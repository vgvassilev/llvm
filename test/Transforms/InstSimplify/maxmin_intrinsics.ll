; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

declare i81 @llvm.smax.i81(i81, i81)
declare i8 @llvm.smax.i8(i8, i8)
declare <2 x i8> @llvm.smax.v2i8(<2 x i8>, <2 x i8>)
declare i3 @llvm.smin.i3(i3, i3)
declare i8 @llvm.smin.i8(i8, i8)
declare <2 x i8> @llvm.smin.v2i8(<2 x i8>, <2 x i8>)
declare i8 @llvm.umax.i8(i8, i8)
declare <2 x i8> @llvm.umax.v2i8(<2 x i8>, <2 x i8>)
declare i8 @llvm.umin.i8(i8, i8)
declare <2 x i8> @llvm.umin.v2i8(<2 x i8>, <2 x i8>)

define i81 @smax_sameval(i81 %x) {
; CHECK-LABEL: @smax_sameval(
; CHECK-NEXT:    ret i81 [[X:%.*]]
;
  %r = call i81 @llvm.smax.i81(i81 %x, i81 %x)
  ret i81 %r
}

define i3 @smin_sameval(i3 %x) {
; CHECK-LABEL: @smin_sameval(
; CHECK-NEXT:    ret i3 [[X:%.*]]
;
  %r = call i3 @llvm.smin.i3(i3 %x, i3 %x)
  ret i3 %r
}

define <2 x i8> @umax_sameval(<2 x i8> %x) {
; CHECK-LABEL: @umax_sameval(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> %x, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @umin_sameval(<2 x i8> %x) {
; CHECK-LABEL: @umin_sameval(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> %x)
  ret <2 x i8> %r
}

define i81 @smax_undef(i81 %x) {
; CHECK-LABEL: @smax_undef(
; CHECK-NEXT:    ret i81 1208925819614629174706175
;
  %r = call i81 @llvm.smax.i81(i81 undef, i81 %x)
  ret i81 %r
}

define i3 @smin_undef(i3 %x) {
; CHECK-LABEL: @smin_undef(
; CHECK-NEXT:    ret i3 -4
;
  %r = call i3 @llvm.smin.i3(i3 %x, i3 undef)
  ret i3 %r
}

define <2 x i8> @umax_undef(<2 x i8> %x) {
; CHECK-LABEL: @umax_undef(
; CHECK-NEXT:    ret <2 x i8> <i8 -1, i8 -1>
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> undef, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @umin_undef(<2 x i8> %x) {
; CHECK-LABEL: @umin_undef(
; CHECK-NEXT:    ret <2 x i8> zeroinitializer
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> undef)
  ret <2 x i8> %r
}

define i8 @smax_maxval(i8 %x) {
; CHECK-LABEL: @smax_maxval(
; CHECK-NEXT:    ret i8 127
;
  %r = call i8 @llvm.smax.i8(i8 %x, i8 127)
  ret i8 %r
}

define <2 x i8> @smax_maxval_commute(<2 x i8> %x) {
; CHECK-LABEL: @smax_maxval_commute(
; CHECK-NEXT:    ret <2 x i8> <i8 127, i8 127>
;
  %r = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 127, i8 127>, <2 x i8> %x)
  ret <2 x i8> %r
}

define i8 @smin_minval(i8 %x) {
; CHECK-LABEL: @smin_minval(
; CHECK-NEXT:    ret i8 -128
;
  %r = call i8 @llvm.smin.i8(i8 -128, i8 %x)
  ret i8 %r
}

define <2 x i8> @smin_minval_commute(<2 x i8> %x) {
; CHECK-LABEL: @smin_minval_commute(
; CHECK-NEXT:    ret <2 x i8> <i8 -128, i8 -128>
;
  %r = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> <i8 -128, i8 -128>)
  ret <2 x i8> %r
}

define i8 @umax_maxval(i8 %x) {
; CHECK-LABEL: @umax_maxval(
; CHECK-NEXT:    ret i8 -1
;
  %r = call i8 @llvm.umax.i8(i8 %x, i8 255)
  ret i8 %r
}

define <2 x i8> @umax_maxval_commute(<2 x i8> %x) {
; CHECK-LABEL: @umax_maxval_commute(
; CHECK-NEXT:    ret <2 x i8> <i8 -1, i8 -1>
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> <i8 255, i8 255>, <2 x i8> %x)
  ret <2 x i8> %r
}

define i8 @umin_minval(i8 %x) {
; CHECK-LABEL: @umin_minval(
; CHECK-NEXT:    ret i8 0
;
  %r = call i8 @llvm.umin.i8(i8 0, i8 %x)
  ret i8 %r
}

define <2 x i8> @umin_minval_commute(<2 x i8> %x) {
; CHECK-LABEL: @umin_minval_commute(
; CHECK-NEXT:    ret <2 x i8> zeroinitializer
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> zeroinitializer)
  ret <2 x i8> %r
}

define i8 @smax_minval(i8 %x) {
; CHECK-LABEL: @smax_minval(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %r = call i8 @llvm.smax.i8(i8 %x, i8 -128)
  ret i8 %r
}

define <2 x i8> @smax_minval_commute(<2 x i8> %x) {
; CHECK-LABEL: @smax_minval_commute(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %r = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 -128, i8 -128>, <2 x i8> %x)
  ret <2 x i8> %r
}

define i8 @smin_maxval(i8 %x) {
; CHECK-LABEL: @smin_maxval(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %r = call i8 @llvm.smin.i8(i8 127, i8 %x)
  ret i8 %r
}

define <2 x i8> @smin_maxval_commute(<2 x i8> %x) {
; CHECK-LABEL: @smin_maxval_commute(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %r = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> <i8 127, i8 127>)
  ret <2 x i8> %r
}

define i8 @umax_minval(i8 %x) {
; CHECK-LABEL: @umax_minval(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %r = call i8 @llvm.umax.i8(i8 %x, i8 0)
  ret i8 %r
}

define <2 x i8> @umax_minval_commute(<2 x i8> %x) {
; CHECK-LABEL: @umax_minval_commute(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> zeroinitializer, <2 x i8> %x)
  ret <2 x i8> %r
}

define i8 @umin_maxval(i8 %x) {
; CHECK-LABEL: @umin_maxval(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %r = call i8 @llvm.umin.i8(i8 255, i8 %x)
  ret i8 %r
}

define <2 x i8> @umin_maxval_commute(<2 x i8> %x) {
; CHECK-LABEL: @umin_maxval_commute(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> <i8 255, i8 255>)
  ret <2 x i8> %r
}

define <2 x i8> @smax_maxval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @smax_maxval_partial_undef(
; CHECK-NEXT:    ret <2 x i8> <i8 127, i8 127>
;
  %r = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 undef, i8 127>, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @smin_minval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @smin_minval_partial_undef(
; CHECK-NEXT:    ret <2 x i8> <i8 -128, i8 -128>
;
  %r = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> <i8 -128, i8 undef>)
  ret <2 x i8> %r
}

define <2 x i8> @umax_maxval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @umax_maxval_partial_undef(
; CHECK-NEXT:    ret <2 x i8> <i8 -1, i8 -1>
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> <i8 255, i8 undef>, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @umin_minval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @umin_minval_partial_undef(
; CHECK-NEXT:    ret <2 x i8> zeroinitializer
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> <i8 undef, i8 0>)
  ret <2 x i8> %r
}

define <2 x i8> @smax_minval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @smax_minval_partial_undef(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %r = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 undef, i8 -128>, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @smin_maxval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @smin_maxval_partial_undef(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %r = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> <i8 undef, i8 127>)
  ret <2 x i8> %r
}

define <2 x i8> @umax_minval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @umax_minval_partial_undef(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %r = call <2 x i8> @llvm.umax.v2i8(<2 x i8> <i8 0, i8 undef>, <2 x i8> %x)
  ret <2 x i8> %r
}

define <2 x i8> @umin_maxval_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @umin_maxval_partial_undef(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %r = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> <i8 255, i8 undef>)
  ret <2 x i8> %r
}

define i8 @umax_umax(i8 %x, i8 %y) {
; CHECK-LABEL: @umax_umax(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umax.i8(i8 [[X:%.*]], i8 [[Y:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.umax.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.umax.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define i8 @umax_umax_commute1(i8 %x, i8 %y) {
; CHECK-LABEL: @umax_umax_commute1(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umax.i8(i8 [[Y:%.*]], i8 [[X:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.umax.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.umax.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define i8 @umax_umax_commute2(i8 %x, i8 %y) {
; CHECK-LABEL: @umax_umax_commute2(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umax.i8(i8 [[X:%.*]], i8 [[Y:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.umax.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.umax.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define <2 x i8> @umax_umax_commute3(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @umax_umax_commute3(
; CHECK-NEXT:    [[M:%.*]] = call <2 x i8> @llvm.umax.v2i8(<2 x i8> [[Y:%.*]], <2 x i8> [[X:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[M]]
;
  %m = call <2 x i8> @llvm.umax.v2i8(<2 x i8> %y, <2 x i8> %x)
  %m2 = call <2 x i8> @llvm.umax.v2i8(<2 x i8> %m, <2 x i8> %x)
  ret <2 x i8> %m2
}

define i8 @umin_umin(i8 %x, i8 %y) {
; CHECK-LABEL: @umin_umin(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[X:%.*]], i8 [[Y:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.umin.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.umin.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define i8 @umin_umin_commute1(i8 %x, i8 %y) {
; CHECK-LABEL: @umin_umin_commute1(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[Y:%.*]], i8 [[X:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.umin.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.umin.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define <2 x i8> @umin_umin_commute2(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @umin_umin_commute2(
; CHECK-NEXT:    [[M:%.*]] = call <2 x i8> @llvm.umin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> [[Y:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[M]]
;
  %m = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> %y)
  %m2 = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %m, <2 x i8> %x)
  ret <2 x i8> %m2
}

define i8 @umin_umin_commute3(i8 %x, i8 %y) {
; CHECK-LABEL: @umin_umin_commute3(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[Y:%.*]], i8 [[X:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.umin.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.umin.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define i8 @smax_smax(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_smax(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smax.i8(i8 [[X:%.*]], i8 [[Y:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.smax.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.smax.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define <2 x i8> @smax_smax_commute1(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @smax_smax_commute1(
; CHECK-NEXT:    [[M:%.*]] = call <2 x i8> @llvm.smax.v2i8(<2 x i8> [[Y:%.*]], <2 x i8> [[X:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[M]]
;
  %m = call <2 x i8> @llvm.smax.v2i8(<2 x i8> %y, <2 x i8> %x)
  %m2 = call <2 x i8> @llvm.smax.v2i8(<2 x i8> %x, <2 x i8> %m)
  ret <2 x i8> %m2
}

define i8 @smax_smax_commute2(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_smax_commute2(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smax.i8(i8 [[X:%.*]], i8 [[Y:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.smax.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.smax.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define i8 @smax_smax_commute3(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_smax_commute3(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smax.i8(i8 [[Y:%.*]], i8 [[X:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.smax.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.smax.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define <2 x i8> @smin_smin(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @smin_smin(
; CHECK-NEXT:    [[M:%.*]] = call <2 x i8> @llvm.smin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> [[Y:%.*]])
; CHECK-NEXT:    ret <2 x i8> [[M]]
;
  %m = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> %y)
  %m2 = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> %m)
  ret <2 x i8> %m2
}

define i8 @smin_smin_commute1(i8 %x, i8 %y) {
; CHECK-LABEL: @smin_smin_commute1(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smin.i8(i8 [[Y:%.*]], i8 [[X:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.smin.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.smin.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define i8 @smin_smin_commute2(i8 %x, i8 %y) {
; CHECK-LABEL: @smin_smin_commute2(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smin.i8(i8 [[X:%.*]], i8 [[Y:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.smin.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.smin.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define i8 @smin_smin_commute3(i8 %x, i8 %y) {
; CHECK-LABEL: @smin_smin_commute3(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smin.i8(i8 [[Y:%.*]], i8 [[X:%.*]])
; CHECK-NEXT:    ret i8 [[M]]
;
  %m = call i8 @llvm.smin.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.smin.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define i8 @umax_umin(i8 %x, i8 %y) {
; CHECK-LABEL: @umax_umin(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.umax.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.umin.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define i8 @umax_umin_commute1(i8 %x, i8 %y) {
; CHECK-LABEL: @umax_umin_commute1(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.umax.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.umin.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define i8 @umax_umin_commute2(i8 %x, i8 %y) {
; CHECK-LABEL: @umax_umin_commute2(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.umax.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.umin.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define <2 x i8> @umax_umin_commute3(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @umax_umin_commute3(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %m = call <2 x i8> @llvm.umax.v2i8(<2 x i8> %y, <2 x i8> %x)
  %m2 = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %m, <2 x i8> %x)
  ret <2 x i8> %m2
}

define i8 @umin_umax(i8 %x, i8 %y) {
; CHECK-LABEL: @umin_umax(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.umin.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.umax.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define i8 @umin_umax_commute1(i8 %x, i8 %y) {
; CHECK-LABEL: @umin_umax_commute1(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.umin.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.umax.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define <2 x i8> @umin_umax_commute2(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @umin_umax_commute2(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %m = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> %y)
  %m2 = call <2 x i8> @llvm.umax.v2i8(<2 x i8> %m, <2 x i8> %x)
  ret <2 x i8> %m2
}

define i8 @umin_umax_commute3(i8 %x, i8 %y) {
; CHECK-LABEL: @umin_umax_commute3(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.umin.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.umax.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define i8 @smax_smin(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_smin(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.smax.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.smin.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define <2 x i8> @smax_smin_commute1(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @smax_smin_commute1(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %m = call <2 x i8> @llvm.smax.v2i8(<2 x i8> %y, <2 x i8> %x)
  %m2 = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> %m)
  ret <2 x i8> %m2
}

define i8 @smax_smin_commute2(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_smin_commute2(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.smax.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.smin.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define i8 @smax_smin_commute3(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_smin_commute3(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.smax.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.smin.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define <2 x i8> @smin_smax(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @smin_smax(
; CHECK-NEXT:    ret <2 x i8> [[X:%.*]]
;
  %m = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> %y)
  %m2 = call <2 x i8> @llvm.smax.v2i8(<2 x i8> %x, <2 x i8> %m)
  ret <2 x i8> %m2
}

define i8 @smin_smax_commute1(i8 %x, i8 %y) {
; CHECK-LABEL: @smin_smax_commute1(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.smin.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.smax.i8(i8 %x, i8 %m)
  ret i8 %m2
}

define i8 @smin_smax_commute2(i8 %x, i8 %y) {
; CHECK-LABEL: @smin_smax_commute2(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.smin.i8(i8 %x, i8 %y)
  %m2 = call i8 @llvm.smax.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define i8 @smin_smax_commute3(i8 %x, i8 %y) {
; CHECK-LABEL: @smin_smax_commute3(
; CHECK-NEXT:    ret i8 [[X:%.*]]
;
  %m = call i8 @llvm.smin.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.smax.i8(i8 %m, i8 %x)
  ret i8 %m2
}

; Negative test - mismatched intrinsics.

define i8 @smax_umin(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_umin(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smax.i8(i8 [[Y:%.*]], i8 [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.umin.i8(i8 [[M]], i8 [[X]])
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.smax.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.umin.i8(i8 %m, i8 %x)
  ret i8 %m2
}

; Negative test - mismatched intrinsics.

define i8 @smax_umax(i8 %x, i8 %y) {
; CHECK-LABEL: @smax_umax(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smax.i8(i8 [[Y:%.*]], i8 [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.umax.i8(i8 [[M]], i8 [[X]])
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.smax.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.umax.i8(i8 %m, i8 %x)
  ret i8 %m2
}

; Negative test - mismatched intrinsics.

define i8 @umax_smin(i8 %x, i8 %y) {
; CHECK-LABEL: @umax_smin(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umax.i8(i8 [[Y:%.*]], i8 [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.smin.i8(i8 [[M]], i8 [[X]])
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.umax.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.smin.i8(i8 %m, i8 %x)
  ret i8 %m2
}

; Negative test - mismatched intrinsics.

define i8 @umin_smin(i8 %x, i8 %y) {
; CHECK-LABEL: @umin_smin(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[Y:%.*]], i8 [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.smin.i8(i8 [[M]], i8 [[X]])
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.umin.i8(i8 %y, i8 %x)
  %m2 = call i8 @llvm.smin.i8(i8 %m, i8 %x)
  ret i8 %m2
}

define i8 @umax_umax_constants(i8 %x) {
; CHECK-LABEL: @umax_umax_constants(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umax.i8(i8 [[X:%.*]], i8 9)
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.umax.i8(i8 7, i8 [[M]])
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.umax.i8(i8 %x, i8 9)
  %m2 = call i8 @llvm.umax.i8(i8 7, i8 %m)
  ret i8 %m2
}

define i8 @umax_umax_constants_commute1(i8 %x) {
; CHECK-LABEL: @umax_umax_constants_commute1(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umax.i8(i8 -128, i8 [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.umax.i8(i8 7, i8 [[M]])
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.umax.i8(i8 128, i8 %x)
  %m2 = call i8 @llvm.umax.i8(i8 7, i8 %m)
  ret i8 %m2
}

define i8 @umax_umax_constants_commute2(i8 %x) {
; CHECK-LABEL: @umax_umax_constants_commute2(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umax.i8(i8 [[X:%.*]], i8 -56)
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.umax.i8(i8 [[M]], i8 127)
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.umax.i8(i8 %x, i8 200)
  %m2 = call i8 @llvm.umax.i8(i8 %m, i8 127)
  ret i8 %m2
}

define <2 x i8> @umax_umax_constants_commute3(<2 x i8> %x) {
; CHECK-LABEL: @umax_umax_constants_commute3(
; CHECK-NEXT:    [[M:%.*]] = call <2 x i8> @llvm.umax.v2i8(<2 x i8> <i8 -2, i8 -2>, <2 x i8> [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call <2 x i8> @llvm.umax.v2i8(<2 x i8> [[M]], <2 x i8> <i8 -128, i8 -128>)
; CHECK-NEXT:    ret <2 x i8> [[M2]]
;
  %m = call <2 x i8> @llvm.umax.v2i8(<2 x i8> <i8 254, i8 254>, <2 x i8> %x)
  %m2 = call <2 x i8> @llvm.umax.v2i8(<2 x i8> %m, <2 x i8> <i8 128, i8 128>)
  ret <2 x i8> %m2
}

define i8 @umin_umin_constants(i8 %x) {
; CHECK-LABEL: @umin_umin_constants(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 [[X:%.*]], i8 7)
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.umin.i8(i8 9, i8 [[M]])
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.umin.i8(i8 %x, i8 7)
  %m2 = call i8 @llvm.umin.i8(i8 9, i8 %m)
  ret i8 %m2
}

define i8 @umin_umin_constants_commute1(i8 %x) {
; CHECK-LABEL: @umin_umin_constants_commute1(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 7, i8 [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.umin.i8(i8 -128, i8 [[M]])
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.umin.i8(i8 7, i8 %x)
  %m2 = call i8 @llvm.umin.i8(i8 128, i8 %m)
  ret i8 %m2
}

define <2 x i8> @umin_umin_constants_commute2(<2 x i8> %x) {
; CHECK-LABEL: @umin_umin_constants_commute2(
; CHECK-NEXT:    [[M:%.*]] = call <2 x i8> @llvm.umin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> <i8 127, i8 127>)
; CHECK-NEXT:    [[M2:%.*]] = call <2 x i8> @llvm.umin.v2i8(<2 x i8> [[M]], <2 x i8> <i8 -56, i8 undef>)
; CHECK-NEXT:    ret <2 x i8> [[M2]]
;
  %m = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> <i8 127, i8 127>)
  %m2 = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %m, <2 x i8> <i8 200, i8 undef>)
  ret <2 x i8> %m2
}

define i8 @umin_umin_constants_commute3(i8 %x) {
; CHECK-LABEL: @umin_umin_constants_commute3(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.umin.i8(i8 -128, i8 [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.umin.i8(i8 [[M]], i8 -2)
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.umin.i8(i8 128, i8 %x)
  %m2 = call i8 @llvm.umin.i8(i8 %m, i8 254)
  ret i8 %m2
}

define i8 @smax_smax_constants(i8 %x) {
; CHECK-LABEL: @smax_smax_constants(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smax.i8(i8 [[X:%.*]], i8 9)
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.smax.i8(i8 7, i8 [[M]])
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.smax.i8(i8 %x, i8 9)
  %m2 = call i8 @llvm.smax.i8(i8 7, i8 %m)
  ret i8 %m2
}

define <2 x i8> @smax_smax_constants_commute1(<2 x i8> %x) {
; CHECK-LABEL: @smax_smax_constants_commute1(
; CHECK-NEXT:    [[M:%.*]] = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 7, i8 7>, <2 x i8> [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 -127, i8 -127>, <2 x i8> [[M]])
; CHECK-NEXT:    ret <2 x i8> [[M2]]
;
  %m = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 7, i8 7>, <2 x i8> %x)
  %m2 = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 -127, i8 -127>, <2 x i8> %m)
  ret <2 x i8> %m2
}

define i8 @smax_smax_constants_commute2(i8 %x) {
; CHECK-LABEL: @smax_smax_constants_commute2(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smax.i8(i8 [[X:%.*]], i8 0)
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.smax.i8(i8 [[M]], i8 -1)
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.smax.i8(i8 %x, i8 0)
  %m2 = call i8 @llvm.smax.i8(i8 %m, i8 -1)
  ret i8 %m2
}

define i8 @smax_smax_constants_commute3(i8 %x) {
; CHECK-LABEL: @smax_smax_constants_commute3(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smax.i8(i8 -1, i8 [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.smax.i8(i8 [[M]], i8 -127)
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.smax.i8(i8 -1, i8 %x)
  %m2 = call i8 @llvm.smax.i8(i8 %m, i8 -127)
  ret i8 %m2
}

define <2 x i8> @smin_smin_constants(<2 x i8> %x) {
; CHECK-LABEL: @smin_smin_constants(
; CHECK-NEXT:    [[M:%.*]] = call <2 x i8> @llvm.smin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> <i8 7, i8 7>)
; CHECK-NEXT:    [[M2:%.*]] = call <2 x i8> @llvm.smin.v2i8(<2 x i8> <i8 undef, i8 9>, <2 x i8> [[M]])
; CHECK-NEXT:    ret <2 x i8> [[M2]]
;
  %m = call <2 x i8> @llvm.smin.v2i8(<2 x i8> %x, <2 x i8> <i8 7, i8 7>)
  %m2 = call <2 x i8> @llvm.smin.v2i8(<2 x i8> <i8 undef, i8 9>, <2 x i8> %m)
  ret <2 x i8> %m2
}

define i8 @smin_smin_constants_commute1(i8 %x) {
; CHECK-LABEL: @smin_smin_constants_commute1(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smin.i8(i8 -127, i8 [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.smin.i8(i8 7, i8 [[M]])
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.smin.i8(i8 -127, i8 %x)
  %m2 = call i8 @llvm.smin.i8(i8 7, i8 %m)
  ret i8 %m2
}

define i8 @smin_smin_constants_commute2(i8 %x) {
; CHECK-LABEL: @smin_smin_constants_commute2(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smin.i8(i8 [[X:%.*]], i8 -1)
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.smin.i8(i8 [[M]], i8 0)
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.smin.i8(i8 %x, i8 -1)
  %m2 = call i8 @llvm.smin.i8(i8 %m, i8 0)
  ret i8 %m2
}

define i8 @smin_smin_constants_commute3(i8 %x) {
; CHECK-LABEL: @smin_smin_constants_commute3(
; CHECK-NEXT:    [[M:%.*]] = call i8 @llvm.smin.i8(i8 -127, i8 [[X:%.*]])
; CHECK-NEXT:    [[M2:%.*]] = call i8 @llvm.smin.i8(i8 [[M]], i8 -1)
; CHECK-NEXT:    ret i8 [[M2]]
;
  %m = call i8 @llvm.smin.i8(i8 -127, i8 %x)
  %m2 = call i8 @llvm.smin.i8(i8 %m, i8 -1)
  ret i8 %m2
}

define <2 x i8> @umin_umin_constants_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @umin_umin_constants_partial_undef(
; CHECK-NEXT:    [[M:%.*]] = call <2 x i8> @llvm.umin.v2i8(<2 x i8> [[X:%.*]], <2 x i8> <i8 7, i8 undef>)
; CHECK-NEXT:    [[M2:%.*]] = call <2 x i8> @llvm.umin.v2i8(<2 x i8> <i8 9, i8 9>, <2 x i8> [[M]])
; CHECK-NEXT:    ret <2 x i8> [[M2]]
;
  %m = call <2 x i8> @llvm.umin.v2i8(<2 x i8> %x, <2 x i8> <i8 7, i8 undef> )
  %m2 = call <2 x i8> @llvm.umin.v2i8(<2 x i8> <i8 9, i8 9>, <2 x i8> %m)
  ret <2 x i8> %m2
}

define <2 x i8> @smax_smax_constants_partial_undef(<2 x i8> %x) {
; CHECK-LABEL: @smax_smax_constants_partial_undef(
; CHECK-NEXT:    [[M:%.*]] = call <2 x i8> @llvm.smax.v2i8(<2 x i8> [[X:%.*]], <2 x i8> <i8 undef, i8 10>)
; CHECK-NEXT:    [[M2:%.*]] = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 9, i8 9>, <2 x i8> [[M]])
; CHECK-NEXT:    ret <2 x i8> [[M2]]
;
  %m = call <2 x i8> @llvm.smax.v2i8(<2 x i8> %x, <2 x i8> <i8 undef, i8 10> )
  %m2 = call <2 x i8> @llvm.smax.v2i8(<2 x i8> <i8 9, i8 9>, <2 x i8> %m)
  ret <2 x i8> %m2
}
