//===-- ConstantFolding.h - Fold instructions into constants ----*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file declares routines for folding instructions into constants when all
// operands are constants, for example "sub i32 1, 0" -> "1".
//
// Also, to supplement the basic VMCore ConstantExpr simplifications,
// this file declares some additional folding routines that can make use of
// DataLayout information. These functions cannot go in VMCore due to library
// dependency issues.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_ANALYSIS_CONSTANTFOLDING_H
#define LLVM_ANALYSIS_CONSTANTFOLDING_H

namespace llvm {
class APInt;
template <typename T> class ArrayRef;
class CallBase;
class Constant;
class ConstantExpr;
class DSOLocalEquivalent;
class DataLayout;
class Function;
class GlobalValue;
class Instruction;
class TargetLibraryInfo;
class Type;

/// If this constant is a constant offset from a global, return the global and
/// the constant. Because of constantexprs, this function is recursive.
/// If the global is part of a dso_local_equivalent constant, return it through
/// `Equiv` if it is provided.
bool IsConstantOffsetFromGlobal(Constant *C, GlobalValue *&GV, APInt &Offset,
                                const DataLayout &DL,
                                DSOLocalEquivalent **DSOEquiv = nullptr);

/// ConstantFoldInstruction - Try to constant fold the specified instruction.
/// If successful, the constant result is returned, if not, null is returned.
/// Note that this fails if not all of the operands are constant.  Otherwise,
/// this function can only fail when attempting to fold instructions like loads
/// and stores, which have no constant expression form.
Constant *ConstantFoldInstruction(Instruction *I, const DataLayout &DL,
                                  const TargetLibraryInfo *TLI = nullptr);

/// ConstantFoldConstant - Fold the constant using the specified DataLayout.
/// This function always returns a non-null constant: Either the folding result,
/// or the original constant if further folding is not possible.
Constant *ConstantFoldConstant(const Constant *C, const DataLayout &DL,
                               const TargetLibraryInfo *TLI = nullptr);

/// ConstantFoldInstOperands - Attempt to constant fold an instruction with the
/// specified operands.  If successful, the constant result is returned, if not,
/// null is returned.  Note that this function can fail when attempting to
/// fold instructions like loads and stores, which have no constant expression
/// form.
///
Constant *ConstantFoldInstOperands(Instruction *I, ArrayRef<Constant *> Ops,
                                   const DataLayout &DL,
                                   const TargetLibraryInfo *TLI = nullptr);

/// ConstantFoldCompareInstOperands - Attempt to constant fold a compare
/// instruction (icmp/fcmp) with the specified operands.  If it fails, it
/// returns a constant expression of the specified operands.
///
Constant *
ConstantFoldCompareInstOperands(unsigned Predicate, Constant *LHS,
                                Constant *RHS, const DataLayout &DL,
                                const TargetLibraryInfo *TLI = nullptr);

/// Attempt to constant fold a unary operation with the specified
/// operand. If it fails, it returns a constant expression of the specified
/// operands.
Constant *ConstantFoldUnaryOpOperand(unsigned Opcode, Constant *Op,
                                     const DataLayout &DL);

/// Attempt to constant fold a binary operation with the specified
/// operands.  If it fails, it returns a constant expression of the specified
/// operands.
Constant *ConstantFoldBinaryOpOperands(unsigned Opcode, Constant *LHS,
                                       Constant *RHS, const DataLayout &DL);

/// Attempt to constant fold a select instruction with the specified
/// operands. The constant result is returned if successful; if not, null is
/// returned.
Constant *ConstantFoldSelectInstruction(Constant *Cond, Constant *V1,
                                        Constant *V2);

/// Attempt to constant fold a cast with the specified operand.  If it
/// fails, it returns a constant expression of the specified operand.
Constant *ConstantFoldCastOperand(unsigned Opcode, Constant *C, Type *DestTy,
                                  const DataLayout &DL);

/// ConstantFoldInsertValueInstruction - Attempt to constant fold an insertvalue
/// instruction with the specified operands and indices.  The constant result is
/// returned if successful; if not, null is returned.
Constant *ConstantFoldInsertValueInstruction(Constant *Agg, Constant *Val,
                                             ArrayRef<unsigned> Idxs);

/// Attempt to constant fold an extractvalue instruction with the
/// specified operands and indices.  The constant result is returned if
/// successful; if not, null is returned.
Constant *ConstantFoldExtractValueInstruction(Constant *Agg,
                                              ArrayRef<unsigned> Idxs);

/// Attempt to constant fold an insertelement instruction with the
/// specified operands and indices.  The constant result is returned if
/// successful; if not, null is returned.
Constant *ConstantFoldInsertElementInstruction(Constant *Val,
                                               Constant *Elt,
                                               Constant *Idx);

/// Attempt to constant fold an extractelement instruction with the
/// specified operands and indices.  The constant result is returned if
/// successful; if not, null is returned.
Constant *ConstantFoldExtractElementInstruction(Constant *Val, Constant *Idx);

/// Attempt to constant fold a shufflevector instruction with the
/// specified operands and mask.  See class ShuffleVectorInst for a description
/// of the mask representation. The constant result is returned if successful;
/// if not, null is returned.
Constant *ConstantFoldShuffleVectorInstruction(Constant *V1, Constant *V2,
                                               ArrayRef<int> Mask);

/// ConstantFoldLoadFromConstPtr - Return the value that a load from C would
/// produce if it is constant and determinable.  If this is not determinable,
/// return null.
Constant *ConstantFoldLoadFromConstPtr(Constant *C, Type *Ty, const DataLayout &DL);

/// ConstantFoldLoadThroughGEPConstantExpr - Given a constant and a
/// getelementptr constantexpr, return the constant value being addressed by the
/// constant expression, or null if something is funny and we can't decide.
Constant *ConstantFoldLoadThroughGEPConstantExpr(Constant *C, ConstantExpr *CE,
                                                 Type *Ty,
                                                 const DataLayout &DL);

/// ConstantFoldLoadThroughGEPIndices - Given a constant and getelementptr
/// indices (with an *implied* zero pointer index that is not in the list),
/// return the constant value being addressed by a virtual load, or null if
/// something is funny and we can't decide.
Constant *ConstantFoldLoadThroughGEPIndices(Constant *C,
                                            ArrayRef<Constant *> Indices);

/// canConstantFoldCallTo - Return true if its even possible to fold a call to
/// the specified function.
bool canConstantFoldCallTo(const CallBase *Call, const Function *F);

/// ConstantFoldCall - Attempt to constant fold a call to the specified function
/// with the specified arguments, returning null if unsuccessful.
Constant *ConstantFoldCall(const CallBase *Call, Function *F,
                           ArrayRef<Constant *> Operands,
                           const TargetLibraryInfo *TLI = nullptr);

/// ConstantFoldLoadThroughBitcast - try to cast constant to destination type
/// returning null if unsuccessful. Can cast pointer to pointer or pointer to
/// integer and vice versa if their sizes are equal.
Constant *ConstantFoldLoadThroughBitcast(Constant *C, Type *DestTy,
                                         const DataLayout &DL);

/// Check whether the given call has no side-effects.
/// Specifically checks for math routimes which sometimes set errno.
bool isMathLibCallNoop(const CallBase *Call, const TargetLibraryInfo *TLI);
}

#endif
