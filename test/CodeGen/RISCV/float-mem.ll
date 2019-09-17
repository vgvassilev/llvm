; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+f -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IF %s
; RUN: llc -mtriple=riscv64 -mattr=+f -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IF %s

define float @flw(float *%a) nounwind {
; RV32IF-LABEL: flw:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    flw ft0, 12(a0)
; RV32IF-NEXT:    flw ft1, 0(a0)
; RV32IF-NEXT:    fadd.s ft0, ft1, ft0
; RV32IF-NEXT:    fmv.x.w a0, ft0
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: flw:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    flw ft0, 12(a0)
; RV64IF-NEXT:    flw ft1, 0(a0)
; RV64IF-NEXT:    fadd.s ft0, ft1, ft0
; RV64IF-NEXT:    fmv.x.w a0, ft0
; RV64IF-NEXT:    ret
  %1 = load float, float* %a
  %2 = getelementptr float, float* %a, i32 3
  %3 = load float, float* %2
; Use both loaded values in an FP op to ensure an flw is used, even for the
; soft float ABI
  %4 = fadd float %1, %3
  ret float %4
}

define void @fsw(float *%a, float %b, float %c) nounwind {
; Use %b and %c in an FP op to ensure floating point registers are used, even
; for the soft float ABI
; RV32IF-LABEL: fsw:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    fmv.w.x ft0, a2
; RV32IF-NEXT:    fmv.w.x ft1, a1
; RV32IF-NEXT:    fadd.s ft0, ft1, ft0
; RV32IF-NEXT:    fsw ft0, 32(a0)
; RV32IF-NEXT:    fsw ft0, 0(a0)
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: fsw:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fmv.w.x ft0, a2
; RV64IF-NEXT:    fmv.w.x ft1, a1
; RV64IF-NEXT:    fadd.s ft0, ft1, ft0
; RV64IF-NEXT:    fsw ft0, 32(a0)
; RV64IF-NEXT:    fsw ft0, 0(a0)
; RV64IF-NEXT:    ret
  %1 = fadd float %b, %c
  store float %1, float* %a
  %2 = getelementptr float, float* %a, i32 8
  store float %1, float* %2
  ret void
}

; Check load and store to a global
@G = global float 0.0

define float @flw_fsw_global(float %a, float %b) nounwind {
; Use %a and %b in an FP op to ensure floating point registers are used, even
; for the soft float ABI
; RV32IF-LABEL: flw_fsw_global:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    fmv.w.x ft0, a1
; RV32IF-NEXT:    fmv.w.x ft1, a0
; RV32IF-NEXT:    fadd.s ft0, ft1, ft0
; RV32IF-NEXT:    lui a0, %hi(G)
; RV32IF-NEXT:    flw ft1, %lo(G)(a0)
; RV32IF-NEXT:    fsw ft0, %lo(G)(a0)
; RV32IF-NEXT:    addi a0, a0, %lo(G)
; RV32IF-NEXT:    flw ft1, 36(a0)
; RV32IF-NEXT:    fsw ft0, 36(a0)
; RV32IF-NEXT:    fmv.x.w a0, ft0
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: flw_fsw_global:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fmv.w.x ft0, a1
; RV64IF-NEXT:    fmv.w.x ft1, a0
; RV64IF-NEXT:    fadd.s ft0, ft1, ft0
; RV64IF-NEXT:    lui a0, %hi(G)
; RV64IF-NEXT:    flw ft1, %lo(G)(a0)
; RV64IF-NEXT:    fsw ft0, %lo(G)(a0)
; RV64IF-NEXT:    addi a0, a0, %lo(G)
; RV64IF-NEXT:    flw ft1, 36(a0)
; RV64IF-NEXT:    fsw ft0, 36(a0)
; RV64IF-NEXT:    fmv.x.w a0, ft0
; RV64IF-NEXT:    ret
  %1 = fadd float %a, %b
  %2 = load volatile float, float* @G
  store float %1, float* @G
  %3 = getelementptr float, float* @G, i32 9
  %4 = load volatile float, float* %3
  store float %1, float* %3
  ret float %1
}

; Ensure that 1 is added to the high 20 bits if bit 11 of the low part is 1
define float @flw_fsw_constant(float %a) nounwind {
; RV32IF-LABEL: flw_fsw_constant:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    fmv.w.x ft0, a0
; RV32IF-NEXT:    lui a0, 912092
; RV32IF-NEXT:    flw ft1, -273(a0)
; RV32IF-NEXT:    fadd.s ft0, ft0, ft1
; RV32IF-NEXT:    fsw ft0, -273(a0)
; RV32IF-NEXT:    fmv.x.w a0, ft0
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: flw_fsw_constant:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    fmv.w.x ft0, a0
; RV64IF-NEXT:    lui a0, 56
; RV64IF-NEXT:    addiw a0, a0, -1353
; RV64IF-NEXT:    slli a0, a0, 14
; RV64IF-NEXT:    flw ft1, -273(a0)
; RV64IF-NEXT:    fadd.s ft0, ft0, ft1
; RV64IF-NEXT:    fsw ft0, -273(a0)
; RV64IF-NEXT:    fmv.x.w a0, ft0
; RV64IF-NEXT:    ret
  %1 = inttoptr i32 3735928559 to float*
  %2 = load volatile float, float* %1
  %3 = fadd float %a, %2
  store float %3, float* %1
  ret float %3
}

declare void @notdead(i8*)

define float @flw_stack(float %a) nounwind {
; RV32IF-LABEL: flw_stack:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    addi sp, sp, -16
; RV32IF-NEXT:    sw ra, 12(sp)
; RV32IF-NEXT:    sw s0, 8(sp)
; RV32IF-NEXT:    mv s0, a0
; RV32IF-NEXT:    addi a0, sp, 4
; RV32IF-NEXT:    call notdead
; RV32IF-NEXT:    fmv.w.x ft0, s0
; RV32IF-NEXT:    flw ft1, 4(sp)
; RV32IF-NEXT:    fadd.s ft0, ft1, ft0
; RV32IF-NEXT:    fmv.x.w a0, ft0
; RV32IF-NEXT:    lw s0, 8(sp)
; RV32IF-NEXT:    lw ra, 12(sp)
; RV32IF-NEXT:    addi sp, sp, 16
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: flw_stack:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    addi sp, sp, -32
; RV64IF-NEXT:    sd ra, 24(sp)
; RV64IF-NEXT:    sd s0, 16(sp)
; RV64IF-NEXT:    mv s0, a0
; RV64IF-NEXT:    addi a0, sp, 12
; RV64IF-NEXT:    call notdead
; RV64IF-NEXT:    fmv.w.x ft0, s0
; RV64IF-NEXT:    flw ft1, 12(sp)
; RV64IF-NEXT:    fadd.s ft0, ft1, ft0
; RV64IF-NEXT:    fmv.x.w a0, ft0
; RV64IF-NEXT:    ld s0, 16(sp)
; RV64IF-NEXT:    ld ra, 24(sp)
; RV64IF-NEXT:    addi sp, sp, 32
; RV64IF-NEXT:    ret
  %1 = alloca float, align 4
  %2 = bitcast float* %1 to i8*
  call void @notdead(i8* %2)
  %3 = load float, float* %1
  %4 = fadd float %3, %a ; force load in to FPR32
  ret float %4
}

define void @fsw_stack(float %a, float %b) nounwind {
; RV32IF-LABEL: fsw_stack:
; RV32IF:       # %bb.0:
; RV32IF-NEXT:    addi sp, sp, -16
; RV32IF-NEXT:    sw ra, 12(sp)
; RV32IF-NEXT:    fmv.w.x ft0, a1
; RV32IF-NEXT:    fmv.w.x ft1, a0
; RV32IF-NEXT:    fadd.s ft0, ft1, ft0
; RV32IF-NEXT:    fsw ft0, 8(sp)
; RV32IF-NEXT:    addi a0, sp, 8
; RV32IF-NEXT:    call notdead
; RV32IF-NEXT:    lw ra, 12(sp)
; RV32IF-NEXT:    addi sp, sp, 16
; RV32IF-NEXT:    ret
;
; RV64IF-LABEL: fsw_stack:
; RV64IF:       # %bb.0:
; RV64IF-NEXT:    addi sp, sp, -16
; RV64IF-NEXT:    sd ra, 8(sp)
; RV64IF-NEXT:    fmv.w.x ft0, a1
; RV64IF-NEXT:    fmv.w.x ft1, a0
; RV64IF-NEXT:    fadd.s ft0, ft1, ft0
; RV64IF-NEXT:    fsw ft0, 4(sp)
; RV64IF-NEXT:    addi a0, sp, 4
; RV64IF-NEXT:    call notdead
; RV64IF-NEXT:    ld ra, 8(sp)
; RV64IF-NEXT:    addi sp, sp, 16
; RV64IF-NEXT:    ret
  %1 = fadd float %a, %b ; force store from FPR32
  %2 = alloca float, align 4
  store float %1, float* %2
  %3 = bitcast float* %2 to i8*
  call void @notdead(i8* %3)
  ret void
}
