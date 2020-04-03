; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -vector-combine -S -mtriple=x86_64-- -mattr=SSE2 | FileCheck %s --check-prefixes=CHECK,SSE
; RUN: opt < %s -vector-combine -S -mtriple=x86_64-- -mattr=AVX2 | FileCheck %s --check-prefixes=CHECK,AVX

declare void @use_i8(i8)
declare void @use_f32(float)

; Eliminating extract is profitable.

define i8 @ext0_ext0_add(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext0_ext0_add(
; CHECK-NEXT:    [[TMP1:%.*]] = add <16 x i8> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <16 x i8> [[TMP1]], i32 0
; CHECK-NEXT:    ret i8 [[TMP2]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %y, i32 0
  %r = add i8 %e0, %e1
  ret i8 %r
}

; Eliminating extract is still profitable. Flags propagate.

define i8 @ext1_ext1_add_flags(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext1_ext1_add_flags(
; CHECK-NEXT:    [[TMP1:%.*]] = add nuw nsw <16 x i8> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <16 x i8> [[TMP1]], i32 1
; CHECK-NEXT:    ret i8 [[TMP2]]
;
  %e0 = extractelement <16 x i8> %x, i32 1
  %e1 = extractelement <16 x i8> %y, i32 1
  %r = add nsw nuw i8 %e0, %e1
  ret i8 %r
}

; Negative test - eliminating extract is profitable, but vector shift is expensive.

define i8 @ext1_ext1_shl(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext1_ext1_shl(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 1
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 1
; CHECK-NEXT:    [[R:%.*]] = shl i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 1
  %e1 = extractelement <16 x i8> %y, i32 1
  %r = shl i8 %e0, %e1
  ret i8 %r
}

; Negative test - eliminating extract is profitable, but vector multiply is expensive.

define i8 @ext13_ext13_mul(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext13_ext13_mul(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 13
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 13
; CHECK-NEXT:    [[R:%.*]] = mul i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 13
  %e1 = extractelement <16 x i8> %y, i32 13
  %r = mul i8 %e0, %e1
  ret i8 %r
}

; Negative test - cost is irrelevant because sdiv has potential UB.

define i8 @ext0_ext0_sdiv(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext0_ext0_sdiv(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 0
; CHECK-NEXT:    [[R:%.*]] = sdiv i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %y, i32 0
  %r = sdiv i8 %e0, %e1
  ret i8 %r
}

; Extracts are free and vector op has same cost as scalar, but we
; speculatively transform to vector to create more optimization
; opportunities..

define double @ext0_ext0_fadd(<2 x double> %x, <2 x double> %y) {
; CHECK-LABEL: @ext0_ext0_fadd(
; CHECK-NEXT:    [[TMP1:%.*]] = fadd <2 x double> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x double> [[TMP1]], i32 0
; CHECK-NEXT:    ret double [[TMP2]]
;
  %e0 = extractelement <2 x double> %x, i32 0
  %e1 = extractelement <2 x double> %y, i32 0
  %r = fadd double %e0, %e1
  ret double %r
}

; Eliminating extract is profitable. Flags propagate.

define double @ext1_ext1_fsub(<2 x double> %x, <2 x double> %y) {
; CHECK-LABEL: @ext1_ext1_fsub(
; CHECK-NEXT:    [[TMP1:%.*]] = fsub fast <2 x double> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x double> [[TMP1]], i32 1
; CHECK-NEXT:    ret double [[TMP2]]
;
  %e0 = extractelement <2 x double> %x, i32 1
  %e1 = extractelement <2 x double> %y, i32 1
  %r = fsub fast double %e0, %e1
  ret double %r
}

; Negative test - type mismatch.

define double @ext1_ext1_fadd_different_types(<2 x double> %x, <4 x double> %y) {
; CHECK-LABEL: @ext1_ext1_fadd_different_types(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <2 x double> [[X:%.*]], i32 1
; CHECK-NEXT:    [[E1:%.*]] = extractelement <4 x double> [[Y:%.*]], i32 1
; CHECK-NEXT:    [[R:%.*]] = fadd fast double [[E0]], [[E1]]
; CHECK-NEXT:    ret double [[R]]
;
  %e0 = extractelement <2 x double> %x, i32 1
  %e1 = extractelement <4 x double> %y, i32 1
  %r = fadd fast double %e0, %e1
  ret double %r
}

; Disguised same vector operand; scalar code is not cheaper (with default
; x86 target), so aggressively form vector binop.

define i32 @ext1_ext1_add_same_vec(<4 x i32> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = add <4 x i32> [[X:%.*]], [[X]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <4 x i32> [[TMP1]], i32 1
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %e0 = extractelement <4 x i32> %x, i32 1
  %e1 = extractelement <4 x i32> %x, i32 1
  %r = add i32 %e0, %e1
  ret i32 %r
}

; Functionally equivalent to above test; should transform as above.

define i32 @ext1_ext1_add_same_vec_cse(<4 x i32> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec_cse(
; CHECK-NEXT:    [[TMP1:%.*]] = add <4 x i32> [[X:%.*]], [[X]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <4 x i32> [[TMP1]], i32 1
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %e0 = extractelement <4 x i32> %x, i32 1
  %r = add i32 %e0, %e0
  ret i32 %r
}

; Don't assert if extract indices have different types.

define i32 @ext1_ext1_add_same_vec_diff_idx_ty(<4 x i32> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec_diff_idx_ty(
; CHECK-NEXT:    [[TMP1:%.*]] = add <4 x i32> [[X:%.*]], [[X]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <4 x i32> [[TMP1]], i32 1
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %e0 = extractelement <4 x i32> %x, i32 1
  %e1 = extractelement <4 x i32> %x, i64 1
  %r = add i32 %e0, %e1
  ret i32 %r
}

; Negative test - same vector operand; scalar code is cheaper than general case
;                 and vector code would be more expensive still.

define i8 @ext1_ext1_add_same_vec_extra_use0(<16 x i8> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec_extra_use0(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    call void @use_i8(i8 [[E0]])
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[X]], i32 0
; CHECK-NEXT:    [[R:%.*]] = add i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  call void @use_i8(i8 %e0)
  %e1 = extractelement <16 x i8> %x, i32 0
  %r = add i8 %e0, %e1
  ret i8 %r
}

; Negative test - same vector operand; scalar code is cheaper than general case
;                 and vector code would be more expensive still.

define i8 @ext1_ext1_add_same_vec_extra_use1(<16 x i8> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec_extra_use1(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[X]], i32 0
; CHECK-NEXT:    call void @use_i8(i8 [[E1]])
; CHECK-NEXT:    [[R:%.*]] = add i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %x, i32 0
  call void @use_i8(i8 %e1)
  %r = add i8 %e0, %e1
  ret i8 %r
}

; Negative test - same vector operand; scalar code is cheaper than general case
;                 and vector code would be more expensive still.

define i8 @ext1_ext1_add_same_vec_cse_extra_use(<16 x i8> %x) {
; CHECK-LABEL: @ext1_ext1_add_same_vec_cse_extra_use(
; CHECK-NEXT:    [[E:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    call void @use_i8(i8 [[E]])
; CHECK-NEXT:    [[R:%.*]] = add i8 [[E]], [[E]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e = extractelement <16 x i8> %x, i32 0
  call void @use_i8(i8 %e)
  %r = add i8 %e, %e
  ret i8 %r
}

; Vector code costs the same as scalar, so aggressively form vector op.

define i8 @ext1_ext1_add_uses1(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext1_ext1_add_uses1(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    call void @use_i8(i8 [[E0]])
; CHECK-NEXT:    [[TMP1:%.*]] = add <16 x i8> [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <16 x i8> [[TMP1]], i32 0
; CHECK-NEXT:    ret i8 [[TMP2]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  call void @use_i8(i8 %e0)
  %e1 = extractelement <16 x i8> %y, i32 0
  %r = add i8 %e0, %e1
  ret i8 %r
}

; Vector code costs the same as scalar, so aggressively form vector op.

define i8 @ext1_ext1_add_uses2(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext1_ext1_add_uses2(
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 0
; CHECK-NEXT:    call void @use_i8(i8 [[E1]])
; CHECK-NEXT:    [[TMP1:%.*]] = add <16 x i8> [[X:%.*]], [[Y]]
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <16 x i8> [[TMP1]], i32 0
; CHECK-NEXT:    ret i8 [[TMP2]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %y, i32 0
  call void @use_i8(i8 %e1)
  %r = add i8 %e0, %e1
  ret i8 %r
}

define i8 @ext0_ext1_add(<16 x i8> %x, <16 x i8> %y) {
; SSE-LABEL: @ext0_ext1_add(
; SSE-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; SSE-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 1
; SSE-NEXT:    [[R:%.*]] = add nuw i8 [[E0]], [[E1]]
; SSE-NEXT:    ret i8 [[R]]
;
; AVX-LABEL: @ext0_ext1_add(
; AVX-NEXT:    [[TMP1:%.*]] = shufflevector <16 x i8> [[Y:%.*]], <16 x i8> undef, <16 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:    [[TMP2:%.*]] = add nuw <16 x i8> [[X:%.*]], [[TMP1]]
; AVX-NEXT:    [[TMP3:%.*]] = extractelement <16 x i8> [[TMP2]], i32 0
; AVX-NEXT:    ret i8 [[TMP3]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %y, i32 1
  %r = add nuw i8 %e0, %e1
  ret i8 %r
}

define i8 @ext5_ext0_add(<16 x i8> %x, <16 x i8> %y) {
; SSE-LABEL: @ext5_ext0_add(
; SSE-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 5
; SSE-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 0
; SSE-NEXT:    [[R:%.*]] = sub nsw i8 [[E0]], [[E1]]
; SSE-NEXT:    ret i8 [[R]]
;
; AVX-LABEL: @ext5_ext0_add(
; AVX-NEXT:    [[TMP1:%.*]] = shufflevector <16 x i8> [[X:%.*]], <16 x i8> undef, <16 x i32> <i32 5, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:    [[TMP2:%.*]] = sub nsw <16 x i8> [[TMP1]], [[Y:%.*]]
; AVX-NEXT:    [[TMP3:%.*]] = extractelement <16 x i8> [[TMP2]], i64 0
; AVX-NEXT:    ret i8 [[TMP3]]
;
  %e0 = extractelement <16 x i8> %x, i32 5
  %e1 = extractelement <16 x i8> %y, i32 0
  %r = sub nsw i8 %e0, %e1
  ret i8 %r
}

define i8 @ext1_ext6_add(<16 x i8> %x, <16 x i8> %y) {
; SSE-LABEL: @ext1_ext6_add(
; SSE-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 1
; SSE-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 6
; SSE-NEXT:    [[R:%.*]] = and i8 [[E0]], [[E1]]
; SSE-NEXT:    ret i8 [[R]]
;
; AVX-LABEL: @ext1_ext6_add(
; AVX-NEXT:    [[TMP1:%.*]] = shufflevector <16 x i8> [[Y:%.*]], <16 x i8> undef, <16 x i32> <i32 undef, i32 6, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:    [[TMP2:%.*]] = and <16 x i8> [[X:%.*]], [[TMP1]]
; AVX-NEXT:    [[TMP3:%.*]] = extractelement <16 x i8> [[TMP2]], i32 1
; AVX-NEXT:    ret i8 [[TMP3]]
;
  %e0 = extractelement <16 x i8> %x, i32 1
  %e1 = extractelement <16 x i8> %y, i32 6
  %r = and i8 %e0, %e1
  ret i8 %r
}

define float @ext1_ext0_fmul(<4 x float> %x) {
; CHECK-LABEL: @ext1_ext0_fmul(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[X:%.*]], <4 x float> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[TMP2:%.*]] = fmul <4 x float> [[TMP1]], [[X]]
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x float> [[TMP2]], i64 0
; CHECK-NEXT:    ret float [[TMP3]]
;
  %e0 = extractelement <4 x float> %x, i32 1
  %e1 = extractelement <4 x float> %x, i32 0
  %r = fmul float %e0, %e1
  ret float %r
}

define float @ext0_ext3_fmul_extra_use1(<4 x float> %x) {
; CHECK-LABEL: @ext0_ext3_fmul_extra_use1(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <4 x float> [[X:%.*]], i32 0
; CHECK-NEXT:    call void @use_f32(float [[E0]])
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[X]], <4 x float> undef, <4 x i32> <i32 3, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[TMP2:%.*]] = fmul nnan <4 x float> [[X]], [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x float> [[TMP2]], i32 0
; CHECK-NEXT:    ret float [[TMP3]]
;
  %e0 = extractelement <4 x float> %x, i32 0
  call void @use_f32(float %e0)
  %e1 = extractelement <4 x float> %x, i32 3
  %r = fmul nnan float %e0, %e1
  ret float %r
}

define float @ext0_ext3_fmul_extra_use2(<4 x float> %x) {
; CHECK-LABEL: @ext0_ext3_fmul_extra_use2(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <4 x float> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <4 x float> [[X]], i32 3
; CHECK-NEXT:    call void @use_f32(float [[E1]])
; CHECK-NEXT:    [[R:%.*]] = fmul ninf nsz float [[E0]], [[E1]]
; CHECK-NEXT:    ret float [[R]]
;
  %e0 = extractelement <4 x float> %x, i32 0
  %e1 = extractelement <4 x float> %x, i32 3
  call void @use_f32(float %e1)
  %r = fmul ninf nsz float %e0, %e1
  ret float %r
}

define float @ext0_ext4_fmul_v8f32(<8 x float> %x) {
; SSE-LABEL: @ext0_ext4_fmul_v8f32(
; SSE-NEXT:    [[E0:%.*]] = extractelement <8 x float> [[X:%.*]], i32 0
; SSE-NEXT:    [[E1:%.*]] = extractelement <8 x float> [[X]], i32 4
; SSE-NEXT:    [[R:%.*]] = fadd float [[E0]], [[E1]]
; SSE-NEXT:    ret float [[R]]
;
; AVX-LABEL: @ext0_ext4_fmul_v8f32(
; AVX-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[X:%.*]], <8 x float> undef, <8 x i32> <i32 4, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:    [[TMP2:%.*]] = fadd <8 x float> [[X]], [[TMP1]]
; AVX-NEXT:    [[TMP3:%.*]] = extractelement <8 x float> [[TMP2]], i32 0
; AVX-NEXT:    ret float [[TMP3]]
;
  %e0 = extractelement <8 x float> %x, i32 0
  %e1 = extractelement <8 x float> %x, i32 4
  %r = fadd float %e0, %e1
  ret float %r
}

define float @ext7_ext4_fmul_v8f32(<8 x float> %x) {
; SSE-LABEL: @ext7_ext4_fmul_v8f32(
; SSE-NEXT:    [[E0:%.*]] = extractelement <8 x float> [[X:%.*]], i32 7
; SSE-NEXT:    [[E1:%.*]] = extractelement <8 x float> [[X]], i32 4
; SSE-NEXT:    [[R:%.*]] = fadd float [[E0]], [[E1]]
; SSE-NEXT:    ret float [[R]]
;
; AVX-LABEL: @ext7_ext4_fmul_v8f32(
; AVX-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[X:%.*]], <8 x float> undef, <8 x i32> <i32 undef, i32 undef, i32 undef, i32 undef, i32 7, i32 undef, i32 undef, i32 undef>
; AVX-NEXT:    [[TMP2:%.*]] = fadd <8 x float> [[TMP1]], [[X]]
; AVX-NEXT:    [[TMP3:%.*]] = extractelement <8 x float> [[TMP2]], i64 4
; AVX-NEXT:    ret float [[TMP3]]
;
  %e0 = extractelement <8 x float> %x, i32 7
  %e1 = extractelement <8 x float> %x, i32 4
  %r = fadd float %e0, %e1
  ret float %r
}

define float @ext0_ext8_fmul_v16f32(<16 x float> %x) {
; CHECK-LABEL: @ext0_ext8_fmul_v16f32(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x float> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x float> [[X]], i32 8
; CHECK-NEXT:    [[R:%.*]] = fadd float [[E0]], [[E1]]
; CHECK-NEXT:    ret float [[R]]
;
  %e0 = extractelement <16 x float> %x, i32 0
  %e1 = extractelement <16 x float> %x, i32 8
  %r = fadd float %e0, %e1
  ret float %r
}

define float @ext14_ext15_fmul_v16f32(<16 x float> %x) {
; CHECK-LABEL: @ext14_ext15_fmul_v16f32(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x float> [[X:%.*]], i32 14
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x float> [[X]], i32 15
; CHECK-NEXT:    [[R:%.*]] = fadd float [[E0]], [[E1]]
; CHECK-NEXT:    ret float [[R]]
;
  %e0 = extractelement <16 x float> %x, i32 14
  %e1 = extractelement <16 x float> %x, i32 15
  %r = fadd float %e0, %e1
  ret float %r
}

define <4 x float> @ins_bo_ext_ext(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: @ins_bo_ext_ext(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[A:%.*]], <4 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 undef, i32 2>
; CHECK-NEXT:    [[TMP2:%.*]] = fadd <4 x float> [[TMP1]], [[A]]
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x float> [[TMP2]], i64 3
; CHECK-NEXT:    [[V3:%.*]] = insertelement <4 x float> [[B:%.*]], float [[TMP3]], i32 3
; CHECK-NEXT:    ret <4 x float> [[V3]]
;
  %a2 = extractelement <4 x float> %a, i32 2
  %a3 = extractelement <4 x float> %a, i32 3
  %a23 = fadd float %a2, %a3
  %v3 = insertelement <4 x float> %b, float %a23, i32 3
  ret <4 x float> %v3
}

; TODO: This is conservatively left to extract from the lower index value,
;       but it is likely that extracting from index 3 is the better option.

define <4 x float> @ins_bo_ext_ext_uses(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: @ins_bo_ext_ext_uses(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[A:%.*]], <4 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 3, i32 undef>
; CHECK-NEXT:    [[TMP2:%.*]] = fadd <4 x float> [[A]], [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x float> [[TMP2]], i32 2
; CHECK-NEXT:    call void @use_f32(float [[TMP3]])
; CHECK-NEXT:    [[V3:%.*]] = insertelement <4 x float> [[B:%.*]], float [[TMP3]], i32 3
; CHECK-NEXT:    ret <4 x float> [[V3]]
;
  %a2 = extractelement <4 x float> %a, i32 2
  %a3 = extractelement <4 x float> %a, i32 3
  %a23 = fadd float %a2, %a3
  call void @use_f32(float %a23)
  %v3 = insertelement <4 x float> %b, float %a23, i32 3
  ret <4 x float> %v3
}

define <4 x float> @PR34724(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: @PR34724(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[A:%.*]], <4 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 3, i32 undef>
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x float> [[B:%.*]], <4 x float> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <4 x float> [[B]], <4 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 undef, i32 2>
; CHECK-NEXT:    [[TMP4:%.*]] = fadd <4 x float> [[A]], [[TMP1]]
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <4 x float> [[TMP4]], i32 2
; CHECK-NEXT:    [[TMP6:%.*]] = fadd <4 x float> [[B]], [[TMP2]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <4 x float> [[TMP6]], i32 0
; CHECK-NEXT:    [[TMP8:%.*]] = fadd <4 x float> [[TMP3]], [[B]]
; CHECK-NEXT:    [[TMP9:%.*]] = extractelement <4 x float> [[TMP8]], i64 3
; CHECK-NEXT:    [[V1:%.*]] = insertelement <4 x float> undef, float [[TMP5]], i32 1
; CHECK-NEXT:    [[V2:%.*]] = insertelement <4 x float> [[V1]], float [[TMP7]], i32 2
; CHECK-NEXT:    [[V3:%.*]] = insertelement <4 x float> [[V2]], float [[TMP9]], i32 3
; CHECK-NEXT:    ret <4 x float> [[V3]]
;
  %a0 = extractelement <4 x float> %a, i32 0
  %a1 = extractelement <4 x float> %a, i32 1
  %a2 = extractelement <4 x float> %a, i32 2
  %a3 = extractelement <4 x float> %a, i32 3

  %b0 = extractelement <4 x float> %b, i32 0
  %b1 = extractelement <4 x float> %b, i32 1
  %b2 = extractelement <4 x float> %b, i32 2
  %b3 = extractelement <4 x float> %b, i32 3

  %a23 = fadd float %a2, %a3
  %b01 = fadd float %b0, %b1
  %b23 = fadd float %b2, %b3

  %v1 = insertelement <4 x float> undef, float %a23, i32 1
  %v2 = insertelement <4 x float> %v1, float %b01, i32 2
  %v3 = insertelement <4 x float> %v2, float %b23, i32 3
  ret <4 x float> %v3
}
