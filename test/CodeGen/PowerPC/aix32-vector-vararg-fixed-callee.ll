; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -verify-machineinstrs -stop-before=ppc-vsx-copy -vec-extabi \
; RUN:     -mcpu=pwr7  -mtriple powerpc-ibm-aix-xcoff < %s | \
; RUN: FileCheck %s

;; Fixed vector arguments to variadic functions are passed differently than
;; either arguments to non-variadic functions or arguments passed through
;; ellipses.
define double @callee(i32 %count, <4 x i32> %vsi, double %next, ...) {
  ; CHECK-LABEL: name: callee
  ; CHECK: bb.0.entry:
  ; CHECK:   LIFETIME_START %stack.0.arg_list
  ; CHECK:   [[ADDI:%[0-9]+]]:gprc = ADDI %fixed-stack.0, 0
  ; CHECK:   STW killed [[ADDI]], 0, %stack.0.arg_list :: (store (s32) into %ir.0)
  ; CHECK:   [[ADDI1:%[0-9]+]]:gprc = ADDI %fixed-stack.0, 15
  ; CHECK:   [[RLWINM:%[0-9]+]]:gprc_and_gprc_nor0 = RLWINM killed [[ADDI1]], 0, 0, 27
  ; CHECK:   [[LFD:%[0-9]+]]:f8rc = LFD 16, killed [[RLWINM]] :: (load (s64) from %ir.4, align 16)
  ; CHECK:   LIFETIME_END %stack.0.arg_list
  ; CHECK:   $f1 = COPY [[LFD]]
  ; CHECK:   BLR implicit $lr, implicit $rm, implicit $f1
entry:
  %arg_list = alloca i8*, align 4
  %0 = bitcast i8** %arg_list to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %0)
  call void @llvm.va_start(i8* nonnull %0)
  %argp.cur = load i8*, i8** %arg_list, align 4
  %1 = ptrtoint i8* %argp.cur to i32
  %2 = add i32 %1, 15
  %3 = and i32 %2, -16
  %argp.cur.aligned = inttoptr i32 %3 to i8*
  %argp.next = getelementptr inbounds i8, i8* %argp.cur.aligned, i32 16
  %argp.next3 = getelementptr inbounds i8, i8* %argp.cur.aligned, i32 24
  store i8* %argp.next3, i8** %arg_list, align 4
  %4 = bitcast i8* %argp.next to double*
  %5 = load double, double* %4, align 16
  call void @llvm.va_end(i8* nonnull %0)
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %0)
  ret double %5
}

declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture)

declare void @llvm.va_start(i8*)

declare void @llvm.va_end(i8*)

declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture)

