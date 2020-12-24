; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -S -mtriple=thumb7 -mcpu=swift | FileCheck %s

define <4 x i32> @PR13837(<4 x float> %in) {
; CHECK-LABEL: @PR13837(
; CHECK-NEXT:    [[TMP1:%.*]] = fptosi <4 x float> [[IN:%.*]] to <4 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <4 x i32> [[TMP1]], i32 0
; CHECK-NEXT:    [[V0:%.*]] = insertelement <4 x i32> poison, i32 [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x i32> [[TMP1]], i32 1
; CHECK-NEXT:    [[V1:%.*]] = insertelement <4 x i32> [[V0]], i32 [[TMP3]], i32 1
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <4 x i32> [[TMP1]], i32 2
; CHECK-NEXT:    [[V2:%.*]] = insertelement <4 x i32> [[V1]], i32 [[TMP4]], i32 2
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <4 x i32> [[TMP1]], i32 3
; CHECK-NEXT:    [[V3:%.*]] = insertelement <4 x i32> [[V2]], i32 [[TMP5]], i32 3
; CHECK-NEXT:    ret <4 x i32> [[V3]]
;
  %t0 = extractelement <4 x float> %in, i64 0
  %t1 = extractelement <4 x float> %in, i64 1
  %t2 = extractelement <4 x float> %in, i64 2
  %t3 = extractelement <4 x float> %in, i64 3
  %c0 = fptosi float %t0 to i32
  %c1 = fptosi float %t1 to i32
  %c2 = fptosi float %t2 to i32
  %c3 = fptosi float %t3 to i32
  %v0 = insertelement <4 x i32> poison, i32 %c0, i32 0
  %v1 = insertelement <4 x i32> %v0, i32 %c1, i32 1
  %v2 = insertelement <4 x i32> %v1, i32 %c2, i32 2
  %v3 = insertelement <4 x i32> %v2, i32 %c3, i32 3
  ret <4 x i32> %v3
}

