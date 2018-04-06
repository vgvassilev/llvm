; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -mtriple=x86_64-apple-macosx10.8.0 -cost-model -analyze -mattr=+sse2 | FileCheck %s --check-prefixes=CHECK,SSE,SSE2
; RUN: opt < %s -mtriple=x86_64-apple-macosx10.8.0 -cost-model -analyze -mattr=+ssse3 | FileCheck %s --check-prefixes=CHECK,SSE,SSSE3
; RUN: opt < %s -mtriple=x86_64-apple-macosx10.8.0 -cost-model -analyze -mattr=+sse4.2 | FileCheck %s --check-prefixes=CHECK,SSE,SSE42
; RUN: opt < %s -mtriple=x86_64-apple-macosx10.8.0 -cost-model -analyze -mattr=+avx | FileCheck %s --check-prefixes=CHECK,AVX,AVX1
; RUN: opt < %s -mtriple=x86_64-apple-macosx10.8.0 -cost-model -analyze -mattr=+avx2 | FileCheck %s --check-prefixes=CHECK,AVX,AVX2
; RUN: opt < %s -mtriple=x86_64-apple-macosx10.8.0 -cost-model -analyze -mattr=+avx512f | FileCheck %s --check-prefixes=CHECK,AVX512,AVX512F
; RUN: opt < %s -mtriple=x86_64-apple-macosx10.8.0 -cost-model -analyze -mattr=+avx512f,+avx512bw | FileCheck %s --check-prefixes=CHECK,AVX512,AVX512BW

define i32 @srem() {
; CHECK-LABEL: 'srem'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = srem i64 undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %V2i64 = srem <2 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %V4i64 = srem <4 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %V8i64 = srem <8 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = srem i32 undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %V4i32 = srem <4 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %V8i32 = srem <8 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %V16i32 = srem <16 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = srem i16 undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %V8i16 = srem <8 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %V16i16 = srem <16 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %V32i16 = srem <32 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = srem i8 undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %V16i8 = srem <16 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %V32i8 = srem <32 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 192 for instruction: %V64i8 = srem <64 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
  %I64 = srem i64 undef, undef
  %V2i64 = srem <2 x i64> undef, undef
  %V4i64 = srem <4 x i64> undef, undef
  %V8i64 = srem <8 x i64> undef, undef

  %I32 = srem i32 undef, undef
  %V4i32 = srem <4 x i32> undef, undef
  %V8i32 = srem <8 x i32> undef, undef
  %V16i32 = srem <16 x i32> undef, undef

  %I16 = srem i16 undef, undef
  %V8i16 = srem <8 x i16> undef, undef
  %V16i16 = srem <16 x i16> undef, undef
  %V32i16 = srem <32 x i16> undef, undef

  %I8 = srem i8 undef, undef
  %V16i8 = srem <16 x i8> undef, undef
  %V32i8 = srem <32 x i8> undef, undef
  %V64i8 = srem <64 x i8> undef, undef

  ret i32 undef
}

define i32 @urem() {
; CHECK-LABEL: 'urem'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = urem i64 undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %V2i64 = urem <2 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %V4i64 = urem <4 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %V8i64 = urem <8 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = urem i32 undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %V4i32 = urem <4 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %V8i32 = urem <8 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %V16i32 = urem <16 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = urem i16 undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: %V8i16 = urem <8 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %V16i16 = urem <16 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %V32i16 = urem <32 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = urem i8 undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 48 for instruction: %V16i8 = urem <16 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 96 for instruction: %V32i8 = urem <32 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 192 for instruction: %V64i8 = urem <64 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
  %I64 = urem i64 undef, undef
  %V2i64 = urem <2 x i64> undef, undef
  %V4i64 = urem <4 x i64> undef, undef
  %V8i64 = urem <8 x i64> undef, undef

  %I32 = urem i32 undef, undef
  %V4i32 = urem <4 x i32> undef, undef
  %V8i32 = urem <8 x i32> undef, undef
  %V16i32 = urem <16 x i32> undef, undef

  %I16 = urem i16 undef, undef
  %V8i16 = urem <8 x i16> undef, undef
  %V16i16 = urem <16 x i16> undef, undef
  %V32i16 = urem <32 x i16> undef, undef

  %I8 = urem i8 undef, undef
  %V16i8 = urem <16 x i8> undef, undef
  %V32i8 = urem <32 x i8> undef, undef
  %V64i8 = urem <64 x i8> undef, undef

  ret i32 undef
}
