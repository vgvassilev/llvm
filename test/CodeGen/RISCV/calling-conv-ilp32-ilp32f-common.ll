; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I-FPELIM %s
; RUN: llc -mtriple=riscv32 -mattr=+f -target-abi ilp32f \
; RUN:    -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I-FPELIM %s
; RUN: llc -mtriple=riscv32 -verify-machineinstrs -frame-pointer=all < %s \
; RUN:   | FileCheck -check-prefix=RV32I-WITHFP %s
; RUN: llc -mtriple=riscv32 -verify-machineinstrs -frame-pointer=all \
; RUN:   -mattr=+f -target-abi ilp32f < %s \
; RUN:   | FileCheck -check-prefix=RV32I-WITHFP %s

; This file contains tests that should have identical output for the ilp32,
; and ilp32f. As well as calling convention details, we check that
; ra and fp are consistently stored to fp-4 and fp-8.

; Check that on RV32 ilp32[f], double is passed in a pair of registers. Unlike
; the convention for varargs, this need not be an aligned pair.

define i32 @callee_double_in_regs(i32 %a, double %b) nounwind {
; RV32I-FPELIM-LABEL: callee_double_in_regs:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    addi sp, sp, -16
; RV32I-FPELIM-NEXT:    sw ra, 12(sp)
; RV32I-FPELIM-NEXT:    sw s0, 8(sp)
; RV32I-FPELIM-NEXT:    mv s0, a0
; RV32I-FPELIM-NEXT:    mv a0, a1
; RV32I-FPELIM-NEXT:    mv a1, a2
; RV32I-FPELIM-NEXT:    call __fixdfsi
; RV32I-FPELIM-NEXT:    add a0, s0, a0
; RV32I-FPELIM-NEXT:    lw s0, 8(sp)
; RV32I-FPELIM-NEXT:    lw ra, 12(sp)
; RV32I-FPELIM-NEXT:    addi sp, sp, 16
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: callee_double_in_regs:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp)
; RV32I-WITHFP-NEXT:    sw s0, 8(sp)
; RV32I-WITHFP-NEXT:    sw s1, 4(sp)
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    mv s1, a0
; RV32I-WITHFP-NEXT:    mv a0, a1
; RV32I-WITHFP-NEXT:    mv a1, a2
; RV32I-WITHFP-NEXT:    call __fixdfsi
; RV32I-WITHFP-NEXT:    add a0, s1, a0
; RV32I-WITHFP-NEXT:    lw s1, 4(sp)
; RV32I-WITHFP-NEXT:    lw s0, 8(sp)
; RV32I-WITHFP-NEXT:    lw ra, 12(sp)
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  %b_fptosi = fptosi double %b to i32
  %1 = add i32 %a, %b_fptosi
  ret i32 %1
}

define i32 @caller_double_in_regs() nounwind {
; RV32I-FPELIM-LABEL: caller_double_in_regs:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    addi sp, sp, -16
; RV32I-FPELIM-NEXT:    sw ra, 12(sp)
; RV32I-FPELIM-NEXT:    addi a0, zero, 1
; RV32I-FPELIM-NEXT:    lui a2, 262144
; RV32I-FPELIM-NEXT:    mv a1, zero
; RV32I-FPELIM-NEXT:    call callee_double_in_regs
; RV32I-FPELIM-NEXT:    lw ra, 12(sp)
; RV32I-FPELIM-NEXT:    addi sp, sp, 16
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: caller_double_in_regs:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp)
; RV32I-WITHFP-NEXT:    sw s0, 8(sp)
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    addi a0, zero, 1
; RV32I-WITHFP-NEXT:    lui a2, 262144
; RV32I-WITHFP-NEXT:    mv a1, zero
; RV32I-WITHFP-NEXT:    call callee_double_in_regs
; RV32I-WITHFP-NEXT:    lw s0, 8(sp)
; RV32I-WITHFP-NEXT:    lw ra, 12(sp)
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  %1 = call i32 @callee_double_in_regs(i32 1, double 2.0)
  ret i32 %1
}

; Check 2x*xlen values are aligned appropriately when passed on the stack
; Must keep define on a single line due to an update_llc_test_checks.py limitation
define i32 @callee_aligned_stack(i32 %a, i32 %b, fp128 %c, i32 %d, i32 %e, i64 %f, i32 %g, i32 %h, double %i, i32 %j, [2 x i32] %k) nounwind {
; The double should be 8-byte aligned on the stack, but the two-element array
; should only be 4-byte aligned
; RV32I-FPELIM-LABEL: callee_aligned_stack:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    lw a0, 0(a2)
; RV32I-FPELIM-NEXT:    lw a1, 20(sp)
; RV32I-FPELIM-NEXT:    lw a2, 0(sp)
; RV32I-FPELIM-NEXT:    lw a3, 8(sp)
; RV32I-FPELIM-NEXT:    lw a4, 16(sp)
; RV32I-FPELIM-NEXT:    add a0, a0, a7
; RV32I-FPELIM-NEXT:    add a0, a0, a2
; RV32I-FPELIM-NEXT:    add a0, a0, a3
; RV32I-FPELIM-NEXT:    add a0, a0, a4
; RV32I-FPELIM-NEXT:    add a0, a0, a1
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: callee_aligned_stack:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp)
; RV32I-WITHFP-NEXT:    sw s0, 8(sp)
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    lw a0, 0(a2)
; RV32I-WITHFP-NEXT:    lw a1, 20(s0)
; RV32I-WITHFP-NEXT:    lw a2, 0(s0)
; RV32I-WITHFP-NEXT:    lw a3, 8(s0)
; RV32I-WITHFP-NEXT:    lw a4, 16(s0)
; RV32I-WITHFP-NEXT:    add a0, a0, a7
; RV32I-WITHFP-NEXT:    add a0, a0, a2
; RV32I-WITHFP-NEXT:    add a0, a0, a3
; RV32I-WITHFP-NEXT:    add a0, a0, a4
; RV32I-WITHFP-NEXT:    add a0, a0, a1
; RV32I-WITHFP-NEXT:    lw s0, 8(sp)
; RV32I-WITHFP-NEXT:    lw ra, 12(sp)
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  %1 = bitcast fp128 %c to i128
  %2 = trunc i128 %1 to i32
  %3 = add i32 %2, %g
  %4 = add i32 %3, %h
  %5 = bitcast double %i to i64
  %6 = trunc i64 %5 to i32
  %7 = add i32 %4, %6
  %8 = add i32 %7, %j
  %9 = extractvalue [2 x i32] %k, 0
  %10 = add i32 %8, %9
  ret i32 %10
}

define void @caller_aligned_stack() nounwind {
; The double should be 8-byte aligned on the stack, but the two-element array
; should only be 4-byte aligned
; RV32I-FPELIM-LABEL: caller_aligned_stack:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    addi sp, sp, -64
; RV32I-FPELIM-NEXT:    sw ra, 60(sp)
; RV32I-FPELIM-NEXT:    addi a0, zero, 18
; RV32I-FPELIM-NEXT:    sw a0, 24(sp)
; RV32I-FPELIM-NEXT:    addi a0, zero, 17
; RV32I-FPELIM-NEXT:    sw a0, 20(sp)
; RV32I-FPELIM-NEXT:    addi a0, zero, 16
; RV32I-FPELIM-NEXT:    sw a0, 16(sp)
; RV32I-FPELIM-NEXT:    lui a0, 262236
; RV32I-FPELIM-NEXT:    addi a0, a0, 655
; RV32I-FPELIM-NEXT:    sw a0, 12(sp)
; RV32I-FPELIM-NEXT:    lui a0, 377487
; RV32I-FPELIM-NEXT:    addi a0, a0, 1475
; RV32I-FPELIM-NEXT:    sw a0, 8(sp)
; RV32I-FPELIM-NEXT:    addi a0, zero, 15
; RV32I-FPELIM-NEXT:    sw a0, 0(sp)
; RV32I-FPELIM-NEXT:    lui a0, 262153
; RV32I-FPELIM-NEXT:    addi a0, a0, 491
; RV32I-FPELIM-NEXT:    sw a0, 44(sp)
; RV32I-FPELIM-NEXT:    lui a0, 545260
; RV32I-FPELIM-NEXT:    addi a0, a0, -1967
; RV32I-FPELIM-NEXT:    sw a0, 40(sp)
; RV32I-FPELIM-NEXT:    lui a0, 964690
; RV32I-FPELIM-NEXT:    addi a0, a0, -328
; RV32I-FPELIM-NEXT:    sw a0, 36(sp)
; RV32I-FPELIM-NEXT:    lui a0, 335544
; RV32I-FPELIM-NEXT:    addi t0, a0, 1311
; RV32I-FPELIM-NEXT:    lui a0, 688509
; RV32I-FPELIM-NEXT:    addi a5, a0, -2048
; RV32I-FPELIM-NEXT:    addi a2, sp, 32
; RV32I-FPELIM-NEXT:    addi a0, zero, 1
; RV32I-FPELIM-NEXT:    addi a1, zero, 11
; RV32I-FPELIM-NEXT:    addi a3, zero, 12
; RV32I-FPELIM-NEXT:    addi a4, zero, 13
; RV32I-FPELIM-NEXT:    addi a6, zero, 4
; RV32I-FPELIM-NEXT:    addi a7, zero, 14
; RV32I-FPELIM-NEXT:    sw t0, 32(sp)
; RV32I-FPELIM-NEXT:    call callee_aligned_stack
; RV32I-FPELIM-NEXT:    lw ra, 60(sp)
; RV32I-FPELIM-NEXT:    addi sp, sp, 64
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: caller_aligned_stack:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -64
; RV32I-WITHFP-NEXT:    sw ra, 60(sp)
; RV32I-WITHFP-NEXT:    sw s0, 56(sp)
; RV32I-WITHFP-NEXT:    addi s0, sp, 64
; RV32I-WITHFP-NEXT:    addi a0, zero, 18
; RV32I-WITHFP-NEXT:    sw a0, 24(sp)
; RV32I-WITHFP-NEXT:    addi a0, zero, 17
; RV32I-WITHFP-NEXT:    sw a0, 20(sp)
; RV32I-WITHFP-NEXT:    addi a0, zero, 16
; RV32I-WITHFP-NEXT:    sw a0, 16(sp)
; RV32I-WITHFP-NEXT:    lui a0, 262236
; RV32I-WITHFP-NEXT:    addi a0, a0, 655
; RV32I-WITHFP-NEXT:    sw a0, 12(sp)
; RV32I-WITHFP-NEXT:    lui a0, 377487
; RV32I-WITHFP-NEXT:    addi a0, a0, 1475
; RV32I-WITHFP-NEXT:    sw a0, 8(sp)
; RV32I-WITHFP-NEXT:    addi a0, zero, 15
; RV32I-WITHFP-NEXT:    sw a0, 0(sp)
; RV32I-WITHFP-NEXT:    lui a0, 262153
; RV32I-WITHFP-NEXT:    addi a0, a0, 491
; RV32I-WITHFP-NEXT:    sw a0, -20(s0)
; RV32I-WITHFP-NEXT:    lui a0, 545260
; RV32I-WITHFP-NEXT:    addi a0, a0, -1967
; RV32I-WITHFP-NEXT:    sw a0, -24(s0)
; RV32I-WITHFP-NEXT:    lui a0, 964690
; RV32I-WITHFP-NEXT:    addi a0, a0, -328
; RV32I-WITHFP-NEXT:    sw a0, -28(s0)
; RV32I-WITHFP-NEXT:    lui a0, 335544
; RV32I-WITHFP-NEXT:    addi t0, a0, 1311
; RV32I-WITHFP-NEXT:    lui a0, 688509
; RV32I-WITHFP-NEXT:    addi a5, a0, -2048
; RV32I-WITHFP-NEXT:    addi a2, s0, -32
; RV32I-WITHFP-NEXT:    addi a0, zero, 1
; RV32I-WITHFP-NEXT:    addi a1, zero, 11
; RV32I-WITHFP-NEXT:    addi a3, zero, 12
; RV32I-WITHFP-NEXT:    addi a4, zero, 13
; RV32I-WITHFP-NEXT:    addi a6, zero, 4
; RV32I-WITHFP-NEXT:    addi a7, zero, 14
; RV32I-WITHFP-NEXT:    sw t0, -32(s0)
; RV32I-WITHFP-NEXT:    call callee_aligned_stack
; RV32I-WITHFP-NEXT:    lw s0, 56(sp)
; RV32I-WITHFP-NEXT:    lw ra, 60(sp)
; RV32I-WITHFP-NEXT:    addi sp, sp, 64
; RV32I-WITHFP-NEXT:    ret
  %1 = call i32 @callee_aligned_stack(i32 1, i32 11,
    fp128 0xLEB851EB851EB851F400091EB851EB851, i32 12, i32 13,
    i64 20000000000, i32 14, i32 15, double 2.720000e+00, i32 16,
    [2 x i32] [i32 17, i32 18])
  ret void
}

define double @callee_small_scalar_ret() nounwind {
; RV32I-FPELIM-LABEL: callee_small_scalar_ret:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    lui a1, 261888
; RV32I-FPELIM-NEXT:    mv a0, zero
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: callee_small_scalar_ret:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp)
; RV32I-WITHFP-NEXT:    sw s0, 8(sp)
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    lui a1, 261888
; RV32I-WITHFP-NEXT:    mv a0, zero
; RV32I-WITHFP-NEXT:    lw s0, 8(sp)
; RV32I-WITHFP-NEXT:    lw ra, 12(sp)
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  ret double 1.0
}

define i64 @caller_small_scalar_ret() nounwind {
; RV32I-FPELIM-LABEL: caller_small_scalar_ret:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    addi sp, sp, -16
; RV32I-FPELIM-NEXT:    sw ra, 12(sp)
; RV32I-FPELIM-NEXT:    call callee_small_scalar_ret
; RV32I-FPELIM-NEXT:    lw ra, 12(sp)
; RV32I-FPELIM-NEXT:    addi sp, sp, 16
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: caller_small_scalar_ret:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp)
; RV32I-WITHFP-NEXT:    sw s0, 8(sp)
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    call callee_small_scalar_ret
; RV32I-WITHFP-NEXT:    lw s0, 8(sp)
; RV32I-WITHFP-NEXT:    lw ra, 12(sp)
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  %1 = call double @callee_small_scalar_ret()
  %2 = bitcast double %1 to i64
  ret i64 %2
}
