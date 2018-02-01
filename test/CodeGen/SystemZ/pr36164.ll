; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc %s -o - -mtriple=s390x-linux-gnu -mcpu=z13 -disable-basicaa | FileCheck %s

; This test checks that we do not a reference to a deleted node.

%0 = type { i32 }

@g_11 = external dso_local unnamed_addr global i1, align 4
@g_69 = external dso_local global i32, align 4
@g_73 = external dso_local unnamed_addr global i32, align 4
@g_832 = external dso_local constant %0, align 4
@g_938 = external dso_local unnamed_addr global i64, align 8

; Function Attrs: nounwind
define void @main() local_unnamed_addr #0 {
; CHECK-LABEL: main:
; CHECK:       # %bb.0:
; CHECK-NEXT:    stmg %r12, %r15, 96(%r15)
; CHECK-NEXT:    .cfi_offset %r12, -64
; CHECK-NEXT:    .cfi_offset %r13, -56
; CHECK-NEXT:    .cfi_offset %r14, -48
; CHECK-NEXT:    .cfi_offset %r15, -40
; CHECK-NEXT:    lhi %r0, 1
; CHECK-NEXT:    larl %r1, g_938
; CHECK-NEXT:    lhi %r2, 2
; CHECK-NEXT:    lhi %r3, 3
; CHECK-NEXT:    lhi %r4, 0
; CHECK-NEXT:    lhi %r5, 4
; CHECK-NEXT:    larl %r14, g_11
; CHECK-NEXT:  .LBB0_1: # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    strl %r0, g_73
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    strl %r0, g_69
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    lghi %r13, 24
; CHECK-NEXT:    strl %r2, g_69
; CHECK-NEXT:    ag %r13, 0(%r1)
; CHECK-NEXT:    lrl %r12, g_832
; CHECK-NEXT:    strl %r3, g_69
; CHECK-NEXT:    lrl %r12, g_832
; CHECK-NEXT:    strl %r4, g_69
; CHECK-NEXT:    lrl %r12, g_832
; CHECK-NEXT:    strl %r0, g_69
; CHECK-NEXT:    lrl %r12, g_832
; CHECK-NEXT:    strl %r2, g_69
; CHECK-NEXT:    lrl %r12, g_832
; CHECK-NEXT:    strl %r3, g_69
; CHECK-NEXT:    stgrl %r13, g_938
; CHECK-NEXT:    lrl %r13, g_832
; CHECK-NEXT:    strl %r5, g_69
; CHECK-NEXT:    mvi 0(%r14), 1
; CHECK-NEXT:    j .LBB0_1
  br label %1

; <label>:1:                                      ; preds = %1, %0
  store i32 1, i32* @g_73, align 4
  %2 = load i64, i64* @g_938, align 8
  store i32 0, i32* @g_69, align 4
  %3 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  %4 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  %5 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  %6 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 1, i32* @g_69, align 4
  %7 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  %8 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 3, i32* @g_69, align 4
  %9 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  %10 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 1, i32* @g_69, align 4
  %11 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 2, i32* @g_69, align 4
  %12 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 3, i32* @g_69, align 4
  %13 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 0, i32* @g_69, align 4
  %14 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  %15 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  %16 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  %17 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 1, i32* @g_69, align 4
  %18 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 2, i32* @g_69, align 4
  %19 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 3, i32* @g_69, align 4
  %20 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 0, i32* @g_69, align 4
  %21 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 1, i32* @g_69, align 4
  %22 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 2, i32* @g_69, align 4
  %23 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 3, i32* @g_69, align 4
  %24 = add i64 %2, 24
  store i64 %24, i64* @g_938, align 8
  %25 = load volatile i32, i32* getelementptr inbounds (%0, %0* @g_832, i64 0, i32 0), align 4
  store i32 4, i32* @g_69, align 4
  store i1 true, i1* @g_11, align 4
  br label %1
}
