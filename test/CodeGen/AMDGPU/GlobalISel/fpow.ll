; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -march=amdgcn -mcpu=tahiti < %s | FileCheck -check-prefix=GFX6 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=fiji < %s | FileCheck -check-prefix=GFX8 %s
; RUN: llc -global-isel -march=amdgcn -mcpu=gfx900 < %s | FileCheck -check-prefix=GFX9 %s

define float @v_pow_f32(float %x, float %y) {
; GFX6-LABEL: v_pow_f32:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    v_log_f32_e32 v0, v0
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_f32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_log_f32_e32 v0, v0
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX8-NEXT:    v_exp_f32_e32 v0, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_f32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_log_f32_e32 v0, v0
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX9-NEXT:    v_exp_f32_e32 v0, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %pow = call float @llvm.pow.f32(float %x, float %y)
  ret float %pow
}

define <2 x float> @v_pow_v2f32(<2 x float> %x, <2 x float> %y) {
; GFX6-LABEL: v_pow_v2f32:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    v_log_f32_e32 v0, v0
; GFX6-NEXT:    v_log_f32_e32 v1, v1
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, v0, v2
; GFX6-NEXT:    v_mul_legacy_f32_e32 v1, v1, v3
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    v_exp_f32_e32 v1, v1
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_v2f32:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_log_f32_e32 v0, v0
; GFX8-NEXT:    v_log_f32_e32 v1, v1
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, v0, v2
; GFX8-NEXT:    v_mul_legacy_f32_e32 v1, v1, v3
; GFX8-NEXT:    v_exp_f32_e32 v0, v0
; GFX8-NEXT:    v_exp_f32_e32 v1, v1
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_v2f32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_log_f32_e32 v0, v0
; GFX9-NEXT:    v_log_f32_e32 v1, v1
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, v0, v2
; GFX9-NEXT:    v_mul_legacy_f32_e32 v1, v1, v3
; GFX9-NEXT:    v_exp_f32_e32 v0, v0
; GFX9-NEXT:    v_exp_f32_e32 v1, v1
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %pow = call <2 x float> @llvm.pow.v2f32(<2 x float> %x, <2 x float> %y)
  ret <2 x float> %pow
}

define half @v_pow_f16(half %x, half %y) {
; GFX6-LABEL: v_pow_f16:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v1, v1
; GFX6-NEXT:    v_log_f32_e32 v0, v0
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_f16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_log_f16_e32 v0, v0
; GFX8-NEXT:    v_cvt_f32_f16_e32 v1, v1
; GFX8-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX8-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX8-NEXT:    v_exp_f16_e32 v0, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_log_f16_e32 v0, v0
; GFX9-NEXT:    v_cvt_f32_f16_e32 v1, v1
; GFX9-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX9-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX9-NEXT:    v_exp_f16_e32 v0, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %pow = call half @llvm.pow.f16(half %x, half %y)
  ret half %pow
}

define <2 x half> @v_pow_v2f16(<2 x half> %x, <2 x half> %y) {
; GFX6-LABEL: v_pow_v2f16:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    v_lshrrev_b32_e32 v2, 16, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX6-NEXT:    v_lshrrev_b32_e32 v3, 16, v1
; GFX6-NEXT:    v_cvt_f32_f16_e32 v1, v1
; GFX6-NEXT:    v_log_f32_e32 v0, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v3, v3
; GFX6-NEXT:    v_log_f32_e32 v2, v2
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    v_mul_legacy_f32_e32 v1, v2, v3
; GFX6-NEXT:    v_exp_f32_e32 v1, v1
; GFX6-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX6-NEXT:    v_cvt_f16_f32_e32 v1, v1
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_v2f16:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_log_f16_e32 v2, v0
; GFX8-NEXT:    v_log_f16_sdwa v0, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX8-NEXT:    v_cvt_f32_f16_e32 v3, v1
; GFX8-NEXT:    v_cvt_f32_f16_sdwa v1, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX8-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX8-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX8-NEXT:    v_mul_legacy_f32_e32 v2, v2, v3
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX8-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX8-NEXT:    v_cvt_f16_f32_e32 v1, v2
; GFX8-NEXT:    v_mov_b32_e32 v2, 16
; GFX8-NEXT:    v_exp_f16_e32 v0, v0
; GFX8-NEXT:    v_exp_f16_e32 v1, v1
; GFX8-NEXT:    v_lshlrev_b32_sdwa v0, v2, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:WORD_0
; GFX8-NEXT:    v_or_b32_sdwa v0, v1, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_v2f16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_log_f16_e32 v2, v0
; GFX9-NEXT:    v_log_f16_sdwa v0, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-NEXT:    v_cvt_f32_f16_e32 v3, v1
; GFX9-NEXT:    v_cvt_f32_f16_sdwa v1, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX9-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX9-NEXT:    v_mul_legacy_f32_e32 v2, v2, v3
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX9-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX9-NEXT:    v_cvt_f16_f32_e32 v2, v2
; GFX9-NEXT:    v_exp_f16_sdwa v0, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD
; GFX9-NEXT:    v_exp_f16_e32 v1, v2
; GFX9-NEXT:    v_mov_b32_e32 v2, 0xffff
; GFX9-NEXT:    v_and_or_b32 v0, v1, v2, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %pow = call <2 x half> @llvm.pow.v2f16(<2 x half> %x, <2 x half> %y)
  ret <2 x half> %pow
}

define <2 x half> @v_pow_v2f16_fneg_lhs(<2 x half> %x, <2 x half> %y) {
; GFX6-LABEL: v_pow_v2f16_fneg_lhs:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    v_xor_b32_e32 v0, 0x80008000, v0
; GFX6-NEXT:    v_lshrrev_b32_e32 v2, 16, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX6-NEXT:    v_lshrrev_b32_e32 v3, 16, v1
; GFX6-NEXT:    v_cvt_f32_f16_e32 v1, v1
; GFX6-NEXT:    v_log_f32_e32 v0, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v3, v3
; GFX6-NEXT:    v_log_f32_e32 v2, v2
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    v_mul_legacy_f32_e32 v1, v2, v3
; GFX6-NEXT:    v_exp_f32_e32 v1, v1
; GFX6-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX6-NEXT:    v_cvt_f16_f32_e32 v1, v1
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_v2f16_fneg_lhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_xor_b32_e32 v0, 0x80008000, v0
; GFX8-NEXT:    v_log_f16_e32 v2, v0
; GFX8-NEXT:    v_log_f16_sdwa v0, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX8-NEXT:    v_cvt_f32_f16_e32 v3, v1
; GFX8-NEXT:    v_cvt_f32_f16_sdwa v1, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX8-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX8-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX8-NEXT:    v_mul_legacy_f32_e32 v2, v2, v3
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX8-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX8-NEXT:    v_cvt_f16_f32_e32 v1, v2
; GFX8-NEXT:    v_mov_b32_e32 v2, 16
; GFX8-NEXT:    v_exp_f16_e32 v0, v0
; GFX8-NEXT:    v_exp_f16_e32 v1, v1
; GFX8-NEXT:    v_lshlrev_b32_sdwa v0, v2, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:WORD_0
; GFX8-NEXT:    v_or_b32_sdwa v0, v1, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_v2f16_fneg_lhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_xor_b32_e32 v0, 0x80008000, v0
; GFX9-NEXT:    v_log_f16_e32 v2, v0
; GFX9-NEXT:    v_log_f16_sdwa v0, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-NEXT:    v_cvt_f32_f16_e32 v3, v1
; GFX9-NEXT:    v_cvt_f32_f16_sdwa v1, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX9-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX9-NEXT:    v_mul_legacy_f32_e32 v2, v2, v3
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX9-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX9-NEXT:    v_cvt_f16_f32_e32 v2, v2
; GFX9-NEXT:    v_exp_f16_sdwa v0, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD
; GFX9-NEXT:    v_exp_f16_e32 v1, v2
; GFX9-NEXT:    v_mov_b32_e32 v2, 0xffff
; GFX9-NEXT:    v_and_or_b32 v0, v1, v2, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %x.fneg = fneg <2 x half> %x
  %pow = call <2 x half> @llvm.pow.v2f16(<2 x half> %x.fneg, <2 x half> %y)
  ret <2 x half> %pow
}

define <2 x half> @v_pow_v2f16_fneg_rhs(<2 x half> %x, <2 x half> %y) {
; GFX6-LABEL: v_pow_v2f16_fneg_rhs:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    v_lshrrev_b32_e32 v2, 16, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX6-NEXT:    v_xor_b32_e32 v1, 0x80008000, v1
; GFX6-NEXT:    v_lshrrev_b32_e32 v3, 16, v1
; GFX6-NEXT:    v_cvt_f32_f16_e32 v1, v1
; GFX6-NEXT:    v_log_f32_e32 v0, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v3, v3
; GFX6-NEXT:    v_log_f32_e32 v2, v2
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    v_mul_legacy_f32_e32 v1, v2, v3
; GFX6-NEXT:    v_exp_f32_e32 v1, v1
; GFX6-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX6-NEXT:    v_cvt_f16_f32_e32 v1, v1
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_v2f16_fneg_rhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_log_f16_e32 v2, v0
; GFX8-NEXT:    v_log_f16_sdwa v0, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX8-NEXT:    v_xor_b32_e32 v1, 0x80008000, v1
; GFX8-NEXT:    v_cvt_f32_f16_e32 v3, v1
; GFX8-NEXT:    v_cvt_f32_f16_sdwa v1, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX8-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX8-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX8-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX8-NEXT:    v_mul_legacy_f32_e32 v2, v2, v3
; GFX8-NEXT:    v_cvt_f16_f32_e32 v1, v2
; GFX8-NEXT:    v_mov_b32_e32 v2, 16
; GFX8-NEXT:    v_exp_f16_e32 v0, v0
; GFX8-NEXT:    v_exp_f16_e32 v1, v1
; GFX8-NEXT:    v_lshlrev_b32_sdwa v0, v2, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:WORD_0
; GFX8-NEXT:    v_or_b32_sdwa v0, v1, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_v2f16_fneg_rhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_log_f16_e32 v2, v0
; GFX9-NEXT:    v_log_f16_sdwa v0, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-NEXT:    v_xor_b32_e32 v1, 0x80008000, v1
; GFX9-NEXT:    v_cvt_f32_f16_e32 v3, v1
; GFX9-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX9-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX9-NEXT:    v_cvt_f32_f16_sdwa v1, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-NEXT:    v_mul_legacy_f32_e32 v2, v2, v3
; GFX9-NEXT:    v_cvt_f16_f32_e32 v2, v2
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX9-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX9-NEXT:    v_exp_f16_e32 v1, v2
; GFX9-NEXT:    v_mov_b32_e32 v2, 0xffff
; GFX9-NEXT:    v_exp_f16_sdwa v0, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD
; GFX9-NEXT:    v_and_or_b32 v0, v1, v2, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %y.fneg = fneg <2 x half> %y
  %pow = call <2 x half> @llvm.pow.v2f16(<2 x half> %x, <2 x half> %y.fneg)
  ret <2 x half> %pow
}

define <2 x half> @v_pow_v2f16_fneg_lhs_rhs(<2 x half> %x, <2 x half> %y) {
; GFX6-LABEL: v_pow_v2f16_fneg_lhs_rhs:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    s_mov_b32 s4, 0x80008000
; GFX6-NEXT:    v_xor_b32_e32 v0, s4, v0
; GFX6-NEXT:    v_lshrrev_b32_e32 v2, 16, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX6-NEXT:    v_xor_b32_e32 v1, s4, v1
; GFX6-NEXT:    v_lshrrev_b32_e32 v3, 16, v1
; GFX6-NEXT:    v_cvt_f32_f16_e32 v1, v1
; GFX6-NEXT:    v_log_f32_e32 v0, v0
; GFX6-NEXT:    v_cvt_f32_f16_e32 v3, v3
; GFX6-NEXT:    v_log_f32_e32 v2, v2
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    v_mul_legacy_f32_e32 v1, v2, v3
; GFX6-NEXT:    v_exp_f32_e32 v1, v1
; GFX6-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX6-NEXT:    v_cvt_f16_f32_e32 v1, v1
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_v2f16_fneg_lhs_rhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    s_mov_b32 s4, 0x80008000
; GFX8-NEXT:    v_xor_b32_e32 v0, s4, v0
; GFX8-NEXT:    v_log_f16_e32 v2, v0
; GFX8-NEXT:    v_log_f16_sdwa v0, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX8-NEXT:    v_xor_b32_e32 v1, s4, v1
; GFX8-NEXT:    v_cvt_f32_f16_e32 v3, v1
; GFX8-NEXT:    v_cvt_f32_f16_sdwa v1, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX8-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX8-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX8-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX8-NEXT:    v_mul_legacy_f32_e32 v2, v2, v3
; GFX8-NEXT:    v_cvt_f16_f32_e32 v1, v2
; GFX8-NEXT:    v_mov_b32_e32 v2, 16
; GFX8-NEXT:    v_exp_f16_e32 v0, v0
; GFX8-NEXT:    v_exp_f16_e32 v1, v1
; GFX8-NEXT:    v_lshlrev_b32_sdwa v0, v2, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:WORD_0
; GFX8-NEXT:    v_or_b32_sdwa v0, v1, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_v2f16_fneg_lhs_rhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    s_mov_b32 s4, 0x80008000
; GFX9-NEXT:    v_xor_b32_e32 v0, s4, v0
; GFX9-NEXT:    v_log_f16_e32 v2, v0
; GFX9-NEXT:    v_log_f16_sdwa v0, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-NEXT:    v_xor_b32_e32 v1, s4, v1
; GFX9-NEXT:    v_cvt_f32_f16_e32 v3, v1
; GFX9-NEXT:    v_cvt_f32_f16_e32 v2, v2
; GFX9-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GFX9-NEXT:    v_cvt_f32_f16_sdwa v1, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; GFX9-NEXT:    v_mul_legacy_f32_e32 v2, v2, v3
; GFX9-NEXT:    v_cvt_f16_f32_e32 v2, v2
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX9-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GFX9-NEXT:    v_exp_f16_e32 v1, v2
; GFX9-NEXT:    v_mov_b32_e32 v2, 0xffff
; GFX9-NEXT:    v_exp_f16_sdwa v0, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD
; GFX9-NEXT:    v_and_or_b32 v0, v1, v2, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %x.fneg = fneg <2 x half> %x
  %y.fneg = fneg <2 x half> %y
  %pow = call <2 x half> @llvm.pow.v2f16(<2 x half> %x.fneg, <2 x half> %y.fneg)
  ret <2 x half> %pow
}

; FIXME
; define double @v_pow_f64(double %x, double %y) {
;   %pow = call double @llvm.pow.f64(double %x, double %y)
;   ret double %pow
; }

define float @v_pow_f32_fabs_lhs(float %x, float %y) {
; GFX6-LABEL: v_pow_f32_fabs_lhs:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    v_log_f32_e64 v0, |v0|
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_f32_fabs_lhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_log_f32_e64 v0, |v0|
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX8-NEXT:    v_exp_f32_e32 v0, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_f32_fabs_lhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_log_f32_e64 v0, |v0|
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX9-NEXT:    v_exp_f32_e32 v0, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %fabs.x = call float @llvm.fabs.f32(float %x)
  %pow = call float @llvm.pow.f32(float %fabs.x, float %y)
  ret float %pow
}

define float @v_pow_f32_fabs_rhs(float %x, float %y) {
; GFX6-LABEL: v_pow_f32_fabs_rhs:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    v_log_f32_e32 v0, v0
; GFX6-NEXT:    v_mul_legacy_f32_e64 v0, v0, |v1|
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_f32_fabs_rhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_log_f32_e32 v0, v0
; GFX8-NEXT:    v_mul_legacy_f32_e64 v0, v0, |v1|
; GFX8-NEXT:    v_exp_f32_e32 v0, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_f32_fabs_rhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_log_f32_e32 v0, v0
; GFX9-NEXT:    v_mul_legacy_f32_e64 v0, v0, |v1|
; GFX9-NEXT:    v_exp_f32_e32 v0, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %fabs.y = call float @llvm.fabs.f32(float %y)
  %pow = call float @llvm.pow.f32(float %x, float %fabs.y)
  ret float %pow
}

define float @v_pow_f32_fabs_lhs_rhs(float %x, float %y) {
; GFX6-LABEL: v_pow_f32_fabs_lhs_rhs:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    v_log_f32_e64 v0, |v0|
; GFX6-NEXT:    v_mul_legacy_f32_e64 v0, v0, |v1|
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_f32_fabs_lhs_rhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_log_f32_e64 v0, |v0|
; GFX8-NEXT:    v_mul_legacy_f32_e64 v0, v0, |v1|
; GFX8-NEXT:    v_exp_f32_e32 v0, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_f32_fabs_lhs_rhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_log_f32_e64 v0, |v0|
; GFX9-NEXT:    v_mul_legacy_f32_e64 v0, v0, |v1|
; GFX9-NEXT:    v_exp_f32_e32 v0, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %fabs.x = call float @llvm.fabs.f32(float %x)
  %fabs.y = call float @llvm.fabs.f32(float %y)
  %pow = call float @llvm.pow.f32(float %fabs.x, float %fabs.y)
  ret float %pow
}

define amdgpu_ps float @v_pow_f32_sgpr_vgpr(float inreg %x, float %y) {
; GFX6-LABEL: v_pow_f32_sgpr_vgpr:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    v_log_f32_e32 v1, s0
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, v1, v0
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: v_pow_f32_sgpr_vgpr:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    v_log_f32_e32 v1, s0
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, v1, v0
; GFX8-NEXT:    v_exp_f32_e32 v0, v0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: v_pow_f32_sgpr_vgpr:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    v_log_f32_e32 v1, s0
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, v1, v0
; GFX9-NEXT:    v_exp_f32_e32 v0, v0
; GFX9-NEXT:    ; return to shader part epilog
  %pow = call float @llvm.pow.f32(float %x, float %y)
  ret float %pow
}

define amdgpu_ps float @v_pow_f32_vgpr_sgpr(float %x, float inreg %y) {
; GFX6-LABEL: v_pow_f32_vgpr_sgpr:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    v_log_f32_e32 v0, v0
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, s0, v0
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: v_pow_f32_vgpr_sgpr:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    v_log_f32_e32 v0, v0
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, s0, v0
; GFX8-NEXT:    v_exp_f32_e32 v0, v0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: v_pow_f32_vgpr_sgpr:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    v_log_f32_e32 v0, v0
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, s0, v0
; GFX9-NEXT:    v_exp_f32_e32 v0, v0
; GFX9-NEXT:    ; return to shader part epilog
  %pow = call float @llvm.pow.f32(float %x, float %y)
  ret float %pow
}

define amdgpu_ps float @v_pow_f32_sgpr_sgpr(float inreg %x, float inreg %y) {
; GFX6-LABEL: v_pow_f32_sgpr_sgpr:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    v_log_f32_e32 v0, s0
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, s1, v0
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    ; return to shader part epilog
;
; GFX8-LABEL: v_pow_f32_sgpr_sgpr:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    v_log_f32_e32 v0, s0
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, s1, v0
; GFX8-NEXT:    v_exp_f32_e32 v0, v0
; GFX8-NEXT:    ; return to shader part epilog
;
; GFX9-LABEL: v_pow_f32_sgpr_sgpr:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    v_log_f32_e32 v0, s0
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, s1, v0
; GFX9-NEXT:    v_exp_f32_e32 v0, v0
; GFX9-NEXT:    ; return to shader part epilog
  %pow = call float @llvm.pow.f32(float %x, float %y)
  ret float %pow
}

define float @v_pow_f32_fneg_lhs(float %x, float %y) {
; GFX6-LABEL: v_pow_f32_fneg_lhs:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    v_log_f32_e64 v0, -v0
; GFX6-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_f32_fneg_lhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_log_f32_e64 v0, -v0
; GFX8-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX8-NEXT:    v_exp_f32_e32 v0, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_f32_fneg_lhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_log_f32_e64 v0, -v0
; GFX9-NEXT:    v_mul_legacy_f32_e32 v0, v0, v1
; GFX9-NEXT:    v_exp_f32_e32 v0, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %neg.x = fneg float %x
  %pow = call float @llvm.pow.f32(float %neg.x, float %y)
  ret float %pow
}

define float @v_pow_f32_fneg_rhs(float %x, float %y) {
; GFX6-LABEL: v_pow_f32_fneg_rhs:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    v_log_f32_e32 v0, v0
; GFX6-NEXT:    v_mul_legacy_f32_e64 v0, v0, -v1
; GFX6-NEXT:    v_exp_f32_e32 v0, v0
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX8-LABEL: v_pow_f32_fneg_rhs:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX8-NEXT:    v_log_f32_e32 v0, v0
; GFX8-NEXT:    v_mul_legacy_f32_e64 v0, v0, -v1
; GFX8-NEXT:    v_exp_f32_e32 v0, v0
; GFX8-NEXT:    s_setpc_b64 s[30:31]
;
; GFX9-LABEL: v_pow_f32_fneg_rhs:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    v_log_f32_e32 v0, v0
; GFX9-NEXT:    v_mul_legacy_f32_e64 v0, v0, -v1
; GFX9-NEXT:    v_exp_f32_e32 v0, v0
; GFX9-NEXT:    s_setpc_b64 s[30:31]
  %neg.y = fneg float %y
  %pow = call float @llvm.pow.f32(float %x, float %neg.y)
  ret float %pow
}

declare half @llvm.pow.f16(half, half)
declare float @llvm.pow.f32(float, float)
declare double @llvm.pow.f64(double, double)

declare half @llvm.fabs.f16(half)
declare float @llvm.fabs.f32(float)

declare <2 x half> @llvm.pow.v2f16(<2 x half>, <2 x half>)
declare <2 x float> @llvm.pow.v2f32(<2 x float>, <2 x float>)
