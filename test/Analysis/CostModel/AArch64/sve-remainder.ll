; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -cost-model -analyze -mtriple aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

define void @test_urem_srem_expand() {
; CHECK-LABEL: 'test_urem_srem_expand'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %legal_type_urem_0 = urem <vscale x 16 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %legal_type_urem_1 = urem <vscale x 8 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %legal_type_urem_2 = urem <vscale x 4 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %legal_type_urem_3 = urem <vscale x 2 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %legal_type_srem_0 = srem <vscale x 16 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %legal_type_srem_1 = srem <vscale x 8 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %legal_type_srem_2 = srem <vscale x 4 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %legal_type_srem_3 = srem <vscale x 2 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %split_type_urem_0 = urem <vscale x 32 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %split_type_urem_1 = urem <vscale x 16 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %split_type_urem_2 = urem <vscale x 8 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %split_type_urem_3 = urem <vscale x 4 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %split_type_srem_0 = srem <vscale x 32 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %split_type_srem_1 = srem <vscale x 16 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %split_type_srem_2 = srem <vscale x 8 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %split_type_srem_3 = srem <vscale x 4 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %widen_type_urem_0 = urem <vscale x 31 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %widen_type_urem_1 = urem <vscale x 15 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %widen_type_urem_2 = urem <vscale x 7 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %widen_type_urem_3 = urem <vscale x 3 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %widen_type_srem_0 = srem <vscale x 31 x i8> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %widen_type_srem_1 = srem <vscale x 15 x i16> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %widen_type_srem_2 = srem <vscale x 7 x i32> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %widen_type_srem_3 = srem <vscale x 3 x i64> undef, undef
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
entry:
  %legal_type_urem_0 = urem <vscale x 16 x i8> undef, undef
  %legal_type_urem_1 = urem <vscale x 8 x i16> undef, undef
  %legal_type_urem_2 = urem <vscale x 4 x i32> undef, undef
  %legal_type_urem_3 = urem <vscale x 2 x i64> undef, undef
  %legal_type_srem_0 = srem <vscale x 16 x i8> undef, undef
  %legal_type_srem_1 = srem <vscale x 8 x i16> undef, undef
  %legal_type_srem_2 = srem <vscale x 4 x i32> undef, undef
  %legal_type_srem_3 = srem <vscale x 2 x i64> undef, undef

  %split_type_urem_0 = urem <vscale x 32 x i8> undef, undef
  %split_type_urem_1 = urem <vscale x 16 x i16> undef, undef
  %split_type_urem_2 = urem <vscale x 8 x i32> undef, undef
  %split_type_urem_3 = urem <vscale x 4 x i64> undef, undef
  %split_type_srem_0 = srem <vscale x 32 x i8> undef, undef
  %split_type_srem_1 = srem <vscale x 16 x i16> undef, undef
  %split_type_srem_2 = srem <vscale x 8 x i32> undef, undef
  %split_type_srem_3 = srem <vscale x 4 x i64> undef, undef

  %widen_type_urem_0 = urem <vscale x 31 x i8> undef, undef
  %widen_type_urem_1 = urem <vscale x 15 x i16> undef, undef
  %widen_type_urem_2 = urem <vscale x 7 x i32> undef, undef
  %widen_type_urem_3 = urem <vscale x 3 x i64> undef, undef
  %widen_type_srem_0 = srem <vscale x 31 x i8> undef, undef
  %widen_type_srem_1 = srem <vscale x 15 x i16> undef, undef
  %widen_type_srem_2 = srem <vscale x 7 x i32> undef, undef
  %widen_type_srem_3 = srem <vscale x 3 x i64> undef, undef

  ret void
}
