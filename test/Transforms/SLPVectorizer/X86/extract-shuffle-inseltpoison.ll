; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -S -o - -mtriple=x86_64-unknown-linux -mcpu=bdver2 -slp-schedule-budget=1 | FileCheck %s

define <2 x i8> @g(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @g(
; CHECK-NEXT:    [[X0:%.*]] = extractelement <2 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    [[Y1:%.*]] = extractelement <2 x i8> [[Y:%.*]], i32 1
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x i8> poison, i8 [[X0]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <2 x i8> [[TMP1]], i8 [[Y1]], i32 1
; CHECK-NEXT:    [[TMP3:%.*]] = mul <2 x i8> [[TMP2]], [[TMP2]]
; CHECK-NEXT:    ret <2 x i8> [[TMP3]]
;
  %x0 = extractelement <2 x i8> %x, i32 0
  %y1 = extractelement <2 x i8> %y, i32 1
  %x0x0 = mul i8 %x0, %x0
  %y1y1 = mul i8 %y1, %y1
  %ins1 = insertelement <2 x i8> poison, i8 %x0x0, i32 0
  %ins2 = insertelement <2 x i8> %ins1, i8 %y1y1, i32 1
  ret <2 x i8> %ins2
}

