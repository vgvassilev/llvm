; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp %s -o - | FileCheck %s

declare i64 @llvm.vector.reduce.add.i64.v2i64(<2 x i64>)
declare i32 @llvm.vector.reduce.add.i32.v4i32(<4 x i32>)
declare i32 @llvm.vector.reduce.add.i32.v8i32(<8 x i32>)
declare i16 @llvm.vector.reduce.add.i16.v8i16(<8 x i16>)
declare i16 @llvm.vector.reduce.add.i16.v16i16(<16 x i16>)
declare i8 @llvm.vector.reduce.add.i8.v16i8(<16 x i8>)
declare i8 @llvm.vector.reduce.add.i8.v32i8(<32 x i8>)

define arm_aapcs_vfpcc i64 @vaddv_v2i64_i64(<2 x i64> %s1) {
; CHECK-LABEL: vaddv_v2i64_i64:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov r0, r1, d1
; CHECK-NEXT:    vmov r2, r3, d0
; CHECK-NEXT:    adds r0, r0, r2
; CHECK-NEXT:    adcs r1, r3
; CHECK-NEXT:    bx lr
entry:
  %r = call i64 @llvm.vector.reduce.add.i64.v2i64(<2 x i64> %s1)
  ret i64 %r
}

define arm_aapcs_vfpcc i32 @vaddv_v4i32_i32(<4 x i32> %s1) {
; CHECK-LABEL: vaddv_v4i32_i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vaddv.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %r = call i32 @llvm.vector.reduce.add.i32.v4i32(<4 x i32> %s1)
  ret i32 %r
}

define arm_aapcs_vfpcc i32 @vaddv_v8i32_i32(<8 x i32> %s1) {
; CHECK-LABEL: vaddv_v8i32_i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    vaddv.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %r = call i32 @llvm.vector.reduce.add.i32.v8i32(<8 x i32> %s1)
  ret i32 %r
}

define arm_aapcs_vfpcc i16 @vaddv_v8i16_i16(<8 x i16> %s1) {
; CHECK-LABEL: vaddv_v8i16_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vaddv.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %r = call i16 @llvm.vector.reduce.add.i16.v8i16(<8 x i16> %s1)
  ret i16 %r
}

define arm_aapcs_vfpcc i16 @vaddv_v16i16_i16(<16 x i16> %s1) {
; CHECK-LABEL: vaddv_v16i16_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i16 q0, q0, q1
; CHECK-NEXT:    vaddv.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %r = call i16 @llvm.vector.reduce.add.i16.v16i16(<16 x i16> %s1)
  ret i16 %r
}

define arm_aapcs_vfpcc i8 @vaddv_v16i8_i8(<16 x i8> %s1) {
; CHECK-LABEL: vaddv_v16i8_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vaddv.u8 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %r = call i8 @llvm.vector.reduce.add.i8.v16i8(<16 x i8> %s1)
  ret i8 %r
}

define arm_aapcs_vfpcc i8 @vaddv_v32i8_i8(<32 x i8> %s1) {
; CHECK-LABEL: vaddv_v32i8_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i8 q0, q0, q1
; CHECK-NEXT:    vaddv.u8 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %r = call i8 @llvm.vector.reduce.add.i8.v32i8(<32 x i8> %s1)
  ret i8 %r
}

define arm_aapcs_vfpcc i64 @vaddva_v2i64_i64(<2 x i64> %s1, i64 %x) {
; CHECK-LABEL: vaddva_v2i64_i64:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    vmov lr, r12, d1
; CHECK-NEXT:    vmov r3, r2, d0
; CHECK-NEXT:    adds.w r3, r3, lr
; CHECK-NEXT:    adc.w r2, r2, r12
; CHECK-NEXT:    adds r0, r0, r3
; CHECK-NEXT:    adcs r1, r2
; CHECK-NEXT:    pop {r7, pc}
entry:
  %t = call i64 @llvm.vector.reduce.add.i64.v2i64(<2 x i64> %s1)
  %r = add i64 %t, %x
  ret i64 %r
}

define arm_aapcs_vfpcc i32 @vaddva_v4i32_i32(<4 x i32> %s1, i32 %x) {
; CHECK-LABEL: vaddva_v4i32_i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vaddva.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %t = call i32 @llvm.vector.reduce.add.i32.v4i32(<4 x i32> %s1)
  %r = add i32 %t, %x
  ret i32 %r
}

define arm_aapcs_vfpcc i32 @vaddva_v8i32_i32(<8 x i32> %s1, i32 %x) {
; CHECK-LABEL: vaddva_v8i32_i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i32 q0, q0, q1
; CHECK-NEXT:    vaddva.u32 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %t = call i32 @llvm.vector.reduce.add.i32.v8i32(<8 x i32> %s1)
  %r = add i32 %t, %x
  ret i32 %r
}

define arm_aapcs_vfpcc i16 @vaddva_v8i16_i16(<8 x i16> %s1, i16 %x) {
; CHECK-LABEL: vaddva_v8i16_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vaddva.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %t = call i16 @llvm.vector.reduce.add.i16.v8i16(<8 x i16> %s1)
  %r = add i16 %t, %x
  ret i16 %r
}

define arm_aapcs_vfpcc i16 @vaddva_v16i16_i16(<16 x i16> %s1, i16 %x) {
; CHECK-LABEL: vaddva_v16i16_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i16 q0, q0, q1
; CHECK-NEXT:    vaddva.u16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %t = call i16 @llvm.vector.reduce.add.i16.v16i16(<16 x i16> %s1)
  %r = add i16 %t, %x
  ret i16 %r
}

define arm_aapcs_vfpcc i8 @vaddva_v16i8_i8(<16 x i8> %s1, i8 %x) {
; CHECK-LABEL: vaddva_v16i8_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vaddva.u8 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %t = call i8 @llvm.vector.reduce.add.i8.v16i8(<16 x i8> %s1)
  %r = add i8 %t, %x
  ret i8 %r
}

define arm_aapcs_vfpcc i8 @vaddva_v32i8_i8(<32 x i8> %s1, i8 %x) {
; CHECK-LABEL: vaddva_v32i8_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vadd.i8 q0, q0, q1
; CHECK-NEXT:    vaddva.u8 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %t = call i8 @llvm.vector.reduce.add.i8.v32i8(<32 x i8> %s1)
  %r = add i8 %t, %x
  ret i8 %r
}
