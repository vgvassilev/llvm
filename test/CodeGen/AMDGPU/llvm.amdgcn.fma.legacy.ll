; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1030 < %s | FileCheck -check-prefix=GCN %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1030 < %s | FileCheck -check-prefix=GCN %s

define float @v_fma(float %a, float %b, float %c)  {
; GCN-LABEL: v_fma:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_waitcnt_vscnt null, 0x0
; GCN-NEXT:    v_fmac_legacy_f32_e64 v2, v0, v1
; GCN-NEXT:    ; implicit-def: $vcc_hi
; GCN-NEXT:    v_mov_b32_e32 v0, v2
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %fma = call float @llvm.amdgcn.fma.legacy(float %a, float %b, float %c)
  ret float %fma
}

define float @v_fabs_fma(float %a, float %b, float %c)  {
; GCN-LABEL: v_fabs_fma:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_waitcnt_vscnt null, 0x0
; GCN-NEXT:    v_fma_legacy_f32 v0, |v0|, v1, v2
; GCN-NEXT:    ; implicit-def: $vcc_hi
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %fabs.a = call float @llvm.fabs.f32(float %a)
  %fma = call float @llvm.amdgcn.fma.legacy(float %fabs.a, float %b, float %c)
  ret float %fma
}

define float @v_fneg_fabs_fma(float %a, float %b, float %c)  {
; GCN-LABEL: v_fneg_fabs_fma:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_waitcnt_vscnt null, 0x0
; GCN-NEXT:    v_fma_legacy_f32 v0, v0, -|v1|, v2
; GCN-NEXT:    ; implicit-def: $vcc_hi
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %fabs.b = call float @llvm.fabs.f32(float %b)
  %neg.fabs.b = fneg float %fabs.b
  %fma = call float @llvm.amdgcn.fma.legacy(float %a, float %neg.fabs.b, float %c)
  ret float %fma
}

define float @v_fneg_fma(float %a, float %b, float %c)  {
; GCN-LABEL: v_fneg_fma:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_waitcnt_vscnt null, 0x0
; GCN-NEXT:    v_fma_legacy_f32 v0, v0, v1, -v2
; GCN-NEXT:    ; implicit-def: $vcc_hi
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %neg.c = fneg float %c
  %fma = call float @llvm.amdgcn.fma.legacy(float %a, float %b, float %neg.c)
  ret float %fma
}

declare float @llvm.amdgcn.fma.legacy(float, float, float)
declare float @llvm.fabs.f32(float)
