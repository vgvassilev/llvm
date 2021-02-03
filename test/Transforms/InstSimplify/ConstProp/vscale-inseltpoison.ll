; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S -verify | FileCheck %s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Unary Operations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define <vscale x 2 x double> @fneg(<vscale x 2 x double> %val) {
; CHECK-LABEL: @fneg(
; CHECK-NEXT:    ret <vscale x 2 x double> undef
;
  %r = fneg <vscale x 2 x double> undef
  ret <vscale x 2 x double> %r
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Binary Operations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define <vscale x 4 x i32> @add() {
; CHECK-LABEL: @add(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = add <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x float> @fadd() {
; CHECK-LABEL: @fadd(
; CHECK-NEXT:    ret <vscale x 4 x float> undef
;
  %r = fadd <vscale x 4 x float> undef, undef
  ret <vscale x 4 x float> %r
}

define <vscale x 4 x i32> @sub() {
; CHECK-LABEL: @sub(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = sub <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @sub_splat() {
; CHECK-LABEL: @sub_splat(
; CHECK-NEXT:    ret <vscale x 4 x i32> shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> undef, i32 -16, i32 0), <vscale x 4 x i32> undef, <vscale x 4 x i32> zeroinitializer)
;
  %r = sub <vscale x 4 x i32> zeroinitializer, shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> undef, i32 16, i32 0), <vscale x 4 x i32> undef, <vscale x 4 x i32> zeroinitializer)
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x float> @fsub() {
; CHECK-LABEL: @fsub(
; CHECK-NEXT:    ret <vscale x 4 x float> undef
;
  %r = fsub <vscale x 4 x float> undef, undef
  ret <vscale x 4 x float> %r
}

define <vscale x 4 x i32> @mul() {
; CHECK-LABEL: @mul(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = mul <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x float> @fmul() {
; CHECK-LABEL: @fmul(
; CHECK-NEXT:    ret <vscale x 4 x float> undef
;
  %r = fmul <vscale x 4 x float> undef, undef
  ret <vscale x 4 x float> %r
}

define <vscale x 4 x i32> @udiv() {
; CHECK-LABEL: @udiv(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = udiv <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @udiv_splat_zero() {
; CHECK-LABEL: @udiv_splat_zero(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = udiv <vscale x 4 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @sdiv() {
; CHECK-LABEL: @sdiv(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = sdiv <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x float> @fdiv() {
; CHECK-LABEL: @fdiv(
; CHECK-NEXT:    ret <vscale x 4 x float> undef
;
  %r = fdiv <vscale x 4 x float> undef, undef
  ret <vscale x 4 x float> %r
}

define <vscale x 4 x i32> @urem() {
; CHECK-LABEL: @urem(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = urem <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @srem() {
; CHECK-LABEL: @srem(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = srem <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x float> @frem() {
; CHECK-LABEL: @frem(
; CHECK-NEXT:    ret <vscale x 4 x float> undef
;
  %r = frem <vscale x 4 x float> undef, undef
  ret <vscale x 4 x float> %r
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bitwise Binary Operations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define <vscale x 4 x i32> @shl() {
; CHECK-LABEL: @shl(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = shl <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @lshr() {
; CHECK-LABEL: @lshr(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = lshr <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @ashr() {
; CHECK-LABEL: @ashr(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = ashr <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @and() {
; CHECK-LABEL: @and(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = and <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @or() {
; CHECK-LABEL: @or(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = or <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @xor() {
; CHECK-LABEL: @xor(
; CHECK-NEXT:    ret <vscale x 4 x i32> zeroinitializer
;
  %r = xor <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i32> %r
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vector Operations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define <vscale x 4 x i32> @insertelement() {
; CHECK-LABEL: @insertelement(
; CHECK-NEXT:    ret <vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 1, i32 0)
;
  %i = insertelement <vscale x 4 x i32> poison, i32 1, i32 0
  ret <vscale x 4 x i32> %i
}

define <vscale x 4 x i32> @shufflevector() {
; CHECK-LABEL: @shufflevector(
; CHECK-NEXT:    ret <vscale x 4 x i32> shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 1, i32 0), <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer)
;
  %i = insertelement <vscale x 4 x i32> poison, i32 1, i32 0
  %i2 = shufflevector <vscale x 4 x i32> %i, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i32> %i2
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Memory Access and Addressing Operations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define <vscale x 2 x double> @load() {
; CHECK-LABEL: @load(
; CHECK-NEXT:    [[R:%.*]] = load <vscale x 2 x double>, <vscale x 2 x double>* getelementptr (<vscale x 2 x double>, <vscale x 2 x double>* null, i64 1), align 16
; CHECK-NEXT:    ret <vscale x 2 x double> [[R]]
;
  %r = load <vscale x 2 x double>, <vscale x 2 x double>* getelementptr (<vscale x 2 x double>, <vscale x 2 x double>* null, i64 1)
  ret <vscale x 2 x double> %r
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Conversion Operations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define <vscale x 4 x float> @bitcast() {
; CHECK-LABEL: @bitcast(
; CHECK-NEXT:    ret <vscale x 4 x float> bitcast (<vscale x 4 x i32> shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 1, i32 0), <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer) to <vscale x 4 x float>)
;
  %i1 = insertelement <vscale x 4 x i32> poison, i32 1, i32 0
  %i2 = shufflevector <vscale x 4 x i32> %i1, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %i3 = bitcast <vscale x 4 x i32> %i2 to <vscale x 4 x float>
  ret <vscale x 4 x float> %i3
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Other Operations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define <vscale x 4 x i32> @select() {
; CHECK-LABEL: @select(
; CHECK-NEXT:    ret <vscale x 4 x i32> undef
;
  %r = select <vscale x 4 x i1> undef, <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32> undef
  ret <vscale x 4 x i32> %r
}

declare <vscale x 16 x i8> @llvm.something(<vscale x 16 x i8>, <vscale x 16 x i8>)

define <vscale x 16 x i8> @call() {
; CHECK-LABEL: @call(
; CHECK-NEXT:    [[R:%.*]] = call <vscale x 16 x i8> @llvm.something(<vscale x 16 x i8> undef, <vscale x 16 x i8> undef)
; CHECK-NEXT:    ret <vscale x 16 x i8> [[R]]
;
  %r =  call <vscale x 16 x i8> @llvm.something(<vscale x 16 x i8> undef, <vscale x 16 x i8> undef)
  ret <vscale x 16 x i8> %r
}

define <vscale x 4 x i1> @icmp_undef() {
; CHECK-LABEL: @icmp_undef(
; CHECK-NEXT:    ret <vscale x 4 x i1> undef
;
  %r = icmp eq <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i1> %r
}

define <vscale x 4 x i1> @icmp_zero() {
; CHECK-LABEL: @icmp_zero(
; CHECK-NEXT:    ret <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> undef, i1 true, i32 0), <vscale x 4 x i1> undef, <vscale x 4 x i32> zeroinitializer)
;
  %r = icmp eq <vscale x 4 x i32> zeroinitializer, zeroinitializer
  ret <vscale x 4 x i1> %r
}

define <vscale x 4 x i1> @fcmp_true() {
; CHECK-LABEL: @fcmp_true(
; CHECK-NEXT:    ret <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> undef, i1 true, i32 0), <vscale x 4 x i1> undef, <vscale x 4 x i32> zeroinitializer)
;
  %r = fcmp true <vscale x 4 x float> undef, undef
  ret <vscale x 4 x i1> %r
}

define <vscale x 4 x i1> @fcmp_false() {
; CHECK-LABEL: @fcmp_false(
; CHECK-NEXT:    ret <vscale x 4 x i1> zeroinitializer
;
  %r = fcmp false <vscale x 4 x float> undef, undef
  ret <vscale x 4 x i1> %r
}

define <vscale x 4 x i1> @fcmp_undef() {
; CHECK-LABEL: @fcmp_undef(
; CHECK-NEXT:    ret <vscale x 4 x i1> undef
;
  %r = icmp ne <vscale x 4 x i32> undef, undef
  ret <vscale x 4 x i1> %r
}

define <vscale x 4 x i1> @fcmp_not_equality() {
; CHECK-LABEL: @fcmp_not_equality(
; CHECK-NEXT:    ret <vscale x 4 x i1> shufflevector (<vscale x 4 x i1> insertelement (<vscale x 4 x i1> undef, i1 true, i32 0), <vscale x 4 x i1> undef, <vscale x 4 x i32> zeroinitializer)
;
  %r = icmp ule <vscale x 4 x i32> undef, zeroinitializer
  ret <vscale x 4 x i1> %r
}
