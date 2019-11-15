; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main -mattr=+mve.fp -verify-machineinstrs -o - %s | FileCheck %s

define arm_aapcs_vfpcc <16 x i8> @test_veorq_u8(<16 x i8> %a, <16 x i8> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_veorq_u8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    veor q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %0 = xor <16 x i8> %b, %a
  ret <16 x i8> %0
}

define arm_aapcs_vfpcc <4 x i32> @test_veorq_u32(<4 x i32> %a, <4 x i32> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_veorq_u32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    veor q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %0 = xor <4 x i32> %b, %a
  ret <4 x i32> %0
}

define arm_aapcs_vfpcc <8 x i16> @test_veorq_s16(<8 x i16> %a, <8 x i16> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_veorq_s16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    veor q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %0 = xor <8 x i16> %b, %a
  ret <8 x i16> %0
}

define arm_aapcs_vfpcc <4 x float> @test_veorq_f32(<4 x float> %a, <4 x float> %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_veorq_f32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    veor q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %0 = bitcast <4 x float> %a to <4 x i32>
  %1 = bitcast <4 x float> %b to <4 x i32>
  %2 = xor <4 x i32> %1, %0
  %3 = bitcast <4 x i32> %2 to <4 x float>
  ret <4 x float> %3
}

define arm_aapcs_vfpcc <16 x i8> @test_veorq_m_s8(<16 x i8> %inactive, <16 x i8> %a, <16 x i8> %b, i16 zeroext %p) local_unnamed_addr #1 {
; CHECK-LABEL: test_veorq_m_s8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    veort q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32 %0)
  %2 = tail call <16 x i8> @llvm.arm.mve.eor.predicated.v16i8.v16i1(<16 x i8> %a, <16 x i8> %b, <16 x i1> %1, <16 x i8> %inactive)
  ret <16 x i8> %2
}

declare <16 x i1> @llvm.arm.mve.pred.i2v.v16i1(i32) #2

declare <16 x i8> @llvm.arm.mve.eor.predicated.v16i8.v16i1(<16 x i8>, <16 x i8>, <16 x i1>, <16 x i8>) #2

define arm_aapcs_vfpcc <8 x i16> @test_veorq_m_u16(<8 x i16> %inactive, <8 x i16> %a, <8 x i16> %b, i16 zeroext %p) local_unnamed_addr #1 {
; CHECK-LABEL: test_veorq_m_u16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    veort q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = zext i16 %p to i32
  %1 = tail call <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32 %0)
  %2 = tail call <8 x i16> @llvm.arm.mve.eor.predicated.v8i16.v8i1(<8 x i16> %a, <8 x i16> %b, <8 x i1> %1, <8 x i16> %inactive)
  ret <8 x i16> %2
}

declare <8 x i1> @llvm.arm.mve.pred.i2v.v8i1(i32) #2

declare <8 x i16> @llvm.arm.mve.eor.predicated.v8i16.v8i1(<8 x i16>, <8 x i16>, <8 x i1>, <8 x i16>) #2

; Function Attrs: nounwind readnone
define arm_aapcs_vfpcc <8 x half> @test_veorq_m_f32(<4 x float> %inactive, <4 x float> %a, <4 x float> %b, i16 zeroext %p) local_unnamed_addr #1 {
; CHECK-LABEL: test_veorq_m_f32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmsr p0, r0
; CHECK-NEXT:    vpst
; CHECK-NEXT:    veort q0, q1, q2
; CHECK-NEXT:    bx lr
entry:
  %0 = bitcast <4 x float> %a to <4 x i32>
  %1 = bitcast <4 x float> %b to <4 x i32>
  %2 = zext i16 %p to i32
  %3 = tail call <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32 %2)
  %4 = bitcast <4 x float> %inactive to <4 x i32>
  %5 = tail call <4 x i32> @llvm.arm.mve.eor.predicated.v4i32.v4i1(<4 x i32> %0, <4 x i32> %1, <4 x i1> %3, <4 x i32> %4)
  %6 = bitcast <4 x i32> %5 to <8 x half>
  ret <8 x half> %6
}

declare <4 x i1> @llvm.arm.mve.pred.i2v.v4i1(i32) #2

declare <4 x i32> @llvm.arm.mve.eor.predicated.v4i32.v4i1(<4 x i32>, <4 x i32>, <4 x i1>, <4 x i32>) #2
