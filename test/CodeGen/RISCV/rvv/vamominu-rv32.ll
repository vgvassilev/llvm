; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v,+d,+experimental-zvamo -verify-machineinstrs \
; RUN:   --riscv-no-aliases < %s | FileCheck %s
declare <vscale x 1 x i32> @llvm.riscv.vamominu.nxv1i32.nxv1i32(
  <vscale x 1 x i32>*,
  <vscale x 1 x i32>,
  <vscale x 1 x i32>,
  i32);

define <vscale x 1 x i32> @intrinsic_vamominu_v_nxv1i32_nxv1i32(<vscale x 1 x i32> *%0, <vscale x 1 x i32> %1, <vscale x 1 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv1i32_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,mf2,tu,mu
; CHECK-NEXT:    vamominuei32.v v9, (a0), v8, v9
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vamominu.nxv1i32.nxv1i32(
    <vscale x 1 x i32> *%0,
    <vscale x 1 x i32> %1,
    <vscale x 1 x i32> %2,
    i32 %3)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vamominu.mask.nxv1i32.nxv1i32(
  <vscale x 1 x i32>*,
  <vscale x 1 x i32>,
  <vscale x 1 x i32>,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i32> @intrinsic_vamominu_mask_v_nxv1i32_nxv1i32(<vscale x 1 x i32> *%0, <vscale x 1 x i32> %1, <vscale x 1 x i32> %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv1i32_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,mf2,tu,mu
; CHECK-NEXT:    vamominuei32.v v9, (a0), v8, v9, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vamominu.mask.nxv1i32.nxv1i32(
    <vscale x 1 x i32> *%0,
    <vscale x 1 x i32> %1,
    <vscale x 1 x i32> %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vamominu.nxv2i32.nxv2i32(
  <vscale x 2 x i32>*,
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  i32);

define <vscale x 2 x i32> @intrinsic_vamominu_v_nxv2i32_nxv2i32(<vscale x 2 x i32> *%0, <vscale x 2 x i32> %1, <vscale x 2 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv2i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m1,tu,mu
; CHECK-NEXT:    vamominuei32.v v9, (a0), v8, v9
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vamominu.nxv2i32.nxv2i32(
    <vscale x 2 x i32> *%0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i32> %2,
    i32 %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vamominu.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>*,
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i32> @intrinsic_vamominu_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> *%0, <vscale x 2 x i32> %1, <vscale x 2 x i32> %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv2i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m1,tu,mu
; CHECK-NEXT:    vamominuei32.v v9, (a0), v8, v9, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vamominu.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> *%0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i32> %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vamominu.nxv4i32.nxv4i32(
  <vscale x 4 x i32>*,
  <vscale x 4 x i32>,
  <vscale x 4 x i32>,
  i32);

define <vscale x 4 x i32> @intrinsic_vamominu_v_nxv4i32_nxv4i32(<vscale x 4 x i32> *%0, <vscale x 4 x i32> %1, <vscale x 4 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv4i32_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m2,tu,mu
; CHECK-NEXT:    vamominuei32.v v10, (a0), v8, v10
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vamominu.nxv4i32.nxv4i32(
    <vscale x 4 x i32> *%0,
    <vscale x 4 x i32> %1,
    <vscale x 4 x i32> %2,
    i32 %3)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vamominu.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>*,
  <vscale x 4 x i32>,
  <vscale x 4 x i32>,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i32> @intrinsic_vamominu_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> *%0, <vscale x 4 x i32> %1, <vscale x 4 x i32> %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv4i32_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m2,tu,mu
; CHECK-NEXT:    vamominuei32.v v10, (a0), v8, v10, v0.t
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vamominu.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> *%0,
    <vscale x 4 x i32> %1,
    <vscale x 4 x i32> %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vamominu.nxv8i32.nxv8i32(
  <vscale x 8 x i32>*,
  <vscale x 8 x i32>,
  <vscale x 8 x i32>,
  i32);

define <vscale x 8 x i32> @intrinsic_vamominu_v_nxv8i32_nxv8i32(<vscale x 8 x i32> *%0, <vscale x 8 x i32> %1, <vscale x 8 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv8i32_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m4,tu,mu
; CHECK-NEXT:    vamominuei32.v v12, (a0), v8, v12
; CHECK-NEXT:    vmv4r.v v8, v12
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vamominu.nxv8i32.nxv8i32(
    <vscale x 8 x i32> *%0,
    <vscale x 8 x i32> %1,
    <vscale x 8 x i32> %2,
    i32 %3)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vamominu.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>*,
  <vscale x 8 x i32>,
  <vscale x 8 x i32>,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i32> @intrinsic_vamominu_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> *%0, <vscale x 8 x i32> %1, <vscale x 8 x i32> %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv8i32_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m4,tu,mu
; CHECK-NEXT:    vamominuei32.v v12, (a0), v8, v12, v0.t
; CHECK-NEXT:    vmv4r.v v8, v12
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vamominu.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> *%0,
    <vscale x 8 x i32> %1,
    <vscale x 8 x i32> %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vamominu.nxv16i32.nxv16i32(
  <vscale x 16 x i32>*,
  <vscale x 16 x i32>,
  <vscale x 16 x i32>,
  i32);

define <vscale x 16 x i32> @intrinsic_vamominu_v_nxv16i32_nxv16i32(<vscale x 16 x i32> *%0, <vscale x 16 x i32> %1, <vscale x 16 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv16i32_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m8,tu,mu
; CHECK-NEXT:    vamominuei32.v v16, (a0), v8, v16
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vamominu.nxv16i32.nxv16i32(
    <vscale x 16 x i32> *%0,
    <vscale x 16 x i32> %1,
    <vscale x 16 x i32> %2,
    i32 %3)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vamominu.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>*,
  <vscale x 16 x i32>,
  <vscale x 16 x i32>,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i32> @intrinsic_vamominu_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> *%0, <vscale x 16 x i32> %1, <vscale x 16 x i32> %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv16i32_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m8,tu,mu
; CHECK-NEXT:    vamominuei32.v v16, (a0), v8, v16, v0.t
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vamominu.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> *%0,
    <vscale x 16 x i32> %1,
    <vscale x 16 x i32> %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vamominu.nxv1i32.nxv1i16(
  <vscale x 1 x i32>*,
  <vscale x 1 x i16>,
  <vscale x 1 x i32>,
  i32);

define <vscale x 1 x i32> @intrinsic_vamominu_v_nxv1i32_nxv1i16(<vscale x 1 x i32> *%0, <vscale x 1 x i16> %1, <vscale x 1 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv1i32_nxv1i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,mf2,tu,mu
; CHECK-NEXT:    vamominuei16.v v9, (a0), v8, v9
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vamominu.nxv1i32.nxv1i16(
    <vscale x 1 x i32> *%0,
    <vscale x 1 x i16> %1,
    <vscale x 1 x i32> %2,
    i32 %3)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vamominu.mask.nxv1i32.nxv1i16(
  <vscale x 1 x i32>*,
  <vscale x 1 x i16>,
  <vscale x 1 x i32>,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i32> @intrinsic_vamominu_mask_v_nxv1i32_nxv1i16(<vscale x 1 x i32> *%0, <vscale x 1 x i16> %1, <vscale x 1 x i32> %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv1i32_nxv1i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,mf2,tu,mu
; CHECK-NEXT:    vamominuei16.v v9, (a0), v8, v9, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vamominu.mask.nxv1i32.nxv1i16(
    <vscale x 1 x i32> *%0,
    <vscale x 1 x i16> %1,
    <vscale x 1 x i32> %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vamominu.nxv2i32.nxv2i16(
  <vscale x 2 x i32>*,
  <vscale x 2 x i16>,
  <vscale x 2 x i32>,
  i32);

define <vscale x 2 x i32> @intrinsic_vamominu_v_nxv2i32_nxv2i16(<vscale x 2 x i32> *%0, <vscale x 2 x i16> %1, <vscale x 2 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv2i32_nxv2i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m1,tu,mu
; CHECK-NEXT:    vamominuei16.v v9, (a0), v8, v9
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vamominu.nxv2i32.nxv2i16(
    <vscale x 2 x i32> *%0,
    <vscale x 2 x i16> %1,
    <vscale x 2 x i32> %2,
    i32 %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vamominu.mask.nxv2i32.nxv2i16(
  <vscale x 2 x i32>*,
  <vscale x 2 x i16>,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i32> @intrinsic_vamominu_mask_v_nxv2i32_nxv2i16(<vscale x 2 x i32> *%0, <vscale x 2 x i16> %1, <vscale x 2 x i32> %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv2i32_nxv2i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m1,tu,mu
; CHECK-NEXT:    vamominuei16.v v9, (a0), v8, v9, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vamominu.mask.nxv2i32.nxv2i16(
    <vscale x 2 x i32> *%0,
    <vscale x 2 x i16> %1,
    <vscale x 2 x i32> %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vamominu.nxv4i32.nxv4i16(
  <vscale x 4 x i32>*,
  <vscale x 4 x i16>,
  <vscale x 4 x i32>,
  i32);

define <vscale x 4 x i32> @intrinsic_vamominu_v_nxv4i32_nxv4i16(<vscale x 4 x i32> *%0, <vscale x 4 x i16> %1, <vscale x 4 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv4i32_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m2,tu,mu
; CHECK-NEXT:    vamominuei16.v v10, (a0), v8, v10
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vamominu.nxv4i32.nxv4i16(
    <vscale x 4 x i32> *%0,
    <vscale x 4 x i16> %1,
    <vscale x 4 x i32> %2,
    i32 %3)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vamominu.mask.nxv4i32.nxv4i16(
  <vscale x 4 x i32>*,
  <vscale x 4 x i16>,
  <vscale x 4 x i32>,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i32> @intrinsic_vamominu_mask_v_nxv4i32_nxv4i16(<vscale x 4 x i32> *%0, <vscale x 4 x i16> %1, <vscale x 4 x i32> %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv4i32_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m2,tu,mu
; CHECK-NEXT:    vamominuei16.v v10, (a0), v8, v10, v0.t
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vamominu.mask.nxv4i32.nxv4i16(
    <vscale x 4 x i32> *%0,
    <vscale x 4 x i16> %1,
    <vscale x 4 x i32> %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vamominu.nxv8i32.nxv8i16(
  <vscale x 8 x i32>*,
  <vscale x 8 x i16>,
  <vscale x 8 x i32>,
  i32);

define <vscale x 8 x i32> @intrinsic_vamominu_v_nxv8i32_nxv8i16(<vscale x 8 x i32> *%0, <vscale x 8 x i16> %1, <vscale x 8 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv8i32_nxv8i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m4,tu,mu
; CHECK-NEXT:    vamominuei16.v v12, (a0), v8, v12
; CHECK-NEXT:    vmv4r.v v8, v12
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vamominu.nxv8i32.nxv8i16(
    <vscale x 8 x i32> *%0,
    <vscale x 8 x i16> %1,
    <vscale x 8 x i32> %2,
    i32 %3)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vamominu.mask.nxv8i32.nxv8i16(
  <vscale x 8 x i32>*,
  <vscale x 8 x i16>,
  <vscale x 8 x i32>,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i32> @intrinsic_vamominu_mask_v_nxv8i32_nxv8i16(<vscale x 8 x i32> *%0, <vscale x 8 x i16> %1, <vscale x 8 x i32> %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv8i32_nxv8i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m4,tu,mu
; CHECK-NEXT:    vamominuei16.v v12, (a0), v8, v12, v0.t
; CHECK-NEXT:    vmv4r.v v8, v12
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vamominu.mask.nxv8i32.nxv8i16(
    <vscale x 8 x i32> *%0,
    <vscale x 8 x i16> %1,
    <vscale x 8 x i32> %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vamominu.nxv16i32.nxv16i16(
  <vscale x 16 x i32>*,
  <vscale x 16 x i16>,
  <vscale x 16 x i32>,
  i32);

define <vscale x 16 x i32> @intrinsic_vamominu_v_nxv16i32_nxv16i16(<vscale x 16 x i32> *%0, <vscale x 16 x i16> %1, <vscale x 16 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv16i32_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m8,tu,mu
; CHECK-NEXT:    vamominuei16.v v16, (a0), v8, v16
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vamominu.nxv16i32.nxv16i16(
    <vscale x 16 x i32> *%0,
    <vscale x 16 x i16> %1,
    <vscale x 16 x i32> %2,
    i32 %3)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vamominu.mask.nxv16i32.nxv16i16(
  <vscale x 16 x i32>*,
  <vscale x 16 x i16>,
  <vscale x 16 x i32>,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i32> @intrinsic_vamominu_mask_v_nxv16i32_nxv16i16(<vscale x 16 x i32> *%0, <vscale x 16 x i16> %1, <vscale x 16 x i32> %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv16i32_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m8,tu,mu
; CHECK-NEXT:    vamominuei16.v v16, (a0), v8, v16, v0.t
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vamominu.mask.nxv16i32.nxv16i16(
    <vscale x 16 x i32> *%0,
    <vscale x 16 x i16> %1,
    <vscale x 16 x i32> %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vamominu.nxv1i32.nxv1i8(
  <vscale x 1 x i32>*,
  <vscale x 1 x i8>,
  <vscale x 1 x i32>,
  i32);

define <vscale x 1 x i32> @intrinsic_vamominu_v_nxv1i32_nxv1i8(<vscale x 1 x i32> *%0, <vscale x 1 x i8> %1, <vscale x 1 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv1i32_nxv1i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,mf2,tu,mu
; CHECK-NEXT:    vamominuei8.v v9, (a0), v8, v9
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vamominu.nxv1i32.nxv1i8(
    <vscale x 1 x i32> *%0,
    <vscale x 1 x i8> %1,
    <vscale x 1 x i32> %2,
    i32 %3)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vamominu.mask.nxv1i32.nxv1i8(
  <vscale x 1 x i32>*,
  <vscale x 1 x i8>,
  <vscale x 1 x i32>,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i32> @intrinsic_vamominu_mask_v_nxv1i32_nxv1i8(<vscale x 1 x i32> *%0, <vscale x 1 x i8> %1, <vscale x 1 x i32> %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv1i32_nxv1i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,mf2,tu,mu
; CHECK-NEXT:    vamominuei8.v v9, (a0), v8, v9, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vamominu.mask.nxv1i32.nxv1i8(
    <vscale x 1 x i32> *%0,
    <vscale x 1 x i8> %1,
    <vscale x 1 x i32> %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vamominu.nxv2i32.nxv2i8(
  <vscale x 2 x i32>*,
  <vscale x 2 x i8>,
  <vscale x 2 x i32>,
  i32);

define <vscale x 2 x i32> @intrinsic_vamominu_v_nxv2i32_nxv2i8(<vscale x 2 x i32> *%0, <vscale x 2 x i8> %1, <vscale x 2 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv2i32_nxv2i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m1,tu,mu
; CHECK-NEXT:    vamominuei8.v v9, (a0), v8, v9
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vamominu.nxv2i32.nxv2i8(
    <vscale x 2 x i32> *%0,
    <vscale x 2 x i8> %1,
    <vscale x 2 x i32> %2,
    i32 %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vamominu.mask.nxv2i32.nxv2i8(
  <vscale x 2 x i32>*,
  <vscale x 2 x i8>,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i32> @intrinsic_vamominu_mask_v_nxv2i32_nxv2i8(<vscale x 2 x i32> *%0, <vscale x 2 x i8> %1, <vscale x 2 x i32> %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv2i32_nxv2i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m1,tu,mu
; CHECK-NEXT:    vamominuei8.v v9, (a0), v8, v9, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vamominu.mask.nxv2i32.nxv2i8(
    <vscale x 2 x i32> *%0,
    <vscale x 2 x i8> %1,
    <vscale x 2 x i32> %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vamominu.nxv4i32.nxv4i8(
  <vscale x 4 x i32>*,
  <vscale x 4 x i8>,
  <vscale x 4 x i32>,
  i32);

define <vscale x 4 x i32> @intrinsic_vamominu_v_nxv4i32_nxv4i8(<vscale x 4 x i32> *%0, <vscale x 4 x i8> %1, <vscale x 4 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv4i32_nxv4i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m2,tu,mu
; CHECK-NEXT:    vamominuei8.v v10, (a0), v8, v10
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vamominu.nxv4i32.nxv4i8(
    <vscale x 4 x i32> *%0,
    <vscale x 4 x i8> %1,
    <vscale x 4 x i32> %2,
    i32 %3)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vamominu.mask.nxv4i32.nxv4i8(
  <vscale x 4 x i32>*,
  <vscale x 4 x i8>,
  <vscale x 4 x i32>,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i32> @intrinsic_vamominu_mask_v_nxv4i32_nxv4i8(<vscale x 4 x i32> *%0, <vscale x 4 x i8> %1, <vscale x 4 x i32> %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv4i32_nxv4i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m2,tu,mu
; CHECK-NEXT:    vamominuei8.v v10, (a0), v8, v10, v0.t
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vamominu.mask.nxv4i32.nxv4i8(
    <vscale x 4 x i32> *%0,
    <vscale x 4 x i8> %1,
    <vscale x 4 x i32> %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vamominu.nxv8i32.nxv8i8(
  <vscale x 8 x i32>*,
  <vscale x 8 x i8>,
  <vscale x 8 x i32>,
  i32);

define <vscale x 8 x i32> @intrinsic_vamominu_v_nxv8i32_nxv8i8(<vscale x 8 x i32> *%0, <vscale x 8 x i8> %1, <vscale x 8 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv8i32_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m4,tu,mu
; CHECK-NEXT:    vamominuei8.v v12, (a0), v8, v12
; CHECK-NEXT:    vmv4r.v v8, v12
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vamominu.nxv8i32.nxv8i8(
    <vscale x 8 x i32> *%0,
    <vscale x 8 x i8> %1,
    <vscale x 8 x i32> %2,
    i32 %3)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vamominu.mask.nxv8i32.nxv8i8(
  <vscale x 8 x i32>*,
  <vscale x 8 x i8>,
  <vscale x 8 x i32>,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i32> @intrinsic_vamominu_mask_v_nxv8i32_nxv8i8(<vscale x 8 x i32> *%0, <vscale x 8 x i8> %1, <vscale x 8 x i32> %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv8i32_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m4,tu,mu
; CHECK-NEXT:    vamominuei8.v v12, (a0), v8, v12, v0.t
; CHECK-NEXT:    vmv4r.v v8, v12
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vamominu.mask.nxv8i32.nxv8i8(
    <vscale x 8 x i32> *%0,
    <vscale x 8 x i8> %1,
    <vscale x 8 x i32> %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vamominu.nxv16i32.nxv16i8(
  <vscale x 16 x i32>*,
  <vscale x 16 x i8>,
  <vscale x 16 x i32>,
  i32);

define <vscale x 16 x i32> @intrinsic_vamominu_v_nxv16i32_nxv16i8(<vscale x 16 x i32> *%0, <vscale x 16 x i8> %1, <vscale x 16 x i32> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vamominu_v_nxv16i32_nxv16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m8,tu,mu
; CHECK-NEXT:    vamominuei8.v v16, (a0), v8, v16
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vamominu.nxv16i32.nxv16i8(
    <vscale x 16 x i32> *%0,
    <vscale x 16 x i8> %1,
    <vscale x 16 x i32> %2,
    i32 %3)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vamominu.mask.nxv16i32.nxv16i8(
  <vscale x 16 x i32>*,
  <vscale x 16 x i8>,
  <vscale x 16 x i32>,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i32> @intrinsic_vamominu_mask_v_nxv16i32_nxv16i8(<vscale x 16 x i32> *%0, <vscale x 16 x i8> %1, <vscale x 16 x i32> %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vamominu_mask_v_nxv16i32_nxv16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m8,tu,mu
; CHECK-NEXT:    vamominuei8.v v16, (a0), v8, v16, v0.t
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vamominu.mask.nxv16i32.nxv16i8(
    <vscale x 16 x i32> *%0,
    <vscale x 16 x i8> %1,
    <vscale x 16 x i32> %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x i32> %a
}
