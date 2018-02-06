; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

define <4 x i32> @test_v4i32_splatconst_pow2(<4 x i32> %a0) {
; CHECK-LABEL: @test_v4i32_splatconst_pow2(
; CHECK-NEXT:    [[TMP1:%.*]] = and <4 x i32> [[A0:%.*]], <i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    ret <4 x i32> [[TMP1]]
;
  %1 = urem <4 x i32> %a0, <i32 2, i32 2, i32 2, i32 2>
  ret <4 x i32> %1
}

define <4 x i32> @test_v4i32_const_pow2(<4 x i32> %a0) {
; CHECK-LABEL: @test_v4i32_const_pow2(
; CHECK-NEXT:    [[TMP1:%.*]] = urem <4 x i32> [[A0:%.*]], <i32 1, i32 2, i32 4, i32 8>
; CHECK-NEXT:    ret <4 x i32> [[TMP1]]
;
  %1 = urem <4 x i32> %a0, <i32 1, i32 2, i32 4, i32 8>
  ret <4 x i32> %1
}

