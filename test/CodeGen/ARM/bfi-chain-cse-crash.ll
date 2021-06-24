; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=thumbv7s | FileCheck %s
target datalayout = "e-m:o-p:32:32-f64:32:64-v64:32:64-v128:32:128-a:0:32-n32-S32"
target triple = "thumbv7s-apple-ios3.1.3"

define void @bfi_chain_cse_crash(i8* %0, i8 *%ptr) {
; CHECK-LABEL: bfi_chain_cse_crash:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    ldrb r2, [r0]
; CHECK-NEXT:    and r3, r2, #1
; CHECK-NEXT:    lsr.w r12, r2, #3
; CHECK-NEXT:    bfi r3, r12, #3, #1
; CHECK-NEXT:    strb r3, [r0]
; CHECK-NEXT:    and r0, r2, #4
; CHECK-NEXT:    bfi r0, r12, #3, #1
; CHECK-NEXT:    strb r0, [r1]
; CHECK-NEXT:    bx lr
entry:
  %1 = load i8, i8* %0, align 1
  %2 = and i8 %1, 1
  %3 = select i1 false, i8 %2, i8 0
  %4 = and i8 %1, 4
  %5 = icmp eq i8 %4, 0
  %6 = zext i8 %3 to i32
  %7 = or i32 %6, 4
  %8 = trunc i32 %7 to i8
  %9 = select i1 %5, i8 %3, i8 %8
  %10 = and i8 %1, 8
  %11 = icmp eq i8 %10, 0
  %12 = zext i8 %2 to i32
  %13 = or i32 %12, 8
  %14 = trunc i32 %13 to i8
  %15 = zext i8 %9 to i32
  %16 = or i32 %15, 8
  %17 = trunc i32 %16 to i8
  %18 = select i1 %11, i8 %2, i8 %14
  %19 = select i1 %11, i8 %9, i8 %17
  store i8 %18, i8* %0, align 1
  store i8 %19, i8* %ptr, align 1
  ret void
}
