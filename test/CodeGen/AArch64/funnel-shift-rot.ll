; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s

declare i8 @llvm.fshl.i8(i8, i8, i8)
declare i16 @llvm.fshl.i16(i16, i16, i16)
declare i32 @llvm.fshl.i32(i32, i32, i32)
declare i64 @llvm.fshl.i64(i64, i64, i64)
declare <4 x i32> @llvm.fshl.v4i32(<4 x i32>, <4 x i32>, <4 x i32>)

declare i8 @llvm.fshr.i8(i8, i8, i8)
declare i16 @llvm.fshr.i16(i16, i16, i16)
declare i32 @llvm.fshr.i32(i32, i32, i32)
declare i64 @llvm.fshr.i64(i64, i64, i64)
declare <4 x i32> @llvm.fshr.v4i32(<4 x i32>, <4 x i32>, <4 x i32>)

; When first 2 operands match, it's a rotate.

define i8 @rotl_i8_const_shift(i8 %x) {
; CHECK-LABEL: rotl_i8_const_shift:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ubfx w8, w0, #5, #3
; CHECK-NEXT:    bfi w8, w0, #3, #29
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
  %f = call i8 @llvm.fshl.i8(i8 %x, i8 %x, i8 3)
  ret i8 %f
}

define i64 @rotl_i64_const_shift(i64 %x) {
; CHECK-LABEL: rotl_i64_const_shift:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ror x0, x0, #61
; CHECK-NEXT:    ret
  %f = call i64 @llvm.fshl.i64(i64 %x, i64 %x, i64 3)
  ret i64 %f
}

; When first 2 operands match, it's a rotate (by variable amount).

define i16 @rotl_i16(i16 %x, i16 %z) {
; CHECK-LABEL: rotl_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg w10, w1
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    and w9, w1, #0xf
; CHECK-NEXT:    and w10, w10, #0xf
; CHECK-NEXT:    lsl w9, w0, w9
; CHECK-NEXT:    lsr w8, w8, w10
; CHECK-NEXT:    orr w0, w9, w8
; CHECK-NEXT:    ret
  %f = call i16 @llvm.fshl.i16(i16 %x, i16 %x, i16 %z)
  ret i16 %f
}

define i32 @rotl_i32(i32 %x, i32 %z) {
; CHECK-LABEL: rotl_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg w8, w1
; CHECK-NEXT:    ror w0, w0, w8
; CHECK-NEXT:    ret
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %x, i32 %z)
  ret i32 %f
}

define i64 @rotl_i64(i64 %x, i64 %z) {
; CHECK-LABEL: rotl_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    neg w8, w1
; CHECK-NEXT:    ror x0, x0, x8
; CHECK-NEXT:    ret
  %f = call i64 @llvm.fshl.i64(i64 %x, i64 %x, i64 %z)
  ret i64 %f
}

; Vector rotate.

define <4 x i32> @rotl_v4i32(<4 x i32> %x, <4 x i32> %z) {
; CHECK-LABEL: rotl_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v2.4s, #31
; CHECK-NEXT:    neg v3.4s, v1.4s
; CHECK-NEXT:    and v1.16b, v1.16b, v2.16b
; CHECK-NEXT:    and v2.16b, v3.16b, v2.16b
; CHECK-NEXT:    neg v2.4s, v2.4s
; CHECK-NEXT:    ushl v1.4s, v0.4s, v1.4s
; CHECK-NEXT:    ushl v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    orr v0.16b, v1.16b, v0.16b
; CHECK-NEXT:    ret
  %f = call <4 x i32> @llvm.fshl.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> %z)
  ret <4 x i32> %f
}

; Vector rotate by constant splat amount.

define <4 x i32> @rotl_v4i32_rotl_const_shift(<4 x i32> %x) {
; CHECK-LABEL: rotl_v4i32_rotl_const_shift:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushr v1.4s, v0.4s, #29
; CHECK-NEXT:    shl v0.4s, v0.4s, #3
; CHECK-NEXT:    orr v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %f = call <4 x i32> @llvm.fshl.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> <i32 3, i32 3, i32 3, i32 3>)
  ret <4 x i32> %f
}

; Repeat everything for funnel shift right.

; When first 2 operands match, it's a rotate.

define i8 @rotr_i8_const_shift(i8 %x) {
; CHECK-LABEL: rotr_i8_const_shift:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsl w8, w0, #5
; CHECK-NEXT:    bfxil w8, w0, #3, #5
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
  %f = call i8 @llvm.fshr.i8(i8 %x, i8 %x, i8 3)
  ret i8 %f
}

define i32 @rotr_i32_const_shift(i32 %x) {
; CHECK-LABEL: rotr_i32_const_shift:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ror w0, w0, #3
; CHECK-NEXT:    ret
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %x, i32 3)
  ret i32 %f
}

; When first 2 operands match, it's a rotate (by variable amount).

define i16 @rotr_i16(i16 %x, i16 %z) {
; CHECK-LABEL: rotr_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    and w9, w1, #0xf
; CHECK-NEXT:    neg w10, w1
; CHECK-NEXT:    lsr w8, w8, w9
; CHECK-NEXT:    and w9, w10, #0xf
; CHECK-NEXT:    lsl w9, w0, w9
; CHECK-NEXT:    orr w0, w8, w9
; CHECK-NEXT:    ret
  %f = call i16 @llvm.fshr.i16(i16 %x, i16 %x, i16 %z)
  ret i16 %f
}

define i32 @rotr_i32(i32 %x, i32 %z) {
; CHECK-LABEL: rotr_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ror w0, w0, w1
; CHECK-NEXT:    ret
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %x, i32 %z)
  ret i32 %f
}

define i64 @rotr_i64(i64 %x, i64 %z) {
; CHECK-LABEL: rotr_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ror x0, x0, x1
; CHECK-NEXT:    ret
  %f = call i64 @llvm.fshr.i64(i64 %x, i64 %x, i64 %z)
  ret i64 %f
}

; Vector rotate.

define <4 x i32> @rotr_v4i32(<4 x i32> %x, <4 x i32> %z) {
; CHECK-LABEL: rotr_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v3.4s, #31
; CHECK-NEXT:    neg v2.4s, v1.4s
; CHECK-NEXT:    and v1.16b, v1.16b, v3.16b
; CHECK-NEXT:    and v2.16b, v2.16b, v3.16b
; CHECK-NEXT:    neg v1.4s, v1.4s
; CHECK-NEXT:    ushl v2.4s, v0.4s, v2.4s
; CHECK-NEXT:    ushl v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    orr v0.16b, v0.16b, v2.16b
; CHECK-NEXT:    ret
  %f = call <4 x i32> @llvm.fshr.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> %z)
  ret <4 x i32> %f
}

; Vector rotate by constant splat amount.

define <4 x i32> @rotr_v4i32_const_shift(<4 x i32> %x) {
; CHECK-LABEL: rotr_v4i32_const_shift:
; CHECK:       // %bb.0:
; CHECK-NEXT:    shl v1.4s, v0.4s, #29
; CHECK-NEXT:    ushr v0.4s, v0.4s, #3
; CHECK-NEXT:    orr v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %f = call <4 x i32> @llvm.fshr.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> <i32 3, i32 3, i32 3, i32 3>)
  ret <4 x i32> %f
}

define i32 @rotl_i32_shift_by_bitwidth(i32 %x) {
; CHECK-LABEL: rotl_i32_shift_by_bitwidth:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %f = call i32 @llvm.fshl.i32(i32 %x, i32 %x, i32 32)
  ret i32 %f
}

define i32 @rotr_i32_shift_by_bitwidth(i32 %x) {
; CHECK-LABEL: rotr_i32_shift_by_bitwidth:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %f = call i32 @llvm.fshr.i32(i32 %x, i32 %x, i32 32)
  ret i32 %f
}

define <4 x i32> @rotl_v4i32_shift_by_bitwidth(<4 x i32> %x) {
; CHECK-LABEL: rotl_v4i32_shift_by_bitwidth:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %f = call <4 x i32> @llvm.fshl.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> <i32 32, i32 32, i32 32, i32 32>)
  ret <4 x i32> %f
}

define <4 x i32> @rotr_v4i32_shift_by_bitwidth(<4 x i32> %x) {
; CHECK-LABEL: rotr_v4i32_shift_by_bitwidth:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %f = call <4 x i32> @llvm.fshr.v4i32(<4 x i32> %x, <4 x i32> %x, <4 x i32> <i32 32, i32 32, i32 32, i32 32>)
  ret <4 x i32> %f
}

