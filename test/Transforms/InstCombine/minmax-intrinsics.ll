; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

declare i8 @llvm.umin.i8(i8, i8)
declare i8 @llvm.umax.i8(i8, i8)
declare i8 @llvm.smin.i8(i8, i8)
declare i8 @llvm.smax.i8(i8, i8)
declare <3 x i8> @llvm.umin.v3i8(<3 x i8>, <3 x i8>)
declare <3 x i8> @llvm.umax.v3i8(<3 x i8>, <3 x i8>)
declare <3 x i8> @llvm.smin.v3i8(<3 x i8>, <3 x i8>)
declare void @use(i8)

define i8 @umin_known_bits(i8 %x, i8 %y) {
; CHECK-LABEL: @umin_known_bits(
; CHECK-NEXT:    ret i8 0
;
  %x2 = and i8 %x, 127
  %m = call i8 @llvm.umin.i8(i8 %x2, i8 %y)
  %r = and i8 %m, -128
  ret i8 %r
}

define i8 @umax_known_bits(i8 %x, i8 %y) {
; CHECK-LABEL: @umax_known_bits(
; CHECK-NEXT:    ret i8 -128
;
  %x2 = or i8 %x, -128
  %m = call i8 @llvm.umax.i8(i8 %x2, i8 %y)
  %r = and i8 %m, -128
  ret i8 %r
}

define i8 @smin_known_bits(i8 %x, i8 %y) {
; CHECK-LABEL: @smin_known_bits(
; CHECK-NEXT:    ret i8 -128
;
  %x2 = or i8 %x, -128
  %m = call i8 @llvm.smin.i8(i8 %x2, i8 %y)
  %r = and i8 %m, -128
  ret i8 %r
}

define i8 @smax_known_bits(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_known_bits(
; CHECK-NEXT:    ret i8 0
;
  %x2 = and i8 %x, 127
  %m = call i8 @llvm.smax.i8(i8 %x2, i8 %y)
  %r = and i8 %m, -128
  ret i8 %r
}

define i8 @smax_sext(i5 %x, i5 %y) {
; CHECK-LABEL: @smax_sext(
; CHECK-NEXT:    [[TMP1:%.*]] = call i5 @llvm.smax.i5(i5 [[X:%.*]], i5 [[Y:%.*]])
; CHECK-NEXT:    [[M:%.*]] = sext i5 [[TMP1]] to i8
; CHECK-NEXT:    ret i8 [[M]]
;
  %sx = sext i5 %x to i8
  %sy = sext i5 %y to i8
  %m = call i8 @llvm.smax.i8(i8 %sx, i8 %sy)
  ret i8 %m
}

; Extra use is ok.

define i8 @smin_sext(i5 %x, i5 %y) {
; CHECK-LABEL: @smin_sext(
; CHECK-NEXT:    [[SY:%.*]] = sext i5 [[Y:%.*]] to i8
; CHECK-NEXT:    call void @use(i8 [[SY]])
; CHECK-NEXT:    [[TMP1:%.*]] = call i5 @llvm.smin.i5(i5 [[X:%.*]], i5 [[Y]])
; CHECK-NEXT:    [[M:%.*]] = sext i5 [[TMP1]] to i8
; CHECK-NEXT:    ret i8 [[M]]
;
  %sx = sext i5 %x to i8
  %sy = sext i5 %y to i8
  call void @use(i8 %sy)
  %m = call i8 @llvm.smin.i8(i8 %sx, i8 %sy)
  ret i8 %m
}

; Sext doesn't change unsigned min/max comparison of narrow values.

define i8 @umax_sext(i5 %x, i5 %y) {
; CHECK-LABEL: @umax_sext(
; CHECK-NEXT:    [[SX:%.*]] = sext i5 [[X:%.*]] to i8
; CHECK-NEXT:    call void @use(i8 [[SX]])
; CHECK-NEXT:    [[TMP1:%.*]] = call i5 @llvm.umax.i5(i5 [[X]], i5 [[Y:%.*]])
; CHECK-NEXT:    [[M:%.*]] = sext i5 [[TMP1]] to i8
; CHECK-NEXT:    ret i8 [[M]]
;
  %sx = sext i5 %x to i8
  call void @use(i8 %sx)
  %sy = sext i5 %y to i8
  %m = call i8 @llvm.umax.i8(i8 %sx, i8 %sy)
  ret i8 %m
}

define <3 x i8> @umin_sext(<3 x i5> %x, <3 x i5> %y) {
; CHECK-LABEL: @umin_sext(
; CHECK-NEXT:    [[TMP1:%.*]] = call <3 x i5> @llvm.umin.v3i5(<3 x i5> [[X:%.*]], <3 x i5> [[Y:%.*]])
; CHECK-NEXT:    [[M:%.*]] = sext <3 x i5> [[TMP1]] to <3 x i8>
; CHECK-NEXT:    ret <3 x i8> [[M]]
;
  %sx = sext <3 x i5> %x to <3 x i8>
  %sy = sext <3 x i5> %y to <3 x i8>
  %m = call <3 x i8> @llvm.umin.v3i8(<3 x i8> %sx, <3 x i8> %sy)
  ret <3 x i8> %m
}

; Negative test - zext may change sign of inputs

define i8 @smax_zext(i5 %x, i5 %y) {
; CHECK-LABEL: @smax_zext(
; CHECK-NEXT:    [[ZX:%.*]] = zext i5 [[X:%.*]] to i8
; CHECK-NEXT:    [[ZY:%.*]] = zext i5 [[Y:%.*]] to i8
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smax.i8(i8 [[ZX]], i8 [[ZY]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %zx = zext i5 %x to i8
  %zy = zext i5 %y to i8
  %m = call i8 @llvm.smax.i8(i8 %zx, i8 %zy)
  ret i8 %m
}

; Negative test - zext may change sign of inputs

define i8 @smin_zext(i5 %x, i5 %y) {
; CHECK-LABEL: @smin_zext(
; CHECK-NEXT:    [[ZX:%.*]] = zext i5 [[X:%.*]] to i8
; CHECK-NEXT:    [[ZY:%.*]] = zext i5 [[Y:%.*]] to i8
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smin.i8(i8 [[ZX]], i8 [[ZY]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %zx = zext i5 %x to i8
  %zy = zext i5 %y to i8
  %m = call i8 @llvm.smin.i8(i8 %zx, i8 %zy)
  ret i8 %m
}

define i8 @umax_zext(i5 %x, i5 %y) {
; CHECK-LABEL: @umax_zext(
; CHECK-NEXT:    [[TMP1:%.*]] = call i5 @llvm.umax.i5(i5 [[X:%.*]], i5 [[Y:%.*]])
; CHECK-NEXT:    [[M:%.*]] = zext i5 [[TMP1]] to i8
; CHECK-NEXT:    ret i8 [[M]]
;
  %zx = zext i5 %x to i8
  %zy = zext i5 %y to i8
  %m = call i8 @llvm.umax.i8(i8 %zx, i8 %zy)
  ret i8 %m
}

define i8 @umin_zext(i5 %x, i5 %y) {
; CHECK-LABEL: @umin_zext(
; CHECK-NEXT:    [[TMP1:%.*]] = call i5 @llvm.umin.i5(i5 [[X:%.*]], i5 [[Y:%.*]])
; CHECK-NEXT:    [[M:%.*]] = zext i5 [[TMP1]] to i8
; CHECK-NEXT:    ret i8 [[M]]
;
  %zx = zext i5 %x to i8
  %zy = zext i5 %y to i8
  %m = call i8 @llvm.umin.i8(i8 %zx, i8 %zy)
  ret i8 %m
}

; Negative test - mismatched types

define i8 @umin_zext_types(i6 %x, i5 %y) {
; CHECK-LABEL: @umin_zext_types(
; CHECK-NEXT:    [[ZX:%.*]] = zext i6 [[X:%.*]] to i8
; CHECK-NEXT:    [[ZY:%.*]] = zext i5 [[Y:%.*]] to i8
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[ZX]], i8 [[ZY]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %zx = zext i6 %x to i8
  %zy = zext i5 %y to i8
  %m = call i8 @llvm.umin.i8(i8 %zx, i8 %zy)
  ret i8 %m
}

; Negative test - mismatched extends

define i8 @umin_ext(i5 %x, i5 %y) {
; CHECK-LABEL: @umin_ext(
; CHECK-NEXT:    [[SX:%.*]] = sext i5 [[X:%.*]] to i8
; CHECK-NEXT:    [[ZY:%.*]] = zext i5 [[Y:%.*]] to i8
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[SX]], i8 [[ZY]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %sx = sext i5 %x to i8
  %zy = zext i5 %y to i8
  %m = call i8 @llvm.umin.i8(i8 %sx, i8 %zy)
  ret i8 %m
}

; Negative test - too many uses.

define i8 @umin_zext_uses(i5 %x, i5 %y) {
; CHECK-LABEL: @umin_zext_uses(
; CHECK-NEXT:    [[ZX:%.*]] = zext i5 [[X:%.*]] to i8
; CHECK-NEXT:    call void @use(i8 [[ZX]])
; CHECK-NEXT:    [[ZY:%.*]] = zext i5 [[Y:%.*]] to i8
; CHECK-NEXT:    call void @use(i8 [[ZY]])
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[ZX]], i8 [[ZY]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %zx = zext i5 %x to i8
  call void @use(i8 %zx)
  %zy = zext i5 %y to i8
  call void @use(i8 %zy)
  %m = call i8 @llvm.umin.i8(i8 %zx, i8 %zy)
  ret i8 %m
}

define i8 @smax_sext_constant(i5 %x) {
; CHECK-LABEL: @smax_sext_constant(
; CHECK-NEXT:    [[TMP1:%.*]] = call i5 @llvm.smax.i5(i5 [[X:%.*]], i5 7)
; CHECK-NEXT:    [[M:%.*]] = zext i5 [[TMP1]] to i8
; CHECK-NEXT:    ret i8 [[M]]
;
  %e = sext i5 %x to i8
  %m = call i8 @llvm.smax.i8(i8 %e, i8 7)
  ret i8 %m
}

; simplifies

define i8 @smax_sext_constant_big(i5 %x) {
; CHECK-LABEL: @smax_sext_constant_big(
; CHECK-NEXT:    ret i8 16
;
  %e = sext i5 %x to i8
  %m = call i8 @llvm.smax.i8(i8 %e, i8 16)
  ret i8 %m
}

; negative test

define i8 @smax_zext_constant(i5 %x) {
; CHECK-LABEL: @smax_zext_constant(
; CHECK-NEXT:    [[E:%.*]] = zext i5 [[X:%.*]] to i8
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smax.i8(i8 [[E]], i8 7)
; CHECK-NEXT:    ret i8 [[M]]
;
  %e = zext i5 %x to i8
  %m = call i8 @llvm.smax.i8(i8 %e, i8 7)
  ret i8 %m
}

define <3 x i8> @smin_sext_constant(<3 x i5> %x) {
; CHECK-LABEL: @smin_sext_constant(
; CHECK-NEXT:    [[TMP1:%.*]] = call <3 x i5> @llvm.smin.v3i5(<3 x i5> [[X:%.*]], <3 x i5> <i5 7, i5 15, i5 -16>)
; CHECK-NEXT:    [[M:%.*]] = sext <3 x i5> [[TMP1]] to <3 x i8>
; CHECK-NEXT:    ret <3 x i8> [[M]]
;
  %e = sext <3 x i5> %x to <3 x i8>
  %m = call <3 x i8> @llvm.smin.v3i8(<3 x i8> %e, <3 x i8> <i8 7, i8 15, i8 -16>)
  ret <3 x i8> %m
}

; negative test

define i8 @smin_zext_constant(i5 %x) {
; CHECK-LABEL: @smin_zext_constant(
; CHECK-NEXT:    [[E:%.*]] = zext i5 [[X:%.*]] to i8
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smin.i8(i8 [[E]], i8 7)
; CHECK-NEXT:    ret i8 [[M]]
;
  %e = zext i5 %x to i8
  %m = call i8 @llvm.smin.i8(i8 %e, i8 7)
  ret i8 %m
}

define i8 @umax_sext_constant(i5 %x) {
; CHECK-LABEL: @umax_sext_constant(
; CHECK-NEXT:    [[TMP1:%.*]] = call i5 @llvm.umax.i5(i5 [[X:%.*]], i5 7)
; CHECK-NEXT:    [[M:%.*]] = sext i5 [[TMP1]] to i8
; CHECK-NEXT:    ret i8 [[M]]
;
  %e = sext i5 %x to i8
  %m = call i8 @llvm.umax.i8(i8 %e, i8 7)
  ret i8 %m
}

; negative test

define i8 @umax_sext_constant_big(i5 %x) {
; CHECK-LABEL: @umax_sext_constant_big(
; CHECK-NEXT:    [[E:%.*]] = sext i5 [[X:%.*]] to i8
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umax.i8(i8 [[E]], i8 126)
; CHECK-NEXT:    ret i8 [[M]]
;
  %e = sext i5 %x to i8
  %m = call i8 @llvm.umax.i8(i8 %e, i8 126)
  ret i8 %m
}

define <3 x i8> @umax_zext_constant(<3 x i5> %x) {
; CHECK-LABEL: @umax_zext_constant(
; CHECK-NEXT:    [[TMP1:%.*]] = call <3 x i5> @llvm.umax.v3i5(<3 x i5> [[X:%.*]], <3 x i5> <i5 7, i5 15, i5 -1>)
; CHECK-NEXT:    [[M:%.*]] = zext <3 x i5> [[TMP1]] to <3 x i8>
; CHECK-NEXT:    ret <3 x i8> [[M]]
;
  %e = zext <3 x i5> %x to <3 x i8>
  %m = call <3 x i8> @llvm.umax.v3i8(<3 x i8> %e, <3 x i8> <i8 7, i8 15, i8 31>)
  ret <3 x i8> %m
}

; simplifies

define i8 @umax_zext_constant_big(i5 %x) {
; CHECK-LABEL: @umax_zext_constant_big(
; CHECK-NEXT:    ret i8 126
;
  %e = zext i5 %x to i8
  %m = call i8 @llvm.umax.i8(i8 %e, i8 126)
  ret i8 %m
}

define i8 @umin_sext_constant(i5 %x) {
; CHECK-LABEL: @umin_sext_constant(
; CHECK-NEXT:    [[TMP1:%.*]] = call i5 @llvm.umin.i5(i5 [[X:%.*]], i5 7)
; CHECK-NEXT:    [[M:%.*]] = zext i5 [[TMP1]] to i8
; CHECK-NEXT:    ret i8 [[M]]
;
  %e = sext i5 %x to i8
  %m = call i8 @llvm.umin.i8(i8 %e, i8 7)
  ret i8 %m
}

; negative test

define i8 @umin_sext_constant_big(i5 %x) {
; CHECK-LABEL: @umin_sext_constant_big(
; CHECK-NEXT:    [[E:%.*]] = sext i5 [[X:%.*]] to i8
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[E]], i8 126)
; CHECK-NEXT:    ret i8 [[M]]
;
  %e = sext i5 %x to i8
  %m = call i8 @llvm.umin.i8(i8 %e, i8 126)
  ret i8 %m
}

define i8 @umin_zext_constant(i5 %x) {
; CHECK-LABEL: @umin_zext_constant(
; CHECK-NEXT:    [[TMP1:%.*]] = call i5 @llvm.umin.i5(i5 [[X:%.*]], i5 7)
; CHECK-NEXT:    [[M:%.*]] = zext i5 [[TMP1]] to i8
; CHECK-NEXT:    ret i8 [[M]]
;
  %e = zext i5 %x to i8
  %m = call i8 @llvm.umin.i8(i8 %e, i8 7)
  ret i8 %m
}

; simplifies

define i8 @umin_zext_constant_big(i5 %x) {
; CHECK-LABEL: @umin_zext_constant_big(
; CHECK-NEXT:    [[E:%.*]] = zext i5 [[X:%.*]] to i8
; CHECK-NEXT:    ret i8 [[E]]
;
  %e = zext i5 %x to i8
  %m = call i8 @llvm.umin.i8(i8 %e, i8 126)
  ret i8 %m
}

; negative test

define i8 @umin_zext_constanti_uses(i5 %x) {
; CHECK-LABEL: @umin_zext_constanti_uses(
; CHECK-NEXT:    [[E:%.*]] = zext i5 [[X:%.*]] to i8
; CHECK-NEXT:    call void @use(i8 [[E]])
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[E]], i8 7)
; CHECK-NEXT:    ret i8 [[M]]
;
  %e = zext i5 %x to i8
  call void @use(i8 %e)
  %m = call i8 @llvm.umin.i8(i8 %e, i8 7)
  ret i8 %m
}

define i8 @smax_of_nots(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_of_nots(
; CHECK-NEXT:    [[TMP1:%.*]] = call i8 @llvm.smin.i8(i8 [[X:%.*]], i8 [[Y:%.*]])
; CHECK-NEXT:    [[M:%.*]] = xor i8 [[TMP1]], -1
; CHECK-NEXT:    ret i8 [[M]]
;
  %notx = xor i8 %x, -1
  %noty = xor i8 %y, -1
  %m = call i8 @llvm.smax.i8(i8 %notx, i8 %noty)
  ret i8 %m
}

; Vectors are ok (including undef lanes of not ops)

define <3 x i8> @smin_of_nots(<3 x i8> %x, <3 x i8> %y) {
; CHECK-LABEL: @smin_of_nots(
; CHECK-NEXT:    [[TMP1:%.*]] = call <3 x i8> @llvm.smax.v3i8(<3 x i8> [[X:%.*]], <3 x i8> [[Y:%.*]])
; CHECK-NEXT:    [[M:%.*]] = xor <3 x i8> [[TMP1]], <i8 -1, i8 -1, i8 -1>
; CHECK-NEXT:    ret <3 x i8> [[M]]
;
  %notx = xor <3 x i8> %x, <i8 -1, i8 undef, i8 -1>
  %noty = xor <3 x i8> %y, <i8 -1, i8 -1, i8 undef>
  %m = call <3 x i8> @llvm.smin.v3i8(<3 x i8> %notx, <3 x i8> %noty)
  ret <3 x i8> %m
}

; An extra use is ok.

define i8 @umax_of_nots(i8 %x, i8 %y) {
; CHECK-LABEL: @umax_of_nots(
; CHECK-NEXT:    [[NOTX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use(i8 [[NOTX]])
; CHECK-NEXT:    [[TMP1:%.*]] = call i8 @llvm.umin.i8(i8 [[X]], i8 [[Y:%.*]])
; CHECK-NEXT:    [[M:%.*]] = xor i8 [[TMP1]], -1
; CHECK-NEXT:    ret i8 [[M]]
;
  %notx = xor i8 %x, -1
  call void @use(i8 %notx)
  %noty = xor i8 %y, -1
  %m = call i8 @llvm.umax.i8(i8 %notx, i8 %noty)
  ret i8 %m
}

; An extra use is ok.

define i8 @umin_of_nots(i8 %x, i8 %y) {
; CHECK-LABEL: @umin_of_nots(
; CHECK-NEXT:    [[NOTY:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    call void @use(i8 [[NOTY]])
; CHECK-NEXT:    [[TMP1:%.*]] = call i8 @llvm.umax.i8(i8 [[X:%.*]], i8 [[Y]])
; CHECK-NEXT:    [[M:%.*]] = xor i8 [[TMP1]], -1
; CHECK-NEXT:    ret i8 [[M]]
;
  %notx = xor i8 %x, -1
  %noty = xor i8 %y, -1
  call void @use(i8 %noty)
  %m = call i8 @llvm.umin.i8(i8 %notx, i8 %noty)
  ret i8 %m
}

; Negative test - too many uses

define i8 @umin_of_nots_uses(i8 %x, i8 %y) {
; CHECK-LABEL: @umin_of_nots_uses(
; CHECK-NEXT:    [[NOTX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use(i8 [[NOTX]])
; CHECK-NEXT:    [[NOTY:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    call void @use(i8 [[NOTY]])
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[NOTX]], i8 [[NOTY]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %notx = xor i8 %x, -1
  call void @use(i8 %notx)
  %noty = xor i8 %y, -1
  call void @use(i8 %noty)
  %m = call i8 @llvm.umin.i8(i8 %notx, i8 %noty)
  ret i8 %m
}

define i8 @smax_of_not_and_const(i8 %x) {
; CHECK-LABEL: @smax_of_not_and_const(
; CHECK-NEXT:    [[NOTX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smax.i8(i8 [[NOTX]], i8 42)
; CHECK-NEXT:    ret i8 [[M]]
;
  %notx = xor i8 %x, -1
  %m = call i8 @llvm.smax.i8(i8 %notx, i8 42)
  ret i8 %m
}

define <3 x i8> @smin_of_not_and_const(<3 x i8> %x) {
; CHECK-LABEL: @smin_of_not_and_const(
; CHECK-NEXT:    [[NOTX:%.*]] = xor <3 x i8> [[X:%.*]], <i8 -1, i8 -1, i8 undef>
; CHECK-NEXT:    [[M:%.*]] = call <3 x i8> @llvm.smin.v3i8(<3 x i8> [[NOTX]], <3 x i8> <i8 42, i8 undef, i8 43>)
; CHECK-NEXT:    ret <3 x i8> [[M]]
;
  %notx = xor <3 x i8> %x, <i8 -1, i8 -1, i8 undef>
  %m = call <3 x i8> @llvm.smin.v3i8(<3 x i8> <i8 42, i8 undef, i8 43>, <3 x i8> %notx)
  ret <3 x i8> %m
}

define i8 @umax_of_not_and_const(i8 %x) {
; CHECK-LABEL: @umax_of_not_and_const(
; CHECK-NEXT:    [[NOTX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umax.i8(i8 [[NOTX]], i8 44)
; CHECK-NEXT:    ret i8 [[M]]
;
  %notx = xor i8 %x, -1
  %m = call i8 @llvm.umax.i8(i8 %notx, i8 44)
  ret i8 %m
}

define i8 @umin_of_not_and_const(i8 %x) {
; CHECK-LABEL: @umin_of_not_and_const(
; CHECK-NEXT:    [[NOTX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[NOTX]], i8 -45)
; CHECK-NEXT:    ret i8 [[M]]
;
  %notx = xor i8 %x, -1
  %m = call i8 @llvm.umin.i8(i8 -45, i8 %notx)
  ret i8 %m
}

define i8 @umin_of_not_and_const_uses(i8 %x) {
; CHECK-LABEL: @umin_of_not_and_const_uses(
; CHECK-NEXT:    [[NOTX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use(i8 [[NOTX]])
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[NOTX]], i8 -45)
; CHECK-NEXT:    ret i8 [[M]]
;
  %notx = xor i8 %x, -1
  call void @use(i8 %notx)
  %m = call i8 @llvm.umin.i8(i8 -45, i8 %notx)
  ret i8 %m
}
