; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -codegenprepare -mcpu=corei7 %s | FileCheck %s --check-prefixes=CHECK,CHECK-SSE2
; RUN: opt -S -codegenprepare -mcpu=bdver2 %s | FileCheck %s --check-prefixes=CHECK,CHECK-XOP
; RUN: opt -S -codegenprepare -mcpu=core-avx2 %s | FileCheck %s --check-prefixes=CHECK,CHECK-AVX,CHECK-AVX2
; RUN: opt -S -codegenprepare -mcpu=skylake-avx512 %s | FileCheck %s --check-prefixes=CHECK,CHECK-AVX,CHECK-AVX512BW

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-apple-darwin10.9.0"

define <16 x i8> @test_8bit(<16 x i8> %lhs, <16 x i8> %tmp, i1 %tst) {
; CHECK-LABEL: @test_8bit(
; CHECK-NEXT:    [[MASK:%.*]] = shufflevector <16 x i8> [[TMP:%.*]], <16 x i8> undef, <16 x i32> zeroinitializer
; CHECK-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK:       if_true:
; CHECK-NEXT:    ret <16 x i8> [[MASK]]
; CHECK:       if_false:
; CHECK-NEXT:    [[RES:%.*]] = shl <16 x i8> [[LHS:%.*]], [[MASK]]
; CHECK-NEXT:    ret <16 x i8> [[RES]]
;
  %mask = shufflevector <16 x i8> %tmp, <16 x i8> undef, <16 x i32> zeroinitializer
  br i1 %tst, label %if_true, label %if_false

if_true:
  ret <16 x i8> %mask

if_false:
  %res = shl <16 x i8> %lhs, %mask
  ret <16 x i8> %res
}

define <8 x i16> @test_16bit(<8 x i16> %lhs, <8 x i16> %tmp, i1 %tst) {
; CHECK-SSE2-LABEL: @test_16bit(
; CHECK-SSE2-NEXT:    [[MASK:%.*]] = shufflevector <8 x i16> [[TMP:%.*]], <8 x i16> undef, <8 x i32> zeroinitializer
; CHECK-SSE2-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK-SSE2:       if_true:
; CHECK-SSE2-NEXT:    ret <8 x i16> [[MASK]]
; CHECK-SSE2:       if_false:
; CHECK-SSE2-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i16> [[TMP]], <8 x i16> undef, <8 x i32> zeroinitializer
; CHECK-SSE2-NEXT:    [[RES:%.*]] = shl <8 x i16> [[LHS:%.*]], [[TMP1]]
; CHECK-SSE2-NEXT:    ret <8 x i16> [[RES]]
;
; CHECK-XOP-LABEL: @test_16bit(
; CHECK-XOP-NEXT:    [[MASK:%.*]] = shufflevector <8 x i16> [[TMP:%.*]], <8 x i16> undef, <8 x i32> zeroinitializer
; CHECK-XOP-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK-XOP:       if_true:
; CHECK-XOP-NEXT:    ret <8 x i16> [[MASK]]
; CHECK-XOP:       if_false:
; CHECK-XOP-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i16> [[TMP]], <8 x i16> undef, <8 x i32> zeroinitializer
; CHECK-XOP-NEXT:    [[RES:%.*]] = shl <8 x i16> [[LHS:%.*]], [[TMP1]]
; CHECK-XOP-NEXT:    ret <8 x i16> [[RES]]
;
; CHECK-AVX2-LABEL: @test_16bit(
; CHECK-AVX2-NEXT:    [[MASK:%.*]] = shufflevector <8 x i16> [[TMP:%.*]], <8 x i16> undef, <8 x i32> zeroinitializer
; CHECK-AVX2-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK-AVX2:       if_true:
; CHECK-AVX2-NEXT:    ret <8 x i16> [[MASK]]
; CHECK-AVX2:       if_false:
; CHECK-AVX2-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i16> [[TMP]], <8 x i16> undef, <8 x i32> zeroinitializer
; CHECK-AVX2-NEXT:    [[RES:%.*]] = shl <8 x i16> [[LHS:%.*]], [[TMP1]]
; CHECK-AVX2-NEXT:    ret <8 x i16> [[RES]]
;
; CHECK-AVX512BW-LABEL: @test_16bit(
; CHECK-AVX512BW-NEXT:    [[MASK:%.*]] = shufflevector <8 x i16> [[TMP:%.*]], <8 x i16> undef, <8 x i32> zeroinitializer
; CHECK-AVX512BW-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK-AVX512BW:       if_true:
; CHECK-AVX512BW-NEXT:    ret <8 x i16> [[MASK]]
; CHECK-AVX512BW:       if_false:
; CHECK-AVX512BW-NEXT:    [[RES:%.*]] = shl <8 x i16> [[LHS:%.*]], [[MASK]]
; CHECK-AVX512BW-NEXT:    ret <8 x i16> [[RES]]
;
  %mask = shufflevector <8 x i16> %tmp, <8 x i16> undef, <8 x i32> zeroinitializer
  br i1 %tst, label %if_true, label %if_false

if_true:
  ret <8 x i16> %mask

if_false:
  %res = shl <8 x i16> %lhs, %mask
  ret <8 x i16> %res
}

define <4 x i32> @test_notsplat(<4 x i32> %lhs, <4 x i32> %tmp, i1 %tst) {
; CHECK-LABEL: @test_notsplat(
; CHECK-NEXT:    [[MASK:%.*]] = shufflevector <4 x i32> [[TMP:%.*]], <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 1, i32 0>
; CHECK-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK:       if_true:
; CHECK-NEXT:    ret <4 x i32> [[MASK]]
; CHECK:       if_false:
; CHECK-NEXT:    [[RES:%.*]] = shl <4 x i32> [[LHS:%.*]], [[MASK]]
; CHECK-NEXT:    ret <4 x i32> [[RES]]
;
  %mask = shufflevector <4 x i32> %tmp, <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 1, i32 0>
  br i1 %tst, label %if_true, label %if_false

if_true:
  ret <4 x i32> %mask

if_false:
  %res = shl <4 x i32> %lhs, %mask
  ret <4 x i32> %res
}

define <4 x i32> @test_32bit(<4 x i32> %lhs, <4 x i32> %tmp, i1 %tst) {
; CHECK-SSE2-LABEL: @test_32bit(
; CHECK-SSE2-NEXT:    [[MASK:%.*]] = shufflevector <4 x i32> [[TMP:%.*]], <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 0, i32 0>
; CHECK-SSE2-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK-SSE2:       if_true:
; CHECK-SSE2-NEXT:    ret <4 x i32> [[MASK]]
; CHECK-SSE2:       if_false:
; CHECK-SSE2-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i32> [[TMP]], <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 0, i32 0>
; CHECK-SSE2-NEXT:    [[RES:%.*]] = ashr <4 x i32> [[LHS:%.*]], [[TMP1]]
; CHECK-SSE2-NEXT:    ret <4 x i32> [[RES]]
;
; CHECK-XOP-LABEL: @test_32bit(
; CHECK-XOP-NEXT:    [[MASK:%.*]] = shufflevector <4 x i32> [[TMP:%.*]], <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 0, i32 0>
; CHECK-XOP-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK-XOP:       if_true:
; CHECK-XOP-NEXT:    ret <4 x i32> [[MASK]]
; CHECK-XOP:       if_false:
; CHECK-XOP-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i32> [[TMP]], <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 0, i32 0>
; CHECK-XOP-NEXT:    [[RES:%.*]] = ashr <4 x i32> [[LHS:%.*]], [[TMP1]]
; CHECK-XOP-NEXT:    ret <4 x i32> [[RES]]
;
; CHECK-AVX-LABEL: @test_32bit(
; CHECK-AVX-NEXT:    [[MASK:%.*]] = shufflevector <4 x i32> [[TMP:%.*]], <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 0, i32 0>
; CHECK-AVX-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK-AVX:       if_true:
; CHECK-AVX-NEXT:    ret <4 x i32> [[MASK]]
; CHECK-AVX:       if_false:
; CHECK-AVX-NEXT:    [[RES:%.*]] = ashr <4 x i32> [[LHS:%.*]], [[MASK]]
; CHECK-AVX-NEXT:    ret <4 x i32> [[RES]]
;
  %mask = shufflevector <4 x i32> %tmp, <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 0, i32 0>
  br i1 %tst, label %if_true, label %if_false

if_true:
  ret <4 x i32> %mask

if_false:
  %res = ashr <4 x i32> %lhs, %mask
  ret <4 x i32> %res
}

define <2 x i64> @test_64bit(<2 x i64> %lhs, <2 x i64> %tmp, i1 %tst) {
; CHECK-SSE2-LABEL: @test_64bit(
; CHECK-SSE2-NEXT:    [[MASK:%.*]] = shufflevector <2 x i64> [[TMP:%.*]], <2 x i64> undef, <2 x i32> zeroinitializer
; CHECK-SSE2-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK-SSE2:       if_true:
; CHECK-SSE2-NEXT:    ret <2 x i64> [[MASK]]
; CHECK-SSE2:       if_false:
; CHECK-SSE2-NEXT:    [[TMP1:%.*]] = shufflevector <2 x i64> [[TMP]], <2 x i64> undef, <2 x i32> zeroinitializer
; CHECK-SSE2-NEXT:    [[RES:%.*]] = lshr <2 x i64> [[LHS:%.*]], [[TMP1]]
; CHECK-SSE2-NEXT:    ret <2 x i64> [[RES]]
;
; CHECK-XOP-LABEL: @test_64bit(
; CHECK-XOP-NEXT:    [[MASK:%.*]] = shufflevector <2 x i64> [[TMP:%.*]], <2 x i64> undef, <2 x i32> zeroinitializer
; CHECK-XOP-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK-XOP:       if_true:
; CHECK-XOP-NEXT:    ret <2 x i64> [[MASK]]
; CHECK-XOP:       if_false:
; CHECK-XOP-NEXT:    [[TMP1:%.*]] = shufflevector <2 x i64> [[TMP]], <2 x i64> undef, <2 x i32> zeroinitializer
; CHECK-XOP-NEXT:    [[RES:%.*]] = lshr <2 x i64> [[LHS:%.*]], [[TMP1]]
; CHECK-XOP-NEXT:    ret <2 x i64> [[RES]]
;
; CHECK-AVX-LABEL: @test_64bit(
; CHECK-AVX-NEXT:    [[MASK:%.*]] = shufflevector <2 x i64> [[TMP:%.*]], <2 x i64> undef, <2 x i32> zeroinitializer
; CHECK-AVX-NEXT:    br i1 [[TST:%.*]], label [[IF_TRUE:%.*]], label [[IF_FALSE:%.*]]
; CHECK-AVX:       if_true:
; CHECK-AVX-NEXT:    ret <2 x i64> [[MASK]]
; CHECK-AVX:       if_false:
; CHECK-AVX-NEXT:    [[RES:%.*]] = lshr <2 x i64> [[LHS:%.*]], [[MASK]]
; CHECK-AVX-NEXT:    ret <2 x i64> [[RES]]
;
  %mask = shufflevector <2 x i64> %tmp, <2 x i64> undef, <2 x i32> zeroinitializer
  br i1 %tst, label %if_true, label %if_false

if_true:
  ret <2 x i64> %mask

if_false:
  %res = lshr <2 x i64> %lhs, %mask
  ret <2 x i64> %res
}
