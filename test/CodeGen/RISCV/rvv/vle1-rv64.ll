; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -verify-machineinstrs \
; RUN:   --riscv-no-aliases < %s | FileCheck %s

declare <vscale x 1 x i1> @llvm.riscv.vle1.nxv1i1(<vscale x 1 x i1>*, i64);

define <vscale x 1 x i1> @intrinsic_vle1_v_nxv1i1(<vscale x 1 x i1>* %0, i64 %1) nounwind {
; CHECK-LABEL: intrinsic_vle1_v_nxv1i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf8,ta,mu
; CHECK-NEXT:    vle1.v v0, (a0)
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x i1> @llvm.riscv.vle1.nxv1i1(<vscale x 1 x i1>* %0, i64 %1)
  ret <vscale x 1 x i1> %a
}

declare <vscale x 2 x i1> @llvm.riscv.vle1.nxv2i1(<vscale x 2 x i1>*, i64);

define <vscale x 2 x i1> @intrinsic_vle1_v_nxv2i1(<vscale x 2 x i1>* %0, i64 %1) nounwind {
; CHECK-LABEL: intrinsic_vle1_v_nxv2i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf4,ta,mu
; CHECK-NEXT:    vle1.v v0, (a0)
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x i1> @llvm.riscv.vle1.nxv2i1(<vscale x 2 x i1>* %0, i64 %1)
  ret <vscale x 2 x i1> %a
}

declare <vscale x 4 x i1> @llvm.riscv.vle1.nxv4i1(<vscale x 4 x i1>*, i64);

define <vscale x 4 x i1> @intrinsic_vle1_v_nxv4i1(<vscale x 4 x i1>* %0, i64 %1) nounwind {
; CHECK-LABEL: intrinsic_vle1_v_nxv4i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf2,ta,mu
; CHECK-NEXT:    vle1.v v0, (a0)
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x i1> @llvm.riscv.vle1.nxv4i1(<vscale x 4 x i1>* %0, i64 %1)
  ret <vscale x 4 x i1> %a
}

declare <vscale x 8 x i1> @llvm.riscv.vle1.nxv8i1(<vscale x 8 x i1>*, i64);

define <vscale x 8 x i1> @intrinsic_vle1_v_nxv8i1(<vscale x 8 x i1>* %0, i64 %1) nounwind {
; CHECK-LABEL: intrinsic_vle1_v_nxv8i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m1,ta,mu
; CHECK-NEXT:    vle1.v v0, (a0)
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x i1> @llvm.riscv.vle1.nxv8i1(<vscale x 8 x i1>* %0, i64 %1)
  ret <vscale x 8 x i1> %a
}

declare <vscale x 16 x i1> @llvm.riscv.vle1.nxv16i1(<vscale x 16 x i1>*, i64);

define <vscale x 16 x i1> @intrinsic_vle1_v_nxv16i1(<vscale x 16 x i1>* %0, i64 %1) nounwind {
; CHECK-LABEL: intrinsic_vle1_v_nxv16i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m2,ta,mu
; CHECK-NEXT:    vle1.v v0, (a0)
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x i1> @llvm.riscv.vle1.nxv16i1(<vscale x 16 x i1>* %0, i64 %1)
  ret <vscale x 16 x i1> %a
}

declare <vscale x 32 x i1> @llvm.riscv.vle1.nxv32i1(<vscale x 32 x i1>*, i64);

define <vscale x 32 x i1> @intrinsic_vle1_v_nxv32i1(<vscale x 32 x i1>* %0, i64 %1) nounwind {
; CHECK-LABEL: intrinsic_vle1_v_nxv32i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m4,ta,mu
; CHECK-NEXT:    vle1.v v0, (a0)
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 32 x i1> @llvm.riscv.vle1.nxv32i1(<vscale x 32 x i1>* %0, i64 %1)
  ret <vscale x 32 x i1> %a
}

declare <vscale x 64 x i1> @llvm.riscv.vle1.nxv64i1(<vscale x 64 x i1>*, i64);

define <vscale x 64 x i1> @intrinsic_vle1_v_nxv64i1(<vscale x 64 x i1>* %0, i64 %1) nounwind {
; CHECK-LABEL: intrinsic_vle1_v_nxv64i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m8,ta,mu
; CHECK-NEXT:    vle1.v v0, (a0)
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 64 x i1> @llvm.riscv.vle1.nxv64i1(<vscale x 64 x i1>* %0, i64 %1)
  ret <vscale x 64 x i1> %a
}
