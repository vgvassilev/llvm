; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

define i32 @zero_dividend(i32 %A) {
; CHECK-LABEL: @zero_dividend(
; CHECK-NEXT:    ret i32 0
;
  %B = sdiv i32 0, %A
  ret i32 %B
}

define <2 x i32> @zero_dividend_vector(<2 x i32> %A) {
; CHECK-LABEL: @zero_dividend_vector(
; CHECK-NEXT:    ret <2 x i32> zeroinitializer
;
  %B = udiv <2 x i32> zeroinitializer, %A
  ret <2 x i32> %B
}

define <2 x i32> @zero_dividend_vector_undef_elt(<2 x i32> %A) {
; CHECK-LABEL: @zero_dividend_vector_undef_elt(
; CHECK-NEXT:    ret <2 x i32> zeroinitializer
;
  %B = sdiv <2 x i32> <i32 0, i32 undef>, %A
  ret <2 x i32> %B
}

; Division-by-zero is undef. UB in any vector lane means the whole op is undef.

define <2 x i8> @sdiv_zero_elt_vec_constfold(<2 x i8> %x) {
; CHECK-LABEL: @sdiv_zero_elt_vec_constfold(
; CHECK-NEXT:    ret <2 x i8> undef
;
  %div = sdiv <2 x i8> <i8 1, i8 2>, <i8 0, i8 -42>
  ret <2 x i8> %div
}

define <2 x i8> @udiv_zero_elt_vec_constfold(<2 x i8> %x) {
; CHECK-LABEL: @udiv_zero_elt_vec_constfold(
; CHECK-NEXT:    ret <2 x i8> undef
;
  %div = udiv <2 x i8> <i8 1, i8 2>, <i8 42, i8 0>
  ret <2 x i8> %div
}

define <2 x i8> @sdiv_zero_elt_vec(<2 x i8> %x) {
; CHECK-LABEL: @sdiv_zero_elt_vec(
; CHECK-NEXT:    ret <2 x i8> poison
;
  %div = sdiv <2 x i8> %x, <i8 -42, i8 0>
  ret <2 x i8> %div
}

define <2 x i8> @udiv_zero_elt_vec(<2 x i8> %x) {
; CHECK-LABEL: @udiv_zero_elt_vec(
; CHECK-NEXT:    ret <2 x i8> poison
;
  %div = udiv <2 x i8> %x, <i8 0, i8 42>
  ret <2 x i8> %div
}

define <2 x i8> @sdiv_undef_elt_vec(<2 x i8> %x) {
; CHECK-LABEL: @sdiv_undef_elt_vec(
; CHECK-NEXT:    ret <2 x i8> poison
;
  %div = sdiv <2 x i8> %x, <i8 -42, i8 undef>
  ret <2 x i8> %div
}

define <2 x i8> @udiv_undef_elt_vec(<2 x i8> %x) {
; CHECK-LABEL: @udiv_undef_elt_vec(
; CHECK-NEXT:    ret <2 x i8> poison
;
  %div = udiv <2 x i8> %x, <i8 undef, i8 42>
  ret <2 x i8> %div
}

; Division-by-zero is undef. UB in any vector lane means the whole op is undef.
; Thus, we can simplify this: if any element of 'y' is 0, we can do anything.
; Therefore, assume that all elements of 'y' must be 1.

define <2 x i1> @sdiv_bool_vec(<2 x i1> %x, <2 x i1> %y) {
; CHECK-LABEL: @sdiv_bool_vec(
; CHECK-NEXT:    ret <2 x i1> [[X:%.*]]
;
  %div = sdiv <2 x i1> %x, %y
  ret <2 x i1> %div
}

define <2 x i1> @udiv_bool_vec(<2 x i1> %x, <2 x i1> %y) {
; CHECK-LABEL: @udiv_bool_vec(
; CHECK-NEXT:    ret <2 x i1> [[X:%.*]]
;
  %div = udiv <2 x i1> %x, %y
  ret <2 x i1> %div
}

define i32 @zext_bool_udiv_divisor(i1 %x, i32 %y) {
; CHECK-LABEL: @zext_bool_udiv_divisor(
; CHECK-NEXT:    ret i32 [[Y:%.*]]
;
  %ext = zext i1 %x to i32
  %r = udiv i32 %y, %ext
  ret i32 %r
}

define <2 x i32> @zext_bool_sdiv_divisor_vec(<2 x i1> %x, <2 x i32> %y) {
; CHECK-LABEL: @zext_bool_sdiv_divisor_vec(
; CHECK-NEXT:    ret <2 x i32> [[Y:%.*]]
;
  %ext = zext <2 x i1> %x to <2 x i32>
  %r = sdiv <2 x i32> %y, %ext
  ret <2 x i32> %r
}

define i32 @udiv_dividend_known_smaller_than_constant_divisor(i32 %x) {
; CHECK-LABEL: @udiv_dividend_known_smaller_than_constant_divisor(
; CHECK-NEXT:    ret i32 0
;
  %and = and i32 %x, 250
  %div = udiv i32 %and, 251
  ret i32 %div
}

define i32 @not_udiv_dividend_known_smaller_than_constant_divisor(i32 %x) {
; CHECK-LABEL: @not_udiv_dividend_known_smaller_than_constant_divisor(
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X:%.*]], 251
; CHECK-NEXT:    [[DIV:%.*]] = udiv i32 [[AND]], 251
; CHECK-NEXT:    ret i32 [[DIV]]
;
  %and = and i32 %x, 251
  %div = udiv i32 %and, 251
  ret i32 %div
}

define i32 @udiv_constant_dividend_known_smaller_than_divisor(i32 %x) {
; CHECK-LABEL: @udiv_constant_dividend_known_smaller_than_divisor(
; CHECK-NEXT:    ret i32 0
;
  %or = or i32 %x, 251
  %div = udiv i32 250, %or
  ret i32 %div
}

define i32 @not_udiv_constant_dividend_known_smaller_than_divisor(i32 %x) {
; CHECK-LABEL: @not_udiv_constant_dividend_known_smaller_than_divisor(
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[X:%.*]], 251
; CHECK-NEXT:    [[DIV:%.*]] = udiv i32 251, [[OR]]
; CHECK-NEXT:    ret i32 [[DIV]]
;
  %or = or i32 %x, 251
  %div = udiv i32 251, %or
  ret i32 %div
}

; This would require computing known bits on both x and y. Is it worth doing?

define i32 @udiv_dividend_known_smaller_than_divisor(i32 %x, i32 %y) {
; CHECK-LABEL: @udiv_dividend_known_smaller_than_divisor(
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X:%.*]], 250
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[Y:%.*]], 251
; CHECK-NEXT:    [[DIV:%.*]] = udiv i32 [[AND]], [[OR]]
; CHECK-NEXT:    ret i32 [[DIV]]
;
  %and = and i32 %x, 250
  %or = or i32 %y, 251
  %div = udiv i32 %and, %or
  ret i32 %div
}

define i32 @not_udiv_dividend_known_smaller_than_divisor(i32 %x, i32 %y) {
; CHECK-LABEL: @not_udiv_dividend_known_smaller_than_divisor(
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X:%.*]], 251
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[Y:%.*]], 251
; CHECK-NEXT:    [[DIV:%.*]] = udiv i32 [[AND]], [[OR]]
; CHECK-NEXT:    ret i32 [[DIV]]
;
  %and = and i32 %x, 251
  %or = or i32 %y, 251
  %div = udiv i32 %and, %or
  ret i32 %div
}

declare i32 @external()

define i32 @div1() {
; CHECK-LABEL: @div1(
; CHECK-NEXT:    [[CALL:%.*]] = call i32 @external(), [[RNG0:!range !.*]]
; CHECK-NEXT:    ret i32 0
;
  %call = call i32 @external(), !range !0
  %urem = udiv i32 %call, 3
  ret i32 %urem
}

!0 = !{i32 0, i32 3}
