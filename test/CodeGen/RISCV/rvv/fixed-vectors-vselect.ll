; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+experimental-v,+experimental-zfh,+f,+d -verify-machineinstrs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+experimental-v,+experimental-zfh,+f,+d -verify-machineinstrs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK

define void @vselect_vv_v8i32(<8 x i32>* %a, <8 x i32>* %b, <8 x i1>* %cc, <8 x i32>* %z) {
; CHECK-LABEL: vselect_vv_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a4, 8, e32,m2,ta,mu
; CHECK-NEXT:    vle32.v v26, (a0)
; CHECK-NEXT:    vle32.v v28, (a1)
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle1.v v0, (a2)
; CHECK-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; CHECK-NEXT:    vmerge.vvm v26, v28, v26, v0
; CHECK-NEXT:    vse32.v v26, (a3)
; CHECK-NEXT:    ret
  %va = load <8 x i32>, <8 x i32>* %a
  %vb = load <8 x i32>, <8 x i32>* %b
  %vcc = load <8 x i1>, <8 x i1>* %cc
  %vsel = select <8 x i1> %vcc, <8 x i32> %va, <8 x i32> %vb
  store <8 x i32> %vsel, <8 x i32>* %z
  ret void
}

define void @vselect_vx_v8i32(i32 %a, <8 x i32>* %b, <8 x i1>* %cc, <8 x i32>* %z) {
; CHECK-LABEL: vselect_vx_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a4, 8, e32,m2,ta,mu
; CHECK-NEXT:    vle32.v v26, (a1)
; CHECK-NEXT:    vsetivli a1, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle1.v v0, (a2)
; CHECK-NEXT:    vsetivli a1, 8, e32,m2,ta,mu
; CHECK-NEXT:    vmerge.vxm v26, v26, a0, v0
; CHECK-NEXT:    vse32.v v26, (a3)
; CHECK-NEXT:    ret
  %vb = load <8 x i32>, <8 x i32>* %b
  %ahead = insertelement <8 x i32> undef, i32 %a, i32 0
  %va = shufflevector <8 x i32> %ahead, <8 x i32> undef, <8 x i32> zeroinitializer
  %vcc = load <8 x i1>, <8 x i1>* %cc
  %vsel = select <8 x i1> %vcc, <8 x i32> %va, <8 x i32> %vb
  store <8 x i32> %vsel, <8 x i32>* %z
  ret void
}

define void @vselect_vi_v8i32(<8 x i32>* %b, <8 x i1>* %cc, <8 x i32>* %z) {
; CHECK-LABEL: vselect_vi_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 8, e32,m2,ta,mu
; CHECK-NEXT:    vle32.v v26, (a0)
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle1.v v0, (a1)
; CHECK-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; CHECK-NEXT:    vmerge.vim v26, v26, -1, v0
; CHECK-NEXT:    vse32.v v26, (a2)
; CHECK-NEXT:    ret
  %vb = load <8 x i32>, <8 x i32>* %b
  %a = insertelement <8 x i32> undef, i32 -1, i32 0
  %va = shufflevector <8 x i32> %a, <8 x i32> undef, <8 x i32> zeroinitializer
  %vcc = load <8 x i1>, <8 x i1>* %cc
  %vsel = select <8 x i1> %vcc, <8 x i32> %va, <8 x i32> %vb
  store <8 x i32> %vsel, <8 x i32>* %z
  ret void
}

define void @vselect_vv_v8f32(<8 x float>* %a, <8 x float>* %b, <8 x i1>* %cc, <8 x float>* %z) {
; CHECK-LABEL: vselect_vv_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a4, 8, e32,m2,ta,mu
; CHECK-NEXT:    vle32.v v26, (a0)
; CHECK-NEXT:    vle32.v v28, (a1)
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle1.v v0, (a2)
; CHECK-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; CHECK-NEXT:    vmerge.vvm v26, v28, v26, v0
; CHECK-NEXT:    vse32.v v26, (a3)
; CHECK-NEXT:    ret
  %va = load <8 x float>, <8 x float>* %a
  %vb = load <8 x float>, <8 x float>* %b
  %vcc = load <8 x i1>, <8 x i1>* %cc
  %vsel = select <8 x i1> %vcc, <8 x float> %va, <8 x float> %vb
  store <8 x float> %vsel, <8 x float>* %z
  ret void
}

define void @vselect_vx_v8f32(float %a, <8 x float>* %b, <8 x i1>* %cc, <8 x float>* %z) {
; CHECK-LABEL: vselect_vx_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 8, e32,m2,ta,mu
; CHECK-NEXT:    vle32.v v26, (a0)
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle1.v v0, (a1)
; CHECK-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; CHECK-NEXT:    vfmerge.vfm v26, v26, fa0, v0
; CHECK-NEXT:    vse32.v v26, (a2)
; CHECK-NEXT:    ret
  %vb = load <8 x float>, <8 x float>* %b
  %ahead = insertelement <8 x float> undef, float %a, i32 0
  %va = shufflevector <8 x float> %ahead, <8 x float> undef, <8 x i32> zeroinitializer
  %vcc = load <8 x i1>, <8 x i1>* %cc
  %vsel = select <8 x i1> %vcc, <8 x float> %va, <8 x float> %vb
  store <8 x float> %vsel, <8 x float>* %z
  ret void
}

define void @vselect_vfpzero_v8f32(<8 x float>* %b, <8 x i1>* %cc, <8 x float>* %z) {
; CHECK-LABEL: vselect_vfpzero_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 8, e32,m2,ta,mu
; CHECK-NEXT:    vle32.v v26, (a0)
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle1.v v0, (a1)
; CHECK-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; CHECK-NEXT:    vmerge.vim v26, v26, 0, v0
; CHECK-NEXT:    vse32.v v26, (a2)
; CHECK-NEXT:    ret
  %vb = load <8 x float>, <8 x float>* %b
  %a = insertelement <8 x float> undef, float 0.0, i32 0
  %va = shufflevector <8 x float> %a, <8 x float> undef, <8 x i32> zeroinitializer
  %vcc = load <8 x i1>, <8 x i1>* %cc
  %vsel = select <8 x i1> %vcc, <8 x float> %va, <8 x float> %vb
  store <8 x float> %vsel, <8 x float>* %z
  ret void
}

define void @vselect_vv_v16i16(<16 x i16>* %a, <16 x i16>* %b, <16 x i1>* %cc, <16 x i16>* %z) {
; CHECK-LABEL: vselect_vv_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a4, 16, e16,m2,ta,mu
; CHECK-NEXT:    vle16.v v26, (a0)
; CHECK-NEXT:    vle16.v v28, (a1)
; CHECK-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle1.v v0, (a2)
; CHECK-NEXT:    vsetivli a0, 16, e16,m2,ta,mu
; CHECK-NEXT:    vmerge.vvm v26, v28, v26, v0
; CHECK-NEXT:    vse16.v v26, (a3)
; CHECK-NEXT:    ret
  %va = load <16 x i16>, <16 x i16>* %a
  %vb = load <16 x i16>, <16 x i16>* %b
  %vcc = load <16 x i1>, <16 x i1>* %cc
  %vsel = select <16 x i1> %vcc, <16 x i16> %va, <16 x i16> %vb
  store <16 x i16> %vsel, <16 x i16>* %z
  ret void
}

define void @vselect_vx_v16i16(i16 signext %a, <16 x i16>* %b, <16 x i1>* %cc, <16 x i16>* %z) {
; CHECK-LABEL: vselect_vx_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a4, 16, e16,m2,ta,mu
; CHECK-NEXT:    vle16.v v26, (a1)
; CHECK-NEXT:    vsetivli a1, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle1.v v0, (a2)
; CHECK-NEXT:    vsetivli a1, 16, e16,m2,ta,mu
; CHECK-NEXT:    vmerge.vxm v26, v26, a0, v0
; CHECK-NEXT:    vse16.v v26, (a3)
; CHECK-NEXT:    ret
  %vb = load <16 x i16>, <16 x i16>* %b
  %ahead = insertelement <16 x i16> undef, i16 %a, i32 0
  %va = shufflevector <16 x i16> %ahead, <16 x i16> undef, <16 x i32> zeroinitializer
  %vcc = load <16 x i1>, <16 x i1>* %cc
  %vsel = select <16 x i1> %vcc, <16 x i16> %va, <16 x i16> %vb
  store <16 x i16> %vsel, <16 x i16>* %z
  ret void
}

define void @vselect_vi_v16i16(<16 x i16>* %b, <16 x i1>* %cc, <16 x i16>* %z) {
; CHECK-LABEL: vselect_vi_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 16, e16,m2,ta,mu
; CHECK-NEXT:    vle16.v v26, (a0)
; CHECK-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle1.v v0, (a1)
; CHECK-NEXT:    vsetivli a0, 16, e16,m2,ta,mu
; CHECK-NEXT:    vmerge.vim v26, v26, 4, v0
; CHECK-NEXT:    vse16.v v26, (a2)
; CHECK-NEXT:    ret
  %vb = load <16 x i16>, <16 x i16>* %b
  %a = insertelement <16 x i16> undef, i16 4, i32 0
  %va = shufflevector <16 x i16> %a, <16 x i16> undef, <16 x i32> zeroinitializer
  %vcc = load <16 x i1>, <16 x i1>* %cc
  %vsel = select <16 x i1> %vcc, <16 x i16> %va, <16 x i16> %vb
  store <16 x i16> %vsel, <16 x i16>* %z
  ret void
}

define void @vselect_vv_v32f16(<32 x half>* %a, <32 x half>* %b, <32 x i1>* %cc, <32 x half>* %z) {
; CHECK-LABEL: vselect_vv_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a4, zero, 32
; CHECK-NEXT:    vsetvli a5, a4, e16,m4,ta,mu
; CHECK-NEXT:    vle16.v v28, (a0)
; CHECK-NEXT:    vle16.v v8, (a1)
; CHECK-NEXT:    vsetvli a0, a4, e8,m2,ta,mu
; CHECK-NEXT:    vle1.v v0, (a2)
; CHECK-NEXT:    vsetvli a0, a4, e16,m4,ta,mu
; CHECK-NEXT:    vmerge.vvm v28, v8, v28, v0
; CHECK-NEXT:    vse16.v v28, (a3)
; CHECK-NEXT:    ret
  %va = load <32 x half>, <32 x half>* %a
  %vb = load <32 x half>, <32 x half>* %b
  %vcc = load <32 x i1>, <32 x i1>* %cc
  %vsel = select <32 x i1> %vcc, <32 x half> %va, <32 x half> %vb
  store <32 x half> %vsel, <32 x half>* %z
  ret void
}

define void @vselect_vx_v32f16(half %a, <32 x half>* %b, <32 x i1>* %cc, <32 x half>* %z) {
; CHECK-LABEL: vselect_vx_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 32
; CHECK-NEXT:    vsetvli a4, a3, e16,m4,ta,mu
; CHECK-NEXT:    vle16.v v28, (a0)
; CHECK-NEXT:    vsetvli a0, a3, e8,m2,ta,mu
; CHECK-NEXT:    vle1.v v0, (a1)
; CHECK-NEXT:    vsetvli a0, a3, e16,m4,ta,mu
; CHECK-NEXT:    vfmerge.vfm v28, v28, fa0, v0
; CHECK-NEXT:    vse16.v v28, (a2)
; CHECK-NEXT:    ret
  %vb = load <32 x half>, <32 x half>* %b
  %ahead = insertelement <32 x half> undef, half %a, i32 0
  %va = shufflevector <32 x half> %ahead, <32 x half> undef, <32 x i32> zeroinitializer
  %vcc = load <32 x i1>, <32 x i1>* %cc
  %vsel = select <32 x i1> %vcc, <32 x half> %va, <32 x half> %vb
  store <32 x half> %vsel, <32 x half>* %z
  ret void
}

define void @vselect_vfpzero_v32f16(<32 x half>* %b, <32 x i1>* %cc, <32 x half>* %z) {
; CHECK-LABEL: vselect_vfpzero_v32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 32
; CHECK-NEXT:    vsetvli a4, a3, e16,m4,ta,mu
; CHECK-NEXT:    vle16.v v28, (a0)
; CHECK-NEXT:    vsetvli a0, a3, e8,m2,ta,mu
; CHECK-NEXT:    vle1.v v0, (a1)
; CHECK-NEXT:    vsetvli a0, a3, e16,m4,ta,mu
; CHECK-NEXT:    vmerge.vim v28, v28, 0, v0
; CHECK-NEXT:    vse16.v v28, (a2)
; CHECK-NEXT:    ret
  %vb = load <32 x half>, <32 x half>* %b
  %a = insertelement <32 x half> undef, half 0.0, i32 0
  %va = shufflevector <32 x half> %a, <32 x half> undef, <32 x i32> zeroinitializer
  %vcc = load <32 x i1>, <32 x i1>* %cc
  %vsel = select <32 x i1> %vcc, <32 x half> %va, <32 x half> %vb
  store <32 x half> %vsel, <32 x half>* %z
  ret void
}
