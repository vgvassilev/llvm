; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -correlated-propagation -S %s | FileCheck %s
; RUN: opt -passes=correlated-propagation -S %s | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

declare void @check1(i1) #1
declare void @check2(i1) #1

; Make sure we propagate the value of %tmp35 to the true/false cases

define void @test1(i64 %tmp35) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP36:%.*]] = icmp sgt i64 [[TMP35:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP36]], label [[BB_TRUE:%.*]], label [[BB_FALSE:%.*]]
; CHECK:       bb_true:
; CHECK-NEXT:    tail call void @check1(i1 false) #0
; CHECK-NEXT:    unreachable
; CHECK:       bb_false:
; CHECK-NEXT:    tail call void @check2(i1 true) #0
; CHECK-NEXT:    unreachable
;
bb:
  %tmp36 = icmp sgt i64 %tmp35, 0
  br i1 %tmp36, label %bb_true, label %bb_false

bb_true:
  %tmp47 = icmp slt i64 %tmp35, 0
  tail call void @check1(i1 %tmp47) #4
  unreachable

bb_false:
  %tmp48 = icmp sle i64 %tmp35, 0
  tail call void @check2(i1 %tmp48) #4
  unreachable
}

; This is the same as test1 but with a diamond to ensure we
; get %tmp36 from both true and false BBs.

define void @test2(i64 %tmp35, i1 %inner_cmp) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP36:%.*]] = icmp sgt i64 [[TMP35:%.*]], 0
; CHECK-NEXT:    br i1 [[TMP36]], label [[BB_TRUE:%.*]], label [[BB_FALSE:%.*]]
; CHECK:       bb_true:
; CHECK-NEXT:    br i1 [[INNER_CMP:%.*]], label [[INNER_TRUE:%.*]], label [[INNER_FALSE:%.*]]
; CHECK:       inner_true:
; CHECK-NEXT:    br label [[MERGE:%.*]]
; CHECK:       inner_false:
; CHECK-NEXT:    br label [[MERGE]]
; CHECK:       merge:
; CHECK-NEXT:    tail call void @check1(i1 false)
; CHECK-NEXT:    unreachable
; CHECK:       bb_false:
; CHECK-NEXT:    tail call void @check2(i1 true) #0
; CHECK-NEXT:    unreachable
;
bb:
  %tmp36 = icmp sgt i64 %tmp35, 0
  br i1 %tmp36, label %bb_true, label %bb_false

bb_true:
  br i1 %inner_cmp, label %inner_true, label %inner_false

inner_true:
  br label %merge

inner_false:
  br label %merge

merge:
  %tmp47 = icmp slt i64 %tmp35, 0
  tail call void @check1(i1 %tmp47) #0
  unreachable

bb_false:
  %tmp48 = icmp sle i64 %tmp35, 0
  tail call void @check2(i1 %tmp48) #4
  unreachable
}

; Make sure binary operator transfer functions are run when RHS is non-constant

define i1 @test3(i32 %x, i32 %y) #0 {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult i32 [[X:%.*]], 10
; CHECK-NEXT:    br i1 [[CMP1]], label [[CONT1:%.*]], label [[OUT:%.*]]
; CHECK:       cont1:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[Y:%.*]], 10
; CHECK-NEXT:    br i1 [[CMP2]], label [[CONT2:%.*]], label [[OUT]]
; CHECK:       cont2:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i32 [[X]], [[Y]]
; CHECK-NEXT:    br label [[CONT3:%.*]]
; CHECK:       cont3:
; CHECK-NEXT:    br label [[OUT]]
; CHECK:       out:
; CHECK-NEXT:    ret i1 true
;
entry:
  %cmp1 = icmp ult i32 %x, 10
  br i1 %cmp1, label %cont1, label %out

cont1:
  %cmp2 = icmp ult i32 %y, 10
  br i1 %cmp2, label %cont2, label %out

cont2:
  %add = add i32 %x, %y
  br label %cont3

cont3:
  %cmp3 = icmp ult i32 %add, 25
  br label %out

out:
  %ret = phi i1 [ true, %entry], [ true, %cont1 ], [ %cmp3, %cont3 ]
  ret i1 %ret
}

; Same as previous but make sure nobody gets over-zealous

define i1 @test4(i32 %x, i32 %y) #0 {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult i32 [[X:%.*]], 10
; CHECK-NEXT:    br i1 [[CMP1]], label [[CONT1:%.*]], label [[OUT:%.*]]
; CHECK:       cont1:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[Y:%.*]], 10
; CHECK-NEXT:    br i1 [[CMP2]], label [[CONT2:%.*]], label [[OUT]]
; CHECK:       cont2:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i32 [[X]], [[Y]]
; CHECK-NEXT:    br label [[CONT3:%.*]]
; CHECK:       cont3:
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ult i32 [[ADD]], 15
; CHECK-NEXT:    br label [[OUT]]
; CHECK:       out:
; CHECK-NEXT:    [[RET:%.*]] = phi i1 [ true, [[ENTRY:%.*]] ], [ true, [[CONT1]] ], [ [[CMP3]], [[CONT3]] ]
; CHECK-NEXT:    ret i1 [[RET]]
;
entry:
  %cmp1 = icmp ult i32 %x, 10
  br i1 %cmp1, label %cont1, label %out

cont1:
  %cmp2 = icmp ult i32 %y, 10
  br i1 %cmp2, label %cont2, label %out

cont2:
  %add = add i32 %x, %y
  br label %cont3

cont3:
  %cmp3 = icmp ult i32 %add, 15
  br label %out

out:
  %ret = phi i1 [ true, %entry], [ true, %cont1 ], [ %cmp3, %cont3 ]
  ret i1 %ret
}

; Make sure binary operator transfer functions are run when RHS is non-constant

define i1 @test5(i32 %x, i32 %y) #0 {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult i32 [[X:%.*]], 5
; CHECK-NEXT:    br i1 [[CMP1]], label [[CONT1:%.*]], label [[OUT:%.*]]
; CHECK:       cont1:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[Y:%.*]], 5
; CHECK-NEXT:    br i1 [[CMP2]], label [[CONT2:%.*]], label [[OUT]]
; CHECK:       cont2:
; CHECK-NEXT:    [[SHIFTED:%.*]] = shl nuw nsw i32 [[X]], [[Y]]
; CHECK-NEXT:    br label [[CONT3:%.*]]
; CHECK:       cont3:
; CHECK-NEXT:    br label [[OUT]]
; CHECK:       out:
; CHECK-NEXT:    ret i1 true
;
entry:
  %cmp1 = icmp ult i32 %x, 5
  br i1 %cmp1, label %cont1, label %out

cont1:
  %cmp2 = icmp ult i32 %y, 5
  br i1 %cmp2, label %cont2, label %out

cont2:
  %shifted = shl i32 %x, %y
  br label %cont3

cont3:
  %cmp3 = icmp ult i32 %shifted, 65536
  br label %out

out:
  %ret = phi i1 [ true, %entry], [ true, %cont1 ], [ %cmp3, %cont3 ]
  ret i1 %ret
}

; Same as previous but make sure nobody gets over-zealous

define i1 @test6(i32 %x, i32 %y) #0 {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult i32 [[X:%.*]], 5
; CHECK-NEXT:    br i1 [[CMP1]], label [[CONT1:%.*]], label [[OUT:%.*]]
; CHECK:       cont1:
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ult i32 [[Y:%.*]], 15
; CHECK-NEXT:    br i1 [[CMP2]], label [[CONT2:%.*]], label [[OUT]]
; CHECK:       cont2:
; CHECK-NEXT:    [[SHIFTED:%.*]] = shl nuw nsw i32 [[X]], [[Y]]
; CHECK-NEXT:    br label [[CONT3:%.*]]
; CHECK:       cont3:
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ult i32 [[SHIFTED]], 65536
; CHECK-NEXT:    br label [[OUT]]
; CHECK:       out:
; CHECK-NEXT:    [[RET:%.*]] = phi i1 [ true, [[ENTRY:%.*]] ], [ true, [[CONT1]] ], [ [[CMP3]], [[CONT3]] ]
; CHECK-NEXT:    ret i1 [[RET]]
;
entry:
  %cmp1 = icmp ult i32 %x, 5
  br i1 %cmp1, label %cont1, label %out

cont1:
  %cmp2 = icmp ult i32 %y, 15
  br i1 %cmp2, label %cont2, label %out

cont2:
  %shifted = shl i32 %x, %y
  br label %cont3

cont3:
  %cmp3 = icmp ult i32 %shifted, 65536
  br label %out

out:
  %ret = phi i1 [ true, %entry], [ true, %cont1 ], [ %cmp3, %cont3 ]
  ret i1 %ret
}

define i1 @test7(i32 %a, i32 %b) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:  begin:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sge i32 [[A:%.*]], 0
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sge i32 [[B:%.*]], 0
; CHECK-NEXT:    [[BR:%.*]] = and i1 [[CMP0]], [[CMP1]]
; CHECK-NEXT:    br i1 [[BR]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw i32 [[A]], [[B]]
; CHECK-NEXT:    br label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    [[RES:%.*]] = icmp sge i32 [[ADD]], 0
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[IV:%.*]] = phi i1 [ true, [[BEGIN:%.*]] ], [ [[RES]], [[CONT]] ]
; CHECK-NEXT:    ret i1 [[IV]]
;
begin:
  %cmp0 = icmp sge i32 %a, 0
  %cmp1 = icmp sge i32 %b, 0
  %br = and i1 %cmp0, %cmp1
  br i1 %br, label %bb, label %exit

bb:
  %add = add i32 %a, %b
  br label %cont

cont:
  %res = icmp sge i32 %add, 0
  br label %exit

exit:
  %iv = phi i1 [ true, %begin ], [ %res, %cont ]
  ret i1 %iv
}

define i1 @test8(i32 %a, i32 %b) {
; CHECK-LABEL: @test8(
; CHECK-NEXT:  begin:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sge i32 [[A:%.*]], 0
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sge i32 [[B:%.*]], 0
; CHECK-NEXT:    [[BR:%.*]] = and i1 [[CMP0]], [[CMP1]]
; CHECK-NEXT:    br i1 [[BR]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i32 [[A]], [[B]]
; CHECK-NEXT:    br label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret i1 true
;
begin:
  %cmp0 = icmp sge i32 %a, 0
  %cmp1 = icmp sge i32 %b, 0
  %br = and i1 %cmp0, %cmp1
  br i1 %br, label %bb, label %exit

bb:
  %add = add nsw i32 %a, %b
  br label %cont

cont:
  %res = icmp sge i32 %add, 0
  br label %exit

exit:
  %iv = phi i1 [ true, %begin ], [ %res, %cont ]
  ret i1 %iv
}

define i1 @test10(i32 %a, i32 %b) {
; CHECK-LABEL: @test10(
; CHECK-NEXT:  begin:
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge i32 [[A:%.*]], -256
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[A]], [[B:%.*]]
; CHECK-NEXT:    br label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    [[RES:%.*]] = icmp uge i32 [[ADD]], -256
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[IV:%.*]] = phi i1 [ true, [[BEGIN:%.*]] ], [ [[RES]], [[CONT]] ]
; CHECK-NEXT:    ret i1 [[IV]]
;
begin:
  %cmp = icmp uge i32 %a, 4294967040
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add i32 %a, %b
  br label %cont

cont:
  %res = icmp uge i32 %add, 4294967040
  br label %exit

exit:
  %iv = phi i1 [ true, %begin ], [ %res, %cont ]
  ret i1 %iv
}

define i1 @test11(i32 %a, i32 %b) {
; CHECK-LABEL: @test11(
; CHECK-NEXT:  begin:
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge i32 [[A:%.*]], -256
; CHECK-NEXT:    br i1 [[CMP]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw i32 [[A]], [[B:%.*]]
; CHECK-NEXT:    br label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret i1 true
;
begin:
  %cmp = icmp uge i32 %a, 4294967040
  br i1 %cmp, label %bb, label %exit

bb:
  %add = add nuw i32 %a, %b
  br label %cont

cont:
  %res = icmp uge i32 %add, 4294967040
  br label %exit

exit:
  %iv = phi i1 [ true, %begin ], [ %res, %cont ]
  ret i1 %iv
}

define i1 @test12(i32 %x) {
; CHECK-LABEL: @test12(
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw nsw i64 [[ZEXT]], 7
; CHECK-NEXT:    [[SHR:%.*]] = lshr i64 [[MUL]], 32
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i64 [[SHR]] to i32
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[TRUNC]], 7
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %zext = zext i32 %x to i64
  %mul = mul nuw i64 %zext, 7
  %shr = lshr i64 %mul, 32
  %trunc = trunc i64 %shr to i32
  %cmp = icmp ult i32 %trunc, 7
  ret i1 %cmp
}

define i1 @test13(i8 %x, i64* %p) {
; CHECK-LABEL: @test13(
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i8 [[X:%.*]] to i64
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i64 [[ZEXT]], 128
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[ADD]], 384
; CHECK-NEXT:    store i64 [[ADD]], i64* [[P:%.*]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %zext = zext i8 %x to i64
  %add = add nuw nsw i64 %zext, 128
  %cmp = icmp ult i64 %add, 384
  ; Without this extra use, InstSimplify could handle this
  store i64 %add, i64* %p
  ret i1 %cmp
}

define i1 @test14(i32 %a, i32 %b) {
; CHECK-LABEL: @test14(
; CHECK-NEXT:  begin:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sge i32 [[A:%.*]], 0
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sge i32 [[B:%.*]], 0
; CHECK-NEXT:    [[BR:%.*]] = and i1 [[CMP0]], [[CMP1]]
; CHECK-NEXT:    br i1 [[BR]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[A]], [[B]]
; CHECK-NEXT:    br label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    [[RES:%.*]] = icmp sge i32 [[SUB]], 0
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[IV:%.*]] = phi i1 [ true, [[BEGIN:%.*]] ], [ [[RES]], [[CONT]] ]
; CHECK-NEXT:    ret i1 [[IV]]
;
begin:
  %cmp0 = icmp sge i32 %a, 0
  %cmp1 = icmp sge i32 %b, 0
  %br = and i1 %cmp0, %cmp1
  br i1 %br, label %bb, label %exit

bb:
  %sub = sub i32 %a, %b
  br label %cont

cont:
  %res = icmp sge i32 %sub, 0
  br label %exit

exit:
  %iv = phi i1 [ true, %begin ], [ %res, %cont ]
  ret i1 %iv
}

define i1 @test15(i32 %a, i32 %b) {
; CHECK-LABEL: @test15(
; CHECK-NEXT:  begin:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sge i32 [[A:%.*]], 0
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sge i32 [[B:%.*]], 0
; CHECK-NEXT:    [[BR:%.*]] = and i1 [[CMP0]], [[CMP1]]
; CHECK-NEXT:    br i1 [[BR]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[A]], [[B]]
; CHECK-NEXT:    br label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    [[RES:%.*]] = icmp sge i32 [[SUB]], 0
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[IV:%.*]] = phi i1 [ true, [[BEGIN:%.*]] ], [ [[RES]], [[CONT]] ]
; CHECK-NEXT:    ret i1 [[IV]]
;
begin:
  %cmp0 = icmp sge i32 %a, 0
  %cmp1 = icmp sge i32 %b, 0
  %br = and i1 %cmp0, %cmp1
  br i1 %br, label %bb, label %exit

bb:
  %sub = sub nsw i32 %a, %b
  br label %cont

cont:
  %res = icmp sge i32 %sub, 0
  br label %exit

exit:
  %iv = phi i1 [ true, %begin ], [ %res, %cont ]
  ret i1 %iv
}

define i1 @test16(i32 %a, i32 %b) {
; CHECK-LABEL: @test16(
; CHECK-NEXT:  begin:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sge i32 [[A:%.*]], 0
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sge i32 [[B:%.*]], 0
; CHECK-NEXT:    [[BR:%.*]] = and i1 [[CMP0]], [[CMP1]]
; CHECK-NEXT:    br i1 [[BR]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[SUB:%.*]] = sub nuw nsw i32 [[A]], [[B]]
; CHECK-NEXT:    br label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret i1 true
;
begin:
  %cmp0 = icmp sge i32 %a, 0
  %cmp1 = icmp sge i32 %b, 0
  %br = and i1 %cmp0, %cmp1
  br i1 %br, label %bb, label %exit

bb:
  %sub = sub nuw i32 %a, %b
  br label %cont

cont:
  %res = icmp sge i32 %sub, 0
  br label %exit

exit:
  %iv = phi i1 [ true, %begin ], [ %res, %cont ]
  ret i1 %iv
}

define i1 @test17(i32 %a, i32 %b) {
; CHECK-LABEL: @test17(
; CHECK-NEXT:  begin:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sle i32 [[A:%.*]], 0
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sge i32 [[B:%.*]], 0
; CHECK-NEXT:    [[BR:%.*]] = and i1 [[CMP0]], [[CMP1]]
; CHECK-NEXT:    br i1 [[BR]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 [[A]], [[B]]
; CHECK-NEXT:    br label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    [[RES:%.*]] = icmp sle i32 [[SUB]], 0
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[IV:%.*]] = phi i1 [ true, [[BEGIN:%.*]] ], [ [[RES]], [[CONT]] ]
; CHECK-NEXT:    ret i1 [[IV]]
;
begin:
  %cmp0 = icmp sle i32 %a, 0
  %cmp1 = icmp sge i32 %b, 0
  %br = and i1 %cmp0, %cmp1
  br i1 %br, label %bb, label %exit

bb:
  %sub = sub i32 %a, %b
  br label %cont

cont:
  %res = icmp sle i32 %sub, 0
  br label %exit

exit:
  %iv = phi i1 [ true, %begin ], [ %res, %cont ]
  ret i1 %iv
}

define i1 @test18(i32 %a, i32 %b) {
; CHECK-LABEL: @test18(
; CHECK-NEXT:  begin:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sle i32 [[A:%.*]], 0
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sge i32 [[B:%.*]], 0
; CHECK-NEXT:    [[BR:%.*]] = and i1 [[CMP0]], [[CMP1]]
; CHECK-NEXT:    br i1 [[BR]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[SUB:%.*]] = sub nuw i32 [[A]], [[B]]
; CHECK-NEXT:    br label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    [[RES:%.*]] = icmp sle i32 [[SUB]], 0
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    [[IV:%.*]] = phi i1 [ true, [[BEGIN:%.*]] ], [ [[RES]], [[CONT]] ]
; CHECK-NEXT:    ret i1 [[IV]]
;
begin:
  %cmp0 = icmp sle i32 %a, 0
  %cmp1 = icmp sge i32 %b, 0
  %br = and i1 %cmp0, %cmp1
  br i1 %br, label %bb, label %exit

bb:
  %sub = sub nuw i32 %a, %b
  br label %cont

cont:
  %res = icmp sle i32 %sub, 0
  br label %exit

exit:
  %iv = phi i1 [ true, %begin ], [ %res, %cont ]
  ret i1 %iv
}

define i1 @test19(i32 %a, i32 %b) {
; CHECK-LABEL: @test19(
; CHECK-NEXT:  begin:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sle i32 [[A:%.*]], 0
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sge i32 [[B:%.*]], 0
; CHECK-NEXT:    [[BR:%.*]] = and i1 [[CMP0]], [[CMP1]]
; CHECK-NEXT:    br i1 [[BR]], label [[BB:%.*]], label [[EXIT:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[SUB:%.*]] = sub nsw i32 [[A]], [[B]]
; CHECK-NEXT:    br label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret i1 true
;
begin:
  %cmp0 = icmp sle i32 %a, 0
  %cmp1 = icmp sge i32 %b, 0
  %br = and i1 %cmp0, %cmp1
  br i1 %br, label %bb, label %exit

bb:
  %sub = sub nsw i32 %a, %b
  br label %cont

cont:
  %res = icmp sle i32 %sub, 0
  br label %exit

exit:
  %iv = phi i1 [ true, %begin ], [ %res, %cont ]
  ret i1 %iv
}

define void @test_cmp_phi(i8 %a) {
; CHECK-LABEL: @test_cmp_phi(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C0:%.*]] = icmp ult i8 [[A:%.*]], 2
; CHECK-NEXT:    br i1 [[C0]], label [[LOOP:%.*]], label [[EXIT:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[P:%.*]] = phi i8 [ [[A]], [[ENTRY:%.*]] ], [ [[B:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[C1:%.*]] = icmp ne i8 [[P]], 0
; CHECK-NEXT:    [[C2:%.*]] = icmp ne i8 [[P]], 2
; CHECK-NEXT:    [[C3:%.*]] = and i1 [[C1]], [[C2]]
; CHECK-NEXT:    [[C4:%.*]] = call i1 @get_bool()
; CHECK-NEXT:    [[B]] = zext i1 [[C4]] to i8
; CHECK-NEXT:    br i1 [[C3]], label [[LOOP]], label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %c0 = icmp ult i8 %a, 2
  br i1 %c0, label %loop, label %exit

loop:
  %p = phi i8 [ %a, %entry ], [ %b, %loop ]
  %c1 = icmp ne i8 %p, 0
  %c2 = icmp ne i8 %p, 2
  %c3 = and i1 %c1, %c2
  %c4 = call i1 @get_bool()
  %b = zext i1 %c4 to i8
  br i1 %c3, label %loop, label %exit

exit:
  ret void
}

declare i1 @get_bool()

attributes #4 = { noreturn }
