; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; testing-case "float fold(float a) { return 1.2f * a * 2.3f; }"
; 1.2f and 2.3f is supposed to be fold.
define float @fold(float %a) {
; CHECK-LABEL: @fold(
; CHECK-NEXT:    [[MUL1:%.*]] = fmul fast float [[A:%.*]], 0x4006147AE0000000
; CHECK-NEXT:    ret float [[MUL1]]
;
  %mul = fmul fast float %a, 0x3FF3333340000000
  %mul1 = fmul fast float %mul, 0x4002666660000000
  ret float %mul1
}

; Same testing-case as the one used in fold() except that the operators have
; fixed FP mode.
define float @notfold(float %a) {
; CHECK-LABEL: @notfold(
; CHECK-NEXT:    [[MUL:%.*]] = fmul fast float [[A:%.*]], 0x3FF3333340000000
; CHECK-NEXT:    [[MUL1:%.*]] = fmul float [[MUL]], 0x4002666660000000
; CHECK-NEXT:    ret float [[MUL1]]
;
  %mul = fmul fast float %a, 0x3FF3333340000000
  %mul1 = fmul float %mul, 0x4002666660000000
  ret float %mul1
}

define float @fold2(float %a) {
; CHECK-LABEL: @fold2(
; CHECK-NEXT:    [[MUL1:%.*]] = fmul fast float [[A:%.*]], 0x4006147AE0000000
; CHECK-NEXT:    ret float [[MUL1]]
;
  %mul = fmul float %a, 0x3FF3333340000000
  %mul1 = fmul fast float %mul, 0x4002666660000000
  ret float %mul1
}

; C * f1 + f1 = (C+1) * f1
; TODO: The particular case where C is 2 (so the folded result is 3.0*f1) is
; always safe, and so doesn't need any FMF.
; That is, (x + x + x) and (3*x) each have only a single rounding.
define double @fold3(double %f1) {
; CHECK-LABEL: @fold3(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast double [[F1:%.*]], 6.000000e+00
; CHECK-NEXT:    ret double [[TMP1]]
;
  %t1 = fmul fast double 5.000000e+00, %f1
  %t2 = fadd fast double %f1, %t1
  ret double %t2
}

; Check again with 'reassoc' and 'nsz' ('nsz' not technically required).
define double @fold3_reassoc_nsz(double %f1) {
; CHECK-LABEL: @fold3_reassoc_nsz(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul reassoc nsz double [[F1:%.*]], 6.000000e+00
; CHECK-NEXT:    ret double [[TMP1]]
;
  %t1 = fmul reassoc nsz double 5.000000e+00, %f1
  %t2 = fadd reassoc nsz double %f1, %t1
  ret double %t2
}

; TODO: This doesn't require 'nsz'.  It should fold to f1 * 6.0.
define double @fold3_reassoc(double %f1) {
; CHECK-LABEL: @fold3_reassoc(
; CHECK-NEXT:    [[T1:%.*]] = fmul reassoc double [[F1:%.*]], 5.000000e+00
; CHECK-NEXT:    [[T2:%.*]] = fadd reassoc double [[T1]], [[F1]]
; CHECK-NEXT:    ret double [[T2]]
;
  %t1 = fmul reassoc double 5.000000e+00, %f1
  %t2 = fadd reassoc double %f1, %t1
  ret double %t2
}

; (C1 - X) + (C2 - Y) => (C1+C2) - (X + Y)
define float @fold4(float %f1, float %f2) {
; CHECK-LABEL: @fold4(
; CHECK-NEXT:    [[TMP1:%.*]] = fadd fast float [[F1:%.*]], [[F2:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = fsub fast float 9.000000e+00, [[TMP1]]
; CHECK-NEXT:    ret float [[TMP2]]
;
  %sub = fsub float 4.000000e+00, %f1
  %sub1 = fsub float 5.000000e+00, %f2
  %add = fadd fast float %sub, %sub1
  ret float %add
}

; Check again with 'reassoc' and 'nsz' ('nsz' not technically required).
define float @fold4_reassoc_nsz(float %f1, float %f2) {
; CHECK-LABEL: @fold4_reassoc_nsz(
; CHECK-NEXT:    [[TMP1:%.*]] = fadd reassoc nsz float [[F1:%.*]], [[F2:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = fsub reassoc nsz float 9.000000e+00, [[TMP1]]
; CHECK-NEXT:    ret float [[TMP2]]
;
  %sub = fsub float 4.000000e+00, %f1
  %sub1 = fsub float 5.000000e+00, %f2
  %add = fadd reassoc nsz float %sub, %sub1
  ret float %add
}

; TODO: This doesn't require 'nsz'.  It should fold to (9.0 - (f1 + f2)).
define float @fold4_reassoc(float %f1, float %f2) {
; CHECK-LABEL: @fold4_reassoc(
; CHECK-NEXT:    [[SUB:%.*]] = fsub float 4.000000e+00, [[F1:%.*]]
; CHECK-NEXT:    [[SUB1:%.*]] = fsub float 5.000000e+00, [[F2:%.*]]
; CHECK-NEXT:    [[ADD:%.*]] = fadd reassoc float [[SUB]], [[SUB1]]
; CHECK-NEXT:    ret float [[ADD]]
;
  %sub = fsub float 4.000000e+00, %f1
  %sub1 = fsub float 5.000000e+00, %f2
  %add = fadd reassoc float %sub, %sub1
  ret float %add
}

; (X + C1) + C2 => X + (C1 + C2)
define float @fold5(float %f1) {
; CHECK-LABEL: @fold5(
; CHECK-NEXT:    [[ADD1:%.*]] = fadd fast float [[F1:%.*]], 9.000000e+00
; CHECK-NEXT:    ret float [[ADD1]]
;
  %add = fadd float %f1, 4.000000e+00
  %add1 = fadd fast float %add, 5.000000e+00
  ret float %add1
}

; Check again with 'reassoc' and 'nsz' ('nsz' not technically required).
define float @fold5_reassoc_nsz(float %f1) {
; CHECK-LABEL: @fold5_reassoc_nsz(
; CHECK-NEXT:    [[ADD1:%.*]] = fadd reassoc nsz float [[F1:%.*]], 9.000000e+00
; CHECK-NEXT:    ret float [[ADD1]]
;
  %add = fadd float %f1, 4.000000e+00
  %add1 = fadd reassoc nsz float %add, 5.000000e+00
  ret float %add1
}

; TODO: This doesn't require 'nsz'.  It should fold to f1 + 9.0
define float @fold5_reassoc(float %f1) {
; CHECK-LABEL: @fold5_reassoc(
; CHECK-NEXT:    [[ADD:%.*]] = fadd float [[F1:%.*]], 4.000000e+00
; CHECK-NEXT:    [[ADD1:%.*]] = fadd reassoc float [[ADD]], 5.000000e+00
; CHECK-NEXT:    ret float [[ADD1]]
;
  %add = fadd float %f1, 4.000000e+00
  %add1 = fadd reassoc float %add, 5.000000e+00
  ret float %add1
}

; (X + X) + X + X => 4.0 * X
define float @fold6(float %f1) {
; CHECK-LABEL: @fold6(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast float [[F1:%.*]], 4.000000e+00
; CHECK-NEXT:    ret float [[TMP1]]
;
  %t1 = fadd fast float %f1, %f1
  %t2 = fadd fast float %f1, %t1
  %t3 = fadd fast float %t2, %f1
  ret float %t3
}

; Check again with 'reassoc' and 'nsz' ('nsz' not technically required).
define float @fold6_reassoc_nsz(float %f1) {
; CHECK-LABEL: @fold6_reassoc_nsz(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul reassoc nsz float [[F1:%.*]], 4.000000e+00
; CHECK-NEXT:    ret float [[TMP1]]
;
  %t1 = fadd reassoc nsz float %f1, %f1
  %t2 = fadd reassoc nsz float %f1, %t1
  %t3 = fadd reassoc nsz float %t2, %f1
  ret float %t3
}

; TODO: This doesn't require 'nsz'.  It should fold to f1 * 4.0.
define float @fold6_reassoc(float %f1) {
; CHECK-LABEL: @fold6_reassoc(
; CHECK-NEXT:    [[T1:%.*]] = fadd reassoc float [[F1:%.*]], [[F1]]
; CHECK-NEXT:    [[T2:%.*]] = fadd reassoc float [[T1]], [[F1]]
; CHECK-NEXT:    [[T3:%.*]] = fadd reassoc float [[T2]], [[F1]]
; CHECK-NEXT:    ret float [[T3]]
;
  %t1 = fadd reassoc float %f1, %f1
  %t2 = fadd reassoc float %f1, %t1
  %t3 = fadd reassoc float %t2, %f1
  ret float %t3
}

; C1 * X + (X + X) = (C1 + 2) * X
define float @fold7(float %f1) {
; CHECK-LABEL: @fold7(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast float [[F1:%.*]], 7.000000e+00
; CHECK-NEXT:    ret float [[TMP1]]
;
  %t1 = fmul fast float %f1, 5.000000e+00
  %t2 = fadd fast float %f1, %f1
  %t3 = fadd fast float %t1, %t2
  ret float %t3
}

; Check again with 'reassoc' and 'nsz' ('nsz' not technically required).
define float @fold7_reassoc_nsz(float %f1) {
; CHECK-LABEL: @fold7_reassoc_nsz(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul reassoc nsz float [[F1:%.*]], 7.000000e+00
; CHECK-NEXT:    ret float [[TMP1]]
;
  %t1 = fmul reassoc nsz float %f1, 5.000000e+00
  %t2 = fadd reassoc nsz float %f1, %f1
  %t3 = fadd reassoc nsz float %t1, %t2
  ret float %t3
}

; TODO: This doesn't require 'nsz'.  It should fold to f1 * 7.0.
define float @fold7_reassoc(float %f1) {
; CHECK-LABEL: @fold7_reassoc(
; CHECK-NEXT:    [[T1:%.*]] = fmul reassoc float [[F1:%.*]], 5.000000e+00
; CHECK-NEXT:    [[T2:%.*]] = fadd reassoc float [[F1]], [[F1]]
; CHECK-NEXT:    [[T3:%.*]] = fadd reassoc float [[T1]], [[T2]]
; CHECK-NEXT:    ret float [[T3]]
;
  %t1 = fmul reassoc float %f1, 5.000000e+00
  %t2 = fadd reassoc float %f1, %f1
  %t3 = fadd reassoc float %t1, %t2
  ret float %t3
}

; (X + X) + (X + X) + X => 5.0 * X
define float @fold8(float %f1) {
; CHECK-LABEL: @fold8(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast float [[F1:%.*]], 5.000000e+00
; CHECK-NEXT:    ret float [[TMP1]]
;
  %t1 = fadd fast float %f1, %f1
  %t2 = fadd fast float %f1, %f1
  %t3 = fadd fast float %t1, %t2
  %t4 = fadd fast float %t3, %f1
  ret float %t4
}

; Check again with 'reassoc' and 'nsz' ('nsz' not technically required).
define float @fold8_reassoc_nsz(float %f1) {
; CHECK-LABEL: @fold8_reassoc_nsz(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul reassoc nsz float [[F1:%.*]], 5.000000e+00
; CHECK-NEXT:    ret float [[TMP1]]
;
  %t1 = fadd reassoc nsz float %f1, %f1
  %t2 = fadd reassoc nsz float %f1, %f1
  %t3 = fadd reassoc nsz float %t1, %t2
  %t4 = fadd reassoc nsz float %t3, %f1
  ret float %t4
}

; TODO: This doesn't require 'nsz'.  It should fold to f1 * 5.0.
define float @fold8_reassoc(float %f1) {
; CHECK-LABEL: @fold8_reassoc(
; CHECK-NEXT:    [[T1:%.*]] = fadd reassoc float [[F1:%.*]], [[F1]]
; CHECK-NEXT:    [[T2:%.*]] = fadd reassoc float [[F1]], [[F1]]
; CHECK-NEXT:    [[T3:%.*]] = fadd reassoc float [[T1]], [[T2]]
; CHECK-NEXT:    [[T4:%.*]] = fadd reassoc float [[T3]], [[F1]]
; CHECK-NEXT:    ret float [[T4]]
;
  %t1 = fadd reassoc float %f1, %f1
  %t2 = fadd reassoc float %f1, %f1
  %t3 = fadd reassoc float %t1, %t2
  %t4 = fadd reassoc float %t3, %f1
  ret float %t4
}

; Y - (X + Y) --> -X

define float @fsub_fadd_common_op_fneg(float %x, float %y) {
; CHECK-LABEL: @fsub_fadd_common_op_fneg(
; CHECK-NEXT:    [[R:%.*]] = fsub fast float -0.000000e+00, [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %a = fadd float %x, %y
  %r = fsub fast float %y, %a
  ret float %r
}

; Y - (X + Y) --> -X
; Check again with 'reassoc' and 'nsz'.
; nsz is required because: 0.0 - (0.0 + 0.0) -> 0.0, not -0.0

define float @fsub_fadd_common_op_fneg_reassoc_nsz(float %x, float %y) {
; CHECK-LABEL: @fsub_fadd_common_op_fneg_reassoc_nsz(
; CHECK-NEXT:    [[R:%.*]] = fsub reassoc nsz float -0.000000e+00, [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %a = fadd float %x, %y
  %r = fsub reassoc nsz float %y, %a
  ret float %r
}

; Y - (X + Y) --> -X

define <2 x float> @fsub_fadd_common_op_fneg_vec(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: @fsub_fadd_common_op_fneg_vec(
; CHECK-NEXT:    [[R:%.*]] = fsub reassoc nsz <2 x float> <float -0.000000e+00, float -0.000000e+00>, [[X:%.*]]
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %a = fadd <2 x float> %x, %y
  %r = fsub nsz reassoc <2 x float> %y, %a
  ret <2 x float> %r
}

; Y - (Y + X) --> -X
; Commute operands of the 'add'.

define float @fsub_fadd_common_op_fneg_commute(float %x, float %y) {
; CHECK-LABEL: @fsub_fadd_common_op_fneg_commute(
; CHECK-NEXT:    [[R:%.*]] = fsub reassoc nsz float -0.000000e+00, [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %a = fadd float %y, %x
  %r = fsub reassoc nsz float %y, %a
  ret float %r
}

; Y - (Y + X) --> -X

define <2 x float> @fsub_fadd_common_op_fneg_commute_vec(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: @fsub_fadd_common_op_fneg_commute_vec(
; CHECK-NEXT:    [[R:%.*]] = fsub reassoc nsz <2 x float> <float -0.000000e+00, float -0.000000e+00>, [[X:%.*]]
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %a = fadd <2 x float> %y, %x
  %r = fsub reassoc nsz <2 x float> %y, %a
  ret <2 x float> %r
}

; (Y - X) - Y --> -X
; nsz is required because: (0.0 - 0.0) - 0.0 -> 0.0, not -0.0

define float @fsub_fsub_common_op_fneg(float %x, float %y) {
; CHECK-LABEL: @fsub_fsub_common_op_fneg(
; CHECK-NEXT:    [[R:%.*]] = fsub reassoc nsz float -0.000000e+00, [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %s = fsub float %y, %x
  %r = fsub reassoc nsz float %s, %y
  ret float %r
}

; (Y - X) - Y --> -X

define <2 x float> @fsub_fsub_common_op_fneg_vec(<2 x float> %x, <2 x float> %y) {
; CHECK-LABEL: @fsub_fsub_common_op_fneg_vec(
; CHECK-NEXT:    [[R:%.*]] = fsub reassoc nsz <2 x float> <float -0.000000e+00, float -0.000000e+00>, [[X:%.*]]
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %s = fsub <2 x float> %y, %x
  %r = fsub reassoc nsz <2 x float> %s, %y
  ret <2 x float> %r
}

; TODO: This doesn't require 'nsz'.  It should fold to 0 - f2
define float @fold9_reassoc(float %f1, float %f2) {
; CHECK-LABEL: @fold9_reassoc(
; CHECK-NEXT:    [[T1:%.*]] = fadd float [[F1:%.*]], [[F2:%.*]]
; CHECK-NEXT:    [[T3:%.*]] = fsub reassoc float [[F1]], [[T1]]
; CHECK-NEXT:    ret float [[T3]]
;
  %t1 = fadd float %f1, %f2
  %t3 = fsub reassoc float %f1, %t1
  ret float %t3
}

; Let C3 = C1 + C2. (f1 + C1) + (f2 + C2) => (f1 + f2) + C3 instead of
; "(f1 + C3) + f2" or "(f2 + C3) + f1". Placing constant-addend at the
; top of resulting simplified expression tree may potentially reveal some
; optimization opportunities in the super-expression trees.
;
define float @fold10(float %f1, float %f2) {
; CHECK-LABEL: @fold10(
; CHECK-NEXT:    [[T2:%.*]] = fadd fast float [[F1:%.*]], [[F2:%.*]]
; CHECK-NEXT:    [[T3:%.*]] = fadd fast float [[T2]], -1.000000e+00
; CHECK-NEXT:    ret float [[T3]]
;
  %t1 = fadd fast float 2.000000e+00, %f1
  %t2 = fsub fast float %f2, 3.000000e+00
  %t3 = fadd fast float %t1, %t2
  ret float %t3
}

; Check again with 'reassoc' and 'nsz'.
; TODO: We may be able to remove the 'nsz' requirement.
define float @fold10_reassoc_nsz(float %f1, float %f2) {
; CHECK-LABEL: @fold10_reassoc_nsz(
; CHECK-NEXT:    [[T2:%.*]] = fadd reassoc nsz float [[F1:%.*]], [[F2:%.*]]
; CHECK-NEXT:    [[T3:%.*]] = fadd reassoc nsz float [[T2]], -1.000000e+00
; CHECK-NEXT:    ret float [[T3]]
;
  %t1 = fadd reassoc nsz float 2.000000e+00, %f1
  %t2 = fsub reassoc nsz float %f2, 3.000000e+00
  %t3 = fadd reassoc nsz float %t1, %t2
  ret float %t3
}

; Observe that the fold is not done with only reassoc (the instructions are
; canonicalized, but not folded).
; TODO: As noted above, 'nsz' may not be required for this to be fully folded.
define float @fold10_reassoc(float %f1, float %f2) {
; CHECK-LABEL: @fold10_reassoc(
; CHECK-NEXT:    [[T1:%.*]] = fadd reassoc float [[F1:%.*]], 2.000000e+00
; CHECK-NEXT:    [[T2:%.*]] = fadd reassoc float [[F2:%.*]], -3.000000e+00
; CHECK-NEXT:    [[T3:%.*]] = fadd reassoc float [[T1]], [[T2]]
; CHECK-NEXT:    ret float [[T3]]
;
  %t1 = fadd reassoc float 2.000000e+00, %f1
  %t2 = fsub reassoc float %f2, 3.000000e+00
  %t3 = fadd reassoc float %t1, %t2
  ret float %t3
}

; This used to crash/miscompile.

define float @fail1(float %f1, float %f2) {
; CHECK-LABEL: @fail1(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast float [[F1:%.*]], 3.000000e+00
; CHECK-NEXT:    [[TMP2:%.*]] = fadd fast float [[TMP1]], -3.000000e+00
; CHECK-NEXT:    ret float [[TMP2]]
;
  %conv3 = fadd fast float %f1, -1.000000e+00
  %add = fadd fast float %conv3, %conv3
  %add2 = fadd fast float %add, %conv3
  ret float %add2
}

define double @fail2(double %f1, double %f2) {
; CHECK-LABEL: @fail2(
; CHECK-NEXT:    [[TMP1:%.*]] = fadd fast double [[F2:%.*]], [[F2]]
; CHECK-NEXT:    [[TMP2:%.*]] = fsub fast double -0.000000e+00, [[TMP1]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %t1 = fsub fast double %f1, %f2
  %t2 = fadd fast double %f1, %f2
  %t3 = fsub fast double %t1, %t2
  ret double %t3
}

; (X * C) - X --> X * (C - 1.0)

define float @fsub_op0_fmul_const(float %x) {
; CHECK-LABEL: @fsub_op0_fmul_const(
; CHECK-NEXT:    [[SUB:%.*]] = fmul reassoc nsz float [[X:%.*]], 6.000000e+00
; CHECK-NEXT:    ret float [[SUB]]
;
  %mul = fmul float %x, 7.0
  %sub = fsub reassoc nsz float %mul, %x
  ret float %sub
}

; (X * C) - X --> X * (C - 1.0)

define <2 x float> @fsub_op0_fmul_const_vec(<2 x float> %x) {
; CHECK-LABEL: @fsub_op0_fmul_const_vec(
; CHECK-NEXT:    [[SUB:%.*]] = fmul reassoc nsz <2 x float> [[X:%.*]], <float 6.000000e+00, float -4.300000e+01>
; CHECK-NEXT:    ret <2 x float> [[SUB]]
;
  %mul = fmul <2 x float> %x, <float 7.0, float -42.0>
  %sub = fsub reassoc nsz <2 x float> %mul, %x
  ret <2 x float> %sub
}

; X - (X * C) --> X * (1.0 - C)

define float @fsub_op1_fmul_const(float %x) {
; CHECK-LABEL: @fsub_op1_fmul_const(
; CHECK-NEXT:    [[SUB:%.*]] = fmul reassoc nsz float [[X:%.*]], -6.000000e+00
; CHECK-NEXT:    ret float [[SUB]]
;
  %mul = fmul float %x, 7.0
  %sub = fsub reassoc nsz float %x, %mul
  ret float %sub
}

; X - (X * C) --> X * (1.0 - C)

define <2 x float> @fsub_op1_fmul_const_vec(<2 x float> %x) {
; CHECK-LABEL: @fsub_op1_fmul_const_vec(
; CHECK-NEXT:    [[SUB:%.*]] = fmul reassoc nsz <2 x float> [[X:%.*]], <float -6.000000e+00, float 1.000000e+00>
; CHECK-NEXT:    ret <2 x float> [[SUB]]
;
  %mul = fmul <2 x float> %x, <float 7.0, float 0.0>
  %sub = fsub reassoc nsz <2 x float> %x, %mul
  ret <2 x float> %sub
}

; Verify the fold is not done with only 'reassoc' ('nsz' is required).

define float @fsub_op0_fmul_const_wrong_FMF(float %x) {
; CHECK-LABEL: @fsub_op0_fmul_const_wrong_FMF(
; CHECK-NEXT:    [[MUL:%.*]] = fmul reassoc float [[X:%.*]], 7.000000e+00
; CHECK-NEXT:    [[SUB:%.*]] = fsub reassoc float [[MUL]], [[X]]
; CHECK-NEXT:    ret float [[SUB]]
;
  %mul = fmul reassoc float %x, 7.0
  %sub = fsub reassoc float %mul, %x
  ret float %sub
}

; (select X+Y, X-Y) => X + (select Y, -Y)
; This is always safe.  No FMF required.
define float @fold16(float %x, float %y) {
; CHECK-LABEL: @fold16(
; CHECK-NEXT:    [[CMP:%.*]] = fcmp ogt float [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = fsub float -0.000000e+00, [[Y]]
; CHECK-NEXT:    [[R_P:%.*]] = select i1 [[CMP]], float [[Y]], float [[TMP1]]
; CHECK-NEXT:    [[R:%.*]] = fadd float [[R_P]], [[X]]
; CHECK-NEXT:    ret float [[R]]
;
  %cmp = fcmp ogt float %x, %y
  %plus = fadd float %x, %y
  %minus = fsub float %x, %y
  %r = select i1 %cmp, float %plus, float %minus
  ret float %r
}

; =========================================================================
;
;   Testing-cases about negation
;
; =========================================================================
define float @fneg1(float %f1, float %f2) {
; CHECK-LABEL: @fneg1(
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[F1:%.*]], [[F2:%.*]]
; CHECK-NEXT:    ret float [[MUL]]
;
  %sub = fsub float -0.000000e+00, %f1
  %sub1 = fsub nsz float 0.000000e+00, %f2
  %mul = fmul float %sub, %sub1
  ret float %mul
}

define float @fneg2(float %x) {
; CHECK-LABEL: @fneg2(
; CHECK-NEXT:    [[SUB:%.*]] = fsub nsz float -0.000000e+00, [[X:%.*]]
; CHECK-NEXT:    ret float [[SUB]]
;
  %sub = fsub nsz float 0.0, %x
  ret float %sub
}

define <2 x float> @fneg2_vec_undef(<2 x float> %x) {
; CHECK-LABEL: @fneg2_vec_undef(
; CHECK-NEXT:    [[SUB:%.*]] = fsub nsz <2 x float> <float -0.000000e+00, float -0.000000e+00>, [[X:%.*]]
; CHECK-NEXT:    ret <2 x float> [[SUB]]
;
  %sub = fsub nsz <2 x float> <float undef, float 0.0>, %x
  ret <2 x float> %sub
}

; =========================================================================
;
;   Testing-cases about div
;
; =========================================================================

; X/C1 / C2 => X * (1/(C2*C1))
define float @fdiv1(float %x) {
; CHECK-LABEL: @fdiv1(
; CHECK-NEXT:    [[DIV1:%.*]] = fmul fast float [[X:%.*]], 0x3FD7303B60000000
; CHECK-NEXT:    ret float [[DIV1]]
;
  %div = fdiv float %x, 0x3FF3333340000000
  %div1 = fdiv fast float %div, 0x4002666660000000
  ret float %div1
; 0x3FF3333340000000 = 1.2f
; 0x4002666660000000 = 2.3f
; 0x3FD7303B60000000 = 0.36231884057971014492
}

; X*C1 / C2 => X * (C1/C2)
define float @fdiv2(float %x) {
; CHECK-LABEL: @fdiv2(
; CHECK-NEXT:    [[DIV1:%.*]] = fmul fast float [[X:%.*]], 0x3FE0B21660000000
; CHECK-NEXT:    ret float [[DIV1]]
;
  %mul = fmul float %x, 0x3FF3333340000000
  %div1 = fdiv fast float %mul, 0x4002666660000000
  ret float %div1

; 0x3FF3333340000000 = 1.2f
; 0x4002666660000000 = 2.3f
; 0x3FE0B21660000000 = 0.52173918485641479492
}

define <2 x float> @fdiv2_vec(<2 x float> %x) {
; CHECK-LABEL: @fdiv2_vec(
; CHECK-NEXT:    [[DIV1:%.*]] = fmul fast <2 x float> [[X:%.*]], <float 3.000000e+00, float 3.000000e+00>
; CHECK-NEXT:    ret <2 x float> [[DIV1]]
;
  %mul = fmul <2 x float> %x, <float 6.0, float 9.0>
  %div1 = fdiv fast <2 x float> %mul, <float 2.0, float 3.0>
  ret <2 x float> %div1
}

; "X/C1 / C2 => X * (1/(C2*C1))" is disabled (for now) is C2/C1 is a denormal
;
define float @fdiv3(float %x) {
; CHECK-LABEL: @fdiv3(
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast float [[X:%.*]], 0x3FDBD37A80000000
; CHECK-NEXT:    [[DIV1:%.*]] = fdiv fast float [[TMP1]], 0x47EFFFFFE0000000
; CHECK-NEXT:    ret float [[DIV1]]
;
  %div = fdiv float %x, 0x47EFFFFFE0000000
  %div1 = fdiv fast float %div, 0x4002666660000000
  ret float %div1
}

; "X*C1 / C2 => X * (C1/C2)" is disabled if C1/C2 is a denormal
define float @fdiv4(float %x) {
; CHECK-LABEL: @fdiv4(
; CHECK-NEXT:    [[MUL:%.*]] = fmul float [[X:%.*]], 0x47EFFFFFE0000000
; CHECK-NEXT:    [[DIV:%.*]] = fdiv float [[MUL]], 0x3FC99999A0000000
; CHECK-NEXT:    ret float [[DIV]]
;
  %mul = fmul float %x, 0x47EFFFFFE0000000
  %div = fdiv float %mul, 0x3FC99999A0000000
  ret float %div
}

; =========================================================================
;
;   Test-cases for square root
;
; =========================================================================

; A squared factor fed into a square root intrinsic should be hoisted out
; as a fabs() value.

declare double @llvm.sqrt.f64(double)

define double @sqrt_intrinsic_arg_squared(double %x) {
; CHECK-LABEL: @sqrt_intrinsic_arg_squared(
; CHECK-NEXT:    [[FABS:%.*]] = call fast double @llvm.fabs.f64(double [[X:%.*]])
; CHECK-NEXT:    ret double [[FABS]]
;
  %mul = fmul fast double %x, %x
  %sqrt = call fast double @llvm.sqrt.f64(double %mul)
  ret double %sqrt
}

; Check all 6 combinations of a 3-way multiplication tree where
; one factor is repeated.

define double @sqrt_intrinsic_three_args1(double %x, double %y) {
; CHECK-LABEL: @sqrt_intrinsic_three_args1(
; CHECK-NEXT:    [[FABS:%.*]] = call fast double @llvm.fabs.f64(double [[X:%.*]])
; CHECK-NEXT:    [[SQRT1:%.*]] = call fast double @llvm.sqrt.f64(double [[Y:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast double [[FABS]], [[SQRT1]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %mul = fmul fast double %y, %x
  %mul2 = fmul fast double %mul, %x
  %sqrt = call fast double @llvm.sqrt.f64(double %mul2)
  ret double %sqrt
}

define double @sqrt_intrinsic_three_args2(double %x, double %y) {
; CHECK-LABEL: @sqrt_intrinsic_three_args2(
; CHECK-NEXT:    [[FABS:%.*]] = call fast double @llvm.fabs.f64(double [[X:%.*]])
; CHECK-NEXT:    [[SQRT1:%.*]] = call fast double @llvm.sqrt.f64(double [[Y:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast double [[FABS]], [[SQRT1]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %mul = fmul fast double %x, %y
  %mul2 = fmul fast double %mul, %x
  %sqrt = call fast double @llvm.sqrt.f64(double %mul2)
  ret double %sqrt
}

define double @sqrt_intrinsic_three_args3(double %x, double %y) {
; CHECK-LABEL: @sqrt_intrinsic_three_args3(
; CHECK-NEXT:    [[FABS:%.*]] = call fast double @llvm.fabs.f64(double [[X:%.*]])
; CHECK-NEXT:    [[SQRT1:%.*]] = call fast double @llvm.sqrt.f64(double [[Y:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast double [[FABS]], [[SQRT1]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %mul = fmul fast double %x, %x
  %mul2 = fmul fast double %mul, %y
  %sqrt = call fast double @llvm.sqrt.f64(double %mul2)
  ret double %sqrt
}

define double @sqrt_intrinsic_three_args4(double %x, double %y) {
; CHECK-LABEL: @sqrt_intrinsic_three_args4(
; CHECK-NEXT:    [[FABS:%.*]] = call fast double @llvm.fabs.f64(double [[X:%.*]])
; CHECK-NEXT:    [[SQRT1:%.*]] = call fast double @llvm.sqrt.f64(double [[Y:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast double [[FABS]], [[SQRT1]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %mul = fmul fast double %y, %x
  %mul2 = fmul fast double %x, %mul
  %sqrt = call fast double @llvm.sqrt.f64(double %mul2)
  ret double %sqrt
}

define double @sqrt_intrinsic_three_args5(double %x, double %y) {
; CHECK-LABEL: @sqrt_intrinsic_three_args5(
; CHECK-NEXT:    [[FABS:%.*]] = call fast double @llvm.fabs.f64(double [[X:%.*]])
; CHECK-NEXT:    [[SQRT1:%.*]] = call fast double @llvm.sqrt.f64(double [[Y:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast double [[FABS]], [[SQRT1]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %mul = fmul fast double %x, %y
  %mul2 = fmul fast double %x, %mul
  %sqrt = call fast double @llvm.sqrt.f64(double %mul2)
  ret double %sqrt
}

define double @sqrt_intrinsic_three_args6(double %x, double %y) {
; CHECK-LABEL: @sqrt_intrinsic_three_args6(
; CHECK-NEXT:    [[FABS:%.*]] = call fast double @llvm.fabs.f64(double [[X:%.*]])
; CHECK-NEXT:    [[SQRT1:%.*]] = call fast double @llvm.sqrt.f64(double [[Y:%.*]])
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast double [[FABS]], [[SQRT1]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %mul = fmul fast double %x, %x
  %mul2 = fmul fast double %y, %mul
  %sqrt = call fast double @llvm.sqrt.f64(double %mul2)
  ret double %sqrt
}

; If any operation is not 'fast', we can't simplify.

define double @sqrt_intrinsic_not_so_fast(double %x, double %y) {
; CHECK-LABEL: @sqrt_intrinsic_not_so_fast(
; CHECK-NEXT:    [[MUL:%.*]] = fmul double [[X:%.*]], [[X]]
; CHECK-NEXT:    [[MUL2:%.*]] = fmul fast double [[MUL]], [[Y:%.*]]
; CHECK-NEXT:    [[SQRT:%.*]] = call fast double @llvm.sqrt.f64(double [[MUL2]])
; CHECK-NEXT:    ret double [[SQRT]]
;
  %mul = fmul double %x, %x
  %mul2 = fmul fast double %mul, %y
  %sqrt = call fast double @llvm.sqrt.f64(double %mul2)
  ret double %sqrt
}

define double @sqrt_intrinsic_arg_4th(double %x) {
; CHECK-LABEL: @sqrt_intrinsic_arg_4th(
; CHECK-NEXT:    [[MUL:%.*]] = fmul fast double [[X:%.*]], [[X]]
; CHECK-NEXT:    ret double [[MUL]]
;
  %mul = fmul fast double %x, %x
  %mul2 = fmul fast double %mul, %mul
  %sqrt = call fast double @llvm.sqrt.f64(double %mul2)
  ret double %sqrt
}

define double @sqrt_intrinsic_arg_5th(double %x) {
; CHECK-LABEL: @sqrt_intrinsic_arg_5th(
; CHECK-NEXT:    [[MUL:%.*]] = fmul fast double [[X:%.*]], [[X]]
; CHECK-NEXT:    [[SQRT1:%.*]] = call fast double @llvm.sqrt.f64(double [[X]])
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast double [[MUL]], [[SQRT1]]
; CHECK-NEXT:    ret double [[TMP1]]
;
  %mul = fmul fast double %x, %x
  %mul2 = fmul fast double %mul, %x
  %mul3 = fmul fast double %mul2, %mul
  %sqrt = call fast double @llvm.sqrt.f64(double %mul3)
  ret double %sqrt
}

; Check that square root calls have the same behavior.

declare float @sqrtf(float)
declare double @sqrt(double)
declare fp128 @sqrtl(fp128)

define float @sqrt_call_squared_f32(float %x) {
; CHECK-LABEL: @sqrt_call_squared_f32(
; CHECK-NEXT:    [[FABS:%.*]] = call fast float @llvm.fabs.f32(float [[X:%.*]])
; CHECK-NEXT:    ret float [[FABS]]
;
  %mul = fmul fast float %x, %x
  %sqrt = call fast float @sqrtf(float %mul)
  ret float %sqrt
}

define double @sqrt_call_squared_f64(double %x) {
; CHECK-LABEL: @sqrt_call_squared_f64(
; CHECK-NEXT:    [[FABS:%.*]] = call fast double @llvm.fabs.f64(double [[X:%.*]])
; CHECK-NEXT:    ret double [[FABS]]
;
  %mul = fmul fast double %x, %x
  %sqrt = call fast double @sqrt(double %mul)
  ret double %sqrt
}

define fp128 @sqrt_call_squared_f128(fp128 %x) {
; CHECK-LABEL: @sqrt_call_squared_f128(
; CHECK-NEXT:    [[FABS:%.*]] = call fast fp128 @llvm.fabs.f128(fp128 [[X:%.*]])
; CHECK-NEXT:    ret fp128 [[FABS]]
;
  %mul = fmul fast fp128 %x, %x
  %sqrt = call fast fp128 @sqrtl(fp128 %mul)
  ret fp128 %sqrt
}

; =========================================================================
;
;   Test-cases for fmin / fmax
;
; =========================================================================

declare double @fmax(double, double)
declare double @fmin(double, double)
declare float @fmaxf(float, float)
declare float @fminf(float, float)
declare fp128 @fmaxl(fp128, fp128)
declare fp128 @fminl(fp128, fp128)

; No NaNs is the minimum requirement to replace these calls.
; This should always be set when unsafe-fp-math is true, but
; alternate the attributes for additional test coverage.
; 'nsz' is implied by the definition of fmax or fmin itself.

; Shrink and remove the call.
define float @max1(float %a, float %b) {
; CHECK-LABEL: @max1(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp fast ogt float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], float [[A]], float [[B]]
; CHECK-NEXT:    ret float [[TMP2]]
;
  %c = fpext float %a to double
  %d = fpext float %b to double
  %e = call fast double @fmax(double %c, double %d)
  %f = fptrunc double %e to float
  ret float %f
}

define float @max2(float %a, float %b) {
; CHECK-LABEL: @max2(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp nnan nsz ogt float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], float [[A]], float [[B]]
; CHECK-NEXT:    ret float [[TMP2]]
;
  %c = call nnan float @fmaxf(float %a, float %b)
  ret float %c
}


define double @max3(double %a, double %b) {
; CHECK-LABEL: @max3(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp fast ogt double [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], double [[A]], double [[B]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %c = call fast double @fmax(double %a, double %b)
  ret double %c
}

define fp128 @max4(fp128 %a, fp128 %b) {
; CHECK-LABEL: @max4(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp nnan nsz ogt fp128 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], fp128 [[A]], fp128 [[B]]
; CHECK-NEXT:    ret fp128 [[TMP2]]
;
  %c = call nnan fp128 @fmaxl(fp128 %a, fp128 %b)
  ret fp128 %c
}

; Shrink and remove the call.
define float @min1(float %a, float %b) {
; CHECK-LABEL: @min1(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp nnan nsz olt float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], float [[A]], float [[B]]
; CHECK-NEXT:    ret float [[TMP2]]
;
  %c = fpext float %a to double
  %d = fpext float %b to double
  %e = call nnan double @fmin(double %c, double %d)
  %f = fptrunc double %e to float
  ret float %f
}

define float @min2(float %a, float %b) {
; CHECK-LABEL: @min2(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp fast olt float [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], float [[A]], float [[B]]
; CHECK-NEXT:    ret float [[TMP2]]
;
  %c = call fast float @fminf(float %a, float %b)
  ret float %c
}

define double @min3(double %a, double %b) {
; CHECK-LABEL: @min3(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp nnan nsz olt double [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], double [[A]], double [[B]]
; CHECK-NEXT:    ret double [[TMP2]]
;
  %c = call nnan double @fmin(double %a, double %b)
  ret double %c
}

define fp128 @min4(fp128 %a, fp128 %b) {
; CHECK-LABEL: @min4(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp fast olt fp128 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = select i1 [[TMP1]], fp128 [[A]], fp128 [[B]]
; CHECK-NEXT:    ret fp128 [[TMP2]]
;
  %c = call fast fp128 @fminl(fp128 %a, fp128 %b)
  ret fp128 %c
}

; ((which ? 2.0 : a) + 1.0) => (which ? 3.0 : (a + 1.0))
; This is always safe.  No FMF required.
define float @test55(i1 %which, float %a) {
; CHECK-LABEL: @test55(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[WHICH:%.*]], label [[FINAL:%.*]], label [[DELAY:%.*]]
; CHECK:       delay:
; CHECK-NEXT:    [[PHITMP:%.*]] = fadd float [[A:%.*]], 1.000000e+00
; CHECK-NEXT:    br label [[FINAL]]
; CHECK:       final:
; CHECK-NEXT:    [[A:%.*]] = phi float [ 3.000000e+00, [[ENTRY:%.*]] ], [ [[PHITMP]], [[DELAY]] ]
; CHECK-NEXT:    ret float [[A]]
;
entry:
  br i1 %which, label %final, label %delay

delay:
  br label %final

final:
  %A = phi float [ 2.0, %entry ], [ %a, %delay ]
  %value = fadd float %A, 1.0
  ret float %value
}
