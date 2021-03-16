; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=SSE
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=slm -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=SLM
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=corei7-avx -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=core-avx2 -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=knl -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX512
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=skx -basic-aa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX512

define <8 x float> @sitofp_uitofp(<8 x i32> %a) {
; SSE-LABEL: @sitofp_uitofp(
; SSE-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[A:%.*]], <8 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SSE-NEXT:    [[TMP2:%.*]] = sitofp <4 x i32> [[TMP1]] to <4 x float>
; SSE-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[A]], <8 x i32> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; SSE-NEXT:    [[TMP4:%.*]] = uitofp <4 x i32> [[TMP3]] to <4 x float>
; SSE-NEXT:    [[R72:%.*]] = shufflevector <4 x float> [[TMP2]], <4 x float> [[TMP4]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; SSE-NEXT:    ret <8 x float> [[R72]]
;
; SLM-LABEL: @sitofp_uitofp(
; SLM-NEXT:    [[TMP1:%.*]] = sitofp <8 x i32> [[A:%.*]] to <8 x float>
; SLM-NEXT:    [[TMP2:%.*]] = uitofp <8 x i32> [[A]] to <8 x float>
; SLM-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[TMP1]], <8 x float> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; SLM-NEXT:    ret <8 x float> [[TMP3]]
;
; AVX-LABEL: @sitofp_uitofp(
; AVX-NEXT:    [[TMP1:%.*]] = sitofp <8 x i32> [[A:%.*]] to <8 x float>
; AVX-NEXT:    [[TMP2:%.*]] = uitofp <8 x i32> [[A]] to <8 x float>
; AVX-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[TMP1]], <8 x float> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX-NEXT:    ret <8 x float> [[TMP3]]
;
; AVX512-LABEL: @sitofp_uitofp(
; AVX512-NEXT:    [[TMP1:%.*]] = sitofp <8 x i32> [[A:%.*]] to <8 x float>
; AVX512-NEXT:    [[TMP2:%.*]] = uitofp <8 x i32> [[A]] to <8 x float>
; AVX512-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[TMP1]], <8 x float> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX512-NEXT:    ret <8 x float> [[TMP3]]
;
  %a0 = extractelement <8 x i32> %a, i32 0
  %a1 = extractelement <8 x i32> %a, i32 1
  %a2 = extractelement <8 x i32> %a, i32 2
  %a3 = extractelement <8 x i32> %a, i32 3
  %a4 = extractelement <8 x i32> %a, i32 4
  %a5 = extractelement <8 x i32> %a, i32 5
  %a6 = extractelement <8 x i32> %a, i32 6
  %a7 = extractelement <8 x i32> %a, i32 7
  %ab0 = sitofp i32 %a0 to float
  %ab1 = sitofp i32 %a1 to float
  %ab2 = sitofp i32 %a2 to float
  %ab3 = sitofp i32 %a3 to float
  %ab4 = uitofp i32 %a4 to float
  %ab5 = uitofp i32 %a5 to float
  %ab6 = uitofp i32 %a6 to float
  %ab7 = uitofp i32 %a7 to float
  %r0 = insertelement <8 x float> undef, float %ab0, i32 0
  %r1 = insertelement <8 x float>   %r0, float %ab1, i32 1
  %r2 = insertelement <8 x float>   %r1, float %ab2, i32 2
  %r3 = insertelement <8 x float>   %r2, float %ab3, i32 3
  %r4 = insertelement <8 x float>   %r3, float %ab4, i32 4
  %r5 = insertelement <8 x float>   %r4, float %ab5, i32 5
  %r6 = insertelement <8 x float>   %r5, float %ab6, i32 6
  %r7 = insertelement <8 x float>   %r6, float %ab7, i32 7
  ret <8 x float> %r7
}

define <8 x i32> @fptosi_fptoui(<8 x float> %a) {
; SSE-LABEL: @fptosi_fptoui(
; SSE-NEXT:    [[A4:%.*]] = extractelement <8 x float> [[A:%.*]], i32 4
; SSE-NEXT:    [[A5:%.*]] = extractelement <8 x float> [[A]], i32 5
; SSE-NEXT:    [[A6:%.*]] = extractelement <8 x float> [[A]], i32 6
; SSE-NEXT:    [[A7:%.*]] = extractelement <8 x float> [[A]], i32 7
; SSE-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SSE-NEXT:    [[TMP2:%.*]] = fptosi <4 x float> [[TMP1]] to <4 x i32>
; SSE-NEXT:    [[AB4:%.*]] = fptoui float [[A4]] to i32
; SSE-NEXT:    [[AB5:%.*]] = fptoui float [[A5]] to i32
; SSE-NEXT:    [[AB6:%.*]] = fptoui float [[A6]] to i32
; SSE-NEXT:    [[AB7:%.*]] = fptoui float [[A7]] to i32
; SSE-NEXT:    [[R31:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE-NEXT:    [[R4:%.*]] = insertelement <8 x i32> [[R31]], i32 [[AB4]], i32 4
; SSE-NEXT:    [[R5:%.*]] = insertelement <8 x i32> [[R4]], i32 [[AB5]], i32 5
; SSE-NEXT:    [[R6:%.*]] = insertelement <8 x i32> [[R5]], i32 [[AB6]], i32 6
; SSE-NEXT:    [[R7:%.*]] = insertelement <8 x i32> [[R6]], i32 [[AB7]], i32 7
; SSE-NEXT:    ret <8 x i32> [[R7]]
;
; SLM-LABEL: @fptosi_fptoui(
; SLM-NEXT:    [[A4:%.*]] = extractelement <8 x float> [[A:%.*]], i32 4
; SLM-NEXT:    [[A5:%.*]] = extractelement <8 x float> [[A]], i32 5
; SLM-NEXT:    [[A6:%.*]] = extractelement <8 x float> [[A]], i32 6
; SLM-NEXT:    [[A7:%.*]] = extractelement <8 x float> [[A]], i32 7
; SLM-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SLM-NEXT:    [[TMP2:%.*]] = fptosi <4 x float> [[TMP1]] to <4 x i32>
; SLM-NEXT:    [[AB4:%.*]] = fptoui float [[A4]] to i32
; SLM-NEXT:    [[AB5:%.*]] = fptoui float [[A5]] to i32
; SLM-NEXT:    [[AB6:%.*]] = fptoui float [[A6]] to i32
; SLM-NEXT:    [[AB7:%.*]] = fptoui float [[A7]] to i32
; SLM-NEXT:    [[R31:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
; SLM-NEXT:    [[R4:%.*]] = insertelement <8 x i32> [[R31]], i32 [[AB4]], i32 4
; SLM-NEXT:    [[R5:%.*]] = insertelement <8 x i32> [[R4]], i32 [[AB5]], i32 5
; SLM-NEXT:    [[R6:%.*]] = insertelement <8 x i32> [[R5]], i32 [[AB6]], i32 6
; SLM-NEXT:    [[R7:%.*]] = insertelement <8 x i32> [[R6]], i32 [[AB7]], i32 7
; SLM-NEXT:    ret <8 x i32> [[R7]]
;
; AVX-LABEL: @fptosi_fptoui(
; AVX-NEXT:    [[TMP1:%.*]] = shufflevector <8 x float> [[A:%.*]], <8 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; AVX-NEXT:    [[TMP2:%.*]] = fptosi <4 x float> [[TMP1]] to <4 x i32>
; AVX-NEXT:    [[TMP3:%.*]] = shufflevector <8 x float> [[A]], <8 x float> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:    [[TMP4:%.*]] = fptoui <4 x float> [[TMP3]] to <4 x i32>
; AVX-NEXT:    [[R72:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> [[TMP4]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:    ret <8 x i32> [[R72]]
;
; AVX512-LABEL: @fptosi_fptoui(
; AVX512-NEXT:    [[TMP1:%.*]] = fptosi <8 x float> [[A:%.*]] to <8 x i32>
; AVX512-NEXT:    [[TMP2:%.*]] = fptoui <8 x float> [[A]] to <8 x i32>
; AVX512-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; AVX512-NEXT:    ret <8 x i32> [[TMP3]]
;
  %a0 = extractelement <8 x float> %a, i32 0
  %a1 = extractelement <8 x float> %a, i32 1
  %a2 = extractelement <8 x float> %a, i32 2
  %a3 = extractelement <8 x float> %a, i32 3
  %a4 = extractelement <8 x float> %a, i32 4
  %a5 = extractelement <8 x float> %a, i32 5
  %a6 = extractelement <8 x float> %a, i32 6
  %a7 = extractelement <8 x float> %a, i32 7
  %ab0 = fptosi float %a0 to i32
  %ab1 = fptosi float %a1 to i32
  %ab2 = fptosi float %a2 to i32
  %ab3 = fptosi float %a3 to i32
  %ab4 = fptoui float %a4 to i32
  %ab5 = fptoui float %a5 to i32
  %ab6 = fptoui float %a6 to i32
  %ab7 = fptoui float %a7 to i32
  %r0 = insertelement <8 x i32> undef, i32 %ab0, i32 0
  %r1 = insertelement <8 x i32>   %r0, i32 %ab1, i32 1
  %r2 = insertelement <8 x i32>   %r1, i32 %ab2, i32 2
  %r3 = insertelement <8 x i32>   %r2, i32 %ab3, i32 3
  %r4 = insertelement <8 x i32>   %r3, i32 %ab4, i32 4
  %r5 = insertelement <8 x i32>   %r4, i32 %ab5, i32 5
  %r6 = insertelement <8 x i32>   %r5, i32 %ab6, i32 6
  %r7 = insertelement <8 x i32>   %r6, i32 %ab7, i32 7
  ret <8 x i32> %r7
}

define <8 x float> @fneg_fabs(<8 x float> %a) {
; CHECK-LABEL: @fneg_fabs(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x float> [[A:%.*]] to <8 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = xor <8 x i32> [[TMP1]], <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP3:%.*]] = and <8 x i32> [[TMP1]], <i32 poison, i32 poison, i32 poison, i32 poison, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <8 x i32> [[TMP2]], <8 x i32> [[TMP3]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast <8 x i32> [[TMP4]] to <8 x float>
; CHECK-NEXT:    ret <8 x float> [[TMP5]]
;
  %a0 = extractelement <8 x float> %a, i32 0
  %a1 = extractelement <8 x float> %a, i32 1
  %a2 = extractelement <8 x float> %a, i32 2
  %a3 = extractelement <8 x float> %a, i32 3
  %a4 = extractelement <8 x float> %a, i32 4
  %a5 = extractelement <8 x float> %a, i32 5
  %a6 = extractelement <8 x float> %a, i32 6
  %a7 = extractelement <8 x float> %a, i32 7
  %aa0 = bitcast float %a0 to i32
  %aa1 = bitcast float %a1 to i32
  %aa2 = bitcast float %a2 to i32
  %aa3 = bitcast float %a3 to i32
  %aa4 = bitcast float %a4 to i32
  %aa5 = bitcast float %a5 to i32
  %aa6 = bitcast float %a6 to i32
  %aa7 = bitcast float %a7 to i32
  %ab0 = xor i32 %aa0, -2147483648
  %ab1 = xor i32 %aa1, -2147483648
  %ab2 = xor i32 %aa2, -2147483648
  %ab3 = xor i32 %aa3, -2147483648
  %ab4 = and i32 %aa4, 2147483647
  %ab5 = and i32 %aa5, 2147483647
  %ab6 = and i32 %aa6, 2147483647
  %ab7 = and i32 %aa7, 2147483647
  %ac0 = bitcast i32 %ab0 to float
  %ac1 = bitcast i32 %ab1 to float
  %ac2 = bitcast i32 %ab2 to float
  %ac3 = bitcast i32 %ab3 to float
  %ac4 = bitcast i32 %ab4 to float
  %ac5 = bitcast i32 %ab5 to float
  %ac6 = bitcast i32 %ab6 to float
  %ac7 = bitcast i32 %ab7 to float
  %r0 = insertelement <8 x float> undef, float %ac0, i32 0
  %r1 = insertelement <8 x float>   %r0, float %ac1, i32 1
  %r2 = insertelement <8 x float>   %r1, float %ac2, i32 2
  %r3 = insertelement <8 x float>   %r2, float %ac3, i32 3
  %r4 = insertelement <8 x float>   %r3, float %ac4, i32 4
  %r5 = insertelement <8 x float>   %r4, float %ac5, i32 5
  %r6 = insertelement <8 x float>   %r5, float %ac6, i32 6
  %r7 = insertelement <8 x float>   %r6, float %ac7, i32 7
  ret <8 x float> %r7
}

define <8 x i32> @sext_zext(<8 x i16> %a) {
; CHECK-LABEL: @sext_zext(
; CHECK-NEXT:    [[TMP1:%.*]] = sext <8 x i16> [[A:%.*]] to <8 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = zext <8 x i16> [[A]] to <8 x i32>
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <8 x i32> [[TMP1]], <8 x i32> [[TMP2]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    ret <8 x i32> [[TMP3]]
;
  %a0 = extractelement <8 x i16> %a, i32 0
  %a1 = extractelement <8 x i16> %a, i32 1
  %a2 = extractelement <8 x i16> %a, i32 2
  %a3 = extractelement <8 x i16> %a, i32 3
  %a4 = extractelement <8 x i16> %a, i32 4
  %a5 = extractelement <8 x i16> %a, i32 5
  %a6 = extractelement <8 x i16> %a, i32 6
  %a7 = extractelement <8 x i16> %a, i32 7
  %ab0 = sext i16 %a0 to i32
  %ab1 = sext i16 %a1 to i32
  %ab2 = sext i16 %a2 to i32
  %ab3 = sext i16 %a3 to i32
  %ab4 = zext i16 %a4 to i32
  %ab5 = zext i16 %a5 to i32
  %ab6 = zext i16 %a6 to i32
  %ab7 = zext i16 %a7 to i32
  %r0 = insertelement <8 x i32> undef, i32 %ab0, i32 0
  %r1 = insertelement <8 x i32>   %r0, i32 %ab1, i32 1
  %r2 = insertelement <8 x i32>   %r1, i32 %ab2, i32 2
  %r3 = insertelement <8 x i32>   %r2, i32 %ab3, i32 3
  %r4 = insertelement <8 x i32>   %r3, i32 %ab4, i32 4
  %r5 = insertelement <8 x i32>   %r4, i32 %ab5, i32 5
  %r6 = insertelement <8 x i32>   %r5, i32 %ab6, i32 6
  %r7 = insertelement <8 x i32>   %r6, i32 %ab7, i32 7
  ret <8 x i32> %r7
}

define <8 x float> @sitofp_4i32_8i16(<4 x i32> %a, <8 x i16> %b) {
; SSE-LABEL: @sitofp_4i32_8i16(
; SSE-NEXT:    [[B0:%.*]] = extractelement <8 x i16> [[B:%.*]], i32 0
; SSE-NEXT:    [[B1:%.*]] = extractelement <8 x i16> [[B]], i32 1
; SSE-NEXT:    [[B2:%.*]] = extractelement <8 x i16> [[B]], i32 2
; SSE-NEXT:    [[B3:%.*]] = extractelement <8 x i16> [[B]], i32 3
; SSE-NEXT:    [[TMP1:%.*]] = sitofp <4 x i32> [[A:%.*]] to <4 x float>
; SSE-NEXT:    [[AB4:%.*]] = sitofp i16 [[B0]] to float
; SSE-NEXT:    [[AB5:%.*]] = sitofp i16 [[B1]] to float
; SSE-NEXT:    [[AB6:%.*]] = sitofp i16 [[B2]] to float
; SSE-NEXT:    [[AB7:%.*]] = sitofp i16 [[B3]] to float
; SSE-NEXT:    [[R31:%.*]] = shufflevector <4 x float> [[TMP1]], <4 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
; SSE-NEXT:    [[R4:%.*]] = insertelement <8 x float> [[R31]], float [[AB4]], i32 4
; SSE-NEXT:    [[R5:%.*]] = insertelement <8 x float> [[R4]], float [[AB5]], i32 5
; SSE-NEXT:    [[R6:%.*]] = insertelement <8 x float> [[R5]], float [[AB6]], i32 6
; SSE-NEXT:    [[R7:%.*]] = insertelement <8 x float> [[R6]], float [[AB7]], i32 7
; SSE-NEXT:    ret <8 x float> [[R7]]
;
; SLM-LABEL: @sitofp_4i32_8i16(
; SLM-NEXT:    [[TMP1:%.*]] = sitofp <4 x i32> [[A:%.*]] to <4 x float>
; SLM-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i16> [[B:%.*]], <8 x i16> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; SLM-NEXT:    [[TMP3:%.*]] = sitofp <4 x i16> [[TMP2]] to <4 x float>
; SLM-NEXT:    [[R72:%.*]] = shufflevector <4 x float> [[TMP1]], <4 x float> [[TMP3]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; SLM-NEXT:    ret <8 x float> [[R72]]
;
; AVX-LABEL: @sitofp_4i32_8i16(
; AVX-NEXT:    [[TMP1:%.*]] = sitofp <4 x i32> [[A:%.*]] to <4 x float>
; AVX-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i16> [[B:%.*]], <8 x i16> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; AVX-NEXT:    [[TMP3:%.*]] = sitofp <4 x i16> [[TMP2]] to <4 x float>
; AVX-NEXT:    [[R72:%.*]] = shufflevector <4 x float> [[TMP1]], <4 x float> [[TMP3]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; AVX-NEXT:    ret <8 x float> [[R72]]
;
; AVX512-LABEL: @sitofp_4i32_8i16(
; AVX512-NEXT:    [[TMP1:%.*]] = sitofp <4 x i32> [[A:%.*]] to <4 x float>
; AVX512-NEXT:    [[TMP2:%.*]] = shufflevector <8 x i16> [[B:%.*]], <8 x i16> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; AVX512-NEXT:    [[TMP3:%.*]] = sitofp <4 x i16> [[TMP2]] to <4 x float>
; AVX512-NEXT:    [[R72:%.*]] = shufflevector <4 x float> [[TMP1]], <4 x float> [[TMP3]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; AVX512-NEXT:    ret <8 x float> [[R72]]
;
  %a0 = extractelement <4 x i32> %a, i32 0
  %a1 = extractelement <4 x i32> %a, i32 1
  %a2 = extractelement <4 x i32> %a, i32 2
  %a3 = extractelement <4 x i32> %a, i32 3
  %b0 = extractelement <8 x i16> %b, i32 0
  %b1 = extractelement <8 x i16> %b, i32 1
  %b2 = extractelement <8 x i16> %b, i32 2
  %b3 = extractelement <8 x i16> %b, i32 3
  %ab0 = sitofp i32 %a0 to float
  %ab1 = sitofp i32 %a1 to float
  %ab2 = sitofp i32 %a2 to float
  %ab3 = sitofp i32 %a3 to float
  %ab4 = sitofp i16 %b0 to float
  %ab5 = sitofp i16 %b1 to float
  %ab6 = sitofp i16 %b2 to float
  %ab7 = sitofp i16 %b3 to float
  %r0 = insertelement <8 x float> undef, float %ab0, i32 0
  %r1 = insertelement <8 x float>   %r0, float %ab1, i32 1
  %r2 = insertelement <8 x float>   %r1, float %ab2, i32 2
  %r3 = insertelement <8 x float>   %r2, float %ab3, i32 3
  %r4 = insertelement <8 x float>   %r3, float %ab4, i32 4
  %r5 = insertelement <8 x float>   %r4, float %ab5, i32 5
  %r6 = insertelement <8 x float>   %r5, float %ab6, i32 6
  %r7 = insertelement <8 x float>   %r6, float %ab7, i32 7
  ret <8 x float> %r7
}

; Inspired by PR38154
define <8 x float> @sitofp_uitofp_4i32_8i16_16i8(<4 x i32> %a, <8 x i16> %b, <16 x i8> %c) {
; CHECK-LABEL: @sitofp_uitofp_4i32_8i16_16i8(
; CHECK-NEXT:    [[B0:%.*]] = extractelement <8 x i16> [[B:%.*]], i32 0
; CHECK-NEXT:    [[B1:%.*]] = extractelement <8 x i16> [[B]], i32 1
; CHECK-NEXT:    [[C0:%.*]] = extractelement <16 x i8> [[C:%.*]], i32 0
; CHECK-NEXT:    [[C1:%.*]] = extractelement <16 x i8> [[C]], i32 1
; CHECK-NEXT:    [[TMP1:%.*]] = sitofp <4 x i32> [[A:%.*]] to <4 x float>
; CHECK-NEXT:    [[TMP2:%.*]] = uitofp <4 x i32> [[A]] to <4 x float>
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <4 x float> [[TMP1]], <4 x float> [[TMP2]], <4 x i32> <i32 0, i32 1, i32 6, i32 7>
; CHECK-NEXT:    [[AB4:%.*]] = sitofp i16 [[B0]] to float
; CHECK-NEXT:    [[AB5:%.*]] = uitofp i16 [[B1]] to float
; CHECK-NEXT:    [[AB6:%.*]] = sitofp i8 [[C0]] to float
; CHECK-NEXT:    [[AB7:%.*]] = uitofp i8 [[C1]] to float
; CHECK-NEXT:    [[R31:%.*]] = shufflevector <4 x float> [[TMP3]], <4 x float> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[R4:%.*]] = insertelement <8 x float> [[R31]], float [[AB4]], i32 4
; CHECK-NEXT:    [[R5:%.*]] = insertelement <8 x float> [[R4]], float [[AB5]], i32 5
; CHECK-NEXT:    [[R6:%.*]] = insertelement <8 x float> [[R5]], float [[AB6]], i32 6
; CHECK-NEXT:    [[R7:%.*]] = insertelement <8 x float> [[R6]], float [[AB7]], i32 7
; CHECK-NEXT:    ret <8 x float> [[R7]]
;
  %a0 = extractelement <4 x i32> %a, i32 0
  %a1 = extractelement <4 x i32> %a, i32 1
  %a2 = extractelement <4 x i32> %a, i32 2
  %a3 = extractelement <4 x i32> %a, i32 3
  %b0 = extractelement <8 x i16> %b, i32 0
  %b1 = extractelement <8 x i16> %b, i32 1
  %c0 = extractelement <16 x i8> %c, i32 0
  %c1 = extractelement <16 x i8> %c, i32 1
  %ab0 = sitofp i32 %a0 to float
  %ab1 = sitofp i32 %a1 to float
  %ab2 = uitofp i32 %a2 to float
  %ab3 = uitofp i32 %a3 to float
  %ab4 = sitofp i16 %b0 to float
  %ab5 = uitofp i16 %b1 to float
  %ab6 = sitofp  i8 %c0 to float
  %ab7 = uitofp  i8 %c1 to float
  %r0 = insertelement <8 x float> undef, float %ab0, i32 0
  %r1 = insertelement <8 x float>   %r0, float %ab1, i32 1
  %r2 = insertelement <8 x float>   %r1, float %ab2, i32 2
  %r3 = insertelement <8 x float>   %r2, float %ab3, i32 3
  %r4 = insertelement <8 x float>   %r3, float %ab4, i32 4
  %r5 = insertelement <8 x float>   %r4, float %ab5, i32 5
  %r6 = insertelement <8 x float>   %r5, float %ab6, i32 6
  %r7 = insertelement <8 x float>   %r6, float %ab7, i32 7
  ret <8 x float> %r7
}
