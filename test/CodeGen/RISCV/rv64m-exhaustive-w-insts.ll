; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+m -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64IM

; The patterns for the 'W' suffixed RV64M instructions have the potential of
; missing cases. This file checks all the variants of
; sign-extended/zero-extended/any-extended inputs and outputs.

define i32 @aext_mulw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_mulw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define i32 @aext_mulw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_mulw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define i32 @aext_mulw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_mulw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define i32 @aext_mulw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_mulw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define i32 @aext_mulw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_mulw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define i32 @aext_mulw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_mulw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define i32 @aext_mulw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_mulw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define i32 @aext_mulw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_mulw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define i32 @aext_mulw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_mulw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_mulw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_mulw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_mulw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_mulw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_mulw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_mulw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_mulw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_mulw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_mulw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_mulw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_mulw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_mulw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_mulw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_mulw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_mulw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_mulw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_mulw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_mulw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mulw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_mulw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_mulw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_mulw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_mulw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_mulw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_mulw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_mulw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_mulw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_mulw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_mulw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_mulw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_mulw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_mulw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_mulw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_mulw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_mulw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_mulw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_mulw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    mul a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define i32 @aext_divuw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_divuw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divuw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_divuw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divuw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_divuw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divuw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_divuw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divuw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_divuw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divuw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_divuw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divuw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_divuw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divuw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_divuw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divuw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_divuw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divuw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_divuw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divuw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_divuw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divuw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_divuw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divuw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_divuw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divuw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_divuw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divuw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_divuw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divuw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_divuw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divuw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_divuw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divuw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_divuw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divuw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_divuw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divuw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_divuw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divuw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_divuw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divuw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_divuw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divuw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_divuw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divuw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_divuw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divuw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_divuw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divuw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_divuw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divuw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_divuw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divu a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i32 %a, %b
  ret i32 %1
}

define zeroext i8 @zext_divuw_zext_zext_i8(i8 zeroext %a, i8 zeroext %b) nounwind {
; RV64IM-LABEL: zext_divuw_zext_zext_i8:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i8 %a, %b
  ret i8 %1
}

define zeroext i16 @zext_divuw_zext_zext_i16(i16 zeroext %a, i16 zeroext %b) nounwind {
; RV64IM-LABEL: zext_divuw_zext_zext_i16:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = udiv i16 %a, %b
  ret i16 %1
}

define i32 @aext_divw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_divw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_divw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_divw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_divw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_divw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_divw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_divw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_divw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define i32 @aext_divw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_divw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_divw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_divw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_divw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_divw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_divw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_divw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_divw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_divw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_divw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_divw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_divw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_divw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_divw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_divw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_divw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_divw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_divw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_divw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_divw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_divw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = sdiv i32 %a, %b
  ret i32 %1
}

define signext i8 @sext_divw_sext_sext_i8(i8 signext %a, i8 signext %b) nounwind {
; RV64IM-LABEL: sext_divw_sext_sext_i8:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 56
; RV64IM-NEXT:    srai a0, a0, 56
; RV64IM-NEXT:    ret
  %1 = sdiv i8 %a, %b
  ret i8 %1
}

define signext i16 @sext_divw_sext_sext_i16(i16 signext %a, i16 signext %b) nounwind {
; RV64IM-LABEL: sext_divw_sext_sext_i16:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    divw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 48
; RV64IM-NEXT:    srai a0, a0, 48
; RV64IM-NEXT:    ret
  %1 = sdiv i16 %a, %b
  ret i16 %1
}

define i32 @aext_remw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_remw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_remw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_remw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_remw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_remw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_remw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_remw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_remw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_remw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_remw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_remw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_remw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_remw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_remw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_remw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_remw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_remw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_remw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_remw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_remw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_remw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_remw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_remw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_remw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_remw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_remw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_remw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = srem i32 %a, %b
  ret i32 %1
}

define signext i8 @sext_remw_sext_sext_i8(i8 signext %a, i8 signext %b) nounwind {
; RV64IM-LABEL: sext_remw_sext_sext_i8:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 56
; RV64IM-NEXT:    srai a0, a0, 56
; RV64IM-NEXT:    ret
  %1 = srem i8 %a, %b
  ret i8 %1
}

define signext i16 @sext_remw_sext_sext_i16(i16 signext %a, i16 signext %b) nounwind {
; RV64IM-LABEL: sext_remw_sext_sext_i16:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 48
; RV64IM-NEXT:    srai a0, a0, 48
; RV64IM-NEXT:    ret
  %1 = srem i16 %a, %b
  ret i16 %1
}

define signext i32 @sext_i32_remw_zext_sext_i16(i16 zeroext %0, i16 signext %1) nounwind {
; RV64IM-LABEL: sext_i32_remw_zext_sext_i16:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    rem a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %3 = sext i16 %1 to i32
  %4 = zext i16 %0 to i32
  %5 = srem i32 %4, %3
  ret i32 %5
}

define i32 @aext_remuw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_remuw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remuw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_remuw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remuw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_remuw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remuw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_remuw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remuw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_remuw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remuw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_remuw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remuw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: aext_remuw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remuw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: aext_remuw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define i32 @aext_remuw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: aext_remuw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remuw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_remuw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remuw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_remuw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remuw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_remuw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remuw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_remuw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remuw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_remuw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remuw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_remuw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remuw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: sext_remuw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remuw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: sext_remuw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define signext i32 @sext_remuw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: sext_remuw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remuw_aext_aext(i32 %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_remuw_aext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remuw_aext_sext(i32 %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_remuw_aext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remuw_aext_zext(i32 %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_remuw_aext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remuw_sext_aext(i32 signext %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_remuw_sext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remuw_sext_sext(i32 signext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_remuw_sext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remuw_sext_zext(i32 signext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_remuw_sext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remuw_zext_aext(i32 zeroext %a, i32 %b) nounwind {
; RV64IM-LABEL: zext_remuw_zext_aext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remuw_zext_sext(i32 zeroext %a, i32 signext %b) nounwind {
; RV64IM-LABEL: zext_remuw_zext_sext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    slli a0, a0, 32
; RV64IM-NEXT:    srli a0, a0, 32
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define zeroext i32 @zext_remuw_zext_zext(i32 zeroext %a, i32 zeroext %b) nounwind {
; RV64IM-LABEL: zext_remuw_zext_zext:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remu a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i32 %a, %b
  ret i32 %1
}

define zeroext i8 @zext_remuw_zext_zext_i8(i8 zeroext %a, i8 zeroext %b) nounwind {
; RV64IM-LABEL: zext_remuw_zext_zext_i8:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i8 %a, %b
  ret i8 %1
}

define zeroext i16 @zext_remuw_zext_zext_i16(i16 zeroext %a, i16 zeroext %b) nounwind {
; RV64IM-LABEL: zext_remuw_zext_zext_i16:
; RV64IM:       # %bb.0:
; RV64IM-NEXT:    remuw a0, a0, a1
; RV64IM-NEXT:    ret
  %1 = urem i16 %a, %b
  ret i16 %1
}
