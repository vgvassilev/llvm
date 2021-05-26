; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v,+d,+experimental-zfh -verify-machineinstrs \
; RUN:   < %s | FileCheck %s
declare <vscale x 1 x half> @llvm.riscv.vfnmadd.nxv1f16.nxv1f16(
  <vscale x 1 x half>,
  <vscale x 1 x half>,
  <vscale x 1 x half>,
  i64);

define <vscale x 1 x half>  @intrinsic_vfnmadd_vv_nxv1f16_nxv1f16_nxv1f16(<vscale x 1 x half> %0, <vscale x 1 x half> %1, <vscale x 1 x half> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv1f16_nxv1f16_nxv1f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf4,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x half> @llvm.riscv.vfnmadd.nxv1f16.nxv1f16(
    <vscale x 1 x half> %0,
    <vscale x 1 x half> %1,
    <vscale x 1 x half> %2,
    i64 %3)

  ret <vscale x 1 x half> %a
}

declare <vscale x 1 x half> @llvm.riscv.vfnmadd.mask.nxv1f16.nxv1f16(
  <vscale x 1 x half>,
  <vscale x 1 x half>,
  <vscale x 1 x half>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x half>  @intrinsic_vfnmadd_mask_vv_nxv1f16_nxv1f16_nxv1f16(<vscale x 1 x half> %0, <vscale x 1 x half> %1, <vscale x 1 x half> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv1f16_nxv1f16_nxv1f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf4,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x half> @llvm.riscv.vfnmadd.mask.nxv1f16.nxv1f16(
    <vscale x 1 x half> %0,
    <vscale x 1 x half> %1,
    <vscale x 1 x half> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x half> %a
}

declare <vscale x 2 x half> @llvm.riscv.vfnmadd.nxv2f16.nxv2f16(
  <vscale x 2 x half>,
  <vscale x 2 x half>,
  <vscale x 2 x half>,
  i64);

define <vscale x 2 x half>  @intrinsic_vfnmadd_vv_nxv2f16_nxv2f16_nxv2f16(<vscale x 2 x half> %0, <vscale x 2 x half> %1, <vscale x 2 x half> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv2f16_nxv2f16_nxv2f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf2,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x half> @llvm.riscv.vfnmadd.nxv2f16.nxv2f16(
    <vscale x 2 x half> %0,
    <vscale x 2 x half> %1,
    <vscale x 2 x half> %2,
    i64 %3)

  ret <vscale x 2 x half> %a
}

declare <vscale x 2 x half> @llvm.riscv.vfnmadd.mask.nxv2f16.nxv2f16(
  <vscale x 2 x half>,
  <vscale x 2 x half>,
  <vscale x 2 x half>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x half>  @intrinsic_vfnmadd_mask_vv_nxv2f16_nxv2f16_nxv2f16(<vscale x 2 x half> %0, <vscale x 2 x half> %1, <vscale x 2 x half> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv2f16_nxv2f16_nxv2f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf2,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x half> @llvm.riscv.vfnmadd.mask.nxv2f16.nxv2f16(
    <vscale x 2 x half> %0,
    <vscale x 2 x half> %1,
    <vscale x 2 x half> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x half> %a
}

declare <vscale x 4 x half> @llvm.riscv.vfnmadd.nxv4f16.nxv4f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>,
  <vscale x 4 x half>,
  i64);

define <vscale x 4 x half>  @intrinsic_vfnmadd_vv_nxv4f16_nxv4f16_nxv4f16(<vscale x 4 x half> %0, <vscale x 4 x half> %1, <vscale x 4 x half> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv4f16_nxv4f16_nxv4f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x half> @llvm.riscv.vfnmadd.nxv4f16.nxv4f16(
    <vscale x 4 x half> %0,
    <vscale x 4 x half> %1,
    <vscale x 4 x half> %2,
    i64 %3)

  ret <vscale x 4 x half> %a
}

declare <vscale x 4 x half> @llvm.riscv.vfnmadd.mask.nxv4f16.nxv4f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>,
  <vscale x 4 x half>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x half>  @intrinsic_vfnmadd_mask_vv_nxv4f16_nxv4f16_nxv4f16(<vscale x 4 x half> %0, <vscale x 4 x half> %1, <vscale x 4 x half> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv4f16_nxv4f16_nxv4f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x half> @llvm.riscv.vfnmadd.mask.nxv4f16.nxv4f16(
    <vscale x 4 x half> %0,
    <vscale x 4 x half> %1,
    <vscale x 4 x half> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x half> %a
}

declare <vscale x 8 x half> @llvm.riscv.vfnmadd.nxv8f16.nxv8f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>,
  <vscale x 8 x half>,
  i64);

define <vscale x 8 x half>  @intrinsic_vfnmadd_vv_nxv8f16_nxv8f16_nxv8f16(<vscale x 8 x half> %0, <vscale x 8 x half> %1, <vscale x 8 x half> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv8f16_nxv8f16_nxv8f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v10, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x half> @llvm.riscv.vfnmadd.nxv8f16.nxv8f16(
    <vscale x 8 x half> %0,
    <vscale x 8 x half> %1,
    <vscale x 8 x half> %2,
    i64 %3)

  ret <vscale x 8 x half> %a
}

declare <vscale x 8 x half> @llvm.riscv.vfnmadd.mask.nxv8f16.nxv8f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>,
  <vscale x 8 x half>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x half>  @intrinsic_vfnmadd_mask_vv_nxv8f16_nxv8f16_nxv8f16(<vscale x 8 x half> %0, <vscale x 8 x half> %1, <vscale x 8 x half> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv8f16_nxv8f16_nxv8f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v10, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x half> @llvm.riscv.vfnmadd.mask.nxv8f16.nxv8f16(
    <vscale x 8 x half> %0,
    <vscale x 8 x half> %1,
    <vscale x 8 x half> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x half> %a
}

declare <vscale x 16 x half> @llvm.riscv.vfnmadd.nxv16f16.nxv16f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>,
  <vscale x 16 x half>,
  i64);

define <vscale x 16 x half>  @intrinsic_vfnmadd_vv_nxv16f16_nxv16f16_nxv16f16(<vscale x 16 x half> %0, <vscale x 16 x half> %1, <vscale x 16 x half> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv16f16_nxv16f16_nxv16f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v12, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x half> @llvm.riscv.vfnmadd.nxv16f16.nxv16f16(
    <vscale x 16 x half> %0,
    <vscale x 16 x half> %1,
    <vscale x 16 x half> %2,
    i64 %3)

  ret <vscale x 16 x half> %a
}

declare <vscale x 16 x half> @llvm.riscv.vfnmadd.mask.nxv16f16.nxv16f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>,
  <vscale x 16 x half>,
  <vscale x 16 x i1>,
  i64);

define <vscale x 16 x half>  @intrinsic_vfnmadd_mask_vv_nxv16f16_nxv16f16_nxv16f16(<vscale x 16 x half> %0, <vscale x 16 x half> %1, <vscale x 16 x half> %2, <vscale x 16 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv16f16_nxv16f16_nxv16f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v12, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x half> @llvm.riscv.vfnmadd.mask.nxv16f16.nxv16f16(
    <vscale x 16 x half> %0,
    <vscale x 16 x half> %1,
    <vscale x 16 x half> %2,
    <vscale x 16 x i1> %3,
    i64 %4)

  ret <vscale x 16 x half> %a
}

declare <vscale x 1 x float> @llvm.riscv.vfnmadd.nxv1f32.nxv1f32(
  <vscale x 1 x float>,
  <vscale x 1 x float>,
  <vscale x 1 x float>,
  i64);

define <vscale x 1 x float>  @intrinsic_vfnmadd_vv_nxv1f32_nxv1f32_nxv1f32(<vscale x 1 x float> %0, <vscale x 1 x float> %1, <vscale x 1 x float> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv1f32_nxv1f32_nxv1f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e32,mf2,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfnmadd.nxv1f32.nxv1f32(
    <vscale x 1 x float> %0,
    <vscale x 1 x float> %1,
    <vscale x 1 x float> %2,
    i64 %3)

  ret <vscale x 1 x float> %a
}

declare <vscale x 1 x float> @llvm.riscv.vfnmadd.mask.nxv1f32.nxv1f32(
  <vscale x 1 x float>,
  <vscale x 1 x float>,
  <vscale x 1 x float>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x float>  @intrinsic_vfnmadd_mask_vv_nxv1f32_nxv1f32_nxv1f32(<vscale x 1 x float> %0, <vscale x 1 x float> %1, <vscale x 1 x float> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv1f32_nxv1f32_nxv1f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e32,mf2,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfnmadd.mask.nxv1f32.nxv1f32(
    <vscale x 1 x float> %0,
    <vscale x 1 x float> %1,
    <vscale x 1 x float> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfnmadd.nxv2f32.nxv2f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>,
  <vscale x 2 x float>,
  i64);

define <vscale x 2 x float>  @intrinsic_vfnmadd_vv_nxv2f32_nxv2f32_nxv2f32(<vscale x 2 x float> %0, <vscale x 2 x float> %1, <vscale x 2 x float> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv2f32_nxv2f32_nxv2f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e32,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfnmadd.nxv2f32.nxv2f32(
    <vscale x 2 x float> %0,
    <vscale x 2 x float> %1,
    <vscale x 2 x float> %2,
    i64 %3)

  ret <vscale x 2 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfnmadd.mask.nxv2f32.nxv2f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>,
  <vscale x 2 x float>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x float>  @intrinsic_vfnmadd_mask_vv_nxv2f32_nxv2f32_nxv2f32(<vscale x 2 x float> %0, <vscale x 2 x float> %1, <vscale x 2 x float> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv2f32_nxv2f32_nxv2f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e32,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfnmadd.mask.nxv2f32.nxv2f32(
    <vscale x 2 x float> %0,
    <vscale x 2 x float> %1,
    <vscale x 2 x float> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfnmadd.nxv4f32.nxv4f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>,
  <vscale x 4 x float>,
  i64);

define <vscale x 4 x float>  @intrinsic_vfnmadd_vv_nxv4f32_nxv4f32_nxv4f32(<vscale x 4 x float> %0, <vscale x 4 x float> %1, <vscale x 4 x float> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv4f32_nxv4f32_nxv4f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e32,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v10, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfnmadd.nxv4f32.nxv4f32(
    <vscale x 4 x float> %0,
    <vscale x 4 x float> %1,
    <vscale x 4 x float> %2,
    i64 %3)

  ret <vscale x 4 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfnmadd.mask.nxv4f32.nxv4f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>,
  <vscale x 4 x float>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x float>  @intrinsic_vfnmadd_mask_vv_nxv4f32_nxv4f32_nxv4f32(<vscale x 4 x float> %0, <vscale x 4 x float> %1, <vscale x 4 x float> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv4f32_nxv4f32_nxv4f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e32,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v10, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfnmadd.mask.nxv4f32.nxv4f32(
    <vscale x 4 x float> %0,
    <vscale x 4 x float> %1,
    <vscale x 4 x float> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfnmadd.nxv8f32.nxv8f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>,
  <vscale x 8 x float>,
  i64);

define <vscale x 8 x float>  @intrinsic_vfnmadd_vv_nxv8f32_nxv8f32_nxv8f32(<vscale x 8 x float> %0, <vscale x 8 x float> %1, <vscale x 8 x float> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv8f32_nxv8f32_nxv8f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e32,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v12, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfnmadd.nxv8f32.nxv8f32(
    <vscale x 8 x float> %0,
    <vscale x 8 x float> %1,
    <vscale x 8 x float> %2,
    i64 %3)

  ret <vscale x 8 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfnmadd.mask.nxv8f32.nxv8f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>,
  <vscale x 8 x float>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x float>  @intrinsic_vfnmadd_mask_vv_nxv8f32_nxv8f32_nxv8f32(<vscale x 8 x float> %0, <vscale x 8 x float> %1, <vscale x 8 x float> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv8f32_nxv8f32_nxv8f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e32,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v12, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfnmadd.mask.nxv8f32.nxv8f32(
    <vscale x 8 x float> %0,
    <vscale x 8 x float> %1,
    <vscale x 8 x float> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x float> %a
}

declare <vscale x 1 x double> @llvm.riscv.vfnmadd.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>,
  <vscale x 1 x double>,
  i64);

define <vscale x 1 x double>  @intrinsic_vfnmadd_vv_nxv1f64_nxv1f64_nxv1f64(<vscale x 1 x double> %0, <vscale x 1 x double> %1, <vscale x 1 x double> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv1f64_nxv1f64_nxv1f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e64,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x double> @llvm.riscv.vfnmadd.nxv1f64.nxv1f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double> %1,
    <vscale x 1 x double> %2,
    i64 %3)

  ret <vscale x 1 x double> %a
}

declare <vscale x 1 x double> @llvm.riscv.vfnmadd.mask.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>,
  <vscale x 1 x double>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x double>  @intrinsic_vfnmadd_mask_vv_nxv1f64_nxv1f64_nxv1f64(<vscale x 1 x double> %0, <vscale x 1 x double> %1, <vscale x 1 x double> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv1f64_nxv1f64_nxv1f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e64,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x double> @llvm.riscv.vfnmadd.mask.nxv1f64.nxv1f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double> %1,
    <vscale x 1 x double> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x double> %a
}

declare <vscale x 2 x double> @llvm.riscv.vfnmadd.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>,
  <vscale x 2 x double>,
  i64);

define <vscale x 2 x double>  @intrinsic_vfnmadd_vv_nxv2f64_nxv2f64_nxv2f64(<vscale x 2 x double> %0, <vscale x 2 x double> %1, <vscale x 2 x double> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv2f64_nxv2f64_nxv2f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e64,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v10, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x double> @llvm.riscv.vfnmadd.nxv2f64.nxv2f64(
    <vscale x 2 x double> %0,
    <vscale x 2 x double> %1,
    <vscale x 2 x double> %2,
    i64 %3)

  ret <vscale x 2 x double> %a
}

declare <vscale x 2 x double> @llvm.riscv.vfnmadd.mask.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>,
  <vscale x 2 x double>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x double>  @intrinsic_vfnmadd_mask_vv_nxv2f64_nxv2f64_nxv2f64(<vscale x 2 x double> %0, <vscale x 2 x double> %1, <vscale x 2 x double> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv2f64_nxv2f64_nxv2f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e64,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v10, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x double> @llvm.riscv.vfnmadd.mask.nxv2f64.nxv2f64(
    <vscale x 2 x double> %0,
    <vscale x 2 x double> %1,
    <vscale x 2 x double> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x double> %a
}

declare <vscale x 4 x double> @llvm.riscv.vfnmadd.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>,
  <vscale x 4 x double>,
  i64);

define <vscale x 4 x double>  @intrinsic_vfnmadd_vv_nxv4f64_nxv4f64_nxv4f64(<vscale x 4 x double> %0, <vscale x 4 x double> %1, <vscale x 4 x double> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vv_nxv4f64_nxv4f64_nxv4f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e64,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v12, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x double> @llvm.riscv.vfnmadd.nxv4f64.nxv4f64(
    <vscale x 4 x double> %0,
    <vscale x 4 x double> %1,
    <vscale x 4 x double> %2,
    i64 %3)

  ret <vscale x 4 x double> %a
}

declare <vscale x 4 x double> @llvm.riscv.vfnmadd.mask.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>,
  <vscale x 4 x double>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x double>  @intrinsic_vfnmadd_mask_vv_nxv4f64_nxv4f64_nxv4f64(<vscale x 4 x double> %0, <vscale x 4 x double> %1, <vscale x 4 x double> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vv_nxv4f64_nxv4f64_nxv4f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e64,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vv v8, v12, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x double> @llvm.riscv.vfnmadd.mask.nxv4f64.nxv4f64(
    <vscale x 4 x double> %0,
    <vscale x 4 x double> %1,
    <vscale x 4 x double> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x double> %a
}

declare <vscale x 1 x half> @llvm.riscv.vfnmadd.nxv1f16.f16(
  <vscale x 1 x half>,
  half,
  <vscale x 1 x half>,
  i64);

define <vscale x 1 x half>  @intrinsic_vfnmadd_vf_nxv1f16_f16_nxv1f16(<vscale x 1 x half> %0, half %1, <vscale x 1 x half> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv1f16_f16_nxv1f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,mf4,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x half> @llvm.riscv.vfnmadd.nxv1f16.f16(
    <vscale x 1 x half> %0,
    half %1,
    <vscale x 1 x half> %2,
    i64 %3)

  ret <vscale x 1 x half> %a
}

declare <vscale x 1 x half> @llvm.riscv.vfnmadd.mask.nxv1f16.f16(
  <vscale x 1 x half>,
  half,
  <vscale x 1 x half>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x half> @intrinsic_vfnmadd_mask_vf_nxv1f16_f16_nxv1f16(<vscale x 1 x half> %0, half %1, <vscale x 1 x half> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv1f16_f16_nxv1f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,mf4,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x half> @llvm.riscv.vfnmadd.mask.nxv1f16.f16(
    <vscale x 1 x half> %0,
    half %1,
    <vscale x 1 x half> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x half> %a
}

declare <vscale x 2 x half> @llvm.riscv.vfnmadd.nxv2f16.f16(
  <vscale x 2 x half>,
  half,
  <vscale x 2 x half>,
  i64);

define <vscale x 2 x half>  @intrinsic_vfnmadd_vf_nxv2f16_f16_nxv2f16(<vscale x 2 x half> %0, half %1, <vscale x 2 x half> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv2f16_f16_nxv2f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,mf2,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x half> @llvm.riscv.vfnmadd.nxv2f16.f16(
    <vscale x 2 x half> %0,
    half %1,
    <vscale x 2 x half> %2,
    i64 %3)

  ret <vscale x 2 x half> %a
}

declare <vscale x 2 x half> @llvm.riscv.vfnmadd.mask.nxv2f16.f16(
  <vscale x 2 x half>,
  half,
  <vscale x 2 x half>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x half> @intrinsic_vfnmadd_mask_vf_nxv2f16_f16_nxv2f16(<vscale x 2 x half> %0, half %1, <vscale x 2 x half> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv2f16_f16_nxv2f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,mf2,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x half> @llvm.riscv.vfnmadd.mask.nxv2f16.f16(
    <vscale x 2 x half> %0,
    half %1,
    <vscale x 2 x half> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x half> %a
}

declare <vscale x 4 x half> @llvm.riscv.vfnmadd.nxv4f16.f16(
  <vscale x 4 x half>,
  half,
  <vscale x 4 x half>,
  i64);

define <vscale x 4 x half>  @intrinsic_vfnmadd_vf_nxv4f16_f16_nxv4f16(<vscale x 4 x half> %0, half %1, <vscale x 4 x half> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv4f16_f16_nxv4f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x half> @llvm.riscv.vfnmadd.nxv4f16.f16(
    <vscale x 4 x half> %0,
    half %1,
    <vscale x 4 x half> %2,
    i64 %3)

  ret <vscale x 4 x half> %a
}

declare <vscale x 4 x half> @llvm.riscv.vfnmadd.mask.nxv4f16.f16(
  <vscale x 4 x half>,
  half,
  <vscale x 4 x half>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x half> @intrinsic_vfnmadd_mask_vf_nxv4f16_f16_nxv4f16(<vscale x 4 x half> %0, half %1, <vscale x 4 x half> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv4f16_f16_nxv4f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x half> @llvm.riscv.vfnmadd.mask.nxv4f16.f16(
    <vscale x 4 x half> %0,
    half %1,
    <vscale x 4 x half> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x half> %a
}

declare <vscale x 8 x half> @llvm.riscv.vfnmadd.nxv8f16.f16(
  <vscale x 8 x half>,
  half,
  <vscale x 8 x half>,
  i64);

define <vscale x 8 x half>  @intrinsic_vfnmadd_vf_nxv8f16_f16_nxv8f16(<vscale x 8 x half> %0, half %1, <vscale x 8 x half> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv8f16_f16_nxv8f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x half> @llvm.riscv.vfnmadd.nxv8f16.f16(
    <vscale x 8 x half> %0,
    half %1,
    <vscale x 8 x half> %2,
    i64 %3)

  ret <vscale x 8 x half> %a
}

declare <vscale x 8 x half> @llvm.riscv.vfnmadd.mask.nxv8f16.f16(
  <vscale x 8 x half>,
  half,
  <vscale x 8 x half>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x half> @intrinsic_vfnmadd_mask_vf_nxv8f16_f16_nxv8f16(<vscale x 8 x half> %0, half %1, <vscale x 8 x half> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv8f16_f16_nxv8f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x half> @llvm.riscv.vfnmadd.mask.nxv8f16.f16(
    <vscale x 8 x half> %0,
    half %1,
    <vscale x 8 x half> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x half> %a
}

declare <vscale x 16 x half> @llvm.riscv.vfnmadd.nxv16f16.f16(
  <vscale x 16 x half>,
  half,
  <vscale x 16 x half>,
  i64);

define <vscale x 16 x half>  @intrinsic_vfnmadd_vf_nxv16f16_f16_nxv16f16(<vscale x 16 x half> %0, half %1, <vscale x 16 x half> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv16f16_f16_nxv16f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x half> @llvm.riscv.vfnmadd.nxv16f16.f16(
    <vscale x 16 x half> %0,
    half %1,
    <vscale x 16 x half> %2,
    i64 %3)

  ret <vscale x 16 x half> %a
}

declare <vscale x 16 x half> @llvm.riscv.vfnmadd.mask.nxv16f16.f16(
  <vscale x 16 x half>,
  half,
  <vscale x 16 x half>,
  <vscale x 16 x i1>,
  i64);

define <vscale x 16 x half> @intrinsic_vfnmadd_mask_vf_nxv16f16_f16_nxv16f16(<vscale x 16 x half> %0, half %1, <vscale x 16 x half> %2, <vscale x 16 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv16f16_f16_nxv16f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x half> @llvm.riscv.vfnmadd.mask.nxv16f16.f16(
    <vscale x 16 x half> %0,
    half %1,
    <vscale x 16 x half> %2,
    <vscale x 16 x i1> %3,
    i64 %4)

  ret <vscale x 16 x half> %a
}

declare <vscale x 1 x float> @llvm.riscv.vfnmadd.nxv1f32.f32(
  <vscale x 1 x float>,
  float,
  <vscale x 1 x float>,
  i64);

define <vscale x 1 x float>  @intrinsic_vfnmadd_vf_nxv1f32_f32_nxv1f32(<vscale x 1 x float> %0, float %1, <vscale x 1 x float> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv1f32_f32_nxv1f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.w.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e32,mf2,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfnmadd.nxv1f32.f32(
    <vscale x 1 x float> %0,
    float %1,
    <vscale x 1 x float> %2,
    i64 %3)

  ret <vscale x 1 x float> %a
}

declare <vscale x 1 x float> @llvm.riscv.vfnmadd.mask.nxv1f32.f32(
  <vscale x 1 x float>,
  float,
  <vscale x 1 x float>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x float> @intrinsic_vfnmadd_mask_vf_nxv1f32_f32_nxv1f32(<vscale x 1 x float> %0, float %1, <vscale x 1 x float> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv1f32_f32_nxv1f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.w.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e32,mf2,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfnmadd.mask.nxv1f32.f32(
    <vscale x 1 x float> %0,
    float %1,
    <vscale x 1 x float> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfnmadd.nxv2f32.f32(
  <vscale x 2 x float>,
  float,
  <vscale x 2 x float>,
  i64);

define <vscale x 2 x float>  @intrinsic_vfnmadd_vf_nxv2f32_f32_nxv2f32(<vscale x 2 x float> %0, float %1, <vscale x 2 x float> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv2f32_f32_nxv2f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.w.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e32,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfnmadd.nxv2f32.f32(
    <vscale x 2 x float> %0,
    float %1,
    <vscale x 2 x float> %2,
    i64 %3)

  ret <vscale x 2 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfnmadd.mask.nxv2f32.f32(
  <vscale x 2 x float>,
  float,
  <vscale x 2 x float>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x float> @intrinsic_vfnmadd_mask_vf_nxv2f32_f32_nxv2f32(<vscale x 2 x float> %0, float %1, <vscale x 2 x float> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv2f32_f32_nxv2f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.w.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e32,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfnmadd.mask.nxv2f32.f32(
    <vscale x 2 x float> %0,
    float %1,
    <vscale x 2 x float> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfnmadd.nxv4f32.f32(
  <vscale x 4 x float>,
  float,
  <vscale x 4 x float>,
  i64);

define <vscale x 4 x float>  @intrinsic_vfnmadd_vf_nxv4f32_f32_nxv4f32(<vscale x 4 x float> %0, float %1, <vscale x 4 x float> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv4f32_f32_nxv4f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.w.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e32,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfnmadd.nxv4f32.f32(
    <vscale x 4 x float> %0,
    float %1,
    <vscale x 4 x float> %2,
    i64 %3)

  ret <vscale x 4 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfnmadd.mask.nxv4f32.f32(
  <vscale x 4 x float>,
  float,
  <vscale x 4 x float>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x float> @intrinsic_vfnmadd_mask_vf_nxv4f32_f32_nxv4f32(<vscale x 4 x float> %0, float %1, <vscale x 4 x float> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv4f32_f32_nxv4f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.w.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e32,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfnmadd.mask.nxv4f32.f32(
    <vscale x 4 x float> %0,
    float %1,
    <vscale x 4 x float> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfnmadd.nxv8f32.f32(
  <vscale x 8 x float>,
  float,
  <vscale x 8 x float>,
  i64);

define <vscale x 8 x float>  @intrinsic_vfnmadd_vf_nxv8f32_f32_nxv8f32(<vscale x 8 x float> %0, float %1, <vscale x 8 x float> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv8f32_f32_nxv8f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.w.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e32,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfnmadd.nxv8f32.f32(
    <vscale x 8 x float> %0,
    float %1,
    <vscale x 8 x float> %2,
    i64 %3)

  ret <vscale x 8 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfnmadd.mask.nxv8f32.f32(
  <vscale x 8 x float>,
  float,
  <vscale x 8 x float>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x float> @intrinsic_vfnmadd_mask_vf_nxv8f32_f32_nxv8f32(<vscale x 8 x float> %0, float %1, <vscale x 8 x float> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv8f32_f32_nxv8f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.w.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e32,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfnmadd.mask.nxv8f32.f32(
    <vscale x 8 x float> %0,
    float %1,
    <vscale x 8 x float> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x float> %a
}

declare <vscale x 1 x double> @llvm.riscv.vfnmadd.nxv1f64.f64(
  <vscale x 1 x double>,
  double,
  <vscale x 1 x double>,
  i64);

define <vscale x 1 x double>  @intrinsic_vfnmadd_vf_nxv1f64_f64_nxv1f64(<vscale x 1 x double> %0, double %1, <vscale x 1 x double> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv1f64_f64_nxv1f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.d.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e64,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x double> @llvm.riscv.vfnmadd.nxv1f64.f64(
    <vscale x 1 x double> %0,
    double %1,
    <vscale x 1 x double> %2,
    i64 %3)

  ret <vscale x 1 x double> %a
}

declare <vscale x 1 x double> @llvm.riscv.vfnmadd.mask.nxv1f64.f64(
  <vscale x 1 x double>,
  double,
  <vscale x 1 x double>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x double> @intrinsic_vfnmadd_mask_vf_nxv1f64_f64_nxv1f64(<vscale x 1 x double> %0, double %1, <vscale x 1 x double> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv1f64_f64_nxv1f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.d.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e64,m1,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x double> @llvm.riscv.vfnmadd.mask.nxv1f64.f64(
    <vscale x 1 x double> %0,
    double %1,
    <vscale x 1 x double> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x double> %a
}

declare <vscale x 2 x double> @llvm.riscv.vfnmadd.nxv2f64.f64(
  <vscale x 2 x double>,
  double,
  <vscale x 2 x double>,
  i64);

define <vscale x 2 x double>  @intrinsic_vfnmadd_vf_nxv2f64_f64_nxv2f64(<vscale x 2 x double> %0, double %1, <vscale x 2 x double> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv2f64_f64_nxv2f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.d.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e64,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x double> @llvm.riscv.vfnmadd.nxv2f64.f64(
    <vscale x 2 x double> %0,
    double %1,
    <vscale x 2 x double> %2,
    i64 %3)

  ret <vscale x 2 x double> %a
}

declare <vscale x 2 x double> @llvm.riscv.vfnmadd.mask.nxv2f64.f64(
  <vscale x 2 x double>,
  double,
  <vscale x 2 x double>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x double> @intrinsic_vfnmadd_mask_vf_nxv2f64_f64_nxv2f64(<vscale x 2 x double> %0, double %1, <vscale x 2 x double> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv2f64_f64_nxv2f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.d.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e64,m2,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x double> @llvm.riscv.vfnmadd.mask.nxv2f64.f64(
    <vscale x 2 x double> %0,
    double %1,
    <vscale x 2 x double> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x double> %a
}

declare <vscale x 4 x double> @llvm.riscv.vfnmadd.nxv4f64.f64(
  <vscale x 4 x double>,
  double,
  <vscale x 4 x double>,
  i64);

define <vscale x 4 x double>  @intrinsic_vfnmadd_vf_nxv4f64_f64_nxv4f64(<vscale x 4 x double> %0, double %1, <vscale x 4 x double> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_vf_nxv4f64_f64_nxv4f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.d.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e64,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x double> @llvm.riscv.vfnmadd.nxv4f64.f64(
    <vscale x 4 x double> %0,
    double %1,
    <vscale x 4 x double> %2,
    i64 %3)

  ret <vscale x 4 x double> %a
}

declare <vscale x 4 x double> @llvm.riscv.vfnmadd.mask.nxv4f64.f64(
  <vscale x 4 x double>,
  double,
  <vscale x 4 x double>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x double> @intrinsic_vfnmadd_mask_vf_nxv4f64_f64_nxv4f64(<vscale x 4 x double> %0, double %1, <vscale x 4 x double> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vfnmadd_mask_vf_nxv4f64_f64_nxv4f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.d.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e64,m4,tu,mu
; CHECK-NEXT:    vfnmadd.vf v8, ft0, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x double> @llvm.riscv.vfnmadd.mask.nxv4f64.f64(
    <vscale x 4 x double> %0,
    double %1,
    <vscale x 4 x double> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x double> %a
}
