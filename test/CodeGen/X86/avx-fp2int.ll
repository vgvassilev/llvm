; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i386-apple-darwin10 -mcpu=corei7-avx -mattr=+avx | FileCheck %s

;; Check that FP_TO_SINT and FP_TO_UINT generate convert with truncate

define <4 x i8> @test1(<4 x double> %d) {
; CHECK-LABEL: test1:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vcvttpd2dq %ymm0, %xmm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retl
  %c = fptoui <4 x double> %d to <4 x i8>
  ret <4 x i8> %c
}
define <4 x i8> @test2(<4 x double> %d) {
; CHECK-LABEL: test2:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vcvttpd2dq %ymm0, %xmm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retl
  %c = fptosi <4 x double> %d to <4 x i8>
  ret <4 x i8> %c
}
