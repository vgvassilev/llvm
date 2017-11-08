; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I

; Check load/store operations on values wider than what is natively supported

define i64 @load_i64(i64 *%a) nounwind {
; RV32I-LABEL: load_i64:
; RV32I:       # BB#0:
; RV32I-NEXT:    lw a2, 0(a0)
; RV32I-NEXT:    lw a1, 4(a0)
; RV32I-NEXT:    addi a0, a2, 0
; RV32I-NEXT:    jalr zero, ra, 0
  %1 = load i64, i64* %a
  ret i64 %1
}
