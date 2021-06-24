; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -simplifycfg -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck %s

define void @pr46638(i1 %c, i32 %x) {
; CHECK-LABEL: @pr46638(
; CHECK-NEXT:    [[CMP1:%.*]] = icmp slt i32 [[X:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP1]])
; CHECK-NEXT:    br i1 [[C:%.*]], label [[TRUE2_CRITEDGE:%.*]], label [[FALSE1:%.*]]
; CHECK:       false1:
; CHECK-NEXT:    call void @dummy(i32 1)
; CHECK-NEXT:    [[CMP2:%.*]] = icmp sgt i32 [[X]], 0
; CHECK-NEXT:    [[EXT:%.*]] = zext i1 [[CMP2]] to i32
; CHECK-NEXT:    call void @dummy(i32 [[EXT]])
; CHECK-NEXT:    br label [[COMMON_RET:%.*]]
; CHECK:       common.ret:
; CHECK-NEXT:    ret void
; CHECK:       true2.critedge:
; CHECK-NEXT:    [[CMP2_C:%.*]] = icmp sgt i32 [[X]], 0
; CHECK-NEXT:    [[EXT_C:%.*]] = zext i1 [[CMP2_C]] to i32
; CHECK-NEXT:    call void @dummy(i32 [[EXT_C]])
; CHECK-NEXT:    call void @dummy(i32 2)
; CHECK-NEXT:    br label [[COMMON_RET]]
;
  %cmp1 = icmp slt i32 %x, 0
  call void @llvm.assume(i1 %cmp1)
  br i1 %c, label %true1, label %false1

true1:
  %cmp2 = icmp sgt i32 %x, 0
  %ext = zext i1 %cmp2 to i32
  call void @dummy(i32 %ext)
  br i1 %c, label %true2, label %false2

false1:
  call void @dummy(i32 1)
  br label %true1

true2:
  call void @dummy(i32 2)
  ret void

false2:
  ret void
}

declare void @dummy(i32)
declare void @llvm.assume(i1)
