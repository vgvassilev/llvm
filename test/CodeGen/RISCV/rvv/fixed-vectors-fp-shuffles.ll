; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+experimental-zfh,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+d,+experimental-zfh,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

define <4 x half> @shuffle_v4f16(<4 x half> %x, <4 x half> %y) {
; CHECK-LABEL: shuffle_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 11
; CHECK-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli a0, 4, e16,m1,ta,mu
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x half> %x, <4 x half> %y, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  ret <4 x half> %s
}

define <8 x float> @shuffle_v8f32(<8 x float> %x, <8 x float> %y) {
; CHECK-LABEL: shuffle_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 236
; CHECK-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %s = shufflevector <8 x float> %x, <8 x float> %y, <8 x i32> <i32 8, i32 9, i32 2, i32 3, i32 12, i32 5, i32 6, i32 7>
  ret <8 x float> %s
}

define <4 x double> @shuffle_fv_v4f64(<4 x double> %x) {
; CHECK-LABEL: shuffle_fv_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 9
; CHECK-NEXT:    lui a1, %hi(.LCPI2_0)
; CHECK-NEXT:    fld ft0, %lo(.LCPI2_0)(a1)
; CHECK-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; CHECK-NEXT:    vfmerge.vfm v8, v8, ft0, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x double> <double 2.0, double 2.0, double 2.0, double 2.0>, <4 x double> %x, <4 x i32> <i32 0, i32 5, i32 6, i32 3>
  ret <4 x double> %s
}

define <4 x double> @shuffle_vf_v4f64(<4 x double> %x) {
; CHECK-LABEL: shuffle_vf_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 6
; CHECK-NEXT:    lui a1, %hi(.LCPI3_0)
; CHECK-NEXT:    fld ft0, %lo(.LCPI3_0)(a1)
; CHECK-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; CHECK-NEXT:    vfmerge.vfm v8, v8, ft0, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x double> %x, <4 x double> <double 2.0, double 2.0, double 2.0, double 2.0>, <4 x i32> <i32 0, i32 5, i32 6, i32 3>
  ret <4 x double> %s
}

define <4 x double> @vrgather_permute_shuffle_vu_v4f64(<4 x double> %x) {
; RV32-LABEL: vrgather_permute_shuffle_vu_v4f64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI4_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI4_0)
; RV32-NEXT:    vsetivli a1, 4, e16,m1,ta,mu
; RV32-NEXT:    vle16.v v25, (a0)
; RV32-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV32-NEXT:    vrgatherei16.vv v26, v8, v25
; RV32-NEXT:    vmv2r.v v8, v26
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_permute_shuffle_vu_v4f64:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI4_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI4_0)
; RV64-NEXT:    vsetivli a1, 4, e64,m2,ta,mu
; RV64-NEXT:    vle64.v v28, (a0)
; RV64-NEXT:    vrgather.vv v26, v8, v28
; RV64-NEXT:    vmv2r.v v8, v26
; RV64-NEXT:    ret
  %s = shufflevector <4 x double> %x, <4 x double> undef, <4 x i32> <i32 1, i32 2, i32 0, i32 1>
  ret <4 x double> %s
}

define <4 x double> @vrgather_permute_shuffle_uv_v4f64(<4 x double> %x) {
; RV32-LABEL: vrgather_permute_shuffle_uv_v4f64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI5_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI5_0)
; RV32-NEXT:    vsetivli a1, 4, e16,m1,ta,mu
; RV32-NEXT:    vle16.v v25, (a0)
; RV32-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV32-NEXT:    vrgatherei16.vv v26, v8, v25
; RV32-NEXT:    vmv2r.v v8, v26
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_permute_shuffle_uv_v4f64:
; RV64:       # %bb.0:
; RV64-NEXT:    lui a0, %hi(.LCPI5_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI5_0)
; RV64-NEXT:    vsetivli a1, 4, e64,m2,ta,mu
; RV64-NEXT:    vle64.v v28, (a0)
; RV64-NEXT:    vrgather.vv v26, v8, v28
; RV64-NEXT:    vmv2r.v v8, v26
; RV64-NEXT:    ret
  %s = shufflevector <4 x double> undef, <4 x double> %x, <4 x i32> <i32 5, i32 6, i32 4, i32 5>
  ret <4 x double> %s
}

define <4 x double> @vrgather_shuffle_vv_v4f64(<4 x double> %x, <4 x double> %y) {
; RV32-LABEL: vrgather_shuffle_vv_v4f64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi a0, zero, 1
; RV32-NEXT:    addi a1, zero, 8
; RV32-NEXT:    vsetivli a2, 1, e8,m1,ta,mu
; RV32-NEXT:    vmv.s.x v0, a1
; RV32-NEXT:    vsetivli a1, 4, e16,m1,ta,mu
; RV32-NEXT:    vmv.s.x v25, a0
; RV32-NEXT:    vmv.v.i v28, 0
; RV32-NEXT:    vsetivli a0, 4, e16,m1,tu,mu
; RV32-NEXT:    vslideup.vi v28, v25, 3
; RV32-NEXT:    lui a0, %hi(.LCPI6_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI6_0)
; RV32-NEXT:    vsetivli a1, 4, e16,m1,ta,mu
; RV32-NEXT:    vle16.v v25, (a0)
; RV32-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV32-NEXT:    vrgatherei16.vv v26, v8, v25
; RV32-NEXT:    vsetivli a0, 4, e64,m2,tu,mu
; RV32-NEXT:    vrgatherei16.vv v26, v10, v28, v0.t
; RV32-NEXT:    vmv2r.v v8, v26
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_vv_v4f64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a0, zero, 1
; RV64-NEXT:    vsetivli a1, 4, e64,m2,ta,mu
; RV64-NEXT:    vmv.s.x v26, a0
; RV64-NEXT:    vmv.v.i v28, 0
; RV64-NEXT:    vsetivli a0, 4, e64,m2,tu,mu
; RV64-NEXT:    vslideup.vi v28, v26, 3
; RV64-NEXT:    addi a0, zero, 8
; RV64-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    lui a0, %hi(.LCPI6_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI6_0)
; RV64-NEXT:    vsetivli a1, 4, e64,m2,ta,mu
; RV64-NEXT:    vle64.v v30, (a0)
; RV64-NEXT:    vrgather.vv v26, v8, v30
; RV64-NEXT:    vsetivli a0, 4, e64,m2,tu,mu
; RV64-NEXT:    vrgather.vv v26, v10, v28, v0.t
; RV64-NEXT:    vmv2r.v v8, v26
; RV64-NEXT:    ret
  %s = shufflevector <4 x double> %x, <4 x double> %y, <4 x i32> <i32 1, i32 2, i32 0, i32 5>
  ret <4 x double> %s
}

define <4 x double> @vrgather_shuffle_xv_v4f64(<4 x double> %x) {
; RV32-LABEL: vrgather_shuffle_xv_v4f64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi a0, zero, 12
; RV32-NEXT:    lui a1, %hi(.LCPI7_0)
; RV32-NEXT:    fld ft0, %lo(.LCPI7_0)(a1)
; RV32-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV32-NEXT:    vfmv.v.f v26, ft0
; RV32-NEXT:    lui a0, %hi(.LCPI7_1)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI7_1)
; RV32-NEXT:    vsetivli a1, 4, e16,m1,ta,mu
; RV32-NEXT:    vle16.v v25, (a0)
; RV32-NEXT:    vsetivli a0, 4, e64,m2,tu,mu
; RV32-NEXT:    vrgatherei16.vv v26, v8, v25, v0.t
; RV32-NEXT:    vmv2r.v v8, v26
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_xv_v4f64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a0, zero, 12
; RV64-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    lui a0, %hi(.LCPI7_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI7_0)
; RV64-NEXT:    lui a1, %hi(.LCPI7_1)
; RV64-NEXT:    fld ft0, %lo(.LCPI7_1)(a1)
; RV64-NEXT:    vsetivli a1, 4, e64,m2,ta,mu
; RV64-NEXT:    vle64.v v28, (a0)
; RV64-NEXT:    vfmv.v.f v26, ft0
; RV64-NEXT:    vsetivli a0, 4, e64,m2,tu,mu
; RV64-NEXT:    vrgather.vv v26, v8, v28, v0.t
; RV64-NEXT:    vmv2r.v v8, v26
; RV64-NEXT:    ret
  %s = shufflevector <4 x double> <double 2.0, double 2.0, double 2.0, double 2.0>, <4 x double> %x, <4 x i32> <i32 0, i32 3, i32 6, i32 5>
  ret <4 x double> %s
}

define <4 x double> @vrgather_shuffle_vx_v4f64(<4 x double> %x) {
; RV32-LABEL: vrgather_shuffle_vx_v4f64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi a0, zero, 3
; RV32-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; RV32-NEXT:    vmv.s.x v0, a0
; RV32-NEXT:    vsetivli a1, 4, e16,m1,ta,mu
; RV32-NEXT:    vmv.s.x v25, a0
; RV32-NEXT:    vmv.v.i v28, 0
; RV32-NEXT:    lui a0, %hi(.LCPI8_0)
; RV32-NEXT:    fld ft0, %lo(.LCPI8_0)(a0)
; RV32-NEXT:    vsetivli a0, 2, e16,m1,tu,mu
; RV32-NEXT:    vslideup.vi v28, v25, 1
; RV32-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV32-NEXT:    vfmv.v.f v26, ft0
; RV32-NEXT:    vsetivli a0, 4, e64,m2,tu,mu
; RV32-NEXT:    vrgatherei16.vv v26, v8, v28, v0.t
; RV32-NEXT:    vmv2r.v v8, v26
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_vx_v4f64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi a0, zero, 3
; RV64-NEXT:    vsetivli a1, 4, e64,m2,ta,mu
; RV64-NEXT:    vmv.s.x v26, a0
; RV64-NEXT:    vmv.v.i v28, 0
; RV64-NEXT:    vsetivli a1, 2, e64,m2,tu,mu
; RV64-NEXT:    vslideup.vi v28, v26, 1
; RV64-NEXT:    lui a1, %hi(.LCPI8_0)
; RV64-NEXT:    fld ft0, %lo(.LCPI8_0)(a1)
; RV64-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; RV64-NEXT:    vmv.s.x v0, a0
; RV64-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV64-NEXT:    vfmv.v.f v26, ft0
; RV64-NEXT:    vsetivli a0, 4, e64,m2,tu,mu
; RV64-NEXT:    vrgather.vv v26, v8, v28, v0.t
; RV64-NEXT:    vmv2r.v v8, v26
; RV64-NEXT:    ret
  %s = shufflevector <4 x double> %x, <4 x double> <double 2.0, double 2.0, double 2.0, double 2.0>, <4 x i32> <i32 0, i32 3, i32 6, i32 5>
  ret <4 x double> %s
}
