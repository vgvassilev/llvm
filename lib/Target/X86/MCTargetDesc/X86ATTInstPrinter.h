//=- X86ATTInstPrinter.h - Convert X86 MCInst to assembly syntax --*- C++ -*-=//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This class prints an X86 MCInst to AT&T style .s file syntax.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_X86_MCTARGETDESC_X86ATTINSTPRINTER_H
#define LLVM_LIB_TARGET_X86_MCTARGETDESC_X86ATTINSTPRINTER_H

#include "X86InstPrinterCommon.h"

namespace llvm {

class X86ATTInstPrinter final : public X86InstPrinterCommon {
public:
  X86ATTInstPrinter(const MCAsmInfo &MAI, const MCInstrInfo &MII,
                    const MCRegisterInfo &MRI)
      : X86InstPrinterCommon(MAI, MII, MRI), HasCustomInstComment(false) {}

  void printRegName(raw_ostream &OS, unsigned RegNo) const override;
  void printInst(const MCInst *MI, uint64_t Address, StringRef Annot,
                 const MCSubtargetInfo &STI, raw_ostream &OS) override;
  bool printVecCompareInstr(const MCInst *MI, raw_ostream &OS);

  // Autogenerated by tblgen, returns true if we successfully printed an
  // alias.
  bool printAliasInstr(const MCInst *MI, raw_ostream &OS);
  void printCustomAliasOperand(const MCInst *MI, unsigned OpIdx,
                               unsigned PrintMethodIdx, raw_ostream &O);

  // Autogenerated by tblgen.
  void printInstruction(const MCInst *MI, raw_ostream &OS);
  static const char *getRegisterName(unsigned RegNo);

  void printOperand(const MCInst *MI, unsigned OpNo, raw_ostream &OS) override;
  void printMemReference(const MCInst *MI, unsigned Op, raw_ostream &OS);
  void printMemOffset(const MCInst *MI, unsigned OpNo, raw_ostream &OS);
  void printSrcIdx(const MCInst *MI, unsigned Op, raw_ostream &O);
  void printDstIdx(const MCInst *MI, unsigned Op, raw_ostream &O);
  void printU8Imm(const MCInst *MI, unsigned Op, raw_ostream &OS);
  void printSTiRegOperand(const MCInst *MI, unsigned OpNo, raw_ostream &OS);

  void printanymem(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemReference(MI, OpNo, O);
  }
  void printopaquemem(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemReference(MI, OpNo, O);
  }

  void printbytemem(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemReference(MI, OpNo, O);
  }
  void printwordmem(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemReference(MI, OpNo, O);
  }
  void printdwordmem(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemReference(MI, OpNo, O);
  }
  void printqwordmem(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemReference(MI, OpNo, O);
  }
  void printxmmwordmem(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemReference(MI, OpNo, O);
  }
  void printymmwordmem(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemReference(MI, OpNo, O);
  }
  void printzmmwordmem(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemReference(MI, OpNo, O);
  }
  void printtbytemem(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemReference(MI, OpNo, O);
  }

  void printSrcIdx8(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printSrcIdx(MI, OpNo, O);
  }
  void printSrcIdx16(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printSrcIdx(MI, OpNo, O);
  }
  void printSrcIdx32(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printSrcIdx(MI, OpNo, O);
  }
  void printSrcIdx64(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printSrcIdx(MI, OpNo, O);
  }
  void printDstIdx8(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printDstIdx(MI, OpNo, O);
  }
  void printDstIdx16(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printDstIdx(MI, OpNo, O);
  }
  void printDstIdx32(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printDstIdx(MI, OpNo, O);
  }
  void printDstIdx64(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printDstIdx(MI, OpNo, O);
  }
  void printMemOffs8(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemOffset(MI, OpNo, O);
  }
  void printMemOffs16(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemOffset(MI, OpNo, O);
  }
  void printMemOffs32(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemOffset(MI, OpNo, O);
  }
  void printMemOffs64(const MCInst *MI, unsigned OpNo, raw_ostream &O) {
    printMemOffset(MI, OpNo, O);
  }

private:
  bool HasCustomInstComment;
};

} // end namespace llvm

#endif // LLVM_LIB_TARGET_X86_MCTARGETDESC_X86ATTINSTPRINTER_H
