; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-arm-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s --check-prefix=CHECK

define arm_aapcs_vfpcc i32 @add_v4i32_v4i32(<4 x i32> %x) {
; CHECK-LABEL: add_v4i32_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vaddv.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %z = call i32 @llvm.experimental.vector.reduce.add.v4i32(<4 x i32> %x)
  ret i32 %z
}

define arm_aapcs_vfpcc i64 @add_v4i32_v4i64_zext(<4 x i32> %x) {
; CHECK-LABEL: add_v4i32_v4i64_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    adr r0, .LCPI1_0
; CHECK-NEXT:    vmov.f32 s4, s0
; CHECK-NEXT:    vldrw.u32 q2, [r0]
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vand q1, q1, q2
; CHECK-NEXT:    vmov r2, s6
; CHECK-NEXT:    vmov r3, s4
; CHECK-NEXT:    vmov r0, s7
; CHECK-NEXT:    vmov r1, s5
; CHECK-NEXT:    vmov.f32 s4, s2
; CHECK-NEXT:    vmov.f32 s6, s3
; CHECK-NEXT:    vand q0, q1, q2
; CHECK-NEXT:    adds r2, r2, r3
; CHECK-NEXT:    vmov r3, s0
; CHECK-NEXT:    adcs r0, r1
; CHECK-NEXT:    vmov r1, s1
; CHECK-NEXT:    adds r2, r2, r3
; CHECK-NEXT:    vmov r3, s3
; CHECK-NEXT:    adcs r1, r0
; CHECK-NEXT:    vmov r0, s2
; CHECK-NEXT:    adds r0, r0, r2
; CHECK-NEXT:    adcs r1, r3
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI1_0:
; CHECK-NEXT:    .long 4294967295 @ 0xffffffff
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 4294967295 @ 0xffffffff
; CHECK-NEXT:    .long 0 @ 0x0
entry:
  %xx = zext <4 x i32> %x to <4 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v4i64(<4 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i64 @add_v4i32_v4i64_sext(<4 x i32> %x) {
; CHECK-LABEL: add_v4i32_v4i64_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s0
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov.32 q2[0], r0
; CHECK-NEXT:    asrs r0, r0, #31
; CHECK-NEXT:    vmov.32 q2[1], r0
; CHECK-NEXT:    vmov r0, s6
; CHECK-NEXT:    vmov.32 q2[2], r0
; CHECK-NEXT:    vmov.f32 s4, s2
; CHECK-NEXT:    vmov.f32 s6, s3
; CHECK-NEXT:    asrs r1, r0, #31
; CHECK-NEXT:    vmov.32 q2[3], r1
; CHECK-NEXT:    vmov r2, s10
; CHECK-NEXT:    vmov r3, s8
; CHECK-NEXT:    vmov r1, s9
; CHECK-NEXT:    adds r2, r2, r3
; CHECK-NEXT:    vmov r3, s6
; CHECK-NEXT:    adc.w r0, r1, r0, asr #31
; CHECK-NEXT:    vmov r1, s4
; CHECK-NEXT:    adds r2, r2, r1
; CHECK-NEXT:    adc.w r1, r0, r1, asr #31
; CHECK-NEXT:    adds r0, r2, r3
; CHECK-NEXT:    adc.w r1, r1, r3, asr #31
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <4 x i32> %x to <4 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v4i64(<4 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i64 @add_v2i32_v2i64_zext(<2 x i32> %x) {
; CHECK-LABEL: add_v2i32_v2i64_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    adr r0, .LCPI3_0
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vand q0, q0, q1
; CHECK-NEXT:    vmov r0, s2
; CHECK-NEXT:    vmov r3, s0
; CHECK-NEXT:    vmov r1, s3
; CHECK-NEXT:    vmov r2, s1
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI3_0:
; CHECK-NEXT:    .long 4294967295 @ 0xffffffff
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 4294967295 @ 0xffffffff
; CHECK-NEXT:    .long 0 @ 0x0
entry:
  %xx = zext <2 x i32> %x to <2 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v2i64(<2 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i64 @add_v2i32_v2i64_sext(<2 x i32> %x) {
; CHECK-LABEL: add_v2i32_v2i64_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    vmov.32 q1[0], r0
; CHECK-NEXT:    vmov r2, s2
; CHECK-NEXT:    asrs r1, r0, #31
; CHECK-NEXT:    vmov.32 q1[1], r1
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    adds r0, r0, r2
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <2 x i32> %x to <2 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v2i64(<2 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i32 @add_v8i16_v8i32_zext(<8 x i16> %x) {
; CHECK-LABEL: add_v8i16_v8i32_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u16 r0, q0[4]
; CHECK-NEXT:    vmov.32 q1[0], r0
; CHECK-NEXT:    vmov.u16 r0, q0[5]
; CHECK-NEXT:    vmov.32 q1[1], r0
; CHECK-NEXT:    vmov.u16 r0, q0[6]
; CHECK-NEXT:    vmov.32 q1[2], r0
; CHECK-NEXT:    vmov.u16 r0, q0[7]
; CHECK-NEXT:    vmov.32 q1[3], r0
; CHECK-NEXT:    vmov.u16 r0, q0[0]
; CHECK-NEXT:    vmov.32 q2[0], r0
; CHECK-NEXT:    vmov.u16 r0, q0[1]
; CHECK-NEXT:    vmov.32 q2[1], r0
; CHECK-NEXT:    vmov.u16 r0, q0[2]
; CHECK-NEXT:    vmov.32 q2[2], r0
; CHECK-NEXT:    vmov.u16 r0, q0[3]
; CHECK-NEXT:    vmov.32 q2[3], r0
; CHECK-NEXT:    vmovlb.u16 q1, q1
; CHECK-NEXT:    vmovlb.u16 q0, q2
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    vaddv.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %xx = zext <8 x i16> %x to <8 x i32>
  %z = call i32 @llvm.experimental.vector.reduce.add.v8i32(<8 x i32> %xx)
  ret i32 %z
}

define arm_aapcs_vfpcc i32 @add_v8i16_v8i32_sext(<8 x i16> %x) {
; CHECK-LABEL: add_v8i16_v8i32_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u16 r0, q0[4]
; CHECK-NEXT:    vmov.32 q1[0], r0
; CHECK-NEXT:    vmov.u16 r0, q0[5]
; CHECK-NEXT:    vmov.32 q1[1], r0
; CHECK-NEXT:    vmov.u16 r0, q0[6]
; CHECK-NEXT:    vmov.32 q1[2], r0
; CHECK-NEXT:    vmov.u16 r0, q0[7]
; CHECK-NEXT:    vmov.32 q1[3], r0
; CHECK-NEXT:    vmov.u16 r0, q0[0]
; CHECK-NEXT:    vmov.32 q2[0], r0
; CHECK-NEXT:    vmov.u16 r0, q0[1]
; CHECK-NEXT:    vmov.32 q2[1], r0
; CHECK-NEXT:    vmov.u16 r0, q0[2]
; CHECK-NEXT:    vmov.32 q2[2], r0
; CHECK-NEXT:    vmov.u16 r0, q0[3]
; CHECK-NEXT:    vmov.32 q2[3], r0
; CHECK-NEXT:    vmovlb.s16 q1, q1
; CHECK-NEXT:    vmovlb.s16 q0, q2
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    vaddv.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <8 x i16> %x to <8 x i32>
  %z = call i32 @llvm.experimental.vector.reduce.add.v8i32(<8 x i32> %xx)
  ret i32 %z
}

define arm_aapcs_vfpcc i32 @add_v4i16_v4i32_zext(<4 x i16> %x) {
; CHECK-LABEL: add_v4i16_v4i32_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovlb.u16 q0, q0
; CHECK-NEXT:    vaddv.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %xx = zext <4 x i16> %x to <4 x i32>
  %z = call i32 @llvm.experimental.vector.reduce.add.v4i32(<4 x i32> %xx)
  ret i32 %z
}

define arm_aapcs_vfpcc i32 @add_v4i16_v4i32_sext(<4 x i16> %x) {
; CHECK-LABEL: add_v4i16_v4i32_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovlb.s16 q0, q0
; CHECK-NEXT:    vaddv.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <4 x i16> %x to <4 x i32>
  %z = call i32 @llvm.experimental.vector.reduce.add.v4i32(<4 x i32> %xx)
  ret i32 %z
}

define arm_aapcs_vfpcc i16 @add_v8i16_v8i16(<8 x i16> %x) {
; CHECK-LABEL: add_v8i16_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vaddv.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %z = call i16 @llvm.experimental.vector.reduce.add.v8i16(<8 x i16> %x)
  ret i16 %z
}

define arm_aapcs_vfpcc i64 @add_v8i16_v8i64_zext(<8 x i16> %x) {
; CHECK-LABEL: add_v8i16_v8i64_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u16 r0, q0[0]
; CHECK-NEXT:    vmov.32 q2[0], r0
; CHECK-NEXT:    vmov.u16 r0, q0[1]
; CHECK-NEXT:    vmov.32 q2[2], r0
; CHECK-NEXT:    adr r0, .LCPI10_0
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vand q2, q2, q1
; CHECK-NEXT:    vmov r0, s10
; CHECK-NEXT:    vmov r1, s8
; CHECK-NEXT:    vmov r2, s11
; CHECK-NEXT:    add r0, r1
; CHECK-NEXT:    vmov.u16 r1, q0[2]
; CHECK-NEXT:    vmov.32 q3[0], r1
; CHECK-NEXT:    vmov.u16 r1, q0[3]
; CHECK-NEXT:    vmov.32 q3[2], r1
; CHECK-NEXT:    vand q3, q3, q1
; CHECK-NEXT:    vmov r1, s12
; CHECK-NEXT:    add r0, r1
; CHECK-NEXT:    vmov r1, s14
; CHECK-NEXT:    add r0, r1
; CHECK-NEXT:    vmov.u16 r1, q0[4]
; CHECK-NEXT:    vmov.32 q3[0], r1
; CHECK-NEXT:    vmov.u16 r1, q0[5]
; CHECK-NEXT:    vmov.32 q3[2], r1
; CHECK-NEXT:    vand q3, q3, q1
; CHECK-NEXT:    vmov r1, s12
; CHECK-NEXT:    vmov r3, s14
; CHECK-NEXT:    add r0, r1
; CHECK-NEXT:    vmov r1, s15
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov.u16 r2, q0[6]
; CHECK-NEXT:    vmov.32 q2[0], r2
; CHECK-NEXT:    vmov.u16 r2, q0[7]
; CHECK-NEXT:    vmov.32 q2[2], r2
; CHECK-NEXT:    vand q0, q2, q1
; CHECK-NEXT:    vmov r3, s0
; CHECK-NEXT:    vmov r2, s1
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    vmov r3, s2
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov r2, s3
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI10_0:
; CHECK-NEXT:    .long 65535 @ 0xffff
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 65535 @ 0xffff
; CHECK-NEXT:    .long 0 @ 0x0
entry:
  %xx = zext <8 x i16> %x to <8 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v8i64(<8 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i64 @add_v8i16_v8i64_sext(<8 x i16> %x) {
; CHECK-LABEL: add_v8i16_v8i64_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u16 r0, q0[0]
; CHECK-NEXT:    sxth r0, r0
; CHECK-NEXT:    vmov.32 q1[0], r0
; CHECK-NEXT:    asrs r0, r0, #31
; CHECK-NEXT:    vmov.32 q1[1], r0
; CHECK-NEXT:    vmov.u16 r0, q0[1]
; CHECK-NEXT:    sxth r0, r0
; CHECK-NEXT:    vmov.32 q1[2], r0
; CHECK-NEXT:    asrs r1, r0, #31
; CHECK-NEXT:    vmov.32 q1[3], r1
; CHECK-NEXT:    vmov r2, s6
; CHECK-NEXT:    vmov r3, s4
; CHECK-NEXT:    vmov r1, s5
; CHECK-NEXT:    adds r2, r2, r3
; CHECK-NEXT:    adc.w r12, r1, r0, asr #31
; CHECK-NEXT:    vmov.u16 r1, q0[2]
; CHECK-NEXT:    sxth r1, r1
; CHECK-NEXT:    vmov.32 q1[0], r1
; CHECK-NEXT:    asrs r1, r1, #31
; CHECK-NEXT:    vmov.32 q1[1], r1
; CHECK-NEXT:    vmov.u16 r1, q0[3]
; CHECK-NEXT:    sxth r1, r1
; CHECK-NEXT:    vmov.32 q1[2], r1
; CHECK-NEXT:    asrs r3, r1, #31
; CHECK-NEXT:    vmov.32 q1[3], r3
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov r3, s5
; CHECK-NEXT:    adds r0, r0, r2
; CHECK-NEXT:    adc.w r2, r12, r3
; CHECK-NEXT:    vmov r3, s6
; CHECK-NEXT:    adds.w r12, r0, r3
; CHECK-NEXT:    adc.w r1, r2, r1, asr #31
; CHECK-NEXT:    vmov.u16 r2, q0[4]
; CHECK-NEXT:    sxth r2, r2
; CHECK-NEXT:    vmov.32 q1[0], r2
; CHECK-NEXT:    asrs r2, r2, #31
; CHECK-NEXT:    vmov.32 q1[1], r2
; CHECK-NEXT:    vmov.u16 r2, q0[5]
; CHECK-NEXT:    sxth r2, r2
; CHECK-NEXT:    vmov.32 q1[2], r2
; CHECK-NEXT:    asrs r3, r2, #31
; CHECK-NEXT:    vmov.32 q1[3], r3
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov r3, s5
; CHECK-NEXT:    adds.w r0, r0, r12
; CHECK-NEXT:    adcs r1, r3
; CHECK-NEXT:    vmov r3, s6
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    vmov.u16 r2, q0[6]
; CHECK-NEXT:    sxth r2, r2
; CHECK-NEXT:    adds r0, r0, r2
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    vmov.u16 r2, q0[7]
; CHECK-NEXT:    sxth r2, r2
; CHECK-NEXT:    adds r0, r0, r2
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <8 x i16> %x to <8 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v8i64(<8 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i64 @add_v2i16_v2i64_zext(<2 x i16> %x) {
; CHECK-LABEL: add_v2i16_v2i64_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    adr r0, .LCPI12_0
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vand q0, q0, q1
; CHECK-NEXT:    vmov r0, s2
; CHECK-NEXT:    vmov r1, s0
; CHECK-NEXT:    add r0, r1
; CHECK-NEXT:    vmov r1, s3
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI12_0:
; CHECK-NEXT:    .long 65535 @ 0xffff
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 65535 @ 0xffff
; CHECK-NEXT:    .long 0 @ 0x0
entry:
  %xx = zext <2 x i16> %x to <2 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v2i64(<2 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i64 @add_v2i16_v2i64_sext(<2 x i16> %x) {
; CHECK-LABEL: add_v2i16_v2i64_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    vmov r2, s2
; CHECK-NEXT:    sxth r0, r0
; CHECK-NEXT:    vmov.32 q1[0], r0
; CHECK-NEXT:    asrs r1, r0, #31
; CHECK-NEXT:    vmov.32 q1[1], r1
; CHECK-NEXT:    sxth r2, r2
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    adds r0, r0, r2
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <2 x i16> %x to <2 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v2i64(<2 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i32 @add_v16i8_v16i32_zext(<16 x i8> %x) {
; CHECK-LABEL: add_v16i8_v16i32_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9}
; CHECK-NEXT:    vpush {d8, d9}
; CHECK-NEXT:    vmov.u8 r0, q0[12]
; CHECK-NEXT:    vmov.i32 q1, #0xff
; CHECK-NEXT:    vmov.32 q2[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[13]
; CHECK-NEXT:    vmov.32 q2[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[14]
; CHECK-NEXT:    vmov.32 q2[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[15]
; CHECK-NEXT:    vmov.32 q2[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[4]
; CHECK-NEXT:    vmov.32 q3[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[5]
; CHECK-NEXT:    vmov.32 q3[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[6]
; CHECK-NEXT:    vmov.32 q3[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[7]
; CHECK-NEXT:    vmov.32 q3[3], r0
; CHECK-NEXT:    vand q2, q2, q1
; CHECK-NEXT:    vand q3, q3, q1
; CHECK-NEXT:    vmov.u8 r0, q0[8]
; CHECK-NEXT:    vadd.i32 q2, q3, q2
; CHECK-NEXT:    vmov.32 q3[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[9]
; CHECK-NEXT:    vmov.32 q3[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[10]
; CHECK-NEXT:    vmov.32 q3[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[11]
; CHECK-NEXT:    vmov.32 q3[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[0]
; CHECK-NEXT:    vmov.32 q4[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[1]
; CHECK-NEXT:    vmov.32 q4[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[2]
; CHECK-NEXT:    vmov.32 q4[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[3]
; CHECK-NEXT:    vmov.32 q4[3], r0
; CHECK-NEXT:    vand q3, q3, q1
; CHECK-NEXT:    vand q0, q4, q1
; CHECK-NEXT:    vadd.i32 q0, q0, q3
; CHECK-NEXT:    vadd.i32 q0, q0, q2
; CHECK-NEXT:    vaddv.u32 r0, q0
; CHECK-NEXT:    vpop {d8, d9}
; CHECK-NEXT:    bx lr
entry:
  %xx = zext <16 x i8> %x to <16 x i32>
  %z = call i32 @llvm.experimental.vector.reduce.add.v16i32(<16 x i32> %xx)
  ret i32 %z
}

define arm_aapcs_vfpcc i32 @add_v16i8_v16i32_sext(<16 x i8> %x) {
; CHECK-LABEL: add_v16i8_v16i32_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u8 r0, q0[12]
; CHECK-NEXT:    vmov.32 q1[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[13]
; CHECK-NEXT:    vmov.32 q1[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[14]
; CHECK-NEXT:    vmov.32 q1[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[15]
; CHECK-NEXT:    vmov.32 q1[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[4]
; CHECK-NEXT:    vmov.32 q2[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[5]
; CHECK-NEXT:    vmov.32 q2[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[6]
; CHECK-NEXT:    vmov.32 q2[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[7]
; CHECK-NEXT:    vmov.32 q2[3], r0
; CHECK-NEXT:    vmovlb.s8 q1, q1
; CHECK-NEXT:    vmovlb.s8 q2, q2
; CHECK-NEXT:    vmovlb.s16 q1, q1
; CHECK-NEXT:    vmovlb.s16 q2, q2
; CHECK-NEXT:    vmov.u8 r0, q0[8]
; CHECK-NEXT:    vadd.i32 q1, q2, q1
; CHECK-NEXT:    vmov.32 q2[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[9]
; CHECK-NEXT:    vmov.32 q2[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[10]
; CHECK-NEXT:    vmov.32 q2[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[11]
; CHECK-NEXT:    vmov.32 q2[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[0]
; CHECK-NEXT:    vmov.32 q3[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[1]
; CHECK-NEXT:    vmov.32 q3[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[2]
; CHECK-NEXT:    vmov.32 q3[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[3]
; CHECK-NEXT:    vmov.32 q3[3], r0
; CHECK-NEXT:    vmovlb.s8 q2, q2
; CHECK-NEXT:    vmovlb.s8 q0, q3
; CHECK-NEXT:    vmovlb.s16 q2, q2
; CHECK-NEXT:    vmovlb.s16 q0, q0
; CHECK-NEXT:    vadd.i32 q0, q0, q2
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    vaddv.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <16 x i8> %x to <16 x i32>
  %z = call i32 @llvm.experimental.vector.reduce.add.v16i32(<16 x i32> %xx)
  ret i32 %z
}

define arm_aapcs_vfpcc i32 @add_v4i8_v4i32_zext(<4 x i8> %x) {
; CHECK-LABEL: add_v4i8_v4i32_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.i32 q1, #0xff
; CHECK-NEXT:    vand q0, q0, q1
; CHECK-NEXT:    vaddv.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %xx = zext <4 x i8> %x to <4 x i32>
  %z = call i32 @llvm.experimental.vector.reduce.add.v4i32(<4 x i32> %xx)
  ret i32 %z
}

define arm_aapcs_vfpcc i32 @add_v4i8_v4i32_sext(<4 x i8> %x) {
; CHECK-LABEL: add_v4i8_v4i32_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovlb.s8 q0, q0
; CHECK-NEXT:    vmovlb.s16 q0, q0
; CHECK-NEXT:    vaddv.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <4 x i8> %x to <4 x i32>
  %z = call i32 @llvm.experimental.vector.reduce.add.v4i32(<4 x i32> %xx)
  ret i32 %z
}

define arm_aapcs_vfpcc i16 @add_v16i8_v16i16_zext(<16 x i8> %x) {
; CHECK-LABEL: add_v16i8_v16i16_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u8 r0, q0[8]
; CHECK-NEXT:    vmov.16 q1[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[9]
; CHECK-NEXT:    vmov.16 q1[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[10]
; CHECK-NEXT:    vmov.16 q1[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[11]
; CHECK-NEXT:    vmov.16 q1[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[12]
; CHECK-NEXT:    vmov.16 q1[4], r0
; CHECK-NEXT:    vmov.u8 r0, q0[13]
; CHECK-NEXT:    vmov.16 q1[5], r0
; CHECK-NEXT:    vmov.u8 r0, q0[14]
; CHECK-NEXT:    vmov.16 q1[6], r0
; CHECK-NEXT:    vmov.u8 r0, q0[15]
; CHECK-NEXT:    vmov.16 q1[7], r0
; CHECK-NEXT:    vmov.u8 r0, q0[0]
; CHECK-NEXT:    vmov.16 q2[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[1]
; CHECK-NEXT:    vmov.16 q2[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[2]
; CHECK-NEXT:    vmov.16 q2[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[3]
; CHECK-NEXT:    vmov.16 q2[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[4]
; CHECK-NEXT:    vmov.16 q2[4], r0
; CHECK-NEXT:    vmov.u8 r0, q0[5]
; CHECK-NEXT:    vmov.16 q2[5], r0
; CHECK-NEXT:    vmov.u8 r0, q0[6]
; CHECK-NEXT:    vmov.16 q2[6], r0
; CHECK-NEXT:    vmov.u8 r0, q0[7]
; CHECK-NEXT:    vmov.16 q2[7], r0
; CHECK-NEXT:    vmovlb.u8 q1, q1
; CHECK-NEXT:    vmovlb.u8 q0, q2
; CHECK-NEXT:    vadd.i16 q0, q0, q1
; CHECK-NEXT:    vaddv.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %xx = zext <16 x i8> %x to <16 x i16>
  %z = call i16 @llvm.experimental.vector.reduce.add.v16i16(<16 x i16> %xx)
  ret i16 %z
}

define arm_aapcs_vfpcc i16 @add_v16i8_v16i16_sext(<16 x i8> %x) {
; CHECK-LABEL: add_v16i8_v16i16_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u8 r0, q0[8]
; CHECK-NEXT:    vmov.16 q1[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[9]
; CHECK-NEXT:    vmov.16 q1[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[10]
; CHECK-NEXT:    vmov.16 q1[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[11]
; CHECK-NEXT:    vmov.16 q1[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[12]
; CHECK-NEXT:    vmov.16 q1[4], r0
; CHECK-NEXT:    vmov.u8 r0, q0[13]
; CHECK-NEXT:    vmov.16 q1[5], r0
; CHECK-NEXT:    vmov.u8 r0, q0[14]
; CHECK-NEXT:    vmov.16 q1[6], r0
; CHECK-NEXT:    vmov.u8 r0, q0[15]
; CHECK-NEXT:    vmov.16 q1[7], r0
; CHECK-NEXT:    vmov.u8 r0, q0[0]
; CHECK-NEXT:    vmov.16 q2[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[1]
; CHECK-NEXT:    vmov.16 q2[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[2]
; CHECK-NEXT:    vmov.16 q2[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[3]
; CHECK-NEXT:    vmov.16 q2[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[4]
; CHECK-NEXT:    vmov.16 q2[4], r0
; CHECK-NEXT:    vmov.u8 r0, q0[5]
; CHECK-NEXT:    vmov.16 q2[5], r0
; CHECK-NEXT:    vmov.u8 r0, q0[6]
; CHECK-NEXT:    vmov.16 q2[6], r0
; CHECK-NEXT:    vmov.u8 r0, q0[7]
; CHECK-NEXT:    vmov.16 q2[7], r0
; CHECK-NEXT:    vmovlb.s8 q1, q1
; CHECK-NEXT:    vmovlb.s8 q0, q2
; CHECK-NEXT:    vadd.i16 q0, q0, q1
; CHECK-NEXT:    vaddv.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <16 x i8> %x to <16 x i16>
  %z = call i16 @llvm.experimental.vector.reduce.add.v16i16(<16 x i16> %xx)
  ret i16 %z
}

define arm_aapcs_vfpcc i16 @add_v8i8_v8i16_zext(<8 x i8> %x) {
; CHECK-LABEL: add_v8i8_v8i16_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovlb.u8 q0, q0
; CHECK-NEXT:    vaddv.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %xx = zext <8 x i8> %x to <8 x i16>
  %z = call i16 @llvm.experimental.vector.reduce.add.v8i16(<8 x i16> %xx)
  ret i16 %z
}

define arm_aapcs_vfpcc i16 @add_v8i8_v8i16_sext(<8 x i8> %x) {
; CHECK-LABEL: add_v8i8_v8i16_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmovlb.s8 q0, q0
; CHECK-NEXT:    vaddv.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <8 x i8> %x to <8 x i16>
  %z = call i16 @llvm.experimental.vector.reduce.add.v8i16(<8 x i16> %xx)
  ret i16 %z
}

define arm_aapcs_vfpcc i8 @add_v16i8_v16i8(<16 x i8> %x) {
; CHECK-LABEL: add_v16i8_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vaddv.u8 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %z = call i8 @llvm.experimental.vector.reduce.add.v16i8(<16 x i8> %x)
  ret i8 %z
}

define arm_aapcs_vfpcc i64 @add_v16i8_v16i64_zext(<16 x i8> %x) {
; CHECK-LABEL: add_v16i8_v16i64_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u8 r0, q0[0]
; CHECK-NEXT:    vmov.32 q2[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[1]
; CHECK-NEXT:    vmov.32 q2[2], r0
; CHECK-NEXT:    adr r0, .LCPI23_0
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vand q2, q2, q1
; CHECK-NEXT:    vmov r0, s10
; CHECK-NEXT:    vmov r1, s8
; CHECK-NEXT:    vmov r2, s11
; CHECK-NEXT:    add r0, r1
; CHECK-NEXT:    vmov.u8 r1, q0[2]
; CHECK-NEXT:    vmov.32 q3[0], r1
; CHECK-NEXT:    vmov.u8 r1, q0[3]
; CHECK-NEXT:    vmov.32 q3[2], r1
; CHECK-NEXT:    vand q3, q3, q1
; CHECK-NEXT:    vmov r1, s12
; CHECK-NEXT:    add r0, r1
; CHECK-NEXT:    vmov r1, s14
; CHECK-NEXT:    add r0, r1
; CHECK-NEXT:    vmov.u8 r1, q0[4]
; CHECK-NEXT:    vmov.32 q3[0], r1
; CHECK-NEXT:    vmov.u8 r1, q0[5]
; CHECK-NEXT:    vmov.32 q3[2], r1
; CHECK-NEXT:    vand q3, q3, q1
; CHECK-NEXT:    vmov r1, s12
; CHECK-NEXT:    vmov r3, s14
; CHECK-NEXT:    add r0, r1
; CHECK-NEXT:    vmov r1, s15
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov.u8 r2, q0[6]
; CHECK-NEXT:    vmov.32 q2[0], r2
; CHECK-NEXT:    vmov.u8 r2, q0[7]
; CHECK-NEXT:    vmov.32 q2[2], r2
; CHECK-NEXT:    vand q2, q2, q1
; CHECK-NEXT:    vmov r3, s8
; CHECK-NEXT:    vmov r2, s9
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    vmov r3, s10
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov r2, s11
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov.u8 r2, q0[8]
; CHECK-NEXT:    vmov.32 q2[0], r2
; CHECK-NEXT:    vmov.u8 r2, q0[9]
; CHECK-NEXT:    vmov.32 q2[2], r2
; CHECK-NEXT:    vand q2, q2, q1
; CHECK-NEXT:    vmov r3, s8
; CHECK-NEXT:    vmov r2, s9
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    vmov r3, s10
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov r2, s11
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov.u8 r2, q0[10]
; CHECK-NEXT:    vmov.32 q2[0], r2
; CHECK-NEXT:    vmov.u8 r2, q0[11]
; CHECK-NEXT:    vmov.32 q2[2], r2
; CHECK-NEXT:    vand q2, q2, q1
; CHECK-NEXT:    vmov r3, s8
; CHECK-NEXT:    vmov r2, s9
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    vmov r3, s10
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov r2, s11
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov.u8 r2, q0[12]
; CHECK-NEXT:    vmov.32 q2[0], r2
; CHECK-NEXT:    vmov.u8 r2, q0[13]
; CHECK-NEXT:    vmov.32 q2[2], r2
; CHECK-NEXT:    vand q2, q2, q1
; CHECK-NEXT:    vmov r3, s8
; CHECK-NEXT:    vmov r2, s9
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    vmov r3, s10
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov r2, s11
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov.u8 r2, q0[14]
; CHECK-NEXT:    vmov.32 q2[0], r2
; CHECK-NEXT:    vmov.u8 r2, q0[15]
; CHECK-NEXT:    vmov.32 q2[2], r2
; CHECK-NEXT:    vand q0, q2, q1
; CHECK-NEXT:    vmov r3, s0
; CHECK-NEXT:    vmov r2, s1
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    vmov r3, s2
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    vmov r2, s3
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI23_0:
; CHECK-NEXT:    .long 255 @ 0xff
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 255 @ 0xff
; CHECK-NEXT:    .long 0 @ 0x0
entry:
  %xx = zext <16 x i8> %x to <16 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v16i64(<16 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i64 @add_v16i8_v16i64_sext(<16 x i8> %x) {
; CHECK-LABEL: add_v16i8_v16i64_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u8 r0, q0[0]
; CHECK-NEXT:    sxtb r0, r0
; CHECK-NEXT:    vmov.32 q1[0], r0
; CHECK-NEXT:    asrs r0, r0, #31
; CHECK-NEXT:    vmov.32 q1[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[1]
; CHECK-NEXT:    sxtb r0, r0
; CHECK-NEXT:    vmov.32 q1[2], r0
; CHECK-NEXT:    asrs r1, r0, #31
; CHECK-NEXT:    vmov.32 q1[3], r1
; CHECK-NEXT:    vmov r2, s6
; CHECK-NEXT:    vmov r3, s4
; CHECK-NEXT:    vmov r1, s5
; CHECK-NEXT:    adds r2, r2, r3
; CHECK-NEXT:    adc.w r12, r1, r0, asr #31
; CHECK-NEXT:    vmov.u8 r1, q0[2]
; CHECK-NEXT:    sxtb r1, r1
; CHECK-NEXT:    vmov.32 q1[0], r1
; CHECK-NEXT:    asrs r1, r1, #31
; CHECK-NEXT:    vmov.32 q1[1], r1
; CHECK-NEXT:    vmov.u8 r1, q0[3]
; CHECK-NEXT:    sxtb r1, r1
; CHECK-NEXT:    vmov.32 q1[2], r1
; CHECK-NEXT:    asrs r3, r1, #31
; CHECK-NEXT:    vmov.32 q1[3], r3
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov r3, s5
; CHECK-NEXT:    adds r0, r0, r2
; CHECK-NEXT:    adc.w r2, r12, r3
; CHECK-NEXT:    vmov r3, s6
; CHECK-NEXT:    adds.w r12, r0, r3
; CHECK-NEXT:    adc.w r1, r2, r1, asr #31
; CHECK-NEXT:    vmov.u8 r2, q0[4]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    vmov.32 q1[0], r2
; CHECK-NEXT:    asrs r2, r2, #31
; CHECK-NEXT:    vmov.32 q1[1], r2
; CHECK-NEXT:    vmov.u8 r2, q0[5]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    vmov.32 q1[2], r2
; CHECK-NEXT:    asrs r3, r2, #31
; CHECK-NEXT:    vmov.32 q1[3], r3
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov r3, s5
; CHECK-NEXT:    adds.w r0, r0, r12
; CHECK-NEXT:    adcs r1, r3
; CHECK-NEXT:    vmov r3, s6
; CHECK-NEXT:    adds.w r12, r0, r3
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    vmov.u8 r2, q0[6]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    vmov.32 q1[0], r2
; CHECK-NEXT:    asrs r2, r2, #31
; CHECK-NEXT:    vmov.32 q1[1], r2
; CHECK-NEXT:    vmov.u8 r2, q0[7]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    vmov.32 q1[2], r2
; CHECK-NEXT:    asrs r3, r2, #31
; CHECK-NEXT:    vmov.32 q1[3], r3
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov r3, s5
; CHECK-NEXT:    adds.w r0, r0, r12
; CHECK-NEXT:    adcs r1, r3
; CHECK-NEXT:    vmov r3, s6
; CHECK-NEXT:    adds.w r12, r0, r3
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    vmov.u8 r2, q0[8]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    vmov.32 q1[0], r2
; CHECK-NEXT:    asrs r2, r2, #31
; CHECK-NEXT:    vmov.32 q1[1], r2
; CHECK-NEXT:    vmov.u8 r2, q0[9]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    vmov.32 q1[2], r2
; CHECK-NEXT:    asrs r3, r2, #31
; CHECK-NEXT:    vmov.32 q1[3], r3
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov r3, s5
; CHECK-NEXT:    adds.w r0, r0, r12
; CHECK-NEXT:    adcs r1, r3
; CHECK-NEXT:    vmov r3, s6
; CHECK-NEXT:    adds.w r12, r0, r3
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    vmov.u8 r2, q0[10]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    vmov.32 q1[0], r2
; CHECK-NEXT:    asrs r2, r2, #31
; CHECK-NEXT:    vmov.32 q1[1], r2
; CHECK-NEXT:    vmov.u8 r2, q0[11]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    vmov.32 q1[2], r2
; CHECK-NEXT:    asrs r3, r2, #31
; CHECK-NEXT:    vmov.32 q1[3], r3
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov r3, s5
; CHECK-NEXT:    adds.w r0, r0, r12
; CHECK-NEXT:    adcs r1, r3
; CHECK-NEXT:    vmov r3, s6
; CHECK-NEXT:    adds.w r12, r0, r3
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    vmov.u8 r2, q0[12]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    vmov.32 q1[0], r2
; CHECK-NEXT:    asrs r2, r2, #31
; CHECK-NEXT:    vmov.32 q1[1], r2
; CHECK-NEXT:    vmov.u8 r2, q0[13]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    vmov.32 q1[2], r2
; CHECK-NEXT:    asrs r3, r2, #31
; CHECK-NEXT:    vmov.32 q1[3], r3
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov r3, s5
; CHECK-NEXT:    adds.w r0, r0, r12
; CHECK-NEXT:    adcs r1, r3
; CHECK-NEXT:    vmov r3, s6
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    vmov.u8 r2, q0[14]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    adds r0, r0, r2
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    vmov.u8 r2, q0[15]
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    adds r0, r0, r2
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <16 x i8> %x to <16 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v16i64(<16 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i64 @add_v2i8_v2i64_zext(<2 x i8> %x) {
; CHECK-LABEL: add_v2i8_v2i64_zext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    adr r0, .LCPI25_0
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vand q0, q0, q1
; CHECK-NEXT:    vmov r0, s2
; CHECK-NEXT:    vmov r1, s0
; CHECK-NEXT:    add r0, r1
; CHECK-NEXT:    vmov r1, s3
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI25_0:
; CHECK-NEXT:    .long 255 @ 0xff
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 255 @ 0xff
; CHECK-NEXT:    .long 0 @ 0x0
entry:
  %xx = zext <2 x i8> %x to <2 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v2i64(<2 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i64 @add_v2i8_v2i64_sext(<2 x i8> %x) {
; CHECK-LABEL: add_v2i8_v2i64_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    vmov r2, s2
; CHECK-NEXT:    sxtb r0, r0
; CHECK-NEXT:    vmov.32 q1[0], r0
; CHECK-NEXT:    asrs r1, r0, #31
; CHECK-NEXT:    vmov.32 q1[1], r1
; CHECK-NEXT:    sxtb r2, r2
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    adds r0, r0, r2
; CHECK-NEXT:    adc.w r1, r1, r2, asr #31
; CHECK-NEXT:    bx lr
entry:
  %xx = sext <2 x i8> %x to <2 x i64>
  %z = call i64 @llvm.experimental.vector.reduce.add.v2i64(<2 x i64> %xx)
  ret i64 %z
}

define arm_aapcs_vfpcc i64 @add_v2i64_v2i64(<2 x i64> %x) {
; CHECK-LABEL: add_v2i64_v2i64:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r0, s2
; CHECK-NEXT:    vmov r3, s0
; CHECK-NEXT:    vmov r1, s3
; CHECK-NEXT:    vmov r2, s1
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    bx lr
entry:
  %z = call i64 @llvm.experimental.vector.reduce.add.v2i64(<2 x i64> %x)
  ret i64 %z
}

declare i16 @llvm.experimental.vector.reduce.add.v16i16(<16 x i16>)
declare i16 @llvm.experimental.vector.reduce.add.v8i16(<8 x i16>)
declare i32 @llvm.experimental.vector.reduce.add.v16i32(<16 x i32>)
declare i32 @llvm.experimental.vector.reduce.add.v4i32(<4 x i32>)
declare i32 @llvm.experimental.vector.reduce.add.v8i32(<8 x i32>)
declare i64 @llvm.experimental.vector.reduce.add.v16i64(<16 x i64>)
declare i64 @llvm.experimental.vector.reduce.add.v2i64(<2 x i64>)
declare i64 @llvm.experimental.vector.reduce.add.v4i64(<4 x i64>)
declare i64 @llvm.experimental.vector.reduce.add.v8i64(<8 x i64>)
declare i8 @llvm.experimental.vector.reduce.add.v16i8(<16 x i8>)
