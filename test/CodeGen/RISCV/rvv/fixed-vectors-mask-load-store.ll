; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=2 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX2
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=2 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX2
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1-RV32
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1-RV64

define void @load_store_v1i1(<1 x i1>* %x, <1 x i1>* %y) {
; CHECK-LABEL: load_store_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 1, e8,m1,ta,mu
; CHECK-NEXT:    vle1.v v0, (a0)
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vsetivli a0, 1, e8,m1,tu,mu
; CHECK-NEXT:    vslideup.vi v26, v25, 0
; CHECK-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; CHECK-NEXT:    vmsne.vi v25, v26, 0
; CHECK-NEXT:    vse1.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <1 x i1>, <1 x i1>* %x
  store <1 x i1> %a, <1 x i1>* %y
  ret void
}

define void @load_store_v2i1(<2 x i1>* %x, <2 x i1>* %y) {
; CHECK-LABEL: load_store_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 2, e8,m1,ta,mu
; CHECK-NEXT:    vle1.v v0, (a0)
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vsetivli a0, 2, e8,m1,tu,mu
; CHECK-NEXT:    vslideup.vi v26, v25, 0
; CHECK-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; CHECK-NEXT:    vmsne.vi v25, v26, 0
; CHECK-NEXT:    vse1.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x i1>, <2 x i1>* %x
  store <2 x i1> %a, <2 x i1>* %y
  ret void
}

define void @load_store_v4i1(<4 x i1>* %x, <4 x i1>* %y) {
; CHECK-LABEL: load_store_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 4, e8,m1,ta,mu
; CHECK-NEXT:    vle1.v v0, (a0)
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vsetivli a0, 4, e8,m1,tu,mu
; CHECK-NEXT:    vslideup.vi v26, v25, 0
; CHECK-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; CHECK-NEXT:    vmsne.vi v25, v26, 0
; CHECK-NEXT:    vse1.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <4 x i1>, <4 x i1>* %x
  store <4 x i1> %a, <4 x i1>* %y
  ret void
}

define void @load_store_v8i1(<8 x i1>* %x, <8 x i1>* %y) {
; CHECK-LABEL: load_store_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 8, e8,m1,ta,mu
; CHECK-NEXT:    vle1.v v25, (a0)
; CHECK-NEXT:    vse1.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x i1>, <8 x i1>* %x
  store <8 x i1> %a, <8 x i1>* %y
  ret void
}

define void @load_store_v16i1(<16 x i1>* %x, <16 x i1>* %y) {
; CHECK-LABEL: load_store_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle1.v v25, (a0)
; CHECK-NEXT:    vse1.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <16 x i1>, <16 x i1>* %x
  store <16 x i1> %a, <16 x i1>* %y
  ret void
}

define void @load_store_v32i1(<32 x i1>* %x, <32 x i1>* %y) {
; LMULMAX2-LABEL: load_store_v32i1:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    addi a2, zero, 32
; LMULMAX2-NEXT:    vsetvli a2, a2, e8,m2,ta,mu
; LMULMAX2-NEXT:    vle1.v v25, (a0)
; LMULMAX2-NEXT:    vse1.v v25, (a1)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-RV32-LABEL: load_store_v32i1:
; LMULMAX1-RV32:       # %bb.0:
; LMULMAX1-RV32-NEXT:    lw a0, 0(a0)
; LMULMAX1-RV32-NEXT:    sw a0, 0(a1)
; LMULMAX1-RV32-NEXT:    ret
;
; LMULMAX1-RV64-LABEL: load_store_v32i1:
; LMULMAX1-RV64:       # %bb.0:
; LMULMAX1-RV64-NEXT:    lw a0, 0(a0)
; LMULMAX1-RV64-NEXT:    sw a0, 0(a1)
; LMULMAX1-RV64-NEXT:    ret
  %a = load <32 x i1>, <32 x i1>* %x
  store <32 x i1> %a, <32 x i1>* %y
  ret void
}
