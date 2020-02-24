; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+sse2 | FileCheck %s -check-prefixes=CHECK,SSE,SSE2
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+ssse3 | FileCheck %s -check-prefixes=CHECK,SSE,SSSE3
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+sse4.2 | FileCheck %s -check-prefixes=CHECK,SSE,SSE42
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+avx | FileCheck %s -check-prefixes=CHECK,AVX,AVX1
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+avx2 | FileCheck %s -check-prefixes=CHECK,AVX,AVX2
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+avx512f | FileCheck %s --check-prefixes=CHECK,AVX512,AVX512F
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+avx512f,+avx512bw | FileCheck %s --check-prefixes=CHECK,AVX512
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mattr=+avx512f,+avx512bw,+avx512vbmi | FileCheck %s --check-prefixes=CHECK,AVX512
;
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mcpu=slm | FileCheck %s --check-prefixes=CHECK,SSE,SSE42
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mcpu=goldmont | FileCheck %s --check-prefixes=CHECK,SSE,SSE42
; RUN: opt < %s -mtriple=x86_64-unknown-linux-gnu -cost-model -analyze -mcpu=btver2 | FileCheck %s --check-prefixes=CHECK,AVX,BTVER2

;
; Verify the cost model for insert_subector style shuffles.
;

define void @test_vXf64(<2 x double> %src128, <4 x double> %src256, <8 x double> %src512) {
; SSE-LABEL: 'test_vXf64'
; SSE-NEXT:  Cost Model: Unknown cost for instruction: %src128_256 = shufflevector <2 x double> %src128, <2 x double> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
; SSE-NEXT:  Cost Model: Unknown cost for instruction: %src128_512 = shufflevector <2 x double> %src128, <2 x double> undef, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE-NEXT:  Cost Model: Unknown cost for instruction: %src256_512 = shufflevector <4 x double> %src256, <4 x double> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V256_01 = shufflevector <4 x double> %src256, <4 x double> %src128_256, <4 x i32> <i32 4, i32 5, i32 2, i32 3>
; SSE-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %V256_23 = shufflevector <4 x double> %src256, <4 x double> %src128_256, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
; SSE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V512_01 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 8, i32 9, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; SSE-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %V512_23 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 4, i32 5, i32 6, i32 7>
; SSE-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %V512_45 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
; SSE-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %V512_67 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
; SSE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V512_0123 = shufflevector <8 x double> %src512, <8 x double> %src256_512, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7>
; SSE-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %V512_4567 = shufflevector <8 x double> %src512, <8 x double> %src256_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
; SSE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; AVX-LABEL: 'test_vXf64'
; AVX-NEXT:  Cost Model: Unknown cost for instruction: %src128_256 = shufflevector <2 x double> %src128, <2 x double> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
; AVX-NEXT:  Cost Model: Unknown cost for instruction: %src128_512 = shufflevector <2 x double> %src128, <2 x double> undef, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:  Cost Model: Unknown cost for instruction: %src256_512 = shufflevector <4 x double> %src256, <4 x double> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V256_01 = shufflevector <4 x double> %src256, <4 x double> %src128_256, <4 x i32> <i32 4, i32 5, i32 2, i32 3>
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V256_23 = shufflevector <4 x double> %src256, <4 x double> %src128_256, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
; AVX-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V512_01 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 8, i32 9, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:  Cost Model: Found an estimated cost of 18 for instruction: %V512_23 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:  Cost Model: Found an estimated cost of 18 for instruction: %V512_45 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
; AVX-NEXT:  Cost Model: Found an estimated cost of 18 for instruction: %V512_67 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
; AVX-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V512_0123 = shufflevector <8 x double> %src512, <8 x double> %src256_512, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:  Cost Model: Found an estimated cost of 18 for instruction: %V512_4567 = shufflevector <8 x double> %src512, <8 x double> %src256_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
; AVX-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; AVX512-LABEL: 'test_vXf64'
; AVX512-NEXT:  Cost Model: Unknown cost for instruction: %src128_256 = shufflevector <2 x double> %src128, <2 x double> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
; AVX512-NEXT:  Cost Model: Unknown cost for instruction: %src128_512 = shufflevector <2 x double> %src128, <2 x double> undef, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX512-NEXT:  Cost Model: Unknown cost for instruction: %src256_512 = shufflevector <4 x double> %src256, <4 x double> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V256_01 = shufflevector <4 x double> %src256, <4 x double> %src128_256, <4 x i32> <i32 4, i32 5, i32 2, i32 3>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V256_23 = shufflevector <4 x double> %src256, <4 x double> %src128_256, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 14 for instruction: %V512_01 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 8, i32 9, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V512_23 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 4, i32 5, i32 6, i32 7>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V512_45 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V512_67 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 14 for instruction: %V512_0123 = shufflevector <8 x double> %src512, <8 x double> %src256_512, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V512_4567 = shufflevector <8 x double> %src512, <8 x double> %src256_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %src128_256 = shufflevector <2 x double> %src128, <2 x double> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %src128_512 = shufflevector <2 x double> %src128, <2 x double> undef, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %src256_512 = shufflevector <4 x double> %src256, <4 x double> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>

  %V256_01 = shufflevector <4 x double> %src256, <4 x double> %src128_256, <4 x i32> <i32 4, i32 5, i32 2, i32 3>
  %V256_23 = shufflevector <4 x double> %src256, <4 x double> %src128_256, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
  %V512_01 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 8, i32 9, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %V512_23 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 4, i32 5, i32 6, i32 7>
  %V512_45 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
  %V512_67 = shufflevector <8 x double> %src512, <8 x double> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
  %V512_0123 = shufflevector <8 x double> %src512, <8 x double> %src256_512, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7>
  %V512_4567 = shufflevector <8 x double> %src512, <8 x double> %src256_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
  ret void
}

define void @test_vXi64(<2 x i64> %src128, <4 x i64> %src256, <8 x i64> %src512) {
; SSE-LABEL: 'test_vXi64'
; SSE-NEXT:  Cost Model: Unknown cost for instruction: %src128_256 = shufflevector <2 x i64> %src128, <2 x i64> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
; SSE-NEXT:  Cost Model: Unknown cost for instruction: %src128_512 = shufflevector <2 x i64> %src128, <2 x i64> undef, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE-NEXT:  Cost Model: Unknown cost for instruction: %src256_512 = shufflevector <4 x i64> %src256, <4 x i64> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V256_01 = shufflevector <4 x i64> %src256, <4 x i64> %src128_256, <4 x i32> <i32 4, i32 5, i32 2, i32 3>
; SSE-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %V256_23 = shufflevector <4 x i64> %src256, <4 x i64> %src128_256, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
; SSE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V512_01 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 8, i32 9, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; SSE-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %V512_23 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 4, i32 5, i32 6, i32 7>
; SSE-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %V512_45 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
; SSE-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %V512_67 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
; SSE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V512_0123 = shufflevector <8 x i64> %src512, <8 x i64> %src256_512, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7>
; SSE-NEXT:  Cost Model: Found an estimated cost of 28 for instruction: %V512_4567 = shufflevector <8 x i64> %src512, <8 x i64> %src256_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
; SSE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; AVX-LABEL: 'test_vXi64'
; AVX-NEXT:  Cost Model: Unknown cost for instruction: %src128_256 = shufflevector <2 x i64> %src128, <2 x i64> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
; AVX-NEXT:  Cost Model: Unknown cost for instruction: %src128_512 = shufflevector <2 x i64> %src128, <2 x i64> undef, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:  Cost Model: Unknown cost for instruction: %src256_512 = shufflevector <4 x i64> %src256, <4 x i64> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V256_01 = shufflevector <4 x i64> %src256, <4 x i64> %src128_256, <4 x i32> <i32 4, i32 5, i32 2, i32 3>
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %V256_23 = shufflevector <4 x i64> %src256, <4 x i64> %src128_256, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
; AVX-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V512_01 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 8, i32 9, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:  Cost Model: Found an estimated cost of 18 for instruction: %V512_23 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:  Cost Model: Found an estimated cost of 18 for instruction: %V512_45 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
; AVX-NEXT:  Cost Model: Found an estimated cost of 18 for instruction: %V512_67 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
; AVX-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V512_0123 = shufflevector <8 x i64> %src512, <8 x i64> %src256_512, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:  Cost Model: Found an estimated cost of 18 for instruction: %V512_4567 = shufflevector <8 x i64> %src512, <8 x i64> %src256_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
; AVX-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; AVX512-LABEL: 'test_vXi64'
; AVX512-NEXT:  Cost Model: Unknown cost for instruction: %src128_256 = shufflevector <2 x i64> %src128, <2 x i64> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
; AVX512-NEXT:  Cost Model: Unknown cost for instruction: %src128_512 = shufflevector <2 x i64> %src128, <2 x i64> undef, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX512-NEXT:  Cost Model: Unknown cost for instruction: %src256_512 = shufflevector <4 x i64> %src256, <4 x i64> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V256_01 = shufflevector <4 x i64> %src256, <4 x i64> %src128_256, <4 x i32> <i32 4, i32 5, i32 2, i32 3>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V256_23 = shufflevector <4 x i64> %src256, <4 x i64> %src128_256, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V512_01 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 8, i32 9, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V512_23 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 4, i32 5, i32 6, i32 7>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V512_45 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V512_67 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %V512_0123 = shufflevector <8 x i64> %src512, <8 x i64> %src256_512, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V512_4567 = shufflevector <8 x i64> %src512, <8 x i64> %src256_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
; AVX512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %src128_256 = shufflevector <2 x i64> %src128, <2 x i64> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %src128_512 = shufflevector <2 x i64> %src128, <2 x i64> undef, <8 x i32> <i32 0, i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
  %src256_512 = shufflevector <4 x i64> %src256, <4 x i64> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>

  %V256_01 = shufflevector <4 x i64> %src256, <4 x i64> %src128_256, <4 x i32> <i32 4, i32 5, i32 2, i32 3>
  %V256_23 = shufflevector <4 x i64> %src256, <4 x i64> %src128_256, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
  %V512_01 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 8, i32 9, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %V512_23 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 4, i32 5, i32 6, i32 7>
  %V512_45 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
  %V512_67 = shufflevector <8 x i64> %src512, <8 x i64> %src128_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
  %V512_0123 = shufflevector <8 x i64> %src512, <8 x i64> %src256_512, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 4, i32 5, i32 6, i32 7>
  %V512_4567 = shufflevector <8 x i64> %src512, <8 x i64> %src256_512, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
  ret void
}
