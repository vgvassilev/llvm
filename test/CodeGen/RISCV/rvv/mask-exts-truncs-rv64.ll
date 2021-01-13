; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -verify-machineinstrs < %s | FileCheck %s

define <vscale x 1 x i8> @sext_nxv1i1_nxv1i8(<vscale x 1 x i1> %v) {
; CHECK-LABEL: sext_nxv1i1_nxv1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 1 x i1> %v to <vscale x 1 x i8>
  ret <vscale x 1 x i8> %r
}

define <vscale x 1 x i8> @zext_nxv1i1_nxv1i8(<vscale x 1 x i1> %v) {
; CHECK-LABEL: zext_nxv1i1_nxv1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 1 x i1> %v to <vscale x 1 x i8>
  ret <vscale x 1 x i8> %r
}

define <vscale x 1 x i1> @trunc_nxv1i8_nxv1i1(<vscale x 1 x i8> %v) {
; CHECK-LABEL: trunc_nxv1i8_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf8,ta,mu
; CHECK-NEXT:    vand.vi v25, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 1 x i8> %v to <vscale x 1 x i1>
  ret <vscale x 1 x i1> %r
}

define <vscale x 2 x i8> @sext_nxv2i1_nxv2i8(<vscale x 2 x i1> %v) {
; CHECK-LABEL: sext_nxv2i1_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf4,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 2 x i1> %v to <vscale x 2 x i8>
  ret <vscale x 2 x i8> %r
}

define <vscale x 2 x i8> @zext_nxv2i1_nxv2i8(<vscale x 2 x i1> %v) {
; CHECK-LABEL: zext_nxv2i1_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf4,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 2 x i1> %v to <vscale x 2 x i8>
  ret <vscale x 2 x i8> %r
}

define <vscale x 2 x i1> @trunc_nxv2i8_nxv2i1(<vscale x 2 x i8> %v) {
; CHECK-LABEL: trunc_nxv2i8_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf4,ta,mu
; CHECK-NEXT:    vand.vi v25, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 2 x i8> %v to <vscale x 2 x i1>
  ret <vscale x 2 x i1> %r
}

define <vscale x 4 x i8> @sext_nxv4i1_nxv4i8(<vscale x 4 x i1> %v) {
; CHECK-LABEL: sext_nxv4i1_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf2,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 4 x i1> %v to <vscale x 4 x i8>
  ret <vscale x 4 x i8> %r
}

define <vscale x 4 x i8> @zext_nxv4i1_nxv4i8(<vscale x 4 x i1> %v) {
; CHECK-LABEL: zext_nxv4i1_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf2,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 4 x i1> %v to <vscale x 4 x i8>
  ret <vscale x 4 x i8> %r
}

define <vscale x 4 x i1> @trunc_nxv4i8_nxv4i1(<vscale x 4 x i8> %v) {
; CHECK-LABEL: trunc_nxv4i8_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf2,ta,mu
; CHECK-NEXT:    vand.vi v25, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 4 x i8> %v to <vscale x 4 x i1>
  ret <vscale x 4 x i1> %r
}

define <vscale x 8 x i8> @sext_nxv8i1_nxv8i8(<vscale x 8 x i1> %v) {
; CHECK-LABEL: sext_nxv8i1_nxv8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m1,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 8 x i1> %v to <vscale x 8 x i8>
  ret <vscale x 8 x i8> %r
}

define <vscale x 8 x i8> @zext_nxv8i1_nxv8i8(<vscale x 8 x i1> %v) {
; CHECK-LABEL: zext_nxv8i1_nxv8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m1,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 8 x i1> %v to <vscale x 8 x i8>
  ret <vscale x 8 x i8> %r
}

define <vscale x 8 x i1> @trunc_nxv8i8_nxv8i1(<vscale x 8 x i8> %v) {
; CHECK-LABEL: trunc_nxv8i8_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m1,ta,mu
; CHECK-NEXT:    vand.vi v25, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 8 x i8> %v to <vscale x 8 x i1>
  ret <vscale x 8 x i1> %r
}

define <vscale x 16 x i8> @sext_nxv16i1_nxv16i8(<vscale x 16 x i1> %v) {
; CHECK-LABEL: sext_nxv16i1_nxv16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m2,ta,mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v16, v26, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 16 x i1> %v to <vscale x 16 x i8>
  ret <vscale x 16 x i8> %r
}

define <vscale x 16 x i8> @zext_nxv16i1_nxv16i8(<vscale x 16 x i1> %v) {
; CHECK-LABEL: zext_nxv16i1_nxv16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m2,ta,mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v16, v26, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 16 x i1> %v to <vscale x 16 x i8>
  ret <vscale x 16 x i8> %r
}

define <vscale x 16 x i1> @trunc_nxv16i8_nxv16i1(<vscale x 16 x i8> %v) {
; CHECK-LABEL: trunc_nxv16i8_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m2,ta,mu
; CHECK-NEXT:    vand.vi v26, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v26, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 16 x i8> %v to <vscale x 16 x i1>
  ret <vscale x 16 x i1> %r
}

define <vscale x 32 x i8> @sext_nxv32i1_nxv32i8(<vscale x 32 x i1> %v) {
; CHECK-LABEL: sext_nxv32i1_nxv32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m4,ta,mu
; CHECK-NEXT:    vmv.v.i v28, 0
; CHECK-NEXT:    vmerge.vim v16, v28, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 32 x i1> %v to <vscale x 32 x i8>
  ret <vscale x 32 x i8> %r
}

define <vscale x 32 x i8> @zext_nxv32i1_nxv32i8(<vscale x 32 x i1> %v) {
; CHECK-LABEL: zext_nxv32i1_nxv32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m4,ta,mu
; CHECK-NEXT:    vmv.v.i v28, 0
; CHECK-NEXT:    vmerge.vim v16, v28, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 32 x i1> %v to <vscale x 32 x i8>
  ret <vscale x 32 x i8> %r
}

define <vscale x 32 x i1> @trunc_nxv32i8_nxv32i1(<vscale x 32 x i8> %v) {
; CHECK-LABEL: trunc_nxv32i8_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m4,ta,mu
; CHECK-NEXT:    vand.vi v28, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v28, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 32 x i8> %v to <vscale x 32 x i1>
  ret <vscale x 32 x i1> %r
}

define <vscale x 64 x i8> @sext_nxv64i1_nxv64i8(<vscale x 64 x i1> %v) {
; CHECK-LABEL: sext_nxv64i1_nxv64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m8,ta,mu
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v16, v8, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 64 x i1> %v to <vscale x 64 x i8>
  ret <vscale x 64 x i8> %r
}

define <vscale x 64 x i8> @zext_nxv64i1_nxv64i8(<vscale x 64 x i1> %v) {
; CHECK-LABEL: zext_nxv64i1_nxv64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m8,ta,mu
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v16, v8, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 64 x i1> %v to <vscale x 64 x i8>
  ret <vscale x 64 x i8> %r
}

define <vscale x 64 x i1> @trunc_nxv64i8_nxv64i1(<vscale x 64 x i8> %v) {
; CHECK-LABEL: trunc_nxv64i8_nxv64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m8,ta,mu
; CHECK-NEXT:    vand.vi v8, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 64 x i8> %v to <vscale x 64 x i1>
  ret <vscale x 64 x i1> %r
}

define <vscale x 1 x i16> @sext_nxv1i1_nxv1i16(<vscale x 1 x i1> %v) {
; CHECK-LABEL: sext_nxv1i1_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,mf4,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 1 x i1> %v to <vscale x 1 x i16>
  ret <vscale x 1 x i16> %r
}

define <vscale x 1 x i16> @zext_nxv1i1_nxv1i16(<vscale x 1 x i1> %v) {
; CHECK-LABEL: zext_nxv1i1_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,mf4,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 1 x i1> %v to <vscale x 1 x i16>
  ret <vscale x 1 x i16> %r
}

define <vscale x 1 x i1> @trunc_nxv1i16_nxv1i1(<vscale x 1 x i16> %v) {
; CHECK-LABEL: trunc_nxv1i16_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,mf4,ta,mu
; CHECK-NEXT:    vand.vi v25, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 1 x i16> %v to <vscale x 1 x i1>
  ret <vscale x 1 x i1> %r
}

define <vscale x 2 x i16> @sext_nxv2i1_nxv2i16(<vscale x 2 x i1> %v) {
; CHECK-LABEL: sext_nxv2i1_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,mf2,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 2 x i1> %v to <vscale x 2 x i16>
  ret <vscale x 2 x i16> %r
}

define <vscale x 2 x i16> @zext_nxv2i1_nxv2i16(<vscale x 2 x i1> %v) {
; CHECK-LABEL: zext_nxv2i1_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,mf2,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 2 x i1> %v to <vscale x 2 x i16>
  ret <vscale x 2 x i16> %r
}

define <vscale x 2 x i1> @trunc_nxv2i16_nxv2i1(<vscale x 2 x i16> %v) {
; CHECK-LABEL: trunc_nxv2i16_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,mf2,ta,mu
; CHECK-NEXT:    vand.vi v25, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 2 x i16> %v to <vscale x 2 x i1>
  ret <vscale x 2 x i1> %r
}

define <vscale x 4 x i16> @sext_nxv4i1_nxv4i16(<vscale x 4 x i1> %v) {
; CHECK-LABEL: sext_nxv4i1_nxv4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m1,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 4 x i1> %v to <vscale x 4 x i16>
  ret <vscale x 4 x i16> %r
}

define <vscale x 4 x i16> @zext_nxv4i1_nxv4i16(<vscale x 4 x i1> %v) {
; CHECK-LABEL: zext_nxv4i1_nxv4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m1,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 4 x i1> %v to <vscale x 4 x i16>
  ret <vscale x 4 x i16> %r
}

define <vscale x 4 x i1> @trunc_nxv4i16_nxv4i1(<vscale x 4 x i16> %v) {
; CHECK-LABEL: trunc_nxv4i16_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m1,ta,mu
; CHECK-NEXT:    vand.vi v25, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 4 x i16> %v to <vscale x 4 x i1>
  ret <vscale x 4 x i1> %r
}

define <vscale x 8 x i16> @sext_nxv8i1_nxv8i16(<vscale x 8 x i1> %v) {
; CHECK-LABEL: sext_nxv8i1_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m2,ta,mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v16, v26, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 8 x i1> %v to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %r
}

define <vscale x 8 x i16> @zext_nxv8i1_nxv8i16(<vscale x 8 x i1> %v) {
; CHECK-LABEL: zext_nxv8i1_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m2,ta,mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v16, v26, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 8 x i1> %v to <vscale x 8 x i16>
  ret <vscale x 8 x i16> %r
}

define <vscale x 8 x i1> @trunc_nxv8i16_nxv8i1(<vscale x 8 x i16> %v) {
; CHECK-LABEL: trunc_nxv8i16_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m2,ta,mu
; CHECK-NEXT:    vand.vi v26, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v26, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 8 x i16> %v to <vscale x 8 x i1>
  ret <vscale x 8 x i1> %r
}

define <vscale x 16 x i16> @sext_nxv16i1_nxv16i16(<vscale x 16 x i1> %v) {
; CHECK-LABEL: sext_nxv16i1_nxv16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m4,ta,mu
; CHECK-NEXT:    vmv.v.i v28, 0
; CHECK-NEXT:    vmerge.vim v16, v28, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 16 x i1> %v to <vscale x 16 x i16>
  ret <vscale x 16 x i16> %r
}

define <vscale x 16 x i16> @zext_nxv16i1_nxv16i16(<vscale x 16 x i1> %v) {
; CHECK-LABEL: zext_nxv16i1_nxv16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m4,ta,mu
; CHECK-NEXT:    vmv.v.i v28, 0
; CHECK-NEXT:    vmerge.vim v16, v28, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 16 x i1> %v to <vscale x 16 x i16>
  ret <vscale x 16 x i16> %r
}

define <vscale x 16 x i1> @trunc_nxv16i16_nxv16i1(<vscale x 16 x i16> %v) {
; CHECK-LABEL: trunc_nxv16i16_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m4,ta,mu
; CHECK-NEXT:    vand.vi v28, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v28, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 16 x i16> %v to <vscale x 16 x i1>
  ret <vscale x 16 x i1> %r
}

define <vscale x 32 x i16> @sext_nxv32i1_nxv32i16(<vscale x 32 x i1> %v) {
; CHECK-LABEL: sext_nxv32i1_nxv32i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m8,ta,mu
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v16, v8, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 32 x i1> %v to <vscale x 32 x i16>
  ret <vscale x 32 x i16> %r
}

define <vscale x 32 x i16> @zext_nxv32i1_nxv32i16(<vscale x 32 x i1> %v) {
; CHECK-LABEL: zext_nxv32i1_nxv32i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m8,ta,mu
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v16, v8, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 32 x i1> %v to <vscale x 32 x i16>
  ret <vscale x 32 x i16> %r
}

define <vscale x 32 x i1> @trunc_nxv32i16_nxv32i1(<vscale x 32 x i16> %v) {
; CHECK-LABEL: trunc_nxv32i16_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16,m8,ta,mu
; CHECK-NEXT:    vand.vi v8, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 32 x i16> %v to <vscale x 32 x i1>
  ret <vscale x 32 x i1> %r
}

define <vscale x 1 x i32> @sext_nxv1i1_nxv1i32(<vscale x 1 x i1> %v) {
; CHECK-LABEL: sext_nxv1i1_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,mf2,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 1 x i1> %v to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %r
}

define <vscale x 1 x i32> @zext_nxv1i1_nxv1i32(<vscale x 1 x i1> %v) {
; CHECK-LABEL: zext_nxv1i1_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,mf2,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 1 x i1> %v to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %r
}

define <vscale x 1 x i1> @trunc_nxv1i32_nxv1i1(<vscale x 1 x i32> %v) {
; CHECK-LABEL: trunc_nxv1i32_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,mf2,ta,mu
; CHECK-NEXT:    vand.vi v25, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 1 x i32> %v to <vscale x 1 x i1>
  ret <vscale x 1 x i1> %r
}

define <vscale x 2 x i32> @sext_nxv2i1_nxv2i32(<vscale x 2 x i1> %v) {
; CHECK-LABEL: sext_nxv2i1_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m1,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 2 x i1> %v to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %r
}

define <vscale x 2 x i32> @zext_nxv2i1_nxv2i32(<vscale x 2 x i1> %v) {
; CHECK-LABEL: zext_nxv2i1_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m1,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 2 x i1> %v to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %r
}

define <vscale x 2 x i1> @trunc_nxv2i32_nxv2i1(<vscale x 2 x i32> %v) {
; CHECK-LABEL: trunc_nxv2i32_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m1,ta,mu
; CHECK-NEXT:    vand.vi v25, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 2 x i32> %v to <vscale x 2 x i1>
  ret <vscale x 2 x i1> %r
}

define <vscale x 4 x i32> @sext_nxv4i1_nxv4i32(<vscale x 4 x i1> %v) {
; CHECK-LABEL: sext_nxv4i1_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m2,ta,mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v16, v26, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 4 x i1> %v to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i32> @zext_nxv4i1_nxv4i32(<vscale x 4 x i1> %v) {
; CHECK-LABEL: zext_nxv4i1_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m2,ta,mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v16, v26, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 4 x i1> %v to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %r
}

define <vscale x 4 x i1> @trunc_nxv4i32_nxv4i1(<vscale x 4 x i32> %v) {
; CHECK-LABEL: trunc_nxv4i32_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m2,ta,mu
; CHECK-NEXT:    vand.vi v26, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v26, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 4 x i32> %v to <vscale x 4 x i1>
  ret <vscale x 4 x i1> %r
}

define <vscale x 8 x i32> @sext_nxv8i1_nxv8i32(<vscale x 8 x i1> %v) {
; CHECK-LABEL: sext_nxv8i1_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m4,ta,mu
; CHECK-NEXT:    vmv.v.i v28, 0
; CHECK-NEXT:    vmerge.vim v16, v28, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 8 x i1> %v to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %r
}

define <vscale x 8 x i32> @zext_nxv8i1_nxv8i32(<vscale x 8 x i1> %v) {
; CHECK-LABEL: zext_nxv8i1_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m4,ta,mu
; CHECK-NEXT:    vmv.v.i v28, 0
; CHECK-NEXT:    vmerge.vim v16, v28, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 8 x i1> %v to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %r
}

define <vscale x 8 x i1> @trunc_nxv8i32_nxv8i1(<vscale x 8 x i32> %v) {
; CHECK-LABEL: trunc_nxv8i32_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m4,ta,mu
; CHECK-NEXT:    vand.vi v28, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v28, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 8 x i32> %v to <vscale x 8 x i1>
  ret <vscale x 8 x i1> %r
}

define <vscale x 16 x i32> @sext_nxv16i1_nxv16i32(<vscale x 16 x i1> %v) {
; CHECK-LABEL: sext_nxv16i1_nxv16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m8,ta,mu
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v16, v8, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 16 x i1> %v to <vscale x 16 x i32>
  ret <vscale x 16 x i32> %r
}

define <vscale x 16 x i32> @zext_nxv16i1_nxv16i32(<vscale x 16 x i1> %v) {
; CHECK-LABEL: zext_nxv16i1_nxv16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m8,ta,mu
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v16, v8, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 16 x i1> %v to <vscale x 16 x i32>
  ret <vscale x 16 x i32> %r
}

define <vscale x 16 x i1> @trunc_nxv16i32_nxv16i1(<vscale x 16 x i32> %v) {
; CHECK-LABEL: trunc_nxv16i32_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32,m8,ta,mu
; CHECK-NEXT:    vand.vi v8, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 16 x i32> %v to <vscale x 16 x i1>
  ret <vscale x 16 x i1> %r
}

define <vscale x 1 x i64> @sext_nxv1i1_nxv1i64(<vscale x 1 x i1> %v) {
; CHECK-LABEL: sext_nxv1i1_nxv1i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m1,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 1 x i1> %v to <vscale x 1 x i64>
  ret <vscale x 1 x i64> %r
}

define <vscale x 1 x i64> @zext_nxv1i1_nxv1i64(<vscale x 1 x i1> %v) {
; CHECK-LABEL: zext_nxv1i1_nxv1i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m1,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v16, v25, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 1 x i1> %v to <vscale x 1 x i64>
  ret <vscale x 1 x i64> %r
}

define <vscale x 1 x i1> @trunc_nxv1i64_nxv1i1(<vscale x 1 x i64> %v) {
; CHECK-LABEL: trunc_nxv1i64_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m1,ta,mu
; CHECK-NEXT:    vand.vi v25, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 1 x i64> %v to <vscale x 1 x i1>
  ret <vscale x 1 x i1> %r
}

define <vscale x 2 x i64> @sext_nxv2i1_nxv2i64(<vscale x 2 x i1> %v) {
; CHECK-LABEL: sext_nxv2i1_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m2,ta,mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v16, v26, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 2 x i1> %v to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i64> @zext_nxv2i1_nxv2i64(<vscale x 2 x i1> %v) {
; CHECK-LABEL: zext_nxv2i1_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m2,ta,mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v16, v26, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 2 x i1> %v to <vscale x 2 x i64>
  ret <vscale x 2 x i64> %r
}

define <vscale x 2 x i1> @trunc_nxv2i64_nxv2i1(<vscale x 2 x i64> %v) {
; CHECK-LABEL: trunc_nxv2i64_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m2,ta,mu
; CHECK-NEXT:    vand.vi v26, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v26, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 2 x i64> %v to <vscale x 2 x i1>
  ret <vscale x 2 x i1> %r
}

define <vscale x 4 x i64> @sext_nxv4i1_nxv4i64(<vscale x 4 x i1> %v) {
; CHECK-LABEL: sext_nxv4i1_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m4,ta,mu
; CHECK-NEXT:    vmv.v.i v28, 0
; CHECK-NEXT:    vmerge.vim v16, v28, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 4 x i1> %v to <vscale x 4 x i64>
  ret <vscale x 4 x i64> %r
}

define <vscale x 4 x i64> @zext_nxv4i1_nxv4i64(<vscale x 4 x i1> %v) {
; CHECK-LABEL: zext_nxv4i1_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m4,ta,mu
; CHECK-NEXT:    vmv.v.i v28, 0
; CHECK-NEXT:    vmerge.vim v16, v28, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 4 x i1> %v to <vscale x 4 x i64>
  ret <vscale x 4 x i64> %r
}

define <vscale x 4 x i1> @trunc_nxv4i64_nxv4i1(<vscale x 4 x i64> %v) {
; CHECK-LABEL: trunc_nxv4i64_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m4,ta,mu
; CHECK-NEXT:    vand.vi v28, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v28, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 4 x i64> %v to <vscale x 4 x i1>
  ret <vscale x 4 x i1> %r
}

define <vscale x 8 x i64> @sext_nxv8i1_nxv8i64(<vscale x 8 x i1> %v) {
; CHECK-LABEL: sext_nxv8i1_nxv8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m8,ta,mu
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v16, v8, -1, v0
; CHECK-NEXT:    ret
  %r = sext <vscale x 8 x i1> %v to <vscale x 8 x i64>
  ret <vscale x 8 x i64> %r
}

define <vscale x 8 x i64> @zext_nxv8i1_nxv8i64(<vscale x 8 x i1> %v) {
; CHECK-LABEL: zext_nxv8i1_nxv8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m8,ta,mu
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v16, v8, 1, v0
; CHECK-NEXT:    ret
  %r = zext <vscale x 8 x i1> %v to <vscale x 8 x i64>
  ret <vscale x 8 x i64> %r
}

define <vscale x 8 x i1> @trunc_nxv8i64_nxv8i1(<vscale x 8 x i64> %v) {
; CHECK-LABEL: trunc_nxv8i64_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64,m8,ta,mu
; CHECK-NEXT:    vand.vi v8, v16, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %r = trunc <vscale x 8 x i64> %v to <vscale x 8 x i1>
  ret <vscale x 8 x i1> %r
}

