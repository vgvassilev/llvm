; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+experimental-zfh,+experimental-v -target-abi=ilp32d \
; RUN:     -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+experimental-zfh,+experimental-v -target-abi=lp64d \
; RUN:     -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s

declare <2 x half> @llvm.maxnum.v2f16(<2 x half>, <2 x half>)

define <2 x half> @vfmax_v2f16_vv(<2 x half> %a, <2 x half> %b) {
; CHECK-LABEL: vfmax_v2f16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e16,mf4,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <2 x half> @llvm.maxnum.v2f16(<2 x half> %a, <2 x half> %b)
  ret <2 x half> %v
}

define <2 x half> @vfmax_v2f16_vf(<2 x half> %a, half %b) {
; CHECK-LABEL: vfmax_v2f16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e16,mf4,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <2 x half> undef, half %b, i32 0
  %splat = shufflevector <2 x half> %head, <2 x half> undef, <2 x i32> zeroinitializer
  %v = call <2 x half> @llvm.maxnum.v2f16(<2 x half> %a, <2 x half> %splat)
  ret <2 x half> %v
}

declare <4 x half> @llvm.maxnum.v4f16(<4 x half>, <4 x half>)

define <4 x half> @vfmax_v4f16_vv(<4 x half> %a, <4 x half> %b) {
; CHECK-LABEL: vfmax_v4f16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x half> @llvm.maxnum.v4f16(<4 x half> %a, <4 x half> %b)
  ret <4 x half> %v
}

define <4 x half> @vfmax_v4f16_vf(<4 x half> %a, half %b) {
; CHECK-LABEL: vfmax_v4f16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <4 x half> undef, half %b, i32 0
  %splat = shufflevector <4 x half> %head, <4 x half> undef, <4 x i32> zeroinitializer
  %v = call <4 x half> @llvm.maxnum.v4f16(<4 x half> %a, <4 x half> %splat)
  ret <4 x half> %v
}

declare <8 x half> @llvm.maxnum.v8f16(<8 x half>, <8 x half>)

define <8 x half> @vfmax_v8f16_vv(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: vfmax_v8f16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 8, e16,m1,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <8 x half> @llvm.maxnum.v8f16(<8 x half> %a, <8 x half> %b)
  ret <8 x half> %v
}

define <8 x half> @vfmax_v8f16_vf(<8 x half> %a, half %b) {
; CHECK-LABEL: vfmax_v8f16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 8, e16,m1,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <8 x half> undef, half %b, i32 0
  %splat = shufflevector <8 x half> %head, <8 x half> undef, <8 x i32> zeroinitializer
  %v = call <8 x half> @llvm.maxnum.v8f16(<8 x half> %a, <8 x half> %splat)
  ret <8 x half> %v
}

declare <16 x half> @llvm.maxnum.v16f16(<16 x half>, <16 x half>)

define <16 x half> @vfmax_v16f16_vv(<16 x half> %a, <16 x half> %b) {
; CHECK-LABEL: vfmax_v16f16_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 16, e16,m2,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <16 x half> @llvm.maxnum.v16f16(<16 x half> %a, <16 x half> %b)
  ret <16 x half> %v
}

define <16 x half> @vfmax_v16f16_vf(<16 x half> %a, half %b) {
; CHECK-LABEL: vfmax_v16f16_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 16, e16,m2,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <16 x half> undef, half %b, i32 0
  %splat = shufflevector <16 x half> %head, <16 x half> undef, <16 x i32> zeroinitializer
  %v = call <16 x half> @llvm.maxnum.v16f16(<16 x half> %a, <16 x half> %splat)
  ret <16 x half> %v
}

declare <2 x float> @llvm.maxnum.v2f32(<2 x float>, <2 x float>)

define <2 x float> @vfmax_v2f32_vv(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: vfmax_v2f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <2 x float> @llvm.maxnum.v2f32(<2 x float> %a, <2 x float> %b)
  ret <2 x float> %v
}

define <2 x float> @vfmax_v2f32_vf(<2 x float> %a, float %b) {
; CHECK-LABEL: vfmax_v2f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <2 x float> undef, float %b, i32 0
  %splat = shufflevector <2 x float> %head, <2 x float> undef, <2 x i32> zeroinitializer
  %v = call <2 x float> @llvm.maxnum.v2f32(<2 x float> %a, <2 x float> %splat)
  ret <2 x float> %v
}

declare <4 x float> @llvm.maxnum.v4f32(<4 x float>, <4 x float>)

define <4 x float> @vfmax_v4f32_vv(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: vfmax_v4f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x float> @llvm.maxnum.v4f32(<4 x float> %a, <4 x float> %b)
  ret <4 x float> %v
}

define <4 x float> @vfmax_v4f32_vf(<4 x float> %a, float %b) {
; CHECK-LABEL: vfmax_v4f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <4 x float> undef, float %b, i32 0
  %splat = shufflevector <4 x float> %head, <4 x float> undef, <4 x i32> zeroinitializer
  %v = call <4 x float> @llvm.maxnum.v4f32(<4 x float> %a, <4 x float> %splat)
  ret <4 x float> %v
}

declare <8 x float> @llvm.maxnum.v8f32(<8 x float>, <8 x float>)

define <8 x float> @vfmax_v8f32_vv(<8 x float> %a, <8 x float> %b) {
; CHECK-LABEL: vfmax_v8f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <8 x float> @llvm.maxnum.v8f32(<8 x float> %a, <8 x float> %b)
  ret <8 x float> %v
}

define <8 x float> @vfmax_v8f32_vf(<8 x float> %a, float %b) {
; CHECK-LABEL: vfmax_v8f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <8 x float> undef, float %b, i32 0
  %splat = shufflevector <8 x float> %head, <8 x float> undef, <8 x i32> zeroinitializer
  %v = call <8 x float> @llvm.maxnum.v8f32(<8 x float> %a, <8 x float> %splat)
  ret <8 x float> %v
}

declare <16 x float> @llvm.maxnum.v16f32(<16 x float>, <16 x float>)

define <16 x float> @vfmax_v16f32_vv(<16 x float> %a, <16 x float> %b) {
; CHECK-LABEL: vfmax_v16f32_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <16 x float> @llvm.maxnum.v16f32(<16 x float> %a, <16 x float> %b)
  ret <16 x float> %v
}

define <16 x float> @vfmax_v16f32_vf(<16 x float> %a, float %b) {
; CHECK-LABEL: vfmax_v16f32_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <16 x float> undef, float %b, i32 0
  %splat = shufflevector <16 x float> %head, <16 x float> undef, <16 x i32> zeroinitializer
  %v = call <16 x float> @llvm.maxnum.v16f32(<16 x float> %a, <16 x float> %splat)
  ret <16 x float> %v
}

declare <2 x double> @llvm.maxnum.v2f64(<2 x double>, <2 x double>)

define <2 x double> @vfmax_v2f64_vv(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: vfmax_v2f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v9
; CHECK-NEXT:    ret
  %v = call <2 x double> @llvm.maxnum.v2f64(<2 x double> %a, <2 x double> %b)
  ret <2 x double> %v
}

define <2 x double> @vfmax_v2f64_vf(<2 x double> %a, double %b) {
; CHECK-LABEL: vfmax_v2f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <2 x double> undef, double %b, i32 0
  %splat = shufflevector <2 x double> %head, <2 x double> undef, <2 x i32> zeroinitializer
  %v = call <2 x double> @llvm.maxnum.v2f64(<2 x double> %a, <2 x double> %splat)
  ret <2 x double> %v
}

declare <4 x double> @llvm.maxnum.v4f64(<4 x double>, <4 x double>)

define <4 x double> @vfmax_v4f64_vv(<4 x double> %a, <4 x double> %b) {
; CHECK-LABEL: vfmax_v4f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v10
; CHECK-NEXT:    ret
  %v = call <4 x double> @llvm.maxnum.v4f64(<4 x double> %a, <4 x double> %b)
  ret <4 x double> %v
}

define <4 x double> @vfmax_v4f64_vf(<4 x double> %a, double %b) {
; CHECK-LABEL: vfmax_v4f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <4 x double> undef, double %b, i32 0
  %splat = shufflevector <4 x double> %head, <4 x double> undef, <4 x i32> zeroinitializer
  %v = call <4 x double> @llvm.maxnum.v4f64(<4 x double> %a, <4 x double> %splat)
  ret <4 x double> %v
}

declare <8 x double> @llvm.maxnum.v8f64(<8 x double>, <8 x double>)

define <8 x double> @vfmax_v8f64_vv(<8 x double> %a, <8 x double> %b) {
; CHECK-LABEL: vfmax_v8f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v12
; CHECK-NEXT:    ret
  %v = call <8 x double> @llvm.maxnum.v8f64(<8 x double> %a, <8 x double> %b)
  ret <8 x double> %v
}

define <8 x double> @vfmax_v8f64_vf(<8 x double> %a, double %b) {
; CHECK-LABEL: vfmax_v8f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <8 x double> undef, double %b, i32 0
  %splat = shufflevector <8 x double> %head, <8 x double> undef, <8 x i32> zeroinitializer
  %v = call <8 x double> @llvm.maxnum.v8f64(<8 x double> %a, <8 x double> %splat)
  ret <8 x double> %v
}

declare <16 x double> @llvm.maxnum.v16f64(<16 x double>, <16 x double>)

define <16 x double> @vfmax_v16f64_vv(<16 x double> %a, <16 x double> %b) {
; CHECK-LABEL: vfmax_v16f64_vv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 16, e64,m8,ta,mu
; CHECK-NEXT:    vfmax.vv v8, v8, v16
; CHECK-NEXT:    ret
  %v = call <16 x double> @llvm.maxnum.v16f64(<16 x double> %a, <16 x double> %b)
  ret <16 x double> %v
}

define <16 x double> @vfmax_v16f64_vf(<16 x double> %a, double %b) {
; CHECK-LABEL: vfmax_v16f64_vf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 16, e64,m8,ta,mu
; CHECK-NEXT:    vfmax.vf v8, v8, fa0
; CHECK-NEXT:    ret
  %head = insertelement <16 x double> undef, double %b, i32 0
  %splat = shufflevector <16 x double> %head, <16 x double> undef, <16 x i32> zeroinitializer
  %v = call <16 x double> @llvm.maxnum.v16f64(<16 x double> %a, <16 x double> %splat)
  ret <16 x double> %v
}
