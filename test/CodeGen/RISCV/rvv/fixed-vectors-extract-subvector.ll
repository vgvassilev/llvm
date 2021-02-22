; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=2 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX2
; RUN: llc -mtriple=riscv64 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1

define void @extract_v2i8_v8i8_0(<8 x i8>* %x, <2 x i8>* %y) {
; CHECK-LABEL: extract_v2i8_v8i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 8, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vsetivli a0, 2, e8,m1,ta,mu
; CHECK-NEXT:    vse8.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %c = call <2 x i8> @llvm.experimental.vector.extract.v2i8.v8i8(<8 x i8> %a, i64 0)
  store <2 x i8> %c, <2 x i8>* %y
  ret void
}

define void @extract_v2i8_v8i8_6(<8 x i8>* %x, <2 x i8>* %y) {
; CHECK-LABEL: extract_v2i8_v8i8_6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 8, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vsetivli a0, 2, e8,m1,ta,mu
; CHECK-NEXT:    vslidedown.vi v25, v25, 6
; CHECK-NEXT:    vse8.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %c = call <2 x i8> @llvm.experimental.vector.extract.v2i8.v8i8(<8 x i8> %a, i64 6)
  store <2 x i8> %c, <2 x i8>* %y
  ret void
}

define void @extract_v2i32_v8i32_0(<8 x i32>* %x, <2 x i32>* %y) {
; LMULMAX2-LABEL: extract_v2i32_v8i32_0:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli a2, 8, e32,m2,ta,mu
; LMULMAX2-NEXT:    vle32.v v26, (a0)
; LMULMAX2-NEXT:    vsetivli a0, 2, e32,m1,ta,mu
; LMULMAX2-NEXT:    vse32.v v26, (a1)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-LABEL: extract_v2i32_v8i32_0:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a2, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vle32.v v25, (a0)
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,m1,ta,mu
; LMULMAX1-NEXT:    vse32.v v25, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x i32>, <8 x i32>* %x
  %c = call <2 x i32> @llvm.experimental.vector.extract.v2i32.v8i32(<8 x i32> %a, i64 0)
  store <2 x i32> %c, <2 x i32>* %y
  ret void
}

define void @extract_v2i32_v8i32_2(<8 x i32>* %x, <2 x i32>* %y) {
; LMULMAX2-LABEL: extract_v2i32_v8i32_2:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli a2, 8, e32,m2,ta,mu
; LMULMAX2-NEXT:    vle32.v v26, (a0)
; LMULMAX2-NEXT:    vsetivli a0, 2, e32,m2,ta,mu
; LMULMAX2-NEXT:    vslidedown.vi v26, v26, 2
; LMULMAX2-NEXT:    vsetivli a0, 2, e32,m1,ta,mu
; LMULMAX2-NEXT:    vse32.v v26, (a1)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-LABEL: extract_v2i32_v8i32_2:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a2, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vle32.v v25, (a0)
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v25, v25, 2
; LMULMAX1-NEXT:    vse32.v v25, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x i32>, <8 x i32>* %x
  %c = call <2 x i32> @llvm.experimental.vector.extract.v2i32.v8i32(<8 x i32> %a, i64 2)
  store <2 x i32> %c, <2 x i32>* %y
  ret void
}

define void @extract_v2i32_v8i32_6(<8 x i32>* %x, <2 x i32>* %y) {
; LMULMAX2-LABEL: extract_v2i32_v8i32_6:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli a2, 8, e32,m2,ta,mu
; LMULMAX2-NEXT:    vle32.v v26, (a0)
; LMULMAX2-NEXT:    vsetivli a0, 2, e32,m2,ta,mu
; LMULMAX2-NEXT:    vslidedown.vi v26, v26, 6
; LMULMAX2-NEXT:    vsetivli a0, 2, e32,m1,ta,mu
; LMULMAX2-NEXT:    vse32.v v26, (a1)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-LABEL: extract_v2i32_v8i32_6:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    addi a0, a0, 16
; LMULMAX1-NEXT:    vsetivli a2, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vle32.v v25, (a0)
; LMULMAX1-NEXT:    vsetivli a0, 2, e32,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v25, v25, 2
; LMULMAX1-NEXT:    vse32.v v25, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x i32>, <8 x i32>* %x
  %c = call <2 x i32> @llvm.experimental.vector.extract.v2i32.v8i32(<8 x i32> %a, i64 6)
  store <2 x i32> %c, <2 x i32>* %y
  ret void
}

define void @extract_v2i32_nxv16i32_0(<vscale x 16 x i32> %x, <2 x i32>* %y) {
; CHECK-LABEL: extract_v2i32_nxv16i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 2, e32,m1,ta,mu
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %c = call <2 x i32> @llvm.experimental.vector.extract.v2i32.nxv16i32(<vscale x 16 x i32> %x, i64 0)
  store <2 x i32> %c, <2 x i32>* %y
  ret void
}

define void @extract_v2i32_nxv16i32_8(<vscale x 16 x i32> %x, <2 x i32>* %y) {
; CHECK-LABEL: extract_v2i32_nxv16i32_8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a1, 2, e32,m8,ta,mu
; CHECK-NEXT:    vslidedown.vi v8, v8, 6
; CHECK-NEXT:    vsetivli a1, 2, e32,m1,ta,mu
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %c = call <2 x i32> @llvm.experimental.vector.extract.v2i32.nxv16i32(<vscale x 16 x i32> %x, i64 6)
  store <2 x i32> %c, <2 x i32>* %y
  ret void
}

define void @extract_v8i32_nxv16i32_8(<vscale x 16 x i32> %x, <8 x i32>* %y) {
; LMULMAX2-LABEL: extract_v8i32_nxv16i32_8:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli a1, 8, e32,m8,ta,mu
; LMULMAX2-NEXT:    vslidedown.vi v8, v8, 8
; LMULMAX2-NEXT:    vsetivli a1, 8, e32,m2,ta,mu
; LMULMAX2-NEXT:    vse32.v v8, (a0)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-LABEL: extract_v8i32_nxv16i32_8:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a1, 4, e32,m8,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v16, v8, 8
; LMULMAX1-NEXT:    vslidedown.vi v8, v8, 12
; LMULMAX1-NEXT:    addi a1, a0, 16
; LMULMAX1-NEXT:    vsetivli a2, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vse32.v v8, (a1)
; LMULMAX1-NEXT:    vse32.v v16, (a0)
; LMULMAX1-NEXT:    ret
  %c = call <8 x i32> @llvm.experimental.vector.extract.v8i32.nxv16i32(<vscale x 16 x i32> %x, i64 8)
  store <8 x i32> %c, <8 x i32>* %y
  ret void
}

declare <2 x i8> @llvm.experimental.vector.extract.v2i8.v8i8(<8 x i8> %vec, i64 %idx)
declare <2 x i32> @llvm.experimental.vector.extract.v2i32.v8i32(<8 x i32> %vec, i64 %idx)

declare <2 x i32> @llvm.experimental.vector.extract.v2i32.nxv16i32(<vscale x 16 x i32> %vec, i64 %idx)
declare <8 x i32> @llvm.experimental.vector.extract.v8i32.nxv16i32(<vscale x 16 x i32> %vec, i64 %idx)
