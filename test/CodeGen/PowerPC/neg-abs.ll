; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -ppc-asm-full-reg-names -verify-machineinstrs \
; RUN:   -mtriple=powerpc64le-linux-gnu < %s | FileCheck \
; RUN:   -check-prefix=CHECK-LE %s

declare i64 @llvm.abs.i64(i64, i1 immarg)

define i64@neg_abs(i64 %x) {
; CHECK-LE-LABEL: neg_abs:
; CHECK-LE:       # %bb.0:
; CHECK-LE-NEXT:    sradi r4, r3, 63
; CHECK-LE-NEXT:    xor r3, r3, r4
; CHECK-LE-NEXT:    sub r3, r4, r3
; CHECK-LE-NEXT:    blr
  %abs = tail call i64 @llvm.abs.i64(i64 %x, i1 true)
  %neg = sub nsw i64 0, %abs
  ret i64 %neg
}
