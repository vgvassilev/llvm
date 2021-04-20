//===- RegAllocGreedy.cpp - greedy register allocator ---------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the RAGreedy function pass for register allocation in
// optimized builds.
//
//===----------------------------------------------------------------------===//

#include "AllocationOrder.h"
#include "InterferenceCache.h"
#include "LiveDebugVariables.h"
#include "RegAllocBase.h"
#include "SpillPlacement.h"
#include "SplitKit.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/IndexedMap.h"
#include "llvm/ADT/MapVector.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/OptimizationRemarkEmitter.h"
#include "llvm/CodeGen/CalcSpillWeights.h"
#include "llvm/CodeGen/EdgeBundles.h"
#include "llvm/CodeGen/LiveInterval.h"
#include "llvm/CodeGen/LiveIntervalUnion.h"
#include "llvm/CodeGen/LiveIntervals.h"
#include "llvm/CodeGen/LiveRangeEdit.h"
#include "llvm/CodeGen/LiveRegMatrix.h"
#include "llvm/CodeGen/LiveStacks.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineBlockFrequencyInfo.h"
#include "llvm/CodeGen/MachineDominators.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineLoopInfo.h"
#include "llvm/CodeGen/MachineOperand.h"
#include "llvm/CodeGen/MachineOptimizationRemarkEmitter.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/RegAllocRegistry.h"
#include "llvm/CodeGen/RegisterClassInfo.h"
#include "llvm/CodeGen/SlotIndexes.h"
#include "llvm/CodeGen/Spiller.h"
#include "llvm/CodeGen/TargetInstrInfo.h"
#include "llvm/CodeGen/TargetRegisterInfo.h"
#include "llvm/CodeGen/TargetSubtargetInfo.h"
#include "llvm/CodeGen/VirtRegMap.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/Pass.h"
#include "llvm/Support/BlockFrequency.h"
#include "llvm/Support/BranchProbability.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/MathExtras.h"
#include "llvm/Support/Timer.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include <algorithm>
#include <cassert>
#include <cstdint>
#include <memory>
#include <queue>
#include <tuple>
#include <utility>

using namespace llvm;

#define DEBUG_TYPE "regalloc"

STATISTIC(NumGlobalSplits, "Number of split global live ranges");
STATISTIC(NumLocalSplits,  "Number of split local live ranges");
STATISTIC(NumEvicted,      "Number of interferences evicted");

static cl::opt<SplitEditor::ComplementSpillMode> SplitSpillMode(
    "split-spill-mode", cl::Hidden,
    cl::desc("Spill mode for splitting live ranges"),
    cl::values(clEnumValN(SplitEditor::SM_Partition, "default", "Default"),
               clEnumValN(SplitEditor::SM_Size, "size", "Optimize for size"),
               clEnumValN(SplitEditor::SM_Speed, "speed", "Optimize for speed")),
    cl::init(SplitEditor::SM_Speed));

static cl::opt<unsigned>
LastChanceRecoloringMaxDepth("lcr-max-depth", cl::Hidden,
                             cl::desc("Last chance recoloring max depth"),
                             cl::init(5));

static cl::opt<unsigned> LastChanceRecoloringMaxInterference(
    "lcr-max-interf", cl::Hidden,
    cl::desc("Last chance recoloring maximum number of considered"
             " interference at a time"),
    cl::init(8));

static cl::opt<bool> ExhaustiveSearch(
    "exhaustive-register-search", cl::NotHidden,
    cl::desc("Exhaustive Search for registers bypassing the depth "
             "and interference cutoffs of last chance recoloring"),
    cl::Hidden);

static cl::opt<bool> EnableLocalReassignment(
    "enable-local-reassign", cl::Hidden,
    cl::desc("Local reassignment can yield better allocation decisions, but "
             "may be compile time intensive"),
    cl::init(false));

static cl::opt<bool> EnableDeferredSpilling(
    "enable-deferred-spilling", cl::Hidden,
    cl::desc("Instead of spilling a variable right away, defer the actual "
             "code insertion to the end of the allocation. That way the "
             "allocator might still find a suitable coloring for this "
             "variable because of other evicted variables."),
    cl::init(false));

// FIXME: Find a good default for this flag and remove the flag.
static cl::opt<unsigned>
CSRFirstTimeCost("regalloc-csr-first-time-cost",
              cl::desc("Cost for first time use of callee-saved register."),
              cl::init(0), cl::Hidden);

static cl::opt<bool> ConsiderLocalIntervalCost(
    "consider-local-interval-cost", cl::Hidden,
    cl::desc("Consider the cost of local intervals created by a split "
             "candidate when choosing the best split candidate."),
    cl::init(false));

static RegisterRegAlloc greedyRegAlloc("greedy", "greedy register allocator",
                                       createGreedyRegisterAllocator);

namespace {

class RAGreedy : public MachineFunctionPass,
                 public RegAllocBase,
                 private LiveRangeEdit::Delegate {
  // Convenient shortcuts.
  using PQueue = std::priority_queue<std::pair<unsigned, unsigned>>;
  using SmallLISet = SmallPtrSet<LiveInterval *, 4>;
  using SmallVirtRegSet = SmallSet<Register, 16>;

  // context
  MachineFunction *MF;

  // Shortcuts to some useful interface.
  const TargetInstrInfo *TII;
  const TargetRegisterInfo *TRI;
  RegisterClassInfo RCI;

  // analyses
  SlotIndexes *Indexes;
  MachineBlockFrequencyInfo *MBFI;
  MachineDominatorTree *DomTree;
  MachineLoopInfo *Loops;
  MachineOptimizationRemarkEmitter *ORE;
  EdgeBundles *Bundles;
  SpillPlacement *SpillPlacer;
  LiveDebugVariables *DebugVars;
  AliasAnalysis *AA;

  // state
  std::unique_ptr<Spiller> SpillerInstance;
  PQueue Queue;
  unsigned NextCascade;
  std::unique_ptr<VirtRegAuxInfo> VRAI;

  // Live ranges pass through a number of stages as we try to allocate them.
  // Some of the stages may also create new live ranges:
  //
  // - Region splitting.
  // - Per-block splitting.
  // - Local splitting.
  // - Spilling.
  //
  // Ranges produced by one of the stages skip the previous stages when they are
  // dequeued. This improves performance because we can skip interference checks
  // that are unlikely to give any results. It also guarantees that the live
  // range splitting algorithm terminates, something that is otherwise hard to
  // ensure.
  enum LiveRangeStage {
    /// Newly created live range that has never been queued.
    RS_New,

    /// Only attempt assignment and eviction. Then requeue as RS_Split.
    RS_Assign,

    /// Attempt live range splitting if assignment is impossible.
    RS_Split,

    /// Attempt more aggressive live range splitting that is guaranteed to make
    /// progress.  This is used for split products that may not be making
    /// progress.
    RS_Split2,

    /// Live range will be spilled.  No more splitting will be attempted.
    RS_Spill,


    /// Live range is in memory. Because of other evictions, it might get moved
    /// in a register in the end.
    RS_Memory,

    /// There is nothing more we can do to this live range.  Abort compilation
    /// if it can't be assigned.
    RS_Done
  };

  // Enum CutOffStage to keep a track whether the register allocation failed
  // because of the cutoffs encountered in last chance recoloring.
  // Note: This is used as bitmask. New value should be next power of 2.
  enum CutOffStage {
    // No cutoffs encountered
    CO_None = 0,

    // lcr-max-depth cutoff encountered
    CO_Depth = 1,

    // lcr-max-interf cutoff encountered
    CO_Interf = 2
  };

  uint8_t CutOffInfo;

#ifndef NDEBUG
  static const char *const StageName[];
#endif

  // RegInfo - Keep additional information about each live range.
  struct RegInfo {
    LiveRangeStage Stage = RS_New;

    // Cascade - Eviction loop prevention. See canEvictInterference().
    unsigned Cascade = 0;

    RegInfo() = default;
  };

  IndexedMap<RegInfo, VirtReg2IndexFunctor> ExtraRegInfo;

  LiveRangeStage getStage(const LiveInterval &VirtReg) const {
    return ExtraRegInfo[VirtReg.reg()].Stage;
  }

  void setStage(const LiveInterval &VirtReg, LiveRangeStage Stage) {
    ExtraRegInfo.resize(MRI->getNumVirtRegs());
    ExtraRegInfo[VirtReg.reg()].Stage = Stage;
  }

  template<typename Iterator>
  void setStage(Iterator Begin, Iterator End, LiveRangeStage NewStage) {
    ExtraRegInfo.resize(MRI->getNumVirtRegs());
    for (;Begin != End; ++Begin) {
      Register Reg = *Begin;
      if (ExtraRegInfo[Reg].Stage == RS_New)
        ExtraRegInfo[Reg].Stage = NewStage;
    }
  }

  /// Cost of evicting interference.
  struct EvictionCost {
    unsigned BrokenHints = 0; ///< Total number of broken hints.
    float MaxWeight = 0;      ///< Maximum spill weight evicted.

    EvictionCost() = default;

    bool isMax() const { return BrokenHints == ~0u; }

    void setMax() { BrokenHints = ~0u; }

    void setBrokenHints(unsigned NHints) { BrokenHints = NHints; }

    bool operator<(const EvictionCost &O) const {
      return std::tie(BrokenHints, MaxWeight) <
             std::tie(O.BrokenHints, O.MaxWeight);
    }
  };

  /// EvictionTrack - Keeps track of past evictions in order to optimize region
  /// split decision.
  class EvictionTrack {

  public:
    using EvictorInfo =
        std::pair<Register /* evictor */, MCRegister /* physreg */>;
    using EvicteeInfo = llvm::DenseMap<Register /* evictee */, EvictorInfo>;

  private:
    /// Each Vreg that has been evicted in the last stage of selectOrSplit will
    /// be mapped to the evictor Vreg and the PhysReg it was evicted from.
    EvicteeInfo Evictees;

  public:
    /// Clear all eviction information.
    void clear() { Evictees.clear(); }

    ///  Clear eviction information for the given evictee Vreg.
    /// E.g. when Vreg get's a new allocation, the old eviction info is no
    /// longer relevant.
    /// \param Evictee The evictee Vreg for whom we want to clear collected
    /// eviction info.
    void clearEvicteeInfo(Register Evictee) { Evictees.erase(Evictee); }

    /// Track new eviction.
    /// The Evictor vreg has evicted the Evictee vreg from Physreg.
    /// \param PhysReg The physical register Evictee was evicted from.
    /// \param Evictor The evictor Vreg that evicted Evictee.
    /// \param Evictee The evictee Vreg.
    void addEviction(MCRegister PhysReg, Register Evictor, Register Evictee) {
      Evictees[Evictee].first = Evictor;
      Evictees[Evictee].second = PhysReg;
    }

    /// Return the Evictor Vreg which evicted Evictee Vreg from PhysReg.
    /// \param Evictee The evictee vreg.
    /// \return The Evictor vreg which evicted Evictee vreg from PhysReg. 0 if
    /// nobody has evicted Evictee from PhysReg.
    EvictorInfo getEvictor(Register Evictee) {
      if (Evictees.count(Evictee)) {
        return Evictees[Evictee];
      }

      return EvictorInfo(0, 0);
    }
  };

  // Keeps track of past evictions in order to optimize region split decision.
  EvictionTrack LastEvicted;

  // splitting state.
  std::unique_ptr<SplitAnalysis> SA;
  std::unique_ptr<SplitEditor> SE;

  /// Cached per-block interference maps
  InterferenceCache IntfCache;

  /// All basic blocks where the current register has uses.
  SmallVector<SpillPlacement::BlockConstraint, 8> SplitConstraints;

  /// Global live range splitting candidate info.
  struct GlobalSplitCandidate {
    // Register intended for assignment, or 0.
    MCRegister PhysReg;

    // SplitKit interval index for this candidate.
    unsigned IntvIdx;

    // Interference for PhysReg.
    InterferenceCache::Cursor Intf;

    // Bundles where this candidate should be live.
    BitVector LiveBundles;
    SmallVector<unsigned, 8> ActiveBlocks;

    void reset(InterferenceCache &Cache, MCRegister Reg) {
      PhysReg = Reg;
      IntvIdx = 0;
      Intf.setPhysReg(Cache, Reg);
      LiveBundles.clear();
      ActiveBlocks.clear();
    }

    // Set B[I] = C for every live bundle where B[I] was NoCand.
    unsigned getBundles(SmallVectorImpl<unsigned> &B, unsigned C) {
      unsigned Count = 0;
      for (unsigned I : LiveBundles.set_bits())
        if (B[I] == NoCand) {
          B[I] = C;
          Count++;
        }
      return Count;
    }
  };

  /// Candidate info for each PhysReg in AllocationOrder.
  /// This vector never shrinks, but grows to the size of the largest register
  /// class.
  SmallVector<GlobalSplitCandidate, 32> GlobalCand;

  enum : unsigned { NoCand = ~0u };

  /// Candidate map. Each edge bundle is assigned to a GlobalCand entry, or to
  /// NoCand which indicates the stack interval.
  SmallVector<unsigned, 32> BundleCand;

  /// Callee-save register cost, calculated once per machine function.
  BlockFrequency CSRCost;

  /// Run or not the local reassignment heuristic. This information is
  /// obtained from the TargetSubtargetInfo.
  bool EnableLocalReassign;

  /// Enable or not the consideration of the cost of local intervals created
  /// by a split candidate when choosing the best split candidate.
  bool EnableAdvancedRASplitCost;

  /// Set of broken hints that may be reconciled later because of eviction.
  SmallSetVector<LiveInterval *, 8> SetOfBrokenHints;

  /// The register cost values. This list will be recreated for each Machine
  /// Function
  ArrayRef<uint8_t> RegCosts;

public:
  RAGreedy();

  /// Return the pass name.
  StringRef getPassName() const override { return "Greedy Register Allocator"; }

  /// RAGreedy analysis usage.
  void getAnalysisUsage(AnalysisUsage &AU) const override;
  void releaseMemory() override;
  Spiller &spiller() override { return *SpillerInstance; }
  void enqueue(LiveInterval *LI) override;
  LiveInterval *dequeue() override;
  MCRegister selectOrSplit(LiveInterval &,
                           SmallVectorImpl<Register> &) override;
  void aboutToRemoveInterval(LiveInterval &) override;

  /// Perform register allocation.
  bool runOnMachineFunction(MachineFunction &mf) override;

  MachineFunctionProperties getRequiredProperties() const override {
    return MachineFunctionProperties().set(
        MachineFunctionProperties::Property::NoPHIs);
  }

  MachineFunctionProperties getClearedProperties() const override {
    return MachineFunctionProperties().set(
      MachineFunctionProperties::Property::IsSSA);
  }

  static char ID;

private:
  MCRegister selectOrSplitImpl(LiveInterval &, SmallVectorImpl<Register> &,
                               SmallVirtRegSet &, unsigned = 0);

  bool LRE_CanEraseVirtReg(Register) override;
  void LRE_WillShrinkVirtReg(Register) override;
  void LRE_DidCloneVirtReg(Register, Register) override;
  void enqueue(PQueue &CurQueue, LiveInterval *LI);
  LiveInterval *dequeue(PQueue &CurQueue);

  BlockFrequency calcSpillCost();
  bool addSplitConstraints(InterferenceCache::Cursor, BlockFrequency&);
  bool addThroughConstraints(InterferenceCache::Cursor, ArrayRef<unsigned>);
  bool growRegion(GlobalSplitCandidate &Cand);
  bool splitCanCauseEvictionChain(Register Evictee, GlobalSplitCandidate &Cand,
                                  unsigned BBNumber,
                                  const AllocationOrder &Order);
  bool splitCanCauseLocalSpill(unsigned VirtRegToSplit,
                               GlobalSplitCandidate &Cand, unsigned BBNumber,
                               const AllocationOrder &Order);
  BlockFrequency calcGlobalSplitCost(GlobalSplitCandidate &,
                                     const AllocationOrder &Order,
                                     bool *CanCauseEvictionChain);
  bool calcCompactRegion(GlobalSplitCandidate&);
  void splitAroundRegion(LiveRangeEdit&, ArrayRef<unsigned>);
  void calcGapWeights(MCRegister, SmallVectorImpl<float> &);
  Register canReassign(LiveInterval &VirtReg, Register PrevReg) const;
  bool shouldEvict(LiveInterval &A, bool, LiveInterval &B, bool) const;
  bool canEvictInterference(LiveInterval &, MCRegister, bool, EvictionCost &,
                            const SmallVirtRegSet &) const;
  bool canEvictInterferenceInRange(const LiveInterval &VirtReg,
                                   MCRegister PhysReg, SlotIndex Start,
                                   SlotIndex End, EvictionCost &MaxCost) const;
  MCRegister getCheapestEvicteeWeight(const AllocationOrder &Order,
                                      const LiveInterval &VirtReg,
                                      SlotIndex Start, SlotIndex End,
                                      float *BestEvictWeight) const;
  void evictInterference(LiveInterval &, MCRegister,
                         SmallVectorImpl<Register> &);
  bool mayRecolorAllInterferences(MCRegister PhysReg, LiveInterval &VirtReg,
                                  SmallLISet &RecoloringCandidates,
                                  const SmallVirtRegSet &FixedRegisters);

  MCRegister tryAssign(LiveInterval&, AllocationOrder&,
                     SmallVectorImpl<Register>&,
                     const SmallVirtRegSet&);
  MCRegister tryEvict(LiveInterval &, AllocationOrder &,
                    SmallVectorImpl<Register> &, uint8_t,
                    const SmallVirtRegSet &);
  MCRegister tryRegionSplit(LiveInterval &, AllocationOrder &,
                            SmallVectorImpl<Register> &);
  /// Calculate cost of region splitting.
  unsigned calculateRegionSplitCost(LiveInterval &VirtReg,
                                    AllocationOrder &Order,
                                    BlockFrequency &BestCost,
                                    unsigned &NumCands, bool IgnoreCSR,
                                    bool *CanCauseEvictionChain = nullptr);
  /// Perform region splitting.
  unsigned doRegionSplit(LiveInterval &VirtReg, unsigned BestCand,
                         bool HasCompact,
                         SmallVectorImpl<Register> &NewVRegs);
  /// Check other options before using a callee-saved register for the first
  /// time.
  MCRegister tryAssignCSRFirstTime(LiveInterval &VirtReg,
                                   AllocationOrder &Order, MCRegister PhysReg,
                                   uint8_t &CostPerUseLimit,
                                   SmallVectorImpl<Register> &NewVRegs);
  void initializeCSRCost();
  unsigned tryBlockSplit(LiveInterval&, AllocationOrder&,
                         SmallVectorImpl<Register>&);
  unsigned tryInstructionSplit(LiveInterval&, AllocationOrder&,
                               SmallVectorImpl<Register>&);
  unsigned tryLocalSplit(LiveInterval&, AllocationOrder&,
    SmallVectorImpl<Register>&);
  unsigned trySplit(LiveInterval&, AllocationOrder&,
                    SmallVectorImpl<Register>&,
                    const SmallVirtRegSet&);
  unsigned tryLastChanceRecoloring(LiveInterval &, AllocationOrder &,
                                   SmallVectorImpl<Register> &,
                                   SmallVirtRegSet &, unsigned);
  bool tryRecoloringCandidates(PQueue &, SmallVectorImpl<Register> &,
                               SmallVirtRegSet &, unsigned);
  void tryHintRecoloring(LiveInterval &);
  void tryHintsRecoloring();

  /// Model the information carried by one end of a copy.
  struct HintInfo {
    /// The frequency of the copy.
    BlockFrequency Freq;
    /// The virtual register or physical register.
    Register Reg;
    /// Its currently assigned register.
    /// In case of a physical register Reg == PhysReg.
    MCRegister PhysReg;

    HintInfo(BlockFrequency Freq, Register Reg, MCRegister PhysReg)
        : Freq(Freq), Reg(Reg), PhysReg(PhysReg) {}
  };
  using HintsInfo = SmallVector<HintInfo, 4>;

  BlockFrequency getBrokenHintFreq(const HintsInfo &, MCRegister);
  void collectHintInfo(Register, HintsInfo &);

  bool isUnusedCalleeSavedReg(MCRegister PhysReg) const;

  /// Greedy RA statistic to remark.
  struct RAGreedyStats {
    unsigned Reloads = 0;
    unsigned FoldedReloads = 0;
    unsigned ZeroCostFoldedReloads = 0;
    unsigned Spills = 0;
    unsigned FoldedSpills = 0;
    unsigned Copies = 0;
    float ReloadsCost = 0.0f;
    float FoldedReloadsCost = 0.0f;
    float SpillsCost = 0.0f;
    float FoldedSpillsCost = 0.0f;
    float CopiesCost = 0.0f;

    bool isEmpty() {
      return !(Reloads || FoldedReloads || Spills || FoldedSpills ||
               ZeroCostFoldedReloads || Copies);
    }

    void add(RAGreedyStats other) {
      Reloads += other.Reloads;
      FoldedReloads += other.FoldedReloads;
      ZeroCostFoldedReloads += other.ZeroCostFoldedReloads;
      Spills += other.Spills;
      FoldedSpills += other.FoldedSpills;
      Copies += other.Copies;
      ReloadsCost += other.ReloadsCost;
      FoldedReloadsCost += other.FoldedReloadsCost;
      SpillsCost += other.SpillsCost;
      FoldedSpillsCost += other.FoldedSpillsCost;
      CopiesCost += other.CopiesCost;
    }

    void report(MachineOptimizationRemarkMissed &R);
  };

  /// Compute statistic for a basic block.
  RAGreedyStats computeStats(MachineBasicBlock &MBB);

  /// Compute and report statistic through a remark.
  RAGreedyStats reportStats(MachineLoop *L);

  /// Report the statistic for each loop.
  void reportStats();
};

} // end anonymous namespace

char RAGreedy::ID = 0;
char &llvm::RAGreedyID = RAGreedy::ID;

INITIALIZE_PASS_BEGIN(RAGreedy, "greedy",
                "Greedy Register Allocator", false, false)
INITIALIZE_PASS_DEPENDENCY(LiveDebugVariables)
INITIALIZE_PASS_DEPENDENCY(SlotIndexes)
INITIALIZE_PASS_DEPENDENCY(LiveIntervals)
INITIALIZE_PASS_DEPENDENCY(RegisterCoalescer)
INITIALIZE_PASS_DEPENDENCY(MachineScheduler)
INITIALIZE_PASS_DEPENDENCY(LiveStacks)
INITIALIZE_PASS_DEPENDENCY(MachineDominatorTree)
INITIALIZE_PASS_DEPENDENCY(MachineLoopInfo)
INITIALIZE_PASS_DEPENDENCY(VirtRegMap)
INITIALIZE_PASS_DEPENDENCY(LiveRegMatrix)
INITIALIZE_PASS_DEPENDENCY(EdgeBundles)
INITIALIZE_PASS_DEPENDENCY(SpillPlacement)
INITIALIZE_PASS_DEPENDENCY(MachineOptimizationRemarkEmitterPass)
INITIALIZE_PASS_END(RAGreedy, "greedy",
                "Greedy Register Allocator", false, false)

#ifndef NDEBUG
const char *const RAGreedy::StageName[] = {
    "RS_New",
    "RS_Assign",
    "RS_Split",
    "RS_Split2",
    "RS_Spill",
    "RS_Memory",
    "RS_Done"
};
#endif

// Hysteresis to use when comparing floats.
// This helps stabilize decisions based on float comparisons.
const float Hysteresis = (2007 / 2048.0f); // 0.97998046875

FunctionPass* llvm::createGreedyRegisterAllocator() {
  return new RAGreedy();
}

RAGreedy::RAGreedy(): MachineFunctionPass(ID) {
}

void RAGreedy::getAnalysisUsage(AnalysisUsage &AU) const {
  AU.setPreservesCFG();
  AU.addRequired<MachineBlockFrequencyInfo>();
  AU.addPreserved<MachineBlockFrequencyInfo>();
  AU.addRequired<AAResultsWrapperPass>();
  AU.addPreserved<AAResultsWrapperPass>();
  AU.addRequired<LiveIntervals>();
  AU.addPreserved<LiveIntervals>();
  AU.addRequired<SlotIndexes>();
  AU.addPreserved<SlotIndexes>();
  AU.addRequired<LiveDebugVariables>();
  AU.addPreserved<LiveDebugVariables>();
  AU.addRequired<LiveStacks>();
  AU.addPreserved<LiveStacks>();
  AU.addRequired<MachineDominatorTree>();
  AU.addPreserved<MachineDominatorTree>();
  AU.addRequired<MachineLoopInfo>();
  AU.addPreserved<MachineLoopInfo>();
  AU.addRequired<VirtRegMap>();
  AU.addPreserved<VirtRegMap>();
  AU.addRequired<LiveRegMatrix>();
  AU.addPreserved<LiveRegMatrix>();
  AU.addRequired<EdgeBundles>();
  AU.addRequired<SpillPlacement>();
  AU.addRequired<MachineOptimizationRemarkEmitterPass>();
  MachineFunctionPass::getAnalysisUsage(AU);
}

//===----------------------------------------------------------------------===//
//                     LiveRangeEdit delegate methods
//===----------------------------------------------------------------------===//

bool RAGreedy::LRE_CanEraseVirtReg(Register VirtReg) {
  LiveInterval &LI = LIS->getInterval(VirtReg);
  if (VRM->hasPhys(VirtReg)) {
    Matrix->unassign(LI);
    aboutToRemoveInterval(LI);
    return true;
  }
  // Unassigned virtreg is probably in the priority queue.
  // RegAllocBase will erase it after dequeueing.
  // Nonetheless, clear the live-range so that the debug
  // dump will show the right state for that VirtReg.
  LI.clear();
  return false;
}

void RAGreedy::LRE_WillShrinkVirtReg(Register VirtReg) {
  if (!VRM->hasPhys(VirtReg))
    return;

  // Register is assigned, put it back on the queue for reassignment.
  LiveInterval &LI = LIS->getInterval(VirtReg);
  Matrix->unassign(LI);
  enqueue(&LI);
}

void RAGreedy::LRE_DidCloneVirtReg(Register New, Register Old) {
  // Cloning a register we haven't even heard about yet?  Just ignore it.
  if (!ExtraRegInfo.inBounds(Old))
    return;

  // LRE may clone a virtual register because dead code elimination causes it to
  // be split into connected components. The new components are much smaller
  // than the original, so they should get a new chance at being assigned.
  // same stage as the parent.
  ExtraRegInfo[Old].Stage = RS_Assign;
  ExtraRegInfo.grow(New);
  ExtraRegInfo[New] = ExtraRegInfo[Old];
}

void RAGreedy::releaseMemory() {
  SpillerInstance.reset();
  ExtraRegInfo.clear();
  GlobalCand.clear();
}

void RAGreedy::enqueue(LiveInterval *LI) { enqueue(Queue, LI); }

void RAGreedy::enqueue(PQueue &CurQueue, LiveInterval *LI) {
  // Prioritize live ranges by size, assigning larger ranges first.
  // The queue holds (size, reg) pairs.
  const unsigned Size = LI->getSize();
  const Register Reg = LI->reg();
  assert(Reg.isVirtual() && "Can only enqueue virtual registers");
  unsigned Prio;

  ExtraRegInfo.grow(Reg);
  if (ExtraRegInfo[Reg].Stage == RS_New)
    ExtraRegInfo[Reg].Stage = RS_Assign;

  if (ExtraRegInfo[Reg].Stage == RS_Split) {
    // Unsplit ranges that couldn't be allocated immediately are deferred until
    // everything else has been allocated.
    Prio = Size;
  } else if (ExtraRegInfo[Reg].Stage == RS_Memory) {
    // Memory operand should be considered last.
    // Change the priority such that Memory operand are assigned in
    // the reverse order that they came in.
    // TODO: Make this a member variable and probably do something about hints.
    static unsigned MemOp = 0;
    Prio = MemOp++;
  } else {
    // Giant live ranges fall back to the global assignment heuristic, which
    // prevents excessive spilling in pathological cases.
    bool ReverseLocal = TRI->reverseLocalAssignment();
    const TargetRegisterClass &RC = *MRI->getRegClass(Reg);
    bool ForceGlobal = !ReverseLocal &&
      (Size / SlotIndex::InstrDist) > (2 * RC.getNumRegs());

    if (ExtraRegInfo[Reg].Stage == RS_Assign && !ForceGlobal && !LI->empty() &&
        LIS->intervalIsInOneMBB(*LI)) {
      // Allocate original local ranges in linear instruction order. Since they
      // are singly defined, this produces optimal coloring in the absence of
      // global interference and other constraints.
      if (!ReverseLocal)
        Prio = LI->beginIndex().getInstrDistance(Indexes->getLastIndex());
      else {
        // Allocating bottom up may allow many short LRGs to be assigned first
        // to one of the cheap registers. This could be much faster for very
        // large blocks on targets with many physical registers.
        Prio = Indexes->getZeroIndex().getInstrDistance(LI->endIndex());
      }
      Prio |= RC.AllocationPriority << 24;
    } else {
      // Allocate global and split ranges in long->short order. Long ranges that
      // don't fit should be spilled (or split) ASAP so they don't create
      // interference.  Mark a bit to prioritize global above local ranges.
      Prio = (1u << 29) + Size;
    }
    // Mark a higher bit to prioritize global and local above RS_Split.
    Prio |= (1u << 31);

    // Boost ranges that have a physical register hint.
    if (VRM->hasKnownPreference(Reg))
      Prio |= (1u << 30);
  }
  // The virtual register number is a tie breaker for same-sized ranges.
  // Give lower vreg numbers higher priority to assign them first.
  CurQueue.push(std::make_pair(Prio, ~Reg));
}

LiveInterval *RAGreedy::dequeue() { return dequeue(Queue); }

LiveInterval *RAGreedy::dequeue(PQueue &CurQueue) {
  if (CurQueue.empty())
    return nullptr;
  LiveInterval *LI = &LIS->getInterval(~CurQueue.top().second);
  CurQueue.pop();
  return LI;
}

//===----------------------------------------------------------------------===//
//                            Direct Assignment
//===----------------------------------------------------------------------===//

/// tryAssign - Try to assign VirtReg to an available register.
MCRegister RAGreedy::tryAssign(LiveInterval &VirtReg,
                             AllocationOrder &Order,
                             SmallVectorImpl<Register> &NewVRegs,
                             const SmallVirtRegSet &FixedRegisters) {
  MCRegister PhysReg;
  for (auto I = Order.begin(), E = Order.end(); I != E && !PhysReg; ++I) {
    assert(*I);
    if (!Matrix->checkInterference(VirtReg, *I)) {
      if (I.isHint())
        return *I;
      else
        PhysReg = *I;
    }
  }
  if (!PhysReg.isValid())
    return PhysReg;

  // PhysReg is available, but there may be a better choice.

  // If we missed a simple hint, try to cheaply evict interference from the
  // preferred register.
  if (Register Hint = MRI->getSimpleHint(VirtReg.reg()))
    if (Order.isHint(Hint)) {
      MCRegister PhysHint = Hint.asMCReg();
      LLVM_DEBUG(dbgs() << "missed hint " << printReg(PhysHint, TRI) << '\n');
      EvictionCost MaxCost;
      MaxCost.setBrokenHints(1);
      if (canEvictInterference(VirtReg, PhysHint, true, MaxCost,
                               FixedRegisters)) {
        evictInterference(VirtReg, PhysHint, NewVRegs);
        return PhysHint;
      }
      // Record the missed hint, we may be able to recover
      // at the end if the surrounding allocation changed.
      SetOfBrokenHints.insert(&VirtReg);
    }

  // Try to evict interference from a cheaper alternative.
  uint8_t Cost = RegCosts[PhysReg];

  // Most registers have 0 additional cost.
  if (!Cost)
    return PhysReg;

  LLVM_DEBUG(dbgs() << printReg(PhysReg, TRI) << " is available at cost "
                    << Cost << '\n');
  MCRegister CheapReg = tryEvict(VirtReg, Order, NewVRegs, Cost, FixedRegisters);
  return CheapReg ? CheapReg : PhysReg;
}

//===----------------------------------------------------------------------===//
//                         Interference eviction
//===----------------------------------------------------------------------===//

Register RAGreedy::canReassign(LiveInterval &VirtReg, Register PrevReg) const {
  auto Order =
      AllocationOrder::create(VirtReg.reg(), *VRM, RegClassInfo, Matrix);
  MCRegister PhysReg;
  for (auto I = Order.begin(), E = Order.end(); I != E && !PhysReg; ++I) {
    if ((*I).id() == PrevReg.id())
      continue;

    MCRegUnitIterator Units(*I, TRI);
    for (; Units.isValid(); ++Units) {
      // Instantiate a "subquery", not to be confused with the Queries array.
      LiveIntervalUnion::Query subQ(VirtReg, Matrix->getLiveUnions()[*Units]);
      if (subQ.checkInterference())
        break;
    }
    // If no units have interference, break out with the current PhysReg.
    if (!Units.isValid())
      PhysReg = *I;
  }
  if (PhysReg)
    LLVM_DEBUG(dbgs() << "can reassign: " << VirtReg << " from "
                      << printReg(PrevReg, TRI) << " to "
                      << printReg(PhysReg, TRI) << '\n');
  return PhysReg;
}

/// shouldEvict - determine if A should evict the assigned live range B. The
/// eviction policy defined by this function together with the allocation order
/// defined by enqueue() decides which registers ultimately end up being split
/// and spilled.
///
/// Cascade numbers are used to prevent infinite loops if this function is a
/// cyclic relation.
///
/// @param A          The live range to be assigned.
/// @param IsHint     True when A is about to be assigned to its preferred
///                   register.
/// @param B          The live range to be evicted.
/// @param BreaksHint True when B is already assigned to its preferred register.
bool RAGreedy::shouldEvict(LiveInterval &A, bool IsHint,
                           LiveInterval &B, bool BreaksHint) const {
  bool CanSplit = getStage(B) < RS_Spill;

  // Be fairly aggressive about following hints as long as the evictee can be
  // split.
  if (CanSplit && IsHint && !BreaksHint)
    return true;

  if (A.weight() > B.weight()) {
    LLVM_DEBUG(dbgs() << "should evict: " << B << " w= " << B.weight() << '\n');
    return true;
  }
  return false;
}

/// canEvictInterference - Return true if all interferences between VirtReg and
/// PhysReg can be evicted.
///
/// @param VirtReg Live range that is about to be assigned.
/// @param PhysReg Desired register for assignment.
/// @param IsHint  True when PhysReg is VirtReg's preferred register.
/// @param MaxCost Only look for cheaper candidates and update with new cost
///                when returning true.
/// @returns True when interference can be evicted cheaper than MaxCost.
bool RAGreedy::canEvictInterference(
    LiveInterval &VirtReg, MCRegister PhysReg, bool IsHint,
    EvictionCost &MaxCost, const SmallVirtRegSet &FixedRegisters) const {
  // It is only possible to evict virtual register interference.
  if (Matrix->checkInterference(VirtReg, PhysReg) > LiveRegMatrix::IK_VirtReg)
    return false;

  bool IsLocal = LIS->intervalIsInOneMBB(VirtReg);

  // Find VirtReg's cascade number. This will be unassigned if VirtReg was never
  // involved in an eviction before. If a cascade number was assigned, deny
  // evicting anything with the same or a newer cascade number. This prevents
  // infinite eviction loops.
  //
  // This works out so a register without a cascade number is allowed to evict
  // anything, and it can be evicted by anything.
  unsigned Cascade = ExtraRegInfo[VirtReg.reg()].Cascade;
  if (!Cascade)
    Cascade = NextCascade;

  EvictionCost Cost;
  for (MCRegUnitIterator Units(PhysReg, TRI); Units.isValid(); ++Units) {
    LiveIntervalUnion::Query &Q = Matrix->query(VirtReg, *Units);
    // If there is 10 or more interferences, chances are one is heavier.
    if (Q.collectInterferingVRegs(10) >= 10)
      return false;

    // Check if any interfering live range is heavier than MaxWeight.
    for (LiveInterval *Intf : reverse(Q.interferingVRegs())) {
      assert(Register::isVirtualRegister(Intf->reg()) &&
             "Only expecting virtual register interference from query");

      // Do not allow eviction of a virtual register if we are in the middle
      // of last-chance recoloring and this virtual register is one that we
      // have scavenged a physical register for.
      if (FixedRegisters.count(Intf->reg()))
        return false;

      // Never evict spill products. They cannot split or spill.
      if (getStage(*Intf) == RS_Done)
        return false;
      // Once a live range becomes small enough, it is urgent that we find a
      // register for it. This is indicated by an infinite spill weight. These
      // urgent live ranges get to evict almost anything.
      //
      // Also allow urgent evictions of unspillable ranges from a strictly
      // larger allocation order.
      bool Urgent =
          !VirtReg.isSpillable() &&
          (Intf->isSpillable() ||
           RegClassInfo.getNumAllocatableRegs(MRI->getRegClass(VirtReg.reg())) <
               RegClassInfo.getNumAllocatableRegs(
                   MRI->getRegClass(Intf->reg())));
      // Only evict older cascades or live ranges without a cascade.
      unsigned IntfCascade = ExtraRegInfo[Intf->reg()].Cascade;
      if (Cascade <= IntfCascade) {
        if (!Urgent)
          return false;
        // We permit breaking cascades for urgent evictions. It should be the
        // last resort, though, so make it really expensive.
        Cost.BrokenHints += 10;
      }
      // Would this break a satisfied hint?
      bool BreaksHint = VRM->hasPreferredPhys(Intf->reg());
      // Update eviction cost.
      Cost.BrokenHints += BreaksHint;
      Cost.MaxWeight = std::max(Cost.MaxWeight, Intf->weight());
      // Abort if this would be too expensive.
      if (!(Cost < MaxCost))
        return false;
      if (Urgent)
        continue;
      // Apply the eviction policy for non-urgent evictions.
      if (!shouldEvict(VirtReg, IsHint, *Intf, BreaksHint))
        return false;
      // If !MaxCost.isMax(), then we're just looking for a cheap register.
      // Evicting another local live range in this case could lead to suboptimal
      // coloring.
      if (!MaxCost.isMax() && IsLocal && LIS->intervalIsInOneMBB(*Intf) &&
          (!EnableLocalReassign || !canReassign(*Intf, PhysReg))) {
        return false;
      }
    }
  }
  MaxCost = Cost;
  return true;
}

/// Return true if all interferences between VirtReg and PhysReg between
/// Start and End can be evicted.
///
/// \param VirtReg Live range that is about to be assigned.
/// \param PhysReg Desired register for assignment.
/// \param Start   Start of range to look for interferences.
/// \param End     End of range to look for interferences.
/// \param MaxCost Only look for cheaper candidates and update with new cost
///                when returning true.
/// \return True when interference can be evicted cheaper than MaxCost.
bool RAGreedy::canEvictInterferenceInRange(const LiveInterval &VirtReg,
                                           MCRegister PhysReg, SlotIndex Start,
                                           SlotIndex End,
                                           EvictionCost &MaxCost) const {
  EvictionCost Cost;

  for (MCRegUnitIterator Units(PhysReg, TRI); Units.isValid(); ++Units) {
    LiveIntervalUnion::Query &Q = Matrix->query(VirtReg, *Units);
    Q.collectInterferingVRegs();

    // Check if any interfering live range is heavier than MaxWeight.
    for (const LiveInterval *Intf : reverse(Q.interferingVRegs())) {
      // Check if interference overlast the segment in interest.
      if (!Intf->overlaps(Start, End))
        continue;

      // Cannot evict non virtual reg interference.
      if (!Register::isVirtualRegister(Intf->reg()))
        return false;
      // Never evict spill products. They cannot split or spill.
      if (getStage(*Intf) == RS_Done)
        return false;

      // Would this break a satisfied hint?
      bool BreaksHint = VRM->hasPreferredPhys(Intf->reg());
      // Update eviction cost.
      Cost.BrokenHints += BreaksHint;
      Cost.MaxWeight = std::max(Cost.MaxWeight, Intf->weight());
      // Abort if this would be too expensive.
      if (!(Cost < MaxCost))
        return false;
    }
  }

  if (Cost.MaxWeight == 0)
    return false;

  MaxCost = Cost;
  return true;
}

/// Return the physical register that will be best
/// candidate for eviction by a local split interval that will be created
/// between Start and End.
///
/// \param Order            The allocation order
/// \param VirtReg          Live range that is about to be assigned.
/// \param Start            Start of range to look for interferences
/// \param End              End of range to look for interferences
/// \param BestEvictweight  The eviction cost of that eviction
/// \return The PhysReg which is the best candidate for eviction and the
/// eviction cost in BestEvictweight
MCRegister RAGreedy::getCheapestEvicteeWeight(const AllocationOrder &Order,
                                              const LiveInterval &VirtReg,
                                              SlotIndex Start, SlotIndex End,
                                              float *BestEvictweight) const {
  EvictionCost BestEvictCost;
  BestEvictCost.setMax();
  BestEvictCost.MaxWeight = VirtReg.weight();
  MCRegister BestEvicteePhys;

  // Go over all physical registers and find the best candidate for eviction
  for (MCRegister PhysReg : Order.getOrder()) {

    if (!canEvictInterferenceInRange(VirtReg, PhysReg, Start, End,
                                     BestEvictCost))
      continue;

    // Best so far.
    BestEvicteePhys = PhysReg;
  }
  *BestEvictweight = BestEvictCost.MaxWeight;
  return BestEvicteePhys;
}

/// evictInterference - Evict any interferring registers that prevent VirtReg
/// from being assigned to Physreg. This assumes that canEvictInterference
/// returned true.
void RAGreedy::evictInterference(LiveInterval &VirtReg, MCRegister PhysReg,
                                 SmallVectorImpl<Register> &NewVRegs) {
  // Make sure that VirtReg has a cascade number, and assign that cascade
  // number to every evicted register. These live ranges than then only be
  // evicted by a newer cascade, preventing infinite loops.
  unsigned Cascade = ExtraRegInfo[VirtReg.reg()].Cascade;
  if (!Cascade)
    Cascade = ExtraRegInfo[VirtReg.reg()].Cascade = NextCascade++;

  LLVM_DEBUG(dbgs() << "evicting " << printReg(PhysReg, TRI)
                    << " interference: Cascade " << Cascade << '\n');

  // Collect all interfering virtregs first.
  SmallVector<LiveInterval*, 8> Intfs;
  for (MCRegUnitIterator Units(PhysReg, TRI); Units.isValid(); ++Units) {
    LiveIntervalUnion::Query &Q = Matrix->query(VirtReg, *Units);
    // We usually have the interfering VRegs cached so collectInterferingVRegs()
    // should be fast, we may need to recalculate if when different physregs
    // overlap the same register unit so we had different SubRanges queried
    // against it.
    Q.collectInterferingVRegs();
    ArrayRef<LiveInterval*> IVR = Q.interferingVRegs();
    Intfs.append(IVR.begin(), IVR.end());
  }

  // Evict them second. This will invalidate the queries.
  for (LiveInterval *Intf : Intfs) {
    // The same VirtReg may be present in multiple RegUnits. Skip duplicates.
    if (!VRM->hasPhys(Intf->reg()))
      continue;

    LastEvicted.addEviction(PhysReg, VirtReg.reg(), Intf->reg());

    Matrix->unassign(*Intf);
    assert((ExtraRegInfo[Intf->reg()].Cascade < Cascade ||
            VirtReg.isSpillable() < Intf->isSpillable()) &&
           "Cannot decrease cascade number, illegal eviction");
    ExtraRegInfo[Intf->reg()].Cascade = Cascade;
    ++NumEvicted;
    NewVRegs.push_back(Intf->reg());
  }
}

/// Returns true if the given \p PhysReg is a callee saved register and has not
/// been used for allocation yet.
bool RAGreedy::isUnusedCalleeSavedReg(MCRegister PhysReg) const {
  MCRegister CSR = RegClassInfo.getLastCalleeSavedAlias(PhysReg);
  if (!CSR)
    return false;

  return !Matrix->isPhysRegUsed(PhysReg);
}

/// tryEvict - Try to evict all interferences for a physreg.
/// @param  VirtReg Currently unassigned virtual register.
/// @param  Order   Physregs to try.
/// @return         Physreg to assign VirtReg, or 0.
MCRegister RAGreedy::tryEvict(LiveInterval &VirtReg, AllocationOrder &Order,
                            SmallVectorImpl<Register> &NewVRegs,
                            uint8_t CostPerUseLimit,
                            const SmallVirtRegSet &FixedRegisters) {
  NamedRegionTimer T("evict", "Evict", TimerGroupName, TimerGroupDescription,
                     TimePassesIsEnabled);

  // Keep track of the cheapest interference seen so far.
  EvictionCost BestCost;
  BestCost.setMax();
  MCRegister BestPhys;
  unsigned OrderLimit = Order.getOrder().size();

  // When we are just looking for a reduced cost per use, don't break any
  // hints, and only evict smaller spill weights.
  if (CostPerUseLimit < uint8_t(~0u)) {
    BestCost.BrokenHints = 0;
    BestCost.MaxWeight = VirtReg.weight();

    // Check of any registers in RC are below CostPerUseLimit.
    const TargetRegisterClass *RC = MRI->getRegClass(VirtReg.reg());
    uint8_t MinCost = RegClassInfo.getMinCost(RC);
    if (MinCost >= CostPerUseLimit) {
      LLVM_DEBUG(dbgs() << TRI->getRegClassName(RC) << " minimum cost = "
                        << MinCost << ", no cheaper registers to be found.\n");
      return 0;
    }

    // It is normal for register classes to have a long tail of registers with
    // the same cost. We don't need to look at them if they're too expensive.
    if (RegCosts[Order.getOrder().back()] >= CostPerUseLimit) {
      OrderLimit = RegClassInfo.getLastCostChange(RC);
      LLVM_DEBUG(dbgs() << "Only trying the first " << OrderLimit
                        << " regs.\n");
    }
  }

  for (auto I = Order.begin(), E = Order.getOrderLimitEnd(OrderLimit); I != E;
       ++I) {
    MCRegister PhysReg = *I;
    assert(PhysReg);
    if (RegCosts[PhysReg] >= CostPerUseLimit)
      continue;
    // The first use of a callee-saved register in a function has cost 1.
    // Don't start using a CSR when the CostPerUseLimit is low.
    if (CostPerUseLimit == 1 && isUnusedCalleeSavedReg(PhysReg)) {
      LLVM_DEBUG(
          dbgs() << printReg(PhysReg, TRI) << " would clobber CSR "
                 << printReg(RegClassInfo.getLastCalleeSavedAlias(PhysReg), TRI)
                 << '\n');
      continue;
    }

    if (!canEvictInterference(VirtReg, PhysReg, false, BestCost,
                              FixedRegisters))
      continue;

    // Best so far.
    BestPhys = PhysReg;

    // Stop if the hint can be used.
    if (I.isHint())
      break;
  }

  if (BestPhys.isValid())
    evictInterference(VirtReg, BestPhys, NewVRegs);
  return BestPhys;
}

//===----------------------------------------------------------------------===//
//                              Region Splitting
//===----------------------------------------------------------------------===//

/// addSplitConstraints - Fill out the SplitConstraints vector based on the
/// interference pattern in Physreg and its aliases. Add the constraints to
/// SpillPlacement and return the static cost of this split in Cost, assuming
/// that all preferences in SplitConstraints are met.
/// Return false if there are no bundles with positive bias.
bool RAGreedy::addSplitConstraints(InterferenceCache::Cursor Intf,
                                   BlockFrequency &Cost) {
  ArrayRef<SplitAnalysis::BlockInfo> UseBlocks = SA->getUseBlocks();

  // Reset interference dependent info.
  SplitConstraints.resize(UseBlocks.size());
  BlockFrequency StaticCost = 0;
  for (unsigned I = 0; I != UseBlocks.size(); ++I) {
    const SplitAnalysis::BlockInfo &BI = UseBlocks[I];
    SpillPlacement::BlockConstraint &BC = SplitConstraints[I];

    BC.Number = BI.MBB->getNumber();
    Intf.moveToBlock(BC.Number);
    BC.Entry = BI.LiveIn ? SpillPlacement::PrefReg : SpillPlacement::DontCare;
    BC.Exit = (BI.LiveOut &&
               !LIS->getInstructionFromIndex(BI.LastInstr)->isImplicitDef())
                  ? SpillPlacement::PrefReg
                  : SpillPlacement::DontCare;
    BC.ChangesValue = BI.FirstDef.isValid();

    if (!Intf.hasInterference())
      continue;

    // Number of spill code instructions to insert.
    unsigned Ins = 0;

    // Interference for the live-in value.
    if (BI.LiveIn) {
      if (Intf.first() <= Indexes->getMBBStartIdx(BC.Number)) {
        BC.Entry = SpillPlacement::MustSpill;
        ++Ins;
      } else if (Intf.first() < BI.FirstInstr) {
        BC.Entry = SpillPlacement::PrefSpill;
        ++Ins;
      } else if (Intf.first() < BI.LastInstr) {
        ++Ins;
      }

      // Abort if the spill cannot be inserted at the MBB' start
      if (((BC.Entry == SpillPlacement::MustSpill) ||
           (BC.Entry == SpillPlacement::PrefSpill)) &&
          SlotIndex::isEarlierInstr(BI.FirstInstr,
                                    SA->getFirstSplitPoint(BC.Number)))
        return false;
    }

    // Interference for the live-out value.
    if (BI.LiveOut) {
      if (Intf.last() >= SA->getLastSplitPoint(BC.Number)) {
        BC.Exit = SpillPlacement::MustSpill;
        ++Ins;
      } else if (Intf.last() > BI.LastInstr) {
        BC.Exit = SpillPlacement::PrefSpill;
        ++Ins;
      } else if (Intf.last() > BI.FirstInstr) {
        ++Ins;
      }
    }

    // Accumulate the total frequency of inserted spill code.
    while (Ins--)
      StaticCost += SpillPlacer->getBlockFrequency(BC.Number);
  }
  Cost = StaticCost;

  // Add constraints for use-blocks. Note that these are the only constraints
  // that may add a positive bias, it is downhill from here.
  SpillPlacer->addConstraints(SplitConstraints);
  return SpillPlacer->scanActiveBundles();
}

/// addThroughConstraints - Add constraints and links to SpillPlacer from the
/// live-through blocks in Blocks.
bool RAGreedy::addThroughConstraints(InterferenceCache::Cursor Intf,
                                     ArrayRef<unsigned> Blocks) {
  const unsigned GroupSize = 8;
  SpillPlacement::BlockConstraint BCS[GroupSize];
  unsigned TBS[GroupSize];
  unsigned B = 0, T = 0;

  for (unsigned Number : Blocks) {
    Intf.moveToBlock(Number);

    if (!Intf.hasInterference()) {
      assert(T < GroupSize && "Array overflow");
      TBS[T] = Number;
      if (++T == GroupSize) {
        SpillPlacer->addLinks(makeArrayRef(TBS, T));
        T = 0;
      }
      continue;
    }

    assert(B < GroupSize && "Array overflow");
    BCS[B].Number = Number;

    // Abort if the spill cannot be inserted at the MBB' start
    MachineBasicBlock *MBB = MF->getBlockNumbered(Number);
    if (!MBB->empty() &&
        SlotIndex::isEarlierInstr(
            LIS->getInstructionIndex(*MBB->getFirstNonDebugInstr()),
            SA->getFirstSplitPoint(Number)))
      return false;
    // Interference for the live-in value.
    if (Intf.first() <= Indexes->getMBBStartIdx(Number))
      BCS[B].Entry = SpillPlacement::MustSpill;
    else
      BCS[B].Entry = SpillPlacement::PrefSpill;

    // Interference for the live-out value.
    if (Intf.last() >= SA->getLastSplitPoint(Number))
      BCS[B].Exit = SpillPlacement::MustSpill;
    else
      BCS[B].Exit = SpillPlacement::PrefSpill;

    if (++B == GroupSize) {
      SpillPlacer->addConstraints(makeArrayRef(BCS, B));
      B = 0;
    }
  }

  SpillPlacer->addConstraints(makeArrayRef(BCS, B));
  SpillPlacer->addLinks(makeArrayRef(TBS, T));
  return true;
}

bool RAGreedy::growRegion(GlobalSplitCandidate &Cand) {
  // Keep track of through blocks that have not been added to SpillPlacer.
  BitVector Todo = SA->getThroughBlocks();
  SmallVectorImpl<unsigned> &ActiveBlocks = Cand.ActiveBlocks;
  unsigned AddedTo = 0;
#ifndef NDEBUG
  unsigned Visited = 0;
#endif

  while (true) {
    ArrayRef<unsigned> NewBundles = SpillPlacer->getRecentPositive();
    // Find new through blocks in the periphery of PrefRegBundles.
    for (unsigned Bundle : NewBundles) {
      // Look at all blocks connected to Bundle in the full graph.
      ArrayRef<unsigned> Blocks = Bundles->getBlocks(Bundle);
      for (unsigned Block : Blocks) {
        if (!Todo.test(Block))
          continue;
        Todo.reset(Block);
        // This is a new through block. Add it to SpillPlacer later.
        ActiveBlocks.push_back(Block);
#ifndef NDEBUG
        ++Visited;
#endif
      }
    }
    // Any new blocks to add?
    if (ActiveBlocks.size() == AddedTo)
      break;

    // Compute through constraints from the interference, or assume that all
    // through blocks prefer spilling when forming compact regions.
    auto NewBlocks = makeArrayRef(ActiveBlocks).slice(AddedTo);
    if (Cand.PhysReg) {
      if (!addThroughConstraints(Cand.Intf, NewBlocks))
        return false;
    } else
      // Provide a strong negative bias on through blocks to prevent unwanted
      // liveness on loop backedges.
      SpillPlacer->addPrefSpill(NewBlocks, /* Strong= */ true);
    AddedTo = ActiveBlocks.size();

    // Perhaps iterating can enable more bundles?
    SpillPlacer->iterate();
  }
  LLVM_DEBUG(dbgs() << ", v=" << Visited);
  return true;
}

/// calcCompactRegion - Compute the set of edge bundles that should be live
/// when splitting the current live range into compact regions.  Compact
/// regions can be computed without looking at interference.  They are the
/// regions formed by removing all the live-through blocks from the live range.
///
/// Returns false if the current live range is already compact, or if the
/// compact regions would form single block regions anyway.
bool RAGreedy::calcCompactRegion(GlobalSplitCandidate &Cand) {
  // Without any through blocks, the live range is already compact.
  if (!SA->getNumThroughBlocks())
    return false;

  // Compact regions don't correspond to any physreg.
  Cand.reset(IntfCache, MCRegister::NoRegister);

  LLVM_DEBUG(dbgs() << "Compact region bundles");

  // Use the spill placer to determine the live bundles. GrowRegion pretends
  // that all the through blocks have interference when PhysReg is unset.
  SpillPlacer->prepare(Cand.LiveBundles);

  // The static split cost will be zero since Cand.Intf reports no interference.
  BlockFrequency Cost;
  if (!addSplitConstraints(Cand.Intf, Cost)) {
    LLVM_DEBUG(dbgs() << ", none.\n");
    return false;
  }

  if (!growRegion(Cand)) {
    LLVM_DEBUG(dbgs() << ", cannot spill all interferences.\n");
    return false;
  }

  SpillPlacer->finish();

  if (!Cand.LiveBundles.any()) {
    LLVM_DEBUG(dbgs() << ", none.\n");
    return false;
  }

  LLVM_DEBUG({
    for (int I : Cand.LiveBundles.set_bits())
      dbgs() << " EB#" << I;
    dbgs() << ".\n";
  });
  return true;
}

/// calcSpillCost - Compute how expensive it would be to split the live range in
/// SA around all use blocks instead of forming bundle regions.
BlockFrequency RAGreedy::calcSpillCost() {
  BlockFrequency Cost = 0;
  ArrayRef<SplitAnalysis::BlockInfo> UseBlocks = SA->getUseBlocks();
  for (const SplitAnalysis::BlockInfo &BI : UseBlocks) {
    unsigned Number = BI.MBB->getNumber();
    // We normally only need one spill instruction - a load or a store.
    Cost += SpillPlacer->getBlockFrequency(Number);

    // Unless the value is redefined in the block.
    if (BI.LiveIn && BI.LiveOut && BI.FirstDef)
      Cost += SpillPlacer->getBlockFrequency(Number);
  }
  return Cost;
}

/// Check if splitting Evictee will create a local split interval in
/// basic block number BBNumber that may cause a bad eviction chain. This is
/// intended to prevent bad eviction sequences like:
/// movl	%ebp, 8(%esp)           # 4-byte Spill
/// movl	%ecx, %ebp
/// movl	%ebx, %ecx
/// movl	%edi, %ebx
/// movl	%edx, %edi
/// cltd
/// idivl	%esi
/// movl	%edi, %edx
/// movl	%ebx, %edi
/// movl	%ecx, %ebx
/// movl	%ebp, %ecx
/// movl	16(%esp), %ebp          # 4 - byte Reload
///
/// Such sequences are created in 2 scenarios:
///
/// Scenario #1:
/// %0 is evicted from physreg0 by %1.
/// Evictee %0 is intended for region splitting with split candidate
/// physreg0 (the reg %0 was evicted from).
/// Region splitting creates a local interval because of interference with the
/// evictor %1 (normally region splitting creates 2 interval, the "by reg"
/// and "by stack" intervals and local interval created when interference
/// occurs).
/// One of the split intervals ends up evicting %2 from physreg1.
/// Evictee %2 is intended for region splitting with split candidate
/// physreg1.
/// One of the split intervals ends up evicting %3 from physreg2, etc.
///
/// Scenario #2
/// %0 is evicted from physreg0 by %1.
/// %2 is evicted from physreg2 by %3 etc.
/// Evictee %0 is intended for region splitting with split candidate
/// physreg1.
/// Region splitting creates a local interval because of interference with the
/// evictor %1.
/// One of the split intervals ends up evicting back original evictor %1
/// from physreg0 (the reg %0 was evicted from).
/// Another evictee %2 is intended for region splitting with split candidate
/// physreg1.
/// One of the split intervals ends up evicting %3 from physreg2, etc.
///
/// \param Evictee  The register considered to be split.
/// \param Cand     The split candidate that determines the physical register
///                 we are splitting for and the interferences.
/// \param BBNumber The number of a BB for which the region split process will
///                 create a local split interval.
/// \param Order    The physical registers that may get evicted by a split
///                 artifact of Evictee.
/// \return True if splitting Evictee may cause a bad eviction chain, false
/// otherwise.
bool RAGreedy::splitCanCauseEvictionChain(Register Evictee,
                                          GlobalSplitCandidate &Cand,
                                          unsigned BBNumber,
                                          const AllocationOrder &Order) {
  EvictionTrack::EvictorInfo VregEvictorInfo = LastEvicted.getEvictor(Evictee);
  unsigned Evictor = VregEvictorInfo.first;
  MCRegister PhysReg = VregEvictorInfo.second;

  // No actual evictor.
  if (!Evictor || !PhysReg)
    return false;

  float MaxWeight = 0;
  MCRegister FutureEvictedPhysReg =
      getCheapestEvicteeWeight(Order, LIS->getInterval(Evictee),
                               Cand.Intf.first(), Cand.Intf.last(), &MaxWeight);

  // The bad eviction chain occurs when either the split candidate is the
  // evicting reg or one of the split artifact will evict the evicting reg.
  if ((PhysReg != Cand.PhysReg) && (PhysReg != FutureEvictedPhysReg))
    return false;

  Cand.Intf.moveToBlock(BBNumber);

  // Check to see if the Evictor contains interference (with Evictee) in the
  // given BB. If so, this interference caused the eviction of Evictee from
  // PhysReg. This suggest that we will create a local interval during the
  // region split to avoid this interference This local interval may cause a bad
  // eviction chain.
  if (!LIS->hasInterval(Evictor))
    return false;
  LiveInterval &EvictorLI = LIS->getInterval(Evictor);
  if (EvictorLI.FindSegmentContaining(Cand.Intf.first()) == EvictorLI.end())
    return false;

  // Now, check to see if the local interval we will create is going to be
  // expensive enough to evict somebody If so, this may cause a bad eviction
  // chain.
  float splitArtifactWeight =
      VRAI->futureWeight(LIS->getInterval(Evictee),
                         Cand.Intf.first().getPrevIndex(), Cand.Intf.last());
  if (splitArtifactWeight >= 0 && splitArtifactWeight < MaxWeight)
    return false;

  return true;
}

/// Check if splitting VirtRegToSplit will create a local split interval
/// in basic block number BBNumber that may cause a spill.
///
/// \param VirtRegToSplit The register considered to be split.
/// \param Cand           The split candidate that determines the physical
///                       register we are splitting for and the interferences.
/// \param BBNumber       The number of a BB for which the region split process
///                       will create a local split interval.
/// \param Order          The physical registers that may get evicted by a
///                       split artifact of VirtRegToSplit.
/// \return True if splitting VirtRegToSplit may cause a spill, false
/// otherwise.
bool RAGreedy::splitCanCauseLocalSpill(unsigned VirtRegToSplit,
                                       GlobalSplitCandidate &Cand,
                                       unsigned BBNumber,
                                       const AllocationOrder &Order) {
  Cand.Intf.moveToBlock(BBNumber);

  // Check if the local interval will find a non interfereing assignment.
  for (auto PhysReg : Order.getOrder()) {
    if (!Matrix->checkInterference(Cand.Intf.first().getPrevIndex(),
                                   Cand.Intf.last(), PhysReg))
      return false;
  }

  // The local interval is not able to find non interferencing assignment
  // and not able to evict a less worthy interval, therfore, it can cause a
  // spill.
  return true;
}

/// calcGlobalSplitCost - Return the global split cost of following the split
/// pattern in LiveBundles. This cost should be added to the local cost of the
/// interference pattern in SplitConstraints.
///
BlockFrequency RAGreedy::calcGlobalSplitCost(GlobalSplitCandidate &Cand,
                                             const AllocationOrder &Order,
                                             bool *CanCauseEvictionChain) {
  BlockFrequency GlobalCost = 0;
  const BitVector &LiveBundles = Cand.LiveBundles;
  Register VirtRegToSplit = SA->getParent().reg();
  ArrayRef<SplitAnalysis::BlockInfo> UseBlocks = SA->getUseBlocks();
  for (unsigned I = 0; I != UseBlocks.size(); ++I) {
    const SplitAnalysis::BlockInfo &BI = UseBlocks[I];
    SpillPlacement::BlockConstraint &BC = SplitConstraints[I];
    bool RegIn  = LiveBundles[Bundles->getBundle(BC.Number, false)];
    bool RegOut = LiveBundles[Bundles->getBundle(BC.Number, true)];
    unsigned Ins = 0;

    Cand.Intf.moveToBlock(BC.Number);
    // Check wheather a local interval is going to be created during the region
    // split. Calculate adavanced spilt cost (cost of local intervals) if option
    // is enabled.
    if (EnableAdvancedRASplitCost && Cand.Intf.hasInterference() && BI.LiveIn &&
        BI.LiveOut && RegIn && RegOut) {

      if (CanCauseEvictionChain &&
          splitCanCauseEvictionChain(VirtRegToSplit, Cand, BC.Number, Order)) {
        // This interference causes our eviction from this assignment, we might
        // evict somebody else and eventually someone will spill, add that cost.
        // See splitCanCauseEvictionChain for detailed description of scenarios.
        GlobalCost += SpillPlacer->getBlockFrequency(BC.Number);
        GlobalCost += SpillPlacer->getBlockFrequency(BC.Number);

        *CanCauseEvictionChain = true;

      } else if (splitCanCauseLocalSpill(VirtRegToSplit, Cand, BC.Number,
                                         Order)) {
        // This interference causes local interval to spill, add that cost.
        GlobalCost += SpillPlacer->getBlockFrequency(BC.Number);
        GlobalCost += SpillPlacer->getBlockFrequency(BC.Number);
      }
    }

    if (BI.LiveIn)
      Ins += RegIn != (BC.Entry == SpillPlacement::PrefReg);
    if (BI.LiveOut)
      Ins += RegOut != (BC.Exit == SpillPlacement::PrefReg);
    while (Ins--)
      GlobalCost += SpillPlacer->getBlockFrequency(BC.Number);
  }

  for (unsigned Number : Cand.ActiveBlocks) {
    bool RegIn  = LiveBundles[Bundles->getBundle(Number, false)];
    bool RegOut = LiveBundles[Bundles->getBundle(Number, true)];
    if (!RegIn && !RegOut)
      continue;
    if (RegIn && RegOut) {
      // We need double spill code if this block has interference.
      Cand.Intf.moveToBlock(Number);
      if (Cand.Intf.hasInterference()) {
        GlobalCost += SpillPlacer->getBlockFrequency(Number);
        GlobalCost += SpillPlacer->getBlockFrequency(Number);

        // Check wheather a local interval is going to be created during the
        // region split.
        if (EnableAdvancedRASplitCost && CanCauseEvictionChain &&
            splitCanCauseEvictionChain(VirtRegToSplit, Cand, Number, Order)) {
          // This interference cause our eviction from this assignment, we might
          // evict somebody else, add that cost.
          // See splitCanCauseEvictionChain for detailed description of
          // scenarios.
          GlobalCost += SpillPlacer->getBlockFrequency(Number);
          GlobalCost += SpillPlacer->getBlockFrequency(Number);

          *CanCauseEvictionChain = true;
        }
      }
      continue;
    }
    // live-in / stack-out or stack-in live-out.
    GlobalCost += SpillPlacer->getBlockFrequency(Number);
  }
  return GlobalCost;
}

/// splitAroundRegion - Split the current live range around the regions
/// determined by BundleCand and GlobalCand.
///
/// Before calling this function, GlobalCand and BundleCand must be initialized
/// so each bundle is assigned to a valid candidate, or NoCand for the
/// stack-bound bundles.  The shared SA/SE SplitAnalysis and SplitEditor
/// objects must be initialized for the current live range, and intervals
/// created for the used candidates.
///
/// @param LREdit    The LiveRangeEdit object handling the current split.
/// @param UsedCands List of used GlobalCand entries. Every BundleCand value
///                  must appear in this list.
void RAGreedy::splitAroundRegion(LiveRangeEdit &LREdit,
                                 ArrayRef<unsigned> UsedCands) {
  // These are the intervals created for new global ranges. We may create more
  // intervals for local ranges.
  const unsigned NumGlobalIntvs = LREdit.size();
  LLVM_DEBUG(dbgs() << "splitAroundRegion with " << NumGlobalIntvs
                    << " globals.\n");
  assert(NumGlobalIntvs && "No global intervals configured");

  // Isolate even single instructions when dealing with a proper sub-class.
  // That guarantees register class inflation for the stack interval because it
  // is all copies.
  Register Reg = SA->getParent().reg();
  bool SingleInstrs = RegClassInfo.isProperSubClass(MRI->getRegClass(Reg));

  // First handle all the blocks with uses.
  ArrayRef<SplitAnalysis::BlockInfo> UseBlocks = SA->getUseBlocks();
  for (const SplitAnalysis::BlockInfo &BI : UseBlocks) {
    unsigned Number = BI.MBB->getNumber();
    unsigned IntvIn = 0, IntvOut = 0;
    SlotIndex IntfIn, IntfOut;
    if (BI.LiveIn) {
      unsigned CandIn = BundleCand[Bundles->getBundle(Number, false)];
      if (CandIn != NoCand) {
        GlobalSplitCandidate &Cand = GlobalCand[CandIn];
        IntvIn = Cand.IntvIdx;
        Cand.Intf.moveToBlock(Number);
        IntfIn = Cand.Intf.first();
      }
    }
    if (BI.LiveOut) {
      unsigned CandOut = BundleCand[Bundles->getBundle(Number, true)];
      if (CandOut != NoCand) {
        GlobalSplitCandidate &Cand = GlobalCand[CandOut];
        IntvOut = Cand.IntvIdx;
        Cand.Intf.moveToBlock(Number);
        IntfOut = Cand.Intf.last();
      }
    }

    // Create separate intervals for isolated blocks with multiple uses.
    if (!IntvIn && !IntvOut) {
      LLVM_DEBUG(dbgs() << printMBBReference(*BI.MBB) << " isolated.\n");
      if (SA->shouldSplitSingleBlock(BI, SingleInstrs))
        SE->splitSingleBlock(BI);
      continue;
    }

    if (IntvIn && IntvOut)
      SE->splitLiveThroughBlock(Number, IntvIn, IntfIn, IntvOut, IntfOut);
    else if (IntvIn)
      SE->splitRegInBlock(BI, IntvIn, IntfIn);
    else
      SE->splitRegOutBlock(BI, IntvOut, IntfOut);
  }

  // Handle live-through blocks. The relevant live-through blocks are stored in
  // the ActiveBlocks list with each candidate. We need to filter out
  // duplicates.
  BitVector Todo = SA->getThroughBlocks();
  for (unsigned c = 0; c != UsedCands.size(); ++c) {
    ArrayRef<unsigned> Blocks = GlobalCand[UsedCands[c]].ActiveBlocks;
    for (unsigned Number : Blocks) {
      if (!Todo.test(Number))
        continue;
      Todo.reset(Number);

      unsigned IntvIn = 0, IntvOut = 0;
      SlotIndex IntfIn, IntfOut;

      unsigned CandIn = BundleCand[Bundles->getBundle(Number, false)];
      if (CandIn != NoCand) {
        GlobalSplitCandidate &Cand = GlobalCand[CandIn];
        IntvIn = Cand.IntvIdx;
        Cand.Intf.moveToBlock(Number);
        IntfIn = Cand.Intf.first();
      }

      unsigned CandOut = BundleCand[Bundles->getBundle(Number, true)];
      if (CandOut != NoCand) {
        GlobalSplitCandidate &Cand = GlobalCand[CandOut];
        IntvOut = Cand.IntvIdx;
        Cand.Intf.moveToBlock(Number);
        IntfOut = Cand.Intf.last();
      }
      if (!IntvIn && !IntvOut)
        continue;
      SE->splitLiveThroughBlock(Number, IntvIn, IntfIn, IntvOut, IntfOut);
    }
  }

  ++NumGlobalSplits;

  SmallVector<unsigned, 8> IntvMap;
  SE->finish(&IntvMap);
  DebugVars->splitRegister(Reg, LREdit.regs(), *LIS);

  ExtraRegInfo.resize(MRI->getNumVirtRegs());
  unsigned OrigBlocks = SA->getNumLiveBlocks();

  // Sort out the new intervals created by splitting. We get four kinds:
  // - Remainder intervals should not be split again.
  // - Candidate intervals can be assigned to Cand.PhysReg.
  // - Block-local splits are candidates for local splitting.
  // - DCE leftovers should go back on the queue.
  for (unsigned I = 0, E = LREdit.size(); I != E; ++I) {
    LiveInterval &Reg = LIS->getInterval(LREdit.get(I));

    // Ignore old intervals from DCE.
    if (getStage(Reg) != RS_New)
      continue;

    // Remainder interval. Don't try splitting again, spill if it doesn't
    // allocate.
    if (IntvMap[I] == 0) {
      setStage(Reg, RS_Spill);
      continue;
    }

    // Global intervals. Allow repeated splitting as long as the number of live
    // blocks is strictly decreasing.
    if (IntvMap[I] < NumGlobalIntvs) {
      if (SA->countLiveBlocks(&Reg) >= OrigBlocks) {
        LLVM_DEBUG(dbgs() << "Main interval covers the same " << OrigBlocks
                          << " blocks as original.\n");
        // Don't allow repeated splitting as a safe guard against looping.
        setStage(Reg, RS_Split2);
      }
      continue;
    }

    // Other intervals are treated as new. This includes local intervals created
    // for blocks with multiple uses, and anything created by DCE.
  }

  if (VerifyEnabled)
    MF->verify(this, "After splitting live range around region");
}

MCRegister RAGreedy::tryRegionSplit(LiveInterval &VirtReg,
                                    AllocationOrder &Order,
                                    SmallVectorImpl<Register> &NewVRegs) {
  if (!TRI->shouldRegionSplitForVirtReg(*MF, VirtReg))
    return MCRegister::NoRegister;
  unsigned NumCands = 0;
  BlockFrequency SpillCost = calcSpillCost();
  BlockFrequency BestCost;

  // Check if we can split this live range around a compact region.
  bool HasCompact = calcCompactRegion(GlobalCand.front());
  if (HasCompact) {
    // Yes, keep GlobalCand[0] as the compact region candidate.
    NumCands = 1;
    BestCost = BlockFrequency::getMaxFrequency();
  } else {
    // No benefit from the compact region, our fallback will be per-block
    // splitting. Make sure we find a solution that is cheaper than spilling.
    BestCost = SpillCost;
    LLVM_DEBUG(dbgs() << "Cost of isolating all blocks = ";
               MBFI->printBlockFreq(dbgs(), BestCost) << '\n');
  }

  bool CanCauseEvictionChain = false;
  unsigned BestCand =
      calculateRegionSplitCost(VirtReg, Order, BestCost, NumCands,
                               false /*IgnoreCSR*/, &CanCauseEvictionChain);

  // Split candidates with compact regions can cause a bad eviction sequence.
  // See splitCanCauseEvictionChain for detailed description of scenarios.
  // To avoid it, we need to comapre the cost with the spill cost and not the
  // current max frequency.
  if (HasCompact && (BestCost > SpillCost) && (BestCand != NoCand) &&
    CanCauseEvictionChain) {
    return MCRegister::NoRegister;
  }

  // No solutions found, fall back to single block splitting.
  if (!HasCompact && BestCand == NoCand)
    return MCRegister::NoRegister;

  return doRegionSplit(VirtReg, BestCand, HasCompact, NewVRegs);
}

unsigned RAGreedy::calculateRegionSplitCost(LiveInterval &VirtReg,
                                            AllocationOrder &Order,
                                            BlockFrequency &BestCost,
                                            unsigned &NumCands, bool IgnoreCSR,
                                            bool *CanCauseEvictionChain) {
  unsigned BestCand = NoCand;
  for (MCPhysReg PhysReg : Order) {
    assert(PhysReg);
    if (IgnoreCSR && isUnusedCalleeSavedReg(PhysReg))
      continue;

    // Discard bad candidates before we run out of interference cache cursors.
    // This will only affect register classes with a lot of registers (>32).
    if (NumCands == IntfCache.getMaxCursors()) {
      unsigned WorstCount = ~0u;
      unsigned Worst = 0;
      for (unsigned CandIndex = 0; CandIndex != NumCands; ++CandIndex) {
        if (CandIndex == BestCand || !GlobalCand[CandIndex].PhysReg)
          continue;
        unsigned Count = GlobalCand[CandIndex].LiveBundles.count();
        if (Count < WorstCount) {
          Worst = CandIndex;
          WorstCount = Count;
        }
      }
      --NumCands;
      GlobalCand[Worst] = GlobalCand[NumCands];
      if (BestCand == NumCands)
        BestCand = Worst;
    }

    if (GlobalCand.size() <= NumCands)
      GlobalCand.resize(NumCands+1);
    GlobalSplitCandidate &Cand = GlobalCand[NumCands];
    Cand.reset(IntfCache, PhysReg);

    SpillPlacer->prepare(Cand.LiveBundles);
    BlockFrequency Cost;
    if (!addSplitConstraints(Cand.Intf, Cost)) {
      LLVM_DEBUG(dbgs() << printReg(PhysReg, TRI) << "\tno positive bundles\n");
      continue;
    }
    LLVM_DEBUG(dbgs() << printReg(PhysReg, TRI) << "\tstatic = ";
               MBFI->printBlockFreq(dbgs(), Cost));
    if (Cost >= BestCost) {
      LLVM_DEBUG({
        if (BestCand == NoCand)
          dbgs() << " worse than no bundles\n";
        else
          dbgs() << " worse than "
                 << printReg(GlobalCand[BestCand].PhysReg, TRI) << '\n';
      });
      continue;
    }
    if (!growRegion(Cand)) {
      LLVM_DEBUG(dbgs() << ", cannot spill all interferences.\n");
      continue;
    }

    SpillPlacer->finish();

    // No live bundles, defer to splitSingleBlocks().
    if (!Cand.LiveBundles.any()) {
      LLVM_DEBUG(dbgs() << " no bundles.\n");
      continue;
    }

    bool HasEvictionChain = false;
    Cost += calcGlobalSplitCost(Cand, Order, &HasEvictionChain);
    LLVM_DEBUG({
      dbgs() << ", total = ";
      MBFI->printBlockFreq(dbgs(), Cost) << " with bundles";
      for (int I : Cand.LiveBundles.set_bits())
        dbgs() << " EB#" << I;
      dbgs() << ".\n";
    });
    if (Cost < BestCost) {
      BestCand = NumCands;
      BestCost = Cost;
      // See splitCanCauseEvictionChain for detailed description of bad
      // eviction chain scenarios.
      if (CanCauseEvictionChain)
        *CanCauseEvictionChain = HasEvictionChain;
    }
    ++NumCands;
  }

  if (CanCauseEvictionChain && BestCand != NoCand) {
    // See splitCanCauseEvictionChain for detailed description of bad
    // eviction chain scenarios.
    LLVM_DEBUG(dbgs() << "Best split candidate of vreg "
                      << printReg(VirtReg.reg(), TRI) << "  may ");
    if (!(*CanCauseEvictionChain))
      LLVM_DEBUG(dbgs() << "not ");
    LLVM_DEBUG(dbgs() << "cause bad eviction chain\n");
  }

  return BestCand;
}

unsigned RAGreedy::doRegionSplit(LiveInterval &VirtReg, unsigned BestCand,
                                 bool HasCompact,
                                 SmallVectorImpl<Register> &NewVRegs) {
  SmallVector<unsigned, 8> UsedCands;
  // Prepare split editor.
  LiveRangeEdit LREdit(&VirtReg, NewVRegs, *MF, *LIS, VRM, this, &DeadRemats);
  SE->reset(LREdit, SplitSpillMode);

  // Assign all edge bundles to the preferred candidate, or NoCand.
  BundleCand.assign(Bundles->getNumBundles(), NoCand);

  // Assign bundles for the best candidate region.
  if (BestCand != NoCand) {
    GlobalSplitCandidate &Cand = GlobalCand[BestCand];
    if (unsigned B = Cand.getBundles(BundleCand, BestCand)) {
      UsedCands.push_back(BestCand);
      Cand.IntvIdx = SE->openIntv();
      LLVM_DEBUG(dbgs() << "Split for " << printReg(Cand.PhysReg, TRI) << " in "
                        << B << " bundles, intv " << Cand.IntvIdx << ".\n");
      (void)B;
    }
  }

  // Assign bundles for the compact region.
  if (HasCompact) {
    GlobalSplitCandidate &Cand = GlobalCand.front();
    assert(!Cand.PhysReg && "Compact region has no physreg");
    if (unsigned B = Cand.getBundles(BundleCand, 0)) {
      UsedCands.push_back(0);
      Cand.IntvIdx = SE->openIntv();
      LLVM_DEBUG(dbgs() << "Split for compact region in " << B
                        << " bundles, intv " << Cand.IntvIdx << ".\n");
      (void)B;
    }
  }

  splitAroundRegion(LREdit, UsedCands);
  return 0;
}

//===----------------------------------------------------------------------===//
//                            Per-Block Splitting
//===----------------------------------------------------------------------===//

/// tryBlockSplit - Split a global live range around every block with uses. This
/// creates a lot of local live ranges, that will be split by tryLocalSplit if
/// they don't allocate.
unsigned RAGreedy::tryBlockSplit(LiveInterval &VirtReg, AllocationOrder &Order,
                                 SmallVectorImpl<Register> &NewVRegs) {
  assert(&SA->getParent() == &VirtReg && "Live range wasn't analyzed");
  Register Reg = VirtReg.reg();
  bool SingleInstrs = RegClassInfo.isProperSubClass(MRI->getRegClass(Reg));
  LiveRangeEdit LREdit(&VirtReg, NewVRegs, *MF, *LIS, VRM, this, &DeadRemats);
  SE->reset(LREdit, SplitSpillMode);
  ArrayRef<SplitAnalysis::BlockInfo> UseBlocks = SA->getUseBlocks();
  for (const SplitAnalysis::BlockInfo &BI : UseBlocks) {
    if (SA->shouldSplitSingleBlock(BI, SingleInstrs))
      SE->splitSingleBlock(BI);
  }
  // No blocks were split.
  if (LREdit.empty())
    return 0;

  // We did split for some blocks.
  SmallVector<unsigned, 8> IntvMap;
  SE->finish(&IntvMap);

  // Tell LiveDebugVariables about the new ranges.
  DebugVars->splitRegister(Reg, LREdit.regs(), *LIS);

  ExtraRegInfo.resize(MRI->getNumVirtRegs());

  // Sort out the new intervals created by splitting. The remainder interval
  // goes straight to spilling, the new local ranges get to stay RS_New.
  for (unsigned I = 0, E = LREdit.size(); I != E; ++I) {
    LiveInterval &LI = LIS->getInterval(LREdit.get(I));
    if (getStage(LI) == RS_New && IntvMap[I] == 0)
      setStage(LI, RS_Spill);
  }

  if (VerifyEnabled)
    MF->verify(this, "After splitting live range around basic blocks");
  return 0;
}

//===----------------------------------------------------------------------===//
//                         Per-Instruction Splitting
//===----------------------------------------------------------------------===//

/// Get the number of allocatable registers that match the constraints of \p Reg
/// on \p MI and that are also in \p SuperRC.
static unsigned getNumAllocatableRegsForConstraints(
    const MachineInstr *MI, Register Reg, const TargetRegisterClass *SuperRC,
    const TargetInstrInfo *TII, const TargetRegisterInfo *TRI,
    const RegisterClassInfo &RCI) {
  assert(SuperRC && "Invalid register class");

  const TargetRegisterClass *ConstrainedRC =
      MI->getRegClassConstraintEffectForVReg(Reg, SuperRC, TII, TRI,
                                             /* ExploreBundle */ true);
  if (!ConstrainedRC)
    return 0;
  return RCI.getNumAllocatableRegs(ConstrainedRC);
}

/// tryInstructionSplit - Split a live range around individual instructions.
/// This is normally not worthwhile since the spiller is doing essentially the
/// same thing. However, when the live range is in a constrained register
/// class, it may help to insert copies such that parts of the live range can
/// be moved to a larger register class.
///
/// This is similar to spilling to a larger register class.
unsigned
RAGreedy::tryInstructionSplit(LiveInterval &VirtReg, AllocationOrder &Order,
                              SmallVectorImpl<Register> &NewVRegs) {
  const TargetRegisterClass *CurRC = MRI->getRegClass(VirtReg.reg());
  // There is no point to this if there are no larger sub-classes.
  if (!RegClassInfo.isProperSubClass(CurRC))
    return 0;

  // Always enable split spill mode, since we're effectively spilling to a
  // register.
  LiveRangeEdit LREdit(&VirtReg, NewVRegs, *MF, *LIS, VRM, this, &DeadRemats);
  SE->reset(LREdit, SplitEditor::SM_Size);

  ArrayRef<SlotIndex> Uses = SA->getUseSlots();
  if (Uses.size() <= 1)
    return 0;

  LLVM_DEBUG(dbgs() << "Split around " << Uses.size()
                    << " individual instrs.\n");

  const TargetRegisterClass *SuperRC =
      TRI->getLargestLegalSuperClass(CurRC, *MF);
  unsigned SuperRCNumAllocatableRegs = RCI.getNumAllocatableRegs(SuperRC);
  // Split around every non-copy instruction if this split will relax
  // the constraints on the virtual register.
  // Otherwise, splitting just inserts uncoalescable copies that do not help
  // the allocation.
  for (const auto &Use : Uses) {
    if (const MachineInstr *MI = Indexes->getInstructionFromIndex(Use))
      if (MI->isFullCopy() ||
          SuperRCNumAllocatableRegs ==
              getNumAllocatableRegsForConstraints(MI, VirtReg.reg(), SuperRC,
                                                  TII, TRI, RCI)) {
        LLVM_DEBUG(dbgs() << "    skip:\t" << Use << '\t' << *MI);
        continue;
      }
    SE->openIntv();
    SlotIndex SegStart = SE->enterIntvBefore(Use);
    SlotIndex SegStop = SE->leaveIntvAfter(Use);
    SE->useIntv(SegStart, SegStop);
  }

  if (LREdit.empty()) {
    LLVM_DEBUG(dbgs() << "All uses were copies.\n");
    return 0;
  }

  SmallVector<unsigned, 8> IntvMap;
  SE->finish(&IntvMap);
  DebugVars->splitRegister(VirtReg.reg(), LREdit.regs(), *LIS);
  ExtraRegInfo.resize(MRI->getNumVirtRegs());

  // Assign all new registers to RS_Spill. This was the last chance.
  setStage(LREdit.begin(), LREdit.end(), RS_Spill);
  return 0;
}

//===----------------------------------------------------------------------===//
//                             Local Splitting
//===----------------------------------------------------------------------===//

/// calcGapWeights - Compute the maximum spill weight that needs to be evicted
/// in order to use PhysReg between two entries in SA->UseSlots.
///
/// GapWeight[I] represents the gap between UseSlots[I] and UseSlots[I + 1].
///
void RAGreedy::calcGapWeights(MCRegister PhysReg,
                              SmallVectorImpl<float> &GapWeight) {
  assert(SA->getUseBlocks().size() == 1 && "Not a local interval");
  const SplitAnalysis::BlockInfo &BI = SA->getUseBlocks().front();
  ArrayRef<SlotIndex> Uses = SA->getUseSlots();
  const unsigned NumGaps = Uses.size()-1;

  // Start and end points for the interference check.
  SlotIndex StartIdx =
    BI.LiveIn ? BI.FirstInstr.getBaseIndex() : BI.FirstInstr;
  SlotIndex StopIdx =
    BI.LiveOut ? BI.LastInstr.getBoundaryIndex() : BI.LastInstr;

  GapWeight.assign(NumGaps, 0.0f);

  // Add interference from each overlapping register.
  for (MCRegUnitIterator Units(PhysReg, TRI); Units.isValid(); ++Units) {
    if (!Matrix->query(const_cast<LiveInterval&>(SA->getParent()), *Units)
          .checkInterference())
      continue;

    // We know that VirtReg is a continuous interval from FirstInstr to
    // LastInstr, so we don't need InterferenceQuery.
    //
    // Interference that overlaps an instruction is counted in both gaps
    // surrounding the instruction. The exception is interference before
    // StartIdx and after StopIdx.
    //
    LiveIntervalUnion::SegmentIter IntI =
      Matrix->getLiveUnions()[*Units] .find(StartIdx);
    for (unsigned Gap = 0; IntI.valid() && IntI.start() < StopIdx; ++IntI) {
      // Skip the gaps before IntI.
      while (Uses[Gap+1].getBoundaryIndex() < IntI.start())
        if (++Gap == NumGaps)
          break;
      if (Gap == NumGaps)
        break;

      // Update the gaps covered by IntI.
      const float weight = IntI.value()->weight();
      for (; Gap != NumGaps; ++Gap) {
        GapWeight[Gap] = std::max(GapWeight[Gap], weight);
        if (Uses[Gap+1].getBaseIndex() >= IntI.stop())
          break;
      }
      if (Gap == NumGaps)
        break;
    }
  }

  // Add fixed interference.
  for (MCRegUnitIterator Units(PhysReg, TRI); Units.isValid(); ++Units) {
    const LiveRange &LR = LIS->getRegUnit(*Units);
    LiveRange::const_iterator I = LR.find(StartIdx);
    LiveRange::const_iterator E = LR.end();

    // Same loop as above. Mark any overlapped gaps as HUGE_VALF.
    for (unsigned Gap = 0; I != E && I->start < StopIdx; ++I) {
      while (Uses[Gap+1].getBoundaryIndex() < I->start)
        if (++Gap == NumGaps)
          break;
      if (Gap == NumGaps)
        break;

      for (; Gap != NumGaps; ++Gap) {
        GapWeight[Gap] = huge_valf;
        if (Uses[Gap+1].getBaseIndex() >= I->end)
          break;
      }
      if (Gap == NumGaps)
        break;
    }
  }
}

/// tryLocalSplit - Try to split VirtReg into smaller intervals inside its only
/// basic block.
///
unsigned RAGreedy::tryLocalSplit(LiveInterval &VirtReg, AllocationOrder &Order,
                                 SmallVectorImpl<Register> &NewVRegs) {
  // TODO: the function currently only handles a single UseBlock; it should be
  // possible to generalize.
  if (SA->getUseBlocks().size() != 1)
    return 0;

  const SplitAnalysis::BlockInfo &BI = SA->getUseBlocks().front();

  // Note that it is possible to have an interval that is live-in or live-out
  // while only covering a single block - A phi-def can use undef values from
  // predecessors, and the block could be a single-block loop.
  // We don't bother doing anything clever about such a case, we simply assume
  // that the interval is continuous from FirstInstr to LastInstr. We should
  // make sure that we don't do anything illegal to such an interval, though.

  ArrayRef<SlotIndex> Uses = SA->getUseSlots();
  if (Uses.size() <= 2)
    return 0;
  const unsigned NumGaps = Uses.size()-1;

  LLVM_DEBUG({
    dbgs() << "tryLocalSplit: ";
    for (const auto &Use : Uses)
      dbgs() << ' ' << Use;
    dbgs() << '\n';
  });

  // If VirtReg is live across any register mask operands, compute a list of
  // gaps with register masks.
  SmallVector<unsigned, 8> RegMaskGaps;
  if (Matrix->checkRegMaskInterference(VirtReg)) {
    // Get regmask slots for the whole block.
    ArrayRef<SlotIndex> RMS = LIS->getRegMaskSlotsInBlock(BI.MBB->getNumber());
    LLVM_DEBUG(dbgs() << RMS.size() << " regmasks in block:");
    // Constrain to VirtReg's live range.
    unsigned RI =
        llvm::lower_bound(RMS, Uses.front().getRegSlot()) - RMS.begin();
    unsigned RE = RMS.size();
    for (unsigned I = 0; I != NumGaps && RI != RE; ++I) {
      // Look for Uses[I] <= RMS <= Uses[I + 1].
      assert(!SlotIndex::isEarlierInstr(RMS[RI], Uses[I]));
      if (SlotIndex::isEarlierInstr(Uses[I + 1], RMS[RI]))
        continue;
      // Skip a regmask on the same instruction as the last use. It doesn't
      // overlap the live range.
      if (SlotIndex::isSameInstr(Uses[I + 1], RMS[RI]) && I + 1 == NumGaps)
        break;
      LLVM_DEBUG(dbgs() << ' ' << RMS[RI] << ':' << Uses[I] << '-'
                        << Uses[I + 1]);
      RegMaskGaps.push_back(I);
      // Advance ri to the next gap. A regmask on one of the uses counts in
      // both gaps.
      while (RI != RE && SlotIndex::isEarlierInstr(RMS[RI], Uses[I + 1]))
        ++RI;
    }
    LLVM_DEBUG(dbgs() << '\n');
  }

  // Since we allow local split results to be split again, there is a risk of
  // creating infinite loops. It is tempting to require that the new live
  // ranges have less instructions than the original. That would guarantee
  // convergence, but it is too strict. A live range with 3 instructions can be
  // split 2+3 (including the COPY), and we want to allow that.
  //
  // Instead we use these rules:
  //
  // 1. Allow any split for ranges with getStage() < RS_Split2. (Except for the
  //    noop split, of course).
  // 2. Require progress be made for ranges with getStage() == RS_Split2. All
  //    the new ranges must have fewer instructions than before the split.
  // 3. New ranges with the same number of instructions are marked RS_Split2,
  //    smaller ranges are marked RS_New.
  //
  // These rules allow a 3 -> 2+3 split once, which we need. They also prevent
  // excessive splitting and infinite loops.
  //
  bool ProgressRequired = getStage(VirtReg) >= RS_Split2;

  // Best split candidate.
  unsigned BestBefore = NumGaps;
  unsigned BestAfter = 0;
  float BestDiff = 0;

  const float blockFreq =
    SpillPlacer->getBlockFrequency(BI.MBB->getNumber()).getFrequency() *
    (1.0f / MBFI->getEntryFreq());
  SmallVector<float, 8> GapWeight;

  for (MCPhysReg PhysReg : Order) {
    assert(PhysReg);
    // Keep track of the largest spill weight that would need to be evicted in
    // order to make use of PhysReg between UseSlots[I] and UseSlots[I + 1].
    calcGapWeights(PhysReg, GapWeight);

    // Remove any gaps with regmask clobbers.
    if (Matrix->checkRegMaskInterference(VirtReg, PhysReg))
      for (unsigned I = 0, E = RegMaskGaps.size(); I != E; ++I)
        GapWeight[RegMaskGaps[I]] = huge_valf;

    // Try to find the best sequence of gaps to close.
    // The new spill weight must be larger than any gap interference.

    // We will split before Uses[SplitBefore] and after Uses[SplitAfter].
    unsigned SplitBefore = 0, SplitAfter = 1;

    // MaxGap should always be max(GapWeight[SplitBefore..SplitAfter-1]).
    // It is the spill weight that needs to be evicted.
    float MaxGap = GapWeight[0];

    while (true) {
      // Live before/after split?
      const bool LiveBefore = SplitBefore != 0 || BI.LiveIn;
      const bool LiveAfter = SplitAfter != NumGaps || BI.LiveOut;

      LLVM_DEBUG(dbgs() << printReg(PhysReg, TRI) << ' ' << Uses[SplitBefore]
                        << '-' << Uses[SplitAfter] << " I=" << MaxGap);

      // Stop before the interval gets so big we wouldn't be making progress.
      if (!LiveBefore && !LiveAfter) {
        LLVM_DEBUG(dbgs() << " all\n");
        break;
      }
      // Should the interval be extended or shrunk?
      bool Shrink = true;

      // How many gaps would the new range have?
      unsigned NewGaps = LiveBefore + SplitAfter - SplitBefore + LiveAfter;

      // Legally, without causing looping?
      bool Legal = !ProgressRequired || NewGaps < NumGaps;

      if (Legal && MaxGap < huge_valf) {
        // Estimate the new spill weight. Each instruction reads or writes the
        // register. Conservatively assume there are no read-modify-write
        // instructions.
        //
        // Try to guess the size of the new interval.
        const float EstWeight = normalizeSpillWeight(
            blockFreq * (NewGaps + 1),
            Uses[SplitBefore].distance(Uses[SplitAfter]) +
                (LiveBefore + LiveAfter) * SlotIndex::InstrDist,
            1);
        // Would this split be possible to allocate?
        // Never allocate all gaps, we wouldn't be making progress.
        LLVM_DEBUG(dbgs() << " w=" << EstWeight);
        if (EstWeight * Hysteresis >= MaxGap) {
          Shrink = false;
          float Diff = EstWeight - MaxGap;
          if (Diff > BestDiff) {
            LLVM_DEBUG(dbgs() << " (best)");
            BestDiff = Hysteresis * Diff;
            BestBefore = SplitBefore;
            BestAfter = SplitAfter;
          }
        }
      }

      // Try to shrink.
      if (Shrink) {
        if (++SplitBefore < SplitAfter) {
          LLVM_DEBUG(dbgs() << " shrink\n");
          // Recompute the max when necessary.
          if (GapWeight[SplitBefore - 1] >= MaxGap) {
            MaxGap = GapWeight[SplitBefore];
            for (unsigned I = SplitBefore + 1; I != SplitAfter; ++I)
              MaxGap = std::max(MaxGap, GapWeight[I]);
          }
          continue;
        }
        MaxGap = 0;
      }

      // Try to extend the interval.
      if (SplitAfter >= NumGaps) {
        LLVM_DEBUG(dbgs() << " end\n");
        break;
      }

      LLVM_DEBUG(dbgs() << " extend\n");
      MaxGap = std::max(MaxGap, GapWeight[SplitAfter++]);
    }
  }

  // Didn't find any candidates?
  if (BestBefore == NumGaps)
    return 0;

  LLVM_DEBUG(dbgs() << "Best local split range: " << Uses[BestBefore] << '-'
                    << Uses[BestAfter] << ", " << BestDiff << ", "
                    << (BestAfter - BestBefore + 1) << " instrs\n");

  LiveRangeEdit LREdit(&VirtReg, NewVRegs, *MF, *LIS, VRM, this, &DeadRemats);
  SE->reset(LREdit);

  SE->openIntv();
  SlotIndex SegStart = SE->enterIntvBefore(Uses[BestBefore]);
  SlotIndex SegStop  = SE->leaveIntvAfter(Uses[BestAfter]);
  SE->useIntv(SegStart, SegStop);
  SmallVector<unsigned, 8> IntvMap;
  SE->finish(&IntvMap);
  DebugVars->splitRegister(VirtReg.reg(), LREdit.regs(), *LIS);

  // If the new range has the same number of instructions as before, mark it as
  // RS_Split2 so the next split will be forced to make progress. Otherwise,
  // leave the new intervals as RS_New so they can compete.
  bool LiveBefore = BestBefore != 0 || BI.LiveIn;
  bool LiveAfter = BestAfter != NumGaps || BI.LiveOut;
  unsigned NewGaps = LiveBefore + BestAfter - BestBefore + LiveAfter;
  if (NewGaps >= NumGaps) {
    LLVM_DEBUG(dbgs() << "Tagging non-progress ranges: ");
    assert(!ProgressRequired && "Didn't make progress when it was required.");
    for (unsigned I = 0, E = IntvMap.size(); I != E; ++I)
      if (IntvMap[I] == 1) {
        setStage(LIS->getInterval(LREdit.get(I)), RS_Split2);
        LLVM_DEBUG(dbgs() << printReg(LREdit.get(I)));
      }
    LLVM_DEBUG(dbgs() << '\n');
  }
  ++NumLocalSplits;

  return 0;
}

//===----------------------------------------------------------------------===//
//                          Live Range Splitting
//===----------------------------------------------------------------------===//

/// trySplit - Try to split VirtReg or one of its interferences, making it
/// assignable.
/// @return Physreg when VirtReg may be assigned and/or new NewVRegs.
unsigned RAGreedy::trySplit(LiveInterval &VirtReg, AllocationOrder &Order,
                            SmallVectorImpl<Register> &NewVRegs,
                            const SmallVirtRegSet &FixedRegisters) {
  // Ranges must be Split2 or less.
  if (getStage(VirtReg) >= RS_Spill)
    return 0;

  // Local intervals are handled separately.
  if (LIS->intervalIsInOneMBB(VirtReg)) {
    NamedRegionTimer T("local_split", "Local Splitting", TimerGroupName,
                       TimerGroupDescription, TimePassesIsEnabled);
    SA->analyze(&VirtReg);
    Register PhysReg = tryLocalSplit(VirtReg, Order, NewVRegs);
    if (PhysReg || !NewVRegs.empty())
      return PhysReg;
    return tryInstructionSplit(VirtReg, Order, NewVRegs);
  }

  NamedRegionTimer T("global_split", "Global Splitting", TimerGroupName,
                     TimerGroupDescription, TimePassesIsEnabled);

  SA->analyze(&VirtReg);

  // FIXME: SplitAnalysis may repair broken live ranges coming from the
  // coalescer. That may cause the range to become allocatable which means that
  // tryRegionSplit won't be making progress. This check should be replaced with
  // an assertion when the coalescer is fixed.
  if (SA->didRepairRange()) {
    // VirtReg has changed, so all cached queries are invalid.
    Matrix->invalidateVirtRegs();
    if (Register PhysReg = tryAssign(VirtReg, Order, NewVRegs, FixedRegisters))
      return PhysReg;
  }

  // First try to split around a region spanning multiple blocks. RS_Split2
  // ranges already made dubious progress with region splitting, so they go
  // straight to single block splitting.
  if (getStage(VirtReg) < RS_Split2) {
    MCRegister PhysReg = tryRegionSplit(VirtReg, Order, NewVRegs);
    if (PhysReg || !NewVRegs.empty())
      return PhysReg;
  }

  // Then isolate blocks.
  return tryBlockSplit(VirtReg, Order, NewVRegs);
}

//===----------------------------------------------------------------------===//
//                          Last Chance Recoloring
//===----------------------------------------------------------------------===//

/// Return true if \p reg has any tied def operand.
static bool hasTiedDef(MachineRegisterInfo *MRI, unsigned reg) {
  for (const MachineOperand &MO : MRI->def_operands(reg))
    if (MO.isTied())
      return true;

  return false;
}

/// mayRecolorAllInterferences - Check if the virtual registers that
/// interfere with \p VirtReg on \p PhysReg (or one of its aliases) may be
/// recolored to free \p PhysReg.
/// When true is returned, \p RecoloringCandidates has been augmented with all
/// the live intervals that need to be recolored in order to free \p PhysReg
/// for \p VirtReg.
/// \p FixedRegisters contains all the virtual registers that cannot be
/// recolored.
bool RAGreedy::mayRecolorAllInterferences(
    MCRegister PhysReg, LiveInterval &VirtReg, SmallLISet &RecoloringCandidates,
    const SmallVirtRegSet &FixedRegisters) {
  const TargetRegisterClass *CurRC = MRI->getRegClass(VirtReg.reg());

  for (MCRegUnitIterator Units(PhysReg, TRI); Units.isValid(); ++Units) {
    LiveIntervalUnion::Query &Q = Matrix->query(VirtReg, *Units);
    // If there is LastChanceRecoloringMaxInterference or more interferences,
    // chances are one would not be recolorable.
    if (Q.collectInterferingVRegs(LastChanceRecoloringMaxInterference) >=
        LastChanceRecoloringMaxInterference && !ExhaustiveSearch) {
      LLVM_DEBUG(dbgs() << "Early abort: too many interferences.\n");
      CutOffInfo |= CO_Interf;
      return false;
    }
    for (LiveInterval *Intf : reverse(Q.interferingVRegs())) {
      // If Intf is done and sit on the same register class as VirtReg,
      // it would not be recolorable as it is in the same state as VirtReg.
      // However, if VirtReg has tied defs and Intf doesn't, then
      // there is still a point in examining if it can be recolorable.
      if (((getStage(*Intf) == RS_Done &&
            MRI->getRegClass(Intf->reg()) == CurRC) &&
           !(hasTiedDef(MRI, VirtReg.reg()) &&
             !hasTiedDef(MRI, Intf->reg()))) ||
          FixedRegisters.count(Intf->reg())) {
        LLVM_DEBUG(
            dbgs() << "Early abort: the interference is not recolorable.\n");
        return false;
      }
      RecoloringCandidates.insert(Intf);
    }
  }
  return true;
}

/// tryLastChanceRecoloring - Try to assign a color to \p VirtReg by recoloring
/// its interferences.
/// Last chance recoloring chooses a color for \p VirtReg and recolors every
/// virtual register that was using it. The recoloring process may recursively
/// use the last chance recoloring. Therefore, when a virtual register has been
/// assigned a color by this mechanism, it is marked as Fixed, i.e., it cannot
/// be last-chance-recolored again during this recoloring "session".
/// E.g.,
/// Let
/// vA can use {R1, R2    }
/// vB can use {    R2, R3}
/// vC can use {R1        }
/// Where vA, vB, and vC cannot be split anymore (they are reloads for
/// instance) and they all interfere.
///
/// vA is assigned R1
/// vB is assigned R2
/// vC tries to evict vA but vA is already done.
/// Regular register allocation fails.
///
/// Last chance recoloring kicks in:
/// vC does as if vA was evicted => vC uses R1.
/// vC is marked as fixed.
/// vA needs to find a color.
/// None are available.
/// vA cannot evict vC: vC is a fixed virtual register now.
/// vA does as if vB was evicted => vA uses R2.
/// vB needs to find a color.
/// R3 is available.
/// Recoloring => vC = R1, vA = R2, vB = R3
///
/// \p Order defines the preferred allocation order for \p VirtReg.
/// \p NewRegs will contain any new virtual register that have been created
/// (split, spill) during the process and that must be assigned.
/// \p FixedRegisters contains all the virtual registers that cannot be
/// recolored.
/// \p Depth gives the current depth of the last chance recoloring.
/// \return a physical register that can be used for VirtReg or ~0u if none
/// exists.
unsigned RAGreedy::tryLastChanceRecoloring(LiveInterval &VirtReg,
                                           AllocationOrder &Order,
                                           SmallVectorImpl<Register> &NewVRegs,
                                           SmallVirtRegSet &FixedRegisters,
                                           unsigned Depth) {
  if (!TRI->shouldUseLastChanceRecoloringForVirtReg(*MF, VirtReg))
    return ~0u;

  LLVM_DEBUG(dbgs() << "Try last chance recoloring for " << VirtReg << '\n');
  // Ranges must be Done.
  assert((getStage(VirtReg) >= RS_Done || !VirtReg.isSpillable()) &&
         "Last chance recoloring should really be last chance");
  // Set the max depth to LastChanceRecoloringMaxDepth.
  // We may want to reconsider that if we end up with a too large search space
  // for target with hundreds of registers.
  // Indeed, in that case we may want to cut the search space earlier.
  if (Depth >= LastChanceRecoloringMaxDepth && !ExhaustiveSearch) {
    LLVM_DEBUG(dbgs() << "Abort because max depth has been reached.\n");
    CutOffInfo |= CO_Depth;
    return ~0u;
  }

  // Set of Live intervals that will need to be recolored.
  SmallLISet RecoloringCandidates;
  // Record the original mapping virtual register to physical register in case
  // the recoloring fails.
  DenseMap<Register, MCRegister> VirtRegToPhysReg;
  // Mark VirtReg as fixed, i.e., it will not be recolored pass this point in
  // this recoloring "session".
  assert(!FixedRegisters.count(VirtReg.reg()));
  FixedRegisters.insert(VirtReg.reg());
  SmallVector<Register, 4> CurrentNewVRegs;

  for (MCRegister PhysReg : Order) {
    assert(PhysReg.isValid());
    LLVM_DEBUG(dbgs() << "Try to assign: " << VirtReg << " to "
                      << printReg(PhysReg, TRI) << '\n');
    RecoloringCandidates.clear();
    VirtRegToPhysReg.clear();
    CurrentNewVRegs.clear();

    // It is only possible to recolor virtual register interference.
    if (Matrix->checkInterference(VirtReg, PhysReg) >
        LiveRegMatrix::IK_VirtReg) {
      LLVM_DEBUG(
          dbgs() << "Some interferences are not with virtual registers.\n");

      continue;
    }

    // Early give up on this PhysReg if it is obvious we cannot recolor all
    // the interferences.
    if (!mayRecolorAllInterferences(PhysReg, VirtReg, RecoloringCandidates,
                                    FixedRegisters)) {
      LLVM_DEBUG(dbgs() << "Some interferences cannot be recolored.\n");
      continue;
    }

    // RecoloringCandidates contains all the virtual registers that interfer
    // with VirtReg on PhysReg (or one of its aliases).
    // Enqueue them for recoloring and perform the actual recoloring.
    PQueue RecoloringQueue;
    for (LiveInterval *RC : RecoloringCandidates) {
      Register ItVirtReg = RC->reg();
      enqueue(RecoloringQueue, RC);
      assert(VRM->hasPhys(ItVirtReg) &&
             "Interferences are supposed to be with allocated variables");

      // Record the current allocation.
      VirtRegToPhysReg[ItVirtReg] = VRM->getPhys(ItVirtReg);
      // unset the related struct.
      Matrix->unassign(*RC);
    }

    // Do as if VirtReg was assigned to PhysReg so that the underlying
    // recoloring has the right information about the interferes and
    // available colors.
    Matrix->assign(VirtReg, PhysReg);

    // Save the current recoloring state.
    // If we cannot recolor all the interferences, we will have to start again
    // at this point for the next physical register.
    SmallVirtRegSet SaveFixedRegisters(FixedRegisters);
    if (tryRecoloringCandidates(RecoloringQueue, CurrentNewVRegs,
                                FixedRegisters, Depth)) {
      // Push the queued vregs into the main queue.
      for (Register NewVReg : CurrentNewVRegs)
        NewVRegs.push_back(NewVReg);
      // Do not mess up with the global assignment process.
      // I.e., VirtReg must be unassigned.
      Matrix->unassign(VirtReg);
      return PhysReg;
    }

    LLVM_DEBUG(dbgs() << "Fail to assign: " << VirtReg << " to "
                      << printReg(PhysReg, TRI) << '\n');

    // The recoloring attempt failed, undo the changes.
    FixedRegisters = SaveFixedRegisters;
    Matrix->unassign(VirtReg);

    // For a newly created vreg which is also in RecoloringCandidates,
    // don't add it to NewVRegs because its physical register will be restored
    // below. Other vregs in CurrentNewVRegs are created by calling
    // selectOrSplit and should be added into NewVRegs.
    for (Register &R : CurrentNewVRegs) {
      if (RecoloringCandidates.count(&LIS->getInterval(R)))
        continue;
      NewVRegs.push_back(R);
    }

    for (LiveInterval *RC : RecoloringCandidates) {
      Register ItVirtReg = RC->reg();
      if (VRM->hasPhys(ItVirtReg))
        Matrix->unassign(*RC);
      MCRegister ItPhysReg = VirtRegToPhysReg[ItVirtReg];
      Matrix->assign(*RC, ItPhysReg);
    }
  }

  // Last chance recoloring did not worked either, give up.
  return ~0u;
}

/// tryRecoloringCandidates - Try to assign a new color to every register
/// in \RecoloringQueue.
/// \p NewRegs will contain any new virtual register created during the
/// recoloring process.
/// \p FixedRegisters[in/out] contains all the registers that have been
/// recolored.
/// \return true if all virtual registers in RecoloringQueue were successfully
/// recolored, false otherwise.
bool RAGreedy::tryRecoloringCandidates(PQueue &RecoloringQueue,
                                       SmallVectorImpl<Register> &NewVRegs,
                                       SmallVirtRegSet &FixedRegisters,
                                       unsigned Depth) {
  while (!RecoloringQueue.empty()) {
    LiveInterval *LI = dequeue(RecoloringQueue);
    LLVM_DEBUG(dbgs() << "Try to recolor: " << *LI << '\n');
    MCRegister PhysReg =
        selectOrSplitImpl(*LI, NewVRegs, FixedRegisters, Depth + 1);
    // When splitting happens, the live-range may actually be empty.
    // In that case, this is okay to continue the recoloring even
    // if we did not find an alternative color for it. Indeed,
    // there will not be anything to color for LI in the end.
    if (PhysReg == ~0u || (!PhysReg && !LI->empty()))
      return false;

    if (!PhysReg) {
      assert(LI->empty() && "Only empty live-range do not require a register");
      LLVM_DEBUG(dbgs() << "Recoloring of " << *LI
                        << " succeeded. Empty LI.\n");
      continue;
    }
    LLVM_DEBUG(dbgs() << "Recoloring of " << *LI
                      << " succeeded with: " << printReg(PhysReg, TRI) << '\n');

    Matrix->assign(*LI, PhysReg);
    FixedRegisters.insert(LI->reg());
  }
  return true;
}

//===----------------------------------------------------------------------===//
//                            Main Entry Point
//===----------------------------------------------------------------------===//

MCRegister RAGreedy::selectOrSplit(LiveInterval &VirtReg,
                                   SmallVectorImpl<Register> &NewVRegs) {
  CutOffInfo = CO_None;
  LLVMContext &Ctx = MF->getFunction().getContext();
  SmallVirtRegSet FixedRegisters;
  MCRegister Reg = selectOrSplitImpl(VirtReg, NewVRegs, FixedRegisters);
  if (Reg == ~0U && (CutOffInfo != CO_None)) {
    uint8_t CutOffEncountered = CutOffInfo & (CO_Depth | CO_Interf);
    if (CutOffEncountered == CO_Depth)
      Ctx.emitError("register allocation failed: maximum depth for recoloring "
                    "reached. Use -fexhaustive-register-search to skip "
                    "cutoffs");
    else if (CutOffEncountered == CO_Interf)
      Ctx.emitError("register allocation failed: maximum interference for "
                    "recoloring reached. Use -fexhaustive-register-search "
                    "to skip cutoffs");
    else if (CutOffEncountered == (CO_Depth | CO_Interf))
      Ctx.emitError("register allocation failed: maximum interference and "
                    "depth for recoloring reached. Use "
                    "-fexhaustive-register-search to skip cutoffs");
  }
  return Reg;
}

/// Using a CSR for the first time has a cost because it causes push|pop
/// to be added to prologue|epilogue. Splitting a cold section of the live
/// range can have lower cost than using the CSR for the first time;
/// Spilling a live range in the cold path can have lower cost than using
/// the CSR for the first time. Returns the physical register if we decide
/// to use the CSR; otherwise return 0.
MCRegister
RAGreedy::tryAssignCSRFirstTime(LiveInterval &VirtReg, AllocationOrder &Order,
                                MCRegister PhysReg, uint8_t &CostPerUseLimit,
                                SmallVectorImpl<Register> &NewVRegs) {
  if (getStage(VirtReg) == RS_Spill && VirtReg.isSpillable()) {
    // We choose spill over using the CSR for the first time if the spill cost
    // is lower than CSRCost.
    SA->analyze(&VirtReg);
    if (calcSpillCost() >= CSRCost)
      return PhysReg;

    // We are going to spill, set CostPerUseLimit to 1 to make sure that
    // we will not use a callee-saved register in tryEvict.
    CostPerUseLimit = 1;
    return 0;
  }
  if (getStage(VirtReg) < RS_Split) {
    // We choose pre-splitting over using the CSR for the first time if
    // the cost of splitting is lower than CSRCost.
    SA->analyze(&VirtReg);
    unsigned NumCands = 0;
    BlockFrequency BestCost = CSRCost; // Don't modify CSRCost.
    unsigned BestCand = calculateRegionSplitCost(VirtReg, Order, BestCost,
                                                 NumCands, true /*IgnoreCSR*/);
    if (BestCand == NoCand)
      // Use the CSR if we can't find a region split below CSRCost.
      return PhysReg;

    // Perform the actual pre-splitting.
    doRegionSplit(VirtReg, BestCand, false/*HasCompact*/, NewVRegs);
    return 0;
  }
  return PhysReg;
}

void RAGreedy::aboutToRemoveInterval(LiveInterval &LI) {
  // Do not keep invalid information around.
  SetOfBrokenHints.remove(&LI);
}

void RAGreedy::initializeCSRCost() {
  // We use the larger one out of the command-line option and the value report
  // by TRI.
  CSRCost = BlockFrequency(
      std::max((unsigned)CSRFirstTimeCost, TRI->getCSRFirstUseCost()));
  if (!CSRCost.getFrequency())
    return;

  // Raw cost is relative to Entry == 2^14; scale it appropriately.
  uint64_t ActualEntry = MBFI->getEntryFreq();
  if (!ActualEntry) {
    CSRCost = 0;
    return;
  }
  uint64_t FixedEntry = 1 << 14;
  if (ActualEntry < FixedEntry)
    CSRCost *= BranchProbability(ActualEntry, FixedEntry);
  else if (ActualEntry <= UINT32_MAX)
    // Invert the fraction and divide.
    CSRCost /= BranchProbability(FixedEntry, ActualEntry);
  else
    // Can't use BranchProbability in general, since it takes 32-bit numbers.
    CSRCost = CSRCost.getFrequency() * (ActualEntry / FixedEntry);
}

/// Collect the hint info for \p Reg.
/// The results are stored into \p Out.
/// \p Out is not cleared before being populated.
void RAGreedy::collectHintInfo(Register Reg, HintsInfo &Out) {
  for (const MachineInstr &Instr : MRI->reg_nodbg_instructions(Reg)) {
    if (!Instr.isFullCopy())
      continue;
    // Look for the other end of the copy.
    Register OtherReg = Instr.getOperand(0).getReg();
    if (OtherReg == Reg) {
      OtherReg = Instr.getOperand(1).getReg();
      if (OtherReg == Reg)
        continue;
    }
    // Get the current assignment.
    MCRegister OtherPhysReg =
        OtherReg.isPhysical() ? OtherReg.asMCReg() : VRM->getPhys(OtherReg);
    // Push the collected information.
    Out.push_back(HintInfo(MBFI->getBlockFreq(Instr.getParent()), OtherReg,
                           OtherPhysReg));
  }
}

/// Using the given \p List, compute the cost of the broken hints if
/// \p PhysReg was used.
/// \return The cost of \p List for \p PhysReg.
BlockFrequency RAGreedy::getBrokenHintFreq(const HintsInfo &List,
                                           MCRegister PhysReg) {
  BlockFrequency Cost = 0;
  for (const HintInfo &Info : List) {
    if (Info.PhysReg != PhysReg)
      Cost += Info.Freq;
  }
  return Cost;
}

/// Using the register assigned to \p VirtReg, try to recolor
/// all the live ranges that are copy-related with \p VirtReg.
/// The recoloring is then propagated to all the live-ranges that have
/// been recolored and so on, until no more copies can be coalesced or
/// it is not profitable.
/// For a given live range, profitability is determined by the sum of the
/// frequencies of the non-identity copies it would introduce with the old
/// and new register.
void RAGreedy::tryHintRecoloring(LiveInterval &VirtReg) {
  // We have a broken hint, check if it is possible to fix it by
  // reusing PhysReg for the copy-related live-ranges. Indeed, we evicted
  // some register and PhysReg may be available for the other live-ranges.
  SmallSet<Register, 4> Visited;
  SmallVector<unsigned, 2> RecoloringCandidates;
  HintsInfo Info;
  Register Reg = VirtReg.reg();
  MCRegister PhysReg = VRM->getPhys(Reg);
  // Start the recoloring algorithm from the input live-interval, then
  // it will propagate to the ones that are copy-related with it.
  Visited.insert(Reg);
  RecoloringCandidates.push_back(Reg);

  LLVM_DEBUG(dbgs() << "Trying to reconcile hints for: " << printReg(Reg, TRI)
                    << '(' << printReg(PhysReg, TRI) << ")\n");

  do {
    Reg = RecoloringCandidates.pop_back_val();

    // We cannot recolor physical register.
    if (Register::isPhysicalRegister(Reg))
      continue;

    assert(VRM->hasPhys(Reg) && "We have unallocated variable!!");

    // Get the live interval mapped with this virtual register to be able
    // to check for the interference with the new color.
    LiveInterval &LI = LIS->getInterval(Reg);
    MCRegister CurrPhys = VRM->getPhys(Reg);
    // Check that the new color matches the register class constraints and
    // that it is free for this live range.
    if (CurrPhys != PhysReg && (!MRI->getRegClass(Reg)->contains(PhysReg) ||
                                Matrix->checkInterference(LI, PhysReg)))
      continue;

    LLVM_DEBUG(dbgs() << printReg(Reg, TRI) << '(' << printReg(CurrPhys, TRI)
                      << ") is recolorable.\n");

    // Gather the hint info.
    Info.clear();
    collectHintInfo(Reg, Info);
    // Check if recoloring the live-range will increase the cost of the
    // non-identity copies.
    if (CurrPhys != PhysReg) {
      LLVM_DEBUG(dbgs() << "Checking profitability:\n");
      BlockFrequency OldCopiesCost = getBrokenHintFreq(Info, CurrPhys);
      BlockFrequency NewCopiesCost = getBrokenHintFreq(Info, PhysReg);
      LLVM_DEBUG(dbgs() << "Old Cost: " << OldCopiesCost.getFrequency()
                        << "\nNew Cost: " << NewCopiesCost.getFrequency()
                        << '\n');
      if (OldCopiesCost < NewCopiesCost) {
        LLVM_DEBUG(dbgs() << "=> Not profitable.\n");
        continue;
      }
      // At this point, the cost is either cheaper or equal. If it is
      // equal, we consider this is profitable because it may expose
      // more recoloring opportunities.
      LLVM_DEBUG(dbgs() << "=> Profitable.\n");
      // Recolor the live-range.
      Matrix->unassign(LI);
      Matrix->assign(LI, PhysReg);
    }
    // Push all copy-related live-ranges to keep reconciling the broken
    // hints.
    for (const HintInfo &HI : Info) {
      if (Visited.insert(HI.Reg).second)
        RecoloringCandidates.push_back(HI.Reg);
    }
  } while (!RecoloringCandidates.empty());
}

/// Try to recolor broken hints.
/// Broken hints may be repaired by recoloring when an evicted variable
/// freed up a register for a larger live-range.
/// Consider the following example:
/// BB1:
///   a =
///   b =
/// BB2:
///   ...
///   = b
///   = a
/// Let us assume b gets split:
/// BB1:
///   a =
///   b =
/// BB2:
///   c = b
///   ...
///   d = c
///   = d
///   = a
/// Because of how the allocation work, b, c, and d may be assigned different
/// colors. Now, if a gets evicted later:
/// BB1:
///   a =
///   st a, SpillSlot
///   b =
/// BB2:
///   c = b
///   ...
///   d = c
///   = d
///   e = ld SpillSlot
///   = e
/// This is likely that we can assign the same register for b, c, and d,
/// getting rid of 2 copies.
void RAGreedy::tryHintsRecoloring() {
  for (LiveInterval *LI : SetOfBrokenHints) {
    assert(Register::isVirtualRegister(LI->reg()) &&
           "Recoloring is possible only for virtual registers");
    // Some dead defs may be around (e.g., because of debug uses).
    // Ignore those.
    if (!VRM->hasPhys(LI->reg()))
      continue;
    tryHintRecoloring(*LI);
  }
}

MCRegister RAGreedy::selectOrSplitImpl(LiveInterval &VirtReg,
                                       SmallVectorImpl<Register> &NewVRegs,
                                       SmallVirtRegSet &FixedRegisters,
                                       unsigned Depth) {
  uint8_t CostPerUseLimit = uint8_t(~0u);
  // First try assigning a free register.
  auto Order =
      AllocationOrder::create(VirtReg.reg(), *VRM, RegClassInfo, Matrix);
  if (MCRegister PhysReg =
          tryAssign(VirtReg, Order, NewVRegs, FixedRegisters)) {
    // If VirtReg got an assignment, the eviction info is no longer relevant.
    LastEvicted.clearEvicteeInfo(VirtReg.reg());
    // When NewVRegs is not empty, we may have made decisions such as evicting
    // a virtual register, go with the earlier decisions and use the physical
    // register.
    if (CSRCost.getFrequency() && isUnusedCalleeSavedReg(PhysReg) &&
        NewVRegs.empty()) {
      MCRegister CSRReg = tryAssignCSRFirstTime(VirtReg, Order, PhysReg,
                                                CostPerUseLimit, NewVRegs);
      if (CSRReg || !NewVRegs.empty())
        // Return now if we decide to use a CSR or create new vregs due to
        // pre-splitting.
        return CSRReg;
    } else
      return PhysReg;
  }

  LiveRangeStage Stage = getStage(VirtReg);
  LLVM_DEBUG(dbgs() << StageName[Stage] << " Cascade "
                    << ExtraRegInfo[VirtReg.reg()].Cascade << '\n');

  // Try to evict a less worthy live range, but only for ranges from the primary
  // queue. The RS_Split ranges already failed to do this, and they should not
  // get a second chance until they have been split.
  if (Stage != RS_Split)
    if (Register PhysReg =
            tryEvict(VirtReg, Order, NewVRegs, CostPerUseLimit,
                     FixedRegisters)) {
      Register Hint = MRI->getSimpleHint(VirtReg.reg());
      // If VirtReg has a hint and that hint is broken record this
      // virtual register as a recoloring candidate for broken hint.
      // Indeed, since we evicted a variable in its neighborhood it is
      // likely we can at least partially recolor some of the
      // copy-related live-ranges.
      if (Hint && Hint != PhysReg)
        SetOfBrokenHints.insert(&VirtReg);
      // If VirtReg eviction someone, the eviction info for it as an evictee is
      // no longer relevant.
      LastEvicted.clearEvicteeInfo(VirtReg.reg());
      return PhysReg;
    }

  assert((NewVRegs.empty() || Depth) && "Cannot append to existing NewVRegs");

  // The first time we see a live range, don't try to split or spill.
  // Wait until the second time, when all smaller ranges have been allocated.
  // This gives a better picture of the interference to split around.
  if (Stage < RS_Split) {
    setStage(VirtReg, RS_Split);
    LLVM_DEBUG(dbgs() << "wait for second round\n");
    NewVRegs.push_back(VirtReg.reg());
    return 0;
  }

  if (Stage < RS_Spill) {
    // Try splitting VirtReg or interferences.
    unsigned NewVRegSizeBefore = NewVRegs.size();
    Register PhysReg = trySplit(VirtReg, Order, NewVRegs, FixedRegisters);
    if (PhysReg || (NewVRegs.size() - NewVRegSizeBefore)) {
      // If VirtReg got split, the eviction info is no longer relevant.
      LastEvicted.clearEvicteeInfo(VirtReg.reg());
      return PhysReg;
    }
  }

  // If we couldn't allocate a register from spilling, there is probably some
  // invalid inline assembly. The base class will report it.
  if (Stage >= RS_Done || !VirtReg.isSpillable())
    return tryLastChanceRecoloring(VirtReg, Order, NewVRegs, FixedRegisters,
                                   Depth);

  // Finally spill VirtReg itself.
  if ((EnableDeferredSpilling ||
       TRI->shouldUseDeferredSpillingForVirtReg(*MF, VirtReg)) &&
      getStage(VirtReg) < RS_Memory) {
    // TODO: This is experimental and in particular, we do not model
    // the live range splitting done by spilling correctly.
    // We would need a deep integration with the spiller to do the
    // right thing here. Anyway, that is still good for early testing.
    setStage(VirtReg, RS_Memory);
    LLVM_DEBUG(dbgs() << "Do as if this register is in memory\n");
    NewVRegs.push_back(VirtReg.reg());
  } else {
    NamedRegionTimer T("spill", "Spiller", TimerGroupName,
                       TimerGroupDescription, TimePassesIsEnabled);
    LiveRangeEdit LRE(&VirtReg, NewVRegs, *MF, *LIS, VRM, this, &DeadRemats);
    spiller().spill(LRE);
    setStage(NewVRegs.begin(), NewVRegs.end(), RS_Done);

    // Tell LiveDebugVariables about the new ranges. Ranges not being covered by
    // the new regs are kept in LDV (still mapping to the old register), until
    // we rewrite spilled locations in LDV at a later stage.
    DebugVars->splitRegister(VirtReg.reg(), LRE.regs(), *LIS);

    if (VerifyEnabled)
      MF->verify(this, "After spilling");
  }

  // The live virtual register requesting allocation was spilled, so tell
  // the caller not to allocate anything during this round.
  return 0;
}

void RAGreedy::RAGreedyStats::report(MachineOptimizationRemarkMissed &R) {
  using namespace ore;
  if (Spills) {
    R << NV("NumSpills", Spills) << " spills ";
    R << NV("TotalSpillsCost", SpillsCost) << " total spills cost ";
  }
  if (FoldedSpills) {
    R << NV("NumFoldedSpills", FoldedSpills) << " folded spills ";
    R << NV("TotalFoldedSpillsCost", FoldedSpillsCost)
      << " total folded spills cost ";
  }
  if (Reloads) {
    R << NV("NumReloads", Reloads) << " reloads ";
    R << NV("TotalReloadsCost", ReloadsCost) << " total reloads cost ";
  }
  if (FoldedReloads) {
    R << NV("NumFoldedReloads", FoldedReloads) << " folded reloads ";
    R << NV("TotalFoldedReloadsCost", FoldedReloadsCost)
      << " total folded reloads cost ";
  }
  if (ZeroCostFoldedReloads)
    R << NV("NumZeroCostFoldedReloads", ZeroCostFoldedReloads)
      << " zero cost folded reloads ";
  if (Copies) {
    R << NV("NumVRCopies", Copies) << " virtual registers copies ";
    R << NV("TotalCopiesCost", CopiesCost) << " total copies cost ";
  }
}

RAGreedy::RAGreedyStats RAGreedy::computeStats(MachineBasicBlock &MBB) {
  RAGreedyStats Stats;
  const MachineFrameInfo &MFI = MF->getFrameInfo();
  int FI;

  auto isSpillSlotAccess = [&MFI](const MachineMemOperand *A) {
    return MFI.isSpillSlotObjectIndex(cast<FixedStackPseudoSourceValue>(
        A->getPseudoValue())->getFrameIndex());
  };
  auto isPatchpointInstr = [](const MachineInstr &MI) {
    return MI.getOpcode() == TargetOpcode::PATCHPOINT ||
           MI.getOpcode() == TargetOpcode::STACKMAP ||
           MI.getOpcode() == TargetOpcode::STATEPOINT;
  };
  for (MachineInstr &MI : MBB) {
    if (MI.isCopy()) {
      MachineOperand &Dest = MI.getOperand(0);
      MachineOperand &Src = MI.getOperand(1);
      if (Dest.isReg() && Src.isReg() && Dest.getReg().isVirtual() &&
          Src.getReg().isVirtual())
        ++Stats.Copies;
      continue;
    }

    SmallVector<const MachineMemOperand *, 2> Accesses;
    if (TII->isLoadFromStackSlot(MI, FI) && MFI.isSpillSlotObjectIndex(FI)) {
      ++Stats.Reloads;
      continue;
    }
    if (TII->isStoreToStackSlot(MI, FI) && MFI.isSpillSlotObjectIndex(FI)) {
      ++Stats.Spills;
      continue;
    }
    if (TII->hasLoadFromStackSlot(MI, Accesses) &&
        llvm::any_of(Accesses, isSpillSlotAccess)) {
      if (!isPatchpointInstr(MI)) {
        Stats.FoldedReloads += Accesses.size();
        continue;
      }
      // For statepoint there may be folded and zero cost folded stack reloads.
      std::pair<unsigned, unsigned> NonZeroCostRange =
          TII->getPatchpointUnfoldableRange(MI);
      SmallSet<unsigned, 16> FoldedReloads;
      SmallSet<unsigned, 16> ZeroCostFoldedReloads;
      for (unsigned Idx = 0, E = MI.getNumOperands(); Idx < E; ++Idx) {
        MachineOperand &MO = MI.getOperand(Idx);
        if (!MO.isFI() || !MFI.isSpillSlotObjectIndex(MO.getIndex()))
          continue;
        if (Idx >= NonZeroCostRange.first && Idx < NonZeroCostRange.second)
          FoldedReloads.insert(MO.getIndex());
        else
          ZeroCostFoldedReloads.insert(MO.getIndex());
      }
      // If stack slot is used in folded reload it is not zero cost then.
      for (unsigned Slot : FoldedReloads)
        ZeroCostFoldedReloads.erase(Slot);
      Stats.FoldedReloads += FoldedReloads.size();
      Stats.ZeroCostFoldedReloads += ZeroCostFoldedReloads.size();
      continue;
    }
    Accesses.clear();
    if (TII->hasStoreToStackSlot(MI, Accesses) &&
        llvm::any_of(Accesses, isSpillSlotAccess)) {
      Stats.FoldedSpills += Accesses.size();
    }
  }
  // Set cost of collected statistic by multiplication to relative frequency of
  // this basic block.
  float RelFreq = MBFI->getBlockFreqRelativeToEntryBlock(&MBB);
  Stats.ReloadsCost = RelFreq * Stats.Reloads;
  Stats.FoldedReloadsCost = RelFreq * Stats.FoldedReloads;
  Stats.SpillsCost = RelFreq * Stats.Spills;
  Stats.FoldedSpillsCost = RelFreq * Stats.FoldedSpills;
  Stats.CopiesCost = RelFreq * Stats.Copies;
  return Stats;
}

RAGreedy::RAGreedyStats RAGreedy::reportStats(MachineLoop *L) {
  RAGreedyStats Stats;

  // Sum up the spill and reloads in subloops.
  for (MachineLoop *SubLoop : *L)
    Stats.add(reportStats(SubLoop));

  for (MachineBasicBlock *MBB : L->getBlocks())
    // Handle blocks that were not included in subloops.
    if (Loops->getLoopFor(MBB) == L)
      Stats.add(computeStats(*MBB));

  if (!Stats.isEmpty()) {
    using namespace ore;

    ORE->emit([&]() {
      MachineOptimizationRemarkMissed R(DEBUG_TYPE, "LoopSpillReloadCopies",
                                        L->getStartLoc(), L->getHeader());
      Stats.report(R);
      R << "generated in loop";
      return R;
    });
  }
  return Stats;
}

void RAGreedy::reportStats() {
  if (!ORE->allowExtraAnalysis(DEBUG_TYPE))
    return;
  RAGreedyStats Stats;
  for (MachineLoop *L : *Loops)
    Stats.add(reportStats(L));
  // Process non-loop blocks.
  for (MachineBasicBlock &MBB : *MF)
    if (!Loops->getLoopFor(&MBB))
      Stats.add(computeStats(MBB));
  if (!Stats.isEmpty()) {
    using namespace ore;

    ORE->emit([&]() {
      DebugLoc Loc;
      if (auto *SP = MF->getFunction().getSubprogram())
        Loc = DILocation::get(SP->getContext(), SP->getLine(), 1, SP);
      MachineOptimizationRemarkMissed R(DEBUG_TYPE, "SpillReloadCopies", Loc,
                                        &MF->front());
      Stats.report(R);
      R << "generated in function";
      return R;
    });
  }
}

bool RAGreedy::runOnMachineFunction(MachineFunction &mf) {
  LLVM_DEBUG(dbgs() << "********** GREEDY REGISTER ALLOCATION **********\n"
                    << "********** Function: " << mf.getName() << '\n');

  MF = &mf;
  TRI = MF->getSubtarget().getRegisterInfo();
  TII = MF->getSubtarget().getInstrInfo();
  RCI.runOnMachineFunction(mf);

  EnableLocalReassign = EnableLocalReassignment ||
                        MF->getSubtarget().enableRALocalReassignment(
                            MF->getTarget().getOptLevel());

  EnableAdvancedRASplitCost =
      ConsiderLocalIntervalCost.getNumOccurrences()
          ? ConsiderLocalIntervalCost
          : MF->getSubtarget().enableAdvancedRASplitCost();

  if (VerifyEnabled)
    MF->verify(this, "Before greedy register allocator");

  RegAllocBase::init(getAnalysis<VirtRegMap>(),
                     getAnalysis<LiveIntervals>(),
                     getAnalysis<LiveRegMatrix>());
  Indexes = &getAnalysis<SlotIndexes>();
  MBFI = &getAnalysis<MachineBlockFrequencyInfo>();
  DomTree = &getAnalysis<MachineDominatorTree>();
  ORE = &getAnalysis<MachineOptimizationRemarkEmitterPass>().getORE();
  Loops = &getAnalysis<MachineLoopInfo>();
  Bundles = &getAnalysis<EdgeBundles>();
  SpillPlacer = &getAnalysis<SpillPlacement>();
  DebugVars = &getAnalysis<LiveDebugVariables>();
  AA = &getAnalysis<AAResultsWrapperPass>().getAAResults();

  initializeCSRCost();

  RegCosts = TRI->getRegisterCosts(*MF);

  VRAI = std::make_unique<VirtRegAuxInfo>(*MF, *LIS, *VRM, *Loops, *MBFI);
  SpillerInstance.reset(createInlineSpiller(*this, *MF, *VRM, *VRAI));

  VRAI->calculateSpillWeightsAndHints();

  LLVM_DEBUG(LIS->dump());

  SA.reset(new SplitAnalysis(*VRM, *LIS, *Loops));
  SE.reset(new SplitEditor(*SA, *AA, *LIS, *VRM, *DomTree, *MBFI, *VRAI));
  ExtraRegInfo.clear();
  ExtraRegInfo.resize(MRI->getNumVirtRegs());
  NextCascade = 1;
  IntfCache.init(MF, Matrix->getLiveUnions(), Indexes, LIS, TRI);
  GlobalCand.resize(32);  // This will grow as needed.
  SetOfBrokenHints.clear();
  LastEvicted.clear();

  allocatePhysRegs();
  tryHintsRecoloring();

  if (VerifyEnabled)
    MF->verify(this, "Before post optimization");
  postOptimization();
  reportStats();

  releaseMemory();
  return true;
}
