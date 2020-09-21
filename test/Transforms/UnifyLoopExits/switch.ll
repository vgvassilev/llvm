; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -unify-loop-exits -enable-new-pm=0 -S | FileCheck %s

define void @loop_1(i32 %Value, i1 %PredEntry, i1 %PredD) {
; CHECK-LABEL: @loop_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[PREDENTRY:%.*]], label [[A:%.*]], label [[G:%.*]]
; CHECK:       A:
; CHECK-NEXT:    br label [[B:%.*]]
; CHECK:       B:
; CHECK-NEXT:    br label [[NODEBLOCK:%.*]]
; CHECK:       NodeBlock:
; CHECK-NEXT:    [[PIVOT:%.*]] = icmp slt i32 [[VALUE:%.*]], 1
; CHECK-NEXT:    br i1 [[PIVOT]], label [[LEAFBLOCK:%.*]], label [[LEAFBLOCK1:%.*]]
; CHECK:       LeafBlock1:
; CHECK-NEXT:    [[SWITCHLEAF2:%.*]] = icmp eq i32 [[VALUE]], 1
; CHECK-NEXT:    br i1 [[SWITCHLEAF2]], label [[D:%.*]], label [[LOOP_EXIT_GUARD:%.*]]
; CHECK:       LeafBlock:
; CHECK-NEXT:    [[SWITCHLEAF:%.*]] = icmp eq i32 [[VALUE]], 0
; CHECK-NEXT:    br i1 [[SWITCHLEAF]], label [[C:%.*]], label [[LOOP_EXIT_GUARD]]
; CHECK:       C:
; CHECK-NEXT:    br label [[D]]
; CHECK:       D:
; CHECK-NEXT:    br i1 [[PREDD:%.*]], label [[A]], label [[LOOP_EXIT_GUARD]]
; CHECK:       NewDefault:
; CHECK-NEXT:    br label [[X:%.*]]
; CHECK:       X:
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       Y:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       G:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
; CHECK:       loop.exit.guard:
; CHECK-NEXT:    [[GUARD_NEWDEFAULT:%.*]] = phi i1 [ true, [[LEAFBLOCK1]] ], [ true, [[LEAFBLOCK]] ], [ false, [[D]] ]
; CHECK-NEXT:    br i1 [[GUARD_NEWDEFAULT]], label [[NEWDEFAULT:%.*]], label [[Y:%.*]]
;
entry:
  br i1 %PredEntry, label %A, label %G

A:
  br label %B

B:
  switch i32 %Value, label %X [
  i32 0, label %C
  i32 1, label %D
  ]

C:
  br label %D

D:
  br i1 %PredD, label %A, label %Y

X:
  br label %exit

Y:
  br label %exit

G:
  br label %exit

exit:
  ret void
}
