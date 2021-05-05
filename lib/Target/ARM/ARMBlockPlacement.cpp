//===-- ARMBlockPlacement.cpp - ARM block placement pass ------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This pass re-arranges machine basic blocks to suit target requirements.
// Currently it only moves blocks to fix backwards WLS branches.
//
//===----------------------------------------------------------------------===//

#include "ARM.h"
#include "ARMBaseInstrInfo.h"
#include "ARMBasicBlockInfo.h"
#include "ARMSubtarget.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineLoopInfo.h"

using namespace llvm;

#define DEBUG_TYPE "arm-block-placement"
#define DEBUG_PREFIX "ARM Block Placement: "

namespace llvm {
class ARMBlockPlacement : public MachineFunctionPass {
private:
  const ARMBaseInstrInfo *TII;
  std::unique_ptr<ARMBasicBlockUtils> BBUtils = nullptr;
  MachineLoopInfo *MLI = nullptr;

public:
  static char ID;
  ARMBlockPlacement() : MachineFunctionPass(ID) {}

  bool runOnMachineFunction(MachineFunction &MF) override;
  void moveBasicBlock(MachineBasicBlock *BB, MachineBasicBlock *Before);
  bool blockIsBefore(MachineBasicBlock *BB, MachineBasicBlock *Other);
  bool fixBackwardsWLS(MachineLoop *ML);
  bool processPostOrderLoops(MachineLoop *ML);

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesCFG();
    AU.addRequired<MachineLoopInfo>();
    MachineFunctionPass::getAnalysisUsage(AU);
  }
};

} // namespace llvm

FunctionPass *llvm::createARMBlockPlacementPass() {
  return new ARMBlockPlacement();
}

char ARMBlockPlacement::ID = 0;

INITIALIZE_PASS(ARMBlockPlacement, DEBUG_TYPE, "ARM block placement", false,
                false)

static MachineInstr *findWLSInBlock(MachineBasicBlock *MBB) {
  for (auto &Terminator : MBB->terminators()) {
    if (Terminator.getOpcode() == ARM::t2WhileLoopStartLR)
      return &Terminator;
  }
  return nullptr;
}

/// Find t2WhileLoopStartLR in the loop predecessor BB or otherwise in its only
/// predecessor. If found, returns (BB, WLS Instr) pair, otherwise a null pair.
static MachineInstr *findWLS(MachineLoop *ML) {
  MachineBasicBlock *Predecessor = ML->getLoopPredecessor();
  if (!Predecessor)
    return nullptr;
  MachineInstr *WlsInstr = findWLSInBlock(Predecessor);
  if (WlsInstr)
    return WlsInstr;
  if (Predecessor->pred_size() == 1)
    return findWLSInBlock(*Predecessor->pred_begin());
  return nullptr;
}

/// Checks if loop has a backwards branching WLS, and if possible, fixes it.
/// This requires checking the predecessor (ie. preheader or it's predecessor)
/// for a WLS and if its loopExit/target is before it.
/// If moving the predecessor won't convert a WLS (to the predecessor) from
/// a forward to a backward branching WLS, then move the predecessor block
/// to before the loopExit/target.
bool ARMBlockPlacement::fixBackwardsWLS(MachineLoop *ML) {
  MachineInstr *WlsInstr = findWLS(ML);
  if (!WlsInstr)
    return false;

  MachineBasicBlock *Predecessor = WlsInstr->getParent();
  MachineBasicBlock *LoopExit = WlsInstr->getOperand(2).getMBB();

  // We don't want to move Preheader to before the function's entry block.
  if (!LoopExit->getPrevNode())
    return false;
  if (blockIsBefore(Predecessor, LoopExit))
    return false;
  LLVM_DEBUG(dbgs() << DEBUG_PREFIX << "Found a backwards WLS from "
                    << Predecessor->getFullName() << " to "
                    << LoopExit->getFullName() << "\n");

  // Make sure no forward branching WLSs to the Predecessor become backwards
  // branching. An example loop structure where the Predecessor can't be moved,
  // since bb2's WLS will become forwards once bb3 is moved before/above bb1.
  //
  // bb1:           - LoopExit
  // bb2:
  //      WLS  bb3
  // bb3:          - Predecessor
  //      WLS bb1
  // bb4:          - Header
  for (auto It = ++LoopExit->getIterator(); It != Predecessor->getIterator();
       ++It) {
    MachineBasicBlock *MBB = &*It;
    for (auto &Terminator : MBB->terminators()) {
      if (Terminator.getOpcode() != ARM::t2WhileLoopStartLR)
        continue;
      MachineBasicBlock *WLSTarget = Terminator.getOperand(2).getMBB();
      // TODO: Analyse the blocks to make a decision if it would be worth
      // moving Preheader even if we'd introduce a backwards WLS
      if (WLSTarget == Predecessor) {
        LLVM_DEBUG(
            dbgs() << DEBUG_PREFIX
                   << "Can't move Predecessor"
                      "block as it would convert a WLS from forward to a "
                      "backwards branching WLS\n");
        return false;
      }
    }
  }

  moveBasicBlock(Predecessor, LoopExit);
  return true;
}

/// Updates ordering (of WLS BB and their loopExits) in inner loops first
/// Returns true if any change was made in any of the loops
bool ARMBlockPlacement::processPostOrderLoops(MachineLoop *ML) {
  bool Changed = false;
  for (auto *InnerML : *ML)
    Changed |= processPostOrderLoops(InnerML);
  return Changed | fixBackwardsWLS(ML);
}

bool ARMBlockPlacement::runOnMachineFunction(MachineFunction &MF) {
  if (skipFunction(MF.getFunction()))
    return false;
  const ARMSubtarget &ST = static_cast<const ARMSubtarget &>(MF.getSubtarget());
  if (!ST.hasLOB())
    return false;
  LLVM_DEBUG(dbgs() << DEBUG_PREFIX << "Running on " << MF.getName() << "\n");
  MLI = &getAnalysis<MachineLoopInfo>();
  TII = static_cast<const ARMBaseInstrInfo *>(ST.getInstrInfo());
  BBUtils = std::unique_ptr<ARMBasicBlockUtils>(new ARMBasicBlockUtils(MF));
  MF.RenumberBlocks();
  BBUtils->computeAllBlockSizes();
  BBUtils->adjustBBOffsetsAfter(&MF.front());
  bool Changed = false;

  // Find loops with a backwards branching WLS and fix if possible.
  for (auto *ML : *MLI)
    Changed |= processPostOrderLoops(ML);

  return Changed;
}

bool ARMBlockPlacement::blockIsBefore(MachineBasicBlock *BB,
                                      MachineBasicBlock *Other) {
  return BBUtils->getOffsetOf(Other) > BBUtils->getOffsetOf(BB);
}

// Moves a BasicBlock before another, without changing the control flow
void ARMBlockPlacement::moveBasicBlock(MachineBasicBlock *BB,
                                       MachineBasicBlock *Before) {
  LLVM_DEBUG(dbgs() << DEBUG_PREFIX << "Moving " << BB->getName() << " before "
                    << Before->getName() << "\n");
  MachineBasicBlock *BBPrevious = BB->getPrevNode();
  assert(BBPrevious && "Cannot move the function entry basic block");
  MachineBasicBlock *BBNext = BB->getNextNode();

  MachineBasicBlock *BeforePrev = Before->getPrevNode();
  assert(BeforePrev &&
         "Cannot move the given block to before the function entry block");
  MachineFunction *F = BB->getParent();
  BB->moveBefore(Before);

  // Since only the blocks are to be moved around (but the control flow must
  // not change), if there were any fall-throughs (to/from adjacent blocks),
  // replace with unconditional branch to the fall through block.
  auto FixFallthrough = [&](MachineBasicBlock *From, MachineBasicBlock *To) {
    LLVM_DEBUG(dbgs() << DEBUG_PREFIX << "Checking for fallthrough from "
                      << From->getName() << " to " << To->getName() << "\n");
    assert(From->isSuccessor(To) &&
           "'To' is expected to be a successor of 'From'");
    MachineInstr &Terminator = *(--From->terminators().end());
    if (!Terminator.isUnconditionalBranch()) {
      // The BB doesn't have an unconditional branch so it relied on
      // fall-through. Fix by adding an unconditional branch to the moved BB.
      MachineInstrBuilder MIB =
          BuildMI(From, Terminator.getDebugLoc(), TII->get(ARM::t2B));
      MIB.addMBB(To);
      MIB.addImm(ARMCC::CondCodes::AL);
      MIB.addReg(ARM::NoRegister);
      LLVM_DEBUG(dbgs() << DEBUG_PREFIX << "Adding unconditional branch from "
                        << From->getName() << " to " << To->getName() << ": "
                        << *MIB.getInstr());
    }
  };

  // Fix fall-through to the moved BB from the one that used to be before it.
  if (BBPrevious->isSuccessor(BB))
    FixFallthrough(BBPrevious, BB);
  // Fix fall through from the destination BB to the one that used to before it.
  if (BeforePrev->isSuccessor(Before))
    FixFallthrough(BeforePrev, Before);
  // Fix fall through from the moved BB to the one that used to follow.
  if (BBNext && BB->isSuccessor(BBNext))
    FixFallthrough(BB, BBNext);

  F->RenumberBlocks();
  BBUtils->computeAllBlockSizes();
  BBUtils->adjustBBOffsetsAfter(&F->front());
}
