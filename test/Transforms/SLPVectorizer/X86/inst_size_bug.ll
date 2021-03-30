; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -S -mtriple=x86_64-unknown-linux-gnu -mattr=+avx2 -slp-max-reg-size=128 | FileCheck %s

define void @inst_size(i64* %a, <2 x i64> %b) {
; CHECK-LABEL: @inst_size(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[VAL:%.*]] = extractelement <2 x i64> [[B:%.*]], i32 0
; CHECK-NEXT:    [[PTR2:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 1
; CHECK-NEXT:    [[PTR3:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 2
; CHECK-NEXT:    [[PTR4:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 3
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i64* [[A]] to <4 x i64>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i64>, <4 x i64>* [[TMP0]], align 4
; CHECK-NEXT:    [[T41:%.*]] = icmp sgt i64 0, [[VAL]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt <4 x i64> zeroinitializer, [[TMP1]]
; CHECK-NEXT:    br label [[BLOCK:%.*]]
; CHECK:       block:
; CHECK-NEXT:    [[PHI1:%.*]] = phi i1 [ [[T41]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = phi <4 x i1> [ [[TMP2]], [[ENTRY]] ]
; CHECK-NEXT:    ret void
;
entry:
  %val = extractelement <2 x i64> %b, i32 0
  %tmpl1 = load i64, i64* %a, align 4
  %ptr2 = getelementptr inbounds i64, i64* %a, i64 1
  %tmpl2 = load i64, i64* %ptr2, align 4
  %ptr3 = getelementptr inbounds i64, i64* %a, i64 2
  %tmpl3 = load i64, i64* %ptr3, align 4
  %ptr4 = getelementptr inbounds i64, i64* %a, i64 3
  %tmpl4 = load i64, i64* %ptr4, align 4
  %t41 = icmp sgt i64 0, %val
  %t42 = icmp sgt i64 0, %tmpl1
  %t43 = icmp sgt i64 0, %tmpl2
  %t44 = icmp sgt i64 0, %tmpl3
  %t45 = icmp sgt i64 0, %tmpl4
  br label %block
block:
  %phi1 = phi i1 [ %t41, %entry]
  %phi2 = phi i1 [ %t42, %entry]
  %phi3 = phi i1 [ %t43, %entry]
  %phi4 = phi i1 [ %t44, %entry]
  %phi5 = phi i1 [ %t45, %entry]
  ret void
}
