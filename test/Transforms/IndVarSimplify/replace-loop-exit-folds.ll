; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -indvars -S < %s | FileCheck %s

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"

define i32 @remove_loop(i32 %size) {
; CHECK-LABEL: @remove_loop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = sub i32 -1, [[SIZE:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[TMP0]], -32
; CHECK-NEXT:    [[UMAX:%.*]] = select i1 [[TMP1]], i32 [[TMP0]], i32 -32
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[SIZE]], [[UMAX]]
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[TMP2]], 32
; CHECK-NEXT:    [[TMP4:%.*]] = lshr i32 [[TMP3]], 5
; CHECK-NEXT:    [[TMP5:%.*]] = shl i32 [[TMP4]], 5
; CHECK-NEXT:    br label [[WHILE_COND:%.*]]
; CHECK:       while.cond:
; CHECK-NEXT:    [[SIZE_ADDR_0:%.*]] = phi i32 [ [[SIZE]], [[ENTRY:%.*]] ], [ [[SUB:%.*]], [[WHILE_COND]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[SIZE_ADDR_0]], 31
; CHECK-NEXT:    [[SUB]] = add i32 [[SIZE_ADDR_0]], -32
; CHECK-NEXT:    br i1 [[CMP]], label [[WHILE_COND]], label [[WHILE_END:%.*]]
; CHECK:       while.end:
; CHECK-NEXT:    [[TMP6:%.*]] = sub i32 [[SIZE]], [[TMP5]]
; CHECK-NEXT:    ret i32 [[TMP6]]
;
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %size.addr.0 = phi i32 [ %size, %entry ], [ %sub, %while.cond ]
  %cmp = icmp ugt i32 %size.addr.0, 31
  %sub = add i32 %size.addr.0, -32
  br i1 %cmp, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  %size.lcssa = phi i32 [ %size.addr.0, %while.cond ]
  ret i32 %size.lcssa
}

define i32 @used_loop(i32 %size) minsize {
; CHECK-LABEL: @used_loop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[WHILE_COND:%.*]]
; CHECK:       while.cond:
; CHECK-NEXT:    [[SIZE_ADDR_0:%.*]] = phi i32 [ [[SIZE:%.*]], [[ENTRY:%.*]] ], [ [[SUB:%.*]], [[WHILE_COND]] ]
; CHECK-NEXT:    tail call void @call()
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[SIZE_ADDR_0]], 31
; CHECK-NEXT:    [[SUB]] = add i32 [[SIZE_ADDR_0]], -32
; CHECK-NEXT:    br i1 [[CMP]], label [[WHILE_COND]], label [[WHILE_END:%.*]]
; CHECK:       while.end:
; CHECK-NEXT:    [[SIZE_LCSSA:%.*]] = phi i32 [ [[SIZE_ADDR_0]], [[WHILE_COND]] ]
; CHECK-NEXT:    ret i32 [[SIZE_LCSSA]]
;
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %size.addr.0 = phi i32 [ %size, %entry ], [ %sub, %while.cond ]
  tail call void @call()
  %cmp = icmp ugt i32 %size.addr.0, 31
  %sub = add i32 %size.addr.0, -32
  br i1 %cmp, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  %size.lcssa = phi i32 [ %size.addr.0, %while.cond ]
  ret i32 %size.lcssa
}


define i32 @test_signed_while(i32 %S) {
; CHECK-LABEL: @test_signed_while(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[WHILE_COND:%.*]]
; CHECK:       while.cond:
; CHECK-NEXT:    [[S_ADDR_0:%.*]] = phi i32 [ [[S:%.*]], [[ENTRY:%.*]] ], [ [[SUB:%.*]], [[WHILE_BODY:%.*]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[S_ADDR_0]], 31
; CHECK-NEXT:    br i1 [[CMP]], label [[WHILE_BODY]], label [[WHILE_END:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[SUB]] = add nsw i32 [[S_ADDR_0]], -32
; CHECK-NEXT:    tail call void @call()
; CHECK-NEXT:    br label [[WHILE_COND]]
; CHECK:       while.end:
; CHECK-NEXT:    [[S_ADDR_0_LCSSA:%.*]] = phi i32 [ [[S_ADDR_0]], [[WHILE_COND]] ]
; CHECK-NEXT:    ret i32 [[S_ADDR_0_LCSSA]]
;
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %S.addr.0 = phi i32 [ %S, %entry ], [ %sub, %while.body ]
  %cmp = icmp sgt i32 %S.addr.0, 31
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %sub = add nsw i32 %S.addr.0, -32
  tail call void @call()
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %S.addr.0.lcssa = phi i32 [ %S.addr.0, %while.cond ]
  ret i32 %S.addr.0.lcssa
}

define i32 @test_signed_do(i32 %S) {
; CHECK-LABEL: @test_signed_do(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[S_ADDR_0:%.*]] = phi i32 [ [[S:%.*]], [[ENTRY:%.*]] ], [ [[SUB:%.*]], [[DO_BODY]] ]
; CHECK-NEXT:    [[SUB]] = add nsw i32 [[S_ADDR_0]], -16
; CHECK-NEXT:    tail call void @call()
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[SUB]], 15
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY]], label [[DO_END:%.*]]
; CHECK:       do.end:
; CHECK-NEXT:    [[SUB_LCSSA:%.*]] = phi i32 [ [[SUB]], [[DO_BODY]] ]
; CHECK-NEXT:    ret i32 [[SUB_LCSSA]]
;
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %S.addr.0 = phi i32 [ %S, %entry ], [ %sub, %do.body ]
  %sub = add nsw i32 %S.addr.0, -16
  tail call void @call()
  %cmp = icmp sgt i32 %sub, 15
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  %sub.lcssa = phi i32 [ %sub, %do.body ]
  ret i32 %sub.lcssa
}

define i32 @test_unsigned_while(i32 %S) {
; CHECK-LABEL: @test_unsigned_while(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[WHILE_COND:%.*]]
; CHECK:       while.cond:
; CHECK-NEXT:    [[S_ADDR_0:%.*]] = phi i32 [ [[S:%.*]], [[ENTRY:%.*]] ], [ [[SUB:%.*]], [[WHILE_BODY:%.*]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[S_ADDR_0]], 15
; CHECK-NEXT:    br i1 [[CMP]], label [[WHILE_BODY]], label [[WHILE_END:%.*]]
; CHECK:       while.body:
; CHECK-NEXT:    [[SUB]] = add i32 [[S_ADDR_0]], -16
; CHECK-NEXT:    tail call void @call()
; CHECK-NEXT:    br label [[WHILE_COND]]
; CHECK:       while.end:
; CHECK-NEXT:    [[S_ADDR_0_LCSSA:%.*]] = phi i32 [ [[S_ADDR_0]], [[WHILE_COND]] ]
; CHECK-NEXT:    ret i32 [[S_ADDR_0_LCSSA]]
;
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %S.addr.0 = phi i32 [ %S, %entry ], [ %sub, %while.body ]
  %cmp = icmp ugt i32 %S.addr.0, 15
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %sub = add i32 %S.addr.0, -16
  tail call void @call()
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %S.addr.0.lcssa = phi i32 [ %S.addr.0, %while.cond ]
  ret i32 %S.addr.0.lcssa
}

define i32 @test_unsigned_do(i32 %S) {
; CHECK-LABEL: @test_unsigned_do(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[DO_BODY:%.*]]
; CHECK:       do.body:
; CHECK-NEXT:    [[S_ADDR_0:%.*]] = phi i32 [ [[S:%.*]], [[ENTRY:%.*]] ], [ [[SUB:%.*]], [[DO_BODY]] ]
; CHECK-NEXT:    [[SUB]] = add i32 [[S_ADDR_0]], -16
; CHECK-NEXT:    tail call void @call()
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[SUB]], 15
; CHECK-NEXT:    br i1 [[CMP]], label [[DO_BODY]], label [[DO_END:%.*]]
; CHECK:       do.end:
; CHECK-NEXT:    [[SUB_LCSSA:%.*]] = phi i32 [ [[SUB]], [[DO_BODY]] ]
; CHECK-NEXT:    ret i32 [[SUB_LCSSA]]
;
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %S.addr.0 = phi i32 [ %S, %entry ], [ %sub, %do.body ]
  %sub = add i32 %S.addr.0, -16
  tail call void @call()
  %cmp = icmp ugt i32 %sub, 15
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  %sub.lcssa = phi i32 [ %sub, %do.body ]
  ret i32 %sub.lcssa
}


declare void @call()
