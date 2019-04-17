; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

;; x * 0 ==> 0 when no-nans and no-signed-zero
define float @mul_zero_1(float %a) {
; CHECK-LABEL: @mul_zero_1(
; CHECK-NEXT:    ret float 0.000000e+00
;
  %b = fmul nsz nnan float %a, 0.0
  ret float %b
}

define float @mul_zero_2(float %a) {
; CHECK-LABEL: @mul_zero_2(
; CHECK-NEXT:    ret float 0.000000e+00
;
  %b = fmul fast float 0.0, %a
  ret float %b
}

define <2 x float> @mul_zero_nsz_nnan_vec_undef(<2 x float> %a) {
; CHECK-LABEL: @mul_zero_nsz_nnan_vec_undef(
; CHECK-NEXT:    ret <2 x float> zeroinitializer
;
  %b = fmul nsz nnan <2 x float> %a, <float 0.0, float undef>
  ret <2 x float> %b
}

;; x * 0 =/=> 0 when there could be nans or -0
define float @no_mul_zero_1(float %a) {
; CHECK-LABEL: @no_mul_zero_1(
; CHECK-NEXT:    [[B:%.*]] = fmul nsz float [[A:%.*]], 0.000000e+00
; CHECK-NEXT:    ret float [[B]]
;
  %b = fmul nsz float %a, 0.0
  ret float %b
}

define float @no_mul_zero_2(float %a) {
; CHECK-LABEL: @no_mul_zero_2(
; CHECK-NEXT:    [[B:%.*]] = fmul nnan float [[A:%.*]], 0.000000e+00
; CHECK-NEXT:    ret float [[B]]
;
  %b = fmul nnan float %a, 0.0
  ret float %b
}

define float @no_mul_zero_3(float %a) {
; CHECK-LABEL: @no_mul_zero_3(
; CHECK-NEXT:    [[B:%.*]] = fmul float [[A:%.*]], 0.000000e+00
; CHECK-NEXT:    ret float [[B]]
;
  %b = fmul float %a, 0.0
  ret float %b
}

; -X + X --> 0.0 (with nnan on the fadd)

define float @fadd_fnegx(float %x) {
; CHECK-LABEL: @fadd_fnegx(
; CHECK-NEXT:    ret float 0.000000e+00
;
  %negx = fsub float -0.0, %x
  %r = fadd nnan float %negx, %x
  ret float %r
}

; X + -X --> 0.0 (with nnan on the fadd)

define <2 x float> @fadd_fnegx_commute_vec(<2 x float> %x) {
; CHECK-LABEL: @fadd_fnegx_commute_vec(
; CHECK-NEXT:    ret <2 x float> zeroinitializer
;
  %negx = fsub <2 x float> <float -0.0, float -0.0>, %x
  %r = fadd nnan <2 x float> %x, %negx
  ret <2 x float> %r
}

define <2 x float> @fadd_fnegx_commute_vec_undef(<2 x float> %x) {
; CHECK-LABEL: @fadd_fnegx_commute_vec_undef(
; CHECK-NEXT:    ret <2 x float> zeroinitializer
;
  %negx = fsub <2 x float> <float undef, float -0.0>, %x
  %r = fadd nnan <2 x float> %x, %negx
  ret <2 x float> %r
}

; https://bugs.llvm.org/show_bug.cgi?id=26958
; https://bugs.llvm.org/show_bug.cgi?id=27151

define float @fadd_fneg_nan(float %x) {
; CHECK-LABEL: @fadd_fneg_nan(
; CHECK-NEXT:    [[T:%.*]] = fsub nnan float -0.000000e+00, [[X:%.*]]
; CHECK-NEXT:    [[COULD_BE_NAN:%.*]] = fadd ninf float [[T]], [[X]]
; CHECK-NEXT:    ret float [[COULD_BE_NAN]]
;
  %t = fsub nnan float -0.0, %x
  %could_be_nan = fadd ninf float %t, %x
  ret float %could_be_nan
}

define float @fadd_fneg_nan_commute(float %x) {
; CHECK-LABEL: @fadd_fneg_nan_commute(
; CHECK-NEXT:    [[T:%.*]] = fsub nnan ninf float -0.000000e+00, [[X:%.*]]
; CHECK-NEXT:    [[COULD_BE_NAN:%.*]] = fadd float [[X]], [[T]]
; CHECK-NEXT:    ret float [[COULD_BE_NAN]]
;
  %t = fsub nnan ninf float -0.0, %x
  %could_be_nan = fadd float %x, %t
  ret float %could_be_nan
}

; X + (0.0 - X) --> 0.0 (with nnan on the fadd)

define float @fadd_fsub_nnan_ninf(float %x) {
; CHECK-LABEL: @fadd_fsub_nnan_ninf(
; CHECK-NEXT:    ret float 0.000000e+00
;
  %sub = fsub float 0.0, %x
  %zero = fadd nnan ninf float %x, %sub
  ret float %zero
}

; (0.0 - X) + X --> 0.0 (with nnan on the fadd)

define <2 x float> @fadd_fsub_nnan_ninf_commute_vec(<2 x float> %x) {
; CHECK-LABEL: @fadd_fsub_nnan_ninf_commute_vec(
; CHECK-NEXT:    ret <2 x float> zeroinitializer
;
  %sub = fsub <2 x float> zeroinitializer, %x
  %zero = fadd nnan ninf <2 x float> %sub, %x
  ret <2 x float> %zero
}

; 'ninf' is not required because 'nnan' allows us to assume
; that X is not INF or -INF (adding opposite INFs would be NaN).

define float @fadd_fsub_nnan(float %x) {
; CHECK-LABEL: @fadd_fsub_nnan(
; CHECK-NEXT:    ret float 0.000000e+00
;
  %sub = fsub float 0.0, %x
  %zero = fadd nnan float %sub, %x
  ret float %zero
}

; fsub nnan x, x ==> 0.0
define float @fsub_x_x(float %a) {
; CHECK-LABEL: @fsub_x_x(
; CHECK-NEXT:    [[NO_ZERO1:%.*]] = fsub ninf float [[A:%.*]], [[A]]
; CHECK-NEXT:    [[NO_ZERO2:%.*]] = fsub float [[A]], [[A]]
; CHECK-NEXT:    [[NO_ZERO:%.*]] = fadd float [[NO_ZERO1]], [[NO_ZERO2]]
; CHECK-NEXT:    ret float [[NO_ZERO]]
;
; X - X ==> 0
  %zero1 = fsub nnan float %a, %a

; Dont fold
  %no_zero1 = fsub ninf float %a, %a
  %no_zero2 = fsub float %a, %a
  %no_zero = fadd float %no_zero1, %no_zero2

; Should get folded
  %ret = fadd nsz float %no_zero, %zero1

  ret float %ret
}

; fsub nsz 0.0, (fsub 0.0, X) ==> X
define float @fsub_0_0_x(float %a) {
; CHECK-LABEL: @fsub_0_0_x(
; CHECK-NEXT:    ret float [[A:%.*]]
;
  %t1 = fsub float 0.0, %a
  %ret = fsub nsz float 0.0, %t1
  ret float %ret
}

define <2 x float> @fsub_0_0_x_vec_undef1(<2 x float> %a) {
; CHECK-LABEL: @fsub_0_0_x_vec_undef1(
; CHECK-NEXT:    ret <2 x float> [[A:%.*]]
;
  %t1 = fsub <2 x float> <float 0.0, float undef>, %a
  %ret = fsub nsz <2 x float> zeroinitializer, %t1
  ret <2 x float> %ret
}

define <2 x float> @fsub_0_0_x_vec_undef2(<2 x float> %a) {
; CHECK-LABEL: @fsub_0_0_x_vec_undef2(
; CHECK-NEXT:    ret <2 x float> [[A:%.*]]
;
  %t1 = fsub <2 x float> zeroinitializer, %a
  %ret = fsub nsz <2 x float> <float undef, float -0.0>, %t1
  ret <2 x float> %ret
}

; fadd nsz X, 0 ==> X

define <2 x float> @fadd_zero_nsz_vec(<2 x float> %x) {
; CHECK-LABEL: @fadd_zero_nsz_vec(
; CHECK-NEXT:    ret <2 x float> [[X:%.*]]
;
  %r = fadd nsz <2 x float> %x, zeroinitializer
  ret <2 x float> %r
}

define <2 x float> @fadd_zero_nsz_vec_undef(<2 x float> %x) {
; CHECK-LABEL: @fadd_zero_nsz_vec_undef(
; CHECK-NEXT:    ret <2 x float> [[X:%.*]]
;
  %r = fadd nsz <2 x float> %x, <float 0.0, float undef>
  ret <2 x float> %r
}

define float @nofold_fadd_x_0(float %a) {
; CHECK-LABEL: @nofold_fadd_x_0(
; CHECK-NEXT:    [[NO_ZERO1:%.*]] = fadd ninf float [[A:%.*]], 0.000000e+00
; CHECK-NEXT:    [[NO_ZERO2:%.*]] = fadd nnan float [[A]], 0.000000e+00
; CHECK-NEXT:    [[NO_ZERO:%.*]] = fadd float [[NO_ZERO1]], [[NO_ZERO2]]
; CHECK-NEXT:    ret float [[NO_ZERO]]
;
; Dont fold
  %no_zero1 = fadd ninf float %a, 0.0
  %no_zero2 = fadd nnan float %a, 0.0
  %no_zero = fadd float %no_zero1, %no_zero2
  ret float %no_zero
}

define float @fold_fadd_nsz_x_0(float %a) {
; CHECK-LABEL: @fold_fadd_nsz_x_0(
; CHECK-NEXT:    ret float [[A:%.*]]
;
  %add = fadd nsz float %a, 0.0
  ret float %add
}

define float @fold_fadd_cannot_be_neg0_nsz_src_x_0(float %a, float %b) {
; CHECK-LABEL: @fold_fadd_cannot_be_neg0_nsz_src_x_0(
; CHECK-NEXT:    [[NSZ:%.*]] = fmul nsz float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret float [[NSZ]]
;
  %nsz = fmul nsz float %a, %b
  %add = fadd float %nsz, 0.0
  ret float %add
}

define float @fold_fadd_cannot_be_neg0_fabs_src_x_0(float %a) {
; CHECK-LABEL: @fold_fadd_cannot_be_neg0_fabs_src_x_0(
; CHECK-NEXT:    [[FABS:%.*]] = call float @llvm.fabs.f32(float [[A:%.*]])
; CHECK-NEXT:    ret float [[FABS]]
;
  %fabs = call float @llvm.fabs.f32(float %a)
  %add = fadd float %fabs, 0.0
  ret float %add
}

define float @fold_fadd_cannot_be_neg0_sqrt_nsz_src_x_0(float %a, float %b) {
; CHECK-LABEL: @fold_fadd_cannot_be_neg0_sqrt_nsz_src_x_0(
; CHECK-NEXT:    [[NSZ:%.*]] = fmul nsz float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[SQRT:%.*]] = call float @llvm.sqrt.f32(float [[NSZ]])
; CHECK-NEXT:    ret float [[SQRT]]
;
  %nsz = fmul nsz float %a, %b
  %sqrt = call float @llvm.sqrt.f32(float %nsz)
  %add = fadd float %sqrt, 0.0
  ret float %add
}

define float @fold_fadd_cannot_be_neg0_canonicalize_nsz_src_x_0(float %a, float %b) {
; CHECK-LABEL: @fold_fadd_cannot_be_neg0_canonicalize_nsz_src_x_0(
; CHECK-NEXT:    [[NSZ:%.*]] = fmul nsz float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[CANON:%.*]] = call float @llvm.canonicalize.f32(float [[NSZ]])
; CHECK-NEXT:    ret float [[CANON]]
;
  %nsz = fmul nsz float %a, %b
  %canon = call float @llvm.canonicalize.f32(float %nsz)
  %add = fadd float %canon, 0.0
  ret float %add
}

; fdiv nsz nnan 0, X ==> 0
; 0 / X -> 0

define double @fdiv_zero_by_x(double %x) {
; CHECK-LABEL: @fdiv_zero_by_x(
; CHECK-NEXT:    ret double 0.000000e+00
;
  %r = fdiv nnan nsz double 0.0, %x
  ret double %r
}

define <2 x double> @fdiv_zero_by_x_vec_undef(<2 x double> %x) {
; CHECK-LABEL: @fdiv_zero_by_x_vec_undef(
; CHECK-NEXT:    ret <2 x double> zeroinitializer
;
  %r = fdiv nnan nsz <2 x double> <double 0.0, double undef>, %x
  ret <2 x double> %r
}

; 0 % X -> 0
; nsz is not necessary - frem result always has the sign of the dividend

define double @frem_zero_by_x(double %x) {
; CHECK-LABEL: @frem_zero_by_x(
; CHECK-NEXT:    ret double 0.000000e+00
;
  %r = frem nnan double 0.0, %x
  ret double %r
}

define <2 x double> @frem_poszero_by_x_vec_undef(<2 x double> %x) {
; CHECK-LABEL: @frem_poszero_by_x_vec_undef(
; CHECK-NEXT:    ret <2 x double> zeroinitializer
;
  %r = frem nnan <2 x double> <double 0.0, double undef>, %x
  ret <2 x double> %r
}

; -0 % X -> -0
; nsz is not necessary - frem result always has the sign of the dividend

define double @frem_negzero_by_x(double %x) {
; CHECK-LABEL: @frem_negzero_by_x(
; CHECK-NEXT:    ret double -0.000000e+00
;
  %r = frem nnan double -0.0, %x
  ret double %r
}

define <2 x double> @frem_negzero_by_x_vec_undef(<2 x double> %x) {
; CHECK-LABEL: @frem_negzero_by_x_vec_undef(
; CHECK-NEXT:    ret <2 x double> <double -0.000000e+00, double -0.000000e+00>
;
  %r = frem nnan <2 x double> <double undef, double -0.0>, %x
  ret <2 x double> %r
}

define float @fdiv_self(float %f) {
; CHECK-LABEL: @fdiv_self(
; CHECK-NEXT:    ret float 1.000000e+00
;
  %div = fdiv nnan float %f, %f
  ret float %div
}

define float @fdiv_self_invalid(float %f) {
; CHECK-LABEL: @fdiv_self_invalid(
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float [[F:%.*]], [[F]]
; CHECK-NEXT:    ret float [[DIV]]
;
  %div = fdiv float %f, %f
  ret float %div
}

define float @fdiv_neg1(float %f) {
; CHECK-LABEL: @fdiv_neg1(
; CHECK-NEXT:    ret float -1.000000e+00
;
  %neg = fsub fast float -0.000000e+00, %f
  %div = fdiv nnan float %neg, %f
  ret float %div
}

define float @fdiv_neg2(float %f) {
; CHECK-LABEL: @fdiv_neg2(
; CHECK-NEXT:    ret float -1.000000e+00
;
  %neg = fsub fast float 0.000000e+00, %f
  %div = fdiv nnan float %neg, %f
  ret float %div
}

define float @fdiv_neg_invalid(float %f) {
; CHECK-LABEL: @fdiv_neg_invalid(
; CHECK-NEXT:    [[NEG:%.*]] = fsub fast float -0.000000e+00, [[F:%.*]]
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float [[NEG]], [[F]]
; CHECK-NEXT:    ret float [[DIV]]
;
  %neg = fsub fast float -0.000000e+00, %f
  %div = fdiv float %neg, %f
  ret float %div
}

define float @fdiv_neg_swapped1(float %f) {
; CHECK-LABEL: @fdiv_neg_swapped1(
; CHECK-NEXT:    ret float -1.000000e+00
;
  %neg = fsub float -0.000000e+00, %f
  %div = fdiv nnan float %f, %neg
  ret float %div
}

define float @fdiv_neg_swapped2(float %f) {
; CHECK-LABEL: @fdiv_neg_swapped2(
; CHECK-NEXT:    ret float -1.000000e+00
;
  %neg = fsub float 0.000000e+00, %f
  %div = fdiv nnan float %f, %neg
  ret float %div
}

define <2 x float> @fdiv_neg_vec_undef_elt(<2 x float> %f) {
; CHECK-LABEL: @fdiv_neg_vec_undef_elt(
; CHECK-NEXT:    ret <2 x float> <float -1.000000e+00, float -1.000000e+00>
;
  %neg = fsub <2 x float> <float 0.0, float undef>, %f
  %div = fdiv nnan <2 x float> %f, %neg
  ret <2 x float> %div
}

; PR21126: http://llvm.org/bugs/show_bug.cgi?id=21126
; With loose math, sqrt(X) * sqrt(X) is just X.

declare double @llvm.sqrt.f64(double)

define double @sqrt_squared(double %f) {
; CHECK-LABEL: @sqrt_squared(
; CHECK-NEXT:    ret double [[F:%.*]]
;
  %sqrt = call double @llvm.sqrt.f64(double %f)
  %mul = fmul reassoc nnan nsz double %sqrt, %sqrt
  ret double %mul
}

; Negative tests for the above transform: we need all 3 of those flags.

define double @sqrt_squared_not_fast_enough1(double %f) {
; CHECK-LABEL: @sqrt_squared_not_fast_enough1(
; CHECK-NEXT:    [[SQRT:%.*]] = call double @llvm.sqrt.f64(double [[F:%.*]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul nnan nsz double [[SQRT]], [[SQRT]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %sqrt = call double @llvm.sqrt.f64(double %f)
  %mul = fmul nnan nsz double %sqrt, %sqrt
  ret double %mul
}

define double @sqrt_squared_not_fast_enough2(double %f) {
; CHECK-LABEL: @sqrt_squared_not_fast_enough2(
; CHECK-NEXT:    [[SQRT:%.*]] = call double @llvm.sqrt.f64(double [[F:%.*]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul reassoc nnan double [[SQRT]], [[SQRT]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %sqrt = call double @llvm.sqrt.f64(double %f)
  %mul = fmul reassoc nnan double %sqrt, %sqrt
  ret double %mul
}

define double @sqrt_squared_not_fast_enough3(double %f) {
; CHECK-LABEL: @sqrt_squared_not_fast_enough3(
; CHECK-NEXT:    [[SQRT:%.*]] = call double @llvm.sqrt.f64(double [[F:%.*]])
; CHECK-NEXT:    [[MUL:%.*]] = fmul reassoc nsz double [[SQRT]], [[SQRT]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %sqrt = call double @llvm.sqrt.f64(double %f)
  %mul = fmul reassoc nsz double %sqrt, %sqrt
  ret double %mul
}

declare float @llvm.fabs.f32(float)
declare float @llvm.sqrt.f32(float)
declare float @llvm.canonicalize.f32(float)
