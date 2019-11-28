; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main -mattr=+mve.fp -verify-machineinstrs -o - %s | FileCheck %s

define dso_local arm_aapcs_vfpcc <16 x i8> @test_vminq_u8(<16 x i8> %a, <16 x i8> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_vminq_u8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmin.u8 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = icmp ugt <16 x i8> %a, %b
  %1 = select <16 x i1> %0, <16 x i8> %b, <16 x i8> %a
  ret <16 x i8> %1
}

define dso_local arm_aapcs_vfpcc <8 x i16> @test_vminq_s16(<8 x i16> %a, <8 x i16> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_vminq_s16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmin.s16 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = icmp sgt <8 x i16> %a, %b
  %1 = select <8 x i1> %0, <8 x i16> %b, <8 x i16> %a
  ret <8 x i16> %1
}

define dso_local arm_aapcs_vfpcc <4 x i32> @test_vminq_u32(<4 x i32> %a, <4 x i32> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_vminq_u32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmin.u32 q0, q0, q1
; CHECK-NEXT:    bx lr
entry:
  %0 = icmp ugt <4 x i32> %a, %b
  %1 = select <4 x i1> %0, <4 x i32> %b, <4 x i32> %a
  ret <4 x i32> %1
}

define dso_local arm_aapcs_vfpcc <16 x i8> @test_vminq_m_s8(<16 x i8> %inactive, <16 x i8> %a, <16 x i8> %b, i16 zeroext %p) local_unnamed_addr #1 {
; CHECK-LABEL: test_vminq_m_s8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vmint.s8 q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 %0)
  %2 = tail call <16 x i8> @llvm.arm.mve.min.predicated.v16i8.v16i1(<16 x i8> %a, <16 x i8> %b, <16 x i1> %1, <16 x i8> %inactive)
  ret <16 x i8> %2
}

declare <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32) #2

declare <16 x i8> @llvm.arm.mve.min.predicated.v16i8.v16i1(<16 x i8>, <16 x i8>, <16 x i1>, <16 x i8>) #2

define dso_local arm_aapcs_vfpcc <8 x i16> @test_vminq_m_u16(<8 x i16> %inactive, <8 x i16> %a, <8 x i16> %b, i16 zeroext %p) local_unnamed_addr #1 {
; CHECK-LABEL: test_vminq_m_u16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vmint.s16 q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 %0)
  %2 = tail call <8 x i16> @llvm.arm.mve.min.predicated.v8i16.v8i1(<8 x i16> %a, <8 x i16> %b, <8 x i1> %1, <8 x i16> %inactive)
  ret <8 x i16> %2
}

declare <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32) #2

declare <8 x i16> @llvm.arm.mve.min.predicated.v8i16.v8i1(<8 x i16>, <8 x i16>, <8 x i1>, <8 x i16>) #2

define dso_local arm_aapcs_vfpcc <4 x i32> @test_vminq_m_s32(<4 x i32> %inactive, <4 x i32> %a, <4 x i32> %b, i16 zeroext %p) local_unnamed_addr #1 {
; CHECK-LABEL: test_vminq_m_s32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vmint.s32 q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %0)
  %2 = tail call <4 x i32> @llvm.arm.mve.min.predicated.v4i32.v4i1(<4 x i32> %a, <4 x i32> %b, <4 x i1> %1, <4 x i32> %inactive)
  ret <4 x i32> %2
}

declare <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32) #2

declare <4 x i32> @llvm.arm.mve.min.predicated.v4i32.v4i1(<4 x i32>, <4 x i32>, <4 x i1>, <4 x i32>) #2
