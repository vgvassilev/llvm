; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+experimental-v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+m,+experimental-v -verify-machineinstrs < %s | FileCheck %s

declare i1 @llvm.vector.reduce.or.nxv1i1(<vscale x 1 x i1>)

define signext i1 @vreduce_or_nxv1i1(<vscale x 1 x i1> %v) {
; CHECK-LABEL: vreduce_or_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf8,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.nxv1i1(<vscale x 1 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.nxv1i1(<vscale x 1 x i1>)

define signext i1 @vreduce_xor_nxv1i1(<vscale x 1 x i1> %v) {
; CHECK-LABEL: vreduce_xor_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf8,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.nxv1i1(<vscale x 1 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.nxv1i1(<vscale x 1 x i1>)

define signext i1 @vreduce_and_nxv1i1(<vscale x 1 x i1> %v) {
; CHECK-LABEL: vreduce_and_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf8,ta,mu
; CHECK-NEXT:    vmnand.mm v25, v0, v0
; CHECK-NEXT:    vpopc.m a0, v25
; CHECK-NEXT:    seqz a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.nxv1i1(<vscale x 1 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.nxv2i1(<vscale x 2 x i1>)

define signext i1 @vreduce_or_nxv2i1(<vscale x 2 x i1> %v) {
; CHECK-LABEL: vreduce_or_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf4,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.nxv2i1(<vscale x 2 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.nxv2i1(<vscale x 2 x i1>)

define signext i1 @vreduce_xor_nxv2i1(<vscale x 2 x i1> %v) {
; CHECK-LABEL: vreduce_xor_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf4,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.nxv2i1(<vscale x 2 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.nxv2i1(<vscale x 2 x i1>)

define signext i1 @vreduce_and_nxv2i1(<vscale x 2 x i1> %v) {
; CHECK-LABEL: vreduce_and_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf4,ta,mu
; CHECK-NEXT:    vmnand.mm v25, v0, v0
; CHECK-NEXT:    vpopc.m a0, v25
; CHECK-NEXT:    seqz a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.nxv2i1(<vscale x 2 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1>)

define signext i1 @vreduce_or_nxv4i1(<vscale x 4 x i1> %v) {
; CHECK-LABEL: vreduce_or_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf2,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.nxv4i1(<vscale x 4 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.nxv4i1(<vscale x 4 x i1>)

define signext i1 @vreduce_xor_nxv4i1(<vscale x 4 x i1> %v) {
; CHECK-LABEL: vreduce_xor_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf2,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.nxv4i1(<vscale x 4 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.nxv4i1(<vscale x 4 x i1>)

define signext i1 @vreduce_and_nxv4i1(<vscale x 4 x i1> %v) {
; CHECK-LABEL: vreduce_and_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf2,ta,mu
; CHECK-NEXT:    vmnand.mm v25, v0, v0
; CHECK-NEXT:    vpopc.m a0, v25
; CHECK-NEXT:    seqz a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.nxv4i1(<vscale x 4 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.nxv8i1(<vscale x 8 x i1>)

define signext i1 @vreduce_or_nxv8i1(<vscale x 8 x i1> %v) {
; CHECK-LABEL: vreduce_or_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m1,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.nxv8i1(<vscale x 8 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.nxv8i1(<vscale x 8 x i1>)

define signext i1 @vreduce_xor_nxv8i1(<vscale x 8 x i1> %v) {
; CHECK-LABEL: vreduce_xor_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m1,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.nxv8i1(<vscale x 8 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.nxv8i1(<vscale x 8 x i1>)

define signext i1 @vreduce_and_nxv8i1(<vscale x 8 x i1> %v) {
; CHECK-LABEL: vreduce_and_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m1,ta,mu
; CHECK-NEXT:    vmnand.mm v25, v0, v0
; CHECK-NEXT:    vpopc.m a0, v25
; CHECK-NEXT:    seqz a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.nxv8i1(<vscale x 8 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.nxv16i1(<vscale x 16 x i1>)

define signext i1 @vreduce_or_nxv16i1(<vscale x 16 x i1> %v) {
; CHECK-LABEL: vreduce_or_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m2,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.nxv16i1(<vscale x 16 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.nxv16i1(<vscale x 16 x i1>)

define signext i1 @vreduce_xor_nxv16i1(<vscale x 16 x i1> %v) {
; CHECK-LABEL: vreduce_xor_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m2,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.nxv16i1(<vscale x 16 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.nxv16i1(<vscale x 16 x i1>)

define signext i1 @vreduce_and_nxv16i1(<vscale x 16 x i1> %v) {
; CHECK-LABEL: vreduce_and_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m2,ta,mu
; CHECK-NEXT:    vmnand.mm v25, v0, v0
; CHECK-NEXT:    vpopc.m a0, v25
; CHECK-NEXT:    seqz a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.nxv16i1(<vscale x 16 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.nxv32i1(<vscale x 32 x i1>)

define signext i1 @vreduce_or_nxv32i1(<vscale x 32 x i1> %v) {
; CHECK-LABEL: vreduce_or_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m4,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.nxv32i1(<vscale x 32 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.nxv32i1(<vscale x 32 x i1>)

define signext i1 @vreduce_xor_nxv32i1(<vscale x 32 x i1> %v) {
; CHECK-LABEL: vreduce_xor_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m4,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.nxv32i1(<vscale x 32 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.nxv32i1(<vscale x 32 x i1>)

define signext i1 @vreduce_and_nxv32i1(<vscale x 32 x i1> %v) {
; CHECK-LABEL: vreduce_and_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m4,ta,mu
; CHECK-NEXT:    vmnand.mm v25, v0, v0
; CHECK-NEXT:    vpopc.m a0, v25
; CHECK-NEXT:    seqz a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.nxv32i1(<vscale x 32 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.nxv64i1(<vscale x 64 x i1>)

define signext i1 @vreduce_or_nxv64i1(<vscale x 64 x i1> %v) {
; CHECK-LABEL: vreduce_or_nxv64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m8,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.nxv64i1(<vscale x 64 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.nxv64i1(<vscale x 64 x i1>)

define signext i1 @vreduce_xor_nxv64i1(<vscale x 64 x i1> %v) {
; CHECK-LABEL: vreduce_xor_nxv64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m8,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.nxv64i1(<vscale x 64 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.nxv64i1(<vscale x 64 x i1>)

define signext i1 @vreduce_and_nxv64i1(<vscale x 64 x i1> %v) {
; CHECK-LABEL: vreduce_and_nxv64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m8,ta,mu
; CHECK-NEXT:    vmnand.mm v25, v0, v0
; CHECK-NEXT:    vpopc.m a0, v25
; CHECK-NEXT:    seqz a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.nxv64i1(<vscale x 64 x i1> %v)
  ret i1 %red
}
