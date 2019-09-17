; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I-FPELIM %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs -frame-pointer=all < %s \
; RUN:   | FileCheck -check-prefix=RV64I-WITHFP %s

; As well as calling convention details, we check that ra and fp are
; consistently stored to fp-8 and fp-16.

; Any tests that would have identical output for some combination of the lp64*
; ABIs belong in calling-conv-*-common.ll. This file contains tests that will
; have different output across those ABIs. i.e. where some arguments would be
; passed according to the floating point ABI.

; TODO: softened float values can be passed anyext.

define i64 @callee_float_in_regs(i64 %a, float %b) nounwind {
; RV64I-FPELIM-LABEL: callee_float_in_regs:
; RV64I-FPELIM:       # %bb.0:
; RV64I-FPELIM-NEXT:    addi sp, sp, -16
; RV64I-FPELIM-NEXT:    sd ra, 8(sp)
; RV64I-FPELIM-NEXT:    sd s0, 0(sp)
; RV64I-FPELIM-NEXT:    mv s0, a0
; RV64I-FPELIM-NEXT:    mv a0, a1
; RV64I-FPELIM-NEXT:    call __fixsfdi
; RV64I-FPELIM-NEXT:    add a0, s0, a0
; RV64I-FPELIM-NEXT:    ld s0, 0(sp)
; RV64I-FPELIM-NEXT:    ld ra, 8(sp)
; RV64I-FPELIM-NEXT:    addi sp, sp, 16
; RV64I-FPELIM-NEXT:    ret
;
; RV64I-WITHFP-LABEL: callee_float_in_regs:
; RV64I-WITHFP:       # %bb.0:
; RV64I-WITHFP-NEXT:    addi sp, sp, -32
; RV64I-WITHFP-NEXT:    sd ra, 24(sp)
; RV64I-WITHFP-NEXT:    sd s0, 16(sp)
; RV64I-WITHFP-NEXT:    sd s1, 8(sp)
; RV64I-WITHFP-NEXT:    addi s0, sp, 32
; RV64I-WITHFP-NEXT:    mv s1, a0
; RV64I-WITHFP-NEXT:    mv a0, a1
; RV64I-WITHFP-NEXT:    call __fixsfdi
; RV64I-WITHFP-NEXT:    add a0, s1, a0
; RV64I-WITHFP-NEXT:    ld s1, 8(sp)
; RV64I-WITHFP-NEXT:    ld s0, 16(sp)
; RV64I-WITHFP-NEXT:    ld ra, 24(sp)
; RV64I-WITHFP-NEXT:    addi sp, sp, 32
; RV64I-WITHFP-NEXT:    ret
  %b_fptosi = fptosi float %b to i64
  %1 = add i64 %a, %b_fptosi
  ret i64 %1
}

define i64 @caller_float_in_regs() nounwind {
; RV64I-FPELIM-LABEL: caller_float_in_regs:
; RV64I-FPELIM:       # %bb.0:
; RV64I-FPELIM-NEXT:    addi sp, sp, -16
; RV64I-FPELIM-NEXT:    sd ra, 8(sp)
; RV64I-FPELIM-NEXT:    addi a0, zero, 1
; RV64I-FPELIM-NEXT:    lui a1, 262144
; RV64I-FPELIM-NEXT:    call callee_float_in_regs
; RV64I-FPELIM-NEXT:    ld ra, 8(sp)
; RV64I-FPELIM-NEXT:    addi sp, sp, 16
; RV64I-FPELIM-NEXT:    ret
;
; RV64I-WITHFP-LABEL: caller_float_in_regs:
; RV64I-WITHFP:       # %bb.0:
; RV64I-WITHFP-NEXT:    addi sp, sp, -16
; RV64I-WITHFP-NEXT:    sd ra, 8(sp)
; RV64I-WITHFP-NEXT:    sd s0, 0(sp)
; RV64I-WITHFP-NEXT:    addi s0, sp, 16
; RV64I-WITHFP-NEXT:    addi a0, zero, 1
; RV64I-WITHFP-NEXT:    lui a1, 262144
; RV64I-WITHFP-NEXT:    call callee_float_in_regs
; RV64I-WITHFP-NEXT:    ld s0, 0(sp)
; RV64I-WITHFP-NEXT:    ld ra, 8(sp)
; RV64I-WITHFP-NEXT:    addi sp, sp, 16
; RV64I-WITHFP-NEXT:    ret
  %1 = call i64 @callee_float_in_regs(i64 1, float 2.0)
  ret i64 %1
}

define i64 @callee_float_on_stack(i128 %a, i128 %b, i128 %c, i128 %d, float %e) nounwind {
; RV64I-FPELIM-LABEL: callee_float_on_stack:
; RV64I-FPELIM:       # %bb.0:
; RV64I-FPELIM-NEXT:    lw a0, 0(sp)
; RV64I-FPELIM-NEXT:    ret
;
; RV64I-WITHFP-LABEL: callee_float_on_stack:
; RV64I-WITHFP:       # %bb.0:
; RV64I-WITHFP-NEXT:    addi sp, sp, -16
; RV64I-WITHFP-NEXT:    sd ra, 8(sp)
; RV64I-WITHFP-NEXT:    sd s0, 0(sp)
; RV64I-WITHFP-NEXT:    addi s0, sp, 16
; RV64I-WITHFP-NEXT:    lw a0, 0(s0)
; RV64I-WITHFP-NEXT:    ld s0, 0(sp)
; RV64I-WITHFP-NEXT:    ld ra, 8(sp)
; RV64I-WITHFP-NEXT:    addi sp, sp, 16
; RV64I-WITHFP-NEXT:    ret
  %1 = trunc i128 %d to i64
  %2 = bitcast float %e to i32
  %3 = sext i32 %2 to i64
  %4 = add i64 %1, %3
  ret i64 %3
}

define i64 @caller_float_on_stack() nounwind {
; RV64I-FPELIM-LABEL: caller_float_on_stack:
; RV64I-FPELIM:       # %bb.0:
; RV64I-FPELIM-NEXT:    addi sp, sp, -16
; RV64I-FPELIM-NEXT:    sd ra, 8(sp)
; RV64I-FPELIM-NEXT:    lui a1, 264704
; RV64I-FPELIM-NEXT:    addi a0, zero, 1
; RV64I-FPELIM-NEXT:    addi a2, zero, 2
; RV64I-FPELIM-NEXT:    addi a4, zero, 3
; RV64I-FPELIM-NEXT:    addi a6, zero, 4
; RV64I-FPELIM-NEXT:    sd a1, 0(sp)
; RV64I-FPELIM-NEXT:    mv a1, zero
; RV64I-FPELIM-NEXT:    mv a3, zero
; RV64I-FPELIM-NEXT:    mv a5, zero
; RV64I-FPELIM-NEXT:    mv a7, zero
; RV64I-FPELIM-NEXT:    call callee_float_on_stack
; RV64I-FPELIM-NEXT:    ld ra, 8(sp)
; RV64I-FPELIM-NEXT:    addi sp, sp, 16
; RV64I-FPELIM-NEXT:    ret
;
; RV64I-WITHFP-LABEL: caller_float_on_stack:
; RV64I-WITHFP:       # %bb.0:
; RV64I-WITHFP-NEXT:    addi sp, sp, -32
; RV64I-WITHFP-NEXT:    sd ra, 24(sp)
; RV64I-WITHFP-NEXT:    sd s0, 16(sp)
; RV64I-WITHFP-NEXT:    addi s0, sp, 32
; RV64I-WITHFP-NEXT:    lui a1, 264704
; RV64I-WITHFP-NEXT:    addi a0, zero, 1
; RV64I-WITHFP-NEXT:    addi a2, zero, 2
; RV64I-WITHFP-NEXT:    addi a4, zero, 3
; RV64I-WITHFP-NEXT:    addi a6, zero, 4
; RV64I-WITHFP-NEXT:    sd a1, 0(sp)
; RV64I-WITHFP-NEXT:    mv a1, zero
; RV64I-WITHFP-NEXT:    mv a3, zero
; RV64I-WITHFP-NEXT:    mv a5, zero
; RV64I-WITHFP-NEXT:    mv a7, zero
; RV64I-WITHFP-NEXT:    call callee_float_on_stack
; RV64I-WITHFP-NEXT:    ld s0, 16(sp)
; RV64I-WITHFP-NEXT:    ld ra, 24(sp)
; RV64I-WITHFP-NEXT:    addi sp, sp, 32
; RV64I-WITHFP-NEXT:    ret
  %1 = call i64 @callee_float_on_stack(i128 1, i128 2, i128 3, i128 4, float 5.0)
  ret i64 %1
}

define float @callee_tiny_scalar_ret() nounwind {
; RV64I-FPELIM-LABEL: callee_tiny_scalar_ret:
; RV64I-FPELIM:       # %bb.0:
; RV64I-FPELIM-NEXT:    lui a0, 260096
; RV64I-FPELIM-NEXT:    ret
;
; RV64I-WITHFP-LABEL: callee_tiny_scalar_ret:
; RV64I-WITHFP:       # %bb.0:
; RV64I-WITHFP-NEXT:    addi sp, sp, -16
; RV64I-WITHFP-NEXT:    sd ra, 8(sp)
; RV64I-WITHFP-NEXT:    sd s0, 0(sp)
; RV64I-WITHFP-NEXT:    addi s0, sp, 16
; RV64I-WITHFP-NEXT:    lui a0, 260096
; RV64I-WITHFP-NEXT:    ld s0, 0(sp)
; RV64I-WITHFP-NEXT:    ld ra, 8(sp)
; RV64I-WITHFP-NEXT:    addi sp, sp, 16
; RV64I-WITHFP-NEXT:    ret
  ret float 1.0
}

; The sign extension of the float return is necessary, as softened floats are
; passed anyext.

define i64 @caller_tiny_scalar_ret() nounwind {
; RV64I-FPELIM-LABEL: caller_tiny_scalar_ret:
; RV64I-FPELIM:       # %bb.0:
; RV64I-FPELIM-NEXT:    addi sp, sp, -16
; RV64I-FPELIM-NEXT:    sd ra, 8(sp)
; RV64I-FPELIM-NEXT:    call callee_tiny_scalar_ret
; RV64I-FPELIM-NEXT:    sext.w a0, a0
; RV64I-FPELIM-NEXT:    ld ra, 8(sp)
; RV64I-FPELIM-NEXT:    addi sp, sp, 16
; RV64I-FPELIM-NEXT:    ret
;
; RV64I-WITHFP-LABEL: caller_tiny_scalar_ret:
; RV64I-WITHFP:       # %bb.0:
; RV64I-WITHFP-NEXT:    addi sp, sp, -16
; RV64I-WITHFP-NEXT:    sd ra, 8(sp)
; RV64I-WITHFP-NEXT:    sd s0, 0(sp)
; RV64I-WITHFP-NEXT:    addi s0, sp, 16
; RV64I-WITHFP-NEXT:    call callee_tiny_scalar_ret
; RV64I-WITHFP-NEXT:    sext.w a0, a0
; RV64I-WITHFP-NEXT:    ld s0, 0(sp)
; RV64I-WITHFP-NEXT:    ld ra, 8(sp)
; RV64I-WITHFP-NEXT:    addi sp, sp, 16
; RV64I-WITHFP-NEXT:    ret
  %1 = call float @callee_tiny_scalar_ret()
  %2 = bitcast float %1 to i32
  %3 = sext i32 %2 to i64
  ret i64 %3
}
