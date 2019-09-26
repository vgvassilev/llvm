; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -slp-vectorizer -slp-vectorize-hor -slp-vectorize-hor-store -S < %s -mtriple=x86_64-unknown-linux-gnu | FileCheck %s
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128-ni:1"

define void @mainTest(i32* %ptr) #0  {
; CHECK-LABEL: @mainTest(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32* [[PTR:%.*]], null
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP:%.*]], label [[BAIL_OUT:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[DUMMY_PHI:%.*]] = phi i32 [ 1, [[ENTRY:%.*]] ], [ [[OP_EXTRA5:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i32, i32* [[PTR]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, i32* [[PTR]], i64 2
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, i32* [[PTR]], i64 3
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast i32* [[PTR]] to <4 x i32>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <4 x i32>, <4 x i32>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <4 x i32> [[TMP4]], i32 3
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <4 x i32> [[TMP4]], i32 2
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <4 x i32> [[TMP4]], i32 1
; CHECK-NEXT:    [[TMP8:%.*]] = mul <4 x i32> [[TMP4]], [[TMP4]]
; CHECK-NEXT:    [[TMP9:%.*]] = add i32 1, undef
; CHECK-NEXT:    [[TMP10:%.*]] = add i32 [[TMP9]], [[TMP7]]
; CHECK-NEXT:    [[TMP11:%.*]] = add i32 [[TMP10]], undef
; CHECK-NEXT:    [[TMP12:%.*]] = add i32 [[TMP11]], [[TMP6]]
; CHECK-NEXT:    [[TMP13:%.*]] = add i32 [[TMP12]], undef
; CHECK-NEXT:    [[TMP14:%.*]] = sext i32 [[TMP6]] to i64
; CHECK-NEXT:    [[TMP15:%.*]] = add i32 [[TMP13]], [[TMP5]]
; CHECK-NEXT:    [[RDX_SHUF:%.*]] = shufflevector <4 x i32> [[TMP8]], <4 x i32> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <4 x i32> [[TMP8]], [[RDX_SHUF]]
; CHECK-NEXT:    [[RDX_SHUF1:%.*]] = shufflevector <4 x i32> [[BIN_RDX]], <4 x i32> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[BIN_RDX2:%.*]] = add <4 x i32> [[BIN_RDX]], [[RDX_SHUF1]]
; CHECK-NEXT:    [[TMP16:%.*]] = extractelement <4 x i32> [[BIN_RDX2]], i32 0
; CHECK-NEXT:    [[OP_EXTRA:%.*]] = add i32 [[TMP16]], 1
; CHECK-NEXT:    [[OP_EXTRA3:%.*]] = add i32 [[OP_EXTRA]], [[TMP7]]
; CHECK-NEXT:    [[OP_EXTRA4:%.*]] = add i32 [[OP_EXTRA3]], [[TMP6]]
; CHECK-NEXT:    [[OP_EXTRA5]] = add i32 [[OP_EXTRA4]], [[TMP5]]
; CHECK-NEXT:    [[TMP17:%.*]] = add i32 [[TMP15]], undef
; CHECK-NEXT:    br label [[LOOP]]
; CHECK:       bail_out:
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp eq i32* %ptr, null
  br i1 %cmp, label %loop, label %bail_out

loop:
  %dummy_phi = phi i32 [ 1, %entry ], [ %18, %loop ]
  %0 = load i32, i32 * %ptr , align 4
  %1 = mul i32 %0, %0
  %2 = add i32 1, %1
  %3 = getelementptr inbounds i32, i32 * %ptr, i64 1
  %4 = load i32, i32 * %3 , align 4
  %5 = mul i32 %4, %4
  %6 = add i32 %2, %4
  %7 = add i32 %6, %5
  %8 = getelementptr inbounds i32, i32 *%ptr, i64 2
  %9 = load i32, i32 * %8 , align 4
  %10 = mul i32 %9, %9
  %11 = add i32 %7, %9
  %12 = add i32 %11, %10
  %13 = sext i32 %9 to i64
  %14 = getelementptr inbounds i32, i32 *%ptr, i64 3
  %15 = load i32, i32 * %14 , align 4
  %16 = mul i32 %15, %15
  %17 = add i32 %12, %15
  %18 = add i32 %17, %16
  br label %loop

bail_out:
  ret void
}

attributes #0 = { "target-cpu"="westmere" }

