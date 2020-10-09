; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -ppc-asm-full-reg-names -verify-machineinstrs \
; RUN:   -mtriple=powerpc64le-linux-gnu < %s | FileCheck \
; RUN:   -check-prefix=CHECK-LE %s
; RUN: llc -ppc-asm-full-reg-names -verify-machineinstrs \
; RUN:   -mtriple=powerpc-linux-gnu < %s | FileCheck \
; RUN:   -check-prefix=CHECK-32 %s

define i64 @f0(i64 %x) {
; CHECK-LE-LABEL: f0:
; CHECK-LE:       # %bb.0:
; CHECK-LE-NEXT:    li r4, 125
; CHECK-LE-NEXT:    cmpdi r3, 0
; CHECK-LE-NEXT:    li r3, -3
; CHECK-LE-NEXT:    isellt r3, r3, r4
; CHECK-LE-NEXT:    blr
;
; CHECK-32-LABEL: f0:
; CHECK-32:       # %bb.0:
; CHECK-32-NEXT:    li r4, 125
; CHECK-32-NEXT:    li r5, -3
; CHECK-32-NEXT:    cmpwi r3, 0
; CHECK-32-NEXT:    bc 12, lt, .LBB0_1
; CHECK-32-NEXT:    b .LBB0_2
; CHECK-32-NEXT:  .LBB0_1:
; CHECK-32-NEXT:    addi r4, r5, 0
; CHECK-32-NEXT:  .LBB0_2:
; CHECK-32-NEXT:    srawi r3, r3, 31
; CHECK-32-NEXT:    blr
  %c = icmp slt i64 %x, 0
  %r = select i1 %c, i64 -3, i64 125
  ret i64 %r
}

define i64 @f1(i64 %x) {
; CHECK-LE-LABEL: f1:
; CHECK-LE:       # %bb.0:
; CHECK-LE-NEXT:    li r4, 512
; CHECK-LE-NEXT:    cmpdi r3, 0
; CHECK-LE-NEXT:    li r3, 64
; CHECK-LE-NEXT:    isellt r3, r3, r4
; CHECK-LE-NEXT:    blr
;
; CHECK-32-LABEL: f1:
; CHECK-32:       # %bb.0:
; CHECK-32-NEXT:    li r4, 512
; CHECK-32-NEXT:    cmpwi r3, 0
; CHECK-32-NEXT:    li r3, 64
; CHECK-32-NEXT:    bc 12, lt, .LBB1_1
; CHECK-32-NEXT:    b .LBB1_2
; CHECK-32-NEXT:  .LBB1_1:
; CHECK-32-NEXT:    addi r4, r3, 0
; CHECK-32-NEXT:  .LBB1_2:
; CHECK-32-NEXT:    li r3, 0
; CHECK-32-NEXT:    blr
  %c = icmp slt i64 %x, 0
  %r = select i1 %c, i64 64, i64 512
  ret i64 %r
}

define i64 @f2(i64 %x) {
; CHECK-LE-LABEL: f2:
; CHECK-LE:       # %bb.0:
; CHECK-LE-NEXT:    li r4, 1024
; CHECK-LE-NEXT:    cmpdi r3, 0
; CHECK-LE-NEXT:    iseleq r3, 0, r4
; CHECK-LE-NEXT:    blr
;
; CHECK-32-LABEL: f2:
; CHECK-32:       # %bb.0:
; CHECK-32-NEXT:    or. r3, r4, r3
; CHECK-32-NEXT:    li r3, 1024
; CHECK-32-NEXT:    bc 12, eq, .LBB2_2
; CHECK-32-NEXT:  # %bb.1:
; CHECK-32-NEXT:    ori r4, r3, 0
; CHECK-32-NEXT:    b .LBB2_3
; CHECK-32-NEXT:  .LBB2_2:
; CHECK-32-NEXT:    li r4, 0
; CHECK-32-NEXT:  .LBB2_3:
; CHECK-32-NEXT:    li r3, 0
; CHECK-32-NEXT:    blr
  %c = icmp eq i64 %x, 0
  %r = select i1 %c, i64 0, i64 1024
  ret i64 %r
}

define i64 @f3(i64 %x, i64 %y) {
; CHECK-LE-LABEL: f3:
; CHECK-LE:       # %bb.0:
; CHECK-LE-NEXT:    cmpldi r3, 0
; CHECK-LE-NEXT:    iseleq r3, 0, r4
; CHECK-LE-NEXT:    blr
;
; CHECK-32-LABEL: f3:
; CHECK-32:       # %bb.0:
; CHECK-32-NEXT:    or. r3, r4, r3
; CHECK-32-NEXT:    bc 12, eq, .LBB3_2
; CHECK-32-NEXT:  # %bb.1:
; CHECK-32-NEXT:    ori r3, r5, 0
; CHECK-32-NEXT:    ori r4, r6, 0
; CHECK-32-NEXT:    blr
; CHECK-32-NEXT:  .LBB3_2:
; CHECK-32-NEXT:    li r3, 0
; CHECK-32-NEXT:    li r4, 0
; CHECK-32-NEXT:    blr
  %c = icmp eq i64 %x, 0
  %r = select i1 %c, i64 0, i64 %y
  ret i64 %r
}

define i64 @f4(i64 %x) {
; CHECK-LE-LABEL: f4:
; CHECK-LE:       # %bb.0:
; CHECK-LE-NEXT:    neg r4, r3
; CHECK-LE-NEXT:    cmpdi r3, 0
; CHECK-LE-NEXT:    iselgt r3, r4, r3
; CHECK-LE-NEXT:    blr
;
; CHECK-32-LABEL: f4:
; CHECK-32:       # %bb.0:
; CHECK-32-NEXT:    cmplwi r3, 0
; CHECK-32-NEXT:    cmpwi cr1, r3, 0
; CHECK-32-NEXT:    crandc 4*cr5+lt, 4*cr1+gt, eq
; CHECK-32-NEXT:    cmpwi cr1, r4, 0
; CHECK-32-NEXT:    subfic r5, r4, 0
; CHECK-32-NEXT:    crandc 4*cr5+gt, eq, 4*cr1+eq
; CHECK-32-NEXT:    cror 4*cr5+lt, 4*cr5+gt, 4*cr5+lt
; CHECK-32-NEXT:    subfze r6, r3
; CHECK-32-NEXT:    bc 12, 4*cr5+lt, .LBB4_1
; CHECK-32-NEXT:    blr
; CHECK-32-NEXT:  .LBB4_1:
; CHECK-32-NEXT:    addi r3, r6, 0
; CHECK-32-NEXT:    addi r4, r5, 0
; CHECK-32-NEXT:    blr
  %c = icmp sgt i64 %x, 0
  %x.neg = sub i64 0, %x
  %r = select i1 %c, i64 %x.neg, i64 %x
  ret i64 %r
}
