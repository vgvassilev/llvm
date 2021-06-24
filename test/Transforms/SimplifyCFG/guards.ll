; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -simplifycfg -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck %s

declare void @llvm.experimental.guard(i1, ...)

define i32 @f_0(i1 %c) {
; CHECK-LABEL: @f_0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 false) [ "deopt"() ]
; CHECK-NEXT:    unreachable
;
entry:
  call void(i1, ...) @llvm.experimental.guard(i1 false) [ "deopt"() ]
  ret i32 10
}

define i32 @f_1(i1 %c) {
; Demonstrate that we (intentionally) do not simplify a guard on undef
; CHECK-LABEL: @f_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[TRUE:%.*]], label [[COMMON_RET:%.*]]
; CHECK:       common.ret:
; CHECK-NEXT:    [[COMMON_RET_OP:%.*]] = phi i32 [ 10, [[TRUE]] ], [ 20, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 [[COMMON_RET_OP]]
; CHECK:       true:
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 undef) [ "deopt"() ]
; CHECK-NEXT:    br label [[COMMON_RET]]
;

entry:
  br i1 %c, label %true, label %false

true:
  call void(i1, ...) @llvm.experimental.guard(i1 undef) [ "deopt"() ]
  ret i32 10

false:
  ret i32 20
}

define i32 @f_2(i1 %c, i32* %buf) {
; CHECK-LABEL: @f_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[GUARD_BLOCK:%.*]], label [[MERGE_BLOCK:%.*]]
; CHECK:       guard_block:
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 false) [ "deopt"() ]
; CHECK-NEXT:    unreachable
; CHECK:       merge_block:
; CHECK-NEXT:    ret i32 50
;
entry:
  br i1 %c, label %guard_block, label %merge_block

guard_block:
  call void(i1, ...) @llvm.experimental.guard(i1 false) [ "deopt"() ]
  %val = load i32, i32* %buf
  br label %merge_block

merge_block:
  %to.return = phi i32 [ %val, %guard_block ], [ 50, %entry ]
  ret i32 %to.return

}

define i32 @f_3(i1* %c, i32* %buf) {
; CHECK-LABEL: @f_3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C0:%.*]] = load volatile i1, i1* [[C:%.*]], align 1
; CHECK-NEXT:    br i1 [[C0]], label [[GUARD_BLOCK:%.*]], label [[MERGE_BLOCK:%.*]]
; CHECK:       guard_block:
; CHECK-NEXT:    call void (i1, ...) @llvm.experimental.guard(i1 false) [ "deopt"() ]
; CHECK-NEXT:    unreachable
; CHECK:       merge_block:
; CHECK-NEXT:    [[C1:%.*]] = load volatile i1, i1* [[C]], align 1
; CHECK-NEXT:    [[DOT:%.*]] = select i1 [[C1]], i32 50, i32 100
; CHECK-NEXT:    ret i32 [[DOT]]
;
entry:
  %c0 = load volatile i1, i1* %c
  br i1 %c0, label %guard_block, label %merge_block

guard_block:
  call void(i1, ...) @llvm.experimental.guard(i1 false) [ "deopt"() ]
  %val = load i32, i32* %buf
  %c2 = load volatile i1, i1* %c
  br i1 %c2, label %left, label %right

merge_block:
  %c1 = load volatile i1, i1* %c
  br i1 %c1, label %left, label %right

left:
  %val.left = phi i32 [ %val, %guard_block ], [ 50, %merge_block ]
  ret i32 %val.left

right:
  %val.right = phi i32 [ %val, %guard_block ], [ 100, %merge_block ]
  ret i32 %val.right


}
