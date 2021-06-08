; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v,+f -verify-machineinstrs \
; RUN:   < %s | FileCheck %s
declare <vscale x 1 x i8> @llvm.riscv.vslide1down.nxv1i8.i8(
  <vscale x 1 x i8>,
  i8,
  i32);

define <vscale x 1 x i8> @intrinsic_vslide1down_vx_nxv1i8_nxv1i8_i8(<vscale x 1 x i8> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv1i8_nxv1i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i8> @llvm.riscv.vslide1down.nxv1i8.i8(
    <vscale x 1 x i8> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 1 x i8> %a
}

declare <vscale x 1 x i8> @llvm.riscv.vslide1down.mask.nxv1i8.i8(
  <vscale x 1 x i8>,
  <vscale x 1 x i8>,
  i8,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i8> @intrinsic_vslide1down_mask_vx_nxv1i8_nxv1i8_i8(<vscale x 1 x i8> %0, <vscale x 1 x i8> %1, i8 %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv1i8_nxv1i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v9, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i8> @llvm.riscv.vslide1down.mask.nxv1i8.i8(
    <vscale x 1 x i8> %0,
    <vscale x 1 x i8> %1,
    i8 %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x i8> %a
}

declare <vscale x 2 x i8> @llvm.riscv.vslide1down.nxv2i8.i8(
  <vscale x 2 x i8>,
  i8,
  i32);

define <vscale x 2 x i8> @intrinsic_vslide1down_vx_nxv2i8_nxv2i8_i8(<vscale x 2 x i8> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv2i8_nxv2i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i8> @llvm.riscv.vslide1down.nxv2i8.i8(
    <vscale x 2 x i8> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 2 x i8> %a
}

declare <vscale x 2 x i8> @llvm.riscv.vslide1down.mask.nxv2i8.i8(
  <vscale x 2 x i8>,
  <vscale x 2 x i8>,
  i8,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i8> @intrinsic_vslide1down_mask_vx_nxv2i8_nxv2i8_i8(<vscale x 2 x i8> %0, <vscale x 2 x i8> %1, i8 %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv2i8_nxv2i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v9, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i8> @llvm.riscv.vslide1down.mask.nxv2i8.i8(
    <vscale x 2 x i8> %0,
    <vscale x 2 x i8> %1,
    i8 %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x i8> %a
}

declare <vscale x 4 x i8> @llvm.riscv.vslide1down.nxv4i8.i8(
  <vscale x 4 x i8>,
  i8,
  i32);

define <vscale x 4 x i8> @intrinsic_vslide1down_vx_nxv4i8_nxv4i8_i8(<vscale x 4 x i8> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv4i8_nxv4i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i8> @llvm.riscv.vslide1down.nxv4i8.i8(
    <vscale x 4 x i8> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 4 x i8> %a
}

declare <vscale x 4 x i8> @llvm.riscv.vslide1down.mask.nxv4i8.i8(
  <vscale x 4 x i8>,
  <vscale x 4 x i8>,
  i8,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i8> @intrinsic_vslide1down_mask_vx_nxv4i8_nxv4i8_i8(<vscale x 4 x i8> %0, <vscale x 4 x i8> %1, i8 %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv4i8_nxv4i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v9, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i8> @llvm.riscv.vslide1down.mask.nxv4i8.i8(
    <vscale x 4 x i8> %0,
    <vscale x 4 x i8> %1,
    i8 %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vslide1down.nxv8i8.i8(
  <vscale x 8 x i8>,
  i8,
  i32);

define <vscale x 8 x i8> @intrinsic_vslide1down_vx_nxv8i8_nxv8i8_i8(<vscale x 8 x i8> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv8i8_nxv8i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vslide1down.nxv8i8.i8(
    <vscale x 8 x i8> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vslide1down.mask.nxv8i8.i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  i8,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i8> @intrinsic_vslide1down_mask_vx_nxv8i8_nxv8i8_i8(<vscale x 8 x i8> %0, <vscale x 8 x i8> %1, i8 %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv8i8_nxv8i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v9, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vslide1down.mask.nxv8i8.i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8> %1,
    i8 %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 16 x i8> @llvm.riscv.vslide1down.nxv16i8.i8(
  <vscale x 16 x i8>,
  i8,
  i32);

define <vscale x 16 x i8> @intrinsic_vslide1down_vx_nxv16i8_nxv16i8_i8(<vscale x 16 x i8> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv16i8_nxv16i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i8> @llvm.riscv.vslide1down.nxv16i8.i8(
    <vscale x 16 x i8> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 16 x i8> %a
}

declare <vscale x 16 x i8> @llvm.riscv.vslide1down.mask.nxv16i8.i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>,
  i8,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i8> @intrinsic_vslide1down_mask_vx_nxv16i8_nxv16i8_i8(<vscale x 16 x i8> %0, <vscale x 16 x i8> %1, i8 %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv16i8_nxv16i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v10, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i8> @llvm.riscv.vslide1down.mask.nxv16i8.i8(
    <vscale x 16 x i8> %0,
    <vscale x 16 x i8> %1,
    i8 %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x i8> %a
}

declare <vscale x 32 x i8> @llvm.riscv.vslide1down.nxv32i8.i8(
  <vscale x 32 x i8>,
  i8,
  i32);

define <vscale x 32 x i8> @intrinsic_vslide1down_vx_nxv32i8_nxv32i8_i8(<vscale x 32 x i8> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv32i8_nxv32i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i8> @llvm.riscv.vslide1down.nxv32i8.i8(
    <vscale x 32 x i8> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 32 x i8> %a
}

declare <vscale x 32 x i8> @llvm.riscv.vslide1down.mask.nxv32i8.i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>,
  i8,
  <vscale x 32 x i1>,
  i32);

define <vscale x 32 x i8> @intrinsic_vslide1down_mask_vx_nxv32i8_nxv32i8_i8(<vscale x 32 x i8> %0, <vscale x 32 x i8> %1, i8 %2, <vscale x 32 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv32i8_nxv32i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v12, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i8> @llvm.riscv.vslide1down.mask.nxv32i8.i8(
    <vscale x 32 x i8> %0,
    <vscale x 32 x i8> %1,
    i8 %2,
    <vscale x 32 x i1> %3,
    i32 %4)

  ret <vscale x 32 x i8> %a
}

declare <vscale x 64 x i8> @llvm.riscv.vslide1down.nxv64i8.i8(
  <vscale x 64 x i8>,
  i8,
  i32);

define <vscale x 64 x i8> @intrinsic_vslide1down_vx_nxv64i8_nxv64i8_i8(<vscale x 64 x i8> %0, i8 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv64i8_nxv64i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 64 x i8> @llvm.riscv.vslide1down.nxv64i8.i8(
    <vscale x 64 x i8> %0,
    i8 %1,
    i32 %2)

  ret <vscale x 64 x i8> %a
}

declare <vscale x 64 x i8> @llvm.riscv.vslide1down.mask.nxv64i8.i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>,
  i8,
  <vscale x 64 x i1>,
  i32);

define <vscale x 64 x i8> @intrinsic_vslide1down_mask_vx_nxv64i8_nxv64i8_i8(<vscale x 64 x i8> %0, <vscale x 64 x i8> %1, i8 %2, <vscale x 64 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv64i8_nxv64i8_i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v16, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 64 x i8> @llvm.riscv.vslide1down.mask.nxv64i8.i8(
    <vscale x 64 x i8> %0,
    <vscale x 64 x i8> %1,
    i8 %2,
    <vscale x 64 x i1> %3,
    i32 %4)

  ret <vscale x 64 x i8> %a
}

declare <vscale x 1 x i16> @llvm.riscv.vslide1down.nxv1i16.i16(
  <vscale x 1 x i16>,
  i16,
  i32);

define <vscale x 1 x i16> @intrinsic_vslide1down_vx_nxv1i16_nxv1i16_i16(<vscale x 1 x i16> %0, i16 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv1i16_nxv1i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, mf4, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i16> @llvm.riscv.vslide1down.nxv1i16.i16(
    <vscale x 1 x i16> %0,
    i16 %1,
    i32 %2)

  ret <vscale x 1 x i16> %a
}

declare <vscale x 1 x i16> @llvm.riscv.vslide1down.mask.nxv1i16.i16(
  <vscale x 1 x i16>,
  <vscale x 1 x i16>,
  i16,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i16> @intrinsic_vslide1down_mask_vx_nxv1i16_nxv1i16_i16(<vscale x 1 x i16> %0, <vscale x 1 x i16> %1, i16 %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv1i16_nxv1i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, mf4, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v9, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i16> @llvm.riscv.vslide1down.mask.nxv1i16.i16(
    <vscale x 1 x i16> %0,
    <vscale x 1 x i16> %1,
    i16 %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x i16> %a
}

declare <vscale x 2 x i16> @llvm.riscv.vslide1down.nxv2i16.i16(
  <vscale x 2 x i16>,
  i16,
  i32);

define <vscale x 2 x i16> @intrinsic_vslide1down_vx_nxv2i16_nxv2i16_i16(<vscale x 2 x i16> %0, i16 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv2i16_nxv2i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, mf2, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i16> @llvm.riscv.vslide1down.nxv2i16.i16(
    <vscale x 2 x i16> %0,
    i16 %1,
    i32 %2)

  ret <vscale x 2 x i16> %a
}

declare <vscale x 2 x i16> @llvm.riscv.vslide1down.mask.nxv2i16.i16(
  <vscale x 2 x i16>,
  <vscale x 2 x i16>,
  i16,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i16> @intrinsic_vslide1down_mask_vx_nxv2i16_nxv2i16_i16(<vscale x 2 x i16> %0, <vscale x 2 x i16> %1, i16 %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv2i16_nxv2i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, mf2, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v9, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i16> @llvm.riscv.vslide1down.mask.nxv2i16.i16(
    <vscale x 2 x i16> %0,
    <vscale x 2 x i16> %1,
    i16 %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vslide1down.nxv4i16.i16(
  <vscale x 4 x i16>,
  i16,
  i32);

define <vscale x 4 x i16> @intrinsic_vslide1down_vx_nxv4i16_nxv4i16_i16(<vscale x 4 x i16> %0, i16 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv4i16_nxv4i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vslide1down.nxv4i16.i16(
    <vscale x 4 x i16> %0,
    i16 %1,
    i32 %2)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vslide1down.mask.nxv4i16.i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>,
  i16,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i16> @intrinsic_vslide1down_mask_vx_nxv4i16_nxv4i16_i16(<vscale x 4 x i16> %0, <vscale x 4 x i16> %1, i16 %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv4i16_nxv4i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v9, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vslide1down.mask.nxv4i16.i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16> %1,
    i16 %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.vslide1down.nxv8i16.i16(
  <vscale x 8 x i16>,
  i16,
  i32);

define <vscale x 8 x i16> @intrinsic_vslide1down_vx_nxv8i16_nxv8i16_i16(<vscale x 8 x i16> %0, i16 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv8i16_nxv8i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.vslide1down.nxv8i16.i16(
    <vscale x 8 x i16> %0,
    i16 %1,
    i32 %2)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.vslide1down.mask.nxv8i16.i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>,
  i16,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i16> @intrinsic_vslide1down_mask_vx_nxv8i16_nxv8i16_i16(<vscale x 8 x i16> %0, <vscale x 8 x i16> %1, i16 %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv8i16_nxv8i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v10, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.vslide1down.mask.nxv8i16.i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16> %1,
    i16 %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.vslide1down.nxv16i16.i16(
  <vscale x 16 x i16>,
  i16,
  i32);

define <vscale x 16 x i16> @intrinsic_vslide1down_vx_nxv16i16_nxv16i16_i16(<vscale x 16 x i16> %0, i16 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv16i16_nxv16i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.vslide1down.nxv16i16.i16(
    <vscale x 16 x i16> %0,
    i16 %1,
    i32 %2)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.vslide1down.mask.nxv16i16.i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>,
  i16,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i16> @intrinsic_vslide1down_mask_vx_nxv16i16_nxv16i16_i16(<vscale x 16 x i16> %0, <vscale x 16 x i16> %1, i16 %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv16i16_nxv16i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v12, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.vslide1down.mask.nxv16i16.i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16> %1,
    i16 %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.vslide1down.nxv32i16.i16(
  <vscale x 32 x i16>,
  i16,
  i32);

define <vscale x 32 x i16> @intrinsic_vslide1down_vx_nxv32i16_nxv32i16_i16(<vscale x 32 x i16> %0, i16 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv32i16_nxv32i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.vslide1down.nxv32i16.i16(
    <vscale x 32 x i16> %0,
    i16 %1,
    i32 %2)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.vslide1down.mask.nxv32i16.i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>,
  i16,
  <vscale x 32 x i1>,
  i32);

define <vscale x 32 x i16> @intrinsic_vslide1down_mask_vx_nxv32i16_nxv32i16_i16(<vscale x 32 x i16> %0, <vscale x 32 x i16> %1, i16 %2, <vscale x 32 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv32i16_nxv32i16_i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v16, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.vslide1down.mask.nxv32i16.i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16> %1,
    i16 %2,
    <vscale x 32 x i1> %3,
    i32 %4)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vslide1down.nxv1i32.i32(
  <vscale x 1 x i32>,
  i32,
  i32);

define <vscale x 1 x i32> @intrinsic_vslide1down_vx_nxv1i32_nxv1i32_i32(<vscale x 1 x i32> %0, i32 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv1i32_nxv1i32_i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vslide1down.nxv1i32.i32(
    <vscale x 1 x i32> %0,
    i32 %1,
    i32 %2)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vslide1down.mask.nxv1i32.i32(
  <vscale x 1 x i32>,
  <vscale x 1 x i32>,
  i32,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i32> @intrinsic_vslide1down_mask_vx_nxv1i32_nxv1i32_i32(<vscale x 1 x i32> %0, <vscale x 1 x i32> %1, i32 %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv1i32_nxv1i32_i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v9, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vslide1down.mask.nxv1i32.i32(
    <vscale x 1 x i32> %0,
    <vscale x 1 x i32> %1,
    i32 %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vslide1down.nxv2i32.i32(
  <vscale x 2 x i32>,
  i32,
  i32);

define <vscale x 2 x i32> @intrinsic_vslide1down_vx_nxv2i32_nxv2i32_i32(<vscale x 2 x i32> %0, i32 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv2i32_nxv2i32_i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vslide1down.nxv2i32.i32(
    <vscale x 2 x i32> %0,
    i32 %1,
    i32 %2)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vslide1down.mask.nxv2i32.i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  i32,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i32> @intrinsic_vslide1down_mask_vx_nxv2i32_nxv2i32_i32(<vscale x 2 x i32> %0, <vscale x 2 x i32> %1, i32 %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv2i32_nxv2i32_i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v9, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vslide1down.mask.nxv2i32.i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32> %1,
    i32 %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vslide1down.nxv4i32.i32(
  <vscale x 4 x i32>,
  i32,
  i32);

define <vscale x 4 x i32> @intrinsic_vslide1down_vx_nxv4i32_nxv4i32_i32(<vscale x 4 x i32> %0, i32 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv4i32_nxv4i32_i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vslide1down.nxv4i32.i32(
    <vscale x 4 x i32> %0,
    i32 %1,
    i32 %2)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vslide1down.mask.nxv4i32.i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>,
  i32,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i32> @intrinsic_vslide1down_mask_vx_nxv4i32_nxv4i32_i32(<vscale x 4 x i32> %0, <vscale x 4 x i32> %1, i32 %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv4i32_nxv4i32_i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v10, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vslide1down.mask.nxv4i32.i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32> %1,
    i32 %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vslide1down.nxv8i32.i32(
  <vscale x 8 x i32>,
  i32,
  i32);

define <vscale x 8 x i32> @intrinsic_vslide1down_vx_nxv8i32_nxv8i32_i32(<vscale x 8 x i32> %0, i32 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv8i32_nxv8i32_i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vslide1down.nxv8i32.i32(
    <vscale x 8 x i32> %0,
    i32 %1,
    i32 %2)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vslide1down.mask.nxv8i32.i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>,
  i32,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i32> @intrinsic_vslide1down_mask_vx_nxv8i32_nxv8i32_i32(<vscale x 8 x i32> %0, <vscale x 8 x i32> %1, i32 %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv8i32_nxv8i32_i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v12, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vslide1down.mask.nxv8i32.i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32> %1,
    i32 %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vslide1down.nxv16i32.i32(
  <vscale x 16 x i32>,
  i32,
  i32);

define <vscale x 16 x i32> @intrinsic_vslide1down_vx_nxv16i32_nxv16i32_i32(<vscale x 16 x i32> %0, i32 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv16i32_nxv16i32_i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vslide1down.nxv16i32.i32(
    <vscale x 16 x i32> %0,
    i32 %1,
    i32 %2)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vslide1down.mask.nxv16i32.i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>,
  i32,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i32> @intrinsic_vslide1down_mask_vx_nxv16i32_nxv16i32_i32(<vscale x 16 x i32> %0, <vscale x 16 x i32> %1, i32 %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv16i32_nxv16i32_i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, tu, mu
; CHECK-NEXT:    vslide1down.vx v8, v16, a0, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vslide1down.mask.nxv16i32.i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32> %1,
    i32 %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vslide1down.nxv1i64.i64(
  <vscale x 1 x i64>,
  i64,
  i32);

define <vscale x 1 x i64> @intrinsic_vslide1down_vx_nxv1i64_nxv1i64_i64(<vscale x 1 x i64> %0, i64 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv1i64_nxv1i64_i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, ta, mu
; CHECK-NEXT:    vslide1down.vx v25, v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v25, a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vslide1down.nxv1i64.i64(
    <vscale x 1 x i64> %0,
    i64 %1,
    i32 %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vslide1down.mask.nxv1i64.i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>,
  i64,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i64> @intrinsic_vslide1down_mask_vx_nxv1i64_nxv1i64_i64(<vscale x 1 x i64> %0, <vscale x 1 x i64> %1, i64 %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv1i64_nxv1i64_i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    slli a3, a2, 1
; CHECK-NEXT:    vsetvli zero, a3, e32, m1, ta, mu
; CHECK-NEXT:    vslide1down.vx v25, v9, a0
; CHECK-NEXT:    vslide1down.vx v25, v25, a1
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, ta, mu
; CHECK-NEXT:    vmerge.vvm v8, v8, v25, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vslide1down.mask.nxv1i64.i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64> %1,
    i64 %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.vslide1down.nxv2i64.i64(
  <vscale x 2 x i64>,
  i64,
  i32);

define <vscale x 2 x i64> @intrinsic_vslide1down_vx_nxv2i64_nxv2i64_i64(<vscale x 2 x i64> %0, i64 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv2i64_nxv2i64_i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, ta, mu
; CHECK-NEXT:    vslide1down.vx v26, v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v26, a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.vslide1down.nxv2i64.i64(
    <vscale x 2 x i64> %0,
    i64 %1,
    i32 %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.vslide1down.mask.nxv2i64.i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>,
  i64,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i64> @intrinsic_vslide1down_mask_vx_nxv2i64_nxv2i64_i64(<vscale x 2 x i64> %0, <vscale x 2 x i64> %1, i64 %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv2i64_nxv2i64_i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    slli a3, a2, 1
; CHECK-NEXT:    vsetvli zero, a3, e32, m2, ta, mu
; CHECK-NEXT:    vslide1down.vx v26, v10, a0
; CHECK-NEXT:    vslide1down.vx v26, v26, a1
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, ta, mu
; CHECK-NEXT:    vmerge.vvm v8, v8, v26, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.vslide1down.mask.nxv2i64.i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64> %1,
    i64 %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.vslide1down.nxv4i64.i64(
  <vscale x 4 x i64>,
  i64,
  i32);

define <vscale x 4 x i64> @intrinsic_vslide1down_vx_nxv4i64_nxv4i64_i64(<vscale x 4 x i64> %0, i64 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv4i64_nxv4i64_i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, ta, mu
; CHECK-NEXT:    vslide1down.vx v28, v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v28, a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.vslide1down.nxv4i64.i64(
    <vscale x 4 x i64> %0,
    i64 %1,
    i32 %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.vslide1down.mask.nxv4i64.i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>,
  i64,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i64> @intrinsic_vslide1down_mask_vx_nxv4i64_nxv4i64_i64(<vscale x 4 x i64> %0, <vscale x 4 x i64> %1, i64 %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv4i64_nxv4i64_i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    slli a3, a2, 1
; CHECK-NEXT:    vsetvli zero, a3, e32, m4, ta, mu
; CHECK-NEXT:    vslide1down.vx v28, v12, a0
; CHECK-NEXT:    vslide1down.vx v28, v28, a1
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, ta, mu
; CHECK-NEXT:    vmerge.vvm v8, v8, v28, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.vslide1down.mask.nxv4i64.i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64> %1,
    i64 %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.vslide1down.nxv8i64.i64(
  <vscale x 8 x i64>,
  i64,
  i32);

define <vscale x 8 x i64> @intrinsic_vslide1down_vx_nxv8i64_nxv8i64_i64(<vscale x 8 x i64> %0, i64 %1, i32 %2) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_vx_nxv8i64_nxv8i64_i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, ta, mu
; CHECK-NEXT:    vslide1down.vx v8, v8, a0
; CHECK-NEXT:    vslide1down.vx v8, v8, a1
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.vslide1down.nxv8i64.i64(
    <vscale x 8 x i64> %0,
    i64 %1,
    i32 %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.vslide1down.mask.nxv8i64.i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>,
  i64,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i64> @intrinsic_vslide1down_mask_vx_nxv8i64_nxv8i64_i64(<vscale x 8 x i64> %0, <vscale x 8 x i64> %1, i64 %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vslide1down_mask_vx_nxv8i64_nxv8i64_i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    slli a3, a2, 1
; CHECK-NEXT:    vsetvli zero, a3, e32, m8, ta, mu
; CHECK-NEXT:    vslide1down.vx v16, v16, a0
; CHECK-NEXT:    vslide1down.vx v16, v16, a1
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, mu
; CHECK-NEXT:    vmerge.vvm v8, v8, v16, v0
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.vslide1down.mask.nxv8i64.i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64> %1,
    i64 %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x i64> %a
}
