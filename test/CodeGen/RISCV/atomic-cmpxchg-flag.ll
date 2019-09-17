; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+a -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IA %s

; This test ensures that the output of the 'lr.w' instruction is sign-extended.
; Previously, the default zero-extension was being used and 'cmp' parameter
; higher bits were masked to zero for the comparison.

define i1 @cmpxchg_i32_seq_cst_seq_cst(i32* %ptr, i32 signext %cmp,
; RV64IA-LABEL: cmpxchg_i32_seq_cst_seq_cst:
; RV64IA:       # %bb.0: # %entry
; RV64IA-NEXT:  .LBB0_1: # %entry
; RV64IA-NEXT:    # =>This Inner Loop Header: Depth=1
; RV64IA-NEXT:    lr.w.aqrl a3, (a0)
; RV64IA-NEXT:    bne a3, a1, .LBB0_3
; RV64IA-NEXT:  # %bb.2: # %entry
; RV64IA-NEXT:    # in Loop: Header=BB0_1 Depth=1
; RV64IA-NEXT:    sc.w.aqrl a4, a2, (a0)
; RV64IA-NEXT:    bnez a4, .LBB0_1
; RV64IA-NEXT:  .LBB0_3: # %entry
; RV64IA-NEXT:    xor a0, a3, a1
; RV64IA-NEXT:    seqz a0, a0
; RV64IA-NEXT:    ret
        i32 signext %val) nounwind {
entry:
  %0 = cmpxchg i32* %ptr, i32 %cmp, i32 %val seq_cst seq_cst
  %1 = extractvalue { i32, i1 } %0, 1
  ret i1 %1
}
