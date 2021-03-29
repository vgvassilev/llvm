; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='loop-mssa(unswitch<nontrivial>),verify<loops>' -S < %s | FileCheck %s

declare void @clobber()

define i32 @partial_unswitch_true_successor(i32* %ptr, i32 %N) {
; CHECK-LABEL: @partial_unswitch_true_successor(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load i32, i32* %ptr
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

define i32 @partial_unswitch_false_successor(i32* %ptr, i32 %N) {
; CHECK-LABEL: @partial_unswitch_false_successor(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[CLOBBER:%.*]], label [[NOCLOBBER:%.*]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load i32, i32* %ptr
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %clobber, label %noclobber

clobber:
  call void @clobber()
  br label %loop.latch

noclobber:
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

define i32 @partial_unswtich_gep_load_icmp(i32** %ptr, i32 %N) {
; CHECK-LABEL: @partial_unswtich_gep_load_icmp(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i32*, i32** [[PTR:%.*]], i32 1
; CHECK-NEXT:    [[LV_1:%.*]] = load i32*, i32** [[GEP]], align 8
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[LV_1]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %gep = getelementptr i32*, i32** %ptr, i32 1
  %lv.1 = load i32*, i32** %gep
  %lv = load i32, i32* %lv.1
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

define i32 @partial_unswitch_reduction_phi(i32* %ptr, i32 %N) {
; CHECK-LABEL: @partial_unswitch_reduction_phi(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[RED:%.*]] = phi i32 [ 20, [[ENTRY]] ], [ [[RED_NEXT:%.*]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[CLOBBER:%.*]], label [[NOCLOBBER:%.*]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    [[ADD_5:%.*]] = add i32 [[RED]], 5
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       noclobber:
; CHECK-NEXT:    [[ADD_10:%.*]] = add i32 [[RED]], 10
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[RED_NEXT]] = phi i32 [ [[ADD_5]], [[CLOBBER]] ], [ [[ADD_10]], [[NOCLOBBER]] ]
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[RED_NEXT_LCSSA:%.*]] = phi i32 [ [[RED_NEXT]], [[LOOP_LATCH]] ]
; CHECK-NEXT:    ret i32 [[RED_NEXT_LCSSA]]
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %red = phi i32 [ 20, %entry ], [ %red.next, %loop.latch ]
  %lv = load i32, i32* %ptr
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %clobber, label %noclobber

clobber:
  call void @clobber()
  %add.5 = add i32 %red, 5
  br label %loop.latch

noclobber:
  %add.10 = add i32 %red, 10
  br label %loop.latch

loop.latch:
  %red.next = phi i32 [ %add.5, %clobber ], [ %add.10, %noclobber ]
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  %red.next.lcssa = phi i32 [ %red.next, %loop.latch ]
  ret i32 %red.next.lcssa
}

; Partial unswitching is possible, because the store in %noclobber does not
; alias the load of the condition.
define i32 @partial_unswitch_true_successor_noclobber(i32* noalias %ptr.1, i32* noalias %ptr.2, i32 %N) {
; CHECK-LABEL: @partial_unswitch_true_successor_noclobber(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR_1:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    [[GEP_1:%.*]] = getelementptr i32, i32* [[PTR_2:%.*]], i32 [[IV]]
; CHECK-NEXT:    store i32 [[LV]], i32* [[GEP_1]], align 4
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load i32, i32* %ptr.1
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  %gep.1 = getelementptr i32, i32* %ptr.2, i32 %iv
  store i32 %lv, i32* %gep.1
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

define void @no_partial_unswitch_phi_cond(i1 %lc, i32 %N) {
; CHECK-LABEL: @no_partial_unswitch_phi_cond(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[SC:%.*]] = phi i1 [ [[LC:%.*]], [[ENTRY]] ], [ true, [[LOOP_LATCH]] ]
; CHECK-NEXT:    br i1 [[SC]], label [[CLOBBER:%.*]], label [[NOCLOBBER:%.*]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %sc = phi i1 [ %lc, %entry ], [ true, %loop.latch ]
  br i1 %sc, label %clobber, label %noclobber

clobber:
  call void @clobber()
  br label %loop.latch

noclobber:
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret void
}

define void @no_partial_unswitch_clobber_latch(i32* %ptr, i32 %N) {
; CHECK-LABEL: @no_partial_unswitch_clobber_latch(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load i32, i32* %ptr
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  call void @clobber()
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret void
}

define void @no_partial_unswitch_clobber_header(i32* %ptr, i32 %N) {
; CHECK-LABEL: @no_partial_unswitch_clobber_header(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  call void @clobber()
  %lv = load i32, i32* %ptr
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret void
}

define void @no_partial_unswitch_clobber_both(i32* %ptr, i32 %N) {
; CHECK-LABEL: @no_partial_unswitch_clobber_both(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load i32, i32* %ptr
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  call void @clobber()
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret void
}

define i32 @no_partial_unswitch_true_successor_storeclobber(i32* %ptr.1, i32* %ptr.2, i32 %N) {
; CHECK-LABEL: @no_partial_unswitch_true_successor_storeclobber(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR_1:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    [[GEP_1:%.*]] = getelementptr i32, i32* [[PTR_2:%.*]], i32 [[IV]]
; CHECK-NEXT:    store i32 [[LV]], i32* [[GEP_1]], align 4
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load i32, i32* %ptr.1
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  %gep.1 = getelementptr i32, i32* %ptr.2, i32 %iv
  store i32 %lv, i32* %gep.1
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

; Make sure the duplicated instructions are moved to a preheader that always
; executes when the loop body also executes. Do not check the unswitched code,
; because it is already checked in the @partial_unswitch_true_successor test
; case.
define i32 @partial_unswitch_true_successor_preheader_insertion(i32* %ptr, i32 %N) {
; CHECK-LABEL: @partial_unswitch_true_successor_preheader_insertion(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[EC:%.*]] = icmp ne i32* [[PTR:%.*]], null
; CHECK-NEXT:    br i1 [[EC]], label [[LOOP_PH:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.ph:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[LOOP_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT_LOOPEXIT:%.*]]
; CHECK:       exit.loopexit:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;

entry:
  %ec = icmp ne i32* %ptr, null
  br i1 %ec, label %loop.ph, label %exit

loop.ph:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %loop.ph ], [ %iv.next, %loop.latch ]
  %lv = load i32, i32* %ptr
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

; Make sure the duplicated instructions are hoisted just before the branch of
; the preheader. Do not check the unswitched code, because it is already checked
; in the @partial_unswitch_true_successor test case
define i32 @partial_unswitch_true_successor_insert_point(i32* %ptr, i32 %N) {
; CHECK-LABEL: @partial_unswitch_true_successor_insert_point(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  call void @clobber()
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load i32, i32* %ptr
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

; Make sure invariant instructions in the loop are also hoisted to the preheader.
; Do not check the unswitched code, because it is already checked in the
; @partial_unswitch_true_successor test case
define i32 @partial_unswitch_true_successor_hoist_invariant(i32* %ptr, i32 %N) {
; CHECK-LABEL: @partial_unswitch_true_successor_hoist_invariant(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i32, i32* [[PTR:%.*]], i64 1
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[GEP]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %gep = getelementptr i32, i32* %ptr, i64 1
  %lv = load i32, i32* %gep
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

; Do not unswitch if the condition depends on an atomic load. Duplicating such
; loads is not safe.
define i32 @no_partial_unswitch_atomic_load_unordered(i32* %ptr, i32 %N) {
; CHECK-LABEL: @no_partial_unswitch_atomic_load_unordered(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load atomic i32, i32* [[PTR:%.*]] unordered, align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load atomic i32, i32* %ptr unordered, align 4
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

; Do not unswitch if the condition depends on an atomic load. Duplicating such
; loads is not safe.
define i32 @no_partial_unswitch_atomic_load_monotonic(i32* %ptr, i32 %N) {
; CHECK-LABEL: @no_partial_unswitch_atomic_load_monotonic(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load atomic i32, i32* [[PTR:%.*]] monotonic, align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load atomic i32, i32* %ptr monotonic, align 4
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}


declare i32 @get_value()

; Do not unswitch if the condition depends on a call, that may clobber memory.
; Duplicating such a call is not safe.
define i32 @no_partial_unswitch_cond_call(i32* %ptr, i32 %N) {
; CHECK-LABEL: @no_partial_unswitch_cond_call(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = call i32 @get_value()
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[CLOBBER:%.*]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = call i32 @get_value()
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %clobber

noclobber:
  br label %loop.latch

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

define i32 @no_partial_unswitch_true_successor_exit(i32* %ptr, i32 %N) {
; CHECK-LABEL: @no_partial_unswitch_true_successor_exit(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[EXIT:%.*]], label [[CLOBBER:%.*]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load i32, i32* %ptr
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %exit, label %clobber

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

define i32 @no_partial_unswitch_true_same_successor(i32* %ptr, i32 %N) {
; CHECK-LABEL: @no_partial_unswitch_true_same_successor(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[NOCLOBBER:%.*]], label [[NOCLOBBER]]
; CHECK:       noclobber:
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load i32, i32* %ptr
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %noclobber, label %noclobber

noclobber:
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}

define i32 @partial_unswitch_true_to_latch(i32* %ptr, i32 %N) {
; CHECK-LABEL: @partial_unswitch_true_to_latch(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[LV:%.*]] = load i32, i32* [[PTR:%.*]], align 4
; CHECK-NEXT:    [[SC:%.*]] = icmp eq i32 [[LV]], 100
; CHECK-NEXT:    br i1 [[SC]], label [[LOOP_LATCH]], label [[CLOBBER:%.*]]
; CHECK:       clobber:
; CHECK-NEXT:    call void @clobber()
; CHECK-NEXT:    br label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[C:%.*]] = icmp ult i32 [[IV]], [[N:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i32 [[IV]], 1
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 10
;
entry:
  br label %loop.header

loop.header:
  %iv = phi i32 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %lv = load i32, i32* %ptr
  %sc = icmp eq i32 %lv, 100
  br i1 %sc, label %loop.latch, label %clobber

clobber:
  call void @clobber()
  br label %loop.latch

loop.latch:
  %c = icmp ult i32 %iv, %N
  %iv.next = add i32 %iv, 1
  br i1 %c, label %loop.header, label %exit

exit:
  ret i32 10
}
