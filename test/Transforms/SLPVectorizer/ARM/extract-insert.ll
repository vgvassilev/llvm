; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -S -mtriple=thumb7 -mcpu=swift | FileCheck %s

define <4 x i32> @PR13837(<4 x float> %in) {
; CHECK-LABEL: @PR13837(
; CHECK-NEXT:    [[TMP1:%.*]] = fptosi <4 x float> [[IN:%.*]] to <4 x i32>
; CHECK-NEXT:    ret <4 x i32> [[TMP1]]
;
  %t0 = extractelement <4 x float> %in, i64 0
  %t1 = extractelement <4 x float> %in, i64 1
  %t2 = extractelement <4 x float> %in, i64 2
  %t3 = extractelement <4 x float> %in, i64 3
  %c0 = fptosi float %t0 to i32
  %c1 = fptosi float %t1 to i32
  %c2 = fptosi float %t2 to i32
  %c3 = fptosi float %t3 to i32
  %v0 = insertelement <4 x i32> undef, i32 %c0, i32 0
  %v1 = insertelement <4 x i32> %v0, i32 %c1, i32 1
  %v2 = insertelement <4 x i32> %v1, i32 %c2, i32 2
  %v3 = insertelement <4 x i32> %v2, i32 %c3, i32 3
  ret <4 x i32> %v3
}

