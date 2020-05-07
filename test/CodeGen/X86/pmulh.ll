; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefix=SSE --check-prefix=SSE2 --check-prefix=SSE2-PROMOTE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=SSE --check-prefix=SSE41 --check-prefix=SSE41-PROMOTE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=AVX --check-prefix=AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f | FileCheck %s --check-prefix=AVX --check-prefix=AVX512 --check-prefix=AVX512F
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw | FileCheck %s --check-prefix=AVX --check-prefix=AVX512 --check-prefix=AVX512BW

define <4 x i16> @mulhuw_v4i16(<4 x i16> %a, <4 x i16> %b) {
; SSE-LABEL: mulhuw_v4i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pmulhuw %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: mulhuw_v4i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulhuw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a1 = zext <4 x i16> %a to <4 x i32>
  %b1 = zext <4 x i16> %b to <4 x i32>
  %c = mul <4 x i32> %a1, %b1
  %d = lshr <4 x i32> %c, <i32 16, i32 16, i32 16, i32 16>
  %e = trunc <4 x i32> %d to <4 x i16>
  ret <4 x i16> %e
}

define <4 x i16> @mulhw_v4i16(<4 x i16> %a, <4 x i16> %b) {
; SSE-LABEL: mulhw_v4i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pmulhw %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: mulhw_v4i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulhw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a1 = sext <4 x i16> %a to <4 x i32>
  %b1 = sext <4 x i16> %b to <4 x i32>
  %c = mul <4 x i32> %a1, %b1
  %d = lshr <4 x i32> %c, <i32 16, i32 16, i32 16, i32 16>
  %e = trunc <4 x i32> %d to <4 x i16>
  ret <4 x i16> %e
}

define <8 x i16> @mulhuw_v8i16(<8 x i16> %a, <8 x i16> %b) {
; SSE-LABEL: mulhuw_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pmulhuw %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: mulhuw_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulhuw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a1 = zext <8 x i16> %a to <8 x i32>
  %b1 = zext <8 x i16> %b to <8 x i32>
  %c = mul <8 x i32> %a1, %b1
  %d = lshr <8 x i32> %c, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %e = trunc <8 x i32> %d to <8 x i16>
  ret <8 x i16> %e
}

define <8 x i16> @mulhw_v8i16(<8 x i16> %a, <8 x i16> %b) {
; SSE-LABEL: mulhw_v8i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pmulhw %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: mulhw_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulhw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a1 = sext <8 x i16> %a to <8 x i32>
  %b1 = sext <8 x i16> %b to <8 x i32>
  %c = mul <8 x i32> %a1, %b1
  %d = lshr <8 x i32> %c, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %e = trunc <8 x i32> %d to <8 x i16>
  ret <8 x i16> %e
}

define <16 x i16> @mulhuw_v16i16(<16 x i16> %a, <16 x i16> %b) {
; SSE-LABEL: mulhuw_v16i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pmulhuw %xmm2, %xmm0
; SSE-NEXT:    pmulhuw %xmm3, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: mulhuw_v16i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulhuw %ymm1, %ymm0, %ymm0
; AVX-NEXT:    retq
  %a1 = zext <16 x i16> %a to <16 x i32>
  %b1 = zext <16 x i16> %b to <16 x i32>
  %c = mul <16 x i32> %a1, %b1
  %d = lshr <16 x i32> %c, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %e = trunc <16 x i32> %d to <16 x i16>
  ret <16 x i16> %e
}

define <16 x i16> @mulhw_v16i16(<16 x i16> %a, <16 x i16> %b) {
; SSE-LABEL: mulhw_v16i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pmulhw %xmm2, %xmm0
; SSE-NEXT:    pmulhw %xmm3, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: mulhw_v16i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulhw %ymm1, %ymm0, %ymm0
; AVX-NEXT:    retq
  %a1 = sext <16 x i16> %a to <16 x i32>
  %b1 = sext <16 x i16> %b to <16 x i32>
  %c = mul <16 x i32> %a1, %b1
  %d = lshr <16 x i32> %c, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %e = trunc <16 x i32> %d to <16 x i16>
  ret <16 x i16> %e
}

define <32 x i16> @mulhuw_v32i16(<32 x i16> %a, <32 x i16> %b) {
; SSE-LABEL: mulhuw_v32i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pmulhuw %xmm4, %xmm0
; SSE-NEXT:    pmulhuw %xmm5, %xmm1
; SSE-NEXT:    pmulhuw %xmm6, %xmm2
; SSE-NEXT:    pmulhuw %xmm7, %xmm3
; SSE-NEXT:    retq
;
; AVX2-LABEL: mulhuw_v32i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmulhuw %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpmulhuw %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: mulhuw_v32i16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vextracti64x4 $1, %zmm1, %ymm2
; AVX512F-NEXT:    vextracti64x4 $1, %zmm0, %ymm3
; AVX512F-NEXT:    vpmulhuw %ymm2, %ymm3, %ymm2
; AVX512F-NEXT:    vpmulhuw %ymm1, %ymm0, %ymm0
; AVX512F-NEXT:    vinserti64x4 $1, %ymm2, %zmm0, %zmm0
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: mulhuw_v32i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmulhuw %zmm1, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %a1 = zext <32 x i16> %a to <32 x i32>
  %b1 = zext <32 x i16> %b to <32 x i32>
  %c = mul <32 x i32> %a1, %b1
  %d = lshr <32 x i32> %c, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %e = trunc <32 x i32> %d to <32 x i16>
  ret <32 x i16> %e
}

define <32 x i16> @mulhw_v32i16(<32 x i16> %a, <32 x i16> %b) {
; SSE-LABEL: mulhw_v32i16:
; SSE:       # %bb.0:
; SSE-NEXT:    pmulhw %xmm4, %xmm0
; SSE-NEXT:    pmulhw %xmm5, %xmm1
; SSE-NEXT:    pmulhw %xmm6, %xmm2
; SSE-NEXT:    pmulhw %xmm7, %xmm3
; SSE-NEXT:    retq
;
; AVX2-LABEL: mulhw_v32i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmulhw %ymm2, %ymm0, %ymm0
; AVX2-NEXT:    vpmulhw %ymm3, %ymm1, %ymm1
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: mulhw_v32i16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vextracti64x4 $1, %zmm1, %ymm2
; AVX512F-NEXT:    vextracti64x4 $1, %zmm0, %ymm3
; AVX512F-NEXT:    vpmulhw %ymm2, %ymm3, %ymm2
; AVX512F-NEXT:    vpmulhw %ymm1, %ymm0, %ymm0
; AVX512F-NEXT:    vinserti64x4 $1, %ymm2, %zmm0, %zmm0
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: mulhw_v32i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmulhw %zmm1, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %a1 = sext <32 x i16> %a to <32 x i32>
  %b1 = sext <32 x i16> %b to <32 x i32>
  %c = mul <32 x i32> %a1, %b1
  %d = lshr <32 x i32> %c, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %e = trunc <32 x i32> %d to <32 x i16>
  ret <32 x i16> %e
}

define <64 x i16> @mulhuw_v64i16(<64 x i16> %a, <64 x i16> %b) {
; SSE-LABEL: mulhuw_v64i16:
; SSE:       # %bb.0:
; SSE-NEXT:    movq %rdi, %rax
; SSE-NEXT:    pmulhuw {{[0-9]+}}(%rsp), %xmm0
; SSE-NEXT:    pmulhuw {{[0-9]+}}(%rsp), %xmm1
; SSE-NEXT:    pmulhuw {{[0-9]+}}(%rsp), %xmm2
; SSE-NEXT:    pmulhuw {{[0-9]+}}(%rsp), %xmm3
; SSE-NEXT:    pmulhuw {{[0-9]+}}(%rsp), %xmm4
; SSE-NEXT:    pmulhuw {{[0-9]+}}(%rsp), %xmm5
; SSE-NEXT:    pmulhuw {{[0-9]+}}(%rsp), %xmm6
; SSE-NEXT:    pmulhuw {{[0-9]+}}(%rsp), %xmm7
; SSE-NEXT:    movdqa %xmm7, 112(%rdi)
; SSE-NEXT:    movdqa %xmm6, 96(%rdi)
; SSE-NEXT:    movdqa %xmm5, 80(%rdi)
; SSE-NEXT:    movdqa %xmm4, 64(%rdi)
; SSE-NEXT:    movdqa %xmm3, 48(%rdi)
; SSE-NEXT:    movdqa %xmm2, 32(%rdi)
; SSE-NEXT:    movdqa %xmm1, 16(%rdi)
; SSE-NEXT:    movdqa %xmm0, (%rdi)
; SSE-NEXT:    retq
;
; AVX2-LABEL: mulhuw_v64i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmulhuw %ymm4, %ymm0, %ymm0
; AVX2-NEXT:    vpmulhuw %ymm5, %ymm1, %ymm1
; AVX2-NEXT:    vpmulhuw %ymm6, %ymm2, %ymm2
; AVX2-NEXT:    vpmulhuw %ymm7, %ymm3, %ymm3
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: mulhuw_v64i16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vextracti64x4 $1, %zmm2, %ymm4
; AVX512F-NEXT:    vextracti64x4 $1, %zmm0, %ymm5
; AVX512F-NEXT:    vpmulhuw %ymm4, %ymm5, %ymm4
; AVX512F-NEXT:    vpmulhuw %ymm2, %ymm0, %ymm0
; AVX512F-NEXT:    vinserti64x4 $1, %ymm4, %zmm0, %zmm0
; AVX512F-NEXT:    vextracti64x4 $1, %zmm3, %ymm2
; AVX512F-NEXT:    vextracti64x4 $1, %zmm1, %ymm4
; AVX512F-NEXT:    vpmulhuw %ymm2, %ymm4, %ymm2
; AVX512F-NEXT:    vpmulhuw %ymm3, %ymm1, %ymm1
; AVX512F-NEXT:    vinserti64x4 $1, %ymm2, %zmm1, %zmm1
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: mulhuw_v64i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmulhuw %zmm2, %zmm0, %zmm0
; AVX512BW-NEXT:    vpmulhuw %zmm3, %zmm1, %zmm1
; AVX512BW-NEXT:    retq
  %a1 = zext <64 x i16> %a to <64 x i32>
  %b1 = zext <64 x i16> %b to <64 x i32>
  %c = mul <64 x i32> %a1, %b1
  %d = lshr <64 x i32> %c, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %e = trunc <64 x i32> %d to <64 x i16>
  ret <64 x i16> %e
}

define <64 x i16> @mulhw_v64i16(<64 x i16> %a, <64 x i16> %b) {
; SSE-LABEL: mulhw_v64i16:
; SSE:       # %bb.0:
; SSE-NEXT:    movq %rdi, %rax
; SSE-NEXT:    pmulhw {{[0-9]+}}(%rsp), %xmm0
; SSE-NEXT:    pmulhw {{[0-9]+}}(%rsp), %xmm1
; SSE-NEXT:    pmulhw {{[0-9]+}}(%rsp), %xmm2
; SSE-NEXT:    pmulhw {{[0-9]+}}(%rsp), %xmm3
; SSE-NEXT:    pmulhw {{[0-9]+}}(%rsp), %xmm4
; SSE-NEXT:    pmulhw {{[0-9]+}}(%rsp), %xmm5
; SSE-NEXT:    pmulhw {{[0-9]+}}(%rsp), %xmm6
; SSE-NEXT:    pmulhw {{[0-9]+}}(%rsp), %xmm7
; SSE-NEXT:    movdqa %xmm7, 112(%rdi)
; SSE-NEXT:    movdqa %xmm6, 96(%rdi)
; SSE-NEXT:    movdqa %xmm5, 80(%rdi)
; SSE-NEXT:    movdqa %xmm4, 64(%rdi)
; SSE-NEXT:    movdqa %xmm3, 48(%rdi)
; SSE-NEXT:    movdqa %xmm2, 32(%rdi)
; SSE-NEXT:    movdqa %xmm1, 16(%rdi)
; SSE-NEXT:    movdqa %xmm0, (%rdi)
; SSE-NEXT:    retq
;
; AVX2-LABEL: mulhw_v64i16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmulhw %ymm4, %ymm0, %ymm0
; AVX2-NEXT:    vpmulhw %ymm5, %ymm1, %ymm1
; AVX2-NEXT:    vpmulhw %ymm6, %ymm2, %ymm2
; AVX2-NEXT:    vpmulhw %ymm7, %ymm3, %ymm3
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: mulhw_v64i16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vextracti64x4 $1, %zmm2, %ymm4
; AVX512F-NEXT:    vextracti64x4 $1, %zmm0, %ymm5
; AVX512F-NEXT:    vpmulhw %ymm4, %ymm5, %ymm4
; AVX512F-NEXT:    vpmulhw %ymm2, %ymm0, %ymm0
; AVX512F-NEXT:    vinserti64x4 $1, %ymm4, %zmm0, %zmm0
; AVX512F-NEXT:    vextracti64x4 $1, %zmm3, %ymm2
; AVX512F-NEXT:    vextracti64x4 $1, %zmm1, %ymm4
; AVX512F-NEXT:    vpmulhw %ymm2, %ymm4, %ymm2
; AVX512F-NEXT:    vpmulhw %ymm3, %ymm1, %ymm1
; AVX512F-NEXT:    vinserti64x4 $1, %ymm2, %zmm1, %zmm1
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: mulhw_v64i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmulhw %zmm2, %zmm0, %zmm0
; AVX512BW-NEXT:    vpmulhw %zmm3, %zmm1, %zmm1
; AVX512BW-NEXT:    retq
  %a1 = sext <64 x i16> %a to <64 x i32>
  %b1 = sext <64 x i16> %b to <64 x i32>
  %c = mul <64 x i32> %a1, %b1
  %d = lshr <64 x i32> %c, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %e = trunc <64 x i32> %d to <64 x i16>
  ret <64 x i16> %e
}

define <8 x i16> @mulhuw_v8i16_i64(<8 x i16> %a, <8 x i16> %b) {
; SSE2-LABEL: mulhuw_v8i16_i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pxor %xmm4, %xmm4
; SSE2-NEXT:    movdqa %xmm0, %xmm5
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm5 = xmm5[4],xmm4[4],xmm5[5],xmm4[5],xmm5[6],xmm4[6],xmm5[7],xmm4[7]
; SSE2-NEXT:    movdqa %xmm5, %xmm6
; SSE2-NEXT:    punpckldq {{.*#+}} xmm6 = xmm6[0],xmm4[0],xmm6[1],xmm4[1]
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm5 = xmm5[2],xmm4[2],xmm5[3],xmm4[3]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm4[0],xmm0[1],xmm4[1],xmm0[2],xmm4[2],xmm0[3],xmm4[3]
; SSE2-NEXT:    movdqa %xmm0, %xmm7
; SSE2-NEXT:    punpckldq {{.*#+}} xmm7 = xmm7[0],xmm4[0],xmm7[1],xmm4[1]
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm0 = xmm0[2],xmm4[2],xmm0[3],xmm4[3]
; SSE2-NEXT:    movdqa %xmm1, %xmm2
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm2 = xmm2[4],xmm4[4],xmm2[5],xmm4[5],xmm2[6],xmm4[6],xmm2[7],xmm4[7]
; SSE2-NEXT:    movdqa %xmm2, %xmm3
; SSE2-NEXT:    punpckldq {{.*#+}} xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
; SSE2-NEXT:    pmuludq %xmm6, %xmm3
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm2 = xmm2[2],xmm4[2],xmm2[3],xmm4[3]
; SSE2-NEXT:    pmuludq %xmm5, %xmm2
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1],xmm1[2],xmm4[2],xmm1[3],xmm4[3]
; SSE2-NEXT:    movdqa %xmm1, %xmm5
; SSE2-NEXT:    punpckldq {{.*#+}} xmm5 = xmm5[0],xmm4[0],xmm5[1],xmm4[1]
; SSE2-NEXT:    pmuludq %xmm7, %xmm5
; SSE2-NEXT:    punpckhdq {{.*#+}} xmm1 = xmm1[2],xmm4[2],xmm1[3],xmm4[3]
; SSE2-NEXT:    pmuludq %xmm0, %xmm1
; SSE2-NEXT:    psrlq $16, %xmm3
; SSE2-NEXT:    psrlq $16, %xmm2
; SSE2-NEXT:    psrlq $16, %xmm5
; SSE2-NEXT:    psrlq $16, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[0,2,2,3]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,2,2,3,4,5,6,7]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm5[0,2,2,3]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm1 = xmm1[0,2,2,3,4,5,6,7]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[0,2,2,3]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm2 = xmm0[0,1,0,2,4,5,6,7]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm3[0,2,2,3]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,1,0,2,4,5,6,7]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = xmm1[0],xmm0[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: mulhuw_v8i16_i64:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm2 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
; SSE41-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[1,1,2,3]
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm3 = xmm3[0],zero,zero,zero,xmm3[1],zero,zero,zero
; SSE41-NEXT:    pshufd {{.*#+}} xmm4 = xmm0[3,1,2,3]
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm4 = xmm4[0],zero,zero,zero,xmm4[1],zero,zero,zero
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm5 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm0 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero
; SSE41-NEXT:    pmuldq %xmm2, %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[1,1,2,3]
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm2 = xmm2[0],zero,zero,zero,xmm2[1],zero,zero,zero
; SSE41-NEXT:    pmuldq %xmm3, %xmm2
; SSE41-NEXT:    pshufd {{.*#+}} xmm3 = xmm1[3,1,2,3]
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm3 = xmm3[0],zero,zero,zero,xmm3[1],zero,zero,zero
; SSE41-NEXT:    pmuldq %xmm4, %xmm3
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[2,3,0,1]
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm1 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero
; SSE41-NEXT:    pmuldq %xmm5, %xmm1
; SSE41-NEXT:    psrlq $16, %xmm0
; SSE41-NEXT:    psrlq $16, %xmm2
; SSE41-NEXT:    packusdw %xmm2, %xmm0
; SSE41-NEXT:    psrlq $16, %xmm3
; SSE41-NEXT:    psrlq $16, %xmm1
; SSE41-NEXT:    packusdw %xmm3, %xmm1
; SSE41-NEXT:    packusdw %xmm1, %xmm0
; SSE41-NEXT:    retq
;
; AVX2-LABEL: mulhuw_v8i16_i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovzxwq {{.*#+}} ymm2 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpmovzxwq {{.*#+}} ymm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
; AVX2-NEXT:    vpmovzxwq {{.*#+}} ymm3 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero,xmm1[2],zero,zero,zero,xmm1[3],zero,zero,zero
; AVX2-NEXT:    vpmuldq %ymm3, %ymm2, %ymm2
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[2,3,0,1]
; AVX2-NEXT:    vpmovzxwq {{.*#+}} ymm1 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero,xmm1[2],zero,zero,zero,xmm1[3],zero,zero,zero
; AVX2-NEXT:    vpmuldq %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrlq $16, %ymm2, %ymm1
; AVX2-NEXT:    vpsrlq $16, %ymm0, %ymm0
; AVX2-NEXT:    vpackusdw %ymm0, %ymm1, %ymm0
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,1,3]
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vpackusdw %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: mulhuw_v8i16_i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpmovzxwq {{.*#+}} zmm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero,xmm0[4],zero,zero,zero,xmm0[5],zero,zero,zero,xmm0[6],zero,zero,zero,xmm0[7],zero,zero,zero
; AVX512-NEXT:    vpmovzxwq {{.*#+}} zmm1 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero,xmm1[2],zero,zero,zero,xmm1[3],zero,zero,zero,xmm1[4],zero,zero,zero,xmm1[5],zero,zero,zero,xmm1[6],zero,zero,zero,xmm1[7],zero,zero,zero
; AVX512-NEXT:    vpmuldq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrlq $16, %zmm0, %zmm0
; AVX512-NEXT:    vpmovqw %zmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %a1 = zext <8 x i16> %a to <8 x i64>
  %b1 = zext <8 x i16> %b to <8 x i64>
  %c = mul <8 x i64> %a1, %b1
  %d = lshr <8 x i64> %c, <i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16>
  %e = trunc <8 x i64> %d to <8 x i16>
  ret <8 x i16> %e
}

define <8 x i16> @mulhw_v8i16_i64(<8 x i16> %a, <8 x i16> %b) {
; SSE2-LABEL: mulhw_v8i16_i64:
; SSE2:       # %bb.0:
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm2 = xmm2[4],xmm0[4],xmm2[5],xmm0[5],xmm2[6],xmm0[6],xmm2[7],xmm0[7]
; SSE2-NEXT:    psrad $16, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,1,1,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[2,1,3,3]
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; SSE2-NEXT:    psrad $16, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm4 = xmm0[0,1,1,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,1,3,3]
; SSE2-NEXT:    punpckhwd {{.*#+}} xmm5 = xmm5[4],xmm1[4],xmm5[5],xmm1[5],xmm5[6],xmm1[6],xmm5[7],xmm1[7]
; SSE2-NEXT:    psrad $16, %xmm5
; SSE2-NEXT:    pshufd {{.*#+}} xmm6 = xmm5[0,1,1,3]
; SSE2-NEXT:    pmuludq %xmm3, %xmm6
; SSE2-NEXT:    pshufd {{.*#+}} xmm3 = xmm5[2,1,3,3]
; SSE2-NEXT:    pmuludq %xmm2, %xmm3
; SSE2-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0,0,1,1,2,2,3,3]
; SSE2-NEXT:    psrad $16, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[0,1,1,3]
; SSE2-NEXT:    pmuludq %xmm4, %xmm2
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[2,1,3,3]
; SSE2-NEXT:    pmuludq %xmm0, %xmm1
; SSE2-NEXT:    psrlq $16, %xmm6
; SSE2-NEXT:    psrlq $16, %xmm3
; SSE2-NEXT:    psrlq $16, %xmm2
; SSE2-NEXT:    psrlq $16, %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[0,2,2,3]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,2,2,3,4,5,6,7]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[0,2,2,3]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm1 = xmm1[0,2,2,3,4,5,6,7]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm3[0,2,2,3]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm2 = xmm0[0,1,0,2,4,5,6,7]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm6[0,2,2,3]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,1,0,2,4,5,6,7]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = xmm1[0],xmm0[1]
; SSE2-NEXT:    retq
;
; SSE41-LABEL: mulhw_v8i16_i64:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,2,3]
; SSE41-NEXT:    pmovsxwq %xmm2, %xmm3
; SSE41-NEXT:    pmovsxwq %xmm0, %xmm4
; SSE41-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[2,3,0,1]
; SSE41-NEXT:    pmovsxwq %xmm2, %xmm5
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,1,2,3]
; SSE41-NEXT:    pmovsxwq %xmm0, %xmm6
; SSE41-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,2,3]
; SSE41-NEXT:    pmovsxwq %xmm0, %xmm2
; SSE41-NEXT:    pmuldq %xmm3, %xmm2
; SSE41-NEXT:    pmovsxwq %xmm1, %xmm0
; SSE41-NEXT:    pmuldq %xmm4, %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm3 = xmm1[2,3,0,1]
; SSE41-NEXT:    pmovsxwq %xmm3, %xmm3
; SSE41-NEXT:    pmuldq %xmm5, %xmm3
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[3,1,2,3]
; SSE41-NEXT:    pmovsxwq %xmm1, %xmm1
; SSE41-NEXT:    pmuldq %xmm6, %xmm1
; SSE41-NEXT:    psrlq $16, %xmm2
; SSE41-NEXT:    psrlq $16, %xmm0
; SSE41-NEXT:    psrlq $16, %xmm3
; SSE41-NEXT:    psrlq $16, %xmm1
; SSE41-NEXT:    pxor %xmm4, %xmm4
; SSE41-NEXT:    pblendw {{.*#+}} xmm1 = xmm1[0],xmm4[1,2,3],xmm1[4],xmm4[5,6,7]
; SSE41-NEXT:    pblendw {{.*#+}} xmm3 = xmm3[0],xmm4[1,2,3],xmm3[4],xmm4[5,6,7]
; SSE41-NEXT:    packusdw %xmm1, %xmm3
; SSE41-NEXT:    pblendw {{.*#+}} xmm0 = xmm0[0],xmm4[1,2,3],xmm0[4],xmm4[5,6,7]
; SSE41-NEXT:    pblendw {{.*#+}} xmm2 = xmm2[0],xmm4[1,2,3],xmm2[4],xmm4[5,6,7]
; SSE41-NEXT:    packusdw %xmm2, %xmm0
; SSE41-NEXT:    packusdw %xmm3, %xmm0
; SSE41-NEXT:    retq
;
; AVX2-LABEL: mulhw_v8i16_i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovsxwq %xmm0, %ymm2
; AVX2-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; AVX2-NEXT:    vpmovsxwq %xmm0, %ymm0
; AVX2-NEXT:    vpmovsxwq %xmm1, %ymm3
; AVX2-NEXT:    vpmuldq %ymm3, %ymm2, %ymm2
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[2,3,0,1]
; AVX2-NEXT:    vpmovsxwq %xmm1, %ymm1
; AVX2-NEXT:    vpmuldq %ymm1, %ymm0, %ymm0
; AVX2-NEXT:    vpsrlq $16, %ymm2, %ymm1
; AVX2-NEXT:    vpsrlq $16, %ymm0, %ymm0
; AVX2-NEXT:    vperm2i128 {{.*#+}} ymm2 = ymm1[2,3],ymm0[2,3]
; AVX2-NEXT:    vinserti128 $1, %xmm0, %ymm1, %ymm0
; AVX2-NEXT:    vshufps {{.*#+}} ymm0 = ymm0[0,2],ymm2[0,2],ymm0[4,6],ymm2[4,6]
; AVX2-NEXT:    vpshufb {{.*#+}} ymm0 = ymm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15,16,17,20,21,24,25,28,29,24,25,28,29,28,29,30,31]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    # kill: def $xmm0 killed $xmm0 killed $ymm0
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: mulhw_v8i16_i64:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpmovsxwq %xmm0, %zmm0
; AVX512-NEXT:    vpmovsxwq %xmm1, %zmm1
; AVX512-NEXT:    vpmuldq %zmm1, %zmm0, %zmm0
; AVX512-NEXT:    vpsrlq $16, %zmm0, %zmm0
; AVX512-NEXT:    vpmovqw %zmm0, %xmm0
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %a1 = sext <8 x i16> %a to <8 x i64>
  %b1 = sext <8 x i16> %b to <8 x i64>
  %c = mul <8 x i64> %a1, %b1
  %d = lshr <8 x i64> %c, <i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16, i64 16>
  %e = trunc <8 x i64> %d to <8 x i16>
  ret <8 x i16> %e
}
