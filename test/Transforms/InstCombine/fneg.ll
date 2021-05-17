; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

declare void @use(float)

define float @fneg_fneg(float %a) {
;
; CHECK-LABEL: @fneg_fneg(
; CHECK-NEXT:    ret float [[A:%.*]]
;
  %f = fneg float %a
  %r = fneg float %f
  ret float %r
}

; -(X * C) --> X * (-C)

define float @fmul_fsub(float %x) {
; CHECK-LABEL: @fmul_fsub(
; CHECK-NEXT:    [[R:%.*]] = fmul float [[X:%.*]], -4.200000e+01
; CHECK-NEXT:    ret float [[R]]
;
  %m = fmul float %x, 42.0
  %r = fsub float -0.0, %m
  ret float %r
}

define float @fmul_fneg(float %x) {
; CHECK-LABEL: @fmul_fneg(
; CHECK-NEXT:    [[R:%.*]] = fmul float [[X:%.*]], -4.200000e+01
; CHECK-NEXT:    ret float [[R]]
;
  %m = fmul float %x, 42.0
  %r = fneg float %m
  ret float %r
}

; Fast math is not required, but it should be propagated.

define float @fmul_fsub_fmf(float %x) {
; CHECK-LABEL: @fmul_fsub_fmf(
; CHECK-NEXT:    [[R:%.*]] = fmul reassoc nsz float [[X:%.*]], -4.200000e+01
; CHECK-NEXT:    ret float [[R]]
;
  %m = fmul float %x, 42.0
  %r = fsub reassoc nsz float -0.0, %m
  ret float %r
}

define float @fmul_fneg_fmf(float %x) {
; CHECK-LABEL: @fmul_fneg_fmf(
; CHECK-NEXT:    [[R:%.*]] = fmul reassoc nsz float [[X:%.*]], -4.200000e+01
; CHECK-NEXT:    ret float [[R]]
;
  %m = fmul float %x, 42.0
  %r = fneg reassoc nsz float %m
  ret float %r
}

; Extra use prevents the fold. We don't want to replace the fneg with an fmul.

define float @fmul_fsub_extra_use(float %x) {
; CHECK-LABEL: @fmul_fsub_extra_use(
; CHECK-NEXT:    [[M:%.*]] = fmul float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    [[R:%.*]] = fneg float [[M]]
; CHECK-NEXT:    call void @use(float [[M]])
; CHECK-NEXT:    ret float [[R]]
;
  %m = fmul float %x, 42.0
  %r = fsub float -0.0, %m
  call void @use(float %m)
  ret float %r
}

define float @fmul_fneg_extra_use(float %x) {
; CHECK-LABEL: @fmul_fneg_extra_use(
; CHECK-NEXT:    [[M:%.*]] = fmul float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    [[R:%.*]] = fneg float [[M]]
; CHECK-NEXT:    call void @use(float [[M]])
; CHECK-NEXT:    ret float [[R]]
;
  %m = fmul float %x, 42.0
  %r = fneg float %m
  call void @use(float %m)
  ret float %r
}

; Try a vector. Use special constants (NaN, INF, undef) because they don't change anything.

define <4 x double> @fmul_fsub_vec(<4 x double> %x) {
; CHECK-LABEL: @fmul_fsub_vec(
; CHECK-NEXT:    [[R:%.*]] = fmul <4 x double> [[X:%.*]], <double -4.200000e+01, double 0xFFF8000000000000, double 0xFFF0000000000000, double undef>
; CHECK-NEXT:    ret <4 x double> [[R]]
;
  %m = fmul <4 x double> %x, <double 42.0, double 0x7FF8000000000000, double 0x7FF0000000000000, double undef>
  %r = fsub <4 x double> <double -0.0, double -0.0, double -0.0, double -0.0>, %m
  ret <4 x double> %r
}

define <4 x double> @fmul_fneg_vec(<4 x double> %x) {
; CHECK-LABEL: @fmul_fneg_vec(
; CHECK-NEXT:    [[R:%.*]] = fmul <4 x double> [[X:%.*]], <double -4.200000e+01, double 0xFFF8000000000000, double 0xFFF0000000000000, double undef>
; CHECK-NEXT:    ret <4 x double> [[R]]
;
  %m = fmul <4 x double> %x, <double 42.0, double 0x7FF8000000000000, double 0x7FF0000000000000, double undef>
  %r = fneg <4 x double> %m
  ret <4 x double> %r
}

; -(X / C) --> X / (-C)

define float @fdiv_op1_constant_fsub(float %x) {
; CHECK-LABEL: @fdiv_op1_constant_fsub(
; CHECK-NEXT:    [[R:%.*]] = fdiv float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float %x, -42.0
  %r = fsub float -0.0, %d
  ret float %r
}

define float @fdiv_op1_constant_fneg(float %x) {
; CHECK-LABEL: @fdiv_op1_constant_fneg(
; CHECK-NEXT:    [[R:%.*]] = fdiv float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float %x, -42.0
  %r = fneg float %d
  ret float %r
}

; Fast math is not required, but it should be propagated.

define float @fdiv_op1_constant_fsub_fmf(float %x) {
; CHECK-LABEL: @fdiv_op1_constant_fsub_fmf(
; CHECK-NEXT:    [[R:%.*]] = fdiv nnan float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float %x, -42.0
  %r = fsub nnan float -0.0, %d
  ret float %r
}

define float @fdiv_op1_constant_fneg_fmf(float %x) {
; CHECK-LABEL: @fdiv_op1_constant_fneg_fmf(
; CHECK-NEXT:    [[R:%.*]] = fdiv nnan float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float %x, -42.0
  %r = fneg nnan float %d
  ret float %r
}

; Extra use prevents the fold. We don't want to replace the fneg with an fdiv.

define float @fdiv_op1_constant_fsub_extra_use(float %x) {
; CHECK-LABEL: @fdiv_op1_constant_fsub_extra_use(
; CHECK-NEXT:    [[D:%.*]] = fdiv float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    [[R:%.*]] = fneg float [[D]]
; CHECK-NEXT:    call void @use(float [[D]])
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float %x, 42.0
  %r = fsub float -0.0, %d
  call void @use(float %d)
  ret float %r
}

define float @fdiv_op1_constant_fneg_extra_use(float %x) {
; CHECK-LABEL: @fdiv_op1_constant_fneg_extra_use(
; CHECK-NEXT:    [[D:%.*]] = fdiv float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    [[R:%.*]] = fneg float [[D]]
; CHECK-NEXT:    call void @use(float [[D]])
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float %x, 42.0
  %r = fneg float %d
  call void @use(float %d)
  ret float %r
}

; Try a vector. Use special constants (NaN, INF, undef) because they don't change anything.

define <4 x double> @fdiv_op1_constant_fsub_vec(<4 x double> %x) {
; CHECK-LABEL: @fdiv_op1_constant_fsub_vec(
; CHECK-NEXT:    [[R:%.*]] = fdiv <4 x double> [[X:%.*]], <double 4.200000e+01, double 0x7FF800000ABCD000, double 0x7FF0000000000000, double undef>
; CHECK-NEXT:    ret <4 x double> [[R]]
;
  %d = fdiv <4 x double> %x, <double -42.0, double 0xFFF800000ABCD000, double 0xFFF0000000000000, double undef>
  %r = fsub <4 x double> <double -0.0, double -0.0, double -0.0, double -0.0>, %d
  ret <4 x double> %r
}

define <4 x double> @fdiv_op1_constant_fneg_vec(<4 x double> %x) {
; CHECK-LABEL: @fdiv_op1_constant_fneg_vec(
; CHECK-NEXT:    [[R:%.*]] = fdiv <4 x double> [[X:%.*]], <double 4.200000e+01, double 0x7FF800000ABCD000, double 0x7FF0000000000000, double undef>
; CHECK-NEXT:    ret <4 x double> [[R]]
;
  %d = fdiv <4 x double> %x, <double -42.0, double 0xFFF800000ABCD000, double 0xFFF0000000000000, double undef>
  %r = fneg <4 x double> %d
  ret <4 x double> %r
}

; -(C / X) --> (-C) / X

define float @fdiv_op0_constant_fsub(float %x) {
; CHECK-LABEL: @fdiv_op0_constant_fsub(
; CHECK-NEXT:    [[R:%.*]] = fdiv float -4.200000e+01, [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float 42.0, %x
  %r = fsub float -0.0, %d
  ret float %r
}

define float @fdiv_op0_constant_fneg(float %x) {
; CHECK-LABEL: @fdiv_op0_constant_fneg(
; CHECK-NEXT:    [[R:%.*]] = fdiv float -4.200000e+01, [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float 42.0, %x
  %r = fneg float %d
  ret float %r
}

; Fast math is not required, but it should be propagated.

define float @fdiv_op0_constant_fsub_fmf(float %x) {
; CHECK-LABEL: @fdiv_op0_constant_fsub_fmf(
; CHECK-NEXT:    [[R:%.*]] = fdiv fast float -4.200000e+01, [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float 42.0, %x
  %r = fsub fast float -0.0, %d
  ret float %r
}

define float @fdiv_op0_constant_fneg_fmf(float %x) {
; CHECK-LABEL: @fdiv_op0_constant_fneg_fmf(
; CHECK-NEXT:    [[R:%.*]] = fdiv fast float -4.200000e+01, [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float 42.0, %x
  %r = fneg fast float %d
  ret float %r
}

; Extra use prevents the fold. We don't want to replace the fneg with an fdiv.

define float @fdiv_op0_constant_fsub_extra_use(float %x) {
; CHECK-LABEL: @fdiv_op0_constant_fsub_extra_use(
; CHECK-NEXT:    [[D:%.*]] = fdiv float -4.200000e+01, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = fneg float [[D]]
; CHECK-NEXT:    call void @use(float [[D]])
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float -42.0, %x
  %r = fsub float -0.0, %d
  call void @use(float %d)
  ret float %r
}

define float @fdiv_op0_constant_fneg_extra_use(float %x) {
; CHECK-LABEL: @fdiv_op0_constant_fneg_extra_use(
; CHECK-NEXT:    [[D:%.*]] = fdiv float -4.200000e+01, [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = fneg float [[D]]
; CHECK-NEXT:    call void @use(float [[D]])
; CHECK-NEXT:    ret float [[R]]
;
  %d = fdiv float -42.0, %x
  %r = fneg float %d
  call void @use(float %d)
  ret float %r
}

; Try a vector. Use special constants (NaN, INF, undef) because they don't change anything.

define <4 x double> @fdiv_op0_constant_fsub_vec(<4 x double> %x) {
; CHECK-LABEL: @fdiv_op0_constant_fsub_vec(
; CHECK-NEXT:    [[R:%.*]] = fdiv <4 x double> <double 4.200000e+01, double 0xFFF8000000000000, double 0x7FF0000000000000, double undef>, [[X:%.*]]
; CHECK-NEXT:    ret <4 x double> [[R]]
;
  %d = fdiv <4 x double> <double -42.0, double 0x7FF8000000000000, double 0xFFF0000000000000, double undef>, %x
  %r = fsub <4 x double> <double -0.0, double -0.0, double -0.0, double -0.0>, %d
  ret <4 x double> %r
}

define <4 x double> @fdiv_op0_constant_fneg_vec(<4 x double> %x) {
; CHECK-LABEL: @fdiv_op0_constant_fneg_vec(
; CHECK-NEXT:    [[R:%.*]] = fdiv <4 x double> <double 4.200000e+01, double 0xFFF8000000000000, double 0x7FF0000000000000, double undef>, [[X:%.*]]
; CHECK-NEXT:    ret <4 x double> [[R]]
;
  %d = fdiv <4 x double> <double -42.0, double 0x7FF8000000000000, double 0xFFF0000000000000, double undef>, %x
  %r = fneg <4 x double> %d
  ret <4 x double> %r
}

; Sink FP negation through a select:
; c ? -x : -y --> -(c ? x : y)

define <2 x double> @fneg_fneg_sel(<2 x double> %x, <2 x double> %y, i1 %cond) {
; CHECK-LABEL: @fneg_fneg_sel(
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[COND:%.*]], <2 x double> [[X:%.*]], <2 x double> [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = fneg <2 x double> [[SEL_V]]
; CHECK-NEXT:    ret <2 x double> [[SEL]]
;
  %n1 = fneg <2 x double> %x
  %n2 = fneg <2 x double> %y
  %sel = select i1 %cond, <2 x double> %n1, <2 x double> %n2
  ret <2 x double> %sel
}

; An extra use is allowed.

define float @fneg_fneg_sel_extra_use1(float %x, float %y, i1 %cond) {
; CHECK-LABEL: @fneg_fneg_sel_extra_use1(
; CHECK-NEXT:    [[N1:%.*]] = fneg float [[X:%.*]]
; CHECK-NEXT:    call void @use(float [[N1]])
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[COND:%.*]], float [[X]], float [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = fneg float [[SEL_V]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %n1 = fneg float %x
  call void @use(float %n1)
  %n2 = fneg float %y
  %sel = select i1 %cond, float %n1, float %n2
  ret float %sel
}

define float @fneg_fneg_sel_extra_use2(float %x, float %y, i1 %cond) {
; CHECK-LABEL: @fneg_fneg_sel_extra_use2(
; CHECK-NEXT:    [[N2:%.*]] = fneg float [[Y:%.*]]
; CHECK-NEXT:    call void @use(float [[N2]])
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[COND:%.*]], float [[X:%.*]], float [[Y]]
; CHECK-NEXT:    [[SEL:%.*]] = fneg float [[SEL_V]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %n1 = fneg float %x
  %n2 = fneg float %y
  call void @use(float %n2)
  %sel = select i1 %cond, float %n1, float %n2
  ret float %sel
}

; Legacy form of fneg should work too.

define float @fsub_fsub_sel_extra_use1(float %x, float %y, i1 %cond) {
; CHECK-LABEL: @fsub_fsub_sel_extra_use1(
; CHECK-NEXT:    [[N1:%.*]] = fneg float [[X:%.*]]
; CHECK-NEXT:    call void @use(float [[N1]])
; CHECK-NEXT:    [[SEL_V:%.*]] = select i1 [[COND:%.*]], float [[X]], float [[Y:%.*]]
; CHECK-NEXT:    [[SEL:%.*]] = fneg float [[SEL_V]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %n1 = fsub float -0.0, %x
  call void @use(float %n1)
  %n2 = fsub float -0.0, %y
  %sel = select i1 %cond, float %n1, float %n2
  ret float %sel
}

; Negative test: but 2 extra uses would require an extra instruction.

define float @fneg_fneg_sel_extra_use3(float %x, float %y, i1 %cond) {
; CHECK-LABEL: @fneg_fneg_sel_extra_use3(
; CHECK-NEXT:    [[N1:%.*]] = fneg float [[X:%.*]]
; CHECK-NEXT:    call void @use(float [[N1]])
; CHECK-NEXT:    [[N2:%.*]] = fneg float [[Y:%.*]]
; CHECK-NEXT:    call void @use(float [[N2]])
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[COND:%.*]], float [[N1]], float [[N2]]
; CHECK-NEXT:    ret float [[SEL]]
;
  %n1 = fneg float %x
  call void @use(float %n1)
  %n2 = fneg float %y
  call void @use(float %n2)
  %sel = select i1 %cond, float %n1, float %n2
  ret float %sel
}

; Negative test

define float @fneg_fadd_constant(float %x) {
; CHECK-LABEL: @fneg_fadd_constant(
; CHECK-NEXT:    [[A:%.*]] = fadd float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    [[R:%.*]] = fneg float [[A]]
; CHECK-NEXT:    ret float [[R]]
;
  %a = fadd float %x, 42.0
  %r = fneg float %a
  ret float %r
}

; Negative test

define float @fake_nsz_fadd_constant(float %x) {
; CHECK-LABEL: @fake_nsz_fadd_constant(
; CHECK-NEXT:    [[A:%.*]] = fadd float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    [[R:%.*]] = fneg float [[A]]
; CHECK-NEXT:    ret float [[R]]
;
  %a = fadd float %x, 42.0
  %r = fsub float -0.0, %a
  ret float %r
}

; -(X + C) --> -C - X

define float @fneg_nsz_fadd_constant(float %x) {
; CHECK-LABEL: @fneg_nsz_fadd_constant(
; CHECK-NEXT:    [[R:%.*]] = fsub nsz float -4.200000e+01, [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %a = fadd float %x, 42.0
  %r = fneg nsz float %a
  ret float %r
}

; -(X + C) --> -C - X

define float @fake_fneg_nsz_fadd_constant(float %x) {
; CHECK-LABEL: @fake_fneg_nsz_fadd_constant(
; CHECK-NEXT:    [[R:%.*]] = fsub fast float -4.200000e+01, [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %a = fadd float %x, 42.0
  %r = fsub fast float -0.0, %a
  ret float %r
}

; Negative test

define float @fneg_nsz_fadd_constant_extra_use(float %x) {
; CHECK-LABEL: @fneg_nsz_fadd_constant_extra_use(
; CHECK-NEXT:    [[A:%.*]] = fadd float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    call void @use(float [[A]])
; CHECK-NEXT:    [[R:%.*]] = fneg nsz float [[A]]
; CHECK-NEXT:    ret float [[R]]
;
  %a = fadd float %x, 42.0
  call void @use(float %a)
  %r = fneg nsz float %a
  ret float %r
}

; Negative test

define float @fake_fneg_nsz_fadd_constant_extra_use(float %x) {
; CHECK-LABEL: @fake_fneg_nsz_fadd_constant_extra_use(
; CHECK-NEXT:    [[A:%.*]] = fadd float [[X:%.*]], 4.200000e+01
; CHECK-NEXT:    call void @use(float [[A]])
; CHECK-NEXT:    [[R:%.*]] = fneg fast float [[A]]
; CHECK-NEXT:    ret float [[R]]
;
  %a = fadd float %x, 42.0
  call void @use(float %a)
  %r = fsub fast float -0.0, %a
  ret float %r
}

; -(X + C) --> -C - X

define <2 x float> @fneg_nsz_fadd_constant_vec(<2 x float> %x) {
; CHECK-LABEL: @fneg_nsz_fadd_constant_vec(
; CHECK-NEXT:    [[R:%.*]] = fsub reassoc nnan nsz <2 x float> <float -4.200000e+01, float -4.300000e+01>, [[X:%.*]]
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %a = fadd <2 x float> %x, <float 42.0, float 43.0>
  %r = fneg nsz nnan reassoc <2 x float> %a
  ret <2 x float> %r
}

; -(X + C) --> -C - X

define <2 x float> @fake_fneg_nsz_fadd_constant_vec(<2 x float> %x) {
; CHECK-LABEL: @fake_fneg_nsz_fadd_constant_vec(
; CHECK-NEXT:    [[R:%.*]] = fsub nsz <2 x float> <float -4.200000e+01, float undef>, [[X:%.*]]
; CHECK-NEXT:    ret <2 x float> [[R]]
;
  %a = fadd <2 x float> %x, <float 42.0, float undef>
  %r = fsub nsz <2 x float> <float undef, float -0.0>, %a
  ret <2 x float> %r
}

@g = external global i16, align 1

define float @fneg_nsz_fadd_constant_expr(float %x) {
; CHECK-LABEL: @fneg_nsz_fadd_constant_expr(
; CHECK-NEXT:    [[R:%.*]] = fsub nsz float fneg (float bitcast (i32 ptrtoint (i16* @g to i32) to float)), [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %a = fadd float %x, bitcast (i32 ptrtoint (i16* @g to i32) to float)
  %r = fneg nsz float %a
  ret float %r
}

define float @fake_fneg_nsz_fadd_constant_expr(float %x) {
; CHECK-LABEL: @fake_fneg_nsz_fadd_constant_expr(
; CHECK-NEXT:    [[R:%.*]] = fsub nsz float fneg (float bitcast (i32 ptrtoint (i16* @g to i32) to float)), [[X:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %a = fadd float %x, bitcast (i32 ptrtoint (i16* @g to i32) to float)
  %r = fsub nsz float -0.0, %a
  ret float %r
}

define float @select_fneg_true(float %x, float %y, i1 %b) {
; CHECK-LABEL: @select_fneg_true(
; CHECK-NEXT:    [[Y_NEG:%.*]] = fneg float [[Y:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = select i1 [[B:%.*]], float [[X:%.*]], float [[Y_NEG]]
; CHECK-NEXT:    ret float [[TMP1]]
;
  %nx = fneg float %x
  %s = select i1 %b, float %nx, float %y
  %r = fneg float %s
  ret float %r
}

define <2 x float> @select_fneg_false(<2 x float> %x, <2 x float> %y, <2 x i1> %b) {
; CHECK-LABEL: @select_fneg_false(
; CHECK-NEXT:    [[X_NEG:%.*]] = fneg nnan nsz <2 x float> [[X:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = select nnan nsz <2 x i1> [[B:%.*]], <2 x float> [[X_NEG]], <2 x float> [[Y:%.*]]
; CHECK-NEXT:    ret <2 x float> [[TMP1]]
;
  %ny = fneg nnan <2 x float> %y
  %s = select ninf <2 x i1> %b, <2 x float> %x, <2 x float> %ny
  %r = fneg nsz nnan <2 x float> %s
  ret <2 x float> %r
}

define float @select_fneg_both(float %x, float %y, i1 %b) {
; CHECK-LABEL: @select_fneg_both(
; CHECK-NEXT:    [[S_V:%.*]] = select i1 [[B:%.*]], float [[X:%.*]], float [[Y:%.*]]
; CHECK-NEXT:    ret float [[S_V]]
;
  %nx = fneg float %x
  %ny = fneg float %y
  %s = select i1 %b, float %nx, float %ny
  %r = fneg float %s
  ret float %r
}

define float @select_fneg_use1(float %x, float %y, i1 %b) {
; CHECK-LABEL: @select_fneg_use1(
; CHECK-NEXT:    [[NX:%.*]] = fneg ninf float [[X:%.*]]
; CHECK-NEXT:    call void @use(float [[NX]])
; CHECK-NEXT:    [[Y_NEG:%.*]] = fneg float [[Y:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = select i1 [[B:%.*]], float [[X]], float [[Y_NEG]]
; CHECK-NEXT:    ret float [[TMP1]]
;
  %nx = fneg ninf float %x
  call void @use(float %nx)
  %s = select fast i1 %b, float %nx, float %y
  %r = fneg float %s
  ret float %r
}

define float @select_fneg_use2(float %x, float %y, i1 %b) {
; CHECK-LABEL: @select_fneg_use2(
; CHECK-NEXT:    call void @use(float [[Y:%.*]])
; CHECK-NEXT:    [[Y_NEG:%.*]] = fneg fast float [[Y]]
; CHECK-NEXT:    [[TMP1:%.*]] = select fast i1 [[B:%.*]], float [[X:%.*]], float [[Y_NEG]]
; CHECK-NEXT:    ret float [[TMP1]]
;
  call void @use(float %y)
  %nx = fneg nsz float %x
  %s = select ninf i1 %b, float %nx, float %y
  %r = fneg fast float %s
  ret float %r
}

; Negative test

define float @select_fneg_use3(float %x, float %y, i1 %b) {
; CHECK-LABEL: @select_fneg_use3(
; CHECK-NEXT:    [[NX:%.*]] = fneg float [[X:%.*]]
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], float [[NX]], float [[Y:%.*]]
; CHECK-NEXT:    call void @use(float [[S]])
; CHECK-NEXT:    [[R:%.*]] = fneg float [[S]]
; CHECK-NEXT:    ret float [[R]]
;
  %nx = fneg float %x
  %s = select i1 %b, float %nx, float %y
  call void @use(float %s)
  %r = fneg float %s
  ret float %r
}
