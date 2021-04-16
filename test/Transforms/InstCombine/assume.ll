; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S  -instcombine-infinite-loop-threshold=2  -instcombine-unsafe-select-transform=0 | FileCheck --check-prefixes=CHECK,DEFAULT %s
; RUN: opt < %s -instcombine --enable-knowledge-retention -S  -instcombine-infinite-loop-threshold=2  -instcombine-unsafe-select-transform=0 | FileCheck --check-prefixes=CHECK,BUNDLES %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

declare void @llvm.assume(i1) #1

; Check that the alignment has been upgraded and that the assume has not
; been removed:

define i32 @foo1(i32* %a) #0 {
; DEFAULT-LABEL: @foo1(
; DEFAULT-NEXT:    [[T0:%.*]] = load i32, i32* [[A:%.*]], align 32
; DEFAULT-NEXT:    [[PTRINT:%.*]] = ptrtoint i32* [[A]] to i64
; DEFAULT-NEXT:    [[MASKEDPTR:%.*]] = and i64 [[PTRINT]], 31
; DEFAULT-NEXT:    [[MASKCOND:%.*]] = icmp eq i64 [[MASKEDPTR]], 0
; DEFAULT-NEXT:    tail call void @llvm.assume(i1 [[MASKCOND]])
; DEFAULT-NEXT:    ret i32 [[T0]]
;
; BUNDLES-LABEL: @foo1(
; BUNDLES-NEXT:    [[T0:%.*]] = load i32, i32* [[A:%.*]], align 32
; BUNDLES-NEXT:    call void @llvm.assume(i1 true) [ "align"(i32* [[A]], i64 32) ]
; BUNDLES-NEXT:    ret i32 [[T0]]
;
  %t0 = load i32, i32* %a, align 4
  %ptrint = ptrtoint i32* %a to i64
  %maskedptr = and i64 %ptrint, 31
  %maskcond = icmp eq i64 %maskedptr, 0
  tail call void @llvm.assume(i1 %maskcond)
  ret i32 %t0
}

; Same check as in @foo1, but make sure it works if the assume is first too.

define i32 @foo2(i32* %a) #0 {
; DEFAULT-LABEL: @foo2(
; DEFAULT-NEXT:    [[PTRINT:%.*]] = ptrtoint i32* [[A:%.*]] to i64
; DEFAULT-NEXT:    [[MASKEDPTR:%.*]] = and i64 [[PTRINT]], 31
; DEFAULT-NEXT:    [[MASKCOND:%.*]] = icmp eq i64 [[MASKEDPTR]], 0
; DEFAULT-NEXT:    tail call void @llvm.assume(i1 [[MASKCOND]])
; DEFAULT-NEXT:    [[T0:%.*]] = load i32, i32* [[A]], align 32
; DEFAULT-NEXT:    ret i32 [[T0]]
;
; BUNDLES-LABEL: @foo2(
; BUNDLES-NEXT:    call void @llvm.assume(i1 true) [ "align"(i32* [[A:%.*]], i64 32) ]
; BUNDLES-NEXT:    [[T0:%.*]] = load i32, i32* [[A]], align 32
; BUNDLES-NEXT:    ret i32 [[T0]]
;
  %ptrint = ptrtoint i32* %a to i64
  %maskedptr = and i64 %ptrint, 31
  %maskcond = icmp eq i64 %maskedptr, 0
  tail call void @llvm.assume(i1 %maskcond)
  %t0 = load i32, i32* %a, align 4
  ret i32 %t0
}

define i32 @simple(i32 %a) #1 {
; CHECK-LABEL: @simple(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[A:%.*]], 4
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret i32 4
;
  %cmp = icmp eq i32 %a, 4
  tail call void @llvm.assume(i1 %cmp)
  ret i32 %a
}

define i32 @can1(i1 %a, i1 %b, i1 %c) {
; CHECK-LABEL: @can1(
; CHECK-NEXT:    call void @llvm.assume(i1 [[A:%.*]])
; CHECK-NEXT:    call void @llvm.assume(i1 [[B:%.*]])
; CHECK-NEXT:    call void @llvm.assume(i1 [[C:%.*]])
; CHECK-NEXT:    ret i32 5
;
  %and1 = and i1 %a, %b
  %and  = and i1 %and1, %c
  tail call void @llvm.assume(i1 %and)
  ret i32 5
}

define i32 @can1_logical(i1 %a, i1 %b, i1 %c) {
; CHECK-LABEL: @can1_logical(
; CHECK-NEXT:    call void @llvm.assume(i1 [[A:%.*]])
; CHECK-NEXT:    call void @llvm.assume(i1 [[B:%.*]])
; CHECK-NEXT:    call void @llvm.assume(i1 [[C:%.*]])
; CHECK-NEXT:    ret i32 5
;
  %and1 = select i1 %a, i1 %b, i1 false
  %and  = select i1 %and1, i1 %c, i1 false
  tail call void @llvm.assume(i1 %and)
  ret i32 5
}

define i32 @can2(i1 %a, i1 %b, i1 %c) {
; CHECK-LABEL: @can2(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i1 [[A:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP1]])
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[B:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP2]])
; CHECK-NEXT:    ret i32 5
;
  %v = or i1 %a, %b
  %w = xor i1 %v, 1
  tail call void @llvm.assume(i1 %w)
  ret i32 5
}

define i32 @can2_logical(i1 %a, i1 %b, i1 %c) {
; CHECK-LABEL: @can2_logical(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i1 [[A:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP1]])
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[B:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP2]])
; CHECK-NEXT:    ret i32 5
;
  %v = select i1 %a, i1 true, i1 %b
  %w = xor i1 %v, 1
  tail call void @llvm.assume(i1 %w)
  ret i32 5
}

define i32 @bar1(i32 %a) #0 {
; CHECK-LABEL: @bar1(
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[A:%.*]], 7
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[AND]], 1
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret i32 1
;
  %and1 = and i32 %a, 3
  %and = and i32 %a, 7
  %cmp = icmp eq i32 %and, 1
  tail call void @llvm.assume(i1 %cmp)
  ret i32 %and1
}

define i32 @bar2(i32 %a) #0 {
; CHECK-LABEL: @bar2(
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[A:%.*]], 7
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[AND]], 1
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret i32 1
;
  %and = and i32 %a, 7
  %cmp = icmp eq i32 %and, 1
  tail call void @llvm.assume(i1 %cmp)
  %and1 = and i32 %a, 3
  ret i32 %and1
}

define i32 @bar3(i32 %a, i1 %x, i1 %y) #0 {
; CHECK-LABEL: @bar3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[X:%.*]])
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[A:%.*]], 7
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[AND]], 1
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[Y:%.*]])
; CHECK-NEXT:    ret i32 1
;
entry:
  %and1 = and i32 %a, 3

; Don't be fooled by other assumes around.

  tail call void @llvm.assume(i1 %x)

  %and = and i32 %a, 7
  %cmp = icmp eq i32 %and, 1
  tail call void @llvm.assume(i1 %cmp)

  tail call void @llvm.assume(i1 %y)

  ret i32 %and1
}

; If we allow recursive known bits queries based on
; assumptions, we could do better here:
; a == b and a & 7 == 1, so b & 7 == 1, so b & 3 == 1, so return 1.

define i32 @known_bits_recursion_via_assumes(i32 %a, i32 %b) {
; CHECK-LABEL: @known_bits_recursion_via_assumes(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[AND1:%.*]] = and i32 [[B:%.*]], 3
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[A:%.*]], 7
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[AND]], 1
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i32 [[A]], [[B]]
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP2]])
; CHECK-NEXT:    ret i32 [[AND1]]
;
entry:
  %and1 = and i32 %b, 3
  %and = and i32 %a, 7
  %cmp = icmp eq i32 %and, 1
  tail call void @llvm.assume(i1 %cmp)
  %cmp2 = icmp eq i32 %a, %b
  tail call void @llvm.assume(i1 %cmp2)
  ret i32 %and1
}

define i32 @icmp1(i32 %a) #0 {
; CHECK-LABEL: @icmp1(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[A:%.*]], 5
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret i32 1
;
  %cmp = icmp sgt i32 %a, 5
  tail call void @llvm.assume(i1 %cmp)
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define i32 @icmp2(i32 %a) #0 {
; CHECK-LABEL: @icmp2(
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[A:%.*]], 5
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret i32 0
;
  %cmp = icmp sgt i32 %a, 5
  tail call void @llvm.assume(i1 %cmp)
  %t0 = zext i1 %cmp to i32
  %lnot.ext = xor i32 %t0, 1
  ret i32 %lnot.ext
}

; If the 'not' of a condition is known true, then the condition must be false.

define i1 @assume_not(i1 %cond) {
; CHECK-LABEL: @assume_not(
; CHECK-NEXT:    [[NOTCOND:%.*]] = xor i1 [[COND:%.*]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[NOTCOND]])
; CHECK-NEXT:    ret i1 false
;
  %notcond = xor i1 %cond, true
  call void @llvm.assume(i1 %notcond)
  ret i1 %cond
}

declare void @escape(i32* %a)

; Canonicalize a nonnull assumption on a load into metadata form.

define i32 @bundle1(i32* %P) {
; CHECK-LABEL: @bundle1(
; CHECK-NEXT:    tail call void @llvm.assume(i1 true) [ "nonnull"(i32* [[P:%.*]]) ]
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, i32* [[P]], align 4
; CHECK-NEXT:    ret i32 [[LOAD]]
;
  tail call void @llvm.assume(i1 true) ["nonnull"(i32* %P)]
  %load = load i32, i32* %P
  ret i32 %load
}

define i32 @bundle2(i32* %P) {
; CHECK-LABEL: @bundle2(
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, i32* [[P:%.*]], align 4
; CHECK-NEXT:    ret i32 [[LOAD]]
;
  tail call void @llvm.assume(i1 true) ["ignore"(i32* undef)]
  %load = load i32, i32* %P
  ret i32 %load
}

define i1 @nonnull1(i32** %a) {
; CHECK-LABEL: @nonnull1(
; CHECK-NEXT:    [[LOAD:%.*]] = load i32*, i32** [[A:%.*]], align 8, !nonnull !6
; CHECK-NEXT:    tail call void @escape(i32* nonnull [[LOAD]])
; CHECK-NEXT:    ret i1 false
;
  %load = load i32*, i32** %a
  %cmp = icmp ne i32* %load, null
  tail call void @llvm.assume(i1 %cmp)
  tail call void @escape(i32* %load)
  %rval = icmp eq i32* %load, null
  ret i1 %rval
}

; Make sure the above canonicalization applies only
; to pointer types.  Doing otherwise would be illegal.

define i1 @nonnull2(i32* %a) {
; CHECK-LABEL: @nonnull2(
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, i32* [[A:%.*]], align 4
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[LOAD]], 0
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret i1 false
;
  %load = load i32, i32* %a
  %cmp = icmp ne i32 %load, 0
  tail call void @llvm.assume(i1 %cmp)
  %rval = icmp eq i32 %load, 0
  ret i1 %rval
}

; Make sure the above canonicalization does not trigger
; if the assume is control dependent on something else

define i1 @nonnull3(i32** %a, i1 %control) {
; FIXME: in the BUNDLES version we could duplicate the load and keep the assume nonnull.
; DEFAULT-LABEL: @nonnull3(
; DEFAULT-NEXT:  entry:
; DEFAULT-NEXT:    [[LOAD:%.*]] = load i32*, i32** [[A:%.*]], align 8
; DEFAULT-NEXT:    [[CMP:%.*]] = icmp ne i32* [[LOAD]], null
; DEFAULT-NEXT:    br i1 [[CONTROL:%.*]], label [[TAKEN:%.*]], label [[NOT_TAKEN:%.*]]
; DEFAULT:       taken:
; DEFAULT-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; DEFAULT-NEXT:    ret i1 false
; DEFAULT:       not_taken:
; DEFAULT-NEXT:    [[RVAL_2:%.*]] = icmp sgt i32* [[LOAD]], null
; DEFAULT-NEXT:    ret i1 [[RVAL_2]]
;
; BUNDLES-LABEL: @nonnull3(
; BUNDLES-NEXT:  entry:
; BUNDLES-NEXT:    br i1 [[CONTROL:%.*]], label [[TAKEN:%.*]], label [[NOT_TAKEN:%.*]]
; BUNDLES:       taken:
; BUNDLES-NEXT:    ret i1 false
; BUNDLES:       not_taken:
; BUNDLES-NEXT:    [[LOAD:%.*]] = load i32*, i32** [[A:%.*]], align 8
; BUNDLES-NEXT:    [[RVAL_2:%.*]] = icmp sgt i32* [[LOAD]], null
; BUNDLES-NEXT:    ret i1 [[RVAL_2]]
;
entry:
  %load = load i32*, i32** %a
  %cmp = icmp ne i32* %load, null
  br i1 %control, label %taken, label %not_taken
taken:
  tail call void @llvm.assume(i1 %cmp)
  %rval = icmp eq i32* %load, null
  ret i1 %rval
not_taken:
  %rval.2 = icmp sgt i32* %load, null
  ret i1 %rval.2
}

; Make sure the above canonicalization does not trigger
; if the path from the load to the assume is potentially
; interrupted by an exception being thrown

define i1 @nonnull4(i32** %a) {
; DEFAULT-LABEL: @nonnull4(
; DEFAULT-NEXT:    [[LOAD:%.*]] = load i32*, i32** [[A:%.*]], align 8
; DEFAULT-NEXT:    tail call void @escape(i32* [[LOAD]])
; DEFAULT-NEXT:    [[CMP:%.*]] = icmp ne i32* [[LOAD]], null
; DEFAULT-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; DEFAULT-NEXT:    ret i1 false
;
; BUNDLES-LABEL: @nonnull4(
; BUNDLES-NEXT:    [[LOAD:%.*]] = load i32*, i32** [[A:%.*]], align 8
; BUNDLES-NEXT:    tail call void @escape(i32* [[LOAD]])
; BUNDLES-NEXT:    call void @llvm.assume(i1 true) [ "nonnull"(i32* [[LOAD]]) ]
; BUNDLES-NEXT:    ret i1 false
;
  %load = load i32*, i32** %a
  ;; This call may throw!
  tail call void @escape(i32* %load)
  %cmp = icmp ne i32* %load, null
  tail call void @llvm.assume(i1 %cmp)
  %rval = icmp eq i32* %load, null
  ret i1 %rval
}
define i1 @nonnull5(i32** %a) {
; CHECK-LABEL: @nonnull5(
; CHECK-NEXT:    [[LOAD:%.*]] = load i32*, i32** [[A:%.*]], align 8
; CHECK-NEXT:    tail call void @escape(i32* [[LOAD]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32* [[LOAD]], null
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret i1 false
;
  %load = load i32*, i32** %a
  ;; This call may throw!
  tail call void @escape(i32* %load)
  %integral = ptrtoint i32* %load to i64
  %cmp = icmp slt i64 %integral, 0
  tail call void @llvm.assume(i1 %cmp) ; %load has at least highest bit set
  %rval = icmp eq i32* %load, null
  ret i1 %rval
}

; PR35846 - https://bugs.llvm.org/show_bug.cgi?id=35846

define i32 @assumption_conflicts_with_known_bits(i32 %a, i32 %b) {
; CHECK-LABEL: @assumption_conflicts_with_known_bits(
; CHECK-NEXT:    [[AND1:%.*]] = and i32 [[B:%.*]], 3
; CHECK-NEXT:    tail call void @llvm.assume(i1 false)
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i32 [[AND1]], 0
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP2]])
; CHECK-NEXT:    ret i32 0
;
  %and1 = and i32 %b, 3
  %B1 = lshr i32 %and1, %and1
  %B3 = shl nuw nsw i32 %and1, %B1
  %cmp = icmp eq i32 %B3, 1
  tail call void @llvm.assume(i1 %cmp)
  %cmp2 = icmp eq i32 %B1, %B3
  tail call void @llvm.assume(i1 %cmp2)
  ret i32 %and1
}

; PR37726 - https://bugs.llvm.org/show_bug.cgi?id=37726
; There's a loophole in eliminating a redundant assumption when
; we have conflicting assumptions. Verify that debuginfo doesn't
; get in the way of the fold.

define void @debug_interference(i8 %x) {
; CHECK-LABEL: @debug_interference(
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ne i8 [[X:%.*]], 0
; CHECK-NEXT:    tail call void @llvm.dbg.value(metadata i32 5, metadata [[META7:![0-9]+]], metadata !DIExpression()), !dbg [[DBG9:![0-9]+]]
; CHECK-NEXT:    tail call void @llvm.assume(i1 false)
; CHECK-NEXT:    tail call void @llvm.dbg.value(metadata i32 5, metadata [[META7]], metadata !DIExpression()), !dbg [[DBG9]]
; CHECK-NEXT:    tail call void @llvm.dbg.value(metadata i32 5, metadata [[META7]], metadata !DIExpression()), !dbg [[DBG9]]
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP2]])
; CHECK-NEXT:    ret void
;
  %cmp1 = icmp eq i8 %x, 0
  %cmp2 = icmp ne i8 %x, 0
  tail call void @llvm.assume(i1 %cmp1)
  tail call void @llvm.dbg.value(metadata i32 5, metadata !1, metadata !DIExpression()), !dbg !9
  tail call void @llvm.assume(i1 %cmp1)
  tail call void @llvm.dbg.value(metadata i32 5, metadata !1, metadata !DIExpression()), !dbg !9
  tail call void @llvm.assume(i1 %cmp2)
  tail call void @llvm.dbg.value(metadata i32 5, metadata !1, metadata !DIExpression()), !dbg !9
  tail call void @llvm.assume(i1 %cmp2)
  ret void
}

; This would crash.
; Does it ever make sense to peek through a bitcast of the icmp operand?

define i32 @PR40940(<4 x i8> %x) {
; CHECK-LABEL: @PR40940(
; CHECK-NEXT:    [[SHUF:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> undef, <4 x i32> <i32 1, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[T2:%.*]] = bitcast <4 x i8> [[SHUF]] to i32
; CHECK-NEXT:    [[T3:%.*]] = icmp ult i32 [[T2]], 65536
; CHECK-NEXT:    call void @llvm.assume(i1 [[T3]])
; CHECK-NEXT:    ret i32 [[T2]]
;
  %shuf = shufflevector <4 x i8> %x, <4 x i8> undef, <4 x i32> <i32 1, i32 1, i32 2, i32 3>
  %t2 = bitcast <4 x i8> %shuf to i32
  %t3 = icmp ult i32 %t2, 65536
  call void @llvm.assume(i1 %t3)
  ret i32 %t2
}

define i1 @nonnull3A(i32** %a, i1 %control) {
; DEFAULT-LABEL: @nonnull3A(
; DEFAULT-NEXT:  entry:
; DEFAULT-NEXT:    [[LOAD:%.*]] = load i32*, i32** [[A:%.*]], align 8
; DEFAULT-NEXT:    br i1 [[CONTROL:%.*]], label [[TAKEN:%.*]], label [[NOT_TAKEN:%.*]]
; DEFAULT:       taken:
; DEFAULT-NEXT:    [[CMP:%.*]] = icmp ne i32* [[LOAD]], null
; DEFAULT-NEXT:    call void @llvm.assume(i1 [[CMP]])
; DEFAULT-NEXT:    ret i1 true
; DEFAULT:       not_taken:
; DEFAULT-NEXT:    [[RVAL_2:%.*]] = icmp sgt i32* [[LOAD]], null
; DEFAULT-NEXT:    ret i1 [[RVAL_2]]
;
; BUNDLES-LABEL: @nonnull3A(
; BUNDLES-NEXT:  entry:
; BUNDLES-NEXT:    br i1 [[CONTROL:%.*]], label [[TAKEN:%.*]], label [[NOT_TAKEN:%.*]]
; BUNDLES:       taken:
; BUNDLES-NEXT:    ret i1 true
; BUNDLES:       not_taken:
; BUNDLES-NEXT:    [[LOAD:%.*]] = load i32*, i32** [[A:%.*]], align 8
; BUNDLES-NEXT:    [[RVAL_2:%.*]] = icmp sgt i32* [[LOAD]], null
; BUNDLES-NEXT:    ret i1 [[RVAL_2]]
;
entry:
  %load = load i32*, i32** %a
  %cmp = icmp ne i32* %load, null
  br i1 %control, label %taken, label %not_taken
taken:
  call void @llvm.assume(i1 %cmp)
  ret i1 %cmp
not_taken:
  call void @llvm.assume(i1 %cmp)
  %rval.2 = icmp sgt i32* %load, null
  ret i1 %rval.2
}

define i1 @nonnull3B(i32** %a, i1 %control) {
; CHECK-LABEL: @nonnull3B(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[CONTROL:%.*]], label [[TAKEN:%.*]], label [[NOT_TAKEN:%.*]]
; CHECK:       taken:
; CHECK-NEXT:    [[LOAD:%.*]] = load i32*, i32** [[A:%.*]], align 8
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32* [[LOAD]], null
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]]) [ "nonnull"(i32* [[LOAD]]), "nonnull"(i1 [[CMP]]) ]
; CHECK-NEXT:    ret i1 true
; CHECK:       not_taken:
; CHECK-NEXT:    ret i1 [[CONTROL]]
;
entry:
  %load = load i32*, i32** %a
  %cmp = icmp ne i32* %load, null
  br i1 %control, label %taken, label %not_taken
taken:
  call void @llvm.assume(i1 %cmp) ["nonnull"(i32* %load), "nonnull"(i1 %cmp)]
  ret i1 %cmp
not_taken:
  call void @llvm.assume(i1 %cmp) ["nonnull"(i32* %load), "nonnull"(i1 %cmp)]
  ret i1 %control
}

declare i1 @tmp1(i1)

define i1 @nonnull3C(i32** %a, i1 %control) {
; CHECK-LABEL: @nonnull3C(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[CONTROL:%.*]], label [[TAKEN:%.*]], label [[NOT_TAKEN:%.*]]
; CHECK:       taken:
; CHECK-NEXT:    [[LOAD:%.*]] = load i32*, i32** [[A:%.*]], align 8
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32* [[LOAD]], null
; CHECK-NEXT:    [[CMP2:%.*]] = call i1 @tmp1(i1 [[CMP]])
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i1 [[CMP2]]
; CHECK:       not_taken:
; CHECK-NEXT:    ret i1 [[CONTROL]]
;
entry:
  %load = load i32*, i32** %a
  %cmp = icmp ne i32* %load, null
  br i1 %control, label %taken, label %not_taken
taken:
  %cmp2 = call i1 @tmp1(i1 %cmp)
  br label %exit
exit:
  ; FIXME: this shouldn't be dropped because it is still dominated by the new position of %load
  call void @llvm.assume(i1 %cmp) ["nonnull"(i32* %load), "nonnull"(i1 %cmp)]
  ret i1 %cmp2
not_taken:
  call void @llvm.assume(i1 %cmp)
  ret i1 %control
}

define i1 @nonnull3D(i32** %a, i1 %control) {
; CHECK-LABEL: @nonnull3D(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[CONTROL:%.*]], label [[TAKEN:%.*]], label [[NOT_TAKEN:%.*]]
; CHECK:       taken:
; CHECK-NEXT:    [[LOAD:%.*]] = load i32*, i32** [[A:%.*]], align 8
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32* [[LOAD]], null
; CHECK-NEXT:    [[CMP2:%.*]] = call i1 @tmp1(i1 [[CMP]])
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i1 [[CMP2]]
; CHECK:       not_taken:
; CHECK-NEXT:    call void @llvm.assume(i1 true) [ "ignore"(i32* undef), "ignore"(i1 undef), "nonnull"(i1 [[CONTROL]]) ]
; CHECK-NEXT:    ret i1 [[CONTROL]]
;
entry:
  %load = load i32*, i32** %a
  %cmp = icmp ne i32* %load, null
  br i1 %control, label %taken, label %not_taken
taken:
  %cmp2 = call i1 @tmp1(i1 %cmp)
  br label %exit
exit:
  ret i1 %cmp2
not_taken:
  call void @llvm.assume(i1 %cmp) ["nonnull"(i32* %load), "nonnull"(i1 %cmp), "nonnull"(i1 %control)]
  ret i1 %control
}


define void @always_true_assumption() {
; CHECK-LABEL: @always_true_assumption(
; CHECK-NEXT:    ret void
;
  call void @llvm.assume(i1 true)
  ret void
}

; The alloca guarantees that the low bits of %a are zero because of alignment.
; The assume says the opposite. Make sure we don't crash.

define i64 @PR31809() {
; CHECK-LABEL: @PR31809(
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[T1:%.*]] = ptrtoint i32* [[A]] to i64
; CHECK-NEXT:    call void @llvm.assume(i1 false)
; CHECK-NEXT:    ret i64 [[T1]]
;
  %a = alloca i32
  %t1 = ptrtoint i32* %a to i64
  %cond = icmp eq i64 %t1, 3
  call void @llvm.assume(i1 %cond)
  ret i64 %t1
}

; Similar to above: there's no way to know which assumption is truthful,
; so just don't crash.

define i8 @conflicting_assumptions(i8 %x){
; CHECK-LABEL: @conflicting_assumptions(
; CHECK-NEXT:    call void @llvm.assume(i1 false)
; CHECK-NEXT:    [[COND2:%.*]] = icmp eq i8 [[X:%.*]], 4
; CHECK-NEXT:    call void @llvm.assume(i1 [[COND2]])
; CHECK-NEXT:    ret i8 5
;
  %add = add i8 %x, 1
  %cond1 = icmp eq i8 %x, 3
  call void @llvm.assume(i1 %cond1)
  %cond2 = icmp eq i8 %x, 4
  call void @llvm.assume(i1 %cond2)
  ret i8 %add
}

; Another case of conflicting assumptions. This would crash because we'd
; try to set more known bits than existed in the known bits struct.

define void @PR36270(i32 %b) {
; CHECK-LABEL: @PR36270(
; CHECK-NEXT:    unreachable
;
  %B7 = xor i32 -1, 2147483647
  %and1 = and i32 %b, 3
  %B12 = lshr i32 %B7, %and1
  %C1 = icmp ult i32 %and1, %B12
  tail call void @llvm.assume(i1 %C1)
  %cmp2 = icmp eq i32 0, %B12
  tail call void @llvm.assume(i1 %cmp2)
  unreachable
}

; PR47416

define i32 @unreachable_assume(i32 %x, i32 %y) {
; CHECK-LABEL: @unreachable_assume(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sgt i32 [[X:%.*]], 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[Y:%.*]], 1
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[CMP0]], [[CMP1]]
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[OR]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i32 [[X]], 1
; CHECK-NEXT:    br i1 [[CMP2]], label [[IF:%.*]], label [[EXIT:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[A:%.*]] = and i32 [[Y]], -2
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ne i32 [[A]], 104
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP3]])
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    unreachable
;
entry:
  %cmp0 = icmp sgt i32 %x, 1
  %cmp1 = icmp eq i32 %y, 1
  %or = or i1 %cmp0, %cmp1
  tail call void @llvm.assume(i1 %or)
  %cmp2 = icmp eq i32 %x, 1
  br i1 %cmp2, label %if, label %exit

if:
  %a = and i32 %y, -2
  %cmp3 = icmp ne i32 %a, 104
  tail call void @llvm.assume(i1 %cmp3)
  br label %exit

exit:
  %cmp4 = icmp eq i32 %x, 2
  tail call void @llvm.assume(i1 %cmp4)
  unreachable
}

define i32 @unreachable_assume_logical(i32 %x, i32 %y) {
; CHECK-LABEL: @unreachable_assume_logical(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sgt i32 [[X:%.*]], 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[Y:%.*]], 1
; CHECK-NEXT:    [[OR:%.*]] = select i1 [[CMP0]], i1 true, i1 [[CMP1]]
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[OR]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i32 [[X]], 1
; CHECK-NEXT:    br i1 [[CMP2]], label [[IF:%.*]], label [[EXIT:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[A:%.*]] = and i32 [[Y]], -2
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ne i32 [[A]], 104
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP3]])
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    unreachable
;
entry:
  %cmp0 = icmp sgt i32 %x, 1
  %cmp1 = icmp eq i32 %y, 1
  %or = select i1 %cmp0, i1 true, i1 %cmp1
  tail call void @llvm.assume(i1 %or)
  %cmp2 = icmp eq i32 %x, 1
  br i1 %cmp2, label %if, label %exit

if:
  %a = and i32 %y, -2
  %cmp3 = icmp ne i32 %a, 104
  tail call void @llvm.assume(i1 %cmp3)
  br label %exit

exit:
  %cmp4 = icmp eq i32 %x, 2
  tail call void @llvm.assume(i1 %cmp4)
  unreachable
}

define i32 @unreachable_assumes_and_store(i32 %x, i32 %y, i32* %p) {
; CHECK-LABEL: @unreachable_assumes_and_store(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sgt i32 [[X:%.*]], 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[Y:%.*]], 1
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[CMP0]], [[CMP1]]
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[OR]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i32 [[X]], 1
; CHECK-NEXT:    br i1 [[CMP2]], label [[IF:%.*]], label [[EXIT:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[A:%.*]] = and i32 [[Y]], -2
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ne i32 [[A]], 104
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP3]])
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    unreachable
;
entry:
  %cmp0 = icmp sgt i32 %x, 1
  %cmp1 = icmp eq i32 %y, 1
  %or = or i1 %cmp0, %cmp1
  tail call void @llvm.assume(i1 %or)
  %cmp2 = icmp eq i32 %x, 1
  br i1 %cmp2, label %if, label %exit

if:
  %a = and i32 %y, -2
  %cmp3 = icmp ne i32 %a, 104
  tail call void @llvm.assume(i1 %cmp3)
  br label %exit

exit:
  %cmp4 = icmp eq i32 %x, 2
  tail call void @llvm.assume(i1 %cmp4)
  %cmp5 = icmp ugt i32 %y, 42
  tail call void @llvm.assume(i1 %cmp5)
  store i32 %x, i32* %p
  unreachable
}

define i32 @unreachable_assumes_and_store_logical(i32 %x, i32 %y, i32* %p) {
; CHECK-LABEL: @unreachable_assumes_and_store_logical(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP0:%.*]] = icmp sgt i32 [[X:%.*]], 1
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[Y:%.*]], 1
; CHECK-NEXT:    [[OR:%.*]] = select i1 [[CMP0]], i1 true, i1 [[CMP1]]
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[OR]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i32 [[X]], 1
; CHECK-NEXT:    br i1 [[CMP2]], label [[IF:%.*]], label [[EXIT:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[A:%.*]] = and i32 [[Y]], -2
; CHECK-NEXT:    [[CMP3:%.*]] = icmp ne i32 [[A]], 104
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP3]])
; CHECK-NEXT:    br label [[EXIT]]
; CHECK:       exit:
; CHECK-NEXT:    unreachable
;
entry:
  %cmp0 = icmp sgt i32 %x, 1
  %cmp1 = icmp eq i32 %y, 1
  %or = select i1 %cmp0, i1 true, i1 %cmp1
  tail call void @llvm.assume(i1 %or)
  %cmp2 = icmp eq i32 %x, 1
  br i1 %cmp2, label %if, label %exit

if:
  %a = and i32 %y, -2
  %cmp3 = icmp ne i32 %a, 104
  tail call void @llvm.assume(i1 %cmp3)
  br label %exit

exit:
  %cmp4 = icmp eq i32 %x, 2
  tail call void @llvm.assume(i1 %cmp4)
  %cmp5 = icmp ugt i32 %y, 42
  tail call void @llvm.assume(i1 %cmp5)
  store i32 %x, i32* %p
  unreachable
}

define void @canonicalize_assume(i32* %0) {
; DEFAULT-LABEL: @canonicalize_assume(
; DEFAULT-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i32, i32* [[TMP0:%.*]], i64 2
; DEFAULT-NEXT:    [[TMP3:%.*]] = bitcast i32* [[TMP2]] to i8*
; DEFAULT-NEXT:    call void @llvm.assume(i1 true) [ "align"(i8* [[TMP3]], i64 16) ]
; DEFAULT-NEXT:    ret void
;
; BUNDLES-LABEL: @canonicalize_assume(
; BUNDLES-NEXT:    call void @llvm.assume(i1 true) [ "align"(i32* [[TMP0:%.*]], i64 8) ]
; BUNDLES-NEXT:    ret void
;
  %2 = getelementptr inbounds i32, i32* %0, i64 2
  %3 = bitcast i32* %2 to i8*
  call void @llvm.assume(i1 true) [ "align"(i8* %3, i64 16) ]
  ret void
}

declare void @llvm.dbg.value(metadata, metadata, metadata)

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7, !8}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !3, producer: "Me", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: null, retainedTypes: null, imports: null)
!1 = !DILocalVariable(name: "", arg: 1, scope: !2, file: null, line: 1, type: null)
!2 = distinct !DISubprogram(name: "debug", linkageName: "debug", scope: null, file: null, line: 0, type: null, isLocal: false, isDefinition: true, scopeLine: 1, flags: DIFlagPrototyped, isOptimized: true, unit: !0)
!3 = !DIFile(filename: "consecutive-fences.ll", directory: "")
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{i32 7, !"PIC Level", i32 2}
!9 = !DILocation(line: 0, column: 0, scope: !2)


attributes #0 = { nounwind uwtable }
attributes #1 = { nounwind }

