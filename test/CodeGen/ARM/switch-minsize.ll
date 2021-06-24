; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s | FileCheck %s

target datalayout = "e-m:o-p:32:32-f64:32:64-v64:32:64-v128:32:128-a:0:32-n32-S32"
target triple = "thumbv7-apple-ios8.0.0"

declare void @g(i32)
define void @f(i32 %val) optsize minsize {
; CHECK-LABEL: f:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov r1, r0
; CHECK-NEXT:    movs r0, #1
; CHECK-NEXT:    cbz r1, LBB0_6
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:    movw r2, #1154
; CHECK-NEXT:    cmp r1, r2
; CHECK-NEXT:    beq LBB0_4
; CHECK-NEXT:  @ %bb.2:
; CHECK-NEXT:    movw r2, #994
; CHECK-NEXT:    cmp r1, r2
; CHECK-NEXT:    beq LBB0_5
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:    cmp r1, #9
; CHECK-NEXT:    it ne
; CHECK-NEXT:    movne r0, #11
; CHECK-NEXT:    b LBB0_6
; CHECK-NEXT:  LBB0_4: @ %four
; CHECK-NEXT:    movs r0, #87
; CHECK-NEXT:    b LBB0_6
; CHECK-NEXT:  LBB0_5: @ %three
; CHECK-NEXT:    movs r0, #78
; CHECK-NEXT:  LBB0_6: @ %common.ret
; CHECK-NEXT:    str lr, [sp, #-4]!
; CHECK-NEXT:    bl _g
; CHECK-NEXT:    ldr lr, [sp], #4
; CHECK-NEXT:    bx lr
  switch i32 %val, label %def [
    i32 0, label %one
    i32 9, label %two
    i32 994, label %three
    i32 1154, label %four
  ]

one:
  call void @g(i32 1)
  ret void
two:
  call void @g(i32 001)
  ret void
three:
  call void @g(i32 78)
  ret void
four:
  call void @g(i32 87)
  ret void
def:
  call void @g(i32 11)
  ret void
}
