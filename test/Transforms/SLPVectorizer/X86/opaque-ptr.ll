; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -slp-vectorizer -mtriple=x86_64-apple-macosx -mcpu=haswell < %s | FileCheck %s

define void @test(ptr %r, ptr %p, ptr %q) #0 {
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[P0:%.*]] = getelementptr inbounds i64, ptr [[P:%.*]], i64 0
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds i64, ptr [[P]], i64 1
; CHECK-NEXT:    [[P2:%.*]] = getelementptr inbounds i64, ptr [[P]], i64 2
; CHECK-NEXT:    [[P3:%.*]] = getelementptr inbounds i64, ptr [[P]], i64 3
; CHECK-NEXT:    [[Q0:%.*]] = getelementptr inbounds i64, ptr [[Q:%.*]], i64 0
; CHECK-NEXT:    [[Q1:%.*]] = getelementptr inbounds i64, ptr [[Q]], i64 1
; CHECK-NEXT:    [[Q2:%.*]] = getelementptr inbounds i64, ptr [[Q]], i64 2
; CHECK-NEXT:    [[Q3:%.*]] = getelementptr inbounds i64, ptr [[Q]], i64 3
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast ptr [[P0]] to <4 x i64>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x i64>, <4 x i64>* [[TMP1]], align 2
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast ptr [[Q0]] to <4 x i64>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <4 x i64>, <4 x i64>* [[TMP3]], align 2
; CHECK-NEXT:    [[TMP5:%.*]] = sub nsw <4 x i64> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <4 x i64> [[TMP5]], i32 0
; CHECK-NEXT:    [[G0:%.*]] = getelementptr inbounds i32, ptr [[R:%.*]], i64 [[TMP6]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <4 x i64> [[TMP5]], i32 1
; CHECK-NEXT:    [[G1:%.*]] = getelementptr inbounds i32, ptr [[R]], i64 [[TMP7]]
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <4 x i64> [[TMP5]], i32 2
; CHECK-NEXT:    [[G2:%.*]] = getelementptr inbounds i32, ptr [[R]], i64 [[TMP8]]
; CHECK-NEXT:    [[TMP9:%.*]] = extractelement <4 x i64> [[TMP5]], i32 3
; CHECK-NEXT:    [[G3:%.*]] = getelementptr inbounds i32, ptr [[R]], i64 [[TMP9]]
; CHECK-NEXT:    ret void
;
  %p0 = getelementptr inbounds i64, ptr %p, i64 0
  %p1 = getelementptr inbounds i64, ptr %p, i64 1
  %p2 = getelementptr inbounds i64, ptr %p, i64 2
  %p3 = getelementptr inbounds i64, ptr %p, i64 3

  %q0 = getelementptr inbounds i64, ptr %q, i64 0
  %q1 = getelementptr inbounds i64, ptr %q, i64 1
  %q2 = getelementptr inbounds i64, ptr %q, i64 2
  %q3 = getelementptr inbounds i64, ptr %q, i64 3

  %x0 = load i64, ptr %p0, align 2
  %x1 = load i64, ptr %p1, align 2
  %x2 = load i64, ptr %p2, align 2
  %x3 = load i64, ptr %p3, align 2

  %y0 = load i64, ptr %q0, align 2
  %y1 = load i64, ptr %q1, align 2
  %y2 = load i64, ptr %q2, align 2
  %y3 = load i64, ptr %q3, align 2

  %sub0 = sub nsw i64 %x0, %y0
  %sub1 = sub nsw i64 %x1, %y1
  %sub2 = sub nsw i64 %x2, %y2
  %sub3 = sub nsw i64 %x3, %y3

  %g0 = getelementptr inbounds i32, ptr %r, i64 %sub0
  %g1 = getelementptr inbounds i32, ptr %r, i64 %sub1
  %g2 = getelementptr inbounds i32, ptr %r, i64 %sub2
  %g3 = getelementptr inbounds i32, ptr %r, i64 %sub3
  ret void
}
