; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

define <4 x i32> @sve_no_typesize_warning(<vscale x 8 x i16> %a, <4 x i16> %b) #0 {
; CHECK-LABEL: sve_no_typesize_warning:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uaddl v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
%a.lo = call <4 x i16> @llvm.experimental.vector.extract.v4i16.nxv8i16(<vscale x 8 x i16> %a, i64 0)
%a.lo.zext = zext <4 x i16> %a.lo to <4 x i32>
%b.zext = zext <4 x i16> %b to <4 x i32>
%add = add <4 x i32> %a.lo.zext, %b.zext
ret <4 x i32> %add
}

declare <4 x i16> @llvm.experimental.vector.extract.v4i16.nxv8i16(<vscale x 8 x i16>, i64)

attributes #0 = { "target-features"="+sve" }
