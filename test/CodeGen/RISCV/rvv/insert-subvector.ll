; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple riscv32 -mattr=+m,+d,+experimental-zfh,+experimental-v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple riscv64 -mattr=+m,+d,+experimental-zfh,+experimental-v -verify-machineinstrs < %s | FileCheck %s

define <vscale x 8 x i32> @insert_nxv8i32_nxv4i32_0(<vscale x 8 x i32> %vec, <vscale x 4 x i32> %subvec) {
; CHECK-LABEL: insert_nxv8i32_nxv4i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v8, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.experimental.vector.insert.nxv4i32.nxv8i32(<vscale x 8 x i32> %vec, <vscale x 4 x i32> %subvec, i64 0)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @insert_nxv8i32_nxv4i32_4(<vscale x 8 x i32> %vec, <vscale x 4 x i32> %subvec) {
; CHECK-LABEL: insert_nxv8i32_nxv4i32_4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v10, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.experimental.vector.insert.nxv4i32.nxv8i32(<vscale x 8 x i32> %vec, <vscale x 4 x i32> %subvec, i64 4)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @insert_nxv8i32_nxv2i32_0(<vscale x 8 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv8i32_nxv2i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v8, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv8i32(<vscale x 8 x i32> %vec, <vscale x 2 x i32> %subvec, i64 0)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @insert_nxv8i32_nxv2i32_2(<vscale x 8 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv8i32_nxv2i32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv8i32(<vscale x 8 x i32> %vec, <vscale x 2 x i32> %subvec, i64 2)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @insert_nxv8i32_nxv2i32_4(<vscale x 8 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv8i32_nxv2i32_4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v10, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv8i32(<vscale x 8 x i32> %vec, <vscale x 2 x i32> %subvec, i64 4)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @insert_nxv8i32_nxv2i32_6(<vscale x 8 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv8i32_nxv2i32_6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v11, v12
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv8i32(<vscale x 8 x i32> %vec, <vscale x 2 x i32> %subvec, i64 6)
  ret <vscale x 8 x i32> %v
}

define <vscale x 4 x i8> @insert_nxv1i8_nxv4i8_0(<vscale x 4 x i8> %vec, <vscale x 1 x i8> %subvec) {
; CHECK-LABEL: insert_nxv1i8_nxv4i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, tu, mu
; CHECK-NEXT:    vslideup.vi v8, v9, 0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i8> @llvm.experimental.vector.insert.nxv1i8.nxv4i8(<vscale x 4 x i8> %vec, <vscale x 1 x i8> %subvec, i64 0)
  ret <vscale x 4 x i8> %v
}

define <vscale x 4 x i8> @insert_nxv1i8_nxv4i8_3(<vscale x 4 x i8> %vec, <vscale x 1 x i8> %subvec) {
; CHECK-LABEL: insert_nxv1i8_nxv4i8_3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    slli a1, a0, 1
; CHECK-NEXT:    add a1, a1, a0
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, tu, mu
; CHECK-NEXT:    vslideup.vx v8, v9, a1
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i8> @llvm.experimental.vector.insert.nxv1i8.nxv4i8(<vscale x 4 x i8> %vec, <vscale x 1 x i8> %subvec, i64 3)
  ret <vscale x 4 x i8> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv8i32_0(<vscale x 16 x i32> %vec, <vscale x 8 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv8i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv4r.v v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv8i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 8 x i32> %subvec, i64 0)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv8i32_8(<vscale x 16 x i32> %vec, <vscale x 8 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv8i32_8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv4r.v v12, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv8i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 8 x i32> %subvec, i64 8)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv4i32_0(<vscale x 16 x i32> %vec, <vscale x 4 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv4i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv4i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 4 x i32> %subvec, i64 0)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv4i32_4(<vscale x 16 x i32> %vec, <vscale x 4 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv4i32_4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v10, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv4i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 4 x i32> %subvec, i64 4)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv4i32_8(<vscale x 16 x i32> %vec, <vscale x 4 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv4i32_8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v12, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv4i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 4 x i32> %subvec, i64 8)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv4i32_12(<vscale x 16 x i32> %vec, <vscale x 4 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv4i32_12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv2r.v v14, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv4i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 4 x i32> %subvec, i64 12)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv2i32_0(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv2i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec, i64 0)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv2i32_2(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv2i32_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v9, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec, i64 2)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv2i32_4(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv2i32_4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v10, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec, i64 4)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv2i32_6(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv2i32_6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v11, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec, i64 6)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv2i32_8(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv2i32_8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v12, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec, i64 8)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv2i32_10(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv2i32_10:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v13, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec, i64 10)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv2i32_12(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv2i32_12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v14, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec, i64 12)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv2i32_14(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv2i32_14:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v15, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 2 x i32> %subvec, i64 14)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv1i32_0(<vscale x 16 x i32> %vec, <vscale x 1 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv1i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, tu, mu
; CHECK-NEXT:    vslideup.vi v8, v16, 0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv1i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 1 x i32> %subvec, i64 0)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv1i32_1(<vscale x 16 x i32> %vec, <vscale x 1 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv1i32_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    add a1, a0, a0
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, tu, mu
; CHECK-NEXT:    vslideup.vx v8, v16, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv1i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 1 x i32> %subvec, i64 1)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @insert_nxv16i32_nxv1i32_6(<vscale x 16 x i32> %vec, <vscale x 1 x i32> %subvec) {
; CHECK-LABEL: insert_nxv16i32_nxv1i32_6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, tu, mu
; CHECK-NEXT:    vslideup.vi v11, v16, 0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv1i32.nxv16i32(<vscale x 16 x i32> %vec, <vscale x 1 x i32> %subvec, i64 6)
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i8> @insert_nxv16i8_nxv1i8_0(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec) {
; CHECK-LABEL: insert_nxv16i8_nxv1i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, tu, mu
; CHECK-NEXT:    vslideup.vi v8, v10, 0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.experimental.vector.insert.nxv1i8.nxv16i8(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec, i64 0)
  ret <vscale x 16 x i8> %v
}

define <vscale x 16 x i8> @insert_nxv16i8_nxv1i8_1(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec) {
; CHECK-LABEL: insert_nxv16i8_nxv1i8_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    add a1, a0, a0
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, tu, mu
; CHECK-NEXT:    vslideup.vx v8, v10, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.experimental.vector.insert.nxv1i8.nxv16i8(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec, i64 1)
  ret <vscale x 16 x i8> %v
}

define <vscale x 16 x i8> @insert_nxv16i8_nxv1i8_2(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec) {
; CHECK-LABEL: insert_nxv16i8_nxv1i8_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a1, a0, 3
; CHECK-NEXT:    srli a0, a0, 2
; CHECK-NEXT:    add a1, a0, a1
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, tu, mu
; CHECK-NEXT:    vslideup.vx v8, v10, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.experimental.vector.insert.nxv1i8.nxv16i8(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec, i64 2)
  ret <vscale x 16 x i8> %v
}

define <vscale x 16 x i8> @insert_nxv16i8_nxv1i8_3(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec) {
; CHECK-LABEL: insert_nxv16i8_nxv1i8_3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    slli a1, a0, 1
; CHECK-NEXT:    add a1, a1, a0
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, tu, mu
; CHECK-NEXT:    vslideup.vx v8, v10, a1
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.experimental.vector.insert.nxv1i8.nxv16i8(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec, i64 3)
  ret <vscale x 16 x i8> %v
}

define <vscale x 16 x i8> @insert_nxv16i8_nxv1i8_7(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec) {
; CHECK-LABEL: insert_nxv16i8_nxv1i8_7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    slli a1, a0, 3
; CHECK-NEXT:    sub a0, a1, a0
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, tu, mu
; CHECK-NEXT:    vslideup.vx v8, v10, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.experimental.vector.insert.nxv1i8.nxv16i8(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec, i64 7)
  ret <vscale x 16 x i8> %v
}

define <vscale x 16 x i8> @insert_nxv16i8_nxv1i8_15(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec) {
; CHECK-LABEL: insert_nxv16i8_nxv1i8_15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    slli a1, a0, 3
; CHECK-NEXT:    sub a0, a1, a0
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, tu, mu
; CHECK-NEXT:    vslideup.vx v9, v10, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.experimental.vector.insert.nxv1i8.nxv16i8(<vscale x 16 x i8> %vec, <vscale x 1 x i8> %subvec, i64 15)
  ret <vscale x 16 x i8> %v
}

define <vscale x 32 x half> @insert_nxv32f16_nxv2f16_0(<vscale x 32 x half> %vec, <vscale x 2 x half> %subvec) {
; CHECK-LABEL: insert_nxv32f16_nxv2f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 2
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, tu, mu
; CHECK-NEXT:    vslideup.vi v8, v16, 0
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.experimental.vector.insert.nxv2f16.nxv32f16(<vscale x 32 x half> %vec, <vscale x 2 x half> %subvec, i64 0)
  ret <vscale x 32 x half> %v
}

define <vscale x 32 x half> @insert_nxv32f16_nxv2f16_2(<vscale x 32 x half> %vec, <vscale x 2 x half> %subvec) {
; CHECK-LABEL: insert_nxv32f16_nxv2f16_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 2
; CHECK-NEXT:    add a1, a0, a0
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, tu, mu
; CHECK-NEXT:    vslideup.vx v8, v16, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.experimental.vector.insert.nxv2f16.nxv32f16(<vscale x 32 x half> %vec, <vscale x 2 x half> %subvec, i64 2)
  ret <vscale x 32 x half> %v
}

define <vscale x 32 x half> @insert_nxv32f16_nxv2f16_26(<vscale x 32 x half> %vec, <vscale x 2 x half> %subvec) {
; CHECK-LABEL: insert_nxv32f16_nxv2f16_26:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 2
; CHECK-NEXT:    add a1, a0, a0
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, tu, mu
; CHECK-NEXT:    vslideup.vx v14, v16, a0
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.experimental.vector.insert.nxv2f16.nxv32f16(<vscale x 32 x half> %vec, <vscale x 2 x half> %subvec, i64 26)
  ret <vscale x 32 x half> %v
}

define <vscale x 32 x half> @insert_nxv32f16_undef_nxv1f16_0(<vscale x 1 x half> %subvec) {
; CHECK-LABEL: insert_nxv32f16_undef_nxv1f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $v8 killed $v8 def $v8m8
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.experimental.vector.insert.nxv1f16.nxv32f16(<vscale x 32 x half> undef, <vscale x 1 x half> %subvec, i64 0)
  ret <vscale x 32 x half> %v
}

define <vscale x 32 x half> @insert_nxv32f16_undef_nxv1f16_26(<vscale x 1 x half> %subvec) {
; CHECK-LABEL: insert_nxv32f16_undef_nxv1f16_26:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a1, a0, 3
; CHECK-NEXT:    srli a0, a0, 2
; CHECK-NEXT:    add a1, a0, a1
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, mu
; CHECK-NEXT:    vslideup.vx v22, v8, a0
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.experimental.vector.insert.nxv1f16.nxv32f16(<vscale x 32 x half> undef, <vscale x 1 x half> %subvec, i64 26)
  ret <vscale x 32 x half> %v
}

define <vscale x 32 x i1> @insert_nxv32i1_nxv8i1_0(<vscale x 32 x i1> %v, <vscale x 8 x i1> %sv) {
; CHECK-LABEL: insert_nxv32i1_nxv8i1_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, tu, mu
; CHECK-NEXT:    vslideup.vi v0, v8, 0
; CHECK-NEXT:    ret
  %vec = call <vscale x 32 x i1> @llvm.experimental.vector.insert.nxv8i1.nxv32i1(<vscale x 32 x i1> %v, <vscale x 8 x i1> %sv, i64 0)
  ret <vscale x 32 x i1> %vec
}

define <vscale x 32 x i1> @insert_nxv32i1_nxv8i1_8(<vscale x 32 x i1> %v, <vscale x 8 x i1> %sv) {
; CHECK-LABEL: insert_nxv32i1_nxv8i1_8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    add a1, a0, a0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, tu, mu
; CHECK-NEXT:    vslideup.vx v0, v8, a0
; CHECK-NEXT:    ret
  %vec = call <vscale x 32 x i1> @llvm.experimental.vector.insert.nxv8i1.nxv32i1(<vscale x 32 x i1> %v, <vscale x 8 x i1> %sv, i64 8)
  ret <vscale x 32 x i1> %vec
}

define <vscale x 4 x i1> @insert_nxv4i1_nxv1i1_0(<vscale x 4 x i1> %v, <vscale x 1 x i1> %sv) {
; CHECK-LABEL: insert_nxv4i1_nxv1i1_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    vsetvli a0, zero, e8, mf8, ta, mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vmerge.vim v26, v26, 1, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a0, a0, 3
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, tu, mu
; CHECK-NEXT:    vslideup.vi v25, v26, 0
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, mu
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %vec = call <vscale x 4 x i1> @llvm.experimental.vector.insert.nxv1i1.nxv4i1(<vscale x 4 x i1> %v, <vscale x 1 x i1> %sv, i64 0)
  ret <vscale x 4 x i1> %vec
}

define <vscale x 4 x i1> @insert_nxv4i1_nxv1i1_2(<vscale x 4 x i1> %v, <vscale x 1 x i1> %sv) {
; CHECK-LABEL: insert_nxv4i1_nxv1i1_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    srli a1, a0, 3
; CHECK-NEXT:    srli a0, a0, 2
; CHECK-NEXT:    add a1, a0, a1
; CHECK-NEXT:    vsetvli a2, zero, e8, mf8, ta, mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vmerge.vim v26, v26, 1, v0
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, tu, mu
; CHECK-NEXT:    vslideup.vx v25, v26, a0
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, mu
; CHECK-NEXT:    vmsne.vi v0, v25, 0
; CHECK-NEXT:    ret
  %vec = call <vscale x 4 x i1> @llvm.experimental.vector.insert.nxv1i1.nxv4i1(<vscale x 4 x i1> %v, <vscale x 1 x i1> %sv, i64 2)
  ret <vscale x 4 x i1> %vec
}

declare <vscale x 16 x i64> @llvm.experimental.vector.insert.nxv8i64.nxv16i64(<vscale x 16 x i64>, <vscale x 8 x i64>, i64)

define void @insert_nxv8i64_nxv16i64(<vscale x 8 x i64> %sv0, <vscale x 8 x i64> %sv1, <vscale x 16 x i64>* %out) {
; CHECK-LABEL: insert_nxv8i64_nxv16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vs8r.v v8, (a0)
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    vs8r.v v16, (a0)
; CHECK-NEXT:    ret
  %v0 = call <vscale x 16 x i64> @llvm.experimental.vector.insert.nxv8i64.nxv16i64(<vscale x 16 x i64> undef, <vscale x 8 x i64> %sv0, i64 0)
  %v = call <vscale x 16 x i64> @llvm.experimental.vector.insert.nxv8i64.nxv16i64(<vscale x 16 x i64> %v0, <vscale x 8 x i64> %sv1, i64 8)
  store <vscale x 16 x i64> %v, <vscale x 16 x i64>* %out
  ret void
}

define void @insert_nxv8i64_nxv16i64_lo(<vscale x 8 x i64> %sv0, <vscale x 16 x i64>* %out) {
; CHECK-LABEL: insert_nxv8i64_nxv16i64_lo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vs8r.v v8, (a0)
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i64> @llvm.experimental.vector.insert.nxv8i64.nxv16i64(<vscale x 16 x i64> undef, <vscale x 8 x i64> %sv0, i64 0)
  store <vscale x 16 x i64> %v, <vscale x 16 x i64>* %out
  ret void
}

define void @insert_nxv8i64_nxv16i64_hi(<vscale x 8 x i64> %sv0, <vscale x 16 x i64>* %out) {
; CHECK-LABEL: insert_nxv8i64_nxv16i64_hi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    vs8r.v v8, (a0)
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i64> @llvm.experimental.vector.insert.nxv8i64.nxv16i64(<vscale x 16 x i64> undef, <vscale x 8 x i64> %sv0, i64 8)
  store <vscale x 16 x i64> %v, <vscale x 16 x i64>* %out
  ret void
}

declare <vscale x 4 x i1> @llvm.experimental.vector.insert.nxv1i1.nxv4i1(<vscale x 4 x i1>, <vscale x 1 x i1>, i64)
declare <vscale x 32 x i1> @llvm.experimental.vector.insert.nxv8i1.nxv32i1(<vscale x 32 x i1>, <vscale x 8 x i1>, i64)

declare <vscale x 16 x i8> @llvm.experimental.vector.insert.nxv1i8.nxv16i8(<vscale x 16 x i8>, <vscale x 1 x i8>, i64)

declare <vscale x 32 x half> @llvm.experimental.vector.insert.nxv1f16.nxv32f16(<vscale x 32 x half>, <vscale x 1 x half>, i64)
declare <vscale x 32 x half> @llvm.experimental.vector.insert.nxv2f16.nxv32f16(<vscale x 32 x half>, <vscale x 2 x half>, i64)

declare <vscale x 4 x i8> @llvm.experimental.vector.insert.nxv1i8.nxv4i8(<vscale x 4 x i8>, <vscale x 1 x i8>, i64 %idx)

declare <vscale x 8 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv8i32(<vscale x 8 x i32>, <vscale x 2 x i32>, i64 %idx)
declare <vscale x 8 x i32> @llvm.experimental.vector.insert.nxv4i32.nxv8i32(<vscale x 8 x i32>, <vscale x 4 x i32>, i64 %idx)

declare <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv1i32.nxv16i32(<vscale x 16 x i32>, <vscale x 1 x i32>, i64 %idx)
declare <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv2i32.nxv16i32(<vscale x 16 x i32>, <vscale x 2 x i32>, i64 %idx)
declare <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv4i32.nxv16i32(<vscale x 16 x i32>, <vscale x 4 x i32>, i64 %idx)
declare <vscale x 16 x i32> @llvm.experimental.vector.insert.nxv8i32.nxv16i32(<vscale x 16 x i32>, <vscale x 8 x i32>, i64 %idx)
