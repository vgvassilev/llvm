//===- ARCSubtarget.h - Define Subtarget for the ARC ------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares the ARC specific subclass of TargetSubtargetInfo.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_ARC_ARCSUBTARGET_H
#define LLVM_LIB_TARGET_ARC_ARCSUBTARGET_H

#include "ARCFrameLowering.h"
#include "ARCISelLowering.h"
#include "ARCInstrInfo.h"
#include "llvm/CodeGen/SelectionDAGTargetInfo.h"
#include "llvm/Target/TargetSubtargetInfo.h"
#include <string>

#define GET_SUBTARGETINFO_HEADER
#include "ARCGenSubtargetInfo.inc"

namespace llvm {

class StringRef;
class TargetMachine;

class ARCSubtarget : public ARCGenSubtargetInfo {
  virtual void anchor();
  ARCInstrInfo InstrInfo;
  ARCFrameLowering FrameLowering;
  ARCTargetLowering TLInfo;
  SelectionDAGTargetInfo TSInfo;

public:
  /// This constructor initializes the data members to match that
  /// of the specified triple.
  ARCSubtarget(const Triple &TT, const std::string &CPU, const std::string &FS,
               const TargetMachine &TM);

  /// Parses features string setting specified subtarget options.
  /// Definition of function is auto generated by tblgen.
  void ParseSubtargetFeatures(StringRef CPU, StringRef FS);

  const ARCInstrInfo *getInstrInfo() const override { return &InstrInfo; }
  const ARCFrameLowering *getFrameLowering() const override {
    return &FrameLowering;
  }
  const ARCTargetLowering *getTargetLowering() const override {
    return &TLInfo;
  }
  const ARCRegisterInfo *getRegisterInfo() const override {
    return &InstrInfo.getRegisterInfo();
  }
  const SelectionDAGTargetInfo *getSelectionDAGInfo() const override {
    return &TSInfo;
  }
};

} // end namespace llvm

#endif // LLVM_LIB_TARGET_ARC_ARCSUBTARGET_H
