; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp -verify-machineinstrs %s -o - | FileCheck %s

define half @extret1_f16_sf(<8 x half> %a, <8 x half> %b, half* nocapture %p) {
; CHECK-LABEL: extret1_f16_sf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov d0, r0, r1
; CHECK-NEXT:    mov r0, sp
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    ldr r0, [sp, #16]
; CHECK-NEXT:    vadd.f16 q0, q0, q1
; CHECK-NEXT:    vmovx.f16 s0, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    bx lr
  %c = fadd <8 x half> %a, %b
  %e = extractelement <8 x half> %c, i32 1
  store half %e, half* %p, align 2
  ret half %e
}

define half @extret4_f16_sf(<8 x half> %a, <8 x half> %b, half* nocapture %p) {
; CHECK-LABEL: extret4_f16_sf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, sp
; CHECK-NEXT:    vmov d1, r2, r3
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    ldr r0, [sp, #16]
; CHECK-NEXT:    vadd.f16 q0, q0, q1
; CHECK-NEXT:    vstr.16 s2, [r0]
; CHECK-NEXT:    vmov r0, s2
; CHECK-NEXT:    bx lr
  %c = fadd <8 x half> %a, %b
  %e = extractelement <8 x half> %c, i32 4
  store half %e, half* %p, align 2
  ret half %e
}

define arm_aapcs_vfpcc half @extret1_f16_hf(<8 x half> %a, <8 x half> %b, half* nocapture %p) {
; CHECK-LABEL: extret1_f16_hf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vadd.f16 q0, q0, q1
; CHECK-NEXT:    vmovx.f16 s0, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %c = fadd <8 x half> %a, %b
  %e = extractelement <8 x half> %c, i32 1
  store half %e, half* %p, align 2
  ret half %e
}

define arm_aapcs_vfpcc half @extret4_f16_hf(<8 x half> %a, <8 x half> %b, half* nocapture %p) {
; CHECK-LABEL: extret4_f16_hf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vadd.f16 q0, q0, q1
; CHECK-NEXT:    vmov.f32 s0, s2
; CHECK-NEXT:    vstr.16 s2, [r0]
; CHECK-NEXT:    bx lr
  %c = fadd <8 x half> %a, %b
  %e = extractelement <8 x half> %c, i32 4
  store half %e, half* %p, align 2
  ret half %e
}

define arm_aapcs_vfpcc <8 x half> @extret1_v8f16_hf(<8 x half> %a, <8 x half> %b, half* nocapture %p) {
; CHECK-LABEL: extret1_v8f16_hf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vadd.f16 q0, q0, q1
; CHECK-NEXT:    vmov.u16 r1, q0[1]
; CHECK-NEXT:    vdup.16 q0, r1
; CHECK-NEXT:    strh r1, [r0]
; CHECK-NEXT:    bx lr
  %c = fadd <8 x half> %a, %b
  %e = extractelement <8 x half> %c, i32 1
  store half %e, half* %p, align 2
  %i = insertelement <8 x half> undef, half %e, i32 0
  %s = shufflevector <8 x half> %i, <8 x half> undef, <8 x i32> zeroinitializer
  ret <8 x half> %s
}

define arm_aapcs_vfpcc <8 x half> @extret4_v8f16_hf(<8 x half> %a, <8 x half> %b, half* nocapture %p) {
; CHECK-LABEL: extret4_v8f16_hf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vadd.f16 q0, q0, q1
; CHECK-NEXT:    vmov.u16 r1, q0[4]
; CHECK-NEXT:    vdup.16 q0, r1
; CHECK-NEXT:    strh r1, [r0]
; CHECK-NEXT:    bx lr
  %c = fadd <8 x half> %a, %b
  %e = extractelement <8 x half> %c, i32 4
  store half %e, half* %p, align 2
  %i = insertelement <8 x half> undef, half %e, i32 0
  %s = shufflevector <8 x half> %i, <8 x half> undef, <8 x i32> zeroinitializer
  ret <8 x half> %s
}


define float @extret1_f32_sf(<4 x float> %a, <4 x float> %b, float* nocapture %p) {
; CHECK-LABEL: extret1_f32_sf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov d0, r0, r1
; CHECK-NEXT:    mov r0, sp
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    ldr r1, [sp, #16]
; CHECK-NEXT:    vadd.f32 q0, q0, q1
; CHECK-NEXT:    vmov r0, s1
; CHECK-NEXT:    vstr s1, [r1]
; CHECK-NEXT:    bx lr
  %c = fadd <4 x float> %a, %b
  %e = extractelement <4 x float> %c, i32 1
  store float %e, float* %p, align 4
  ret float %e
}

define float @extret2_f32_sf(<4 x float> %a, <4 x float> %b, float* nocapture %p) {
; CHECK-LABEL: extret2_f32_sf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r0, sp
; CHECK-NEXT:    vmov d1, r2, r3
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    ldr r1, [sp, #16]
; CHECK-NEXT:    vadd.f32 q0, q0, q1
; CHECK-NEXT:    vmov r0, s2
; CHECK-NEXT:    vstr s2, [r1]
; CHECK-NEXT:    bx lr
  %c = fadd <4 x float> %a, %b
  %e = extractelement <4 x float> %c, i32 2
  store float %e, float* %p, align 4
  ret float %e
}

define arm_aapcs_vfpcc float @extret1_f32_hf(<4 x float> %a, <4 x float> %b, float* nocapture %p) {
; CHECK-LABEL: extret1_f32_hf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vadd.f32 q0, q0, q1
; CHECK-NEXT:    vmov.f32 s0, s1
; CHECK-NEXT:    vstr s1, [r0]
; CHECK-NEXT:    bx lr
  %c = fadd <4 x float> %a, %b
  %e = extractelement <4 x float> %c, i32 1
  store float %e, float* %p, align 4
  ret float %e
}


define arm_aapcs_vfpcc float @extret2_f32_hf(<4 x float> %a, <4 x float> %b, float* nocapture %p) {
; CHECK-LABEL: extret2_f32_hf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vadd.f32 q0, q0, q1
; CHECK-NEXT:    vmov.f32 s0, s2
; CHECK-NEXT:    vstr s2, [r0]
; CHECK-NEXT:    bx lr
  %c = fadd <4 x float> %a, %b
  %e = extractelement <4 x float> %c, i32 2
  store float %e, float* %p, align 4
  ret float %e
}

define arm_aapcs_vfpcc <4 x float> @extret1_v4f32_hf(<4 x float> %a, <4 x float> %b, float* nocapture %p) {
; CHECK-LABEL: extret1_v4f32_hf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vadd.f32 q1, q0, q1
; CHECK-NEXT:    vmov r1, s5
; CHECK-NEXT:    vstr s5, [r0]
; CHECK-NEXT:    vdup.32 q0, r1
; CHECK-NEXT:    bx lr
  %c = fadd <4 x float> %a, %b
  %e = extractelement <4 x float> %c, i32 1
  store float %e, float* %p, align 4
  %i = insertelement <4 x float> undef, float %e, i32 0
  %s = shufflevector <4 x float> %i, <4 x float> undef, <4 x i32> zeroinitializer
  ret <4 x float> %s
}

define arm_aapcs_vfpcc <4 x float> @extret2_v4f32_hf(<4 x float> %a, <4 x float> %b, float* nocapture %p) {
; CHECK-LABEL: extret2_v4f32_hf:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vadd.f32 q1, q0, q1
; CHECK-NEXT:    vmov r1, s6
; CHECK-NEXT:    vstr s6, [r0]
; CHECK-NEXT:    vdup.32 q0, r1
; CHECK-NEXT:    bx lr
  %c = fadd <4 x float> %a, %b
  %e = extractelement <4 x float> %c, i32 2
  store float %e, float* %p, align 4
  %i = insertelement <4 x float> undef, float %e, i32 0
  %s = shufflevector <4 x float> %i, <4 x float> undef, <4 x i32> zeroinitializer
  ret <4 x float> %s
}
