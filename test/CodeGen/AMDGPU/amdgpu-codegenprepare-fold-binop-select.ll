; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=fiji -amdgpu-codegenprepare %s | FileCheck -check-prefix=IR %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=fiji < %s | FileCheck -check-prefix=GCN %s

define i32 @select_sdiv_lhs_const_i32(i1 %cond) {
; IR-LABEL: @select_sdiv_lhs_const_i32(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i32 200000, i32 125000
; IR-NEXT:    ret i32 [[OP]]
;
; GCN-LABEL: select_sdiv_lhs_const_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0x1e848
; GCN-NEXT:    v_mov_b32_e32 v2, 0x30d40
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, i32 5, i32 8
  %op = sdiv i32 1000000, %select
  ret i32 %op
}

define i32 @select_sdiv_rhs_const_i32(i1 %cond) {
; IR-LABEL: @select_sdiv_rhs_const_i32(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i32 1000, i32 10000
; IR-NEXT:    ret i32 [[OP]]
;
; GCN-LABEL: select_sdiv_rhs_const_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0x2710
; GCN-NEXT:    v_mov_b32_e32 v2, 0x3e8
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, i32 42000, i32 420000
  %op = sdiv i32 %select, 42
  ret i32 %op
}

define <2 x i32> @select_sdiv_lhs_const_v2i32(i1 %cond) {
; IR-LABEL: @select_sdiv_lhs_const_v2i32(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], <2 x i32> <i32 666, i32 undef>, <2 x i32> <i32 555, i32 1428>
; IR-NEXT:    ret <2 x i32> [[OP]]
;
; GCN-LABEL: select_sdiv_lhs_const_v2i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0x22b
; GCN-NEXT:    v_mov_b32_e32 v2, 0x29a
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    v_mov_b32_e32 v1, 0x594
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, <2 x i32> <i32 5, i32 undef>, <2 x i32> <i32 6, i32 7>
  %op = sdiv <2 x i32> <i32 3333, i32 9999>, %select
  ret <2 x i32> %op
}

define <2 x i32> @select_sdiv_rhs_const_v2i32(i1 %cond) {
; IR-LABEL: @select_sdiv_rhs_const_v2i32(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], <2 x i32> <i32 198621, i32 20855308>, <2 x i32> <i32 222748, i32 2338858>
; IR-NEXT:    ret <2 x i32> [[OP]]
;
; GCN-LABEL: select_sdiv_rhs_const_v2i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0x3661c
; GCN-NEXT:    v_mov_b32_e32 v2, 0x307dd
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    v_mov_b32_e32 v1, 0x23b02a
; GCN-NEXT:    v_mov_b32_e32 v2, 0x13e3a0c
; GCN-NEXT:    v_cndmask_b32_e32 v1, v1, v2, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, <2 x i32> <i32 8342123, i32 834212353>, <2 x i32> <i32 9355456, i32 93554321>
  %op = sdiv <2 x i32> %select, <i32 42, i32 40>
  ret <2 x i32> %op
}

@gv = external addrspace(1) global i32

define i32 @select_sdiv_lhs_opaque_const0_i32(i1 %cond) {
; IR-LABEL: @select_sdiv_lhs_opaque_const0_i32(
; IR-NEXT:    [[SELECT:%.*]] = select i1 [[COND:%.*]], i32 ptrtoint (i32 addrspace(1)* @gv to i32), i32 5
; IR-NEXT:    [[TMP1:%.*]] = ashr i32 [[SELECT]], 31
; IR-NEXT:    [[TMP2:%.*]] = xor i32 0, [[TMP1]]
; IR-NEXT:    [[TMP3:%.*]] = add i32 [[SELECT]], [[TMP1]]
; IR-NEXT:    [[TMP4:%.*]] = xor i32 [[TMP3]], [[TMP1]]
; IR-NEXT:    [[TMP5:%.*]] = uitofp i32 [[TMP4]] to float
; IR-NEXT:    [[TMP6:%.*]] = call fast float @llvm.amdgcn.rcp.f32(float [[TMP5]])
; IR-NEXT:    [[TMP7:%.*]] = fmul fast float [[TMP6]], 0x41F0000000000000
; IR-NEXT:    [[TMP8:%.*]] = fptoui float [[TMP7]] to i32
; IR-NEXT:    [[TMP9:%.*]] = zext i32 [[TMP8]] to i64
; IR-NEXT:    [[TMP10:%.*]] = zext i32 [[TMP4]] to i64
; IR-NEXT:    [[TMP11:%.*]] = mul i64 [[TMP9]], [[TMP10]]
; IR-NEXT:    [[TMP12:%.*]] = trunc i64 [[TMP11]] to i32
; IR-NEXT:    [[TMP13:%.*]] = lshr i64 [[TMP11]], 32
; IR-NEXT:    [[TMP14:%.*]] = trunc i64 [[TMP13]] to i32
; IR-NEXT:    [[TMP15:%.*]] = sub i32 0, [[TMP12]]
; IR-NEXT:    [[TMP16:%.*]] = icmp eq i32 [[TMP14]], 0
; IR-NEXT:    [[TMP17:%.*]] = select i1 [[TMP16]], i32 [[TMP15]], i32 [[TMP12]]
; IR-NEXT:    [[TMP18:%.*]] = zext i32 [[TMP17]] to i64
; IR-NEXT:    [[TMP19:%.*]] = zext i32 [[TMP8]] to i64
; IR-NEXT:    [[TMP20:%.*]] = mul i64 [[TMP18]], [[TMP19]]
; IR-NEXT:    [[TMP21:%.*]] = trunc i64 [[TMP20]] to i32
; IR-NEXT:    [[TMP22:%.*]] = lshr i64 [[TMP20]], 32
; IR-NEXT:    [[TMP23:%.*]] = trunc i64 [[TMP22]] to i32
; IR-NEXT:    [[TMP24:%.*]] = add i32 [[TMP8]], [[TMP23]]
; IR-NEXT:    [[TMP25:%.*]] = sub i32 [[TMP8]], [[TMP23]]
; IR-NEXT:    [[TMP26:%.*]] = select i1 [[TMP16]], i32 [[TMP24]], i32 [[TMP25]]
; IR-NEXT:    [[TMP27:%.*]] = zext i32 [[TMP26]] to i64
; IR-NEXT:    [[TMP28:%.*]] = mul i64 [[TMP27]], 1000000
; IR-NEXT:    [[TMP29:%.*]] = trunc i64 [[TMP28]] to i32
; IR-NEXT:    [[TMP30:%.*]] = lshr i64 [[TMP28]], 32
; IR-NEXT:    [[TMP31:%.*]] = trunc i64 [[TMP30]] to i32
; IR-NEXT:    [[TMP32:%.*]] = mul i32 [[TMP31]], [[TMP4]]
; IR-NEXT:    [[TMP33:%.*]] = sub i32 1000000, [[TMP32]]
; IR-NEXT:    [[TMP34:%.*]] = icmp uge i32 [[TMP33]], [[TMP4]]
; IR-NEXT:    [[TMP35:%.*]] = icmp uge i32 1000000, [[TMP32]]
; IR-NEXT:    [[TMP36:%.*]] = and i1 [[TMP34]], [[TMP35]]
; IR-NEXT:    [[TMP37:%.*]] = add i32 [[TMP31]], 1
; IR-NEXT:    [[TMP38:%.*]] = sub i32 [[TMP31]], 1
; IR-NEXT:    [[TMP39:%.*]] = select i1 [[TMP36]], i32 [[TMP37]], i32 [[TMP31]]
; IR-NEXT:    [[TMP40:%.*]] = select i1 [[TMP35]], i32 [[TMP39]], i32 [[TMP38]]
; IR-NEXT:    [[TMP41:%.*]] = xor i32 [[TMP40]], [[TMP2]]
; IR-NEXT:    [[TMP42:%.*]] = sub i32 [[TMP41]], [[TMP2]]
; IR-NEXT:    ret i32 [[TMP42]]
;
; GCN-LABEL: select_sdiv_lhs_opaque_const0_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_getpc_b64 s[4:5]
; GCN-NEXT:    s_add_u32 s4, s4, gv@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s5, s5, gv@gotpcrel32@hi+4
; GCN-NEXT:    s_load_dword s4, s[4:5], 0x0
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    s_mov_b32 s6, 0xf4240
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v1, s4
; GCN-NEXT:    v_cndmask_b32_e32 v0, 5, v1, vcc
; GCN-NEXT:    v_ashrrev_i32_e32 v1, 31, v0
; GCN-NEXT:    v_add_u32_e32 v0, vcc, v0, v1
; GCN-NEXT:    v_xor_b32_e32 v0, v0, v1
; GCN-NEXT:    v_cvt_f32_u32_e32 v2, v0
; GCN-NEXT:    v_rcp_iflag_f32_e32 v2, v2
; GCN-NEXT:    v_mul_f32_e32 v2, 0x4f800000, v2
; GCN-NEXT:    v_cvt_u32_f32_e32 v2, v2
; GCN-NEXT:    v_mul_lo_u32 v3, v2, v0
; GCN-NEXT:    v_mul_hi_u32 v4, v2, v0
; GCN-NEXT:    v_sub_u32_e32 v5, vcc, 0, v3
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v4
; GCN-NEXT:    v_cndmask_b32_e32 v3, v3, v5, vcc
; GCN-NEXT:    v_mul_hi_u32 v3, v3, v2
; GCN-NEXT:    v_add_u32_e64 v4, s[4:5], v2, v3
; GCN-NEXT:    v_sub_u32_e64 v2, s[4:5], v2, v3
; GCN-NEXT:    v_cndmask_b32_e32 v2, v2, v4, vcc
; GCN-NEXT:    v_mul_hi_u32 v2, v2, s6
; GCN-NEXT:    s_mov_b32 s4, 0xf4241
; GCN-NEXT:    v_mul_lo_u32 v3, v2, v0
; GCN-NEXT:    v_add_u32_e32 v4, vcc, 1, v2
; GCN-NEXT:    v_add_u32_e32 v5, vcc, -1, v2
; GCN-NEXT:    v_sub_u32_e32 v6, vcc, s6, v3
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, s4, v3
; GCN-NEXT:    v_cmp_ge_u32_e64 s[4:5], v6, v0
; GCN-NEXT:    s_and_b64 s[4:5], s[4:5], vcc
; GCN-NEXT:    v_cndmask_b32_e64 v0, v2, v4, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v0, v5, v0, vcc
; GCN-NEXT:    v_xor_b32_e32 v0, v0, v1
; GCN-NEXT:    v_sub_u32_e32 v0, vcc, v0, v1
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, i32 ptrtoint (i32 addrspace(1)* @gv to i32), i32 5
  %op = sdiv i32 1000000, %select
  ret i32 %op
}

define i32 @select_sdiv_lhs_opaque_const1_i32(i1 %cond) {
; IR-LABEL: @select_sdiv_lhs_opaque_const1_i32(
; IR-NEXT:    [[SELECT:%.*]] = select i1 [[COND:%.*]], i32 5, i32 ptrtoint (i32 addrspace(1)* @gv to i32)
; IR-NEXT:    [[TMP1:%.*]] = ashr i32 [[SELECT]], 31
; IR-NEXT:    [[TMP2:%.*]] = xor i32 0, [[TMP1]]
; IR-NEXT:    [[TMP3:%.*]] = add i32 [[SELECT]], [[TMP1]]
; IR-NEXT:    [[TMP4:%.*]] = xor i32 [[TMP3]], [[TMP1]]
; IR-NEXT:    [[TMP5:%.*]] = uitofp i32 [[TMP4]] to float
; IR-NEXT:    [[TMP6:%.*]] = call fast float @llvm.amdgcn.rcp.f32(float [[TMP5]])
; IR-NEXT:    [[TMP7:%.*]] = fmul fast float [[TMP6]], 0x41F0000000000000
; IR-NEXT:    [[TMP8:%.*]] = fptoui float [[TMP7]] to i32
; IR-NEXT:    [[TMP9:%.*]] = zext i32 [[TMP8]] to i64
; IR-NEXT:    [[TMP10:%.*]] = zext i32 [[TMP4]] to i64
; IR-NEXT:    [[TMP11:%.*]] = mul i64 [[TMP9]], [[TMP10]]
; IR-NEXT:    [[TMP12:%.*]] = trunc i64 [[TMP11]] to i32
; IR-NEXT:    [[TMP13:%.*]] = lshr i64 [[TMP11]], 32
; IR-NEXT:    [[TMP14:%.*]] = trunc i64 [[TMP13]] to i32
; IR-NEXT:    [[TMP15:%.*]] = sub i32 0, [[TMP12]]
; IR-NEXT:    [[TMP16:%.*]] = icmp eq i32 [[TMP14]], 0
; IR-NEXT:    [[TMP17:%.*]] = select i1 [[TMP16]], i32 [[TMP15]], i32 [[TMP12]]
; IR-NEXT:    [[TMP18:%.*]] = zext i32 [[TMP17]] to i64
; IR-NEXT:    [[TMP19:%.*]] = zext i32 [[TMP8]] to i64
; IR-NEXT:    [[TMP20:%.*]] = mul i64 [[TMP18]], [[TMP19]]
; IR-NEXT:    [[TMP21:%.*]] = trunc i64 [[TMP20]] to i32
; IR-NEXT:    [[TMP22:%.*]] = lshr i64 [[TMP20]], 32
; IR-NEXT:    [[TMP23:%.*]] = trunc i64 [[TMP22]] to i32
; IR-NEXT:    [[TMP24:%.*]] = add i32 [[TMP8]], [[TMP23]]
; IR-NEXT:    [[TMP25:%.*]] = sub i32 [[TMP8]], [[TMP23]]
; IR-NEXT:    [[TMP26:%.*]] = select i1 [[TMP16]], i32 [[TMP24]], i32 [[TMP25]]
; IR-NEXT:    [[TMP27:%.*]] = zext i32 [[TMP26]] to i64
; IR-NEXT:    [[TMP28:%.*]] = mul i64 [[TMP27]], 1000000
; IR-NEXT:    [[TMP29:%.*]] = trunc i64 [[TMP28]] to i32
; IR-NEXT:    [[TMP30:%.*]] = lshr i64 [[TMP28]], 32
; IR-NEXT:    [[TMP31:%.*]] = trunc i64 [[TMP30]] to i32
; IR-NEXT:    [[TMP32:%.*]] = mul i32 [[TMP31]], [[TMP4]]
; IR-NEXT:    [[TMP33:%.*]] = sub i32 1000000, [[TMP32]]
; IR-NEXT:    [[TMP34:%.*]] = icmp uge i32 [[TMP33]], [[TMP4]]
; IR-NEXT:    [[TMP35:%.*]] = icmp uge i32 1000000, [[TMP32]]
; IR-NEXT:    [[TMP36:%.*]] = and i1 [[TMP34]], [[TMP35]]
; IR-NEXT:    [[TMP37:%.*]] = add i32 [[TMP31]], 1
; IR-NEXT:    [[TMP38:%.*]] = sub i32 [[TMP31]], 1
; IR-NEXT:    [[TMP39:%.*]] = select i1 [[TMP36]], i32 [[TMP37]], i32 [[TMP31]]
; IR-NEXT:    [[TMP40:%.*]] = select i1 [[TMP35]], i32 [[TMP39]], i32 [[TMP38]]
; IR-NEXT:    [[TMP41:%.*]] = xor i32 [[TMP40]], [[TMP2]]
; IR-NEXT:    [[TMP42:%.*]] = sub i32 [[TMP41]], [[TMP2]]
; IR-NEXT:    ret i32 [[TMP42]]
;
; GCN-LABEL: select_sdiv_lhs_opaque_const1_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_getpc_b64 s[4:5]
; GCN-NEXT:    s_add_u32 s4, s4, gv@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s5, s5, gv@gotpcrel32@hi+4
; GCN-NEXT:    s_load_dword s4, s[4:5], 0x0
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    s_mov_b32 s6, 0xf4240
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v1, s4
; GCN-NEXT:    v_cndmask_b32_e64 v0, v1, 5, vcc
; GCN-NEXT:    v_ashrrev_i32_e32 v1, 31, v0
; GCN-NEXT:    v_add_u32_e32 v0, vcc, v0, v1
; GCN-NEXT:    v_xor_b32_e32 v0, v0, v1
; GCN-NEXT:    v_cvt_f32_u32_e32 v2, v0
; GCN-NEXT:    v_rcp_iflag_f32_e32 v2, v2
; GCN-NEXT:    v_mul_f32_e32 v2, 0x4f800000, v2
; GCN-NEXT:    v_cvt_u32_f32_e32 v2, v2
; GCN-NEXT:    v_mul_lo_u32 v3, v2, v0
; GCN-NEXT:    v_mul_hi_u32 v4, v2, v0
; GCN-NEXT:    v_sub_u32_e32 v5, vcc, 0, v3
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v4
; GCN-NEXT:    v_cndmask_b32_e32 v3, v3, v5, vcc
; GCN-NEXT:    v_mul_hi_u32 v3, v3, v2
; GCN-NEXT:    v_add_u32_e64 v4, s[4:5], v2, v3
; GCN-NEXT:    v_sub_u32_e64 v2, s[4:5], v2, v3
; GCN-NEXT:    v_cndmask_b32_e32 v2, v2, v4, vcc
; GCN-NEXT:    v_mul_hi_u32 v2, v2, s6
; GCN-NEXT:    s_mov_b32 s4, 0xf4241
; GCN-NEXT:    v_mul_lo_u32 v3, v2, v0
; GCN-NEXT:    v_add_u32_e32 v4, vcc, 1, v2
; GCN-NEXT:    v_add_u32_e32 v5, vcc, -1, v2
; GCN-NEXT:    v_sub_u32_e32 v6, vcc, s6, v3
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, s4, v3
; GCN-NEXT:    v_cmp_ge_u32_e64 s[4:5], v6, v0
; GCN-NEXT:    s_and_b64 s[4:5], s[4:5], vcc
; GCN-NEXT:    v_cndmask_b32_e64 v0, v2, v4, s[4:5]
; GCN-NEXT:    v_cndmask_b32_e32 v0, v5, v0, vcc
; GCN-NEXT:    v_xor_b32_e32 v0, v0, v1
; GCN-NEXT:    v_sub_u32_e32 v0, vcc, v0, v1
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, i32 5, i32 ptrtoint (i32 addrspace(1)* @gv to i32)
  %op = sdiv i32 1000000, %select
  ret i32 %op
}

define i32 @select_sdiv_rhs_opaque_const0_i32(i1 %cond) {
; IR-LABEL: @select_sdiv_rhs_opaque_const0_i32(
; IR-NEXT:    [[SELECT:%.*]] = select i1 [[COND:%.*]], i32 ptrtoint (i32 addrspace(1)* @gv to i32), i32 234234
; IR-NEXT:    [[OP:%.*]] = sdiv i32 [[SELECT]], 42
; IR-NEXT:    ret i32 [[OP]]
;
; GCN-LABEL: select_sdiv_rhs_opaque_const0_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_getpc_b64 s[4:5]
; GCN-NEXT:    s_add_u32 s4, s4, gv@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s5, s5, gv@gotpcrel32@hi+4
; GCN-NEXT:    s_load_dword s4, s[4:5], 0x0
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0x392fa
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    s_mov_b32 s5, 0x30c30c31
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v2, s4
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    v_mul_hi_i32 v0, v0, s5
; GCN-NEXT:    v_lshrrev_b32_e32 v1, 31, v0
; GCN-NEXT:    v_ashrrev_i32_e32 v0, 3, v0
; GCN-NEXT:    v_add_u32_e32 v0, vcc, v0, v1
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, i32 ptrtoint (i32 addrspace(1)* @gv to i32), i32 234234
  %op = sdiv i32 %select, 42
  ret i32 %op
}

define i32 @select_sdiv_rhs_opaque_const1_i32(i1 %cond) {
; IR-LABEL: @select_sdiv_rhs_opaque_const1_i32(
; IR-NEXT:    [[SELECT:%.*]] = select i1 [[COND:%.*]], i32 42000, i32 ptrtoint (i32 addrspace(1)* @gv to i32)
; IR-NEXT:    [[OP:%.*]] = sdiv i32 [[SELECT]], 42
; IR-NEXT:    ret i32 [[OP]]
;
; GCN-LABEL: select_sdiv_rhs_opaque_const1_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_getpc_b64 s[4:5]
; GCN-NEXT:    s_add_u32 s4, s4, gv@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s5, s5, gv@gotpcrel32@hi+4
; GCN-NEXT:    s_load_dword s4, s[4:5], 0x0
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0xa410
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    s_mov_b32 s5, 0x30c30c31
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v2, s4
; GCN-NEXT:    v_cndmask_b32_e32 v0, v2, v1, vcc
; GCN-NEXT:    v_mul_hi_i32 v0, v0, s5
; GCN-NEXT:    v_lshrrev_b32_e32 v1, 31, v0
; GCN-NEXT:    v_ashrrev_i32_e32 v0, 3, v0
; GCN-NEXT:    v_add_u32_e32 v0, vcc, v0, v1
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, i32 42000, i32 ptrtoint (i32 addrspace(1)* @gv to i32)
  %op = sdiv i32 %select, 42
  ret i32 %op
}

define i32 @select_add_lhs_const_i32(i1 %cond) {
; IR-LABEL: @select_add_lhs_const_i32(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i32 1000005, i32 1000008
; IR-NEXT:    ret i32 [[OP]]
;
; GCN-LABEL: select_add_lhs_const_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0xf4248
; GCN-NEXT:    v_mov_b32_e32 v2, 0xf4245
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, i32 5, i32 8
  %op = add i32 1000000, %select
  ret i32 %op
}

define float @select_fadd_lhs_const_i32_fmf(i1 %cond) {
; IR-LABEL: @select_fadd_lhs_const_i32_fmf(
; IR-NEXT:    [[OP:%.*]] = select nnan nsz i1 [[COND:%.*]], float 3.000000e+00, float 5.000000e+00
; IR-NEXT:    ret float [[OP]]
; GCN-LABEL: select_fadd_lhs_const_i32_fmf:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0x40a00000
; GCN-NEXT:    v_mov_b32_e32 v2, 0x40400000
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, float 2.0, float 4.0
  %op = fadd nnan nsz float 1.0, %select
  ret float %op
}

; Make sure we don't try to use mul24 instead
define i32 @select_mul_lhs_const_i32(i1 %cond) {
; GCN-LABEL: select_mul_lhs_const_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0x1f40
; GCN-NEXT:    v_mov_b32_e32 v2, 0x1388
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
; IR-LABEL: @select_mul_lhs_const_i32(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i32 5000, i32 8000
; IR-NEXT:    ret i32 [[OP]]
  %select = select i1 %cond, i32 5, i32 8
  %op = mul i32 1000, %select
  ret i32 %op
}

; Make sure we don't try to use mul24 instead
define i32 @select_mul_rhs_const_i32(i1 %cond) {
; GCN-LABEL: select_mul_rhs_const_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0x1f40
; GCN-NEXT:    v_mov_b32_e32 v2, 0x1388
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
; IR-LABEL: @select_mul_rhs_const_i32(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i32 5000, i32 8000
; IR-NEXT:    ret i32 [[OP]]
;
  %select = select i1 %cond, i32 5, i32 8
  %op = mul i32 %select, 1000
  ret i32 %op
}

define amdgpu_kernel void @select_add_lhs_const_i16(i1 %cond) {
; IR-LABEL: @select_add_lhs_const_i16(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i16 128, i16 131
; IR-NEXT:    store i16 [[OP]], i16 addrspace(1)* undef
; IR-NEXT:    ret void

; GCN-LABEL: select_add_lhs_const_i16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dword s0, s[4:5], 0x0
; GCN-NEXT:    v_mov_b32_e32 v0, 0x83
; GCN-NEXT:    v_mov_b32_e32 v1, 0x80
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_and_b32 s0, 1, s0
; GCN-NEXT:    v_cmp_eq_u32_e64 vcc, s0, 1
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v1, vcc
; GCN-NEXT:    flat_store_short v[0:1], v0
; GCN-NEXT:    s_endpgm
;
  %select = select i1 %cond, i16 5, i16 8
  %op = add i16 %select, 123
  store i16 %op, i16 addrspace(1)* undef
  ret void
}

define i16 @select_add_trunc_select(i1 %cond) {
; GCN-LABEL: select_add_trunc_select:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e64 v0, 50, 47, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
; IR-LABEL: @select_add_trunc_select(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i16 47, i16 50
; IR-NEXT:    ret i16 [[OP]]
;
  %select = select i1 %cond, i32 5, i32 8
  %trunc = trunc i32 %select to i16
  %op = add i16 %trunc, 42
  ret i16 %op
}

define i32 @select_add_sext_select(i1 %cond) {
; IR-LABEL: @select_add_sext_select(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i32 29, i32 50
; IR-NEXT:    ret i32 [[OP]]
; GCN-LABEL: select_add_sext_select:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e64 v0, 50, 29, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, i16 -13, i16 8
  %trunc = sext i16 %select to i32
  %op = add i32 %trunc, 42
  ret i32 %op
}

define i32 @select_add_zext_select(i1 %cond) {
; IR-LABEL: @select_add_zext_select(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i32 47, i32 50
; IR-NEXT:    ret i32 [[OP]]

; GCN-LABEL: select_add_zext_select:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e64 v0, 50, 47, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, i16 5, i16 8
  %trunc = zext i16 %select to i32
  %op = add i32 %trunc, 42
  ret i32 %op
}

define i32 @select_add_bitcast_select(i1 %cond) {
; IR-LABEL: @select_add_bitcast_select(
; IR-NEXT:    [[OP:%.*]] = select i1 [[COND:%.*]], i32 1065353258, i32 1073741866
; IR-NEXT:    ret i32 [[OP]]
;
; GCN-LABEL: select_add_bitcast_select:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0x4000002a
; GCN-NEXT:    v_mov_b32_e32 v2, 0x3f80002a
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v1, v2, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, float 1.0, float 2.0
  %trunc = bitcast float %select to i32
  %op = add i32 %trunc, 42
  ret i32 %op
}

; If we fold through a cast, we need to ensure it doesn't have
; multiple uses.
define <2 x half> @multi_use_cast_regression(i1 %cond) {
; IR-LABEL: @multi_use_cast_regression(
; IR-NEXT:    [[SELECT:%.*]] = select i1 [[COND:%.*]], half 0xH3C00, half 0xH0000
; IR-NEXT:    [[FPEXT:%.*]] = fpext half [[SELECT]] to float
; IR-NEXT:    [[FSUB:%.*]] = fsub nsz float 1.000000e+00, [[FPEXT]]
; IR-NEXT:    [[CALL:%.*]] = call nsz <2 x half> @llvm.amdgcn.cvt.pkrtz(float [[FPEXT]], float [[FSUB]])
; IR-NEXT:    ret <2 x half> [[CALL]]
;
; GCN-LABEL: multi_use_cast_regression:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_and_b32_e32 v0, 1, v0
; GCN-NEXT:    v_mov_b32_e32 v1, 0x3c00
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v1, vcc
; GCN-NEXT:    v_cvt_f32_f16_e32 v0, v0
; GCN-NEXT:    v_sub_f32_e32 v1, 1.0, v0
; GCN-NEXT:    v_cvt_pkrtz_f16_f32 v0, v0, v1
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %select = select i1 %cond, half 1.000000e+00, half 0.000000e+00
  %fpext = fpext half %select to float
  %fsub = fsub nsz float 1.0, %fpext
  %call = call nsz <2 x half> @llvm.amdgcn.cvt.pkrtz(float %fpext, float %fsub) #3
  ret <2 x half> %call
}

declare <2 x half> @llvm.amdgcn.cvt.pkrtz(float, float) #0

attributes #0 = { nounwind readnone speculatable }
