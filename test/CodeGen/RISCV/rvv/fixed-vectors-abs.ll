; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=2 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX2
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=2 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX2
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1-RV32
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1-RV64

define void @abs_v16i8(<16 x i8>* %x) {
; CHECK-LABEL: abs_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vrsub.vi v26, v25, 0
; CHECK-NEXT:    vmax.vv v25, v25, v26
; CHECK-NEXT:    vse8.v v25, (a0)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, <16 x i8>* %x
  %b = call <16 x i8> @llvm.abs.v16i8(<16 x i8> %a, i1 false)
  store <16 x i8> %b, <16 x i8>* %x
  ret void
}
declare <16 x i8> @llvm.abs.v16i8(<16 x i8>, i1)

define void @abs_v8i16(<8 x i16>* %x) {
; CHECK-LABEL: abs_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, mu
; CHECK-NEXT:    vle16.v v25, (a0)
; CHECK-NEXT:    vrsub.vi v26, v25, 0
; CHECK-NEXT:    vmax.vv v25, v25, v26
; CHECK-NEXT:    vse16.v v25, (a0)
; CHECK-NEXT:    ret
  %a = load <8 x i16>, <8 x i16>* %x
  %b = call <8 x i16> @llvm.abs.v8i16(<8 x i16> %a, i1 false)
  store <8 x i16> %b, <8 x i16>* %x
  ret void
}
declare <8 x i16> @llvm.abs.v8i16(<8 x i16>, i1)

define void @abs_v4i32(<4 x i32>* %x) {
; CHECK-LABEL: abs_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, mu
; CHECK-NEXT:    vle32.v v25, (a0)
; CHECK-NEXT:    vrsub.vi v26, v25, 0
; CHECK-NEXT:    vmax.vv v25, v25, v26
; CHECK-NEXT:    vse32.v v25, (a0)
; CHECK-NEXT:    ret
  %a = load <4 x i32>, <4 x i32>* %x
  %b = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %a, i1 false)
  store <4 x i32> %b, <4 x i32>* %x
  ret void
}
declare <4 x i32> @llvm.abs.v4i32(<4 x i32>, i1)

define void @abs_v2i64(<2 x i64>* %x) {
; CHECK-LABEL: abs_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; CHECK-NEXT:    vle64.v v25, (a0)
; CHECK-NEXT:    vrsub.vi v26, v25, 0
; CHECK-NEXT:    vmax.vv v25, v25, v26
; CHECK-NEXT:    vse64.v v25, (a0)
; CHECK-NEXT:    ret
  %a = load <2 x i64>, <2 x i64>* %x
  %b = call <2 x i64> @llvm.abs.v2i64(<2 x i64> %a, i1 false)
  store <2 x i64> %b, <2 x i64>* %x
  ret void
}
declare <2 x i64> @llvm.abs.v2i64(<2 x i64>, i1)

define void @abs_v32i8(<32 x i8>* %x) {
; LMULMAX2-LABEL: abs_v32i8:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    addi a1, zero, 32
; LMULMAX2-NEXT:    vsetvli zero, a1, e8, m2, ta, mu
; LMULMAX2-NEXT:    vle8.v v26, (a0)
; LMULMAX2-NEXT:    vrsub.vi v28, v26, 0
; LMULMAX2-NEXT:    vmax.vv v26, v26, v28
; LMULMAX2-NEXT:    vse8.v v26, (a0)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-RV32-LABEL: abs_v32i8:
; LMULMAX1-RV32:       # %bb.0:
; LMULMAX1-RV32-NEXT:    vsetivli zero, 16, e8, m1, ta, mu
; LMULMAX1-RV32-NEXT:    addi a1, a0, 16
; LMULMAX1-RV32-NEXT:    vle8.v v25, (a1)
; LMULMAX1-RV32-NEXT:    vle8.v v26, (a0)
; LMULMAX1-RV32-NEXT:    vrsub.vi v27, v25, 0
; LMULMAX1-RV32-NEXT:    vmax.vv v25, v25, v27
; LMULMAX1-RV32-NEXT:    vrsub.vi v27, v26, 0
; LMULMAX1-RV32-NEXT:    vmax.vv v26, v26, v27
; LMULMAX1-RV32-NEXT:    vse8.v v26, (a0)
; LMULMAX1-RV32-NEXT:    vse8.v v25, (a1)
; LMULMAX1-RV32-NEXT:    ret
;
; LMULMAX1-RV64-LABEL: abs_v32i8:
; LMULMAX1-RV64:       # %bb.0:
; LMULMAX1-RV64-NEXT:    vsetivli zero, 16, e8, m1, ta, mu
; LMULMAX1-RV64-NEXT:    addi a1, a0, 16
; LMULMAX1-RV64-NEXT:    vle8.v v25, (a1)
; LMULMAX1-RV64-NEXT:    vle8.v v26, (a0)
; LMULMAX1-RV64-NEXT:    vrsub.vi v27, v25, 0
; LMULMAX1-RV64-NEXT:    vmax.vv v25, v25, v27
; LMULMAX1-RV64-NEXT:    vrsub.vi v27, v26, 0
; LMULMAX1-RV64-NEXT:    vmax.vv v26, v26, v27
; LMULMAX1-RV64-NEXT:    vse8.v v26, (a0)
; LMULMAX1-RV64-NEXT:    vse8.v v25, (a1)
; LMULMAX1-RV64-NEXT:    ret
  %a = load <32 x i8>, <32 x i8>* %x
  %b = call <32 x i8> @llvm.abs.v32i8(<32 x i8> %a, i1 false)
  store <32 x i8> %b, <32 x i8>* %x
  ret void
}
declare <32 x i8> @llvm.abs.v32i8(<32 x i8>, i1)

define void @abs_v16i16(<16 x i16>* %x) {
; LMULMAX2-LABEL: abs_v16i16:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli zero, 16, e16, m2, ta, mu
; LMULMAX2-NEXT:    vle16.v v26, (a0)
; LMULMAX2-NEXT:    vrsub.vi v28, v26, 0
; LMULMAX2-NEXT:    vmax.vv v26, v26, v28
; LMULMAX2-NEXT:    vse16.v v26, (a0)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-RV32-LABEL: abs_v16i16:
; LMULMAX1-RV32:       # %bb.0:
; LMULMAX1-RV32-NEXT:    vsetivli zero, 8, e16, m1, ta, mu
; LMULMAX1-RV32-NEXT:    addi a1, a0, 16
; LMULMAX1-RV32-NEXT:    vle16.v v25, (a1)
; LMULMAX1-RV32-NEXT:    vle16.v v26, (a0)
; LMULMAX1-RV32-NEXT:    vrsub.vi v27, v25, 0
; LMULMAX1-RV32-NEXT:    vmax.vv v25, v25, v27
; LMULMAX1-RV32-NEXT:    vrsub.vi v27, v26, 0
; LMULMAX1-RV32-NEXT:    vmax.vv v26, v26, v27
; LMULMAX1-RV32-NEXT:    vse16.v v26, (a0)
; LMULMAX1-RV32-NEXT:    vse16.v v25, (a1)
; LMULMAX1-RV32-NEXT:    ret
;
; LMULMAX1-RV64-LABEL: abs_v16i16:
; LMULMAX1-RV64:       # %bb.0:
; LMULMAX1-RV64-NEXT:    vsetivli zero, 8, e16, m1, ta, mu
; LMULMAX1-RV64-NEXT:    addi a1, a0, 16
; LMULMAX1-RV64-NEXT:    vle16.v v25, (a1)
; LMULMAX1-RV64-NEXT:    vle16.v v26, (a0)
; LMULMAX1-RV64-NEXT:    vrsub.vi v27, v25, 0
; LMULMAX1-RV64-NEXT:    vmax.vv v25, v25, v27
; LMULMAX1-RV64-NEXT:    vrsub.vi v27, v26, 0
; LMULMAX1-RV64-NEXT:    vmax.vv v26, v26, v27
; LMULMAX1-RV64-NEXT:    vse16.v v26, (a0)
; LMULMAX1-RV64-NEXT:    vse16.v v25, (a1)
; LMULMAX1-RV64-NEXT:    ret
  %a = load <16 x i16>, <16 x i16>* %x
  %b = call <16 x i16> @llvm.abs.v16i16(<16 x i16> %a, i1 false)
  store <16 x i16> %b, <16 x i16>* %x
  ret void
}
declare <16 x i16> @llvm.abs.v16i16(<16 x i16>, i1)

define void @abs_v8i32(<8 x i32>* %x) {
; LMULMAX2-LABEL: abs_v8i32:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli zero, 8, e32, m2, ta, mu
; LMULMAX2-NEXT:    vle32.v v26, (a0)
; LMULMAX2-NEXT:    vrsub.vi v28, v26, 0
; LMULMAX2-NEXT:    vmax.vv v26, v26, v28
; LMULMAX2-NEXT:    vse32.v v26, (a0)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-RV32-LABEL: abs_v8i32:
; LMULMAX1-RV32:       # %bb.0:
; LMULMAX1-RV32-NEXT:    vsetivli zero, 4, e32, m1, ta, mu
; LMULMAX1-RV32-NEXT:    addi a1, a0, 16
; LMULMAX1-RV32-NEXT:    vle32.v v25, (a1)
; LMULMAX1-RV32-NEXT:    vle32.v v26, (a0)
; LMULMAX1-RV32-NEXT:    vrsub.vi v27, v25, 0
; LMULMAX1-RV32-NEXT:    vmax.vv v25, v25, v27
; LMULMAX1-RV32-NEXT:    vrsub.vi v27, v26, 0
; LMULMAX1-RV32-NEXT:    vmax.vv v26, v26, v27
; LMULMAX1-RV32-NEXT:    vse32.v v26, (a0)
; LMULMAX1-RV32-NEXT:    vse32.v v25, (a1)
; LMULMAX1-RV32-NEXT:    ret
;
; LMULMAX1-RV64-LABEL: abs_v8i32:
; LMULMAX1-RV64:       # %bb.0:
; LMULMAX1-RV64-NEXT:    vsetivli zero, 4, e32, m1, ta, mu
; LMULMAX1-RV64-NEXT:    addi a1, a0, 16
; LMULMAX1-RV64-NEXT:    vle32.v v25, (a1)
; LMULMAX1-RV64-NEXT:    vle32.v v26, (a0)
; LMULMAX1-RV64-NEXT:    vrsub.vi v27, v25, 0
; LMULMAX1-RV64-NEXT:    vmax.vv v25, v25, v27
; LMULMAX1-RV64-NEXT:    vrsub.vi v27, v26, 0
; LMULMAX1-RV64-NEXT:    vmax.vv v26, v26, v27
; LMULMAX1-RV64-NEXT:    vse32.v v26, (a0)
; LMULMAX1-RV64-NEXT:    vse32.v v25, (a1)
; LMULMAX1-RV64-NEXT:    ret
  %a = load <8 x i32>, <8 x i32>* %x
  %b = call <8 x i32> @llvm.abs.v8i32(<8 x i32> %a, i1 false)
  store <8 x i32> %b, <8 x i32>* %x
  ret void
}
declare <8 x i32> @llvm.abs.v8i32(<8 x i32>, i1)

define void @abs_v4i64(<4 x i64>* %x) {
; LMULMAX2-LABEL: abs_v4i64:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli zero, 4, e64, m2, ta, mu
; LMULMAX2-NEXT:    vle64.v v26, (a0)
; LMULMAX2-NEXT:    vrsub.vi v28, v26, 0
; LMULMAX2-NEXT:    vmax.vv v26, v26, v28
; LMULMAX2-NEXT:    vse64.v v26, (a0)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-RV32-LABEL: abs_v4i64:
; LMULMAX1-RV32:       # %bb.0:
; LMULMAX1-RV32-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; LMULMAX1-RV32-NEXT:    addi a1, a0, 16
; LMULMAX1-RV32-NEXT:    vle64.v v25, (a1)
; LMULMAX1-RV32-NEXT:    vle64.v v26, (a0)
; LMULMAX1-RV32-NEXT:    vrsub.vi v27, v25, 0
; LMULMAX1-RV32-NEXT:    vmax.vv v25, v25, v27
; LMULMAX1-RV32-NEXT:    vrsub.vi v27, v26, 0
; LMULMAX1-RV32-NEXT:    vmax.vv v26, v26, v27
; LMULMAX1-RV32-NEXT:    vse64.v v26, (a0)
; LMULMAX1-RV32-NEXT:    vse64.v v25, (a1)
; LMULMAX1-RV32-NEXT:    ret
;
; LMULMAX1-RV64-LABEL: abs_v4i64:
; LMULMAX1-RV64:       # %bb.0:
; LMULMAX1-RV64-NEXT:    vsetivli zero, 2, e64, m1, ta, mu
; LMULMAX1-RV64-NEXT:    addi a1, a0, 16
; LMULMAX1-RV64-NEXT:    vle64.v v25, (a1)
; LMULMAX1-RV64-NEXT:    vle64.v v26, (a0)
; LMULMAX1-RV64-NEXT:    vrsub.vi v27, v25, 0
; LMULMAX1-RV64-NEXT:    vmax.vv v25, v25, v27
; LMULMAX1-RV64-NEXT:    vrsub.vi v27, v26, 0
; LMULMAX1-RV64-NEXT:    vmax.vv v26, v26, v27
; LMULMAX1-RV64-NEXT:    vse64.v v26, (a0)
; LMULMAX1-RV64-NEXT:    vse64.v v25, (a1)
; LMULMAX1-RV64-NEXT:    ret
  %a = load <4 x i64>, <4 x i64>* %x
  %b = call <4 x i64> @llvm.abs.v4i64(<4 x i64> %a, i1 false)
  store <4 x i64> %b, <4 x i64>* %x
  ret void
}
declare <4 x i64> @llvm.abs.v4i64(<4 x i64>, i1)
