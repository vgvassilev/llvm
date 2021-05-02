; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

declare void @foo()

define i1 @test1(i32 %a, i32 %b) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[TMP1:%.*]] = or i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt i32 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = icmp slt i32 %a, 0
  %2 = icmp slt i32 %b, 0
  %or.cond = or i1 %1, %2
  ret i1 %or.cond
}

define i1 @test1_logical(i32 %a, i32 %b) {
; CHECK-LABEL: @test1_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = or i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt i32 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = icmp slt i32 %a, 0
  %2 = icmp slt i32 %b, 0
  %or.cond = select i1 %1, i1 true, i1 %2
  ret i1 %or.cond
}

define i1 @test2(i32 %a, i32 %b) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[TMP1]], -1
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = icmp sgt i32 %a, -1
  %2 = icmp sgt i32 %b, -1
  %or.cond = or i1 %1, %2
  ret i1 %or.cond
}

define i1 @test2_logical(i32 %a, i32 %b) {
; CHECK-LABEL: @test2_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[TMP1]], -1
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = icmp sgt i32 %a, -1
  %2 = icmp sgt i32 %b, -1
  %or.cond = select i1 %1, i1 true, i1 %2
  ret i1 %or.cond
}

define i1 @test3(i32 %a, i32 %b) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt i32 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = icmp slt i32 %a, 0
  %2 = icmp slt i32 %b, 0
  %or.cond = and i1 %1, %2
  ret i1 %or.cond
}

define i1 @test3_logical(i32 %a, i32 %b) {
; CHECK-LABEL: @test3_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt i32 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = icmp slt i32 %a, 0
  %2 = icmp slt i32 %b, 0
  %or.cond = select i1 %1, i1 %2, i1 false
  ret i1 %or.cond
}

define i1 @test4(i32 %a, i32 %b) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[TMP1:%.*]] = or i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[TMP1]], -1
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = icmp sgt i32 %a, -1
  %2 = icmp sgt i32 %b, -1
  %or.cond = and i1 %1, %2
  ret i1 %or.cond
}

define i1 @test4_logical(i32 %a, i32 %b) {
; CHECK-LABEL: @test4_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = or i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp sgt i32 [[TMP1]], -1
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = icmp sgt i32 %a, -1
  %2 = icmp sgt i32 %b, -1
  %or.cond = select i1 %1, i1 %2, i1 false
  ret i1 %or.cond
}

define void @test5(i32 %a) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], -2013265920
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TMP2]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @foo() #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
  %and = and i32 %a, 134217728
  %1 = icmp eq i32 %and, 0
  %2 = icmp sgt i32 %a, -1
  %or.cond = and i1 %1, %2
  br i1 %or.cond, label %if.then, label %if.end


if.then:
  tail call void @foo() nounwind
  ret void

if.end:
  ret void
}

define void @test5_logical(i32 %a) {
; CHECK-LABEL: @test5_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], -2013265920
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TMP2]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @foo() #[[ATTR0]]
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
  %and = and i32 %a, 134217728
  %1 = icmp eq i32 %and, 0
  %2 = icmp sgt i32 %a, -1
  %or.cond = select i1 %1, i1 %2, i1 false
  br i1 %or.cond, label %if.then, label %if.end


if.then:
  tail call void @foo() nounwind
  ret void

if.end:
  ret void
}

define void @test6(i32 %a) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], -2013265920
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TMP2]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @foo() #[[ATTR0]]
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
  %1 = icmp sgt i32 %a, -1
  %and = and i32 %a, 134217728
  %2 = icmp eq i32 %and, 0
  %or.cond = and i1 %1, %2
  br i1 %or.cond, label %if.then, label %if.end


if.then:
  tail call void @foo() nounwind
  ret void

if.end:
  ret void
}

define void @test6_logical(i32 %a) {
; CHECK-LABEL: @test6_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], -2013265920
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[TMP2]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @foo() #[[ATTR0]]
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
  %1 = icmp sgt i32 %a, -1
  %and = and i32 %a, 134217728
  %2 = icmp eq i32 %and, 0
  %or.cond = select i1 %1, i1 %2, i1 false
  br i1 %or.cond, label %if.then, label %if.end


if.then:
  tail call void @foo() nounwind
  ret void

if.end:
  ret void
}

define void @test7(i32 %a) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], -2013265920
; CHECK-NEXT:    [[DOTNOT:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[DOTNOT]], label [[IF_END:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @foo() #[[ATTR0]]
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
  %and = and i32 %a, 134217728
  %1 = icmp ne i32 %and, 0
  %2 = icmp slt i32 %a, 0
  %or.cond = or i1 %1, %2
  br i1 %or.cond, label %if.then, label %if.end


if.then:
  tail call void @foo() nounwind
  ret void

if.end:
  ret void
}

define void @test7_logical(i32 %a) {
; CHECK-LABEL: @test7_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], -2013265920
; CHECK-NEXT:    [[DOTNOT:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[DOTNOT]], label [[IF_END:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @foo() #[[ATTR0]]
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
  %and = and i32 %a, 134217728
  %1 = icmp ne i32 %and, 0
  %2 = icmp slt i32 %a, 0
  %or.cond = select i1 %1, i1 true, i1 %2
  br i1 %or.cond, label %if.then, label %if.end


if.then:
  tail call void @foo() nounwind
  ret void

if.end:
  ret void
}

define void @test8(i32 %a) {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], -2013265920
; CHECK-NEXT:    [[DOTNOT:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[DOTNOT]], label [[IF_END:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @foo()
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
  %1 = icmp slt i32 %a, 0
  %and = and i32 %a, 134217728
  %2 = icmp ne i32 %and, 0
  %or.cond = or i1 %1, %2
  br i1 %or.cond, label %if.then, label %if.end


if.then:
  tail call void @foo()
  ret void

if.end:
  ret void
}

define void @test8_logical(i32 %a) {
; CHECK-LABEL: @test8_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], -2013265920
; CHECK-NEXT:    [[DOTNOT:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    br i1 [[DOTNOT]], label [[IF_END:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @foo()
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
  %1 = icmp slt i32 %a, 0
  %and = and i32 %a, 134217728
  %2 = icmp ne i32 %and, 0
  %or.cond = select i1 %1, i1 true, i1 %2
  br i1 %or.cond, label %if.then, label %if.end


if.then:
  tail call void @foo()
  ret void

if.end:
  ret void
}

define i1 @test9(i32 %a) {
; CHECK-LABEL: @test9(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], -1073741824
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP1]], 1073741824
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = and i32 %a, 1073741824
  %2 = icmp ne i32 %1, 0
  %3 = icmp sgt i32 %a, -1
  %or.cond = and i1 %2, %3
  ret i1 %or.cond
}

define i1 @test9_logical(i32 %a) {
; CHECK-LABEL: @test9_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[A:%.*]], -1073741824
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP1]], 1073741824
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = and i32 %a, 1073741824
  %2 = icmp ne i32 %1, 0
  %3 = icmp sgt i32 %a, -1
  %or.cond = select i1 %2, i1 %3, i1 false
  ret i1 %or.cond
}

define i1 @test10(i32 %a) {
; CHECK-LABEL: @test10(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i32 [[A:%.*]], 2
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = and i32 %a, 2
  %2 = icmp eq i32 %1, 0
  %3 = icmp ult i32 %a, 4
  %or.cond = and i1 %2, %3
  ret i1 %or.cond
}

define i1 @test10_logical(i32 %a) {
; CHECK-LABEL: @test10_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ult i32 [[A:%.*]], 2
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = and i32 %a, 2
  %2 = icmp eq i32 %1, 0
  %3 = icmp ult i32 %a, 4
  %or.cond = select i1 %2, i1 %3, i1 false
  ret i1 %or.cond
}

define i1 @test11(i32 %a) {
; CHECK-LABEL: @test11(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[A:%.*]], 1
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = and i32 %a, 2
  %2 = icmp ne i32 %1, 0
  %3 = icmp ugt i32 %a, 3
  %or.cond = or i1 %2, %3
  ret i1 %or.cond
}

define i1 @test11_logical(i32 %a) {
; CHECK-LABEL: @test11_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[A:%.*]], 1
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %1 = and i32 %a, 2
  %2 = icmp ne i32 %1, 0
  %3 = icmp ugt i32 %a, 3
  %or.cond = select i1 %2, i1 true, i1 %3
  ret i1 %or.cond
}
