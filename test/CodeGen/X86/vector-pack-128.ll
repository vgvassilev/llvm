; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2   | FileCheck %s --check-prefixes=SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.2 | FileCheck %s --check-prefixes=SSE,SSE4
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx    | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2   | FileCheck %s --check-prefixes=AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,+avx512f  | FileCheck %s --check-prefixes=AVX,AVX512,AVX512F
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,+avx512bw | FileCheck %s --check-prefixes=AVX,AVX512,AVX512BW

; trunc(concat(x,y)) -> pack

define <8 x i16> @trunc_concat_packssdw_128(<4 x i32> %a0, <4 x i32> %a1) nounwind {
; SSE-LABEL: trunc_concat_packssdw_128:
; SSE:       # %bb.0:
; SSE-NEXT:    psrad $17, %xmm0
; SSE-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE-NEXT:    packssdw %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX1-LABEL: trunc_concat_packssdw_128:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpsrad $17, %xmm0, %xmm0
; AVX1-NEXT:    vpand {{.*}}(%rip), %xmm1, %xmm1
; AVX1-NEXT:    vpackssdw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: trunc_concat_packssdw_128:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrad $17, %xmm0, %xmm0
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [15,15,15,15]
; AVX2-NEXT:    vpand %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpackssdw %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: trunc_concat_packssdw_128:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpsrad $17, %xmm0, %xmm0
; AVX512-NEXT:    vpandd {{.*}}(%rip){1to4}, %xmm1, %xmm1
; AVX512-NEXT:    vpackssdw %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %1 = ashr <4 x i32> %a0, <i32 17, i32 17, i32 17, i32 17>
  %2 = and  <4 x i32> %a1, <i32 15, i32 15, i32 15, i32 15>
  %3 = shufflevector <4 x i32> %1, <4 x i32> %2, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %4 = trunc <8 x i32> %3 to <8 x i16>
  ret <8 x i16> %4
}

define <8 x i16> @trunc_concat_packusdw_128(<4 x i32> %a0, <4 x i32> %a1) nounwind {
; SSE2-LABEL: trunc_concat_packusdw_128:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrld $17, %xmm0
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE2-NEXT:    packssdw %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; SSE4-LABEL: trunc_concat_packusdw_128:
; SSE4:       # %bb.0:
; SSE4-NEXT:    psrld $17, %xmm0
; SSE4-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE4-NEXT:    packusdw %xmm1, %xmm0
; SSE4-NEXT:    retq
;
; AVX1-LABEL: trunc_concat_packusdw_128:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpsrld $17, %xmm0, %xmm0
; AVX1-NEXT:    vpand {{.*}}(%rip), %xmm1, %xmm1
; AVX1-NEXT:    vpackusdw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: trunc_concat_packusdw_128:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrld $17, %xmm0, %xmm0
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [15,15,15,15]
; AVX2-NEXT:    vpand %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpackusdw %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: trunc_concat_packusdw_128:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpsrld $17, %xmm0, %xmm0
; AVX512-NEXT:    vpandd {{.*}}(%rip){1to4}, %xmm1, %xmm1
; AVX512-NEXT:    vpackusdw %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %1 = lshr <4 x i32> %a0, <i32 17, i32 17, i32 17, i32 17>
  %2 = and  <4 x i32> %a1, <i32 15, i32 15, i32 15, i32 15>
  %3 = shufflevector <4 x i32> %1, <4 x i32> %2, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %4 = trunc <8 x i32> %3 to <8 x i16>
  ret <8 x i16> %4
}

define <16 x i8> @trunc_concat_packsswb_128(<8 x i16> %a0, <8 x i16> %a1) nounwind {
; SSE-LABEL: trunc_concat_packsswb_128:
; SSE:       # %bb.0:
; SSE-NEXT:    psraw $15, %xmm0
; SSE-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE-NEXT:    packsswb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: trunc_concat_packsswb_128:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsraw $15, %xmm0, %xmm0
; AVX-NEXT:    vpand {{.*}}(%rip), %xmm1, %xmm1
; AVX-NEXT:    vpacksswb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = ashr <8 x i16> %a0, <i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15>
  %2 = and  <8 x i16> %a1, <i16  1, i16  1, i16  1, i16  1, i16  1, i16  1, i16  1, i16  1>
  %3 = shufflevector <8 x i16> %1, <8 x i16> %2, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %4 = trunc <16 x i16> %3 to <16 x i8>
  ret <16 x i8> %4
}

define <16 x i8> @trunc_concat_packuswb_128(<8 x i16> %a0, <8 x i16> %a1) nounwind {
; SSE-LABEL: trunc_concat_packuswb_128:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlw $15, %xmm0
; SSE-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE-NEXT:    packuswb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: trunc_concat_packuswb_128:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlw $15, %xmm0, %xmm0
; AVX-NEXT:    vpand {{.*}}(%rip), %xmm1, %xmm1
; AVX-NEXT:    vpackuswb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = lshr <8 x i16> %a0, <i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15>
  %2 = and  <8 x i16> %a1, <i16  1, i16  1, i16  1, i16  1, i16  1, i16  1, i16  1, i16  1>
  %3 = shufflevector <8 x i16> %1, <8 x i16> %2, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %4 = trunc <16 x i16> %3 to <16 x i8>
  ret <16 x i8> %4
}

; concat(trunc(x),trunc(y)) -> pack

define <8 x i16> @concat_trunc_packssdw_128(<4 x i32> %a0, <4 x i32> %a1) nounwind {
; SSE2-LABEL: concat_trunc_packssdw_128:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrad $17, %xmm0
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE2-NEXT:    packssdw %xmm0, %xmm0
; SSE2-NEXT:    packuswb %xmm1, %xmm1
; SSE2-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-NEXT:    retq
;
; SSE4-LABEL: concat_trunc_packssdw_128:
; SSE4:       # %bb.0:
; SSE4-NEXT:    psrad $17, %xmm0
; SSE4-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE4-NEXT:    packssdw %xmm1, %xmm0
; SSE4-NEXT:    retq
;
; AVX1-LABEL: concat_trunc_packssdw_128:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpsrad $17, %xmm0, %xmm0
; AVX1-NEXT:    vpand {{.*}}(%rip), %xmm1, %xmm1
; AVX1-NEXT:    vpackssdw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: concat_trunc_packssdw_128:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrad $17, %xmm0, %xmm0
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [15,15,15,15]
; AVX2-NEXT:    vpand %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpackssdw %xmm0, %xmm0, %xmm0
; AVX2-NEXT:    vpackusdw %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX2-NEXT:    retq
;
; AVX512-LABEL: concat_trunc_packssdw_128:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpsrad $17, %xmm0, %xmm0
; AVX512-NEXT:    vpandd {{.*}}(%rip){1to4}, %xmm1, %xmm1
; AVX512-NEXT:    vpackssdw %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %1 = ashr <4 x i32> %a0, <i32 17, i32 17, i32 17, i32 17>
  %2 = and  <4 x i32> %a1, <i32 15, i32 15, i32 15, i32 15>
  %3 = trunc <4 x i32> %1 to <4 x i16>
  %4 = trunc <4 x i32> %2 to <4 x i16>
  %5 = shufflevector <4 x i16> %3, <4 x i16> %4, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i16> %5
}

define <8 x i16> @concat_trunc_packusdw_128(<4 x i32> %a0, <4 x i32> %a1) nounwind {
; SSE2-LABEL: concat_trunc_packusdw_128:
; SSE2:       # %bb.0:
; SSE2-NEXT:    psrld $17, %xmm0
; SSE2-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE2-NEXT:    packssdw %xmm0, %xmm0
; SSE2-NEXT:    packuswb %xmm1, %xmm1
; SSE2-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; SSE2-NEXT:    retq
;
; SSE4-LABEL: concat_trunc_packusdw_128:
; SSE4:       # %bb.0:
; SSE4-NEXT:    psrld $17, %xmm0
; SSE4-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE4-NEXT:    packusdw %xmm1, %xmm0
; SSE4-NEXT:    retq
;
; AVX1-LABEL: concat_trunc_packusdw_128:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpsrld $17, %xmm0, %xmm0
; AVX1-NEXT:    vpand {{.*}}(%rip), %xmm1, %xmm1
; AVX1-NEXT:    vpackusdw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: concat_trunc_packusdw_128:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpsrld $17, %xmm0, %xmm0
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [15,15,15,15]
; AVX2-NEXT:    vpand %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpackusdw %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: concat_trunc_packusdw_128:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vpsrld $17, %xmm0, %xmm0
; AVX512-NEXT:    vpandd {{.*}}(%rip){1to4}, %xmm1, %xmm1
; AVX512-NEXT:    vpackusdw %xmm1, %xmm0, %xmm0
; AVX512-NEXT:    retq
  %1 = lshr <4 x i32> %a0, <i32 17, i32 17, i32 17, i32 17>
  %2 = and  <4 x i32> %a1, <i32 15, i32 15, i32 15, i32 15>
  %3 = trunc <4 x i32> %1 to <4 x i16>
  %4 = trunc <4 x i32> %2 to <4 x i16>
  %5 = shufflevector <4 x i16> %3, <4 x i16> %4, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i16> %5
}

define <16 x i8> @concat_trunc_packsswb_128(<8 x i16> %a0, <8 x i16> %a1) nounwind {
; SSE-LABEL: concat_trunc_packsswb_128:
; SSE:       # %bb.0:
; SSE-NEXT:    psraw $15, %xmm0
; SSE-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE-NEXT:    packsswb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: concat_trunc_packsswb_128:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsraw $15, %xmm0, %xmm0
; AVX-NEXT:    vpand {{.*}}(%rip), %xmm1, %xmm1
; AVX-NEXT:    vpacksswb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = ashr <8 x i16> %a0, <i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15>
  %2 = and  <8 x i16> %a1, <i16  1, i16  1, i16  1, i16  1, i16  1, i16  1, i16  1, i16  1>
  %3 = trunc <8 x i16> %1 to <8 x i8>
  %4 = trunc <8 x i16> %2 to <8 x i8>
  %5 = shufflevector <8 x i8> %3, <8 x i8> %4, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  ret <16 x i8> %5
}

define <16 x i8> @concat_trunc_packuswb_128(<8 x i16> %a0, <8 x i16> %a1) nounwind {
; SSE-LABEL: concat_trunc_packuswb_128:
; SSE:       # %bb.0:
; SSE-NEXT:    psrlw $15, %xmm0
; SSE-NEXT:    pand {{.*}}(%rip), %xmm1
; SSE-NEXT:    packuswb %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: concat_trunc_packuswb_128:
; AVX:       # %bb.0:
; AVX-NEXT:    vpsrlw $15, %xmm0, %xmm0
; AVX-NEXT:    vpand {{.*}}(%rip), %xmm1, %xmm1
; AVX-NEXT:    vpackuswb %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = lshr <8 x i16> %a0, <i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15, i16 15>
  %2 = and  <8 x i16> %a1, <i16  1, i16  1, i16  1, i16  1, i16  1, i16  1, i16  1, i16  1>
  %3 = trunc <8 x i16> %1 to <8 x i8>
  %4 = trunc <8 x i16> %2 to <8 x i8>
  %5 = shufflevector <8 x i8> %3, <8 x i8> %4, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  ret <16 x i8> %5
}
