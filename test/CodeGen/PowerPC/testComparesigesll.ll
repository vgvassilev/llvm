; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s --check-prefix=CHECK-BE \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s --check-prefix=CHECK-LE \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
@glob = dso_local local_unnamed_addr global i64 0, align 8

define dso_local signext i32 @test_igesll(i64 %a, i64 %b) {
; CHECK-LABEL: test_igesll:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sradi r5, r3, 63
; CHECK-NEXT:    rldicl r6, r4, 1, 63
; CHECK-NEXT:    subfc r3, r4, r3
; CHECK-NEXT:    adde r3, r5, r6
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_igesll:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sradi r5, r3, 63
; CHECK-BE-NEXT:    rldicl r6, r4, 1, 63
; CHECK-BE-NEXT:    subc r3, r3, r4
; CHECK-BE-NEXT:    adde r3, r5, r6
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_igesll:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sradi r5, r3, 63
; CHECK-LE-NEXT:    rldicl r6, r4, 1, 63
; CHECK-LE-NEXT:    subc r3, r3, r4
; CHECK-LE-NEXT:    adde r3, r5, r6
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sge i64 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define dso_local signext i32 @test_igesll_sext(i64 %a, i64 %b) {
; CHECK-LABEL: test_igesll_sext:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sradi r5, r3, 63
; CHECK-NEXT:    rldicl r6, r4, 1, 63
; CHECK-NEXT:    subfc r3, r4, r3
; CHECK-NEXT:    adde r3, r5, r6
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_igesll_sext:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sradi r5, r3, 63
; CHECK-BE-NEXT:    rldicl r6, r4, 1, 63
; CHECK-BE-NEXT:    subc r3, r3, r4
; CHECK-BE-NEXT:    adde r3, r5, r6
; CHECK-BE-NEXT:    neg r3, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_igesll_sext:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sradi r5, r3, 63
; CHECK-LE-NEXT:    rldicl r6, r4, 1, 63
; CHECK-LE-NEXT:    subc r3, r3, r4
; CHECK-LE-NEXT:    adde r3, r5, r6
; CHECK-LE-NEXT:    neg r3, r3
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sge i64 %a, %b
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local signext i32 @test_igesll_z(i64 %a) {
; CHECK-LABEL: test_igesll_z:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    not r3, r3
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_igesll_z:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    not r3, r3
; CHECK-BE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_igesll_z:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    not r3, r3
; CHECK-LE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sgt i64 %a, -1
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define dso_local signext i32 @test_igesll_sext_z(i64 %a) {
; CHECK-LABEL: test_igesll_sext_z:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sradi r3, r3, 63
; CHECK-NEXT:    not r3, r3
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_igesll_sext_z:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    not r3, r3
; CHECK-BE-NEXT:    sradi r3, r3, 63
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_igesll_sext_z:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    not r3, r3
; CHECK-LE-NEXT:    sradi r3, r3, 63
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sgt i64 %a, -1
  %sub = sext i1 %cmp to i32
  ret i32 %sub
}

define dso_local void @test_igesll_store(i64 %a, i64 %b) {
; CHECK-LABEL: test_igesll_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sradi r6, r3, 63
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    subfc r3, r4, r3
; CHECK-NEXT:    rldicl r3, r4, 1, 63
; CHECK-NEXT:    adde r3, r6, r3
; CHECK-NEXT:    std r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_igesll_store:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sradi r6, r3, 63
; CHECK-BE-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-BE-NEXT:    subc r3, r3, r4
; CHECK-BE-NEXT:    rldicl r3, r4, 1, 63
; CHECK-BE-NEXT:    adde r3, r6, r3
; CHECK-BE-NEXT:    std r3, glob@toc@l(r5)
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_igesll_store:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sradi r6, r3, 63
; CHECK-LE-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-LE-NEXT:    subc r3, r3, r4
; CHECK-LE-NEXT:    rldicl r3, r4, 1, 63
; CHECK-LE-NEXT:    adde r3, r6, r3
; CHECK-LE-NEXT:    std r3, glob@toc@l(r5)
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sge i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @glob, align 8
  ret void
}

define dso_local void @test_igesll_sext_store(i64 %a, i64 %b) {
; CHECK-LABEL: test_igesll_sext_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sradi r6, r3, 63
; CHECK-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-NEXT:    subfc r3, r4, r3
; CHECK-NEXT:    rldicl r3, r4, 1, 63
; CHECK-NEXT:    adde r3, r6, r3
; CHECK-NEXT:    neg r3, r3
; CHECK-NEXT:    std r3, glob@toc@l(r5)
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_igesll_sext_store:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sradi r6, r3, 63
; CHECK-BE-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-BE-NEXT:    subc r3, r3, r4
; CHECK-BE-NEXT:    rldicl r3, r4, 1, 63
; CHECK-BE-NEXT:    adde r3, r6, r3
; CHECK-BE-NEXT:    neg r3, r3
; CHECK-BE-NEXT:    std r3, glob@toc@l(r5)
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_igesll_sext_store:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    sradi r6, r3, 63
; CHECK-LE-NEXT:    addis r5, r2, glob@toc@ha
; CHECK-LE-NEXT:    subc r3, r3, r4
; CHECK-LE-NEXT:    rldicl r3, r4, 1, 63
; CHECK-LE-NEXT:    adde r3, r6, r3
; CHECK-LE-NEXT:    neg r3, r3
; CHECK-LE-NEXT:    std r3, glob@toc@l(r5)
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sge i64 %a, %b
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, i64* @glob, align 8
  ret void
}

define dso_local void @test_igesll_z_store(i64 %a) {
; CHECK-LABEL: test_igesll_z_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    not r3, r3
; CHECK-NEXT:    addis r4, r2, glob@toc@ha
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    std r3, glob@toc@l(r4)
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_igesll_z_store:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    not r3, r3
; CHECK-BE-NEXT:    addis r4, r2, glob@toc@ha
; CHECK-BE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-BE-NEXT:    std r3, glob@toc@l(r4)
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_igesll_z_store:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    not r3, r3
; CHECK-LE-NEXT:    addis r4, r2, glob@toc@ha
; CHECK-LE-NEXT:    rldicl r3, r3, 1, 63
; CHECK-LE-NEXT:    std r3, glob@toc@l(r4)
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sgt i64 %a, -1
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @glob, align 8
  ret void
}

define dso_local void @test_igesll_sext_z_store(i64 %a) {
; CHECK-LABEL: test_igesll_sext_z_store:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    not r3, r3
; CHECK-NEXT:    addis r4, r2, glob@toc@ha
; CHECK-NEXT:    sradi r3, r3, 63
; CHECK-NEXT:    std r3, glob@toc@l(r4)
; CHECK-NEXT:    blr
; CHECK-BE-LABEL: test_igesll_sext_z_store:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    not r3, r3
; CHECK-BE-NEXT:    addis r4, r2, glob@toc@ha
; CHECK-BE-NEXT:    sradi r3, r3, 63
; CHECK-BE-NEXT:    std r3, glob@toc@l(r4)
; CHECK-BE-NEXT:    blr
;
; CHECK-LE-LABEL: test_igesll_sext_z_store:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    not r3, r3
; CHECK-LE-NEXT:    addis r4, r2, glob@toc@ha
; CHECK-LE-NEXT:    sradi r3, r3, 63
; CHECK-LE-NEXT:    std r3, glob@toc@l(r4)
; CHECK-LE-NEXT:    blr
entry:
  %cmp = icmp sgt i64 %a, -1
  %conv1 = sext i1 %cmp to i64
  store i64 %conv1, i64* @glob, align 8
  ret void
}
