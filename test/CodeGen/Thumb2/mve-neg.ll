; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s

define arm_aapcs_vfpcc <16 x i8> @neg_v16i8(<16 x i8> %s1) {
; CHECK-LABEL: neg_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vneg.s8 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %0 = sub nsw <16 x i8> zeroinitializer, %s1
  ret <16 x i8> %0
}

define arm_aapcs_vfpcc <8 x i16> @neg_v8i16(<8 x i16> %s1) {
; CHECK-LABEL: neg_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vneg.s16 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %0 = sub nsw <8 x i16> zeroinitializer, %s1
  ret <8 x i16> %0
}

define arm_aapcs_vfpcc <4 x i32> @neg_v4i32(<4 x i32> %s1) {
; CHECK-LABEL: neg_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vneg.s32 q0, q0
; CHECK-NEXT:    bx lr
entry:
  %0 = sub nsw <4 x i32> zeroinitializer, %s1
  ret <4 x i32> %0
}

define arm_aapcs_vfpcc <2 x i64> @neg_v2i64(<2 x i64> %s1) {
; CHECK-LABEL: neg_v2i64:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r1, s0
; CHECK-NEXT:    mov.w r12, #0
; CHECK-NEXT:    vmov r0, s1
; CHECK-NEXT:    vmov r2, s2
; CHECK-NEXT:    vmov r3, s3
; CHECK-NEXT:    rsbs r1, r1, #0
; CHECK-NEXT:    sbc.w r0, r12, r0
; CHECK-NEXT:    rsbs r2, r2, #0
; CHECK-NEXT:    sbc.w r3, r12, r3
; CHECK-NEXT:    vmov q0[2], q0[0], r2, r1
; CHECK-NEXT:    vmov q0[3], q0[1], r3, r0
; CHECK-NEXT:    bx lr
entry:
  %0 = sub nsw <2 x i64> zeroinitializer, %s1
  ret <2 x i64> %0
}

