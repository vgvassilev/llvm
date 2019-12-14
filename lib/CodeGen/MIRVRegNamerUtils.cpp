//===---------- MIRVRegNamerUtils.cpp - MIR VReg Renaming Utilities -------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MIRVRegNamerUtils.h"
#include "llvm/Support/Debug.h"

using namespace llvm;

#define DEBUG_TYPE "mir-vregnamer-utils"

using VRegRenameMap = std::map<unsigned, unsigned>;

bool VRegRenamer::doVRegRenaming(const VRegRenameMap &VRM) {
  bool Changed = false;

  for (const auto &E : VRM) {
    Changed = Changed || !MRI.reg_empty(E.first);
    MRI.replaceRegWith(E.first, E.second);
  }

  return Changed;
}

VRegRenameMap
VRegRenamer::getVRegRenameMap(const std::vector<NamedVReg> &VRegs) {

  StringMap<unsigned> VRegNameCollisionMap;

  auto GetUniqueVRegName = [&VRegNameCollisionMap](const NamedVReg &Reg) {
    if (VRegNameCollisionMap.find(Reg.getName()) == VRegNameCollisionMap.end())
      VRegNameCollisionMap[Reg.getName()] = 0;
    const unsigned Counter = ++VRegNameCollisionMap[Reg.getName()];
    return Reg.getName() + "__" + std::to_string(Counter);
  };

  VRegRenameMap VRM;
  for (const auto &VReg : VRegs) {
    const unsigned Reg = VReg.getReg();
    VRM[Reg] = createVirtualRegisterWithLowerName(Reg, GetUniqueVRegName(VReg));
  }
  return VRM;
}

std::string VRegRenamer::getInstructionOpcodeHash(MachineInstr &MI) {
  std::string S;
  raw_string_ostream OS(S);

  // Gets a hashable artifact from a given MachineOperand (ie an unsigned).
  auto GetHashableMO = [this](const MachineOperand &MO) -> unsigned {
    switch (MO.getType()) {
    case MachineOperand::MO_Immediate:
      return MO.getImm();
    case MachineOperand::MO_TargetIndex:
      return MO.getOffset() | (MO.getTargetFlags() << 16);
    case MachineOperand::MO_Register:
      if (Register::isVirtualRegister(MO.getReg()))
        return MRI.getVRegDef(MO.getReg())->getOpcode();
      return MO.getReg();

    // We could explicitly handle all the types of the MachineOperand,
    // here but we can just return a common number until we find a
    // compelling test case where this is bad. The only side effect here
    // is contributing to a hash collision but there's enough information
    // (Opcodes,other registers etc) that this will likely not be a problem.

    // TODO: Handle the following Immediate/Index/ID/Predicate cases. They can
    // be hashed on in a stable manner.
    case MachineOperand::MO_CImmediate:
    case MachineOperand::MO_FPImmediate:
    case MachineOperand::MO_FrameIndex:
    case MachineOperand::MO_ConstantPoolIndex:
    case MachineOperand::MO_JumpTableIndex:
    case MachineOperand::MO_CFIIndex:
    case MachineOperand::MO_IntrinsicID:
    case MachineOperand::MO_Predicate:

    // In the cases below we havn't found a way to produce an artifact that will
    // result in a stable hash, in most cases because they are pointers. We want
    // stable hashes because we want the hash to be the same run to run.
    case MachineOperand::MO_MachineBasicBlock:
    case MachineOperand::MO_ExternalSymbol:
    case MachineOperand::MO_GlobalAddress:
    case MachineOperand::MO_BlockAddress:
    case MachineOperand::MO_RegisterMask:
    case MachineOperand::MO_RegisterLiveOut:
    case MachineOperand::MO_Metadata:
    case MachineOperand::MO_MCSymbol:
    case MachineOperand::MO_ShuffleMask:
      return 0;
    }
    llvm_unreachable("Unexpected MachineOperandType.");
  };

  SmallVector<unsigned, 16> MIOperands = {MI.getOpcode(), MI.getFlags()};
  llvm::transform(MI.uses(), std::back_inserter(MIOperands), GetHashableMO);

  for (const auto *Op : MI.memoperands()) {
    MIOperands.push_back((unsigned)Op->getSize());
    MIOperands.push_back((unsigned)Op->getFlags());
    MIOperands.push_back((unsigned)Op->getOffset());
    MIOperands.push_back((unsigned)Op->getOrdering());
    MIOperands.push_back((unsigned)Op->getAddrSpace());
    MIOperands.push_back((unsigned)Op->getSyncScopeID());
    MIOperands.push_back((unsigned)Op->getBaseAlignment());
    MIOperands.push_back((unsigned)Op->getFailureOrdering());
  }

  auto HashMI = hash_combine_range(MIOperands.begin(), MIOperands.end());
  return std::to_string(HashMI).substr(0, 5);
}

unsigned VRegRenamer::createVirtualRegister(unsigned VReg) {
  assert(Register::isVirtualRegister(VReg) && "Expected Virtual Registers");
  std::string Name = getInstructionOpcodeHash(*MRI.getVRegDef(VReg));
  return createVirtualRegisterWithLowerName(VReg, Name);
}

bool VRegRenamer::renameInstsInMBB(MachineBasicBlock *MBB) {
  std::vector<NamedVReg> VRegs;
  std::string Prefix = "bb" + std::to_string(CurrentBBNumber) + "_";
  for (MachineInstr &Candidate : *MBB) {
    // Don't rename stores/branches.
    if (Candidate.mayStore() || Candidate.isBranch())
      continue;
    if (!Candidate.getNumOperands())
      continue;
    // Look for instructions that define VRegs in operand 0.
    MachineOperand &MO = Candidate.getOperand(0);
    // Avoid non regs, instructions defining physical regs.
    if (!MO.isReg() || !Register::isVirtualRegister(MO.getReg()))
      continue;
    VRegs.push_back(
        NamedVReg(MO.getReg(), Prefix + getInstructionOpcodeHash(Candidate)));
  }

  return VRegs.size() ? doVRegRenaming(getVRegRenameMap(VRegs)) : false;
}

unsigned VRegRenamer::createVirtualRegisterWithLowerName(unsigned VReg,
                                                         StringRef Name) {
  std::string LowerName = Name.lower();
  const TargetRegisterClass *RC = MRI.getRegClassOrNull(VReg);
  return RC ? MRI.createVirtualRegister(RC, LowerName)
            : MRI.createGenericVirtualRegister(MRI.getType(VReg), LowerName);
}
