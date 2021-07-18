; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=CHECK,SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefixes=CHECK,SSE,SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=CHECK,AVX,AVX-SLOW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=CHECK,AVX,AVX-FAST-ALL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=CHECK,AVX,AVX-FAST-PERLANE

; fold (shl 0, x) -> 0
define <4 x i32> @combine_vec_shl_zero(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_zero:
; SSE:       # %bb.0:
; SSE-NEXT:    xorps %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_zero:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shl <4 x i32> zeroinitializer, %x
  ret <4 x i32> %1
}

; fold (shl x, c >= size(x)) -> undef
define <4 x i32> @combine_vec_shl_outofrange0(<4 x i32> %x) {
; CHECK-LABEL: combine_vec_shl_outofrange0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %1 = shl <4 x i32> %x, <i32 33, i32 33, i32 33, i32 33>
  ret <4 x i32> %1
}

define <4 x i32> @combine_vec_shl_outofrange1(<4 x i32> %x) {
; CHECK-LABEL: combine_vec_shl_outofrange1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %1 = shl <4 x i32> %x, <i32 33, i32 34, i32 35, i32 36>
  ret <4 x i32> %1
}

define <4 x i32> @combine_vec_shl_outofrange2(<4 x i32> %a0) {
; CHECK-LABEL: combine_vec_shl_outofrange2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %1 = and <4 x i32> %a0, <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
  %2 = shl <4 x i32> %1, <i32 33, i32 33, i32 33, i32 33>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_outofrange3(<4 x i32> %a0) {
; CHECK-LABEL: combine_vec_shl_outofrange3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %1 = shl <4 x i32> %a0, <i32 33, i32 34, i32 35, i32 undef>
  ret <4 x i32> %1
}

; fold (shl x, 0) -> x
define <4 x i32> @combine_vec_shl_by_zero(<4 x i32> %x) {
; CHECK-LABEL: combine_vec_shl_by_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    retq
  %1 = shl <4 x i32> %x, zeroinitializer
  ret <4 x i32> %1
}

; if (shl x, c) is known to be zero, return 0
define <4 x i32> @combine_vec_shl_known_zero0(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_known_zero0:
; SSE:       # %bb.0:
; SSE-NEXT:    xorps %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_known_zero0:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = and <4 x i32> %x, <i32 4294901760, i32 4294901760, i32 4294901760, i32 4294901760>
  %2 = shl <4 x i32> %1, <i32 16, i32 16, i32 16, i32 16>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_known_zero1(<4 x i32> %x) {
; SSE2-LABEL: combine_vec_shl_known_zero1:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [65536,32768,16384,8192]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_known_zero1:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_known_zero1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = and <4 x i32> %x, <i32 4294901760, i32 8589803520, i32 17179607040, i32 34359214080>
  %2 = shl <4 x i32> %1, <i32 16, i32 15, i32 14, i32 13>
  ret <4 x i32> %2
}

; fold (shl x, (trunc (and y, c))) -> (shl x, (and (trunc y), (trunc c))).
define <4 x i32> @combine_vec_shl_trunc_and(<4 x i32> %x, <4 x i64> %y) {
; SSE2-LABEL: combine_vec_shl_trunc_and:
; SSE2:       # %bb.0:
; SSE2-NEXT:    shufps {{.*#+}} xmm1 = xmm1[0,2],xmm2[0,2]
; SSE2-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE2-NEXT:    pslld $23, %xmm1
; SSE2-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE2-NEXT:    cvttps2dq %xmm1, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_trunc_and:
; SSE41:       # %bb.0:
; SSE41-NEXT:    shufps {{.*#+}} xmm1 = xmm1[0,2],xmm2[0,2]
; SSE41-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE41-NEXT:    pslld $23, %xmm1
; SSE41-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE41-NEXT:    cvttps2dq %xmm1, %xmm1
; SSE41-NEXT:    pmulld %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX-SLOW-LABEL: combine_vec_shl_trunc_and:
; AVX-SLOW:       # %bb.0:
; AVX-SLOW-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX-SLOW-NEXT:    vshufps {{.*#+}} xmm1 = xmm1[0,2],xmm2[0,2]
; AVX-SLOW-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; AVX-SLOW-NEXT:    vpsllvd %xmm1, %xmm0, %xmm0
; AVX-SLOW-NEXT:    vzeroupper
; AVX-SLOW-NEXT:    retq
;
; AVX-FAST-ALL-LABEL: combine_vec_shl_trunc_and:
; AVX-FAST-ALL:       # %bb.0:
; AVX-FAST-ALL-NEXT:    vmovdqa {{.*#+}} ymm2 = <0,2,4,6,u,u,u,u>
; AVX-FAST-ALL-NEXT:    vpermd %ymm1, %ymm2, %ymm1
; AVX-FAST-ALL-NEXT:    vpand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; AVX-FAST-ALL-NEXT:    vpsllvd %xmm1, %xmm0, %xmm0
; AVX-FAST-ALL-NEXT:    vzeroupper
; AVX-FAST-ALL-NEXT:    retq
;
; AVX-FAST-PERLANE-LABEL: combine_vec_shl_trunc_and:
; AVX-FAST-PERLANE:       # %bb.0:
; AVX-FAST-PERLANE-NEXT:    vextractf128 $1, %ymm1, %xmm2
; AVX-FAST-PERLANE-NEXT:    vshufps {{.*#+}} xmm1 = xmm1[0,2],xmm2[0,2]
; AVX-FAST-PERLANE-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1, %xmm1
; AVX-FAST-PERLANE-NEXT:    vpsllvd %xmm1, %xmm0, %xmm0
; AVX-FAST-PERLANE-NEXT:    vzeroupper
; AVX-FAST-PERLANE-NEXT:    retq
  %1 = and <4 x i64> %y, <i64 15, i64 255, i64 4095, i64 65535>
  %2 = trunc <4 x i64> %1 to <4 x i32>
  %3 = shl <4 x i32> %x, %2
  ret <4 x i32> %3
}

; fold (shl (shl x, c1), c2) -> (shl x, (add c1, c2))
define <4 x i32> @combine_vec_shl_shl0(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_shl0:
; SSE:       # %bb.0:
; SSE-NEXT:    pslld $6, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_shl0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpslld $6, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shl <4 x i32> %x, <i32 2, i32 2, i32 2, i32 2>
  %2 = shl <4 x i32> %1, <i32 4, i32 4, i32 4, i32 4>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_shl1(<4 x i32> %x) {
; SSE2-LABEL: combine_vec_shl_shl1:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [16,64,256,1024]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_shl1:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_shl1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shl <4 x i32> %x, <i32 0, i32 1, i32 2, i32 3>
  %2 = shl <4 x i32> %1, <i32 4, i32 5, i32 6, i32 7>
  ret <4 x i32> %2
}

; fold (shl (shl x, c1), c2) -> 0
define <4 x i32> @combine_vec_shl_shlr_zero0(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_shlr_zero0:
; SSE:       # %bb.0:
; SSE-NEXT:    xorps %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_shlr_zero0:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shl <4 x i32> %x, <i32 16, i32 16, i32 16, i32 16>
  %2 = shl <4 x i32> %1, <i32 20, i32 20, i32 20, i32 20>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_shl_zero1(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_shl_zero1:
; SSE:       # %bb.0:
; SSE-NEXT:    xorps %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_shl_zero1:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shl <4 x i32> %x, <i32 17, i32 18, i32 19, i32 20>
  %2 = shl <4 x i32> %1, <i32 25, i32 26, i32 27, i32 28>
  ret <4 x i32> %2
}

; fold (shl (ext (shl x, c1)), c2) -> (shl (ext x), (add c1, c2))
define <8 x i32> @combine_vec_shl_ext_shl0(<8 x i16> %x) {
; SSE2-LABEL: combine_vec_shl_ext_shl0:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; SSE2-NEXT:    pslld $20, %xmm0
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm1 = xmm1[4,4,5,5,6,6,7,7]
; SSE2-NEXT:    pslld $20, %xmm1
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_ext_shl0:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    pmovzxwd {{.*#+}} xmm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; SSE41-NEXT:    punpckhwd {{.*#+}} xmm1 = xmm1[4,4,5,5,6,6,7,7]
; SSE41-NEXT:    pslld $20, %xmm1
; SSE41-NEXT:    pslld $20, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_ext_shl0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovzxwd {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; AVX-NEXT:    vpslld $20, %ymm0, %ymm0
; AVX-NEXT:    retq
  %1 = shl <8 x i16> %x, <i16 4, i16 4, i16 4, i16 4, i16 4, i16 4, i16 4, i16 4>
  %2 = sext <8 x i16> %1 to <8 x i32>
  %3 = shl <8 x i32> %2, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  ret <8 x i32> %3
}

define <8 x i32> @combine_vec_shl_ext_shl1(<8 x i16> %x) {
; SSE-LABEL: combine_vec_shl_ext_shl1:
; SSE:       # %bb.0:
; SSE-NEXT:    xorps %xmm0, %xmm0
; SSE-NEXT:    xorps %xmm1, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_ext_shl1:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shl <8 x i16> %x, <i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8>
  %2 = sext <8 x i16> %1 to <8 x i32>
  %3 = shl <8 x i32> %2, <i32 31, i32 31, i32 30, i32 30, i32 29, i32 29, i32 28, i32 28>
  ret <8 x i32> %3
}

define <8 x i32> @combine_vec_shl_ext_shl2(<8 x i16> %x) {
; SSE2-LABEL: combine_vec_shl_ext_shl2:
; SSE2:       # %bb.0:
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3]
; SSE2-NEXT:    psrad $16, %xmm1
; SSE2-NEXT:    movdqa {{.*#+}} xmm3 = [131072,524288,2097152,8388608]
; SSE2-NEXT:    pshufd {{.*#+}} xmm4 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm3, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm3[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm4, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm0 = xmm0[4,4,5,5,6,6,7,7]
; SSE2-NEXT:    psrad $16, %xmm0
; SSE2-NEXT:    movdqa {{.*#+}} xmm3 = [33554432,134217728,536870912,2147483648]
; SSE2-NEXT:    pshufd {{.*#+}} xmm4 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm3, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm3[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm4, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    movdqa %xmm2, %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_ext_shl2:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovsxwd %xmm0, %xmm2
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,2,3]
; SSE41-NEXT:    pmovsxwd %xmm0, %xmm1
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE41-NEXT:    movdqa %xmm2, %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_ext_shl2:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmovsxwd %xmm0, %ymm0
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm0
; AVX-NEXT:    retq
  %1 = shl <8 x i16> %x, <i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8>
  %2 = sext <8 x i16> %1 to <8 x i32>
  %3 = shl <8 x i32> %2, <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23>
  ret <8 x i32> %3
}

; fold (shl (zext (srl x, C)), C) -> (zext (shl (srl x, C), C))
define <8 x i32> @combine_vec_shl_zext_lshr0(<8 x i16> %x) {
; SSE2-LABEL: combine_vec_shl_zext_lshr0:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE2-NEXT:    pxor %xmm2, %xmm2
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3]
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm1 = xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_zext_lshr0:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE41-NEXT:    pxor %xmm2, %xmm2
; SSE41-NEXT:    pmovzxwd {{.*#+}} xmm0 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero
; SSE41-NEXT:    punpckhwd {{.*#+}} xmm1 = xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_zext_lshr0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpmovzxwd {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; AVX-NEXT:    retq
  %1 = lshr <8 x i16> %x, <i16 4, i16 4, i16 4, i16 4, i16 4, i16 4, i16 4, i16 4>
  %2 = zext <8 x i16> %1 to <8 x i32>
  %3 = shl <8 x i32> %2, <i32 4, i32 4, i32 4, i32 4, i32 4, i32 4, i32 4, i32 4>
  ret <8 x i32> %3
}

define <8 x i32> @combine_vec_shl_zext_lshr1(<8 x i16> %x) {
; SSE2-LABEL: combine_vec_shl_zext_lshr1:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    pmulhuw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE2-NEXT:    pxor %xmm2, %xmm2
; SSE2-NEXT:    pmullw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE2-NEXT:    movdqa %xmm1, %xmm0
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3]
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm1 = xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_zext_lshr1:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    pmulhuw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE41-NEXT:    pxor %xmm2, %xmm2
; SSE41-NEXT:    pmullw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE41-NEXT:    pmovzxwd {{.*#+}} xmm0 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero
; SSE41-NEXT:    punpckhwd {{.*#+}} xmm1 = xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_zext_lshr1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulhuw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpmullw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpmovzxwd {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; AVX-NEXT:    retq
  %1 = lshr <8 x i16> %x, <i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8>
  %2 = zext <8 x i16> %1 to <8 x i32>
  %3 = shl <8 x i32> %2, <i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8>
  ret <8 x i32> %3
}

; fold (shl (sr[la] exact X,  C1), C2) -> (shl X, (C2-C1)) if C1 <= C2
define <4 x i32> @combine_vec_shl_ge_ashr_extact0(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_ge_ashr_extact0:
; SSE:       # %bb.0:
; SSE-NEXT:    pslld $2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_ge_ashr_extact0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpslld $2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = ashr exact <4 x i32> %x, <i32 3, i32 3, i32 3, i32 3>
  %2 = shl <4 x i32> %1, <i32 5, i32 5, i32 5, i32 5>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_ge_ashr_extact1(<4 x i32> %x) {
; SSE2-LABEL: combine_vec_shl_ge_ashr_extact1:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrad $3, %xmm1
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    psrad $5, %xmm2
; SSE2-NEXT:    movsd {{.*#+}} xmm2 = xmm1[0],xmm2[1]
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrad $8, %xmm1
; SSE2-NEXT:    psrad $4, %xmm0
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1],xmm1[3,3]
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [32,64,128,256]
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm0, %xmm3
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[0,2,2,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_ge_ashr_extact1:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrad $8, %xmm1
; SSE41-NEXT:    movdqa %xmm0, %xmm2
; SSE41-NEXT:    psrad $4, %xmm2
; SSE41-NEXT:    pblendw {{.*#+}} xmm2 = xmm2[0,1,2,3],xmm1[4,5,6,7]
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrad $5, %xmm1
; SSE41-NEXT:    psrad $3, %xmm0
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1,2,3],xmm1[4,5,6,7]
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1],xmm2[2,3],xmm0[4,5],xmm2[6,7]
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_ge_ashr_extact1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsravd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = ashr exact <4 x i32> %x, <i32 3, i32 4, i32 5, i32 8>
  %2 = shl <4 x i32> %1, <i32 5, i32 6, i32 7, i32 8>
  ret <4 x i32> %2
}

; fold (shl (sr[la] exact SEL(X,Y),  C1), C2) -> (shl SEL(X,Y), (C2-C1)) if C1 <= C2
define i32 @combine_shl_ge_sel_ashr_extact0(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: combine_shl_ge_sel_ashr_extact0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NEXT:    testl %edx, %edx
; CHECK-NEXT:    cmovel %esi, %edi
; CHECK-NEXT:    leal (,%rdi,4), %eax
; CHECK-NEXT:    retq
  %cmp = icmp ne i32 %z, 0
  %ashrx = ashr exact i32 %x, 3
  %ashry = ashr exact i32 %y, 3
  %sel = select i1 %cmp, i32 %ashrx, i32 %ashry
  %shl = shl i32 %sel, 5
  ret i32 %shl
}

; fold (shl (sr[la] exact X,  C1), C2) -> (sr[la] X, (C2-C1)) if C1  > C2
define <4 x i32> @combine_vec_shl_lt_ashr_extact0(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_lt_ashr_extact0:
; SSE:       # %bb.0:
; SSE-NEXT:    psrad $2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_lt_ashr_extact0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrad $2, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = ashr exact <4 x i32> %x, <i32 5, i32 5, i32 5, i32 5>
  %2 = shl <4 x i32> %1, <i32 3, i32 3, i32 3, i32 3>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_lt_ashr_extact1(<4 x i32> %x) {
; SSE2-LABEL: combine_vec_shl_lt_ashr_extact1:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrad $5, %xmm1
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    psrad $7, %xmm2
; SSE2-NEXT:    movsd {{.*#+}} xmm2 = xmm1[0],xmm2[1]
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrad $8, %xmm1
; SSE2-NEXT:    psrad $6, %xmm0
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1],xmm1[3,3]
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [8,16,32,256]
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm0, %xmm3
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[0,2,2,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_lt_ashr_extact1:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrad $8, %xmm1
; SSE41-NEXT:    movdqa %xmm0, %xmm2
; SSE41-NEXT:    psrad $6, %xmm2
; SSE41-NEXT:    pblendw {{.*#+}} xmm2 = xmm2[0,1,2,3],xmm1[4,5,6,7]
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrad $7, %xmm1
; SSE41-NEXT:    psrad $5, %xmm0
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1,2,3],xmm1[4,5,6,7]
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1],xmm2[2,3],xmm0[4,5],xmm2[6,7]
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_lt_ashr_extact1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsravd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = ashr exact <4 x i32> %x, <i32 5, i32 6, i32 7, i32 8>
  %2 = shl <4 x i32> %1, <i32 3, i32 4, i32 5, i32 8>
  ret <4 x i32> %2
}

; fold (shl (srl x, c1), c2) -> (and (shl x, (sub c2, c1), MASK) if C2 > C1
define <4 x i32> @combine_vec_shl_gt_lshr0(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_gt_lshr0:
; SSE:       # %bb.0:
; SSE-NEXT:    pslld $2, %xmm0
; SSE-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_gt_lshr0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [4294967264,4294967264,4294967264,4294967264]
; AVX-NEXT:    vpslld $2, %xmm0, %xmm0
; AVX-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = lshr <4 x i32> %x, <i32 3, i32 3, i32 3, i32 3>
  %2 = shl <4 x i32> %1, <i32 5, i32 5, i32 5, i32 5>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_gt_lshr1(<4 x i32> %x) {
; SSE2-LABEL: combine_vec_shl_gt_lshr1:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrld $3, %xmm1
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    psrld $5, %xmm2
; SSE2-NEXT:    movsd {{.*#+}} xmm2 = xmm1[0],xmm2[1]
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrld $8, %xmm1
; SSE2-NEXT:    psrld $4, %xmm0
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1],xmm1[3,3]
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [32,64,128,256]
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm0, %xmm3
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[0,2,2,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_gt_lshr1:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrld $8, %xmm1
; SSE41-NEXT:    movdqa %xmm0, %xmm2
; SSE41-NEXT:    psrld $4, %xmm2
; SSE41-NEXT:    pblendw {{.*#+}} xmm2 = xmm2[0,1,2,3],xmm1[4,5,6,7]
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrld $5, %xmm1
; SSE41-NEXT:    psrld $3, %xmm0
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1,2,3],xmm1[4,5,6,7]
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1],xmm2[2,3],xmm0[4,5],xmm2[6,7]
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_gt_lshr1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = lshr <4 x i32> %x, <i32 3, i32 4, i32 5, i32 8>
  %2 = shl <4 x i32> %1, <i32 5, i32 6, i32 7, i32 8>
  ret <4 x i32> %2
}

; fold (shl (srl x, c1), c2) -> (and (srl x, (sub c1, c2), MASK) if C1 >= C2
define <4 x i32> @combine_vec_shl_le_lshr0(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_le_lshr0:
; SSE:       # %bb.0:
; SSE-NEXT:    psrld $2, %xmm0
; SSE-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_le_lshr0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [1073741816,1073741816,1073741816,1073741816]
; AVX-NEXT:    vpsrld $2, %xmm0, %xmm0
; AVX-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = lshr <4 x i32> %x, <i32 5, i32 5, i32 5, i32 5>
  %2 = shl <4 x i32> %1, <i32 3, i32 3, i32 3, i32 3>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_le_lshr1(<4 x i32> %x) {
; SSE2-LABEL: combine_vec_shl_le_lshr1:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrld $5, %xmm1
; SSE2-NEXT:    movdqa %xmm0, %xmm2
; SSE2-NEXT:    psrld $7, %xmm2
; SSE2-NEXT:    movsd {{.*#+}} xmm2 = xmm1[0],xmm2[1]
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    psrld $8, %xmm1
; SSE2-NEXT:    psrld $6, %xmm0
; SSE2-NEXT:    shufps {{.*#+}} xmm0 = xmm0[1,1],xmm1[3,3]
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [8,16,32,256]
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm0, %xmm3
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm3[0,2,2,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_le_lshr1:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrld $8, %xmm1
; SSE41-NEXT:    movdqa %xmm0, %xmm2
; SSE41-NEXT:    psrld $6, %xmm2
; SSE41-NEXT:    pblendw {{.*#+}} xmm2 = xmm2[0,1,2,3],xmm1[4,5,6,7]
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    psrld $7, %xmm1
; SSE41-NEXT:    psrld $5, %xmm0
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1,2,3],xmm1[4,5,6,7]
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1],xmm2[2,3],xmm0[4,5],xmm2[6,7]
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_le_lshr1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = lshr <4 x i32> %x, <i32 5, i32 6, i32 7, i32 8>
  %2 = shl <4 x i32> %1, <i32 3, i32 4, i32 5, i32 8>
  ret <4 x i32> %2
}

; fold (shl (sra x, c1), c1) -> (and x, (shl -1, c1))
define <4 x i32> @combine_vec_shl_ashr0(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_ashr0:
; SSE:       # %bb.0:
; SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_ashr0:
; AVX:       # %bb.0:
; AVX-NEXT:    vbroadcastss {{.*#+}} xmm1 = [4294967264,4294967264,4294967264,4294967264]
; AVX-NEXT:    vandps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = ashr <4 x i32> %x, <i32 5, i32 5, i32 5, i32 5>
  %2 = shl <4 x i32> %1, <i32 5, i32 5, i32 5, i32 5>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_ashr1(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_ashr1:
; SSE:       # %bb.0:
; SSE-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_ashr1:
; AVX:       # %bb.0:
; AVX-NEXT:    vandps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = ashr <4 x i32> %x, <i32 5, i32 6, i32 7, i32 8>
  %2 = shl <4 x i32> %1, <i32 5, i32 6, i32 7, i32 8>
  ret <4 x i32> %2
}

; fold (shl (add x, c1), c2) -> (add (shl x, c2), c1 << c2)
define <4 x i32> @combine_vec_shl_add0(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_add0:
; SSE:       # %bb.0:
; SSE-NEXT:    pslld $2, %xmm0
; SSE-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_add0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpslld $2, %xmm0, %xmm0
; AVX-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [20,20,20,20]
; AVX-NEXT:    vpaddd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = add <4 x i32> %x, <i32 5, i32 5, i32 5, i32 5>
  %2 = shl <4 x i32> %1, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_add1(<4 x i32> %x) {
; SSE2-LABEL: combine_vec_shl_add1:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [2,4,8,16]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_add1:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    paddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_add1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpaddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = add <4 x i32> %x, <i32 5, i32 6, i32 7, i32 8>
  %2 = shl <4 x i32> %1, <i32 1, i32 2, i32 3, i32 4>
  ret <4 x i32> %2
}

; fold (shl (or x, c1), c2) -> (or (shl x, c2), c1 << c2)
define <4 x i32> @combine_vec_shl_or0(<4 x i32> %x) {
; SSE-LABEL: combine_vec_shl_or0:
; SSE:       # %bb.0:
; SSE-NEXT:    pslld $2, %xmm0
; SSE-NEXT:    por {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_or0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpslld $2, %xmm0, %xmm0
; AVX-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [20,20,20,20]
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = or  <4 x i32> %x, <i32 5, i32 5, i32 5, i32 5>
  %2 = shl <4 x i32> %1, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_or1(<4 x i32> %x) {
; SSE2-LABEL: combine_vec_shl_or1:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [2,4,8,16]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    por {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_or1:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    por {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_or1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = or  <4 x i32> %x, <i32 5, i32 6, i32 7, i32 8>
  %2 = shl <4 x i32> %1, <i32 1, i32 2, i32 3, i32 4>
  ret <4 x i32> %2
}

; fold (shl (mul x, c1), c2) -> (mul x, c1 << c2)
define <4 x i32> @combine_vec_shl_mul0(<4 x i32> %x) {
; SSE2-LABEL: combine_vec_shl_mul0:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [20,20,20,20]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_mul0:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_mul0:
; AVX:       # %bb.0:
; AVX-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [20,20,20,20]
; AVX-NEXT:    vpmulld %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = mul <4 x i32> %x, <i32 5, i32 5, i32 5, i32 5>
  %2 = shl <4 x i32> %1, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_shl_mul1(<4 x i32> %x) {
; SSE2-LABEL: combine_vec_shl_mul1:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [10,24,56,128]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_shl_mul1:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_shl_mul1:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = mul <4 x i32> %x, <i32 5, i32 6, i32 7, i32 8>
  %2 = shl <4 x i32> %1, <i32 1, i32 2, i32 3, i32 4>
  ret <4 x i32> %2
}

; fold (add (shl x, c1), c2) -> (or (shl x, c1), c2)
define <4 x i32> @combine_vec_add_shl_nonsplat(<4 x i32> %a0)  {
; SSE2-LABEL: combine_vec_add_shl_nonsplat:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [4,8,16,32]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    por {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_add_shl_nonsplat:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    por {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_shl_nonsplat:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [3,3,3,3]
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shl <4 x i32> %a0, <i32 2, i32 3, i32 4, i32 5>
  %2 = add <4 x i32> %1, <i32 3, i32 3, i32 3, i32 3>
  ret <4 x i32> %2
}

define <4 x i32> @combine_vec_add_shl_and_nonsplat(<4 x i32> %a0)  {
; SSE2-LABEL: combine_vec_add_shl_and_nonsplat:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [4,8,16,32]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    por {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_add_shl_and_nonsplat:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pxor %xmm1, %xmm1
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm1[0],xmm0[1],xmm1[2],xmm0[3],xmm1[4],xmm0[5],xmm1[6],xmm0[7]
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    por {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_shl_and_nonsplat:
; AVX:       # %bb.0:
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpblendw {{.*#+}} xmm0 = xmm1[0],xmm0[1],xmm1[2],xmm0[3],xmm1[4],xmm0[5],xmm1[6],xmm0[7]
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [15,15,15,15]
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = and <4 x i32> %a0, <i32 4294901760, i32 4294901760, i32 4294901760, i32 4294901760>
  %2 = shl <4 x i32> %1, <i32 2, i32 3, i32 4, i32 5>
  %3 = add <4 x i32> %2, <i32 15, i32 15, i32 15, i32 15>
  ret <4 x i32> %3
}

define <4 x i32> @combine_vec_add_shuffle_shl(<4 x i32> %a0)  {
; SSE2-LABEL: combine_vec_add_shuffle_shl:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movdqa %xmm0, %xmm1
; SSE2-NEXT:    pslld $3, %xmm1
; SSE2-NEXT:    pslld $2, %xmm0
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,3,3,0]
; SSE2-NEXT:    por {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE2-NEXT:    retq
;
; SSE41-LABEL: combine_vec_add_shuffle_shl:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movdqa %xmm0, %xmm1
; SSE41-NEXT:    pslld $3, %xmm1
; SSE41-NEXT:    pslld $2, %xmm0
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0,1],xmm1[2,3],xmm0[4,5,6,7]
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,1,1,0]
; SSE41-NEXT:    por {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: combine_vec_add_shuffle_shl:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,1,1,0]
; AVX-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [3,3,3,3]
; AVX-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = shl <4 x i32> %a0, <i32 2, i32 3, i32 0, i32 1>
  %2 = shufflevector <4 x i32> %1, <4 x i32> undef, <4 x i32> <i32 0, i32 1, i32 1, i32 0>
  %3 = add <4 x i32> %2, <i32 3, i32 3, i32 3, i32 3>
  ret <4 x i32> %3
}
