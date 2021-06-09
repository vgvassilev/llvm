; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mergeicmps -verify-dom-info -mtriple=x86_64-unknown-unknown -S | FileCheck %s --check-prefix=X86

%S = type { i32, i32, i32, i32 }

declare void @foo(...)  nounwind readnone

; We can split %entry and create a memcmp(16 bytes).
define zeroext i1 @opeq1(
; X86-LABEL: @opeq1(
; X86-NEXT:  "entry+land.rhs.i+land.rhs.i.2+land.rhs.i.3":
; X86-NEXT:    call void (...) @foo()
; X86-NEXT:    [[TMP0:%.*]] = getelementptr inbounds [[S:%.*]], %S* [[A:%.*]], i64 0, i32 0
; X86-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[S]], %S* [[B:%.*]], i64 0, i32 0
; X86-NEXT:    [[CSTR:%.*]] = bitcast i32* [[TMP0]] to i8*
; X86-NEXT:    [[CSTR1:%.*]] = bitcast i32* [[TMP1]] to i8*
; X86-NEXT:    [[MEMCMP:%.*]] = call i32 @memcmp(i8* nocapture [[CSTR]], i8* nocapture [[CSTR1]], i64 16) #[[ATTR1:[0-9]+]]
; X86-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[MEMCMP]], 0
; X86-NEXT:    br label [[OPEQ1_EXIT:%.*]]
; X86:       opeq1.exit:
; X86-NEXT:    ret i1 [[TMP2]]
;
; Make sure this call is moved to the beginning of the entry block.
  %S* nocapture readonly dereferenceable(16) %a,
  %S* nocapture readonly dereferenceable(16) %b) local_unnamed_addr #0 {
entry:
  %first.i = getelementptr inbounds %S, %S* %a, i64 0, i32 0
  %0 = load i32, i32* %first.i, align 4
  %first1.i = getelementptr inbounds %S, %S* %b, i64 0, i32 0
  %1 = load i32, i32* %first1.i, align 4
  ; Does other work.
  call void (...) @foo()
  %cmp.i = icmp eq i32 %0, %1
  br i1 %cmp.i, label %land.rhs.i, label %opeq1.exit

land.rhs.i:
  %second.i = getelementptr inbounds %S, %S* %a, i64 0, i32 1
  %2 = load i32, i32* %second.i, align 4
  %second2.i = getelementptr inbounds %S, %S* %b, i64 0, i32 1
  %3 = load i32, i32* %second2.i, align 4
  %cmp2.i = icmp eq i32 %2, %3
  br i1 %cmp2.i, label %land.rhs.i.2, label %opeq1.exit

land.rhs.i.2:
  %third.i = getelementptr inbounds %S, %S* %a, i64 0, i32 2
  %4 = load i32, i32* %third.i, align 4
  %third2.i = getelementptr inbounds %S, %S* %b, i64 0, i32 2
  %5 = load i32, i32* %third2.i, align 4
  %cmp3.i = icmp eq i32 %4, %5
  br i1 %cmp3.i, label %land.rhs.i.3, label %opeq1.exit

land.rhs.i.3:
  %fourth.i = getelementptr inbounds %S, %S* %a, i64 0, i32 3
  %6 = load i32, i32* %fourth.i, align 4
  %fourth2.i = getelementptr inbounds %S, %S* %b, i64 0, i32 3
  %7 = load i32, i32* %fourth2.i, align 4
  %cmp4.i = icmp eq i32 %6, %7
  br label %opeq1.exit

opeq1.exit:
  %8 = phi i1 [ false, %entry ], [ false, %land.rhs.i] , [ false, %land.rhs.i.2 ], [ %cmp4.i, %land.rhs.i.3 ]
  ret i1 %8
}


; We will not be able to merge anything, make sure the call is not moved out.
define zeroext i1 @opeq1_discontiguous(
; X86-LABEL: @opeq1_discontiguous(
; X86-NEXT:  entry:
; X86-NEXT:    [[FIRST_I:%.*]] = getelementptr inbounds [[S:%.*]], %S* [[A:%.*]], i64 0, i32 1
; X86-NEXT:    [[TMP0:%.*]] = load i32, i32* [[FIRST_I]], align 4
; X86-NEXT:    [[FIRST1_I:%.*]] = getelementptr inbounds [[S]], %S* [[B:%.*]], i64 0, i32 0
; X86-NEXT:    [[TMP1:%.*]] = load i32, i32* [[FIRST1_I]], align 4
; X86-NEXT:    call void (...) @foo()
; X86-NEXT:    [[CMP_I:%.*]] = icmp eq i32 [[TMP0]], [[TMP1]]
; X86-NEXT:    br i1 [[CMP_I]], label [[LAND_RHS_I:%.*]], label [[OPEQ1_EXIT:%.*]]
; X86:       land.rhs.i:
; X86-NEXT:    [[SECOND_I:%.*]] = getelementptr inbounds [[S]], %S* [[A]], i64 0, i32 2
; X86-NEXT:    [[TMP2:%.*]] = load i32, i32* [[SECOND_I]], align 4
; X86-NEXT:    [[SECOND2_I:%.*]] = getelementptr inbounds [[S]], %S* [[B]], i64 0, i32 1
; X86-NEXT:    [[TMP3:%.*]] = load i32, i32* [[SECOND2_I]], align 4
; X86-NEXT:    [[CMP2_I:%.*]] = icmp eq i32 [[TMP2]], [[TMP3]]
; X86-NEXT:    br i1 [[CMP2_I]], label [[LAND_RHS_I_2:%.*]], label [[OPEQ1_EXIT]]
; X86:       land.rhs.i.2:
; X86-NEXT:    [[THIRD_I:%.*]] = getelementptr inbounds [[S]], %S* [[A]], i64 0, i32 2
; X86-NEXT:    [[TMP4:%.*]] = load i32, i32* [[THIRD_I]], align 4
; X86-NEXT:    [[THIRD2_I:%.*]] = getelementptr inbounds [[S]], %S* [[B]], i64 0, i32 3
; X86-NEXT:    [[TMP5:%.*]] = load i32, i32* [[THIRD2_I]], align 4
; X86-NEXT:    [[CMP3_I:%.*]] = icmp eq i32 [[TMP4]], [[TMP5]]
; X86-NEXT:    br i1 [[CMP3_I]], label [[LAND_RHS_I_3:%.*]], label [[OPEQ1_EXIT]]
; X86:       land.rhs.i.3:
; X86-NEXT:    [[FOURTH_I:%.*]] = getelementptr inbounds [[S]], %S* [[A]], i64 0, i32 1
; X86-NEXT:    [[TMP6:%.*]] = load i32, i32* [[FOURTH_I]], align 4
; X86-NEXT:    [[FOURTH2_I:%.*]] = getelementptr inbounds [[S]], %S* [[B]], i64 0, i32 3
; X86-NEXT:    [[TMP7:%.*]] = load i32, i32* [[FOURTH2_I]], align 4
; X86-NEXT:    [[CMP4_I:%.*]] = icmp eq i32 [[TMP6]], [[TMP7]]
; X86-NEXT:    br label [[OPEQ1_EXIT]]
; X86:       opeq1.exit:
; X86-NEXT:    [[TMP8:%.*]] = phi i1 [ false, [[ENTRY:%.*]] ], [ false, [[LAND_RHS_I]] ], [ false, [[LAND_RHS_I_2]] ], [ [[CMP4_I]], [[LAND_RHS_I_3]] ]
; X86-NEXT:    ret i1 [[TMP8]]
;
; Make sure this call is moved in the entry block.
  %S* nocapture readonly dereferenceable(16) %a,
  %S* nocapture readonly dereferenceable(16) %b) local_unnamed_addr #0 {
entry:
  %first.i = getelementptr inbounds %S, %S* %a, i64 0, i32 1
  %0 = load i32, i32* %first.i, align 4
  %first1.i = getelementptr inbounds %S, %S* %b, i64 0, i32 0
  %1 = load i32, i32* %first1.i, align 4
  ; Does other work.
  call void (...) @foo()
  %cmp.i = icmp eq i32 %0, %1
  br i1 %cmp.i, label %land.rhs.i, label %opeq1.exit

land.rhs.i:
  %second.i = getelementptr inbounds %S, %S* %a, i64 0, i32 2
  %2 = load i32, i32* %second.i, align 4
  %second2.i = getelementptr inbounds %S, %S* %b, i64 0, i32 1
  %3 = load i32, i32* %second2.i, align 4
  %cmp2.i = icmp eq i32 %2, %3
  br i1 %cmp2.i, label %land.rhs.i.2, label %opeq1.exit

land.rhs.i.2:
  %third.i = getelementptr inbounds %S, %S* %a, i64 0, i32 2
  %4 = load i32, i32* %third.i, align 4
  %third2.i = getelementptr inbounds %S, %S* %b, i64 0, i32 3
  %5 = load i32, i32* %third2.i, align 4
  %cmp3.i = icmp eq i32 %4, %5
  br i1 %cmp3.i, label %land.rhs.i.3, label %opeq1.exit

land.rhs.i.3:
  %fourth.i = getelementptr inbounds %S, %S* %a, i64 0, i32 1
  %6 = load i32, i32* %fourth.i, align 4
  %fourth2.i = getelementptr inbounds %S, %S* %b, i64 0, i32 3
  %7 = load i32, i32* %fourth2.i, align 4
  %cmp4.i = icmp eq i32 %6, %7
  br label %opeq1.exit

opeq1.exit:
  %8 = phi i1 [ false, %entry ], [ false, %land.rhs.i] , [ false, %land.rhs.i.2 ], [ %cmp4.i, %land.rhs.i.3 ]
  ret i1 %8
}
