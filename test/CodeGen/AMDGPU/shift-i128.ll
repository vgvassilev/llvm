; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=kaveri -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

define i128 @v_shl_i128_vv(i128 %lhs, i128 %rhs) {
; GCN-LABEL: v_shl_i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v7, vcc, 64, v4
; GCN-NEXT:    v_lshl_b64 v[5:6], v[2:3], v4
; GCN-NEXT:    v_lshr_b64 v[7:8], v[0:1], v7
; GCN-NEXT:    v_cmp_eq_u32_e64 s[6:7], 0, v4
; GCN-NEXT:    v_or_b32_e32 v7, v5, v7
; GCN-NEXT:    v_subrev_i32_e32 v5, vcc, 64, v4
; GCN-NEXT:    v_or_b32_e32 v8, v6, v8
; GCN-NEXT:    v_lshl_b64 v[5:6], v[0:1], v5
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v4
; GCN-NEXT:    v_lshl_b64 v[0:1], v[0:1], v4
; GCN-NEXT:    v_cndmask_b32_e32 v6, v6, v8, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v5, v5, v7, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v3, v6, v3, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e64 v2, v5, v2, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v1, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v0, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl i128 %lhs, %rhs
  ret i128 %shl
}

define i128 @v_lshr_i128_vv(i128 %lhs, i128 %rhs) {
; GCN-LABEL: v_lshr_i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v7, vcc, 64, v4
; GCN-NEXT:    v_lshr_b64 v[5:6], v[0:1], v4
; GCN-NEXT:    v_lshl_b64 v[7:8], v[2:3], v7
; GCN-NEXT:    v_cmp_eq_u32_e64 s[6:7], 0, v4
; GCN-NEXT:    v_or_b32_e32 v7, v5, v7
; GCN-NEXT:    v_subrev_i32_e32 v5, vcc, 64, v4
; GCN-NEXT:    v_or_b32_e32 v8, v6, v8
; GCN-NEXT:    v_lshr_b64 v[5:6], v[2:3], v5
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v4
; GCN-NEXT:    v_lshr_b64 v[2:3], v[2:3], v4
; GCN-NEXT:    v_cndmask_b32_e32 v6, v6, v8, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v5, v5, v7, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v1, v6, v1, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e64 v0, v5, v0, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v3, 0, v3, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v2, 0, v2, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]

  %shl = lshr i128 %lhs, %rhs
  ret i128 %shl
}

define i128 @v_ashr_i128_vv(i128 %lhs, i128 %rhs) {
; GCN-LABEL: v_ashr_i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v9, vcc, 64, v4
; GCN-NEXT:    v_lshr_b64 v[7:8], v[0:1], v4
; GCN-NEXT:    v_lshl_b64 v[9:10], v[2:3], v9
; GCN-NEXT:    v_ashrrev_i32_e32 v11, 31, v3
; GCN-NEXT:    v_or_b32_e32 v8, v8, v10
; GCN-NEXT:    v_subrev_i32_e32 v10, vcc, 64, v4
; GCN-NEXT:    v_ashr_i64 v[5:6], v[2:3], v4
; GCN-NEXT:    v_ashr_i64 v[2:3], v[2:3], v10
; GCN-NEXT:    v_cmp_gt_u32_e64 s[6:7], 64, v4
; GCN-NEXT:    v_or_b32_e32 v7, v7, v9
; GCN-NEXT:    v_cndmask_b32_e64 v5, v11, v5, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e64 v3, v3, v8, s[6:7]
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 0, v4
; GCN-NEXT:    v_cndmask_b32_e64 v2, v2, v7, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e64 v6, v11, v6, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v1, v3, v1, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v0, v2, v0, vcc
; GCN-NEXT:    v_mov_b32_e32 v2, v5
; GCN-NEXT:    v_mov_b32_e32 v3, v6
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = ashr i128 %lhs, %rhs
  ret i128 %shl
}


define i128 @v_shl_i128_vk(i128 %lhs) {
; GCN-LABEL: v_shl_i128_vk:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_lshl_b64 v[2:3], v[2:3], 17
; GCN-NEXT:    v_lshrrev_b32_e32 v4, 15, v1
; GCN-NEXT:    v_lshl_b64 v[0:1], v[0:1], 17
; GCN-NEXT:    v_or_b32_e32 v2, v2, v4
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl i128 %lhs, 17
  ret i128 %shl
}

define i128 @v_lshr_i128_vk(i128 %lhs) {
; GCN-LABEL: v_lshr_i128_vk:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_lshr_b64 v[0:1], v[2:3], 1
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    v_mov_b32_e32 v3, 0
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = lshr i128 %lhs, 65
  ret i128 %shl
}

define i128 @v_ashr_i128_vk(i128 %lhs) {
; GCN-LABEL: v_ashr_i128_vk:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_lshl_b64 v[4:5], v[2:3], 31
; GCN-NEXT:    v_lshrrev_b32_e32 v0, 1, v1
; GCN-NEXT:    v_or_b32_e32 v4, v0, v4
; GCN-NEXT:    v_mov_b32_e32 v0, v4
; GCN-NEXT:    v_ashr_i64 v[2:3], v[2:3], 33
; GCN-NEXT:    v_mov_b32_e32 v1, v5
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = ashr i128 %lhs, 33
  ret i128 %shl
}

define i128 @v_shl_i128_kv(i128 %rhs) {
; GCN-LABEL: v_shl_i128_kv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v1, vcc, 64, v0
; GCN-NEXT:    v_subrev_i32_e32 v3, vcc, 64, v0
; GCN-NEXT:    v_lshr_b64 v[1:2], 17, v1
; GCN-NEXT:    v_lshl_b64 v[4:5], 17, v3
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v0
; GCN-NEXT:    v_cndmask_b32_e32 v2, v5, v2, vcc
; GCN-NEXT:    v_cmp_ne_u32_e64 s[6:7], 0, v0
; GCN-NEXT:    v_cndmask_b32_e64 v3, 0, v2, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v2, v4, v1, vcc
; GCN-NEXT:    v_lshl_b64 v[0:1], 17, v0
; GCN-NEXT:    v_cndmask_b32_e64 v2, 0, v2, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v1, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v0, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl i128 17, %rhs
  ret i128 %shl
}

define i128 @v_lshr_i128_kv(i128 %rhs) {
; GCN-LABEL: v_lshr_i128_kv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_mov_b32 s7, 0
; GCN-NEXT:    s_movk_i32 s6, 0x41
; GCN-NEXT:    v_lshr_b64 v[2:3], s[6:7], v0
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v0
; GCN-NEXT:    v_cmp_ne_u32_e64 s[6:7], 0, v0
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v2, vcc
; GCN-NEXT:    v_mov_b32_e32 v2, 0x41
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v3, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v0, v2, v0, s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    v_cndmask_b32_e64 v1, 0, v1, s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v3, 0
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = lshr i128 65, %rhs
  ret i128 %shl
}

define i128 @v_ashr_i128_kv(i128 %rhs) {
; GCN-LABEL: v_ashr_i128_kv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_lshr_b64 v[2:3], 33, v0
; GCN-NEXT:    v_cmp_gt_u32_e32 vcc, 64, v0
; GCN-NEXT:    v_cmp_ne_u32_e64 s[6:7], 0, v0
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v3, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v2, vcc
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    v_cndmask_b32_e64 v1, 0, v1, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e64 v0, 33, v0, s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v3, 0
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = ashr i128 33, %rhs
  ret i128 %shl
}

define amdgpu_kernel void @s_shl_i128_ss(i128 %lhs, i128 %rhs) {
; GCN-LABEL: s_shl_i128_ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx8 s[4:11], s[4:5], 0x0
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    v_mov_b32_e32 v5, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_sub_i32 s2, 64, s8
; GCN-NEXT:    s_sub_i32 s9, s8, 64
; GCN-NEXT:    s_lshl_b64 s[0:1], s[6:7], s8
; GCN-NEXT:    s_lshr_b64 s[2:3], s[4:5], s2
; GCN-NEXT:    s_or_b64 s[2:3], s[0:1], s[2:3]
; GCN-NEXT:    s_lshl_b64 s[10:11], s[4:5], s9
; GCN-NEXT:    v_mov_b32_e32 v0, s11
; GCN-NEXT:    v_mov_b32_e32 v1, s3
; GCN-NEXT:    v_cmp_lt_u32_e64 vcc, s8, 64
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v1, vcc
; GCN-NEXT:    v_mov_b32_e32 v1, s7
; GCN-NEXT:    v_cmp_eq_u32_e64 s[0:1], s8, 0
; GCN-NEXT:    v_cndmask_b32_e64 v3, v0, v1, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v0, s10
; GCN-NEXT:    v_mov_b32_e32 v1, s2
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v1, vcc
; GCN-NEXT:    v_mov_b32_e32 v1, s6
; GCN-NEXT:    v_cndmask_b32_e64 v2, v0, v1, s[0:1]
; GCN-NEXT:    s_lshl_b64 s[0:1], s[4:5], s8
; GCN-NEXT:    v_mov_b32_e32 v0, s1
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v0, vcc
; GCN-NEXT:    v_mov_b32_e32 v0, s0
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v0, vcc
; GCN-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GCN-NEXT:    s_endpgm
; GCN-NEXT:    .section .rodata,#alloc
; GCN-NEXT:    .p2align 6
; GCN-NEXT:    .amdhsa_kernel s_shl_i128_ss
; GCN-NEXT:     .amdhsa_group_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_private_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_buffer 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_queue_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_kernarg_segment_ptr 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_id 0
; GCN-NEXT:     .amdhsa_user_sgpr_flat_scratch_init 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_size 0
; GCN-NEXT:     .amdhsa_system_sgpr_private_segment_wavefront_offset 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_x 1
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_y 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_z 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_info 0
; GCN-NEXT:     .amdhsa_system_vgpr_workitem_id 0
; GCN-NEXT:     .amdhsa_next_free_vgpr 8
; GCN-NEXT:     .amdhsa_next_free_sgpr 12
; GCN-NEXT:     .amdhsa_reserve_flat_scratch 0
; GCN-NEXT:     .amdhsa_float_round_mode_32 0
; GCN-NEXT:     .amdhsa_float_round_mode_16_64 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_32 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_16_64 3
; GCN-NEXT:     .amdhsa_dx10_clamp 1
; GCN-NEXT:     .amdhsa_ieee_mode 1
; GCN-NEXT:     .amdhsa_exception_fp_ieee_invalid_op 0
; GCN-NEXT:     .amdhsa_exception_fp_denorm_src 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_div_zero 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_overflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_underflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_inexact 0
; GCN-NEXT:     .amdhsa_exception_int_div_zero 0
; GCN-NEXT:    .end_amdhsa_kernel
; GCN-NEXT:    .text
  %shift = shl i128 %lhs, %rhs
  store i128 %shift, i128 addrspace(1)* null
  ret void
}

define amdgpu_kernel void @s_lshr_i128_ss(i128 %lhs, i128 %rhs) {
; GCN-LABEL: s_lshr_i128_ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx8 s[4:11], s[4:5], 0x0
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    v_mov_b32_e32 v5, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_sub_i32 s2, 64, s8
; GCN-NEXT:    s_sub_i32 s9, s8, 64
; GCN-NEXT:    s_lshr_b64 s[0:1], s[4:5], s8
; GCN-NEXT:    s_lshl_b64 s[2:3], s[6:7], s2
; GCN-NEXT:    s_or_b64 s[2:3], s[0:1], s[2:3]
; GCN-NEXT:    s_lshr_b64 s[10:11], s[6:7], s9
; GCN-NEXT:    v_mov_b32_e32 v0, s11
; GCN-NEXT:    v_mov_b32_e32 v1, s3
; GCN-NEXT:    v_cmp_lt_u32_e64 vcc, s8, 64
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v1, vcc
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    v_cmp_eq_u32_e64 s[0:1], s8, 0
; GCN-NEXT:    v_cndmask_b32_e64 v1, v0, v1, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v0, s10
; GCN-NEXT:    v_mov_b32_e32 v2, s2
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v2, vcc
; GCN-NEXT:    v_mov_b32_e32 v2, s4
; GCN-NEXT:    v_cndmask_b32_e64 v0, v0, v2, s[0:1]
; GCN-NEXT:    s_lshr_b64 s[0:1], s[6:7], s8
; GCN-NEXT:    v_mov_b32_e32 v2, s1
; GCN-NEXT:    v_cndmask_b32_e32 v3, 0, v2, vcc
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    v_cndmask_b32_e32 v2, 0, v2, vcc
; GCN-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GCN-NEXT:    s_endpgm
; GCN-NEXT:    .section .rodata,#alloc
; GCN-NEXT:    .p2align 6
; GCN-NEXT:    .amdhsa_kernel s_lshr_i128_ss
; GCN-NEXT:     .amdhsa_group_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_private_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_buffer 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_queue_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_kernarg_segment_ptr 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_id 0
; GCN-NEXT:     .amdhsa_user_sgpr_flat_scratch_init 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_size 0
; GCN-NEXT:     .amdhsa_system_sgpr_private_segment_wavefront_offset 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_x 1
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_y 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_z 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_info 0
; GCN-NEXT:     .amdhsa_system_vgpr_workitem_id 0
; GCN-NEXT:     .amdhsa_next_free_vgpr 8
; GCN-NEXT:     .amdhsa_next_free_sgpr 12
; GCN-NEXT:     .amdhsa_reserve_flat_scratch 0
; GCN-NEXT:     .amdhsa_float_round_mode_32 0
; GCN-NEXT:     .amdhsa_float_round_mode_16_64 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_32 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_16_64 3
; GCN-NEXT:     .amdhsa_dx10_clamp 1
; GCN-NEXT:     .amdhsa_ieee_mode 1
; GCN-NEXT:     .amdhsa_exception_fp_ieee_invalid_op 0
; GCN-NEXT:     .amdhsa_exception_fp_denorm_src 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_div_zero 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_overflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_underflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_inexact 0
; GCN-NEXT:     .amdhsa_exception_int_div_zero 0
; GCN-NEXT:    .end_amdhsa_kernel
; GCN-NEXT:    .text
  %shift = lshr i128 %lhs, %rhs
  store i128 %shift, i128 addrspace(1)* null
  ret void
}

define amdgpu_kernel void @s_ashr_i128_ss(i128 %lhs, i128 %rhs) {
; GCN-LABEL: s_ashr_i128_ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx8 s[4:11], s[4:5], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_sub_i32 s2, 64, s8
; GCN-NEXT:    s_sub_i32 s9, s8, 64
; GCN-NEXT:    s_lshr_b64 s[0:1], s[4:5], s8
; GCN-NEXT:    s_lshl_b64 s[2:3], s[6:7], s2
; GCN-NEXT:    s_or_b64 s[2:3], s[0:1], s[2:3]
; GCN-NEXT:    s_ashr_i64 s[10:11], s[6:7], s9
; GCN-NEXT:    v_mov_b32_e32 v0, s11
; GCN-NEXT:    v_mov_b32_e32 v1, s3
; GCN-NEXT:    v_cmp_lt_u32_e64 vcc, s8, 64
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v1, vcc
; GCN-NEXT:    v_mov_b32_e32 v1, s5
; GCN-NEXT:    v_cmp_eq_u32_e64 s[0:1], s8, 0
; GCN-NEXT:    v_cndmask_b32_e64 v1, v0, v1, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v2, s2
; GCN-NEXT:    v_mov_b32_e32 v0, s10
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v2, vcc
; GCN-NEXT:    v_mov_b32_e32 v2, s4
; GCN-NEXT:    v_cndmask_b32_e64 v0, v0, v2, s[0:1]
; GCN-NEXT:    s_ashr_i64 s[0:1], s[6:7], s8
; GCN-NEXT:    s_ashr_i32 s2, s7, 31
; GCN-NEXT:    v_mov_b32_e32 v2, s2
; GCN-NEXT:    v_mov_b32_e32 v3, s1
; GCN-NEXT:    v_mov_b32_e32 v4, s0
; GCN-NEXT:    v_cndmask_b32_e32 v3, v2, v3, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v2, v2, v4, vcc
; GCN-NEXT:    v_mov_b32_e32 v4, 0
; GCN-NEXT:    v_mov_b32_e32 v5, 0
; GCN-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GCN-NEXT:    s_endpgm
; GCN-NEXT:    .section .rodata,#alloc
; GCN-NEXT:    .p2align 6
; GCN-NEXT:    .amdhsa_kernel s_ashr_i128_ss
; GCN-NEXT:     .amdhsa_group_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_private_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_buffer 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_queue_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_kernarg_segment_ptr 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_id 0
; GCN-NEXT:     .amdhsa_user_sgpr_flat_scratch_init 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_size 0
; GCN-NEXT:     .amdhsa_system_sgpr_private_segment_wavefront_offset 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_x 1
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_y 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_z 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_info 0
; GCN-NEXT:     .amdhsa_system_vgpr_workitem_id 0
; GCN-NEXT:     .amdhsa_next_free_vgpr 8
; GCN-NEXT:     .amdhsa_next_free_sgpr 12
; GCN-NEXT:     .amdhsa_reserve_flat_scratch 0
; GCN-NEXT:     .amdhsa_float_round_mode_32 0
; GCN-NEXT:     .amdhsa_float_round_mode_16_64 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_32 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_16_64 3
; GCN-NEXT:     .amdhsa_dx10_clamp 1
; GCN-NEXT:     .amdhsa_ieee_mode 1
; GCN-NEXT:     .amdhsa_exception_fp_ieee_invalid_op 0
; GCN-NEXT:     .amdhsa_exception_fp_denorm_src 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_div_zero 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_overflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_underflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_inexact 0
; GCN-NEXT:     .amdhsa_exception_int_div_zero 0
; GCN-NEXT:    .end_amdhsa_kernel
; GCN-NEXT:    .text
  %shift = ashr i128 %lhs, %rhs
  store i128 %shift, i128 addrspace(1)* null
  ret void
}

define <2 x i128> @v_shl_v2i128_vv(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: v_shl_v2i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v18, vcc, 64, v8
; GCN-NEXT:    v_lshl_b64 v[16:17], v[2:3], v8
; GCN-NEXT:    v_lshr_b64 v[18:19], v[0:1], v18
; GCN-NEXT:    v_cmp_eq_u64_e64 s[8:9], 0, v[10:11]
; GCN-NEXT:    v_cmp_gt_u64_e64 s[6:7], 64, v[8:9]
; GCN-NEXT:    v_or_b32_e32 v11, v9, v11
; GCN-NEXT:    v_subrev_i32_e32 v9, vcc, 64, v8
; GCN-NEXT:    v_or_b32_e32 v10, v8, v10
; GCN-NEXT:    v_or_b32_e32 v19, v17, v19
; GCN-NEXT:    v_or_b32_e32 v18, v16, v18
; GCN-NEXT:    v_lshl_b64 v[16:17], v[0:1], v9
; GCN-NEXT:    s_and_b64 s[6:7], s[8:9], s[6:7]
; GCN-NEXT:    v_cmp_eq_u64_e32 vcc, 0, v[10:11]
; GCN-NEXT:    v_cndmask_b32_e64 v9, v17, v19, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v3, v9, v3, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v9, v16, v18, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v2, v9, v2, vcc
; GCN-NEXT:    v_sub_i32_e32 v11, vcc, 64, v12
; GCN-NEXT:    v_lshl_b64 v[9:10], v[6:7], v12
; GCN-NEXT:    v_lshr_b64 v[16:17], v[4:5], v11
; GCN-NEXT:    v_cmp_gt_u64_e64 s[8:9], 64, v[12:13]
; GCN-NEXT:    v_or_b32_e32 v16, v9, v16
; GCN-NEXT:    v_cmp_eq_u64_e64 s[10:11], 0, v[14:15]
; GCN-NEXT:    v_subrev_i32_e32 v9, vcc, 64, v12
; GCN-NEXT:    v_or_b32_e32 v11, v10, v17
; GCN-NEXT:    v_lshl_b64 v[9:10], v[4:5], v9
; GCN-NEXT:    s_and_b64 vcc, s[10:11], s[8:9]
; GCN-NEXT:    v_cndmask_b32_e32 v17, v10, v11, vcc
; GCN-NEXT:    v_or_b32_e32 v11, v13, v15
; GCN-NEXT:    v_or_b32_e32 v10, v12, v14
; GCN-NEXT:    v_lshl_b64 v[0:1], v[0:1], v8
; GCN-NEXT:    v_lshl_b64 v[4:5], v[4:5], v12
; GCN-NEXT:    v_cmp_eq_u64_e64 s[8:9], 0, v[10:11]
; GCN-NEXT:    v_cndmask_b32_e32 v9, v9, v16, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v7, v17, v7, s[8:9]
; GCN-NEXT:    v_cndmask_b32_e64 v6, v9, v6, s[8:9]
; GCN-NEXT:    v_cndmask_b32_e64 v1, 0, v1, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e64 v0, 0, v0, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v5, 0, v5, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v4, 0, v4, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = shl <2 x i128> %lhs, %rhs
  ret <2 x i128> %shl
}

define <2 x i128> @v_lshr_v2i128_vv(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: v_lshr_v2i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v18, vcc, 64, v8
; GCN-NEXT:    v_lshr_b64 v[16:17], v[0:1], v8
; GCN-NEXT:    v_lshl_b64 v[18:19], v[2:3], v18
; GCN-NEXT:    v_cmp_eq_u64_e64 s[8:9], 0, v[10:11]
; GCN-NEXT:    v_cmp_gt_u64_e64 s[6:7], 64, v[8:9]
; GCN-NEXT:    v_or_b32_e32 v11, v9, v11
; GCN-NEXT:    v_subrev_i32_e32 v9, vcc, 64, v8
; GCN-NEXT:    v_or_b32_e32 v10, v8, v10
; GCN-NEXT:    v_or_b32_e32 v19, v17, v19
; GCN-NEXT:    v_or_b32_e32 v18, v16, v18
; GCN-NEXT:    v_lshr_b64 v[16:17], v[2:3], v9
; GCN-NEXT:    s_and_b64 s[6:7], s[8:9], s[6:7]
; GCN-NEXT:    v_cmp_eq_u64_e32 vcc, 0, v[10:11]
; GCN-NEXT:    v_cndmask_b32_e64 v9, v17, v19, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v1, v9, v1, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v9, v16, v18, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v0, v9, v0, vcc
; GCN-NEXT:    v_sub_i32_e32 v11, vcc, 64, v12
; GCN-NEXT:    v_lshr_b64 v[9:10], v[4:5], v12
; GCN-NEXT:    v_lshl_b64 v[16:17], v[6:7], v11
; GCN-NEXT:    v_cmp_gt_u64_e64 s[8:9], 64, v[12:13]
; GCN-NEXT:    v_or_b32_e32 v16, v9, v16
; GCN-NEXT:    v_cmp_eq_u64_e64 s[10:11], 0, v[14:15]
; GCN-NEXT:    v_subrev_i32_e32 v9, vcc, 64, v12
; GCN-NEXT:    v_or_b32_e32 v11, v10, v17
; GCN-NEXT:    v_lshr_b64 v[9:10], v[6:7], v9
; GCN-NEXT:    s_and_b64 vcc, s[10:11], s[8:9]
; GCN-NEXT:    v_cndmask_b32_e32 v17, v10, v11, vcc
; GCN-NEXT:    v_or_b32_e32 v11, v13, v15
; GCN-NEXT:    v_or_b32_e32 v10, v12, v14
; GCN-NEXT:    v_lshr_b64 v[2:3], v[2:3], v8
; GCN-NEXT:    v_lshr_b64 v[6:7], v[6:7], v12
; GCN-NEXT:    v_cmp_eq_u64_e64 s[8:9], 0, v[10:11]
; GCN-NEXT:    v_cndmask_b32_e32 v9, v9, v16, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v5, v17, v5, s[8:9]
; GCN-NEXT:    v_cndmask_b32_e64 v4, v9, v4, s[8:9]
; GCN-NEXT:    v_cndmask_b32_e64 v3, 0, v3, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e64 v2, 0, v2, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v7, 0, v7, vcc
; GCN-NEXT:    v_cndmask_b32_e32 v6, 0, v6, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = lshr <2 x i128> %lhs, %rhs
  ret <2 x i128> %shl
}

define <2 x i128> @v_ashr_v2i128_vv(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: v_ashr_v2i128_vv:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_sub_i32_e32 v18, vcc, 64, v8
; GCN-NEXT:    v_lshr_b64 v[16:17], v[0:1], v8
; GCN-NEXT:    v_lshl_b64 v[18:19], v[2:3], v18
; GCN-NEXT:    v_cmp_eq_u64_e64 s[8:9], 0, v[10:11]
; GCN-NEXT:    v_cmp_gt_u64_e64 s[6:7], 64, v[8:9]
; GCN-NEXT:    v_or_b32_e32 v11, v9, v11
; GCN-NEXT:    v_subrev_i32_e32 v9, vcc, 64, v8
; GCN-NEXT:    v_or_b32_e32 v10, v8, v10
; GCN-NEXT:    v_or_b32_e32 v19, v17, v19
; GCN-NEXT:    v_or_b32_e32 v18, v16, v18
; GCN-NEXT:    v_ashr_i64 v[16:17], v[2:3], v9
; GCN-NEXT:    s_and_b64 s[6:7], s[8:9], s[6:7]
; GCN-NEXT:    v_cmp_eq_u64_e32 vcc, 0, v[10:11]
; GCN-NEXT:    v_cndmask_b32_e64 v9, v17, v19, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v1, v9, v1, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v9, v16, v18, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v0, v9, v0, vcc
; GCN-NEXT:    v_sub_i32_e32 v11, vcc, 64, v12
; GCN-NEXT:    v_lshr_b64 v[9:10], v[4:5], v12
; GCN-NEXT:    v_lshl_b64 v[16:17], v[6:7], v11
; GCN-NEXT:    v_cmp_gt_u64_e64 s[8:9], 64, v[12:13]
; GCN-NEXT:    v_or_b32_e32 v16, v9, v16
; GCN-NEXT:    v_cmp_eq_u64_e64 s[10:11], 0, v[14:15]
; GCN-NEXT:    v_subrev_i32_e32 v9, vcc, 64, v12
; GCN-NEXT:    v_or_b32_e32 v11, v10, v17
; GCN-NEXT:    v_ashr_i64 v[9:10], v[6:7], v9
; GCN-NEXT:    s_and_b64 vcc, s[10:11], s[8:9]
; GCN-NEXT:    v_cndmask_b32_e32 v17, v10, v11, vcc
; GCN-NEXT:    v_or_b32_e32 v11, v13, v15
; GCN-NEXT:    v_or_b32_e32 v10, v12, v14
; GCN-NEXT:    v_cmp_eq_u64_e64 s[8:9], 0, v[10:11]
; GCN-NEXT:    v_cndmask_b32_e32 v9, v9, v16, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v4, v9, v4, s[8:9]
; GCN-NEXT:    v_ashr_i64 v[8:9], v[2:3], v8
; GCN-NEXT:    v_ashrrev_i32_e32 v2, 31, v3
; GCN-NEXT:    v_cndmask_b32_e64 v3, v2, v9, s[6:7]
; GCN-NEXT:    v_cndmask_b32_e64 v2, v2, v8, s[6:7]
; GCN-NEXT:    v_ashr_i64 v[8:9], v[6:7], v12
; GCN-NEXT:    v_ashrrev_i32_e32 v6, 31, v7
; GCN-NEXT:    v_cndmask_b32_e32 v7, v6, v9, vcc
; GCN-NEXT:    v_cndmask_b32_e64 v5, v17, v5, s[8:9]
; GCN-NEXT:    v_cndmask_b32_e32 v6, v6, v8, vcc
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %shl = ashr <2 x i128> %lhs, %rhs
  ret <2 x i128> %shl
}

define amdgpu_kernel void @s_shl_v2i128ss(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: s_shl_v2i128ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx8 s[8:15], s[4:5], 0x0
; GCN-NEXT:    s_load_dwordx8 s[0:7], s[4:5], 0x8
; GCN-NEXT:    v_mov_b32_e32 v8, 0
; GCN-NEXT:    v_mov_b32_e32 v9, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_cmp_lt_u64_e64 s[16:17], s[0:1], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[18:19], s[2:3], 0
; GCN-NEXT:    s_lshl_b64 s[20:21], s[8:9], s0
; GCN-NEXT:    s_and_b64 vcc, s[18:19], s[16:17]
; GCN-NEXT:    s_sub_i32 s18, 64, s0
; GCN-NEXT:    s_lshl_b64 s[16:17], s[10:11], s0
; GCN-NEXT:    s_lshr_b64 s[18:19], s[8:9], s18
; GCN-NEXT:    s_or_b64 s[16:17], s[16:17], s[18:19]
; GCN-NEXT:    s_sub_i32 s18, s0, 64
; GCN-NEXT:    s_or_b64 s[0:1], s[0:1], s[2:3]
; GCN-NEXT:    s_lshl_b64 s[8:9], s[8:9], s18
; GCN-NEXT:    v_mov_b32_e32 v2, s9
; GCN-NEXT:    v_mov_b32_e32 v3, s17
; GCN-NEXT:    v_cmp_eq_u64_e64 s[0:1], s[0:1], 0
; GCN-NEXT:    v_cndmask_b32_e32 v2, v2, v3, vcc
; GCN-NEXT:    v_mov_b32_e32 v3, s11
; GCN-NEXT:    v_cndmask_b32_e64 v3, v2, v3, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v2, s8
; GCN-NEXT:    v_mov_b32_e32 v4, s16
; GCN-NEXT:    v_cndmask_b32_e32 v2, v2, v4, vcc
; GCN-NEXT:    v_mov_b32_e32 v4, s10
; GCN-NEXT:    v_mov_b32_e32 v0, s21
; GCN-NEXT:    v_cndmask_b32_e64 v2, v2, v4, s[0:1]
; GCN-NEXT:    v_cmp_lt_u64_e64 s[0:1], s[4:5], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[2:3], s[6:7], 0
; GCN-NEXT:    v_cndmask_b32_e32 v1, 0, v0, vcc
; GCN-NEXT:    v_mov_b32_e32 v0, s20
; GCN-NEXT:    v_cndmask_b32_e32 v0, 0, v0, vcc
; GCN-NEXT:    s_and_b64 vcc, s[2:3], s[0:1]
; GCN-NEXT:    s_sub_i32 s2, 64, s4
; GCN-NEXT:    s_lshl_b64 s[8:9], s[12:13], s4
; GCN-NEXT:    s_lshl_b64 s[0:1], s[14:15], s4
; GCN-NEXT:    s_lshr_b64 s[2:3], s[12:13], s2
; GCN-NEXT:    s_or_b64 s[2:3], s[0:1], s[2:3]
; GCN-NEXT:    v_mov_b32_e32 v4, s9
; GCN-NEXT:    s_sub_i32 s0, s4, 64
; GCN-NEXT:    v_cndmask_b32_e32 v5, 0, v4, vcc
; GCN-NEXT:    v_mov_b32_e32 v4, s8
; GCN-NEXT:    s_lshl_b64 s[8:9], s[12:13], s0
; GCN-NEXT:    s_or_b64 s[0:1], s[4:5], s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v6, s9
; GCN-NEXT:    v_mov_b32_e32 v7, s3
; GCN-NEXT:    v_cmp_eq_u64_e64 s[0:1], s[0:1], 0
; GCN-NEXT:    v_cndmask_b32_e32 v6, v6, v7, vcc
; GCN-NEXT:    v_mov_b32_e32 v7, s15
; GCN-NEXT:    v_cndmask_b32_e64 v7, v6, v7, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v6, s8
; GCN-NEXT:    v_mov_b32_e32 v10, s2
; GCN-NEXT:    v_cndmask_b32_e32 v6, v6, v10, vcc
; GCN-NEXT:    v_mov_b32_e32 v10, s14
; GCN-NEXT:    v_cndmask_b32_e64 v6, v6, v10, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v10, 16
; GCN-NEXT:    v_cndmask_b32_e32 v4, 0, v4, vcc
; GCN-NEXT:    v_mov_b32_e32 v11, 0
; GCN-NEXT:    flat_store_dwordx4 v[8:9], v[0:3]
; GCN-NEXT:    flat_store_dwordx4 v[10:11], v[4:7]
; GCN-NEXT:    s_endpgm
; GCN-NEXT:    .section .rodata,#alloc
; GCN-NEXT:    .p2align 6
; GCN-NEXT:    .amdhsa_kernel s_shl_v2i128ss
; GCN-NEXT:     .amdhsa_group_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_private_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_buffer 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_queue_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_kernarg_segment_ptr 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_id 0
; GCN-NEXT:     .amdhsa_user_sgpr_flat_scratch_init 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_size 0
; GCN-NEXT:     .amdhsa_system_sgpr_private_segment_wavefront_offset 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_x 1
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_y 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_z 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_info 0
; GCN-NEXT:     .amdhsa_system_vgpr_workitem_id 0
; GCN-NEXT:     .amdhsa_next_free_vgpr 16
; GCN-NEXT:     .amdhsa_next_free_sgpr 22
; GCN-NEXT:     .amdhsa_reserve_flat_scratch 0
; GCN-NEXT:     .amdhsa_float_round_mode_32 0
; GCN-NEXT:     .amdhsa_float_round_mode_16_64 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_32 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_16_64 3
; GCN-NEXT:     .amdhsa_dx10_clamp 1
; GCN-NEXT:     .amdhsa_ieee_mode 1
; GCN-NEXT:     .amdhsa_exception_fp_ieee_invalid_op 0
; GCN-NEXT:     .amdhsa_exception_fp_denorm_src 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_div_zero 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_overflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_underflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_inexact 0
; GCN-NEXT:     .amdhsa_exception_int_div_zero 0
; GCN-NEXT:    .end_amdhsa_kernel
; GCN-NEXT:    .text
  %shift = shl <2 x i128> %lhs, %rhs
  store <2 x i128> %shift, <2 x i128> addrspace(1)* null
  ret void
}

define amdgpu_kernel void @s_lshr_v2i128_ss(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: s_lshr_v2i128_ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx8 s[8:15], s[4:5], 0x0
; GCN-NEXT:    s_load_dwordx8 s[0:7], s[4:5], 0x8
; GCN-NEXT:    v_mov_b32_e32 v8, 0
; GCN-NEXT:    v_mov_b32_e32 v9, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_cmp_lt_u64_e64 s[16:17], s[0:1], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[18:19], s[2:3], 0
; GCN-NEXT:    s_lshr_b64 s[20:21], s[10:11], s0
; GCN-NEXT:    s_and_b64 vcc, s[18:19], s[16:17]
; GCN-NEXT:    s_sub_i32 s18, 64, s0
; GCN-NEXT:    s_lshr_b64 s[16:17], s[8:9], s0
; GCN-NEXT:    s_lshl_b64 s[18:19], s[10:11], s18
; GCN-NEXT:    s_or_b64 s[16:17], s[16:17], s[18:19]
; GCN-NEXT:    s_sub_i32 s18, s0, 64
; GCN-NEXT:    v_mov_b32_e32 v0, s21
; GCN-NEXT:    s_or_b64 s[0:1], s[0:1], s[2:3]
; GCN-NEXT:    v_cndmask_b32_e32 v3, 0, v0, vcc
; GCN-NEXT:    v_mov_b32_e32 v0, s20
; GCN-NEXT:    s_lshr_b64 s[10:11], s[10:11], s18
; GCN-NEXT:    v_cndmask_b32_e32 v2, 0, v0, vcc
; GCN-NEXT:    v_mov_b32_e32 v0, s11
; GCN-NEXT:    v_mov_b32_e32 v1, s17
; GCN-NEXT:    v_cmp_eq_u64_e64 s[0:1], s[0:1], 0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v1, vcc
; GCN-NEXT:    v_mov_b32_e32 v1, s9
; GCN-NEXT:    v_cndmask_b32_e64 v1, v0, v1, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v0, s10
; GCN-NEXT:    v_mov_b32_e32 v4, s16
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v4, vcc
; GCN-NEXT:    v_mov_b32_e32 v4, s8
; GCN-NEXT:    v_cndmask_b32_e64 v0, v0, v4, s[0:1]
; GCN-NEXT:    v_cmp_lt_u64_e64 s[0:1], s[4:5], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[2:3], s[6:7], 0
; GCN-NEXT:    s_lshr_b64 s[8:9], s[14:15], s4
; GCN-NEXT:    s_and_b64 vcc, s[2:3], s[0:1]
; GCN-NEXT:    s_sub_i32 s2, 64, s4
; GCN-NEXT:    s_lshr_b64 s[0:1], s[12:13], s4
; GCN-NEXT:    s_lshl_b64 s[2:3], s[14:15], s2
; GCN-NEXT:    s_or_b64 s[2:3], s[0:1], s[2:3]
; GCN-NEXT:    v_mov_b32_e32 v4, s9
; GCN-NEXT:    s_sub_i32 s0, s4, 64
; GCN-NEXT:    v_cndmask_b32_e32 v7, 0, v4, vcc
; GCN-NEXT:    v_mov_b32_e32 v4, s8
; GCN-NEXT:    s_lshr_b64 s[8:9], s[14:15], s0
; GCN-NEXT:    s_or_b64 s[0:1], s[4:5], s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v6, 0, v4, vcc
; GCN-NEXT:    v_mov_b32_e32 v4, s9
; GCN-NEXT:    v_mov_b32_e32 v5, s3
; GCN-NEXT:    v_cmp_eq_u64_e64 s[0:1], s[0:1], 0
; GCN-NEXT:    v_cndmask_b32_e32 v4, v4, v5, vcc
; GCN-NEXT:    v_mov_b32_e32 v5, s13
; GCN-NEXT:    v_cndmask_b32_e64 v5, v4, v5, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v4, s8
; GCN-NEXT:    v_mov_b32_e32 v10, s2
; GCN-NEXT:    v_cndmask_b32_e32 v4, v4, v10, vcc
; GCN-NEXT:    v_mov_b32_e32 v10, s12
; GCN-NEXT:    v_cndmask_b32_e64 v4, v4, v10, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v10, 16
; GCN-NEXT:    v_mov_b32_e32 v11, 0
; GCN-NEXT:    flat_store_dwordx4 v[8:9], v[0:3]
; GCN-NEXT:    flat_store_dwordx4 v[10:11], v[4:7]
; GCN-NEXT:    s_endpgm
; GCN-NEXT:    .section .rodata,#alloc
; GCN-NEXT:    .p2align 6
; GCN-NEXT:    .amdhsa_kernel s_lshr_v2i128_ss
; GCN-NEXT:     .amdhsa_group_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_private_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_buffer 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_queue_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_kernarg_segment_ptr 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_id 0
; GCN-NEXT:     .amdhsa_user_sgpr_flat_scratch_init 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_size 0
; GCN-NEXT:     .amdhsa_system_sgpr_private_segment_wavefront_offset 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_x 1
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_y 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_z 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_info 0
; GCN-NEXT:     .amdhsa_system_vgpr_workitem_id 0
; GCN-NEXT:     .amdhsa_next_free_vgpr 16
; GCN-NEXT:     .amdhsa_next_free_sgpr 22
; GCN-NEXT:     .amdhsa_reserve_flat_scratch 0
; GCN-NEXT:     .amdhsa_float_round_mode_32 0
; GCN-NEXT:     .amdhsa_float_round_mode_16_64 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_32 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_16_64 3
; GCN-NEXT:     .amdhsa_dx10_clamp 1
; GCN-NEXT:     .amdhsa_ieee_mode 1
; GCN-NEXT:     .amdhsa_exception_fp_ieee_invalid_op 0
; GCN-NEXT:     .amdhsa_exception_fp_denorm_src 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_div_zero 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_overflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_underflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_inexact 0
; GCN-NEXT:     .amdhsa_exception_int_div_zero 0
; GCN-NEXT:    .end_amdhsa_kernel
; GCN-NEXT:    .text
  %shift = lshr <2 x i128> %lhs, %rhs
  store <2 x i128> %shift, <2 x i128> addrspace(1)* null
  ret void
}

define amdgpu_kernel void @s_ashr_v2i128_ss(<2 x i128> %lhs, <2 x i128> %rhs) {
; GCN-LABEL: s_ashr_v2i128_ss:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx8 s[8:15], s[4:5], 0x0
; GCN-NEXT:    s_load_dwordx8 s[0:7], s[4:5], 0x8
; GCN-NEXT:    v_mov_b32_e32 v8, 0
; GCN-NEXT:    v_mov_b32_e32 v9, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_ashr_i32 s22, s11, 31
; GCN-NEXT:    v_cmp_lt_u64_e64 s[16:17], s[0:1], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[18:19], s[2:3], 0
; GCN-NEXT:    s_ashr_i64 s[20:21], s[10:11], s0
; GCN-NEXT:    s_and_b64 vcc, s[18:19], s[16:17]
; GCN-NEXT:    s_sub_i32 s18, 64, s0
; GCN-NEXT:    s_lshr_b64 s[16:17], s[8:9], s0
; GCN-NEXT:    s_lshl_b64 s[18:19], s[10:11], s18
; GCN-NEXT:    s_or_b64 s[16:17], s[16:17], s[18:19]
; GCN-NEXT:    s_sub_i32 s18, s0, 64
; GCN-NEXT:    v_mov_b32_e32 v0, s22
; GCN-NEXT:    v_mov_b32_e32 v1, s21
; GCN-NEXT:    s_or_b64 s[0:1], s[0:1], s[2:3]
; GCN-NEXT:    v_cndmask_b32_e32 v3, v0, v1, vcc
; GCN-NEXT:    v_mov_b32_e32 v1, s20
; GCN-NEXT:    s_ashr_i64 s[10:11], s[10:11], s18
; GCN-NEXT:    v_cndmask_b32_e32 v2, v0, v1, vcc
; GCN-NEXT:    v_mov_b32_e32 v0, s11
; GCN-NEXT:    v_mov_b32_e32 v1, s17
; GCN-NEXT:    v_cmp_eq_u64_e64 s[0:1], s[0:1], 0
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v1, vcc
; GCN-NEXT:    v_mov_b32_e32 v1, s9
; GCN-NEXT:    v_cndmask_b32_e64 v1, v0, v1, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v0, s10
; GCN-NEXT:    v_mov_b32_e32 v4, s16
; GCN-NEXT:    v_cndmask_b32_e32 v0, v0, v4, vcc
; GCN-NEXT:    v_mov_b32_e32 v4, s8
; GCN-NEXT:    v_cndmask_b32_e64 v0, v0, v4, s[0:1]
; GCN-NEXT:    v_cmp_lt_u64_e64 s[0:1], s[4:5], 64
; GCN-NEXT:    v_cmp_eq_u64_e64 s[2:3], s[6:7], 0
; GCN-NEXT:    s_ashr_i64 s[8:9], s[14:15], s4
; GCN-NEXT:    s_and_b64 vcc, s[2:3], s[0:1]
; GCN-NEXT:    s_sub_i32 s2, 64, s4
; GCN-NEXT:    s_ashr_i32 s10, s15, 31
; GCN-NEXT:    s_lshr_b64 s[0:1], s[12:13], s4
; GCN-NEXT:    s_lshl_b64 s[2:3], s[14:15], s2
; GCN-NEXT:    s_or_b64 s[2:3], s[0:1], s[2:3]
; GCN-NEXT:    v_mov_b32_e32 v4, s10
; GCN-NEXT:    v_mov_b32_e32 v5, s9
; GCN-NEXT:    s_sub_i32 s0, s4, 64
; GCN-NEXT:    v_cndmask_b32_e32 v7, v4, v5, vcc
; GCN-NEXT:    v_mov_b32_e32 v5, s8
; GCN-NEXT:    s_ashr_i64 s[8:9], s[14:15], s0
; GCN-NEXT:    s_or_b64 s[0:1], s[4:5], s[6:7]
; GCN-NEXT:    v_cndmask_b32_e32 v6, v4, v5, vcc
; GCN-NEXT:    v_mov_b32_e32 v4, s9
; GCN-NEXT:    v_mov_b32_e32 v5, s3
; GCN-NEXT:    v_cmp_eq_u64_e64 s[0:1], s[0:1], 0
; GCN-NEXT:    v_cndmask_b32_e32 v4, v4, v5, vcc
; GCN-NEXT:    v_mov_b32_e32 v5, s13
; GCN-NEXT:    v_cndmask_b32_e64 v5, v4, v5, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v4, s8
; GCN-NEXT:    v_mov_b32_e32 v10, s2
; GCN-NEXT:    v_cndmask_b32_e32 v4, v4, v10, vcc
; GCN-NEXT:    v_mov_b32_e32 v10, s12
; GCN-NEXT:    v_cndmask_b32_e64 v4, v4, v10, s[0:1]
; GCN-NEXT:    v_mov_b32_e32 v10, 16
; GCN-NEXT:    v_mov_b32_e32 v11, 0
; GCN-NEXT:    flat_store_dwordx4 v[8:9], v[0:3]
; GCN-NEXT:    flat_store_dwordx4 v[10:11], v[4:7]
; GCN-NEXT:    s_endpgm
; GCN-NEXT:    .section .rodata,#alloc
; GCN-NEXT:    .p2align 6
; GCN-NEXT:    .amdhsa_kernel s_ashr_v2i128_ss
; GCN-NEXT:     .amdhsa_group_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_private_segment_fixed_size 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_buffer 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_queue_ptr 0
; GCN-NEXT:     .amdhsa_user_sgpr_kernarg_segment_ptr 1
; GCN-NEXT:     .amdhsa_user_sgpr_dispatch_id 0
; GCN-NEXT:     .amdhsa_user_sgpr_flat_scratch_init 0
; GCN-NEXT:     .amdhsa_user_sgpr_private_segment_size 0
; GCN-NEXT:     .amdhsa_system_sgpr_private_segment_wavefront_offset 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_x 1
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_y 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_id_z 0
; GCN-NEXT:     .amdhsa_system_sgpr_workgroup_info 0
; GCN-NEXT:     .amdhsa_system_vgpr_workitem_id 0
; GCN-NEXT:     .amdhsa_next_free_vgpr 16
; GCN-NEXT:     .amdhsa_next_free_sgpr 23
; GCN-NEXT:     .amdhsa_reserve_flat_scratch 0
; GCN-NEXT:     .amdhsa_float_round_mode_32 0
; GCN-NEXT:     .amdhsa_float_round_mode_16_64 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_32 0
; GCN-NEXT:     .amdhsa_float_denorm_mode_16_64 3
; GCN-NEXT:     .amdhsa_dx10_clamp 1
; GCN-NEXT:     .amdhsa_ieee_mode 1
; GCN-NEXT:     .amdhsa_exception_fp_ieee_invalid_op 0
; GCN-NEXT:     .amdhsa_exception_fp_denorm_src 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_div_zero 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_overflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_underflow 0
; GCN-NEXT:     .amdhsa_exception_fp_ieee_inexact 0
; GCN-NEXT:     .amdhsa_exception_int_div_zero 0
; GCN-NEXT:    .end_amdhsa_kernel
; GCN-NEXT:    .text
  %shift = ashr <2 x i128> %lhs, %rhs
  store <2 x i128> %shift, <2 x i128> addrspace(1)* null
  ret void
}

