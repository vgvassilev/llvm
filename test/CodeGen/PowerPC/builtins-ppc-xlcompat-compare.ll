; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr9 < %s | FileCheck %s --check-prefix=CHECK-64
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mcpu=pwr9 < %s | FileCheck %s --check-prefix=CHECK-64
; RUN: llc -verify-machineinstrs -mtriple=powerpc-unknown-aix \
; RUN:   -mcpu=pwr9 < %s | FileCheck %s --check-prefix=CHECK-32
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-aix \
; RUN:   -mcpu=pwr9 < %s | FileCheck %s --check-prefix=CHECK-64

define dso_local signext i32 @test_builtin_ppc_cmprb(i32 %a, i32%b, i32 %c, i32%d) {
; CHECK-32-LABEL: test_builtin_ppc_cmprb:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    cmprb 0, 0, 3, 4
; CHECK-32-NEXT:    setb 3, 0
; CHECK-32-NEXT:    cmprb 0, 1, 5, 6
; CHECK-32-NEXT:    setb 4, 0
; CHECK-32-NEXT:    add 3, 3, 4
; CHECK-32-NEXT:    blr
;
; CHECK-64-LABEL: test_builtin_ppc_cmprb:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    cmprb 0, 0, 3, 4
; CHECK-64-NEXT:    setb 3, 0
; CHECK-64-NEXT:    cmprb 0, 1, 5, 6
; CHECK-64-NEXT:    setb 4, 0
; CHECK-64-NEXT:    add 3, 3, 4
; CHECK-64-NEXT:    extsw 3, 3
; CHECK-64-NEXT:    blr
entry:
  %0 = call i32 @llvm.ppc.cmprb(i32 0, i32 %a, i32 %b)
  %1 = call i32 @llvm.ppc.cmprb(i32 1, i32 %c, i32 %d)
  %add = add nsw i32 %0, %1
  ret i32 %add
}

declare i32 @llvm.ppc.cmprb(i32, i32, i32)
