; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs \
; RUN:   --riscv-no-aliases < %s | FileCheck %s
declare <vscale x 1 x i16> @llvm.riscv.vwsub.w.nxv1i16.nxv1i8(
  <vscale x 1 x i16>,
  <vscale x 1 x i8>,
  i32);

define <vscale x 1 x i16> @intrinsic_vwsub.w_wv_nxv1i16_nxv1i16_nxv1i8(<vscale x 1 x i16> %0, <vscale x 1 x i8> %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wv_nxv1i16_nxv1i16_nxv1i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,mf8,ta,mu
; CHECK-NEXT:    vwsub.wv v25, v8, v9
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i16> @llvm.riscv.vwsub.w.nxv1i16.nxv1i8(
    <vscale x 1 x i16> %0,
    <vscale x 1 x i8> %1,
    i32 %2)

  ret <vscale x 1 x i16> %a
}

declare <vscale x 1 x i16> @llvm.riscv.vwsub.w.mask.nxv1i16.nxv1i8(
  <vscale x 1 x i16>,
  <vscale x 1 x i16>,
  <vscale x 1 x i8>,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i16> @intrinsic_vwsub.w_mask_wv_nxv1i16_nxv1i16_nxv1i8(<vscale x 1 x i16> %0, <vscale x 1 x i16> %1, <vscale x 1 x i8> %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wv_nxv1i16_nxv1i16_nxv1i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,mf8,tu,mu
; CHECK-NEXT:    vwsub.wv v8, v9, v10, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i16> @llvm.riscv.vwsub.w.mask.nxv1i16.nxv1i8(
    <vscale x 1 x i16> %0,
    <vscale x 1 x i16> %1,
    <vscale x 1 x i8> %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x i16> %a
}

declare <vscale x 2 x i16> @llvm.riscv.vwsub.w.nxv2i16.nxv2i8(
  <vscale x 2 x i16>,
  <vscale x 2 x i8>,
  i32);

define <vscale x 2 x i16> @intrinsic_vwsub.w_wv_nxv2i16_nxv2i16_nxv2i8(<vscale x 2 x i16> %0, <vscale x 2 x i8> %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wv_nxv2i16_nxv2i16_nxv2i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,mf4,ta,mu
; CHECK-NEXT:    vwsub.wv v25, v8, v9
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i16> @llvm.riscv.vwsub.w.nxv2i16.nxv2i8(
    <vscale x 2 x i16> %0,
    <vscale x 2 x i8> %1,
    i32 %2)

  ret <vscale x 2 x i16> %a
}

declare <vscale x 2 x i16> @llvm.riscv.vwsub.w.mask.nxv2i16.nxv2i8(
  <vscale x 2 x i16>,
  <vscale x 2 x i16>,
  <vscale x 2 x i8>,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i16> @intrinsic_vwsub.w_mask_wv_nxv2i16_nxv2i16_nxv2i8(<vscale x 2 x i16> %0, <vscale x 2 x i16> %1, <vscale x 2 x i8> %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wv_nxv2i16_nxv2i16_nxv2i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,mf4,tu,mu
; CHECK-NEXT:    vwsub.wv v8, v9, v10, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i16> @llvm.riscv.vwsub.w.mask.nxv2i16.nxv2i8(
    <vscale x 2 x i16> %0,
    <vscale x 2 x i16> %1,
    <vscale x 2 x i8> %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vwsub.w.nxv4i16.nxv4i8(
  <vscale x 4 x i16>,
  <vscale x 4 x i8>,
  i32);

define <vscale x 4 x i16> @intrinsic_vwsub.w_wv_nxv4i16_nxv4i16_nxv4i8(<vscale x 4 x i16> %0, <vscale x 4 x i8> %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wv_nxv4i16_nxv4i16_nxv4i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,mf2,ta,mu
; CHECK-NEXT:    vwsub.wv v25, v8, v9
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vwsub.w.nxv4i16.nxv4i8(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i8> %1,
    i32 %2)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vwsub.w.mask.nxv4i16.nxv4i8(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>,
  <vscale x 4 x i8>,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i16> @intrinsic_vwsub.w_mask_wv_nxv4i16_nxv4i16_nxv4i8(<vscale x 4 x i16> %0, <vscale x 4 x i16> %1, <vscale x 4 x i8> %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wv_nxv4i16_nxv4i16_nxv4i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,mf2,tu,mu
; CHECK-NEXT:    vwsub.wv v8, v9, v10, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vwsub.w.mask.nxv4i16.nxv4i8(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16> %1,
    <vscale x 4 x i8> %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.vwsub.w.nxv8i16.nxv8i8(
  <vscale x 8 x i16>,
  <vscale x 8 x i8>,
  i32);

define <vscale x 8 x i16> @intrinsic_vwsub.w_wv_nxv8i16_nxv8i16_nxv8i8(<vscale x 8 x i16> %0, <vscale x 8 x i8> %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wv_nxv8i16_nxv8i16_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,m1,ta,mu
; CHECK-NEXT:    vwsub.wv v26, v8, v10
; CHECK-NEXT:    vmv2r.v v8, v26
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.vwsub.w.nxv8i16.nxv8i8(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i8> %1,
    i32 %2)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.vwsub.w.mask.nxv8i16.nxv8i8(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>,
  <vscale x 8 x i8>,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i16> @intrinsic_vwsub.w_mask_wv_nxv8i16_nxv8i16_nxv8i8(<vscale x 8 x i16> %0, <vscale x 8 x i16> %1, <vscale x 8 x i8> %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wv_nxv8i16_nxv8i16_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,m1,tu,mu
; CHECK-NEXT:    vwsub.wv v8, v10, v12, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.vwsub.w.mask.nxv8i16.nxv8i8(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16> %1,
    <vscale x 8 x i8> %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.vwsub.w.nxv16i16.nxv16i8(
  <vscale x 16 x i16>,
  <vscale x 16 x i8>,
  i32);

define <vscale x 16 x i16> @intrinsic_vwsub.w_wv_nxv16i16_nxv16i16_nxv16i8(<vscale x 16 x i16> %0, <vscale x 16 x i8> %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wv_nxv16i16_nxv16i16_nxv16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,m2,ta,mu
; CHECK-NEXT:    vwsub.wv v28, v8, v12
; CHECK-NEXT:    vmv4r.v v8, v28
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.vwsub.w.nxv16i16.nxv16i8(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i8> %1,
    i32 %2)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.vwsub.w.mask.nxv16i16.nxv16i8(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>,
  <vscale x 16 x i8>,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i16> @intrinsic_vwsub.w_mask_wv_nxv16i16_nxv16i16_nxv16i8(<vscale x 16 x i16> %0, <vscale x 16 x i16> %1, <vscale x 16 x i8> %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wv_nxv16i16_nxv16i16_nxv16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,m2,tu,mu
; CHECK-NEXT:    vwsub.wv v8, v12, v16, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.vwsub.w.mask.nxv16i16.nxv16i8(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16> %1,
    <vscale x 16 x i8> %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.vwsub.w.nxv32i16.nxv32i8(
  <vscale x 32 x i16>,
  <vscale x 32 x i8>,
  i32);

define <vscale x 32 x i16> @intrinsic_vwsub.w_wv_nxv32i16_nxv32i16_nxv32i8(<vscale x 32 x i16> %0, <vscale x 32 x i8> %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wv_nxv32i16_nxv32i16_nxv32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,m4,ta,mu
; CHECK-NEXT:    vwsub.wv v24, v8, v16
; CHECK-NEXT:    vmv8r.v v8, v24
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.vwsub.w.nxv32i16.nxv32i8(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i8> %1,
    i32 %2)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.vwsub.w.mask.nxv32i16.nxv32i8(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>,
  <vscale x 32 x i8>,
  <vscale x 32 x i1>,
  i32);

define <vscale x 32 x i16> @intrinsic_vwsub.w_mask_wv_nxv32i16_nxv32i16_nxv32i8(<vscale x 32 x i16> %0, <vscale x 32 x i16> %1, <vscale x 32 x i8> %2, <vscale x 32 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wv_nxv32i16_nxv32i16_nxv32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl4re8.v v28, (a0)
; CHECK-NEXT:    vsetvli a0, a1, e8,m4,tu,mu
; CHECK-NEXT:    vwsub.wv v8, v16, v28, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.vwsub.w.mask.nxv32i16.nxv32i8(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16> %1,
    <vscale x 32 x i8> %2,
    <vscale x 32 x i1> %3,
    i32 %4)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vwsub.w.nxv1i32.nxv1i16(
  <vscale x 1 x i32>,
  <vscale x 1 x i16>,
  i32);

define <vscale x 1 x i32> @intrinsic_vwsub.w_wv_nxv1i32_nxv1i32_nxv1i16(<vscale x 1 x i32> %0, <vscale x 1 x i16> %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wv_nxv1i32_nxv1i32_nxv1i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf4,ta,mu
; CHECK-NEXT:    vwsub.wv v25, v8, v9
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vwsub.w.nxv1i32.nxv1i16(
    <vscale x 1 x i32> %0,
    <vscale x 1 x i16> %1,
    i32 %2)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vwsub.w.mask.nxv1i32.nxv1i16(
  <vscale x 1 x i32>,
  <vscale x 1 x i32>,
  <vscale x 1 x i16>,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i32> @intrinsic_vwsub.w_mask_wv_nxv1i32_nxv1i32_nxv1i16(<vscale x 1 x i32> %0, <vscale x 1 x i32> %1, <vscale x 1 x i16> %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wv_nxv1i32_nxv1i32_nxv1i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf4,tu,mu
; CHECK-NEXT:    vwsub.wv v8, v9, v10, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vwsub.w.mask.nxv1i32.nxv1i16(
    <vscale x 1 x i32> %0,
    <vscale x 1 x i32> %1,
    <vscale x 1 x i16> %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vwsub.w.nxv2i32.nxv2i16(
  <vscale x 2 x i32>,
  <vscale x 2 x i16>,
  i32);

define <vscale x 2 x i32> @intrinsic_vwsub.w_wv_nxv2i32_nxv2i32_nxv2i16(<vscale x 2 x i32> %0, <vscale x 2 x i16> %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wv_nxv2i32_nxv2i32_nxv2i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf2,ta,mu
; CHECK-NEXT:    vwsub.wv v25, v8, v9
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vwsub.w.nxv2i32.nxv2i16(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i16> %1,
    i32 %2)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vwsub.w.mask.nxv2i32.nxv2i16(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  <vscale x 2 x i16>,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i32> @intrinsic_vwsub.w_mask_wv_nxv2i32_nxv2i32_nxv2i16(<vscale x 2 x i32> %0, <vscale x 2 x i32> %1, <vscale x 2 x i16> %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wv_nxv2i32_nxv2i32_nxv2i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf2,tu,mu
; CHECK-NEXT:    vwsub.wv v8, v9, v10, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vwsub.w.mask.nxv2i32.nxv2i16(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i16> %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vwsub.w.nxv4i32.nxv4i16(
  <vscale x 4 x i32>,
  <vscale x 4 x i16>,
  i32);

define <vscale x 4 x i32> @intrinsic_vwsub.w_wv_nxv4i32_nxv4i32_nxv4i16(<vscale x 4 x i32> %0, <vscale x 4 x i16> %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wv_nxv4i32_nxv4i32_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m1,ta,mu
; CHECK-NEXT:    vwsub.wv v26, v8, v10
; CHECK-NEXT:    vmv2r.v v8, v26
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vwsub.w.nxv4i32.nxv4i16(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i16> %1,
    i32 %2)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vwsub.w.mask.nxv4i32.nxv4i16(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>,
  <vscale x 4 x i16>,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i32> @intrinsic_vwsub.w_mask_wv_nxv4i32_nxv4i32_nxv4i16(<vscale x 4 x i32> %0, <vscale x 4 x i32> %1, <vscale x 4 x i16> %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wv_nxv4i32_nxv4i32_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m1,tu,mu
; CHECK-NEXT:    vwsub.wv v8, v10, v12, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vwsub.w.mask.nxv4i32.nxv4i16(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32> %1,
    <vscale x 4 x i16> %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vwsub.w.nxv8i32.nxv8i16(
  <vscale x 8 x i32>,
  <vscale x 8 x i16>,
  i32);

define <vscale x 8 x i32> @intrinsic_vwsub.w_wv_nxv8i32_nxv8i32_nxv8i16(<vscale x 8 x i32> %0, <vscale x 8 x i16> %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wv_nxv8i32_nxv8i32_nxv8i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m2,ta,mu
; CHECK-NEXT:    vwsub.wv v28, v8, v12
; CHECK-NEXT:    vmv4r.v v8, v28
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vwsub.w.nxv8i32.nxv8i16(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i16> %1,
    i32 %2)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vwsub.w.mask.nxv8i32.nxv8i16(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>,
  <vscale x 8 x i16>,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i32> @intrinsic_vwsub.w_mask_wv_nxv8i32_nxv8i32_nxv8i16(<vscale x 8 x i32> %0, <vscale x 8 x i32> %1, <vscale x 8 x i16> %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wv_nxv8i32_nxv8i32_nxv8i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m2,tu,mu
; CHECK-NEXT:    vwsub.wv v8, v12, v16, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vwsub.w.mask.nxv8i32.nxv8i16(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32> %1,
    <vscale x 8 x i16> %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vwsub.w.nxv16i32.nxv16i16(
  <vscale x 16 x i32>,
  <vscale x 16 x i16>,
  i32);

define <vscale x 16 x i32> @intrinsic_vwsub.w_wv_nxv16i32_nxv16i32_nxv16i16(<vscale x 16 x i32> %0, <vscale x 16 x i16> %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wv_nxv16i32_nxv16i32_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m4,ta,mu
; CHECK-NEXT:    vwsub.wv v24, v8, v16
; CHECK-NEXT:    vmv8r.v v8, v24
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vwsub.w.nxv16i32.nxv16i16(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i16> %1,
    i32 %2)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vwsub.w.mask.nxv16i32.nxv16i16(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>,
  <vscale x 16 x i16>,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i32> @intrinsic_vwsub.w_mask_wv_nxv16i32_nxv16i32_nxv16i16(<vscale x 16 x i32> %0, <vscale x 16 x i32> %1, <vscale x 16 x i16> %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wv_nxv16i32_nxv16i32_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl4re16.v v28, (a0)
; CHECK-NEXT:    vsetvli a0, a1, e16,m4,tu,mu
; CHECK-NEXT:    vwsub.wv v8, v16, v28, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vwsub.w.mask.nxv16i32.nxv16i16(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32> %1,
    <vscale x 16 x i16> %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i16> @llvm.riscv.vwsub.w.nxv1i16.i8(
  <vscale x 1 x i16>,
  i8,
  i32);

define <vscale x 1 x i16> @intrinsic_vwsub.w_wx_nxv1i16_nxv1i16_i8(<vscale x 1 x i16> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wx_nxv1i16_nxv1i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf8,ta,mu
; CHECK-NEXT:    vwsub.wx v25, v8, a0
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i16> @llvm.riscv.vwsub.w.nxv1i16.i8(
    <vscale x 1 x i16> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 1 x i16> %a
}

declare <vscale x 1 x i16> @llvm.riscv.vwsub.w.mask.nxv1i16.i8(
  <vscale x 1 x i16>,
  <vscale x 1 x i16>,
  i8,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i16> @intrinsic_vwsub.w_mask_wx_nxv1i16_nxv1i16_i8(<vscale x 1 x i16> %0, <vscale x 1 x i16> %1, i8 %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wx_nxv1i16_nxv1i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf8,tu,mu
; CHECK-NEXT:    vwsub.wx v8, v9, a0, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i16> @llvm.riscv.vwsub.w.mask.nxv1i16.i8(
    <vscale x 1 x i16> %0,
    <vscale x 1 x i16> %1,
    i8 %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x i16> %a
}

declare <vscale x 2 x i16> @llvm.riscv.vwsub.w.nxv2i16.i8(
  <vscale x 2 x i16>,
  i8,
  i32);

define <vscale x 2 x i16> @intrinsic_vwsub.w_wx_nxv2i16_nxv2i16_i8(<vscale x 2 x i16> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wx_nxv2i16_nxv2i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf4,ta,mu
; CHECK-NEXT:    vwsub.wx v25, v8, a0
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i16> @llvm.riscv.vwsub.w.nxv2i16.i8(
    <vscale x 2 x i16> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 2 x i16> %a
}

declare <vscale x 2 x i16> @llvm.riscv.vwsub.w.mask.nxv2i16.i8(
  <vscale x 2 x i16>,
  <vscale x 2 x i16>,
  i8,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i16> @intrinsic_vwsub.w_mask_wx_nxv2i16_nxv2i16_i8(<vscale x 2 x i16> %0, <vscale x 2 x i16> %1, i8 %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wx_nxv2i16_nxv2i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf4,tu,mu
; CHECK-NEXT:    vwsub.wx v8, v9, a0, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i16> @llvm.riscv.vwsub.w.mask.nxv2i16.i8(
    <vscale x 2 x i16> %0,
    <vscale x 2 x i16> %1,
    i8 %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vwsub.w.nxv4i16.i8(
  <vscale x 4 x i16>,
  i8,
  i32);

define <vscale x 4 x i16> @intrinsic_vwsub.w_wx_nxv4i16_nxv4i16_i8(<vscale x 4 x i16> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wx_nxv4i16_nxv4i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf2,ta,mu
; CHECK-NEXT:    vwsub.wx v25, v8, a0
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vwsub.w.nxv4i16.i8(
    <vscale x 4 x i16> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vwsub.w.mask.nxv4i16.i8(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>,
  i8,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i16> @intrinsic_vwsub.w_mask_wx_nxv4i16_nxv4i16_i8(<vscale x 4 x i16> %0, <vscale x 4 x i16> %1, i8 %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wx_nxv4i16_nxv4i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf2,tu,mu
; CHECK-NEXT:    vwsub.wx v8, v9, a0, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vwsub.w.mask.nxv4i16.i8(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16> %1,
    i8 %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.vwsub.w.nxv8i16.i8(
  <vscale x 8 x i16>,
  i8,
  i32);

define <vscale x 8 x i16> @intrinsic_vwsub.w_wx_nxv8i16_nxv8i16_i8(<vscale x 8 x i16> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wx_nxv8i16_nxv8i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m1,ta,mu
; CHECK-NEXT:    vwsub.wx v26, v8, a0
; CHECK-NEXT:    vmv2r.v v8, v26
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.vwsub.w.nxv8i16.i8(
    <vscale x 8 x i16> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.vwsub.w.mask.nxv8i16.i8(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>,
  i8,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i16> @intrinsic_vwsub.w_mask_wx_nxv8i16_nxv8i16_i8(<vscale x 8 x i16> %0, <vscale x 8 x i16> %1, i8 %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wx_nxv8i16_nxv8i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m1,tu,mu
; CHECK-NEXT:    vwsub.wx v8, v10, a0, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.vwsub.w.mask.nxv8i16.i8(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16> %1,
    i8 %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.vwsub.w.nxv16i16.i8(
  <vscale x 16 x i16>,
  i8,
  i32);

define <vscale x 16 x i16> @intrinsic_vwsub.w_wx_nxv16i16_nxv16i16_i8(<vscale x 16 x i16> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wx_nxv16i16_nxv16i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m2,ta,mu
; CHECK-NEXT:    vwsub.wx v28, v8, a0
; CHECK-NEXT:    vmv4r.v v8, v28
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.vwsub.w.nxv16i16.i8(
    <vscale x 16 x i16> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.vwsub.w.mask.nxv16i16.i8(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>,
  i8,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i16> @intrinsic_vwsub.w_mask_wx_nxv16i16_nxv16i16_i8(<vscale x 16 x i16> %0, <vscale x 16 x i16> %1, i8 %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wx_nxv16i16_nxv16i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m2,tu,mu
; CHECK-NEXT:    vwsub.wx v8, v12, a0, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.vwsub.w.mask.nxv16i16.i8(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16> %1,
    i8 %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.vwsub.w.nxv32i16.i8(
  <vscale x 32 x i16>,
  i8,
  i32);

define <vscale x 32 x i16> @intrinsic_vwsub.w_wx_nxv32i16_nxv32i16_i8(<vscale x 32 x i16> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wx_nxv32i16_nxv32i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m4,ta,mu
; CHECK-NEXT:    vwsub.wx v16, v8, a0
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.vwsub.w.nxv32i16.i8(
    <vscale x 32 x i16> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.vwsub.w.mask.nxv32i16.i8(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>,
  i8,
  <vscale x 32 x i1>,
  i32);

define <vscale x 32 x i16> @intrinsic_vwsub.w_mask_wx_nxv32i16_nxv32i16_i8(<vscale x 32 x i16> %0, <vscale x 32 x i16> %1, i8 %2, <vscale x 32 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wx_nxv32i16_nxv32i16_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m4,tu,mu
; CHECK-NEXT:    vwsub.wx v8, v16, a0, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.vwsub.w.mask.nxv32i16.i8(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16> %1,
    i8 %2,
    <vscale x 32 x i1> %3,
    i32 %4)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vwsub.w.nxv1i32.i16(
  <vscale x 1 x i32>,
  i16,
  i32);

define <vscale x 1 x i32> @intrinsic_vwsub.w_wx_nxv1i32_nxv1i32_i16(<vscale x 1 x i32> %0, i16 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wx_nxv1i32_nxv1i32_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,mf4,ta,mu
; CHECK-NEXT:    vwsub.wx v25, v8, a0
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vwsub.w.nxv1i32.i16(
    <vscale x 1 x i32> %0,
    i16 %1,
    i32 %2)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vwsub.w.mask.nxv1i32.i16(
  <vscale x 1 x i32>,
  <vscale x 1 x i32>,
  i16,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i32> @intrinsic_vwsub.w_mask_wx_nxv1i32_nxv1i32_i16(<vscale x 1 x i32> %0, <vscale x 1 x i32> %1, i16 %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wx_nxv1i32_nxv1i32_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,mf4,tu,mu
; CHECK-NEXT:    vwsub.wx v8, v9, a0, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vwsub.w.mask.nxv1i32.i16(
    <vscale x 1 x i32> %0,
    <vscale x 1 x i32> %1,
    i16 %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vwsub.w.nxv2i32.i16(
  <vscale x 2 x i32>,
  i16,
  i32);

define <vscale x 2 x i32> @intrinsic_vwsub.w_wx_nxv2i32_nxv2i32_i16(<vscale x 2 x i32> %0, i16 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wx_nxv2i32_nxv2i32_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,mf2,ta,mu
; CHECK-NEXT:    vwsub.wx v25, v8, a0
; CHECK-NEXT:    vmv1r.v v8, v25
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vwsub.w.nxv2i32.i16(
    <vscale x 2 x i32> %0,
    i16 %1,
    i32 %2)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vwsub.w.mask.nxv2i32.i16(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  i16,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i32> @intrinsic_vwsub.w_mask_wx_nxv2i32_nxv2i32_i16(<vscale x 2 x i32> %0, <vscale x 2 x i32> %1, i16 %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wx_nxv2i32_nxv2i32_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,mf2,tu,mu
; CHECK-NEXT:    vwsub.wx v8, v9, a0, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vwsub.w.mask.nxv2i32.i16(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32> %1,
    i16 %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vwsub.w.nxv4i32.i16(
  <vscale x 4 x i32>,
  i16,
  i32);

define <vscale x 4 x i32> @intrinsic_vwsub.w_wx_nxv4i32_nxv4i32_i16(<vscale x 4 x i32> %0, i16 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wx_nxv4i32_nxv4i32_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m1,ta,mu
; CHECK-NEXT:    vwsub.wx v26, v8, a0
; CHECK-NEXT:    vmv2r.v v8, v26
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vwsub.w.nxv4i32.i16(
    <vscale x 4 x i32> %0,
    i16 %1,
    i32 %2)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vwsub.w.mask.nxv4i32.i16(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>,
  i16,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i32> @intrinsic_vwsub.w_mask_wx_nxv4i32_nxv4i32_i16(<vscale x 4 x i32> %0, <vscale x 4 x i32> %1, i16 %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wx_nxv4i32_nxv4i32_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m1,tu,mu
; CHECK-NEXT:    vwsub.wx v8, v10, a0, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vwsub.w.mask.nxv4i32.i16(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32> %1,
    i16 %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vwsub.w.nxv8i32.i16(
  <vscale x 8 x i32>,
  i16,
  i32);

define <vscale x 8 x i32> @intrinsic_vwsub.w_wx_nxv8i32_nxv8i32_i16(<vscale x 8 x i32> %0, i16 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wx_nxv8i32_nxv8i32_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m2,ta,mu
; CHECK-NEXT:    vwsub.wx v28, v8, a0
; CHECK-NEXT:    vmv4r.v v8, v28
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vwsub.w.nxv8i32.i16(
    <vscale x 8 x i32> %0,
    i16 %1,
    i32 %2)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vwsub.w.mask.nxv8i32.i16(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>,
  i16,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i32> @intrinsic_vwsub.w_mask_wx_nxv8i32_nxv8i32_i16(<vscale x 8 x i32> %0, <vscale x 8 x i32> %1, i16 %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wx_nxv8i32_nxv8i32_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m2,tu,mu
; CHECK-NEXT:    vwsub.wx v8, v12, a0, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vwsub.w.mask.nxv8i32.i16(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32> %1,
    i16 %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vwsub.w.nxv16i32.i16(
  <vscale x 16 x i32>,
  i16,
  i32);

define <vscale x 16 x i32> @intrinsic_vwsub.w_wx_nxv16i32_nxv16i32_i16(<vscale x 16 x i32> %0, i16 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_wx_nxv16i32_nxv16i32_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m4,ta,mu
; CHECK-NEXT:    vwsub.wx v16, v8, a0
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vwsub.w.nxv16i32.i16(
    <vscale x 16 x i32> %0,
    i16 %1,
    i32 %2)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vwsub.w.mask.nxv16i32.i16(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>,
  i16,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i32> @intrinsic_vwsub.w_mask_wx_nxv16i32_nxv16i32_i16(<vscale x 16 x i32> %0, <vscale x 16 x i32> %1, i16 %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vwsub.w_mask_wx_nxv16i32_nxv16i32_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m4,tu,mu
; CHECK-NEXT:    vwsub.wx v8, v16, a0, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vwsub.w.mask.nxv16i32.i16(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32> %1,
    i16 %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x i32> %a
}
