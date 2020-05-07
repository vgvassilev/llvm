; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=+sse2      | FileCheck %s --check-prefixes=CHECK,SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+sse4.1    | FileCheck %s --check-prefixes=CHECK,SSE,SSE4
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx       | FileCheck %s --check-prefixes=CHECK,AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2      | FileCheck %s --check-prefixes=CHECK,AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512f   | FileCheck %s --check-prefixes=CHECK,AVX,AVX512,AVX512F
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx512vl  | FileCheck %s --check-prefixes=CHECK,AVX,AVX512,AVX512VL

define <4 x float> @sitofp_v4i32_v4f32(<2 x i32> %x, <2 x i32> %y) {
; SSE-LABEL: sitofp_v4i32_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE-NEXT:    cvtdq2ps %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sitofp_v4i32_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX-NEXT:    vcvtdq2ps %xmm0, %xmm0
; AVX-NEXT:    retq
  %s0 = sitofp <2 x i32> %x to <2 x float>
  %s1 = sitofp <2 x i32> %y to <2 x float>
  %r = shufflevector <2 x float> %s0, <2 x float> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x float> %r
}

define <4 x float> @uitofp_v4i32_v4f32(<2 x i32> %x, <2 x i32> %y) {
; SSE2-LABEL: uitofp_v4i32_v4f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [65535,65535,65535,65535]
; SSE2-NEXT:    pand %xmm0, %xmm1
; SSE2-NEXT:    por {{.*}}(%rip), %xmm1
; SSE2-NEXT:    psrld $16, %xmm0
; SSE2-NEXT:    por {{.*}}(%rip), %xmm0
; SSE2-NEXT:    subps {{.*}}(%rip), %xmm0
; SSE2-NEXT:    addps %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE4-LABEL: uitofp_v4i32_v4f32:
; SSE4:       # %bb.0:
; SSE4-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE4-NEXT:    movdqa {{.*#+}} xmm1 = [1258291200,1258291200,1258291200,1258291200]
; SSE4-NEXT:    pblendw {{.*#+}} xmm1 = xmm0[0],xmm1[1],xmm0[2],xmm1[3],xmm0[4],xmm1[5],xmm0[6],xmm1[7]
; SSE4-NEXT:    psrld $16, %xmm0
; SSE4-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0],mem[1],xmm0[2],mem[3],xmm0[4],mem[5],xmm0[6],mem[7]
; SSE4-NEXT:    subps {{.*}}(%rip), %xmm0
; SSE4-NEXT:    addps %xmm1, %xmm0
; SSE4-NEXT:    retq
;
; AVX1-LABEL: uitofp_v4i32_v4f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm1 = xmm0[0],mem[1],xmm0[2],mem[3],xmm0[4],mem[5],xmm0[6],mem[7]
; AVX1-NEXT:    vpsrld $16, %xmm0, %xmm0
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0],mem[1],xmm0[2],mem[3],xmm0[4],mem[5],xmm0[6],mem[7]
; AVX1-NEXT:    vsubps {{.*}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vaddps %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: uitofp_v4i32_v4f32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [1258291200,1258291200,1258291200,1258291200]
; AVX2-NEXT:    vpblendw {{.*#+}} xmm1 = xmm0[0],xmm1[1],xmm0[2],xmm1[3],xmm0[4],xmm1[5],xmm0[6],xmm1[7]
; AVX2-NEXT:    vpsrld $16, %xmm0, %xmm0
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [1392508928,1392508928,1392508928,1392508928]
; AVX2-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0],xmm2[1],xmm0[2],xmm2[3],xmm0[4],xmm2[5],xmm0[6],xmm2[7]
; AVX2-NEXT:    vbroadcastss {{.*#+}} xmm2 = [5.49764202E+11,5.49764202E+11,5.49764202E+11,5.49764202E+11]
; AVX2-NEXT:    vsubps %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vaddps %xmm0, %xmm1, %xmm0
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: uitofp_v4i32_v4f32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX512F-NEXT:    vcvtudq2ps %zmm0, %zmm0
; AVX512F-NEXT:    # kill: def $xmm0 killed $xmm0 killed $zmm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: uitofp_v4i32_v4f32:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX512VL-NEXT:    vcvtudq2ps %xmm0, %xmm0
; AVX512VL-NEXT:    retq
  %s0 = uitofp <2 x i32> %x to <2 x float>
  %s1 = uitofp <2 x i32> %y to <2 x float>
  %r = shufflevector <2 x float> %s0, <2 x float> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x float> %r
}

define <4 x i32> @fptosi_v4f32_v4i32(<2 x float> %x, <2 x float> %y) {
; SSE-LABEL: fptosi_v4f32_v4i32:
; SSE:       # %bb.0:
; SSE-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE-NEXT:    cvttps2dq %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: fptosi_v4f32_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX-NEXT:    vcvttps2dq %xmm0, %xmm0
; AVX-NEXT:    retq
  %s0 = fptosi <2 x float> %x to <2 x i32>
  %s1 = fptosi <2 x float> %y to <2 x i32>
  %r = shufflevector <2 x i32> %s0, <2 x i32> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x i32> %r
}

define <4 x i32> @fptoui_v4f32_v4i32(<2 x float> %x, <2 x float> %y) {
; SSE2-LABEL: fptoui_v4f32_v4i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movaps {{.*#+}} xmm3 = [2.14748365E+9,2.14748365E+9,2.14748365E+9,2.14748365E+9]
; SSE2-NEXT:    movaps %xmm0, %xmm2
; SSE2-NEXT:    cmpltps %xmm3, %xmm2
; SSE2-NEXT:    cvttps2dq %xmm0, %xmm4
; SSE2-NEXT:    subps %xmm3, %xmm0
; SSE2-NEXT:    cvttps2dq %xmm0, %xmm0
; SSE2-NEXT:    movaps {{.*#+}} xmm5 = [2147483648,2147483648,2147483648,2147483648]
; SSE2-NEXT:    xorps %xmm5, %xmm0
; SSE2-NEXT:    andps %xmm2, %xmm4
; SSE2-NEXT:    andnps %xmm0, %xmm2
; SSE2-NEXT:    orps %xmm4, %xmm2
; SSE2-NEXT:    movaps %xmm1, %xmm0
; SSE2-NEXT:    cmpltps %xmm3, %xmm0
; SSE2-NEXT:    cvttps2dq %xmm1, %xmm4
; SSE2-NEXT:    subps %xmm3, %xmm1
; SSE2-NEXT:    cvttps2dq %xmm1, %xmm1
; SSE2-NEXT:    xorps %xmm5, %xmm1
; SSE2-NEXT:    andps %xmm0, %xmm4
; SSE2-NEXT:    andnps %xmm1, %xmm0
; SSE2-NEXT:    orps %xmm4, %xmm0
; SSE2-NEXT:    movlhps {{.*#+}} xmm2 = xmm2[0],xmm0[0]
; SSE2-NEXT:    movaps %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE4-LABEL: fptoui_v4f32_v4i32:
; SSE4:       # %bb.0:
; SSE4-NEXT:    movaps {{.*#+}} xmm4 = [2.14748365E+9,2.14748365E+9,2.14748365E+9,2.14748365E+9]
; SSE4-NEXT:    movaps %xmm0, %xmm2
; SSE4-NEXT:    cmpltps %xmm4, %xmm2
; SSE4-NEXT:    cvttps2dq %xmm0, %xmm5
; SSE4-NEXT:    subps %xmm4, %xmm0
; SSE4-NEXT:    cvttps2dq %xmm0, %xmm3
; SSE4-NEXT:    movaps {{.*#+}} xmm6 = [2147483648,2147483648,2147483648,2147483648]
; SSE4-NEXT:    xorps %xmm6, %xmm3
; SSE4-NEXT:    movaps %xmm2, %xmm0
; SSE4-NEXT:    blendvps %xmm0, %xmm5, %xmm3
; SSE4-NEXT:    movaps %xmm1, %xmm0
; SSE4-NEXT:    cmpltps %xmm4, %xmm0
; SSE4-NEXT:    cvttps2dq %xmm1, %xmm2
; SSE4-NEXT:    subps %xmm4, %xmm1
; SSE4-NEXT:    cvttps2dq %xmm1, %xmm1
; SSE4-NEXT:    xorps %xmm6, %xmm1
; SSE4-NEXT:    blendvps %xmm0, %xmm2, %xmm1
; SSE4-NEXT:    movlhps {{.*#+}} xmm3 = xmm3[0],xmm1[0]
; SSE4-NEXT:    movaps %xmm3, %xmm0
; SSE4-NEXT:    retq
;
; AVX1-LABEL: fptoui_v4f32_v4i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovaps {{.*#+}} xmm2 = [2.14748365E+9,2.14748365E+9,2.14748365E+9,2.14748365E+9]
; AVX1-NEXT:    vcmpltps %xmm2, %xmm0, %xmm3
; AVX1-NEXT:    vsubps %xmm2, %xmm0, %xmm4
; AVX1-NEXT:    vcvttps2dq %xmm4, %xmm4
; AVX1-NEXT:    vmovaps {{.*#+}} xmm5 = [2147483648,2147483648,2147483648,2147483648]
; AVX1-NEXT:    vxorps %xmm5, %xmm4, %xmm4
; AVX1-NEXT:    vcvttps2dq %xmm0, %xmm0
; AVX1-NEXT:    vblendvps %xmm3, %xmm0, %xmm4, %xmm0
; AVX1-NEXT:    vcmpltps %xmm2, %xmm1, %xmm3
; AVX1-NEXT:    vsubps %xmm2, %xmm1, %xmm2
; AVX1-NEXT:    vcvttps2dq %xmm2, %xmm2
; AVX1-NEXT:    vxorps %xmm5, %xmm2, %xmm2
; AVX1-NEXT:    vcvttps2dq %xmm1, %xmm1
; AVX1-NEXT:    vblendvps %xmm3, %xmm1, %xmm2, %xmm1
; AVX1-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: fptoui_v4f32_v4i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vbroadcastss {{.*#+}} xmm2 = [2.14748365E+9,2.14748365E+9,2.14748365E+9,2.14748365E+9]
; AVX2-NEXT:    vcmpltps %xmm2, %xmm0, %xmm3
; AVX2-NEXT:    vsubps %xmm2, %xmm0, %xmm4
; AVX2-NEXT:    vcvttps2dq %xmm4, %xmm4
; AVX2-NEXT:    vbroadcastss {{.*#+}} xmm5 = [2147483648,2147483648,2147483648,2147483648]
; AVX2-NEXT:    vxorps %xmm5, %xmm4, %xmm4
; AVX2-NEXT:    vcvttps2dq %xmm0, %xmm0
; AVX2-NEXT:    vblendvps %xmm3, %xmm0, %xmm4, %xmm0
; AVX2-NEXT:    vcmpltps %xmm2, %xmm1, %xmm3
; AVX2-NEXT:    vsubps %xmm2, %xmm1, %xmm2
; AVX2-NEXT:    vcvttps2dq %xmm2, %xmm2
; AVX2-NEXT:    vxorps %xmm5, %xmm2, %xmm2
; AVX2-NEXT:    vcvttps2dq %xmm1, %xmm1
; AVX2-NEXT:    vblendvps %xmm3, %xmm1, %xmm2, %xmm1
; AVX2-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: fptoui_v4f32_v4i32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX512F-NEXT:    vcvttps2udq %zmm0, %zmm0
; AVX512F-NEXT:    # kill: def $xmm0 killed $xmm0 killed $zmm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: fptoui_v4f32_v4i32:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX512VL-NEXT:    vcvttps2udq %xmm0, %xmm0
; AVX512VL-NEXT:    retq
  %s0 = fptoui <2 x float> %x to <2 x i32>
  %s1 = fptoui <2 x float> %y to <2 x i32>
  %r = shufflevector <2 x i32> %s0, <2 x i32> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x i32> %r
}

define <4 x double> @sitofp_v4i32_v4f64(<2 x i32> %x, <2 x i32> %y) {
; SSE-LABEL: sitofp_v4i32_v4f64:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtdq2pd %xmm0, %xmm0
; SSE-NEXT:    cvtdq2pd %xmm1, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: sitofp_v4i32_v4f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX-NEXT:    vcvtdq2pd %xmm0, %ymm0
; AVX-NEXT:    retq
  %s0 = sitofp <2 x i32> %x to <2 x double>
  %s1 = sitofp <2 x i32> %y to <2 x double>
  %r = shufflevector <2 x double> %s0, <2 x double> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x double> %r
}

define <4 x double> @uitofp_v4i32_v4f64(<2 x i32> %x, <2 x i32> %y) {
; SSE2-LABEL: uitofp_v4i32_v4f64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    xorpd %xmm2, %xmm2
; SSE2-NEXT:    unpcklps {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE2-NEXT:    movapd {{.*#+}} xmm3 = [4.503599627370496E+15,4.503599627370496E+15]
; SSE2-NEXT:    orpd %xmm3, %xmm0
; SSE2-NEXT:    subpd %xmm3, %xmm0
; SSE2-NEXT:    unpcklps {{.*#+}} xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
; SSE2-NEXT:    orpd %xmm3, %xmm1
; SSE2-NEXT:    subpd %xmm3, %xmm1
; SSE2-NEXT:    retq
;
; SSE4-LABEL: uitofp_v4i32_v4f64:
; SSE4:       # %bb.0:
; SSE4-NEXT:    pmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; SSE4-NEXT:    movdqa {{.*#+}} xmm2 = [4.503599627370496E+15,4.503599627370496E+15]
; SSE4-NEXT:    por %xmm2, %xmm0
; SSE4-NEXT:    subpd %xmm2, %xmm0
; SSE4-NEXT:    pmovzxdq {{.*#+}} xmm1 = xmm1[0],zero,xmm1[1],zero
; SSE4-NEXT:    por %xmm2, %xmm1
; SSE4-NEXT:    subpd %xmm2, %xmm1
; SSE4-NEXT:    retq
;
; AVX1-LABEL: uitofp_v4i32_v4f64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; AVX1-NEXT:    vpmovzxdq {{.*#+}} xmm1 = xmm1[0],zero,xmm1[1],zero
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    vbroadcastsd {{.*#+}} ymm1 = [4.503599627370496E+15,4.503599627370496E+15,4.503599627370496E+15,4.503599627370496E+15]
; AVX1-NEXT:    vorpd %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    vsubpd %ymm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: uitofp_v4i32_v4f64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX2-NEXT:    vpmovzxdq {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; AVX2-NEXT:    vpbroadcastq {{.*#+}} ymm1 = [4.503599627370496E+15,4.503599627370496E+15,4.503599627370496E+15,4.503599627370496E+15]
; AVX2-NEXT:    vpor %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vsubpd %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: uitofp_v4i32_v4f64:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX512F-NEXT:    vcvtudq2pd %ymm0, %zmm0
; AVX512F-NEXT:    # kill: def $ymm0 killed $ymm0 killed $zmm0
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: uitofp_v4i32_v4f64:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX512VL-NEXT:    vcvtudq2pd %xmm0, %ymm0
; AVX512VL-NEXT:    retq
  %s0 = uitofp <2 x i32> %x to <2 x double>
  %s1 = uitofp <2 x i32> %y to <2 x double>
  %r = shufflevector <2 x double> %s0, <2 x double> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x double> %r
}

define <4 x i32> @fptosi_v4f64_v4i32(<2 x double> %x, <2 x double> %y) {
; SSE-LABEL: fptosi_v4f64_v4i32:
; SSE:       # %bb.0:
; SSE-NEXT:    cvttpd2dq %xmm0, %xmm0
; SSE-NEXT:    cvttpd2dq %xmm1, %xmm1
; SSE-NEXT:    unpcklpd {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE-NEXT:    retq
;
; AVX-LABEL: fptosi_v4f64_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    # kill: def $xmm0 killed $xmm0 def $ymm0
; AVX-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX-NEXT:    vcvttpd2dq %ymm0, %xmm0
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
  %s0 = fptosi <2 x double> %x to <2 x i32>
  %s1 = fptosi <2 x double> %y to <2 x i32>
  %r = shufflevector <2 x i32> %s0, <2 x i32> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x i32> %r
}

define <4 x i32> @fptoui_v4f64_v4i32(<2 x double> %x, <2 x double> %y) {
; SSE2-LABEL: fptoui_v4f64_v4i32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    cvttsd2si %xmm0, %rax
; SSE2-NEXT:    unpckhpd {{.*#+}} xmm0 = xmm0[1,1]
; SSE2-NEXT:    cvttsd2si %xmm0, %rcx
; SSE2-NEXT:    cvttsd2si %xmm1, %rdx
; SSE2-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1,1]
; SSE2-NEXT:    cvttsd2si %xmm1, %rsi
; SSE2-NEXT:    movd %edx, %xmm1
; SSE2-NEXT:    movd %esi, %xmm0
; SSE2-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    movd %eax, %xmm0
; SSE2-NEXT:    movd %ecx, %xmm2
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE2-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-NEXT:    retq
;
; SSE4-LABEL: fptoui_v4f64_v4i32:
; SSE4:       # %bb.0:
; SSE4-NEXT:    cvttsd2si %xmm0, %rax
; SSE4-NEXT:    unpckhpd {{.*#+}} xmm0 = xmm0[1,1]
; SSE4-NEXT:    cvttsd2si %xmm0, %rcx
; SSE4-NEXT:    cvttsd2si %xmm1, %rdx
; SSE4-NEXT:    unpckhpd {{.*#+}} xmm1 = xmm1[1,1]
; SSE4-NEXT:    cvttsd2si %xmm1, %rsi
; SSE4-NEXT:    movd %eax, %xmm0
; SSE4-NEXT:    pinsrd $1, %ecx, %xmm0
; SSE4-NEXT:    pinsrd $2, %edx, %xmm0
; SSE4-NEXT:    pinsrd $3, %esi, %xmm0
; SSE4-NEXT:    retq
;
; AVX1-LABEL: fptoui_v4f64_v4i32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    # kill: def $xmm1 killed $xmm1 def $ymm1
; AVX1-NEXT:    # kill: def $xmm0 killed $xmm0 def $ymm0
; AVX1-NEXT:    vmovapd {{.*#+}} ymm2 = [2.147483648E+9,2.147483648E+9,2.147483648E+9,2.147483648E+9]
; AVX1-NEXT:    vcmpltpd %ymm2, %ymm0, %ymm3
; AVX1-NEXT:    vpackssdw %xmm3, %xmm3, %xmm3
; AVX1-NEXT:    vsubpd %ymm2, %ymm0, %ymm4
; AVX1-NEXT:    vcvttpd2dq %ymm4, %xmm4
; AVX1-NEXT:    vmovapd {{.*#+}} xmm5 = [2147483648,2147483648,2147483648,2147483648]
; AVX1-NEXT:    vxorpd %xmm5, %xmm4, %xmm4
; AVX1-NEXT:    vcvttpd2dq %ymm0, %xmm0
; AVX1-NEXT:    vblendvps %xmm3, %xmm0, %xmm4, %xmm0
; AVX1-NEXT:    vcmpltpd %ymm2, %ymm1, %ymm3
; AVX1-NEXT:    vpackssdw %xmm3, %xmm3, %xmm3
; AVX1-NEXT:    vsubpd %ymm2, %ymm1, %ymm2
; AVX1-NEXT:    vcvttpd2dq %ymm2, %xmm2
; AVX1-NEXT:    vxorpd %xmm5, %xmm2, %xmm2
; AVX1-NEXT:    vcvttpd2dq %ymm1, %xmm1
; AVX1-NEXT:    vblendvps %xmm3, %xmm1, %xmm2, %xmm1
; AVX1-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: fptoui_v4f64_v4i32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    # kill: def $xmm1 killed $xmm1 def $ymm1
; AVX2-NEXT:    # kill: def $xmm0 killed $xmm0 def $ymm0
; AVX2-NEXT:    vbroadcastsd {{.*#+}} ymm2 = [2.147483648E+9,2.147483648E+9,2.147483648E+9,2.147483648E+9]
; AVX2-NEXT:    vcmpltpd %ymm2, %ymm0, %ymm3
; AVX2-NEXT:    vpackssdw %xmm3, %xmm3, %xmm3
; AVX2-NEXT:    vsubpd %ymm2, %ymm0, %ymm4
; AVX2-NEXT:    vcvttpd2dq %ymm4, %xmm4
; AVX2-NEXT:    vbroadcastss {{.*#+}} xmm5 = [2147483648,2147483648,2147483648,2147483648]
; AVX2-NEXT:    vxorpd %xmm5, %xmm4, %xmm4
; AVX2-NEXT:    vcvttpd2dq %ymm0, %xmm0
; AVX2-NEXT:    vblendvps %xmm3, %xmm0, %xmm4, %xmm0
; AVX2-NEXT:    vcmpltpd %ymm2, %ymm1, %ymm3
; AVX2-NEXT:    vpackssdw %xmm3, %xmm3, %xmm3
; AVX2-NEXT:    vsubpd %ymm2, %ymm1, %ymm2
; AVX2-NEXT:    vcvttpd2dq %ymm2, %xmm2
; AVX2-NEXT:    vxorpd %xmm5, %xmm2, %xmm2
; AVX2-NEXT:    vcvttpd2dq %ymm1, %xmm1
; AVX2-NEXT:    vblendvps %xmm3, %xmm1, %xmm2, %xmm1
; AVX2-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: fptoui_v4f64_v4i32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    # kill: def $xmm0 killed $xmm0 def $ymm0
; AVX512F-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX512F-NEXT:    vcvttpd2udq %zmm0, %ymm0
; AVX512F-NEXT:    # kill: def $xmm0 killed $xmm0 killed $ymm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: fptoui_v4f64_v4i32:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    # kill: def $xmm0 killed $xmm0 def $ymm0
; AVX512VL-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX512VL-NEXT:    vcvttpd2udq %ymm0, %xmm0
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
  %s0 = fptoui <2 x double> %x to <2 x i32>
  %s1 = fptoui <2 x double> %y to <2 x i32>
  %r = shufflevector <2 x i32> %s0, <2 x i32> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x i32> %r
}

; Negative test

define <4 x float> @mismatch_tofp_v4i32_v4f32(<2 x i32> %x, <2 x i32> %y) {
; SSE2-LABEL: mismatch_tofp_v4i32_v4f32:
; SSE2:       # %bb.0:
; SSE2-NEXT:    xorpd %xmm2, %xmm2
; SSE2-NEXT:    unpcklps {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE2-NEXT:    movapd {{.*#+}} xmm2 = [4.503599627370496E+15,4.503599627370496E+15]
; SSE2-NEXT:    orpd %xmm2, %xmm0
; SSE2-NEXT:    subpd %xmm2, %xmm0
; SSE2-NEXT:    cvtpd2ps %xmm0, %xmm0
; SSE2-NEXT:    cvtdq2ps %xmm1, %xmm1
; SSE2-NEXT:    unpcklpd {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-NEXT:    retq
;
; SSE4-LABEL: mismatch_tofp_v4i32_v4f32:
; SSE4:       # %bb.0:
; SSE4-NEXT:    pmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; SSE4-NEXT:    movdqa {{.*#+}} xmm2 = [4.503599627370496E+15,4.503599627370496E+15]
; SSE4-NEXT:    por %xmm2, %xmm0
; SSE4-NEXT:    subpd %xmm2, %xmm0
; SSE4-NEXT:    cvtpd2ps %xmm0, %xmm0
; SSE4-NEXT:    cvtdq2ps %xmm1, %xmm1
; SSE4-NEXT:    unpcklpd {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE4-NEXT:    retq
;
; AVX1-LABEL: mismatch_tofp_v4i32_v4f32:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = [4.503599627370496E+15,4.503599627370496E+15]
; AVX1-NEXT:    vpor %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vsubpd %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vcvtpd2ps %xmm0, %xmm0
; AVX1-NEXT:    vcvtdq2ps %xmm1, %xmm1
; AVX1-NEXT:    vunpcklpd {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX1-NEXT:    retq
;
; AVX2-LABEL: mismatch_tofp_v4i32_v4f32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovzxdq {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm2 = [4.503599627370496E+15,4.503599627370496E+15]
; AVX2-NEXT:    vpor %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vsubpd %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vcvtpd2ps %xmm0, %xmm0
; AVX2-NEXT:    vcvtdq2ps %xmm1, %xmm1
; AVX2-NEXT:    vunpcklpd {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: mismatch_tofp_v4i32_v4f32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    # kill: def $xmm0 killed $xmm0 def $zmm0
; AVX512F-NEXT:    vcvtudq2ps %zmm0, %zmm0
; AVX512F-NEXT:    vcvtdq2ps %xmm1, %xmm1
; AVX512F-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: mismatch_tofp_v4i32_v4f32:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vcvtudq2ps %xmm0, %xmm0
; AVX512VL-NEXT:    vcvtdq2ps %xmm1, %xmm1
; AVX512VL-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX512VL-NEXT:    retq
  %s0 = uitofp <2 x i32> %x to <2 x float>
  %s1 = sitofp <2 x i32> %y to <2 x float>
  %r = shufflevector <2 x float> %s0, <2 x float> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x float> %r
}

; Negative test

define <4 x float> @sitofp_v4i32_v4f32_extra_use(<2 x i32> %x, <2 x i32> %y, <2 x float>* %p) {
; SSE-LABEL: sitofp_v4i32_v4f32_extra_use:
; SSE:       # %bb.0:
; SSE-NEXT:    cvtdq2ps %xmm0, %xmm0
; SSE-NEXT:    cvtdq2ps %xmm1, %xmm1
; SSE-NEXT:    movlps %xmm1, (%rdi)
; SSE-NEXT:    movlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE-NEXT:    retq
;
; AVX-LABEL: sitofp_v4i32_v4f32_extra_use:
; AVX:       # %bb.0:
; AVX-NEXT:    vcvtdq2ps %xmm0, %xmm0
; AVX-NEXT:    vcvtdq2ps %xmm1, %xmm1
; AVX-NEXT:    vmovlps %xmm1, (%rdi)
; AVX-NEXT:    vmovlhps {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX-NEXT:    retq
  %s0 = sitofp <2 x i32> %x to <2 x float>
  %s1 = sitofp <2 x i32> %y to <2 x float>
  store <2 x float> %s1, <2 x float>* %p
  %r = shufflevector <2 x float> %s0, <2 x float> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x float> %r
}

define <4 x float> @PR45794(<2 x i64> %x, <2 x i64> %y) {
; SSE-LABEL: PR45794:
; SSE:       # %bb.0:
; SSE-NEXT:    psrad $16, %xmm0
; SSE-NEXT:    psrad $16, %xmm1
; SSE-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,3],xmm1[1,3]
; SSE-NEXT:    cvtdq2ps %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX1-LABEL: PR45794:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpsrad $16, %xmm0, %xmm0
; AVX1-NEXT:    vpsrad $16, %xmm1, %xmm1
; AVX1-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[1,3],xmm1[1,3]
; AVX1-NEXT:    vcvtdq2ps %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: PR45794:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrad $16, %xmm0, %xmm0
; AVX2-NEXT:    vpsrad $16, %xmm1, %xmm1
; AVX2-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[1,3],xmm1[1,3]
; AVX2-NEXT:    vcvtdq2ps %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: PR45794:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    # kill: def $xmm1 killed $xmm1 def $zmm1
; AVX512F-NEXT:    # kill: def $xmm0 killed $xmm0 def $zmm0
; AVX512F-NEXT:    vpsraq $48, %zmm0, %zmm0
; AVX512F-NEXT:    vpsraq $48, %zmm1, %zmm1
; AVX512F-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[0,2],xmm1[0,2]
; AVX512F-NEXT:    vcvtdq2ps %xmm0, %xmm0
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: PR45794:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    # kill: def $xmm0 killed $xmm0 def $ymm0
; AVX512VL-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; AVX512VL-NEXT:    vpsraq $48, %ymm0, %ymm0
; AVX512VL-NEXT:    vpmovqd %ymm0, %xmm0
; AVX512VL-NEXT:    vcvtdq2ps %xmm0, %xmm0
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
  %a0 = ashr <2 x i64> %x, <i64 48, i64 48>
  %s0 = sitofp <2 x i64> %a0 to <2 x float>
  %a1 = ashr <2 x i64> %y, <i64 48, i64 48>
  %s1 = sitofp <2 x i64> %a1 to <2 x float>
  %r = shufflevector <2 x float> %s0, <2 x float> %s1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  ret <4 x float> %r
}
