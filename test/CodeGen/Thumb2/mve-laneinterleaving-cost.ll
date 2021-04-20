; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp -verify-machineinstrs %s -o - | FileCheck %s

define arm_aapcs_vfpcc <4 x i32> @loads_i32(<4 x i32> *%A, <4 x i32> *%B, <4 x i32> *%C) {
; CHECK-LABEL: loads_i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r6, lr}
; CHECK-NEXT:    push {r4, r5, r6, lr}
; CHECK-NEXT:    .vsave {d8, d9, d10, d11}
; CHECK-NEXT:    vpush {d8, d9, d10, d11}
; CHECK-NEXT:    vldrw.u32 q1, [r1]
; CHECK-NEXT:    vmov.i64 q0, #0xffffffff
; CHECK-NEXT:    vldrw.u32 q5, [r2]
; CHECK-NEXT:    vmov.f32 s8, s6
; CHECK-NEXT:    vmov.f32 s10, s7
; CHECK-NEXT:    vmov.f32 s6, s5
; CHECK-NEXT:    vand q2, q2, q0
; CHECK-NEXT:    vand q0, q1, q0
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vmov r4, r1, d4
; CHECK-NEXT:    vmov.f32 s12, s6
; CHECK-NEXT:    vmov.f32 s14, s7
; CHECK-NEXT:    vmov r5, s12
; CHECK-NEXT:    vmov.f32 s16, s22
; CHECK-NEXT:    vmov.f32 s18, s23
; CHECK-NEXT:    vmov r3, lr, d0
; CHECK-NEXT:    vmov.f32 s6, s5
; CHECK-NEXT:    vmov r0, r12, d5
; CHECK-NEXT:    vmov.f32 s8, s20
; CHECK-NEXT:    vmov.f32 s10, s21
; CHECK-NEXT:    adds r2, r5, r4
; CHECK-NEXT:    vmov r4, s16
; CHECK-NEXT:    asr.w r6, r5, #31
; CHECK-NEXT:    adcs r1, r6
; CHECK-NEXT:    asrl r2, r1, r4
; CHECK-NEXT:    vmov r1, s4
; CHECK-NEXT:    adds r6, r1, r3
; CHECK-NEXT:    vmov r3, s8
; CHECK-NEXT:    asr.w r4, r1, #31
; CHECK-NEXT:    adc.w r1, r4, lr
; CHECK-NEXT:    asrl r6, r1, r3
; CHECK-NEXT:    vmov r5, r4, d1
; CHECK-NEXT:    vmov r1, s14
; CHECK-NEXT:    vmov q0[2], q0[0], r6, r2
; CHECK-NEXT:    adds r0, r0, r1
; CHECK-NEXT:    asr.w r3, r1, #31
; CHECK-NEXT:    adc.w r1, r3, r12
; CHECK-NEXT:    vmov r3, s18
; CHECK-NEXT:    asrl r0, r1, r3
; CHECK-NEXT:    vmov r1, s6
; CHECK-NEXT:    adds r6, r1, r5
; CHECK-NEXT:    asr.w r2, r1, #31
; CHECK-NEXT:    adc.w r1, r2, r4
; CHECK-NEXT:    vmov r2, s10
; CHECK-NEXT:    asrl r6, r1, r2
; CHECK-NEXT:    vmov q0[3], q0[1], r6, r0
; CHECK-NEXT:    vpop {d8, d9, d10, d11}
; CHECK-NEXT:    pop {r4, r5, r6, pc}
entry:
  %a = load <4 x i32>, <4 x i32> *%A, align 4
  %b = load <4 x i32>, <4 x i32> *%B, align 4
  %c = load <4 x i32>, <4 x i32> *%C, align 4
  %sa = sext <4 x i32> %a to <4 x i64>
  %sb = zext <4 x i32> %b to <4 x i64>
  %sc = zext <4 x i32> %c to <4 x i64>
  %add = add <4 x i64> %sa, %sb
  %sh = ashr <4 x i64> %add, %sc
  %t = trunc <4 x i64> %sh to <4 x i32>
  ret <4 x i32> %t
}

define arm_aapcs_vfpcc <8 x i16> @loads_i16(<8 x i16> *%A, <8 x i16> *%B, <8 x i16> *%C) {
; CHECK-LABEL: loads_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vldrw.u32 q2, [r0]
; CHECK-NEXT:    vmovlb.s16 q1, q0
; CHECK-NEXT:    vmovlb.s16 q3, q2
; CHECK-NEXT:    vmovlt.s16 q0, q0
; CHECK-NEXT:    vmovlt.s16 q2, q2
; CHECK-NEXT:    vadd.i32 q0, q2, q0
; CHECK-NEXT:    vldrw.u32 q2, [r2]
; CHECK-NEXT:    vadd.i32 q1, q3, q1
; CHECK-NEXT:    vmovlt.u16 q3, q2
; CHECK-NEXT:    vneg.s32 q3, q3
; CHECK-NEXT:    vshl.s32 q3, q0, q3
; CHECK-NEXT:    vmovlb.u16 q0, q2
; CHECK-NEXT:    vneg.s32 q0, q0
; CHECK-NEXT:    vshl.s32 q0, q1, q0
; CHECK-NEXT:    vmovnt.i32 q0, q3
; CHECK-NEXT:    bx lr
entry:
  %a = load <8 x i16>, <8 x i16> *%A, align 4
  %b = load <8 x i16>, <8 x i16> *%B, align 4
  %c = load <8 x i16>, <8 x i16> *%C, align 4
  %sa = sext <8 x i16> %a to <8 x i32>
  %sb = sext <8 x i16> %b to <8 x i32>
  %sc = zext <8 x i16> %c to <8 x i32>
  %add = add <8 x i32> %sa, %sb
  %sh = ashr <8 x i32> %add, %sc
  %t = trunc <8 x i32> %sh to <8 x i16>
  ret <8 x i16> %t
}

define arm_aapcs_vfpcc <16 x i8> @loads_i8(<16 x i8> *%A, <16 x i8> *%B, <16 x i8> *%C) {
; CHECK-LABEL: loads_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vldrw.u32 q2, [r0]
; CHECK-NEXT:    vmovlb.s8 q1, q0
; CHECK-NEXT:    vmovlb.s8 q3, q2
; CHECK-NEXT:    vmovlt.s8 q0, q0
; CHECK-NEXT:    vmovlt.s8 q2, q2
; CHECK-NEXT:    vadd.i16 q0, q2, q0
; CHECK-NEXT:    vldrw.u32 q2, [r2]
; CHECK-NEXT:    vadd.i16 q1, q3, q1
; CHECK-NEXT:    vmovlt.u8 q3, q2
; CHECK-NEXT:    vneg.s16 q3, q3
; CHECK-NEXT:    vshl.s16 q3, q0, q3
; CHECK-NEXT:    vmovlb.u8 q0, q2
; CHECK-NEXT:    vneg.s16 q0, q0
; CHECK-NEXT:    vshl.s16 q0, q1, q0
; CHECK-NEXT:    vmovnt.i16 q0, q3
; CHECK-NEXT:    bx lr
entry:
  %a = load <16 x i8>, <16 x i8> *%A, align 4
  %b = load <16 x i8>, <16 x i8> *%B, align 4
  %c = load <16 x i8>, <16 x i8> *%C, align 4
  %sa = sext <16 x i8> %a to <16 x i16>
  %sb = sext <16 x i8> %b to <16 x i16>
  %sc = zext <16 x i8> %c to <16 x i16>
  %add = add <16 x i16> %sa, %sb
  %sh = ashr <16 x i16> %add, %sc
  %t = trunc <16 x i16> %sh to <16 x i8>
  ret <16 x i8> %t
}

define arm_aapcs_vfpcc void @load_store_i32(<4 x i32> *%A, <4 x i32> *%B, <4 x i32> *%C, <4 x i32> *%D) {
; CHECK-LABEL: load_store_i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r6, r7, lr}
; CHECK-NEXT:    push {r4, r5, r6, r7, lr}
; CHECK-NEXT:    .pad #4
; CHECK-NEXT:    sub sp, #4
; CHECK-NEXT:    .vsave {d8, d9, d10, d11}
; CHECK-NEXT:    vpush {d8, d9, d10, d11}
; CHECK-NEXT:    vldrw.u32 q2, [r1]
; CHECK-NEXT:    vmov.i64 q0, #0xffffffff
; CHECK-NEXT:    vldrw.u32 q5, [r2]
; CHECK-NEXT:    vmov.f32 s4, s10
; CHECK-NEXT:    vmov.f32 s6, s11
; CHECK-NEXT:    vmov.f32 s10, s9
; CHECK-NEXT:    vand q1, q1, q0
; CHECK-NEXT:    vand q2, q2, q0
; CHECK-NEXT:    vldrw.u32 q0, [r0]
; CHECK-NEXT:    vmov r5, r1, d2
; CHECK-NEXT:    vmov.f32 s12, s2
; CHECK-NEXT:    vmov.f32 s14, s3
; CHECK-NEXT:    vmov r6, s12
; CHECK-NEXT:    vmov.f32 s16, s22
; CHECK-NEXT:    vmov.f32 s18, s23
; CHECK-NEXT:    vmov r4, lr, d4
; CHECK-NEXT:    vmov.f32 s2, s1
; CHECK-NEXT:    vmov r0, r12, d3
; CHECK-NEXT:    vmov.f32 s4, s20
; CHECK-NEXT:    vmov.f32 s6, s21
; CHECK-NEXT:    adds r2, r6, r5
; CHECK-NEXT:    vmov r5, s16
; CHECK-NEXT:    asr.w r7, r6, #31
; CHECK-NEXT:    adcs r1, r7
; CHECK-NEXT:    asrl r2, r1, r5
; CHECK-NEXT:    vmov r7, s4
; CHECK-NEXT:    vmov r1, s0
; CHECK-NEXT:    adds r4, r4, r1
; CHECK-NEXT:    asr.w r5, r1, #31
; CHECK-NEXT:    adc.w r1, r5, lr
; CHECK-NEXT:    asrl r4, r1, r7
; CHECK-NEXT:    vmov r6, r5, d5
; CHECK-NEXT:    vmov r1, s14
; CHECK-NEXT:    vmov q2[2], q2[0], r4, r2
; CHECK-NEXT:    adds r0, r0, r1
; CHECK-NEXT:    asr.w r7, r1, #31
; CHECK-NEXT:    adc.w r1, r7, r12
; CHECK-NEXT:    vmov r7, s18
; CHECK-NEXT:    asrl r0, r1, r7
; CHECK-NEXT:    vmov r1, s2
; CHECK-NEXT:    adds r6, r6, r1
; CHECK-NEXT:    asr.w r2, r1, #31
; CHECK-NEXT:    adc.w r1, r2, r5
; CHECK-NEXT:    vmov r2, s6
; CHECK-NEXT:    asrl r6, r1, r2
; CHECK-NEXT:    vmov q2[3], q2[1], r6, r0
; CHECK-NEXT:    vstrw.32 q2, [r3]
; CHECK-NEXT:    vpop {d8, d9, d10, d11}
; CHECK-NEXT:    add sp, #4
; CHECK-NEXT:    pop {r4, r5, r6, r7, pc}
entry:
  %a = load <4 x i32>, <4 x i32> *%A, align 4
  %b = load <4 x i32>, <4 x i32> *%B, align 4
  %c = load <4 x i32>, <4 x i32> *%C, align 4
  %sa = sext <4 x i32> %a to <4 x i64>
  %sb = zext <4 x i32> %b to <4 x i64>
  %sc = zext <4 x i32> %c to <4 x i64>
  %add = add <4 x i64> %sa, %sb
  %sh = ashr <4 x i64> %add, %sc
  %t = trunc <4 x i64> %sh to <4 x i32>
  store <4 x i32> %t, <4 x i32> *%D, align 4
  ret void
}

define arm_aapcs_vfpcc void @load_store_i16(<8 x i16> *%A, <8 x i16> *%B, <8 x i16> *%C, <8 x i16> *%D) {
; CHECK-LABEL: load_store_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.s32 q0, [r1, #8]
; CHECK-NEXT:    vldrh.s32 q1, [r0, #8]
; CHECK-NEXT:    vldrh.s32 q2, [r0]
; CHECK-NEXT:    vadd.i32 q0, q1, q0
; CHECK-NEXT:    vldrh.u32 q1, [r2, #8]
; CHECK-NEXT:    vneg.s32 q1, q1
; CHECK-NEXT:    vshl.s32 q0, q0, q1
; CHECK-NEXT:    vldrh.s32 q1, [r1]
; CHECK-NEXT:    vadd.i32 q1, q2, q1
; CHECK-NEXT:    vldrh.u32 q2, [r2]
; CHECK-NEXT:    vstrh.32 q0, [r3, #8]
; CHECK-NEXT:    vneg.s32 q2, q2
; CHECK-NEXT:    vshl.s32 q1, q1, q2
; CHECK-NEXT:    vstrh.32 q1, [r3]
; CHECK-NEXT:    bx lr
entry:
  %a = load <8 x i16>, <8 x i16> *%A, align 4
  %b = load <8 x i16>, <8 x i16> *%B, align 4
  %c = load <8 x i16>, <8 x i16> *%C, align 4
  %sa = sext <8 x i16> %a to <8 x i32>
  %sb = sext <8 x i16> %b to <8 x i32>
  %sc = zext <8 x i16> %c to <8 x i32>
  %add = add <8 x i32> %sa, %sb
  %sh = ashr <8 x i32> %add, %sc
  %t = trunc <8 x i32> %sh to <8 x i16>
  store <8 x i16> %t, <8 x i16> *%D, align 4
  ret void
}

define arm_aapcs_vfpcc void @load_store_i8(<16 x i8> *%A, <16 x i8> *%B, <16 x i8> *%C, <16 x i8> *%D) {
; CHECK-LABEL: load_store_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.s16 q0, [r1, #8]
; CHECK-NEXT:    vldrb.s16 q1, [r0, #8]
; CHECK-NEXT:    vldrb.s16 q2, [r0]
; CHECK-NEXT:    vadd.i16 q0, q1, q0
; CHECK-NEXT:    vldrb.u16 q1, [r2, #8]
; CHECK-NEXT:    vneg.s16 q1, q1
; CHECK-NEXT:    vshl.s16 q0, q0, q1
; CHECK-NEXT:    vldrb.s16 q1, [r1]
; CHECK-NEXT:    vadd.i16 q1, q2, q1
; CHECK-NEXT:    vldrb.u16 q2, [r2]
; CHECK-NEXT:    vstrb.16 q0, [r3, #8]
; CHECK-NEXT:    vneg.s16 q2, q2
; CHECK-NEXT:    vshl.s16 q1, q1, q2
; CHECK-NEXT:    vstrb.16 q1, [r3]
; CHECK-NEXT:    bx lr
entry:
  %a = load <16 x i8>, <16 x i8> *%A, align 4
  %b = load <16 x i8>, <16 x i8> *%B, align 4
  %c = load <16 x i8>, <16 x i8> *%C, align 4
  %sa = sext <16 x i8> %a to <16 x i16>
  %sb = sext <16 x i8> %b to <16 x i16>
  %sc = zext <16 x i8> %c to <16 x i16>
  %add = add <16 x i16> %sa, %sb
  %sh = ashr <16 x i16> %add, %sc
  %t = trunc <16 x i16> %sh to <16 x i8>
  store <16 x i8> %t, <16 x i8> *%D, align 4
  ret void
}


define arm_aapcs_vfpcc void @load_one_store_i32(<4 x i32> *%A, <4 x i32> *%D) {
; CHECK-LABEL: load_one_store_i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r7, lr}
; CHECK-NEXT:    push {r4, r5, r7, lr}
; CHECK-NEXT:    vldrw.u32 q0, [r0]
; CHECK-NEXT:    vmov.f32 s4, s2
; CHECK-NEXT:    vmov.f32 s6, s3
; CHECK-NEXT:    vmov.f32 s2, s1
; CHECK-NEXT:    vmov r2, s6
; CHECK-NEXT:    adds.w r12, r2, r2
; CHECK-NEXT:    asr.w r3, r2, #31
; CHECK-NEXT:    adc.w r7, r3, r2, asr #31
; CHECK-NEXT:    vmov r3, s4
; CHECK-NEXT:    asrl r12, r7, r2
; CHECK-NEXT:    adds r0, r3, r3
; CHECK-NEXT:    asr.w r5, r3, #31
; CHECK-NEXT:    adc.w r5, r5, r3, asr #31
; CHECK-NEXT:    asrl r0, r5, r3
; CHECK-NEXT:    vmov r3, s0
; CHECK-NEXT:    adds r4, r3, r3
; CHECK-NEXT:    asr.w r5, r3, #31
; CHECK-NEXT:    adc.w r5, r5, r3, asr #31
; CHECK-NEXT:    asrl r4, r5, r3
; CHECK-NEXT:    vmov q1[2], q1[0], r4, r0
; CHECK-NEXT:    vmov r0, s2
; CHECK-NEXT:    adds r4, r0, r0
; CHECK-NEXT:    asr.w r2, r0, #31
; CHECK-NEXT:    adc.w r3, r2, r0, asr #31
; CHECK-NEXT:    asrl r4, r3, r0
; CHECK-NEXT:    vmov q1[3], q1[1], r4, r12
; CHECK-NEXT:    vstrw.32 q1, [r1]
; CHECK-NEXT:    pop {r4, r5, r7, pc}
entry:
  %a = load <4 x i32>, <4 x i32> *%A, align 4
  %sa = sext <4 x i32> %a to <4 x i64>
  %add = add <4 x i64> %sa, %sa
  %sh = ashr <4 x i64> %add, %sa
  %t = trunc <4 x i64> %sh to <4 x i32>
  store <4 x i32> %t, <4 x i32> *%D, align 4
  ret void
}

define arm_aapcs_vfpcc void @load_one_store_i16(<8 x i16> *%A, <8 x i16> *%D) {
; CHECK-LABEL: load_one_store_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.s32 q0, [r0, #8]
; CHECK-NEXT:    vneg.s32 q1, q0
; CHECK-NEXT:    vadd.i32 q0, q0, q0
; CHECK-NEXT:    vshl.s32 q0, q0, q1
; CHECK-NEXT:    vldrh.s32 q1, [r0]
; CHECK-NEXT:    vstrh.32 q0, [r1, #8]
; CHECK-NEXT:    vneg.s32 q2, q1
; CHECK-NEXT:    vadd.i32 q1, q1, q1
; CHECK-NEXT:    vshl.s32 q1, q1, q2
; CHECK-NEXT:    vstrh.32 q1, [r1]
; CHECK-NEXT:    bx lr
entry:
  %a = load <8 x i16>, <8 x i16> *%A, align 4
  %sa = sext <8 x i16> %a to <8 x i32>
  %add = add <8 x i32> %sa, %sa
  %sh = ashr <8 x i32> %add, %sa
  %t = trunc <8 x i32> %sh to <8 x i16>
  store <8 x i16> %t, <8 x i16> *%D, align 4
  ret void
}

define arm_aapcs_vfpcc void @load_one_store_i8(<16 x i8> *%A, <16 x i8> *%D) {
; CHECK-LABEL: load_one_store_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.s16 q0, [r0, #8]
; CHECK-NEXT:    vneg.s16 q1, q0
; CHECK-NEXT:    vadd.i16 q0, q0, q0
; CHECK-NEXT:    vshl.s16 q0, q0, q1
; CHECK-NEXT:    vldrb.s16 q1, [r0]
; CHECK-NEXT:    vstrb.16 q0, [r1, #8]
; CHECK-NEXT:    vneg.s16 q2, q1
; CHECK-NEXT:    vadd.i16 q1, q1, q1
; CHECK-NEXT:    vshl.s16 q1, q1, q2
; CHECK-NEXT:    vstrb.16 q1, [r1]
; CHECK-NEXT:    bx lr
entry:
  %a = load <16 x i8>, <16 x i8> *%A, align 4
  %sa = sext <16 x i8> %a to <16 x i16>
  %add = add <16 x i16> %sa, %sa
  %sh = ashr <16 x i16> %add, %sa
  %t = trunc <16 x i16> %sh to <16 x i8>
  store <16 x i8> %t, <16 x i8> *%D, align 4
  ret void
}


define arm_aapcs_vfpcc void @mul_i32(<4 x i32> *%A, <4 x i32> *%B, i64 %C, <4 x i32> *%D) {
; CHECK-LABEL: mul_i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r6, r7, lr}
; CHECK-NEXT:    push {r4, r5, r6, r7, lr}
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    ldr.w lr, [sp, #20]
; CHECK-NEXT:    vmov.f32 s8, s0
; CHECK-NEXT:    vmov.f32 s12, s4
; CHECK-NEXT:    vmov.f32 s14, s5
; CHECK-NEXT:    vmov.f32 s10, s1
; CHECK-NEXT:    vmov r5, s12
; CHECK-NEXT:    vmov r1, s14
; CHECK-NEXT:    vmov r0, s10
; CHECK-NEXT:    smull r12, r3, r1, r0
; CHECK-NEXT:    vmov r0, s8
; CHECK-NEXT:    vmov.f32 s8, s2
; CHECK-NEXT:    vmov.f32 s10, s3
; CHECK-NEXT:    vmov.f32 s0, s6
; CHECK-NEXT:    asrl r12, r3, r2
; CHECK-NEXT:    vmov.f32 s2, s7
; CHECK-NEXT:    vmullb.s32 q1, q0, q2
; CHECK-NEXT:    vmov r6, r1, d2
; CHECK-NEXT:    vmov r4, r7, d3
; CHECK-NEXT:    asrl r6, r1, r2
; CHECK-NEXT:    asrl r4, r7, r2
; CHECK-NEXT:    smull r0, r5, r5, r0
; CHECK-NEXT:    asrl r0, r5, r2
; CHECK-NEXT:    vmov q0[2], q0[0], r0, r6
; CHECK-NEXT:    vmov q0[3], q0[1], r12, r4
; CHECK-NEXT:    vstrw.32 q0, [lr]
; CHECK-NEXT:    pop {r4, r5, r6, r7, pc}
entry:
  %a = load <4 x i32>, <4 x i32> *%A, align 4
  %b = load <4 x i32>, <4 x i32> *%B, align 4
  %i = insertelement <4 x i64> undef, i64 %C, i32 0
  %c = shufflevector <4 x i64> %i, <4 x i64> undef, <4 x i32> zeroinitializer
  %sa = sext <4 x i32> %a to <4 x i64>
  %sb = sext <4 x i32> %b to <4 x i64>
  %add = mul <4 x i64> %sa, %sb
  %sh = ashr <4 x i64> %add, %c
  %t = trunc <4 x i64> %sh to <4 x i32>
  store <4 x i32> %t, <4 x i32> *%D, align 4
  ret void
}

define arm_aapcs_vfpcc void @mul_i16(<8 x i16> *%A, <8 x i16> *%B, i32 %C, <8 x i16> *%D) {
; CHECK-LABEL: mul_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    rsbs r2, r2, #0
; CHECK-NEXT:    vmullt.s16 q2, q1, q0
; CHECK-NEXT:    vmullb.s16 q0, q1, q0
; CHECK-NEXT:    vshl.s32 q2, r2
; CHECK-NEXT:    vshl.s32 q0, r2
; CHECK-NEXT:    vmovnt.i32 q0, q2
; CHECK-NEXT:    vstrw.32 q0, [r3]
; CHECK-NEXT:    bx lr
entry:
  %a = load <8 x i16>, <8 x i16> *%A, align 4
  %b = load <8 x i16>, <8 x i16> *%B, align 4
  %i = insertelement <8 x i32> undef, i32 %C, i32 0
  %c = shufflevector <8 x i32> %i, <8 x i32> undef, <8 x i32> zeroinitializer
  %sa = sext <8 x i16> %a to <8 x i32>
  %sb = sext <8 x i16> %b to <8 x i32>
  %add = mul <8 x i32> %sa, %sb
  %sh = ashr <8 x i32> %add, %c
  %t = trunc <8 x i32> %sh to <8 x i16>
  store <8 x i16> %t, <8 x i16> *%D, align 4
  ret void
}

define arm_aapcs_vfpcc void @mul_i8(<16 x i8> *%A, <16 x i8> *%B, i16 %C, <16 x i8> *%D) {
; CHECK-LABEL: mul_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrw.u32 q0, [r1]
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    rsbs r2, r2, #0
; CHECK-NEXT:    vmullt.s8 q2, q1, q0
; CHECK-NEXT:    vmullb.s8 q0, q1, q0
; CHECK-NEXT:    vshl.s16 q2, r2
; CHECK-NEXT:    vshl.s16 q0, r2
; CHECK-NEXT:    vmovnt.i16 q0, q2
; CHECK-NEXT:    vstrw.32 q0, [r3]
; CHECK-NEXT:    bx lr
entry:
  %a = load <16 x i8>, <16 x i8> *%A, align 4
  %b = load <16 x i8>, <16 x i8> *%B, align 4
  %i = insertelement <16 x i16> undef, i16 %C, i32 0
  %c = shufflevector <16 x i16> %i, <16 x i16> undef, <16 x i32> zeroinitializer
  %sa = sext <16 x i8> %a to <16 x i16>
  %sb = sext <16 x i8> %b to <16 x i16>
  %add = mul <16 x i16> %sa, %sb
  %sh = ashr <16 x i16> %add, %c
  %t = trunc <16 x i16> %sh to <16 x i8>
  store <16 x i8> %t, <16 x i8> *%D, align 4
  ret void
}
