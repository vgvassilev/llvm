; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-none-none-eabi -verify-machineinstrs %s -o - | FileCheck %s

define <4 x i16> @vqmovni32_smaxmin(<4 x i32> %s0) {
; CHECK-LABEL: vqmovni32_smaxmin:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqxtn v0.4h, v0.4s
; CHECK-NEXT:    ret
entry:
  %c1 = icmp slt <4 x i32> %s0, <i32 32767, i32 32767, i32 32767, i32 32767>
  %s1 = select <4 x i1> %c1, <4 x i32> %s0, <4 x i32> <i32 32767, i32 32767, i32 32767, i32 32767>
  %c2 = icmp sgt <4 x i32> %s1, <i32 -32768, i32 -32768, i32 -32768, i32 -32768>
  %s2 = select <4 x i1> %c2, <4 x i32> %s1, <4 x i32> <i32 -32768, i32 -32768, i32 -32768, i32 -32768>
  %t = trunc <4 x i32> %s2 to <4 x i16>
  ret <4 x i16> %t
}

define <4 x i16> @vqmovni32_sminmax(<4 x i32> %s0) {
; CHECK-LABEL: vqmovni32_sminmax:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqxtn v0.4h, v0.4s
; CHECK-NEXT:    ret
entry:
  %c1 = icmp sgt <4 x i32> %s0, <i32 -32768, i32 -32768, i32 -32768, i32 -32768>
  %s1 = select <4 x i1> %c1, <4 x i32> %s0, <4 x i32> <i32 -32768, i32 -32768, i32 -32768, i32 -32768>
  %c2 = icmp slt <4 x i32> %s1, <i32 32767, i32 32767, i32 32767, i32 32767>
  %s2 = select <4 x i1> %c2, <4 x i32> %s1, <4 x i32> <i32 32767, i32 32767, i32 32767, i32 32767>
  %t = trunc <4 x i32> %s2 to <4 x i16>
  ret <4 x i16> %t
}

define <4 x i16> @vqmovni32_umaxmin(<4 x i32> %s0) {
; CHECK-LABEL: vqmovni32_umaxmin:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uqxtn v0.4h, v0.4s
; CHECK-NEXT:    ret
entry:
  %c1 = icmp ult <4 x i32> %s0, <i32 65535, i32 65535, i32 65535, i32 65535>
  %s1 = select <4 x i1> %c1, <4 x i32> %s0, <4 x i32> <i32 65535, i32 65535, i32 65535, i32 65535>
  %t = trunc <4 x i32> %s1 to <4 x i16>
  ret <4 x i16> %t
}

define <8 x i8> @vqmovni16_smaxmin(<8 x i16> %s0) {
; CHECK-LABEL: vqmovni16_smaxmin:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqxtn v0.8b, v0.8h
; CHECK-NEXT:    ret
entry:
  %c1 = icmp slt <8 x i16> %s0, <i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127>
  %s1 = select <8 x i1> %c1, <8 x i16> %s0, <8 x i16> <i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127>
  %c2 = icmp sgt <8 x i16> %s1, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %s2 = select <8 x i1> %c2, <8 x i16> %s1, <8 x i16> <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %t = trunc <8 x i16> %s2 to <8 x i8>
  ret <8 x i8> %t
}

define <8 x i8> @vqmovni16_sminmax(<8 x i16> %s0) {
; CHECK-LABEL: vqmovni16_sminmax:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sqxtn v0.8b, v0.8h
; CHECK-NEXT:    ret
entry:
  %c1 = icmp sgt <8 x i16> %s0, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %s1 = select <8 x i1> %c1, <8 x i16> %s0, <8 x i16> <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %c2 = icmp slt <8 x i16> %s1, <i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127>
  %s2 = select <8 x i1> %c2, <8 x i16> %s1, <8 x i16> <i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127, i16 127>
  %t = trunc <8 x i16> %s2 to <8 x i8>
  ret <8 x i8> %t
}

define <8 x i8> @vqmovni16_umaxmin(<8 x i16> %s0) {
; CHECK-LABEL: vqmovni16_umaxmin:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uqxtn v0.8b, v0.8h
; CHECK-NEXT:    ret
entry:
  %c1 = icmp ult <8 x i16> %s0, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %s1 = select <8 x i1> %c1, <8 x i16> %s0, <8 x i16> <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  %t = trunc <8 x i16> %s1 to <8 x i8>
  ret <8 x i8> %t
}

define <2 x i32> @vqmovni64_smaxmin(<2 x i64> %s0) {
; CHECK-LABEL: vqmovni64_smaxmin:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #2147483647
; CHECK-NEXT:    dup v1.2d, x8
; CHECK-NEXT:    mov x9, #-2147483648
; CHECK-NEXT:    cmgt v2.2d, v1.2d, v0.2d
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    dup v1.2d, x9
; CHECK-NEXT:    cmgt v2.2d, v0.2d, v1.2d
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    xtn v0.2s, v0.2d
; CHECK-NEXT:    ret
entry:
  %c1 = icmp slt <2 x i64> %s0, <i64 2147483647, i64 2147483647>
  %s1 = select <2 x i1> %c1, <2 x i64> %s0, <2 x i64> <i64 2147483647, i64 2147483647>
  %c2 = icmp sgt <2 x i64> %s1, <i64 -2147483648, i64 -2147483648>
  %s2 = select <2 x i1> %c2, <2 x i64> %s1, <2 x i64> <i64 -2147483648, i64 -2147483648>
  %t = trunc <2 x i64> %s2 to <2 x i32>
  ret <2 x i32> %t
}

define <2 x i32> @vqmovni64_sminmax(<2 x i64> %s0) {
; CHECK-LABEL: vqmovni64_sminmax:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov x8, #-2147483648
; CHECK-NEXT:    dup v1.2d, x8
; CHECK-NEXT:    mov w9, #2147483647
; CHECK-NEXT:    cmgt v2.2d, v0.2d, v1.2d
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    dup v1.2d, x9
; CHECK-NEXT:    cmgt v2.2d, v1.2d, v0.2d
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    xtn v0.2s, v0.2d
; CHECK-NEXT:    ret
entry:
  %c1 = icmp sgt <2 x i64> %s0, <i64 -2147483648, i64 -2147483648>
  %s1 = select <2 x i1> %c1, <2 x i64> %s0, <2 x i64> <i64 -2147483648, i64 -2147483648>
  %c2 = icmp slt <2 x i64> %s1, <i64 2147483647, i64 2147483647>
  %s2 = select <2 x i1> %c2, <2 x i64> %s1, <2 x i64> <i64 2147483647, i64 2147483647>
  %t = trunc <2 x i64> %s2 to <2 x i32>
  ret <2 x i32> %t
}

define <2 x i32> @vqmovni64_umaxmin(<2 x i64> %s0) {
; CHECK-LABEL: vqmovni64_umaxmin:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v1.2d, #0x000000ffffffff
; CHECK-NEXT:    cmhi v1.2d, v1.2d, v0.2d
; CHECK-NEXT:    and v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    orn v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    xtn v0.2s, v0.2d
; CHECK-NEXT:    ret
entry:
  %c1 = icmp ult <2 x i64> %s0, <i64 4294967295, i64 4294967295>
  %s1 = select <2 x i1> %c1, <2 x i64> %s0, <2 x i64> <i64 4294967295, i64 4294967295>
  %t = trunc <2 x i64> %s1 to <2 x i32>
  ret <2 x i32> %t
}
