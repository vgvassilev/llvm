// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1030 %s 2>&1 | FileCheck --check-prefix=GFX10 --implicit-check-not=error: %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1031 %s 2>&1 | FileCheck --check-prefix=GFX10 --implicit-check-not=error: %s

v_dot8c_i32_i4 v5, v1, v2
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_dot8c_i32_i4 v5, v1, v2 quad_perm:[0,1,2,3] row_mask:0x0 bank_mask:0x0
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_dot8c_i32_i4 v5, v1, v2 quad_perm:[0,1,2,3] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_dot8c_i32_i4 v5, v1, v2 dpp8:[7,6,5,4,3,2,1,0]
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_dot8c_i32_i4 v5, v1, v2 dpp8:[7,6,5,4,3,2,1,0] fi:1
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

s_get_waveid_in_workgroup s0
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

s_memtime s[0:1]
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

s_getreg_b32 s2, hwreg(HW_REG_XNACK_MASK)
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: specified hardware register is not supported on this GPU

v_mac_f32 v0, v1, v2
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_mad_f32 v0, v1, v2, v3
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_madak_f32 v0, v1, v2, 1
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_madmk_f32 v0, v1, 1, v2
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_mad_legacy_f32 v0, v1, v2, v3
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

v_mac_legacy_f32 v0, v1, v2
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_add_src2_u32 v1 offset:65535 gds
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_add_src2_u32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_add_src2_f32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_sub_src2_u32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_rsub_src2_u32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_inc_src2_u32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_dec_src2_u32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_min_src2_i32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_max_src2_i32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_min_src2_u32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_max_src2_u32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_and_src2_b32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_or_src2_b32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_xor_src2_b32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_min_src2_f32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_max_src2_f32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_add_src2_u64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_sub_src2_u64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_rsub_src2_u64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_inc_src2_u64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_dec_src2_u64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_min_src2_i64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_max_src2_i64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_min_src2_u64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_max_src2_u64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_and_src2_b64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_or_src2_b64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_xor_src2_b64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_min_src2_f64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_max_src2_f64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_write_src2_b32 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU

ds_write_src2_b64 v1 offset:65535
// GFX10: :[[@LINE-1]]:{{[0-9]+}}: error: instruction not supported on this GPU
