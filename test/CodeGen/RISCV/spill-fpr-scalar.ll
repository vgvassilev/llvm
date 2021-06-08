; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v,+d,+experimental-zfh \
; RUN:   -verify-machineinstrs < %s \
; RUN:   | FileCheck %s

declare half @llvm.riscv.vfmv.f.s.nxv1f16(<vscale x 1 x half>)
declare float @llvm.riscv.vfmv.f.s.nxv1f32(<vscale x 1 x float>)
declare double @llvm.riscv.vfmv.f.s.nxv1f64(<vscale x 1 x double>)

declare <vscale x 1 x half> @llvm.riscv.vfmv.v.f.nxv1f16(half, i64);
declare <vscale x 1 x float> @llvm.riscv.vfmv.v.f.nxv1f32(float, i64);
declare <vscale x 1 x double> @llvm.riscv.vfmv.v.f.nxv1f64(double, i64);

define <vscale x 1 x half> @intrinsic_vfmv.f.s_s_nxv1f16(<vscale x 1 x half> %0, i64 %1) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv1f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, mu
; CHECK-NEXT:    vfmv.f.s ft0, v8
; CHECK-NEXT:    fsh ft0, 14(sp) # 2-byte Folded Spill
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, mu
; CHECK-NEXT:    flh ft0, 14(sp) # 2-byte Folded Reload
; CHECK-NEXT:    vfmv.v.f v8, ft0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
entry:
  %a = call half @llvm.riscv.vfmv.f.s.nxv1f16(<vscale x 1 x half> %0)
  tail call void asm sideeffect "", "~{f0_d},~{f1_d},~{f2_d},~{f3_d},~{f4_d},~{f5_d},~{f6_d},~{f7_d},~{f8_d},~{f9_d},~{f10_d},~{f11_d},~{f12_d},~{f13_d},~{f14_d},~{f15_d},~{f16_d},~{f17_d},~{f18_d},~{f19_d},~{f20_d},~{f21_d},~{f22_d},~{f23_d},~{f24_d},~{f25_d},~{f26_d},~{f27_d},~{f28_d},~{f29_d},~{f30_d},~{f31_d}"()
  %b = call <vscale x 1 x half> @llvm.riscv.vfmv.v.f.nxv1f16(half %a, i64 %1)
  ret <vscale x 1 x half> %b
}

define <vscale x 1 x float> @intrinsic_vfmv.f.s_s_nxv1f32(<vscale x 1 x float> %0, i64 %1) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv1f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, mu
; CHECK-NEXT:    vfmv.f.s ft0, v8
; CHECK-NEXT:    fsw ft0, 12(sp) # 4-byte Folded Spill
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, mu
; CHECK-NEXT:    flw ft0, 12(sp) # 4-byte Folded Reload
; CHECK-NEXT:    vfmv.v.f v8, ft0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
entry:
  %a = call float @llvm.riscv.vfmv.f.s.nxv1f32(<vscale x 1 x float> %0)
  tail call void asm sideeffect "", "~{f0_d},~{f1_d},~{f2_d},~{f3_d},~{f4_d},~{f5_d},~{f6_d},~{f7_d},~{f8_d},~{f9_d},~{f10_d},~{f11_d},~{f12_d},~{f13_d},~{f14_d},~{f15_d},~{f16_d},~{f17_d},~{f18_d},~{f19_d},~{f20_d},~{f21_d},~{f22_d},~{f23_d},~{f24_d},~{f25_d},~{f26_d},~{f27_d},~{f28_d},~{f29_d},~{f30_d},~{f31_d}"()
  %b = call <vscale x 1 x float> @llvm.riscv.vfmv.v.f.nxv1f32(float %a, i64 %1)
  ret <vscale x 1 x float> %b
}

define <vscale x 1 x double> @intrinsic_vfmv.f.s_s_nxv1f64(<vscale x 1 x double> %0, i64 %1) nounwind {
; CHECK-LABEL: intrinsic_vfmv.f.s_s_nxv1f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    vsetvli zero, zero, e64, m1, ta, mu
; CHECK-NEXT:    vfmv.f.s ft0, v8
; CHECK-NEXT:    fsd ft0, 8(sp) # 8-byte Folded Spill
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, mu
; CHECK-NEXT:    fld ft0, 8(sp) # 8-byte Folded Reload
; CHECK-NEXT:    vfmv.v.f v8, ft0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
entry:
  %a = call double @llvm.riscv.vfmv.f.s.nxv1f64(<vscale x 1 x double> %0)
  tail call void asm sideeffect "", "~{f0_d},~{f1_d},~{f2_d},~{f3_d},~{f4_d},~{f5_d},~{f6_d},~{f7_d},~{f8_d},~{f9_d},~{f10_d},~{f11_d},~{f12_d},~{f13_d},~{f14_d},~{f15_d},~{f16_d},~{f17_d},~{f18_d},~{f19_d},~{f20_d},~{f21_d},~{f22_d},~{f23_d},~{f24_d},~{f25_d},~{f26_d},~{f27_d},~{f28_d},~{f29_d},~{f30_d},~{f31_d}"()
  %b = call <vscale x 1 x double> @llvm.riscv.vfmv.v.f.nxv1f64(double %a, i64 %1)
  ret <vscale x 1 x double> %b
}
