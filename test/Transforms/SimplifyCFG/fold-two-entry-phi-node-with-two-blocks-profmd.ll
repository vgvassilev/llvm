; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -simplifycfg -simplifycfg-require-and-preserve-domtree=1 -two-entry-phi-node-folding-threshold=4 -phi-node-folding-threshold=0 < %s | FileCheck %s

declare void @sideeffect0()
declare void @sideeffect1()

define i32 @unknown(i32 %a, i32 %b, i32 %c, i32 %d) {
; CHECK-LABEL: @unknown(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @sideeffect0()
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[V0:%.*]] = add i32 [[C:%.*]], [[D:%.*]]
; CHECK-NEXT:    [[V1:%.*]] = sub i32 [[C]], [[D]]
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 [[V0]], i32 [[V1]]
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  call void @sideeffect0()
  %cmp = icmp eq i32 %a, %b
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:
  %v0 = add i32 %c, %d
  br label %end

cond.false:
  %v1 = sub i32 %c, %d
  br label %end

end:
  %res = phi i32 [ %v0, %cond.true ], [ %v1, %cond.false ]
  call void @sideeffect1()
  ret i32 %res
}

define i32 @predictably_taken(i32 %a, i32 %b, i32 %c, i32 %d) {
; CHECK-LABEL: @predictably_taken(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @sideeffect0()
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[V0:%.*]] = add i32 [[C:%.*]], [[D:%.*]]
; CHECK-NEXT:    [[V1:%.*]] = sub i32 [[C]], [[D]]
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 [[V0]], i32 [[V1]], !prof [[PROF0:![0-9]+]]
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  call void @sideeffect0()
  %cmp = icmp eq i32 %a, %b
  br i1 %cmp, label %cond.true, label %cond.false, !prof !0 ; likely branches to %cond.true

cond.true:
  %v0 = add i32 %c, %d
  br label %end

cond.false:
  %v1 = sub i32 %c, %d
  br label %end

end:
  %res = phi i32 [ %v0, %cond.true ], [ %v1, %cond.false ]
  call void @sideeffect1()
  ret i32 %res
}

define i32 @predictably_nontaken(i32 %a, i32 %b, i32 %c, i32 %d) {
; CHECK-LABEL: @predictably_nontaken(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @sideeffect0()
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[V0:%.*]] = add i32 [[C:%.*]], [[D:%.*]]
; CHECK-NEXT:    [[V1:%.*]] = sub i32 [[C]], [[D]]
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 [[V1]], i32 [[V0]], !prof [[PROF0]]
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  call void @sideeffect0()
  %cmp = icmp eq i32 %a, %b
  br i1 %cmp, label %cond.false, label %cond.true, !prof !0 ; likely branches to %cond.false

cond.true:
  %v0 = add i32 %c, %d
  br label %end

cond.false:
  %v1 = sub i32 %c, %d
  br label %end

end:
  %res = phi i32 [ %v0, %cond.true ], [ %v1, %cond.false ]
  call void @sideeffect1()
  ret i32 %res
}

define i32 @unpredictable(i32 %a, i32 %b, i32 %c, i32 %d) {
; CHECK-LABEL: @unpredictable(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @sideeffect0()
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[V0:%.*]] = add i32 [[C:%.*]], [[D:%.*]]
; CHECK-NEXT:    [[V1:%.*]] = sub i32 [[C]], [[D]]
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 [[V0]], i32 [[V1]], !unpredictable !1
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  call void @sideeffect0()
  %cmp = icmp eq i32 %a, %b
  br i1 %cmp, label %cond.true, label %cond.false, !unpredictable !1 ; unpredictable

cond.true:
  %v0 = add i32 %c, %d
  br label %end

cond.false:
  %v1 = sub i32 %c, %d
  br label %end

end:
  %res = phi i32 [ %v0, %cond.true ], [ %v1, %cond.false ]
  call void @sideeffect1()
  ret i32 %res
}

define i32 @unpredictable_yet_taken(i32 %a, i32 %b, i32 %c, i32 %d) {
; CHECK-LABEL: @unpredictable_yet_taken(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @sideeffect0()
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[V0:%.*]] = add i32 [[C:%.*]], [[D:%.*]]
; CHECK-NEXT:    [[V1:%.*]] = sub i32 [[C]], [[D]]
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 [[V0]], i32 [[V1]], !prof [[PROF0]], !unpredictable !1
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  call void @sideeffect0()
  %cmp = icmp eq i32 %a, %b
  br i1 %cmp, label %cond.true, label %cond.false, !prof !0, !unpredictable !1 ; likely branches to %cond.true, yet unpredictable

cond.true:
  %v0 = add i32 %c, %d
  br label %end

cond.false:
  %v1 = sub i32 %c, %d
  br label %end

end:
  %res = phi i32 [ %v0, %cond.true ], [ %v1, %cond.false ]
  call void @sideeffect1()
  ret i32 %res
}

define i32 @unpredictable_yet_nontaken(i32 %a, i32 %b, i32 %c, i32 %d) {
; CHECK-LABEL: @unpredictable_yet_nontaken(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @sideeffect0()
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[V0:%.*]] = add i32 [[C:%.*]], [[D:%.*]]
; CHECK-NEXT:    [[V1:%.*]] = sub i32 [[C]], [[D]]
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 [[V1]], i32 [[V0]], !prof [[PROF0]], !unpredictable !1
; CHECK-NEXT:    call void @sideeffect1()
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  call void @sideeffect0()
  %cmp = icmp eq i32 %a, %b
  br i1 %cmp, label %cond.false, label %cond.true, !prof !0, !unpredictable !1 ; likely branches to %cond.false, yet unpredictable

cond.true:
  %v0 = add i32 %c, %d
  br label %end

cond.false:
  %v1 = sub i32 %c, %d
  br label %end

end:
  %res = phi i32 [ %v0, %cond.true ], [ %v1, %cond.false ]
  call void @sideeffect1()
  ret i32 %res
}

!0 = !{!"branch_weights", i32 99, i32 1}
!1 = !{}

; CHECK: !0 = !{!"branch_weights", i32 99, i32 1}
; CHECK: !1 = !{}
