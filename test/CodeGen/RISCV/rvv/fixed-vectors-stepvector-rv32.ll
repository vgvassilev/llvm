; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=2 < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX2

declare <2 x i8> @llvm.experimental.stepvector.v2i8()

define <2 x i8> @stepvector_v2i8() {
; CHECK-LABEL: stepvector_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.experimental.stepvector.v2i8()
  ret <2 x i8> %v
}

declare <4 x i8> @llvm.experimental.stepvector.v4i8()

define <4 x i8> @stepvector_v4i8() {
; CHECK-LABEL: stepvector_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <4 x i8> @llvm.experimental.stepvector.v4i8()
  ret <4 x i8> %v
}

declare <8 x i8> @llvm.experimental.stepvector.v8i8()

define <8 x i8> @stepvector_v8i8() {
; CHECK-LABEL: stepvector_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <8 x i8> @llvm.experimental.stepvector.v8i8()
  ret <8 x i8> %v
}

declare <16 x i8> @llvm.experimental.stepvector.v16i8()

define <16 x i8> @stepvector_v16i8() {
; CHECK-LABEL: stepvector_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <16 x i8> @llvm.experimental.stepvector.v16i8()
  ret <16 x i8> %v
}

declare <2 x i16> @llvm.experimental.stepvector.v2i16()

define <2 x i16> @stepvector_v2i16() {
; CHECK-LABEL: stepvector_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <2 x i16> @llvm.experimental.stepvector.v2i16()
  ret <2 x i16> %v
}

declare <4 x i16> @llvm.experimental.stepvector.v4i16()

define <4 x i16> @stepvector_v4i16() {
; CHECK-LABEL: stepvector_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <4 x i16> @llvm.experimental.stepvector.v4i16()
  ret <4 x i16> %v
}

declare <8 x i16> @llvm.experimental.stepvector.v8i16()

define <8 x i16> @stepvector_v8i16() {
; CHECK-LABEL: stepvector_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <8 x i16> @llvm.experimental.stepvector.v8i16()
  ret <8 x i16> %v
}

declare <16 x i16> @llvm.experimental.stepvector.v16i16()

define <16 x i16> @stepvector_v16i16() {
; LMULMAX1-LABEL: stepvector_v16i16:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 8, e16, m1, ta, mu
; LMULMAX1-NEXT:    vid.v v8
; LMULMAX1-NEXT:    vadd.vi v9, v8, 8
; LMULMAX1-NEXT:    ret
;
; LMULMAX2-LABEL: stepvector_v16i16:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli zero, 16, e16, m2, ta, mu
; LMULMAX2-NEXT:    vid.v v8
; LMULMAX2-NEXT:    ret
  %v = call <16 x i16> @llvm.experimental.stepvector.v16i16()
  ret <16 x i16> %v
}

declare <2 x i32> @llvm.experimental.stepvector.v2i32()

define <2 x i32> @stepvector_v2i32() {
; CHECK-LABEL: stepvector_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <2 x i32> @llvm.experimental.stepvector.v2i32()
  ret <2 x i32> %v
}

declare <4 x i32> @llvm.experimental.stepvector.v4i32()

define <4 x i32> @stepvector_v4i32() {
; CHECK-LABEL: stepvector_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.experimental.stepvector.v4i32()
  ret <4 x i32> %v
}

declare <8 x i32> @llvm.experimental.stepvector.v8i32()

define <8 x i32> @stepvector_v8i32() {
; LMULMAX1-LABEL: stepvector_v8i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, mu
; LMULMAX1-NEXT:    vid.v v8
; LMULMAX1-NEXT:    vadd.vi v9, v8, 4
; LMULMAX1-NEXT:    ret
;
; LMULMAX2-LABEL: stepvector_v8i32:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli zero, 8, e32, m2, ta, mu
; LMULMAX2-NEXT:    vid.v v8
; LMULMAX2-NEXT:    ret
  %v = call <8 x i32> @llvm.experimental.stepvector.v8i32()
  ret <8 x i32> %v
}

declare <16 x i32> @llvm.experimental.stepvector.v16i32()

define <16 x i32> @stepvector_v16i32() {
; LMULMAX1-LABEL: stepvector_v16i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli zero, 4, e32, m1, ta, mu
; LMULMAX1-NEXT:    vid.v v8
; LMULMAX1-NEXT:    vadd.vi v9, v8, 4
; LMULMAX1-NEXT:    vadd.vi v10, v8, 8
; LMULMAX1-NEXT:    vadd.vi v11, v8, 12
; LMULMAX1-NEXT:    ret
;
; LMULMAX2-LABEL: stepvector_v16i32:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli zero, 8, e32, m2, ta, mu
; LMULMAX2-NEXT:    vid.v v8
; LMULMAX2-NEXT:    vadd.vi v10, v8, 8
; LMULMAX2-NEXT:    ret
  %v = call <16 x i32> @llvm.experimental.stepvector.v16i32()
  ret <16 x i32> %v
}
