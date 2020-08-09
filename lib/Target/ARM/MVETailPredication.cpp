//===- MVETailPredication.cpp - MVE Tail Predication ------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
/// \file
/// Armv8.1m introduced MVE, M-Profile Vector Extension, and low-overhead
/// branches to help accelerate DSP applications. These two extensions,
/// combined with a new form of predication called tail-predication, can be used
/// to provide implicit vector predication within a low-overhead loop.
/// This is implicit because the predicate of active/inactive lanes is
/// calculated by hardware, and thus does not need to be explicitly passed
/// to vector instructions. The instructions responsible for this are the
/// DLSTP and WLSTP instructions, which setup a tail-predicated loop and the
/// the total number of data elements processed by the loop. The loop-end
/// LETP instruction is responsible for decrementing and setting the remaining
/// elements to be processed and generating the mask of active lanes.
///
/// The HardwareLoops pass inserts intrinsics identifying loops that the
/// backend will attempt to convert into a low-overhead loop. The vectorizer is
/// responsible for generating a vectorized loop in which the lanes are
/// predicated upon the iteration counter. This pass looks at these predicated
/// vector loops, that are targets for low-overhead loops, and prepares it for
/// code generation. Once the vectorizer has produced a masked loop, there's a
/// couple of final forms:
/// - A tail-predicated loop, with implicit predication.
/// - A loop containing multiple VCPT instructions, predicating multiple VPT
///   blocks of instructions operating on different vector types.
///
/// This pass:
/// 1) Checks if the predicates of the masked load/store instructions are
///    generated by intrinsic @llvm.get.active.lanes(). This intrinsic consumes
///    the Backedge Taken Count (BTC) of the scalar loop as its second argument,
///    which we extract to set up the number of elements processed by the loop.
/// 2) Intrinsic @llvm.get.active.lanes() is then replaced by the MVE target
///    specific VCTP intrinsic to represent the effect of tail predication.
///    This will be picked up by the ARM Low-overhead loop pass, which performs
///    the final transformation to a DLSTP or WLSTP tail-predicated loop.

#include "ARM.h"
#include "ARMSubtarget.h"
#include "ARMTargetTransformInfo.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicsARM.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/InitializePasses.h"
#include "llvm/Support/Debug.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include "llvm/Transforms/Utils/ScalarEvolutionExpander.h"

using namespace llvm;

#define DEBUG_TYPE "mve-tail-predication"
#define DESC "Transform predicated vector loops to use MVE tail predication"

cl::opt<TailPredication::Mode> EnableTailPredication(
   "tail-predication", cl::desc("MVE tail-predication options"),
   cl::init(TailPredication::Disabled),
   cl::values(clEnumValN(TailPredication::Disabled, "disabled",
                         "Don't tail-predicate loops"),
              clEnumValN(TailPredication::EnabledNoReductions,
                         "enabled-no-reductions",
                         "Enable tail-predication, but not for reduction loops"),
              clEnumValN(TailPredication::Enabled,
                         "enabled",
                         "Enable tail-predication, including reduction loops"),
              clEnumValN(TailPredication::ForceEnabledNoReductions,
                         "force-enabled-no-reductions",
                         "Enable tail-predication, but not for reduction loops, "
                         "and force this which might be unsafe"),
              clEnumValN(TailPredication::ForceEnabled,
                         "force-enabled",
                         "Enable tail-predication, including reduction loops, "
                         "and force this which might be unsafe")));


namespace {

class MVETailPredication : public LoopPass {
  SmallVector<IntrinsicInst*, 4> MaskedInsts;
  Loop *L = nullptr;
  ScalarEvolution *SE = nullptr;
  TargetTransformInfo *TTI = nullptr;
  const ARMSubtarget *ST = nullptr;

public:
  static char ID;

  MVETailPredication() : LoopPass(ID) { }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<ScalarEvolutionWrapperPass>();
    AU.addRequired<LoopInfoWrapperPass>();
    AU.addRequired<TargetPassConfig>();
    AU.addRequired<TargetTransformInfoWrapperPass>();
    AU.addPreserved<LoopInfoWrapperPass>();
    AU.setPreservesCFG();
  }

  bool runOnLoop(Loop *L, LPPassManager&) override;

private:
  /// Perform the relevant checks on the loop and convert if possible.
  bool TryConvert(Value *TripCount);

  /// Return whether this is a vectorized loop, that contains masked
  /// load/stores.
  bool IsPredicatedVectorLoop();

  /// Perform checks on the arguments of @llvm.get.active.lane.mask
  /// intrinsic: check if the first is a loop induction variable, and for the
  /// the second check that no overflow can occur in the expression that use
  /// this backedge-taken count.
  bool IsSafeActiveMask(IntrinsicInst *ActiveLaneMask, Value *TripCount,
                        FixedVectorType *VecTy);

  /// Insert the intrinsic to represent the effect of tail predication.
  void InsertVCTPIntrinsic(IntrinsicInst *ActiveLaneMask, Value *TripCount,
                           FixedVectorType *VecTy);

  /// Rematerialize the iteration count in exit blocks, which enables
  /// ARMLowOverheadLoops to better optimise away loop update statements inside
  /// hardware-loops.
  void RematerializeIterCount();
};

} // end namespace

static bool IsDecrement(Instruction &I) {
  auto *Call = dyn_cast<IntrinsicInst>(&I);
  if (!Call)
    return false;

  Intrinsic::ID ID = Call->getIntrinsicID();
  return ID == Intrinsic::loop_decrement_reg;
}

static bool IsMasked(Instruction *I) {
  auto *Call = dyn_cast<IntrinsicInst>(I);
  if (!Call)
    return false;

  Intrinsic::ID ID = Call->getIntrinsicID();
  // TODO: Support gather/scatter expand/compress operations.
  return ID == Intrinsic::masked_store || ID == Intrinsic::masked_load;
}

bool MVETailPredication::runOnLoop(Loop *L, LPPassManager&) {
  if (skipLoop(L) || !EnableTailPredication)
    return false;

  MaskedInsts.clear();
  Function &F = *L->getHeader()->getParent();
  auto &TPC = getAnalysis<TargetPassConfig>();
  auto &TM = TPC.getTM<TargetMachine>();
  ST = &TM.getSubtarget<ARMSubtarget>(F);
  TTI = &getAnalysis<TargetTransformInfoWrapperPass>().getTTI(F);
  SE = &getAnalysis<ScalarEvolutionWrapperPass>().getSE();
  this->L = L;

  // The MVE and LOB extensions are combined to enable tail-predication, but
  // there's nothing preventing us from generating VCTP instructions for v8.1m.
  if (!ST->hasMVEIntegerOps() || !ST->hasV8_1MMainlineOps()) {
    LLVM_DEBUG(dbgs() << "ARM TP: Not a v8.1m.main+mve target.\n");
    return false;
  }

  BasicBlock *Preheader = L->getLoopPreheader();
  if (!Preheader)
    return false;

  auto FindLoopIterations = [](BasicBlock *BB) -> IntrinsicInst* {
    for (auto &I : *BB) {
      auto *Call = dyn_cast<IntrinsicInst>(&I);
      if (!Call)
        continue;

      Intrinsic::ID ID = Call->getIntrinsicID();
      if (ID == Intrinsic::set_loop_iterations ||
          ID == Intrinsic::test_set_loop_iterations)
        return cast<IntrinsicInst>(&I);
    }
    return nullptr;
  };

  // Look for the hardware loop intrinsic that sets the iteration count.
  IntrinsicInst *Setup = FindLoopIterations(Preheader);

  // The test.set iteration could live in the pre-preheader.
  if (!Setup) {
    if (!Preheader->getSinglePredecessor())
      return false;
    Setup = FindLoopIterations(Preheader->getSinglePredecessor());
    if (!Setup)
      return false;
  }

  // Search for the hardware loop intrinic that decrements the loop counter.
  IntrinsicInst *Decrement = nullptr;
  for (auto *BB : L->getBlocks()) {
    for (auto &I : *BB) {
      if (IsDecrement(I)) {
        Decrement = cast<IntrinsicInst>(&I);
        break;
      }
    }
  }

  if (!Decrement)
    return false;

  LLVM_DEBUG(dbgs() << "ARM TP: Running on Loop: " << *L << *Setup << "\n"
             << *Decrement << "\n");

  if (!TryConvert(Setup->getArgOperand(0))) {
    LLVM_DEBUG(dbgs() << "ARM TP: Can't tail-predicate this loop.\n");
    return false;
  }

  return true;
}

static FixedVectorType *getVectorType(IntrinsicInst *I) {
  unsigned TypeOp = I->getIntrinsicID() == Intrinsic::masked_load ? 0 : 1;
  auto *PtrTy = cast<PointerType>(I->getOperand(TypeOp)->getType());
  auto *VecTy = cast<FixedVectorType>(PtrTy->getElementType());
  assert(VecTy && "No scalable vectors expected here");
  return VecTy;
}

bool MVETailPredication::IsPredicatedVectorLoop() {
  // Check that the loop contains at least one masked load/store intrinsic.
  // We only support 'normal' vector instructions - other than masked
  // load/stores.
  bool ActiveLaneMask = false;
  for (auto *BB : L->getBlocks()) {
    for (auto &I : *BB) {
      auto *Int = dyn_cast<IntrinsicInst>(&I);
      if (!Int)
        continue;

      switch (Int->getIntrinsicID()) {
      case Intrinsic::get_active_lane_mask:
        ActiveLaneMask = true;
        continue;
      case Intrinsic::sadd_sat:
      case Intrinsic::uadd_sat:
      case Intrinsic::ssub_sat:
      case Intrinsic::usub_sat:
      case Intrinsic::experimental_vector_reduce_add:
        continue;
      case Intrinsic::fma:
      case Intrinsic::trunc:
      case Intrinsic::rint:
      case Intrinsic::round:
      case Intrinsic::floor:
      case Intrinsic::ceil:
      case Intrinsic::fabs:
        if (ST->hasMVEFloatOps())
          continue;
        break;
      default:
        break;
      }

      if (IsMasked(&I)) {
        auto *VecTy = getVectorType(Int);
        unsigned Lanes = VecTy->getNumElements();
        unsigned ElementWidth = VecTy->getScalarSizeInBits();
        // MVE vectors are 128-bit, but don't support 128 x i1.
        // TODO: Can we support vectors larger than 128-bits?
        unsigned MaxWidth = TTI->getRegisterBitWidth(true);
        if (Lanes * ElementWidth > MaxWidth || Lanes == MaxWidth)
          return false;
        MaskedInsts.push_back(cast<IntrinsicInst>(&I));
        continue;
      }

      for (const Use &U : Int->args()) {
        if (isa<VectorType>(U->getType()))
          return false;
      }
    }
  }

  if (!ActiveLaneMask) {
    LLVM_DEBUG(dbgs() << "ARM TP: No get.active.lane.mask intrinsic found.\n");
    return false;
  }
  return !MaskedInsts.empty();
}

// Look through the exit block to see whether there's a duplicate predicate
// instruction. This can happen when we need to perform a select on values
// from the last and previous iteration. Instead of doing a straight
// replacement of that predicate with the vctp, clone the vctp and place it
// in the block. This means that the VPR doesn't have to be live into the
// exit block which should make it easier to convert this loop into a proper
// tail predicated loop.
static void Cleanup(SetVector<Instruction*> &MaybeDead, Loop *L) {
  BasicBlock *Exit = L->getUniqueExitBlock();
  if (!Exit) {
    LLVM_DEBUG(dbgs() << "ARM TP: can't find loop exit block\n");
    return;
  }

  // Drop references and add operands to check for dead.
  SmallPtrSet<Instruction*, 4> Dead;
  while (!MaybeDead.empty()) {
    auto *I = MaybeDead.front();
    MaybeDead.remove(I);
    if (I->hasNUsesOrMore(1))
      continue;

    for (auto &U : I->operands())
      if (auto *OpI = dyn_cast<Instruction>(U))
        MaybeDead.insert(OpI);

    Dead.insert(I);
  }

  for (auto *I : Dead) {
    LLVM_DEBUG(dbgs() << "ARM TP: removing dead insn: "; I->dump());
    I->eraseFromParent();
  }

  for (auto I : L->blocks())
    DeleteDeadPHIs(I);
}

// The active lane intrinsic has this form:
//
//    @llvm.get.active.lane.mask(IV, BTC)
//
// Here we perform checks that this intrinsic behaves as expected,
// which means:
//
// 1) The element count, which is calculated with BTC + 1, cannot overflow.
// 2) The element count needs to be sufficiently large that the decrement of
//    element counter doesn't overflow, which means that we need to prove:
//        ceil(ElementCount / VectorWidth) >= TripCount
//    by rounding up ElementCount up:
//        ((ElementCount + (VectorWidth - 1)) / VectorWidth
//    and evaluate if expression isKnownNonNegative:
//        (((ElementCount + (VectorWidth - 1)) / VectorWidth) - TripCount
// 3) The IV must be an induction phi with an increment equal to the
//    vector width.
bool MVETailPredication::IsSafeActiveMask(IntrinsicInst *ActiveLaneMask,
    Value *TripCount, FixedVectorType *VecTy) {
  bool ForceTailPredication =
    EnableTailPredication == TailPredication::ForceEnabledNoReductions ||
    EnableTailPredication == TailPredication::ForceEnabled;
  // 1) Test whether entry to the loop is protected by a conditional
  // BTC + 1 < 0. In other words, if the scalar trip count overflows,
  // becomes negative, we shouldn't enter the loop and creating
  // tripcount expression BTC + 1 is not safe. So, check that BTC
  // isn't max. This is evaluated in unsigned, because the semantics
  // of @get.active.lane.mask is a ULE comparison.

  int VectorWidth = VecTy->getNumElements();
  auto *BackedgeTakenCount = ActiveLaneMask->getOperand(1);
  auto *BTC = SE->getSCEV(BackedgeTakenCount);

  if (!llvm::cannotBeMaxInLoop(BTC, L, *SE, false /*Signed*/) &&
      !ForceTailPredication) {
    LLVM_DEBUG(dbgs() << "ARM TP: Overflow possible, BTC can be max: ";
               BTC->dump());
    return false;
  }

  // 2) Prove that the sub expression is non-negative, i.e. it doesn't overflow:
  //
  //      (((ElementCount + (VectorWidth - 1)) / VectorWidth) - TripCount
  //
  // 2.1) First prove overflow can't happen in:
  //
  //      ElementCount + (VectorWidth - 1)
  //
  // Because of a lack of context, it is difficult to get a useful bounds on
  // this expression. But since ElementCount uses the same variables as the
  // TripCount (TC), for which we can find meaningful value ranges, we use that
  // instead and assert that:
  //
  //     upperbound(TC) <= UINT_MAX - VectorWidth
  //
  auto *TC = SE->getSCEV(TripCount);
  unsigned SizeInBits = TripCount->getType()->getScalarSizeInBits();
  auto Diff =  APInt(SizeInBits, ~0) - APInt(SizeInBits, VectorWidth);
  uint64_t MaxMinusVW = Diff.getZExtValue();
  uint64_t UpperboundTC = SE->getSignedRange(TC).getUpper().getZExtValue();

  if (UpperboundTC > MaxMinusVW && !ForceTailPredication) {
    LLVM_DEBUG(dbgs() << "ARM TP: Overflow possible in tripcount rounding:\n";
               dbgs() << "upperbound(TC) <= UINT_MAX - VectorWidth\n";
               dbgs() << UpperboundTC << " <= " << MaxMinusVW << "== false\n";);
    return false;
  }

  // 2.2) Make sure overflow doesn't happen in final expression:
  //  (((ElementCount + (VectorWidth - 1)) / VectorWidth) - TripCount,
  // To do this, compare the full ranges of these subexpressions:
  //
  //     Range(Ceil) <= Range(TC)
  //
  // where Ceil = ElementCount + (VW-1) / VW. If Ceil and TC are runtime
  // values (and not constants), we have to compensate for the lowerbound value
  // range to be off by 1. The reason is that BTC lives in the preheader in
  // this form:
  //
  //     %trip.count.minus = add nsw nuw i32 %N, -1
  //
  // For the loop to be executed, %N has to be >= 1 and as a result the value
  // range of %trip.count.minus has a lower bound of 0. Value %TC has this form:
  //
  //     %5 = add nuw nsw i32 %4, 1
  //     call void @llvm.set.loop.iterations.i32(i32 %5)
  //
  // where %5 is some expression using %N, which needs to have a lower bound of
  // 1. Thus, if the ranges of Ceil and TC are not a single constant but a set,
  // we first add 0 to TC such that we can do the <= comparison on both sets.
  //
  auto *One = SE->getOne(TripCount->getType());
  // ElementCount = BTC + 1
  auto *ElementCount = SE->getAddExpr(BTC, One);
  // Tmp = ElementCount + (VW-1)
  auto *ECPlusVWMinus1 = SE->getAddExpr(ElementCount,
      SE->getSCEV(ConstantInt::get(TripCount->getType(), VectorWidth - 1)));
  // Ceil = ElementCount + (VW-1) / VW
  auto *Ceil = SE->getUDivExpr(ECPlusVWMinus1,
      SE->getSCEV(ConstantInt::get(TripCount->getType(), VectorWidth)));

  ConstantRange RangeCeil = SE->getSignedRange(Ceil) ;
  ConstantRange RangeTC = SE->getSignedRange(TC) ;
  if (!RangeTC.isSingleElement()) {
    auto ZeroRange =
        ConstantRange(APInt(TripCount->getType()->getScalarSizeInBits(), 0));
    RangeTC = RangeTC.unionWith(ZeroRange);
  }
  if (!RangeTC.contains(RangeCeil) && !ForceTailPredication) {
    LLVM_DEBUG(dbgs() << "ARM TP: Overflow possible in sub\n");
    return false;
  }

  // 3) Find out if IV is an induction phi. Note that We can't use Loop
  // helpers here to get the induction variable, because the hardware loop is
  // no longer in loopsimplify form, and also the hwloop intrinsic use a
  // different counter.  Using SCEV, we check that the induction is of the
  // form i = i + 4, where the increment must be equal to the VectorWidth.
  auto *IV = ActiveLaneMask->getOperand(0);
  auto *IVExpr = SE->getSCEV(IV);
  auto *AddExpr = dyn_cast<SCEVAddRecExpr>(IVExpr);
  if (!AddExpr) {
    LLVM_DEBUG(dbgs() << "ARM TP: induction not an add expr: "; IVExpr->dump());
    return false;
  }
  // Check that this AddRec is associated with this loop.
  if (AddExpr->getLoop() != L) {
    LLVM_DEBUG(dbgs() << "ARM TP: phi not part of this loop\n");
    return false;
  }
  auto *Step = dyn_cast<SCEVConstant>(AddExpr->getOperand(1));
  if (!Step) {
    LLVM_DEBUG(dbgs() << "ARM TP: induction step is not a constant: ";
               AddExpr->getOperand(1)->dump());
    return false;
  }
  auto StepValue = Step->getValue()->getSExtValue();
  if (VectorWidth == StepValue)
    return true;

  LLVM_DEBUG(dbgs() << "ARM TP: Step value " << StepValue << " doesn't match "
             "vector width " << VectorWidth << "\n");

  return false;
}

// Materialize NumElements in the preheader block.
static Value *getNumElements(BasicBlock *Preheader, Value *BTC) {
  // First, check the preheader if it not already exist:
  //
  // preheader:
  //    %BTC = add i32 %N, -1
  //    ..
  // vector.body:
  //
  // if %BTC already exists. We don't need to emit %NumElems = %BTC + 1,
  // but instead can just return %N.
  for (auto &I : *Preheader) {
    if (I.getOpcode() != Instruction::Add || &I != BTC)
      continue;
    ConstantInt *MinusOne = nullptr;
    if (!(MinusOne = dyn_cast<ConstantInt>(I.getOperand(1))))
      continue;
    if (MinusOne->getSExtValue() == -1) {
      LLVM_DEBUG(dbgs() << "ARM TP: Found num elems: " << I << "\n");
      return I.getOperand(0);
    }
  }

  // But we do need to materialise BTC if it is not already there,
  // e.g. if it is a constant.
  IRBuilder<> Builder(Preheader->getTerminator());
  Value *NumElements = Builder.CreateAdd(BTC,
        ConstantInt::get(BTC->getType(), 1), "num.elements");
  LLVM_DEBUG(dbgs() << "ARM TP: Created num elems: " << *NumElements << "\n");
  return NumElements;
}

void MVETailPredication::InsertVCTPIntrinsic(IntrinsicInst *ActiveLaneMask,
    Value *TripCount, FixedVectorType *VecTy) {
  IRBuilder<> Builder(L->getLoopPreheader()->getTerminator());
  Module *M = L->getHeader()->getModule();
  Type *Ty = IntegerType::get(M->getContext(), 32);
  unsigned VectorWidth = VecTy->getNumElements();

  // The backedge-taken count in @llvm.get.active.lane.mask, its 2nd operand,
  // is one less than the trip count. So we need to find or create
  // %num.elements = %BTC + 1 in the preheader.
  Value *BTC = ActiveLaneMask->getOperand(1);
  Builder.SetInsertPoint(L->getLoopPreheader()->getTerminator());
  Value *NumElements = getNumElements(L->getLoopPreheader(), BTC);

  // Insert a phi to count the number of elements processed by the loop.
  Builder.SetInsertPoint(L->getHeader()->getFirstNonPHI()  );
  PHINode *Processed = Builder.CreatePHI(Ty, 2);
  Processed->addIncoming(NumElements, L->getLoopPreheader());

  // Replace @llvm.get.active.mask() with the ARM specific VCTP intrinic, and thus
  // represent the effect of tail predication.
  Builder.SetInsertPoint(ActiveLaneMask);
  ConstantInt *Factor =
    ConstantInt::get(cast<IntegerType>(Ty), VectorWidth);

  Intrinsic::ID VCTPID;
  switch (VectorWidth) {
  default:
    llvm_unreachable("unexpected number of lanes");
  case 4:  VCTPID = Intrinsic::arm_mve_vctp32; break;
  case 8:  VCTPID = Intrinsic::arm_mve_vctp16; break;
  case 16: VCTPID = Intrinsic::arm_mve_vctp8; break;

    // FIXME: vctp64 currently not supported because the predicate
    // vector wants to be <2 x i1>, but v2i1 is not a legal MVE
    // type, so problems happen at isel time.
    // Intrinsic::arm_mve_vctp64 exists for ACLE intrinsics
    // purposes, but takes a v4i1 instead of a v2i1.
  }
  Function *VCTP = Intrinsic::getDeclaration(M, VCTPID);
  Value *VCTPCall = Builder.CreateCall(VCTP, Processed);
  ActiveLaneMask->replaceAllUsesWith(VCTPCall);

  // Add the incoming value to the new phi.
  // TODO: This add likely already exists in the loop.
  Value *Remaining = Builder.CreateSub(Processed, Factor);
  Processed->addIncoming(Remaining, L->getLoopLatch());
  LLVM_DEBUG(dbgs() << "ARM TP: Insert processed elements phi: "
             << *Processed << "\n"
             << "ARM TP: Inserted VCTP: " << *VCTPCall << "\n");
}

bool MVETailPredication::TryConvert(Value *TripCount) {
  if (!IsPredicatedVectorLoop()) {
    LLVM_DEBUG(dbgs() << "ARM TP: no masked instructions in loop.\n");
    return false;
  }

  LLVM_DEBUG(dbgs() << "ARM TP: Found predicated vector loop.\n");
  SetVector<Instruction*> Predicates;

  // Walk through the masked intrinsics and try to find whether the predicate
  // operand is generated by intrinsic @llvm.get.active.lane.mask().
  for (auto *I : MaskedInsts) {
    unsigned PredOp = I->getIntrinsicID() == Intrinsic::masked_load ? 2 : 3;
    auto *Predicate = dyn_cast<Instruction>(I->getArgOperand(PredOp));
    if (!Predicate || Predicates.count(Predicate))
      continue;

    auto *ActiveLaneMask = dyn_cast<IntrinsicInst>(Predicate);
    if (!ActiveLaneMask ||
        ActiveLaneMask->getIntrinsicID() != Intrinsic::get_active_lane_mask)
      continue;

    Predicates.insert(Predicate);
    LLVM_DEBUG(dbgs() << "ARM TP: Found active lane mask: "
                      << *ActiveLaneMask << "\n");

    auto *VecTy = getVectorType(I);
    if (!IsSafeActiveMask(ActiveLaneMask, TripCount, VecTy)) {
      LLVM_DEBUG(dbgs() << "ARM TP: Not safe to insert VCTP.\n");
      return false;
    }
    LLVM_DEBUG(dbgs() << "ARM TP: Safe to insert VCTP.\n");
    InsertVCTPIntrinsic(ActiveLaneMask, TripCount, VecTy);
  }

  Cleanup(Predicates, L);
  return true;
}

Pass *llvm::createMVETailPredicationPass() {
  return new MVETailPredication();
}

char MVETailPredication::ID = 0;

INITIALIZE_PASS_BEGIN(MVETailPredication, DEBUG_TYPE, DESC, false, false)
INITIALIZE_PASS_END(MVETailPredication, DEBUG_TYPE, DESC, false, false)
