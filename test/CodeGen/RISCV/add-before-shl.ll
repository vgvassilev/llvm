; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s

; These test that constant adds are not moved after shifts by DAGCombine,
; if the constant is cheaper to materialise before it has been shifted.

define signext i32 @add_small_const(i32 signext %a) nounwind {
; RV32I-LABEL: add_small_const:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, 1
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srai a0, a0, 24
; RV32I-NEXT:    ret
;
; RV64I-LABEL: add_small_const:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, 1
; RV64I-NEXT:    slli a0, a0, 56
; RV64I-NEXT:    srai a0, a0, 56
; RV64I-NEXT:    ret
  %1 = add i32 %a, 1
  %2 = shl i32 %1, 24
  %3 = ashr i32 %2, 24
  ret i32 %3
}

define signext i32 @add_large_const(i32 signext %a) nounwind {
; RV32I-LABEL: add_large_const:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    lui a1, 65520
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: add_large_const:
; RV64I:       # %bb.0:
; RV64I-NEXT:    lui a1, 1
; RV64I-NEXT:    addiw a1, a1, -1
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:    ret
  %1 = add i32 %a, 4095
  %2 = shl i32 %1, 16
  %3 = ashr i32 %2, 16
  ret i32 %3
}

define signext i32 @add_huge_const(i32 signext %a) nounwind {
; RV32I-LABEL: add_huge_const:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    lui a1, 524272
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srai a0, a0, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: add_huge_const:
; RV64I:       # %bb.0:
; RV64I-NEXT:    lui a1, 8
; RV64I-NEXT:    addiw a1, a1, -1
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    slli a0, a0, 48
; RV64I-NEXT:    srai a0, a0, 48
; RV64I-NEXT:    ret
  %1 = add i32 %a, 32767
  %2 = shl i32 %1, 16
  %3 = ashr i32 %2, 16
  ret i32 %3
}
