; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -jump-threading < %s | FileCheck %s

define i8 @test(i32 %a, i32 %length) {
; CHECK-LABEL: define {{[^@]+}}@test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BACKEDGE:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add nsw i32 [[IV]], 1
; CHECK-NEXT:    [[CONT:%.*]] = icmp slt i32 [[IV_NEXT]], 400
; CHECK-NEXT:    br i1 [[CONT]], label [[BACKEDGE]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i8 0
;
entry:
  br label %loop

loop:
  %iv = phi i32 [0, %entry], [%iv.next, %backedge]
  ;; We can use an inductive argument to prove %iv is always positive
  %cnd = icmp sge i32 %iv, 0
  br i1 %cnd, label %backedge, label %exit

backedge:
  %iv.next = add nsw i32 %iv, 1
  %cont = icmp slt i32 %iv.next, 400
  br i1 %cont, label %loop, label %exit
exit:
  ret i8 0
}

