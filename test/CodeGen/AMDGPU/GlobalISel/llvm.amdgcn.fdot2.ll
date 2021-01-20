; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx906 -verify-machineinstrs < %s | FileCheck --check-prefix=GFX906 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx1011 -verify-machineinstrs < %s | FileCheck --check-prefix=GFX10 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx1012 -verify-machineinstrs < %s | FileCheck --check-prefix=GFX10 %s

define float @v_fdot2(<2 x half> %a, <2 x half> %b, float %c) {
; GFX906-LABEL: v_fdot2:
; GFX906:       ; %bb.0:
; GFX906-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX906-NEXT:    v_dot2_f32_f16 v0, v0, v1, v2
; GFX906-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_fdot2:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_dot2_f32_f16 v0, v0, v1, v2
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %r = call float @llvm.amdgcn.fdot2(<2 x half> %a, <2 x half> %b, float %c, i1 false)
  ret float %r
}

define float @v_fdot2_clamp(<2 x half> %a, <2 x half> %b, float %c) {
; GFX906-LABEL: v_fdot2_clamp:
; GFX906:       ; %bb.0:
; GFX906-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX906-NEXT:    v_dot2_f32_f16 v0, v0, v1, v2 clamp
; GFX906-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_fdot2_clamp:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_dot2_f32_f16 v0, v0, v1, v2 clamp
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %r = call float @llvm.amdgcn.fdot2(<2 x half> %a, <2 x half> %b, float %c, i1 true)
  ret float %r
}

define float @v_fdot2_neg_a(<2 x half> %a, <2 x half> %b, float %c) {
; GFX906-LABEL: v_fdot2_neg_a:
; GFX906:       ; %bb.0:
; GFX906-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX906-NEXT:    v_dot2_f32_f16 v0, v0, v1, v2 neg_lo:[1,0,0] neg_hi:[1,0,0]
; GFX906-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_fdot2_neg_a:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_dot2_f32_f16 v0, v0, v1, v2 neg_lo:[1,0,0] neg_hi:[1,0,0]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %neg.a = fneg <2 x half> %a
  %r = call float @llvm.amdgcn.fdot2(<2 x half> %neg.a, <2 x half> %b, float %c, i1 false)
  ret float %r
}

define float @v_fdot2_neg_b(<2 x half> %a, <2 x half> %b, float %c) {
; GFX906-LABEL: v_fdot2_neg_b:
; GFX906:       ; %bb.0:
; GFX906-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX906-NEXT:    v_dot2_f32_f16 v0, v0, v1, v2 neg_lo:[0,1,0] neg_hi:[0,1,0]
; GFX906-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_fdot2_neg_b:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_dot2_f32_f16 v0, v0, v1, v2 neg_lo:[0,1,0] neg_hi:[0,1,0]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %neg.b = fneg <2 x half> %b
  %r = call float @llvm.amdgcn.fdot2(<2 x half> %a, <2 x half> %neg.b, float %c, i1 false)
  ret float %r
}

define float @v_fdot2_neg_a_neg_b(<2 x half> %a, <2 x half> %b, float %c) {
; GFX906-LABEL: v_fdot2_neg_a_neg_b:
; GFX906:       ; %bb.0:
; GFX906-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX906-NEXT:    v_dot2_f32_f16 v0, v1, v1, v2 neg_lo:[1,1,0] neg_hi:[1,1,0]
; GFX906-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_fdot2_neg_a_neg_b:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_dot2_f32_f16 v0, v1, v1, v2 neg_lo:[1,1,0] neg_hi:[1,1,0]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %neg.a = fneg <2 x half> %b
  %neg.b = fneg <2 x half> %b
  %r = call float @llvm.amdgcn.fdot2(<2 x half> %neg.a, <2 x half> %neg.b, float %c, i1 false)
  ret float %r
}

define float @v_fdot2_neg_c(<2 x half> %a, <2 x half> %b, float %c) {
; GFX906-LABEL: v_fdot2_neg_c:
; GFX906:       ; %bb.0:
; GFX906-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX906-NEXT:    v_xor_b32_e32 v2, 0x80000000, v2
; GFX906-NEXT:    v_dot2_f32_f16 v0, v0, v1, v2
; GFX906-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_fdot2_neg_c:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_xor_b32_e32 v2, 0x80000000, v2
; GFX10-NEXT:    v_dot2_f32_f16 v0, v0, v1, v2
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %neg.c = fneg float %c
  %r = call float @llvm.amdgcn.fdot2(<2 x half> %a, <2 x half> %b, float %neg.c, i1 false)
  ret float %r
}

define float @v_fdot2_inline_literal_a(<2 x half> %b, float %c) {
; GFX906-LABEL: v_fdot2_inline_literal_a:
; GFX906:       ; %bb.0:
; GFX906-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX906-NEXT:    v_dot2_f32_f16 v0, 2.0, v0, v1 op_sel_hi:[0,1,1]
; GFX906-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_fdot2_inline_literal_a:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_dot2_f32_f16 v0, 2.0, v0, v1 op_sel_hi:[0,1,1]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call float @llvm.amdgcn.fdot2(<2 x half> <half 2.0, half 2.0>, <2 x half> %b, float %c, i1 false)
  ret float %ret
}

define float @v_fdot2_inline_literal_b(<2 x half> %a, float %c) {
; GFX906-LABEL: v_fdot2_inline_literal_b:
; GFX906:       ; %bb.0:
; GFX906-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX906-NEXT:    v_dot2_f32_f16 v0, v0, 2.0, v1 op_sel_hi:[1,0,1]
; GFX906-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_fdot2_inline_literal_b:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_dot2_f32_f16 v0, v0, 2.0, v1 op_sel_hi:[1,0,1]
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call float @llvm.amdgcn.fdot2(<2 x half> %a, <2 x half> <half 2.0, half 2.0>, float %c, i1 false)
  ret float %ret
}

define float @v_fdot2_inline_literal_c(<2 x half> %a, <2 x half> %b) {
; GFX906-LABEL: v_fdot2_inline_literal_c:
; GFX906:       ; %bb.0:
; GFX906-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX906-NEXT:    v_dot2_f32_f16 v0, v0, v1, 1.0
; GFX906-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: v_fdot2_inline_literal_c:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    v_dot2_f32_f16 v0, v0, v1, 1.0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call float @llvm.amdgcn.fdot2(<2 x half> %a, <2 x half> %b, float 1.0, i1 false)
  ret float %ret
}

declare float @llvm.amdgcn.fdot2(<2 x half>, <2 x half>, float, i1 immarg) #0

attributes #0 = { nounwind readnone speculatable }
