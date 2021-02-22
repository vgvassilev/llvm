; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve,+fullfp16 -verify-machineinstrs %s -o - | FileCheck %s
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp -verify-machineinstrs %s -o - | FileCheck %s

; i16

define arm_aapcs_vfpcc <8 x i16> @shuffle_i16_45670123(<8 x i16> %s1, <8 x i16> %s2) {
; CHECK-LABEL: shuffle_i16_45670123:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s2
; CHECK-NEXT:    vmov.f32 s5, s3
; CHECK-NEXT:    vmov.f32 s6, s0
; CHECK-NEXT:    vmov.f32 s7, s1
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x i16> %s1, <8 x i16> %s2, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3>
  ret <8 x i16> %out
}

define arm_aapcs_vfpcc <8 x i16> @shuffle_i16_67452301(<8 x i16> %s1, <8 x i16> %s2) {
; CHECK-LABEL: shuffle_i16_67452301:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s3
; CHECK-NEXT:    vmov.f32 s5, s2
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vmov.f32 s7, s0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x i16> %s1, <8 x i16> %s2, <8 x i32> <i32 6, i32 7, i32 4, i32 5, i32 2, i32 3, i32 0, i32 1>
  ret <8 x i16> %out
}

define arm_aapcs_vfpcc <8 x i16> @shuffle_i16_76543210(<8 x i16> %s1, <8 x i16> %s2) {
; CHECK-LABEL: shuffle_i16_76543210:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov q1, q0
; CHECK-NEXT:    vmovx.f16 s0, s7
; CHECK-NEXT:    vins.f16 s0, s7
; CHECK-NEXT:    vmovx.f16 s1, s6
; CHECK-NEXT:    vins.f16 s1, s6
; CHECK-NEXT:    vmovx.f16 s2, s5
; CHECK-NEXT:    vins.f16 s2, s5
; CHECK-NEXT:    vmovx.f16 s3, s4
; CHECK-NEXT:    vins.f16 s3, s4
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x i16> %s1, <8 x i16> %s2, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x i16> %out
}

define arm_aapcs_vfpcc <8 x i16> @shuffle_i16_01234567(<8 x i16> %s1, <8 x i16> %s2) {
; CHECK-LABEL: shuffle_i16_01234567:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x i16> %s1, <8 x i16> %s2, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i16> %out
}

define arm_aapcs_vfpcc <8 x i16> @shuffle_i16_0123cdef(<8 x i16> %s1, <8 x i16> %s2) {
; CHECK-LABEL: shuffle_i16_0123cdef:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s2, s6
; CHECK-NEXT:    vmov.f32 s3, s7
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x i16> %s1, <8 x i16> %s2, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
  ret <8 x i16> %out
}

define arm_aapcs_vfpcc <8 x i16> @shuffle_i16_u7u5u3u1(<8 x i16> %s1, <8 x i16> %s2) {
; CHECK-LABEL: shuffle_i16_u7u5u3u1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s3
; CHECK-NEXT:    vmov.f32 s5, s2
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vmov.f32 s7, s0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x i16> %s1, <8 x i16> %s2, <8 x i32> <i32 undef, i32 7, i32 undef, i32 5, i32 undef, i32 3, i32 undef, i32 1>
  ret <8 x i16> %out
}

define arm_aapcs_vfpcc <8 x i16> @shuffle_i16_6u4u2u0u(<8 x i16> %s1, <8 x i16> %s2) {
; CHECK-LABEL: shuffle_i16_6u4u2u0u:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s3
; CHECK-NEXT:    vmov.f32 s5, s2
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vmov.f32 s7, s0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x i16> %s1, <8 x i16> %s2, <8 x i32> <i32 6, i32 undef, i32 4, i32 undef, i32 2, i32 undef, i32 0, i32 undef>
  ret <8 x i16> %out
}

define arm_aapcs_vfpcc <8 x i16> @shuffle_i16_0uuuuuuu(<8 x i16> %s1, <8 x i16> %s2) {
; CHECK-LABEL: shuffle_i16_0uuuuuuu:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x i16> %s1, <8 x i16> %s2, <8 x i32> <i32 0, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  ret <8 x i16> %out
}

define arm_aapcs_vfpcc <8 x i16> @shuffle_i16_uuuu0uuu(<8 x i16> %s1, <8 x i16> %s2) {
; CHECK-LABEL: shuffle_i16_uuuu0uuu:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u16 r0, q0[0]
; CHECK-NEXT:    vdup.16 q0, r0
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x i16> %s1, <8 x i16> %s2, <8 x i32> <i32 undef, i32 undef, i32 undef, i32 undef, i32 0, i32 undef, i32 undef, i32 undef>
  ret <8 x i16> %out
}


; i8

define arm_aapcs_vfpcc <16 x i8> @shuffle_i8_cdef89ab45670123(<16 x i8> %s1, <16 x i8> %s2) {
; CHECK-LABEL: shuffle_i8_cdef89ab45670123:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s3
; CHECK-NEXT:    vmov.f32 s5, s2
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vmov.f32 s7, s0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <16 x i8> %s1, <16 x i8> %s2, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3>
  ret <16 x i8> %out
}

define arm_aapcs_vfpcc <16 x i8> @shuffle_i8_efcdab8967452301(<16 x i8> %s1, <16 x i8> %s2) {
; CHECK-LABEL: shuffle_i8_efcdab8967452301:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov q1, q0
; CHECK-NEXT:    vmov.u8 r0, q0[14]
; CHECK-NEXT:    vmov.8 q0[0], r0
; CHECK-NEXT:    vmov.u8 r0, q1[15]
; CHECK-NEXT:    vmov.8 q0[1], r0
; CHECK-NEXT:    vmov.u8 r0, q1[12]
; CHECK-NEXT:    vmov.8 q0[2], r0
; CHECK-NEXT:    vmov.u8 r0, q1[13]
; CHECK-NEXT:    vmov.8 q0[3], r0
; CHECK-NEXT:    vmov.u8 r0, q1[10]
; CHECK-NEXT:    vmov.8 q0[4], r0
; CHECK-NEXT:    vmov.u8 r0, q1[11]
; CHECK-NEXT:    vmov.8 q0[5], r0
; CHECK-NEXT:    vmov.u8 r0, q1[8]
; CHECK-NEXT:    vmov.8 q0[6], r0
; CHECK-NEXT:    vmov.u8 r0, q1[9]
; CHECK-NEXT:    vmov.8 q0[7], r0
; CHECK-NEXT:    vmov.u8 r0, q1[6]
; CHECK-NEXT:    vmov.8 q0[8], r0
; CHECK-NEXT:    vmov.u8 r0, q1[7]
; CHECK-NEXT:    vmov.8 q0[9], r0
; CHECK-NEXT:    vmov.u8 r0, q1[4]
; CHECK-NEXT:    vmov.8 q0[10], r0
; CHECK-NEXT:    vmov.u8 r0, q1[5]
; CHECK-NEXT:    vmov.8 q0[11], r0
; CHECK-NEXT:    vmov.u8 r0, q1[2]
; CHECK-NEXT:    vmov.8 q0[12], r0
; CHECK-NEXT:    vmov.u8 r0, q1[3]
; CHECK-NEXT:    vmov.8 q0[13], r0
; CHECK-NEXT:    vmov.u8 r0, q1[0]
; CHECK-NEXT:    vmov.8 q0[14], r0
; CHECK-NEXT:    vmov.u8 r0, q1[1]
; CHECK-NEXT:    vmov.8 q0[15], r0
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <16 x i8> %s1, <16 x i8> %s2, <16 x i32> <i32 14, i32 15, i32 12, i32 13, i32 10, i32 11, i32 8, i32 9, i32 6, i32 7, i32 4, i32 5, i32 2, i32 3, i32 0, i32 1>
  ret <16 x i8> %out
}

define arm_aapcs_vfpcc <16 x i8> @shuffle_i8_fedcba9876543210(<16 x i8> %s1, <16 x i8> %s2) {
; CHECK-LABEL: shuffle_i8_fedcba9876543210:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov q1, q0
; CHECK-NEXT:    vmov.u8 r0, q0[15]
; CHECK-NEXT:    vmov.8 q0[0], r0
; CHECK-NEXT:    vmov.u8 r0, q1[14]
; CHECK-NEXT:    vmov.8 q0[1], r0
; CHECK-NEXT:    vmov.u8 r0, q1[13]
; CHECK-NEXT:    vmov.8 q0[2], r0
; CHECK-NEXT:    vmov.u8 r0, q1[12]
; CHECK-NEXT:    vmov.8 q0[3], r0
; CHECK-NEXT:    vmov.u8 r0, q1[11]
; CHECK-NEXT:    vmov.8 q0[4], r0
; CHECK-NEXT:    vmov.u8 r0, q1[10]
; CHECK-NEXT:    vmov.8 q0[5], r0
; CHECK-NEXT:    vmov.u8 r0, q1[9]
; CHECK-NEXT:    vmov.8 q0[6], r0
; CHECK-NEXT:    vmov.u8 r0, q1[8]
; CHECK-NEXT:    vmov.8 q0[7], r0
; CHECK-NEXT:    vmov.u8 r0, q1[7]
; CHECK-NEXT:    vmov.8 q0[8], r0
; CHECK-NEXT:    vmov.u8 r0, q1[6]
; CHECK-NEXT:    vmov.8 q0[9], r0
; CHECK-NEXT:    vmov.u8 r0, q1[5]
; CHECK-NEXT:    vmov.8 q0[10], r0
; CHECK-NEXT:    vmov.u8 r0, q1[4]
; CHECK-NEXT:    vmov.8 q0[11], r0
; CHECK-NEXT:    vmov.u8 r0, q1[3]
; CHECK-NEXT:    vmov.8 q0[12], r0
; CHECK-NEXT:    vmov.u8 r0, q1[2]
; CHECK-NEXT:    vmov.8 q0[13], r0
; CHECK-NEXT:    vmov.u8 r0, q1[1]
; CHECK-NEXT:    vmov.8 q0[14], r0
; CHECK-NEXT:    vmov.u8 r0, q1[0]
; CHECK-NEXT:    vmov.8 q0[15], r0
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <16 x i8> %s1, <16 x i8> %s2, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <16 x i8> %out
}

define arm_aapcs_vfpcc <16 x i8> @shuffle_i8_0123456789abcdef(<16 x i8> %s1, <16 x i8> %s2) {
; CHECK-LABEL: shuffle_i8_0123456789abcdef:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <16 x i8> %s1, <16 x i8> %s2, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  ret <16 x i8> %out
}

define arm_aapcs_vfpcc <16 x i8> @shuffle_i8_0123ghij4567klmn(<16 x i8> %s1, <16 x i8> %s2) {
; CHECK-LABEL: shuffle_i8_0123ghij4567klmn:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s8, s0
; CHECK-NEXT:    vmov.f32 s9, s4
; CHECK-NEXT:    vmov.f32 s10, s1
; CHECK-NEXT:    vmov.f32 s11, s5
; CHECK-NEXT:    vmov q0, q2
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <16 x i8> %s1, <16 x i8> %s2, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 16, i32 17, i32 18, i32 19, i32 4, i32 5, i32 6, i32 7, i32 20, i32 21, i32 22, i32 23>
  ret <16 x i8> %out
}

define arm_aapcs_vfpcc <16 x i8> @shuffle_i8_cdeu89ub4u67u123(<16 x i8> %s1, <16 x i8> %s2) {
; CHECK-LABEL: shuffle_i8_cdeu89ub4u67u123:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s3
; CHECK-NEXT:    vmov.f32 s5, s2
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vmov.f32 s7, s0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <16 x i8> %s1, <16 x i8> %s2, <16 x i32> <i32 12, i32 13, i32 14, i32 undef, i32 8, i32 9, i32 undef, i32 11, i32 4, i32 undef, i32 6, i32 7, i32 undef, i32 1, i32 2, i32 3>
  ret <16 x i8> %out
}

define arm_aapcs_vfpcc <16 x i8> @shuffle_i8_cduu8uubuu67u12u(<16 x i8> %s1, <16 x i8> %s2) {
; CHECK-LABEL: shuffle_i8_cduu8uubuu67u12u:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s3
; CHECK-NEXT:    vmov.f32 s5, s2
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vmov.f32 s7, s0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <16 x i8> %s1, <16 x i8> %s2, <16 x i32> <i32 12, i32 13, i32 undef, i32 undef, i32 8, i32 undef, i32 undef, i32 11, i32 undef, i32 undef, i32 6, i32 7, i32 undef, i32 1, i32 2, i32 undef>
  ret <16 x i8> %out
}

define arm_aapcs_vfpcc <16 x i8> @shuffle_i8_cuuuuuubuu6uuu2u(<16 x i8> %s1, <16 x i8> %s2) {
; CHECK-LABEL: shuffle_i8_cuuuuuubuu6uuu2u:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s3
; CHECK-NEXT:    vmov.f32 s5, s2
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vmov.f32 s7, s0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <16 x i8> %s1, <16 x i8> %s2, <16 x i32> <i32 12, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 11, i32 undef, i32 undef, i32 6, i32 undef, i32 undef, i32 undef, i32 2, i32 undef>
  ret <16 x i8> %out
}

define arm_aapcs_vfpcc <16 x i8> @shuffle_i8_cdef89ab45u700123(<16 x i8> %s1, <16 x i8> %s2) {
; CHECK-LABEL: shuffle_i8_cdef89ab45u700123:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u8 r0, q0[4]
; CHECK-NEXT:    vmov.8 q1[8], r0
; CHECK-NEXT:    vmov.u8 r0, q0[5]
; CHECK-NEXT:    vmov.8 q1[9], r0
; CHECK-NEXT:    vmov.u8 r0, q0[0]
; CHECK-NEXT:    vmov.8 q1[11], r0
; CHECK-NEXT:    vmov.f32 s4, s3
; CHECK-NEXT:    vmov.f32 s5, s2
; CHECK-NEXT:    vmov.f32 s7, s0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <16 x i8> %s1, <16 x i8> %s2, <16 x i32> <i32 12, i32 13, i32 14, i32 15, i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 undef, i32 0, i32 0, i32 1, i32 2, i32 3>
  ret <16 x i8> %out
}



; f16

define arm_aapcs_vfpcc <8 x half> @shuffle_f16_45670123(<8 x half> %s1, <8 x half> %s2) {
; CHECK-LABEL: shuffle_f16_45670123:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s2
; CHECK-NEXT:    vmov.f32 s5, s3
; CHECK-NEXT:    vmov.f32 s6, s0
; CHECK-NEXT:    vmov.f32 s7, s1
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x half> %s1, <8 x half> %s2, <8 x i32> <i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 2, i32 3>
  ret <8 x half> %out
}

define arm_aapcs_vfpcc <8 x half> @shuffle_f16_67452301(<8 x half> %s1, <8 x half> %s2) {
; CHECK-LABEL: shuffle_f16_67452301:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s3
; CHECK-NEXT:    vmov.f32 s5, s2
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vmov.f32 s7, s0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x half> %s1, <8 x half> %s2, <8 x i32> <i32 6, i32 7, i32 4, i32 5, i32 2, i32 3, i32 0, i32 1>
  ret <8 x half> %out
}

define arm_aapcs_vfpcc <8 x half> @shuffle_f16_76543210(<8 x half> %s1, <8 x half> %s2) {
; CHECK-LABEL: shuffle_f16_76543210:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov q1, q0
; CHECK-NEXT:    vmovx.f16 s0, s7
; CHECK-NEXT:    vins.f16 s0, s7
; CHECK-NEXT:    vmovx.f16 s1, s6
; CHECK-NEXT:    vins.f16 s1, s6
; CHECK-NEXT:    vmovx.f16 s2, s5
; CHECK-NEXT:    vins.f16 s2, s5
; CHECK-NEXT:    vmovx.f16 s3, s4
; CHECK-NEXT:    vins.f16 s3, s4
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x half> %s1, <8 x half> %s2, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret <8 x half> %out
}

define arm_aapcs_vfpcc <8 x half> @shuffle_f16_01234567(<8 x half> %s1, <8 x half> %s2) {
; CHECK-LABEL: shuffle_f16_01234567:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x half> %s1, <8 x half> %s2, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x half> %out
}

define arm_aapcs_vfpcc <8 x half> @shuffle_f16_0123cdef(<8 x half> %s1, <8 x half> %s2) {
; CHECK-LABEL: shuffle_f16_0123cdef:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s2, s6
; CHECK-NEXT:    vmov.f32 s3, s7
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x half> %s1, <8 x half> %s2, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
  ret <8 x half> %out
}

define arm_aapcs_vfpcc <8 x half> @shuffle_f16_u7u5u3u1(<8 x half> %s1, <8 x half> %s2) {
; CHECK-LABEL: shuffle_f16_u7u5u3u1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s3
; CHECK-NEXT:    vmov.f32 s5, s2
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vmov.f32 s7, s0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x half> %s1, <8 x half> %s2, <8 x i32> <i32 undef, i32 7, i32 undef, i32 5, i32 undef, i32 3, i32 undef, i32 1>
  ret <8 x half> %out
}

define arm_aapcs_vfpcc <8 x half> @shuffle_f16_6u4u2u0u(<8 x half> %s1, <8 x half> %s2) {
; CHECK-LABEL: shuffle_f16_6u4u2u0u:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s4, s3
; CHECK-NEXT:    vmov.f32 s5, s2
; CHECK-NEXT:    vmov.f32 s6, s1
; CHECK-NEXT:    vmov.f32 s7, s0
; CHECK-NEXT:    vmov q0, q1
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x half> %s1, <8 x half> %s2, <8 x i32> <i32 6, i32 undef, i32 4, i32 undef, i32 2, i32 undef, i32 0, i32 undef>
  ret <8 x half> %out
}

define arm_aapcs_vfpcc <8 x half> @shuffle_f16_0uuuuuuu(<8 x half> %s1, <8 x half> %s2) {
; CHECK-LABEL: shuffle_f16_0uuuuuuu:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x half> %s1, <8 x half> %s2, <8 x i32> <i32 0, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  ret <8 x half> %out
}

define arm_aapcs_vfpcc <8 x half> @shuffle_f16_uuuu0uuu(<8 x half> %s1, <8 x half> %s2) {
; CHECK-LABEL: shuffle_f16_uuuu0uuu:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u16 r0, q0[0]
; CHECK-NEXT:    vdup.16 q0, r0
; CHECK-NEXT:    bx lr
entry:
  %out = shufflevector <8 x half> %s1, <8 x half> %s2, <8 x i32> <i32 undef, i32 undef, i32 undef, i32 undef, i32 0, i32 undef, i32 undef, i32 undef>
  ret <8 x half> %out
}
