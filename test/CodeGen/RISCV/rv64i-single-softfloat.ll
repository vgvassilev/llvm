; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s

; The test cases check that the single float arguments won't be extended
; when passing to softfloat functions.
; RISCV backend using shouldExtendTypeInLibCall target hook to suppress
; the extension generation.

define float @fadd_s(float %a, float %b) nounwind {
; RV64I-LABEL: fadd_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __addsf3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fadd float %a, %b
  ret float %1
}

define float @fsub_s(float %a, float %b) nounwind {
; RV64I-LABEL: fsub_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __subsf3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fsub float %a, %b
  ret float %1
}

define float @fmul_s(float %a, float %b) nounwind {
; RV64I-LABEL: fmul_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __mulsf3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fmul float %a, %b
  ret float %1
}

define float @fdiv_s(float %a, float %b) nounwind {
; RV64I-LABEL: fdiv_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __divsf3@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fdiv float %a, %b
  ret float %1
}

define i32 @feq_s(float %a, float %b) nounwind {
; RV64I-LABEL: feq_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __eqsf2@plt
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp oeq float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @flt_s(float %a, float %b) nounwind {
; RV64I-LABEL: flt_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __ltsf2@plt
; RV64I-NEXT:    slti a0, a0, 0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp olt float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fle_s(float %a, float %b) nounwind {
; RV64I-LABEL: fle_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __lesf2@plt
; RV64I-NEXT:    slti a0, a0, 1
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp ole float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ogt(float %a, float %b) nounwind {
; RV64I-LABEL: fcmp_ogt:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __gtsf2@plt
; RV64I-NEXT:    sgtz a0, a0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp ogt float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_oge(float %a, float %b) nounwind {
; RV64I-LABEL: fcmp_oge:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __gesf2@plt
; RV64I-NEXT:    addi a1, zero, -1
; RV64I-NEXT:    slt a0, a1, a0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp oge float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_ord(float %a, float %b) nounwind {
; RV64I-LABEL: fcmp_ord:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __unordsf2@plt
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp ord float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcmp_une(float %a, float %b) nounwind {
; RV64I-LABEL: fcmp_une:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __nesf2@plt
; RV64I-NEXT:    snez a0, a0
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fcmp une float %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @fcvt_w_s(float %a) nounwind {
; RV64I-LABEL: fcvt_w_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixsfsi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptosi float %a to i32
  ret i32 %1
}

define i32 @fcvt_wu_s(float %a) nounwind {
; RV64I-LABEL: fcvt_wu_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunssfsi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptoui float %a to i32
  ret i32 %1
}

define float @fcvt_s_w(i32 %a) nounwind {
; RV64I-LABEL: fcvt_s_w:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    call __floatsisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = sitofp i32 %a to float
  ret float %1
}

define float @fcvt_s_wu(i32 %a) nounwind {
; RV64I-LABEL: fcvt_s_wu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    call __floatunsisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = uitofp i32 %a to float
  ret float %1
}

define i64 @fcvt_l_s(float %a) nounwind {
; RV64I-LABEL: fcvt_l_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixsfdi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptosi float %a to i64
  ret i64 %1
}

define i64 @fcvt_lu_s(float %a) nounwind {
; RV64I-LABEL: fcvt_lu_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunssfdi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = fptoui float %a to i64
  ret i64 %1
}

define float @fcvt_s_l(i64 %a) nounwind {
; RV64I-LABEL: fcvt_s_l:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatdisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = sitofp i64 %a to float
  ret float %1
}

define float @fcvt_s_lu(i64 %a) nounwind {
; RV64I-LABEL: fcvt_s_lu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __floatundisf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = uitofp i64 %a to float
  ret float %1
}

declare float @llvm.sqrt.f32(float)

define float @fsqrt_s(float %a) nounwind {
; RV64I-LABEL: fsqrt_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call sqrtf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.sqrt.f32(float %a)
  ret float %1
}

declare float @llvm.copysign.f32(float, float)

define float @fsgnj_s(float %a, float %b) nounwind {
; RV64I-LABEL: fsgnj_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    lui a2, 524288
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    addiw a2, a2, -1
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    ret
  %1 = call float @llvm.copysign.f32(float %a, float %b)
  ret float %1
}

declare float @llvm.minnum.f32(float, float)

define float @fmin_s(float %a, float %b) nounwind {
; RV64I-LABEL: fmin_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call fminf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.minnum.f32(float %a, float %b)
  ret float %1
}

declare float @llvm.maxnum.f32(float, float)

define float @fmax_s(float %a, float %b) nounwind {
; RV64I-LABEL: fmax_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call fmaxf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.maxnum.f32(float %a, float %b)
  ret float %1
}


declare float @llvm.fma.f32(float, float, float)

define float @fmadd_s(float %a, float %b, float %c) nounwind {
; RV64I-LABEL: fmadd_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call fmaf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.fma.f32(float %a, float %b, float %c)
  ret float %1
}

define float @fmsub_s(float %a, float %b, float %c) nounwind {
; RV64I-LABEL: fmsub_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -32
; RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a1
; RV64I-NEXT:    mv s1, a0
; RV64I-NEXT:    mv a0, a2
; RV64I-NEXT:    mv a1, zero
; RV64I-NEXT:    call __addsf3@plt
; RV64I-NEXT:    lui a1, 524288
; RV64I-NEXT:    xor a2, a0, a1
; RV64I-NEXT:    mv a0, s1
; RV64I-NEXT:    mv a1, s0
; RV64I-NEXT:    call fmaf@plt
; RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 32
; RV64I-NEXT:    ret
  %c_ = fadd float 0.0, %c ; avoid negation using xor
  %negc = fsub float -0.0, %c_
  %1 = call float @llvm.fma.f32(float %a, float %b, float %negc)
  ret float %1
}

define float @fnmadd_s(float %a, float %b, float %c) nounwind {
; RV64I-LABEL: fnmadd_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -32
; RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s2, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a2
; RV64I-NEXT:    mv s2, a1
; RV64I-NEXT:    mv a1, zero
; RV64I-NEXT:    call __addsf3@plt
; RV64I-NEXT:    mv s1, a0
; RV64I-NEXT:    mv a0, s0
; RV64I-NEXT:    mv a1, zero
; RV64I-NEXT:    call __addsf3@plt
; RV64I-NEXT:    lui a2, 524288
; RV64I-NEXT:    xor a1, s1, a2
; RV64I-NEXT:    xor a2, a0, a2
; RV64I-NEXT:    mv a0, a1
; RV64I-NEXT:    mv a1, s2
; RV64I-NEXT:    call fmaf@plt
; RV64I-NEXT:    ld s2, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 32
; RV64I-NEXT:    ret
  %a_ = fadd float 0.0, %a
  %c_ = fadd float 0.0, %c
  %nega = fsub float -0.0, %a_
  %negc = fsub float -0.0, %c_
  %1 = call float @llvm.fma.f32(float %nega, float %b, float %negc)
  ret float %1
}

define float @fnmsub_s(float %a, float %b, float %c) nounwind {
; RV64I-LABEL: fnmsub_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -32
; RV64I-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 16(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s1, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a2
; RV64I-NEXT:    mv s1, a1
; RV64I-NEXT:    mv a1, zero
; RV64I-NEXT:    call __addsf3@plt
; RV64I-NEXT:    lui a1, 524288
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    mv a1, s1
; RV64I-NEXT:    mv a2, s0
; RV64I-NEXT:    call fmaf@plt
; RV64I-NEXT:    ld s1, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 16(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 32
; RV64I-NEXT:    ret
  %a_ = fadd float 0.0, %a
  %nega = fsub float -0.0, %a_
  %1 = call float @llvm.fma.f32(float %nega, float %b, float %c)
  ret float %1
}

declare float @llvm.ceil.f32(float)

define float @fceil_s(float %a) nounwind {
; RV64I-LABEL: fceil_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call ceilf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.ceil.f32(float %a)
  ret float %1
}

declare float @llvm.cos.f32(float)

define float @fcos_s(float %a) nounwind {
; RV64I-LABEL: fcos_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call cosf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.cos.f32(float %a)
  ret float %1
}

declare float @llvm.sin.f32(float)

define float @fsin_s(float %a) nounwind {
; RV64I-LABEL: fsin_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call sinf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.sin.f32(float %a)
  ret float %1
}

declare float @llvm.exp.f32(float)

define float @fexp_s(float %a) nounwind {
; RV64I-LABEL: fexp_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call expf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.exp.f32(float %a)
  ret float %1
}

declare float @llvm.exp2.f32(float)

define float @fexp2_s(float %a) nounwind {
; RV64I-LABEL: fexp2_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call exp2f@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.exp2.f32(float %a)
  ret float %1
}

declare float @llvm.floor.f32(float)

define float @ffloor_s(float %a) nounwind {
; RV64I-LABEL: ffloor_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call floorf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.floor.f32(float %a)
  ret float %1
}

declare float @llvm.flog.f32(float)

define float @fflog_s(float %a) nounwind {
; RV64I-LABEL: fflog_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call llvm.flog.f32@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.flog.f32(float %a)
  ret float %1
}

declare float @llvm.flog2.f32(float)

define float @fflog2_s(float %a) nounwind {
; RV64I-LABEL: fflog2_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call llvm.flog2.f32@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.flog2.f32(float %a)
  ret float %1
}

declare float @llvm.flog10.f32(float)

define float @fflog10_s(float %a) nounwind {
; RV64I-LABEL: fflog10_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call llvm.flog10.f32@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.flog10.f32(float %a)
  ret float %1
}

declare float @llvm.fnearbyint.f32(float)

define float @fnearbyint_s(float %a) nounwind {
; RV64I-LABEL: fnearbyint_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call llvm.fnearbyint.f32@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.fnearbyint.f32(float %a)
  ret float %1
}

declare float @llvm.round.f32(float)

define float @fround_s(float %a) nounwind {
; RV64I-LABEL: fround_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call roundf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.round.f32(float %a)
  ret float %1
}

declare float @llvm.fpround.f32(float)

define float @fpround_s(float %a) nounwind {
; RV64I-LABEL: fpround_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call llvm.fpround.f32@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.fpround.f32(float %a)
  ret float %1
}

declare float @llvm.rint.f32(float)

define float @frint_s(float %a) nounwind {
; RV64I-LABEL: frint_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call rintf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.rint.f32(float %a)
  ret float %1
}

declare float @llvm.rem.f32(float)

define float @frem_s(float %a) nounwind {
; RV64I-LABEL: frem_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call llvm.rem.f32@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.rem.f32(float %a)
  ret float %1
}

declare float @llvm.pow.f32(float %Val, float %power)

define float @fpow_s(float %a, float %b) nounwind {
; RV64I-LABEL: fpow_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call powf@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.pow.f32(float %a, float %b)
  ret float %1
}

declare float @llvm.powi.f32.i32(float %Val, i32 %power)

define float @fpowi_s(float %a, i32 %b) nounwind {
; RV64I-LABEL: fpowi_s:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sext.w a1, a1
; RV64I-NEXT:    call __powisf2@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %1 = call float @llvm.powi.f32.i32(float %a, i32 %b)
  ret float %1
}

define double @fp_ext(float %a) nounwind {
; RV64I-LABEL: fp_ext:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __extendsfdf2@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %conv = fpext float %a to double
  ret double %conv
}

define float @fp_trunc(double %a) nounwind {
; RV64I-LABEL: fp_trunc:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __truncdfsf2@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
  %conv = fptrunc double %a to float
  ret float %conv
}

define i32 @fp32_to_ui32(float %a) nounwind {
; RV64I-LABEL: fp32_to_ui32:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunssfsi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
entry:
  %conv = fptoui float %a to i32
  ret i32 %conv
}

define i32 @fp32_to_si32(float %a) nounwind  {
; RV64I-LABEL: fp32_to_si32:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixsfsi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
entry:
  %conv = fptosi float %a to i32
  ret i32 %conv
}



declare i32 @llvm.experimental.constrained.fptoui.i32.f32(float, metadata)
declare i32 @llvm.experimental.constrained.fptosi.i32.f32(float, metadata)

define i32 @strict_fp32_to_ui32(float %a) nounwind strictfp {
; RV64I-LABEL: strict_fp32_to_ui32:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixunssfsi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
entry:
  %conv = tail call i32 @llvm.experimental.constrained.fptoui.i32.f32(float %a, metadata !"fpexcept.strict")
  ret i32 %conv
}

define i32 @strict_fp32_to_si32(float %a) nounwind strictfp {
; RV64I-LABEL: strict_fp32_to_si32:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    call __fixsfsi@plt
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
entry:
  %conv = tail call i32 @llvm.experimental.constrained.fptosi.i32.f32(float %a, metadata !"fpexcept.strict")
  ret i32 %conv
}
