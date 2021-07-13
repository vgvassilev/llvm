; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr9 < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mcpu=pwr9 < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-aix \
; RUN:   -mcpu=pwr9 < %s | FileCheck %s

define dso_local i64 @test_builtin_ppc_mulhd(i64 %a, i64 %b) {
; CHECK-LABEL: test_builtin_ppc_mulhd:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mulhd 3, 3, 4
; CHECK-NEXT:    blr
entry:
  %0 = call i64 @llvm.ppc.mulhd(i64 %a, i64 %b)
  ret i64 %0
}

declare i64 @llvm.ppc.mulhd(i64, i64)

define dso_local i64 @test_builtin_ppc_mulhdu(i64 %a, i64 %b) {
; CHECK-LABEL: test_builtin_ppc_mulhdu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mulhdu 3, 3, 4
; CHECK-NEXT:    blr
entry:
  %0 = call i64 @llvm.ppc.mulhdu(i64 %a, i64 %b)
  ret i64 %0
}

declare i64 @llvm.ppc.mulhdu(i64, i64)

define dso_local i64 @test_builtin_ppc_maddhd(i64 %a, i64 %b, i64 %c) {
; CHECK-LABEL: test_builtin_ppc_maddhd:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    maddhd 3, 3, 4, 5
; CHECK-NEXT:    blr
entry:
  %0 = call i64 @llvm.ppc.maddhd(i64 %a, i64 %b, i64 %c)
  ret i64 %0
}

declare i64 @llvm.ppc.maddhd(i64, i64, i64)

define dso_local i64 @test_builtin_ppc_maddhdu(i64 %a, i64 %b, i64 %c) {
; CHECK-LABEL: test_builtin_ppc_maddhdu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    maddhdu 3, 3, 4, 5
; CHECK-NEXT:    blr
entry:
  %0 = call i64 @llvm.ppc.maddhdu(i64 %a, i64 %b, i64 %c)
  ret i64 %0
}

declare i64 @llvm.ppc.maddhdu(i64, i64, i64)

define dso_local i64 @test_builtin_ppc_maddld(i64 %a, i64 %b, i64 %c) {
; CHECK-LABEL: test_builtin_ppc_maddld:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    maddld 3, 3, 4, 5
; CHECK-NEXT:    blr
entry:
  %0 = call i64 @llvm.ppc.maddld(i64 %a, i64 %b, i64 %c)
  ret i64 %0
}

declare i64 @llvm.ppc.maddld(i64, i64, i64)

