//===-- CSKYInstPrinter.h - Convert CSKY MCInst to asm syntax ---*- C++ -*----//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This class prints a CSKY MCInst to a .s file.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_CSKY_MCTARGETDESC_CSKYINSTPRINTER_H
#define LLVM_LIB_TARGET_CSKY_MCTARGETDESC_CSKYINSTPRINTER_H

#include "MCTargetDesc/CSKYMCTargetDesc.h"
#include "llvm/MC/MCInstPrinter.h"

namespace llvm {

class CSKYInstPrinter : public MCInstPrinter {
public:
  CSKYInstPrinter(const MCAsmInfo &MAI, const MCInstrInfo &MII,
                  const MCRegisterInfo &MRI)
      : MCInstPrinter(MAI, MII, MRI) {}

  bool applyTargetSpecificCLOption(StringRef Opt) override;

  void printInst(const MCInst *MI, uint64_t Address, StringRef Annot,
                 const MCSubtargetInfo &STI, raw_ostream &O) override;
  void printRegName(raw_ostream &O, unsigned RegNo) const override;

  void printOperand(const MCInst *MI, unsigned OpNo, const MCSubtargetInfo &STI,
                    raw_ostream &O, const char *Modifier = nullptr);

  // Autogenerated by tblgen.
  std::pair<const char *, uint64_t> getMnemonic(const MCInst *MI) override;
  void printInstruction(const MCInst *MI, uint64_t Address,
                        const MCSubtargetInfo &STI, raw_ostream &O);
  bool printAliasInstr(const MCInst *MI, uint64_t Address,
                       const MCSubtargetInfo &STI, raw_ostream &O);
  void printCustomAliasOperand(const MCInst *MI, uint64_t Address,
                               unsigned OpIdx, unsigned PrintMethodIdx,
                               const MCSubtargetInfo &STI, raw_ostream &O);

  static const char *getRegisterName(unsigned RegNo);
  static const char *getRegisterName(unsigned RegNo, unsigned AltIdx);
};

} // namespace llvm

#endif // LLVM_LIB_TARGET_CSKY_MCTARGETDESC_CSKYINSTPRINTER_H
