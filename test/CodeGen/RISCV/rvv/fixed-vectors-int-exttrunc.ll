; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8
; RUN: llc -mtriple=riscv64 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8
; RUN: llc -mtriple=riscv32 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=2 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX2
; RUN: llc -mtriple=riscv64 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=2 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX2
; RUN: llc -mtriple=riscv32 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1
; RUN: llc -mtriple=riscv64 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1

define void @sext_v4i8_v4i32(<4 x i8>* %x, <4 x i32>* %z) {
; CHECK-LABEL: sext_v4i8_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 4, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; CHECK-NEXT:    vsext.vf4 v26, v25
; CHECK-NEXT:    vse32.v v26, (a1)
; CHECK-NEXT:    ret
  %a = load <4 x i8>, <4 x i8>* %x
  %b = sext <4 x i8> %a to <4 x i32>
  store <4 x i32> %b, <4 x i32>* %z
  ret void
}

define void @zext_v4i8_v4i32(<4 x i8>* %x, <4 x i32>* %z) {
; CHECK-LABEL: zext_v4i8_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 4, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; CHECK-NEXT:    vzext.vf4 v26, v25
; CHECK-NEXT:    vse32.v v26, (a1)
; CHECK-NEXT:    ret
  %a = load <4 x i8>, <4 x i8>* %x
  %b = zext <4 x i8> %a to <4 x i32>
  store <4 x i32> %b, <4 x i32>* %z
  ret void
}

define void @sext_v8i8_v8i32(<8 x i8>* %x, <8 x i32>* %z) {
; LMULMAX8-LABEL: sext_v8i8_v8i32:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    vsetivli a2, 8, e8,m1,ta,mu
; LMULMAX8-NEXT:    vle8.v v25, (a0)
; LMULMAX8-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; LMULMAX8-NEXT:    vsext.vf4 v26, v25
; LMULMAX8-NEXT:    vse32.v v26, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX2-LABEL: sext_v8i8_v8i32:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli a2, 8, e8,m1,ta,mu
; LMULMAX2-NEXT:    vle8.v v25, (a0)
; LMULMAX2-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; LMULMAX2-NEXT:    vsext.vf4 v26, v25
; LMULMAX2-NEXT:    vse32.v v26, (a1)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-LABEL: sext_v8i8_v8i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a2, 8, e8,m1,ta,mu
; LMULMAX1-NEXT:    vle8.v v25, (a0)
; LMULMAX1-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vsext.vf4 v26, v25
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v25, v25, 4
; LMULMAX1-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vsext.vf4 v27, v25
; LMULMAX1-NEXT:    addi a0, a1, 16
; LMULMAX1-NEXT:    vse32.v v27, (a0)
; LMULMAX1-NEXT:    vse32.v v26, (a1)
; LMULMAX1-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %b = sext <8 x i8> %a to <8 x i32>
  store <8 x i32> %b, <8 x i32>* %z
  ret void
}

define void @sext_v32i8_v32i32(<32 x i8>* %x, <32 x i32>* %z) {
; LMULMAX8-LABEL: sext_v32i8_v32i32:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    addi a2, zero, 32
; LMULMAX8-NEXT:    vsetvli a3, a2, e8,m2,ta,mu
; LMULMAX8-NEXT:    vle8.v v26, (a0)
; LMULMAX8-NEXT:    vsetvli a0, a2, e32,m8,ta,mu
; LMULMAX8-NEXT:    vsext.vf4 v8, v26
; LMULMAX8-NEXT:    vse32.v v8, (a1)
; LMULMAX8-NEXT:    ret
;
; LMULMAX2-LABEL: sext_v32i8_v32i32:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    addi a2, zero, 32
; LMULMAX2-NEXT:    vsetvli a2, a2, e8,m2,ta,mu
; LMULMAX2-NEXT:    vle8.v v26, (a0)
; LMULMAX2-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; LMULMAX2-NEXT:    vslidedown.vi v25, v26, 8
; LMULMAX2-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; LMULMAX2-NEXT:    vsext.vf4 v28, v25
; LMULMAX2-NEXT:    vsetivli a0, 16, e8,m2,ta,mu
; LMULMAX2-NEXT:    vslidedown.vi v30, v26, 16
; LMULMAX2-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; LMULMAX2-NEXT:    vslidedown.vi v25, v30, 8
; LMULMAX2-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; LMULMAX2-NEXT:    vsext.vf4 v8, v25
; LMULMAX2-NEXT:    vsext.vf4 v10, v26
; LMULMAX2-NEXT:    vsext.vf4 v26, v30
; LMULMAX2-NEXT:    addi a0, a1, 64
; LMULMAX2-NEXT:    vse32.v v26, (a0)
; LMULMAX2-NEXT:    vse32.v v10, (a1)
; LMULMAX2-NEXT:    addi a0, a1, 96
; LMULMAX2-NEXT:    vse32.v v8, (a0)
; LMULMAX2-NEXT:    addi a0, a1, 32
; LMULMAX2-NEXT:    vse32.v v28, (a0)
; LMULMAX2-NEXT:    ret
;
; LMULMAX1-LABEL: sext_v32i8_v32i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a2, 16, e8,m1,ta,mu
; LMULMAX1-NEXT:    addi a2, a0, 16
; LMULMAX1-NEXT:    vle8.v v25, (a2)
; LMULMAX1-NEXT:    vle8.v v26, (a0)
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v27, v25, 4
; LMULMAX1-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vsext.vf4 v28, v27
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v27, v26, 4
; LMULMAX1-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vsext.vf4 v29, v27
; LMULMAX1-NEXT:    vsext.vf4 v27, v25
; LMULMAX1-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v25, v25, 8
; LMULMAX1-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vsext.vf4 v30, v25
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v25, v25, 4
; LMULMAX1-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vsext.vf4 v31, v25
; LMULMAX1-NEXT:    vsext.vf4 v25, v26
; LMULMAX1-NEXT:    vsetivli a0, 8, e8,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v26, v26, 8
; LMULMAX1-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vsext.vf4 v8, v26
; LMULMAX1-NEXT:    vsetivli a0, 4, e8,m1,ta,mu
; LMULMAX1-NEXT:    vslidedown.vi v26, v26, 4
; LMULMAX1-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vsext.vf4 v9, v26
; LMULMAX1-NEXT:    addi a0, a1, 48
; LMULMAX1-NEXT:    vse32.v v9, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 32
; LMULMAX1-NEXT:    vse32.v v8, (a0)
; LMULMAX1-NEXT:    vse32.v v25, (a1)
; LMULMAX1-NEXT:    addi a0, a1, 112
; LMULMAX1-NEXT:    vse32.v v31, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 96
; LMULMAX1-NEXT:    vse32.v v30, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 64
; LMULMAX1-NEXT:    vse32.v v27, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 16
; LMULMAX1-NEXT:    vse32.v v29, (a0)
; LMULMAX1-NEXT:    addi a0, a1, 80
; LMULMAX1-NEXT:    vse32.v v28, (a0)
; LMULMAX1-NEXT:    ret
  %a = load <32 x i8>, <32 x i8>* %x
  %b = sext <32 x i8> %a to <32 x i32>
  store <32 x i32> %b, <32 x i32>* %z
  ret void
}
