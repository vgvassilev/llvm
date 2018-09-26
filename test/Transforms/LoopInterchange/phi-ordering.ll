; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -loop-interchange -verify-dom-info -verify-loop-info -verify-scev -verify-loop-lcssa -S 2>&1 | FileCheck %s
;; Checks the order of the inner phi nodes does not cause havoc.
;; The inner loop has a reduction into c. The IV is not the first phi.

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv8--linux-gnueabihf"



; Function Attrs: norecurse nounwind
define void @test(i32 %T, [90 x i32]* noalias nocapture %C, i16* noalias nocapture readonly %A, i16* noalias nocapture readonly %B) local_unnamed_addr #0 {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR3_PREHEADER:%.*]]
; CHECK:       for1.header.preheader:
; CHECK-NEXT:    br label [[FOR1_HEADER:%.*]]
; CHECK:       for1.header:
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[INC20:%.*]], [[FOR1_INC19:%.*]] ], [ 0, [[FOR1_HEADER_PREHEADER:%.*]] ]
; CHECK-NEXT:    [[MUL:%.*]] = mul nsw i32 [[I]], 90
; CHECK-NEXT:    br label [[FOR2_HEADER_PREHEADER:%.*]]
; CHECK:       for2.header.preheader:
; CHECK-NEXT:    br label [[FOR2_HEADER:%.*]]
; CHECK:       for2.header:
; CHECK-NEXT:    [[J:%.*]] = phi i32 [ [[INC17:%.*]], [[FOR2_INC16:%.*]] ], [ 0, [[FOR2_HEADER_PREHEADER]] ]
; CHECK-NEXT:    [[ARRAYIDX14:%.*]] = getelementptr inbounds [90 x i32], [90 x i32]* [[C:%.*]], i32 [[I]], i32 [[J]]
; CHECK-NEXT:    [[ARRAYIDX14_PROMOTED:%.*]] = load i32, i32* [[ARRAYIDX14]], align 4
; CHECK-NEXT:    br label [[FOR3_SPLIT1:%.*]]
; CHECK:       for3.preheader:
; CHECK-NEXT:    br label [[FOR3:%.*]]
; CHECK:       for3:
; CHECK-NEXT:    [[K:%.*]] = phi i32 [ [[INC:%.*]], [[FOR3_SPLIT:%.*]] ], [ 1, [[FOR3_PREHEADER]] ]
; CHECK-NEXT:    br label [[FOR1_HEADER_PREHEADER]]
; CHECK:       for3.split1:
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[K]], [[MUL]]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i16, i16* [[A:%.*]], i32 [[ADD]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i16, i16* [[ARRAYIDX]], align 2
; CHECK-NEXT:    [[CONV:%.*]] = sext i16 [[TMP0]] to i32
; CHECK-NEXT:    [[ADD15:%.*]] = add nsw i32 [[CONV]], [[ARRAYIDX14_PROMOTED]]
; CHECK-NEXT:    br label [[FOR2_INC16]]
; CHECK:       for3.split:
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[K]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], 90
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR1_LOOPEXIT:%.*]], label [[FOR3]]
; CHECK:       for2.inc16:
; CHECK-NEXT:    store i32 [[ADD15]], i32* [[ARRAYIDX14]], align 4
; CHECK-NEXT:    [[INC17]] = add nuw nsw i32 [[J]], 1
; CHECK-NEXT:    [[EXITCOND47:%.*]] = icmp eq i32 [[INC17]], 90
; CHECK-NEXT:    br i1 [[EXITCOND47]], label [[FOR1_INC19]], label [[FOR2_HEADER]]
; CHECK:       for1.inc19:
; CHECK-NEXT:    [[INC20]] = add nuw nsw i32 [[I]], 1
; CHECK-NEXT:    [[EXITCOND48:%.*]] = icmp eq i32 [[INC20]], 90
; CHECK-NEXT:    br i1 [[EXITCOND48]], label [[FOR3_SPLIT]], label [[FOR1_HEADER]]
; CHECK:       for1.loopexit:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for1.header

for1.header:                                  ; preds = %entry
  %i = phi i32 [ %inc20, %for1.inc19 ], [ 0, %entry ]
  %mul = mul nsw i32 %i, 90
  br label %for2.header

for2.header:                                  ; preds = %for2.inc16, %for1.header
  %j = phi i32 [ 0, %for1.header ], [ %inc17, %for2.inc16 ]
  %arrayidx14 = getelementptr inbounds [90 x i32], [90 x i32]* %C, i32 %i, i32 %j
  %arrayidx14.promoted = load i32, i32* %arrayidx14, align 4
  br label %for3

for3:                                        ; preds = %for3, %for2.header
  %add1541 = phi i32 [ %arrayidx14.promoted, %for2.header ], [ %add15, %for3 ]
  %k = phi i32 [ 1, %for2.header ], [ %inc, %for3 ]
  %add = add nsw i32 %k, %mul
  %arrayidx = getelementptr inbounds i16, i16* %A, i32 %add
  %0 = load i16, i16* %arrayidx, align 2
  %conv = sext i16 %0 to i32
  %add15 = add nsw i32 %conv, %add1541
  %inc = add nuw nsw i32 %k, 1
  %exitcond = icmp eq i32 %inc, 90
  br i1 %exitcond, label %for2.inc16, label %for3

for2.inc16:                                        ; preds = %for.body6
  %add15.lcssa = phi i32 [ %add15, %for3 ]
  store i32 %add15.lcssa, i32* %arrayidx14, align 4
  %inc17 = add nuw nsw i32 %j, 1
  %exitcond47 = icmp eq i32 %inc17, 90
  br i1 %exitcond47, label %for1.inc19, label %for2.header

for1.inc19:                                        ; preds = %for2.inc16
  %inc20 = add nuw nsw i32 %i, 1
  %exitcond48 = icmp eq i32 %inc20, 90
  br i1 %exitcond48, label %for1.loopexit, label %for1.header

for1.loopexit:                               ; preds = %for1.inc19
  br label %exit

exit:                                        ; preds = %for1.loopexit
  ret void
}
