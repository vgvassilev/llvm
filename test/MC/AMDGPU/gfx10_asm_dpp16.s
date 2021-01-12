// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1010 -mattr=+wavefrontsize32,-wavefrontsize64 -show-encoding %s | FileCheck --check-prefixes=GFX10,W32 %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1010 -mattr=-wavefrontsize32,+wavefrontsize64 -show-encoding %s | FileCheck --check-prefixes=GFX10,W64 %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1010 -mattr=+wavefrontsize32,-wavefrontsize64 %s 2>&1 | FileCheck --check-prefix=W32-ERR --implicit-check-not=error: %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=gfx1010 -mattr=-wavefrontsize32,+wavefrontsize64 %s 2>&1 | FileCheck --check-prefix=W64-ERR --implicit-check-not=error: %s

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_mov_b32_dpp v5, v1 quad_perm:[0,1,2,3] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0xe4,0x00,0x00]

v_mov_b32_dpp v5, v1 row_mirror row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x40,0x01,0x00]

v_mov_b32_dpp v5, v1 row_half_mirror row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x41,0x01,0x00]

v_mov_b32_dpp v5, v1 row_shl:1 row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x01,0x01,0x00]

v_mov_b32_dpp v5, v1 row_shl:15 row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x0f,0x01,0x00]

v_mov_b32_dpp v5, v1 row_shr:1 row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x11,0x01,0x00]

v_mov_b32_dpp v5, v1 row_shr:15 row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1f,0x01,0x00]

v_mov_b32_dpp v5, v1 row_ror:1 row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x21,0x01,0x00]

v_mov_b32_dpp v5, v1 row_ror:15 row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x2f,0x01,0x00]

v_mov_b32_dpp v5, v1 row_share:0 row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x50,0x01,0x00]

v_mov_b32_dpp v5, v1 row_share:15 row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x5f,0x01,0x00]

v_mov_b32_dpp v5, v1 row_xmask:0 row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x60,0x01,0x00]

v_mov_b32_dpp v5, v1 row_xmask:15 row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x6f,0x01,0x00]

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x1 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x00,0x10]

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x3 bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x00,0x30]

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0xf bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x00,0xf0]

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] bank_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x00,0xf0]

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x1
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x00,0x01]

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x3
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x00,0x03]

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0xf
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x00,0x0f]

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x00,0x0f]

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 bound_ctrl:0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x08,0x00]

v_cvt_f32_i32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x0a,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_f32_u32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x0c,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_u32_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x0e,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_i32_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x10,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_f16_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x14,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_f32_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x16,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_rpi_i32_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x18,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_flr_i32_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x1a,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_off_f32_i4_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x1c,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_f32_ubyte0_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x22,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_f32_ubyte1_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x24,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_f32_ubyte2_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x26,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_f32_ubyte3_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x28,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_fract_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x40,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_trunc_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x42,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_ceil_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x44,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_rndne_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x46,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_floor_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x48,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_exp_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x4a,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_log_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x4e,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_rcp_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x54,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_rcp_iflag_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x56,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_rsq_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x5c,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_sqrt_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x66,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_sin_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x6a,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cos_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x6c,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_not_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x6e,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_bfrev_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x70,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_ffbh_u32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x72,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_ffbl_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x74,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_ffbh_i32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x76,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_frexp_exp_i32_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x7e,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_frexp_mant_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x80,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_f16_u16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xa0,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_f16_i16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xa2,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_u16_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xa4,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_i16_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xa6,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_rcp_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xa8,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_sqrt_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xaa,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_rsq_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xac,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_log_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xae,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_exp_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xb0,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_frexp_mant_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xb2,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_frexp_exp_i16_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xb4,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_floor_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xb6,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_ceil_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xb8,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_trunc_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xba,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_rndne_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xbc,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_fract_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xbe,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_sin_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xc0,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cos_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xc2,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_sat_pk_u8_i16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xc4,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_norm_i16_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xc6,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_cvt_norm_u16_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0xc8,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_add_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x06,0x01,0x1b,0x00,0x00]

v_add_f32_dpp v5, -v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x06,0x01,0x1b,0x10,0x00]

v_add_f32_dpp v5, |v1|, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x06,0x01,0x1b,0x20,0x00]

v_add_f32_dpp v5, v1, -v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x06,0x01,0x1b,0x40,0x00]

v_add_f32_dpp v5, v1, |v2| quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x06,0x01,0x1b,0x80,0x00]

v_sub_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x08,0x01,0x1b,0x00,0x00]

v_subrev_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x0a,0x01,0x1b,0x00,0x00]

v_mul_legacy_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x0e,0x01,0x1b,0x00,0x00]

v_mul_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x10,0x01,0x1b,0x00,0x00]

v_mul_i32_i24_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x12,0x01,0x1b,0x00,0x00]

v_mul_hi_i32_i24_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x14,0x01,0x1b,0x00,0x00]

v_mul_u32_u24_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x16,0x01,0x1b,0x00,0x00]

v_mul_hi_u32_u24_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x18,0x01,0x1b,0x00,0x00]

v_min_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x1e,0x01,0x1b,0x00,0x00]

v_max_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x20,0x01,0x1b,0x00,0x00]

v_min_i32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x22,0x01,0x1b,0x00,0x00]

v_max_i32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x24,0x01,0x1b,0x00,0x00]

v_min_u32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x26,0x01,0x1b,0x00,0x00]

v_max_u32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x28,0x01,0x1b,0x00,0x00]

v_lshrrev_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x2c,0x01,0x1b,0x00,0x00]

v_ashrrev_i32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x30,0x01,0x1b,0x00,0x00]

v_lshlrev_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x34,0x01,0x1b,0x00,0x00]

v_and_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x36,0x01,0x1b,0x00,0x00]

v_or_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x38,0x01,0x1b,0x00,0x00]

v_xor_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x3a,0x01,0x1b,0x00,0x00]

v_xnor_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x3c,0x01,0x1b,0x00,0x00]

v_mac_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x3e,0x01,0x1b,0x00,0x00]

v_add_co_ci_u32_dpp v5, vcc_lo, v1, v2, vcc_lo quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// W32: [0xfa,0x04,0x0a,0x50,0x01,0x1b,0x00,0x00]
// W64-ERR: error: operands are not valid for this GPU or mode

v_sub_co_ci_u32_dpp v5, vcc_lo, v1, v2, vcc_lo quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// W32: [0xfa,0x04,0x0a,0x52,0x01,0x1b,0x00,0x00]
// W64-ERR: error: operands are not valid for this GPU or mode

v_subrev_co_ci_u32_dpp v5, vcc_lo, v1, v2, vcc_lo quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// W32: [0xfa,0x04,0x0a,0x54,0x01,0x1b,0x00,0x00]
// W64-ERR: error: operands are not valid for this GPU or mode

v_add_co_ci_u32_dpp v5, vcc, v1, v2, vcc quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// W64: [0xfa,0x04,0x0a,0x50,0x01,0x1b,0x00,0x00]
// W32-ERR: error: operands are not valid for this GPU or mode

v_sub_co_ci_u32_dpp v5, vcc, v1, v2, vcc quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// W64: [0xfa,0x04,0x0a,0x52,0x01,0x1b,0x00,0x00]
// W32-ERR: error: operands are not valid for this GPU or mode

v_subrev_co_ci_u32_dpp v5, vcc, v1, v2, vcc quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// W64: [0xfa,0x04,0x0a,0x54,0x01,0x1b,0x00,0x00]
// W32-ERR: error: operands are not valid for this GPU or mode

v_fmac_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x56,0x01,0x1b,0x00,0x00]

v_add_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x64,0x01,0x1b,0x00,0x00]

v_sub_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x66,0x01,0x1b,0x00,0x00]

v_subrev_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x68,0x01,0x1b,0x00,0x00]

v_mul_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x6a,0x01,0x1b,0x00,0x00]

v_fmac_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x6c,0x01,0x1b,0x00,0x00]

v_max_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x72,0x01,0x1b,0x00,0x00]

v_min_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x74,0x01,0x1b,0x00,0x00]

v_ldexp_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x76,0x01,0x1b,0x00,0x00]

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:0
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x00,0x00]

v_mov_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x02,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_f32_i32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x0a,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_f32_u32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x0c,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_u32_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x0e,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_i32_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x10,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_f16_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x14,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_f32_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x16,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_rpi_i32_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x18,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_flr_i32_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x1a,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_off_f32_i4_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x1c,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_f32_ubyte0_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x22,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_f32_ubyte1_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x24,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_f32_ubyte2_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x26,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_f32_ubyte3_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x28,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_fract_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x40,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_trunc_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x42,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_ceil_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x44,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_rndne_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x46,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_floor_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x48,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_exp_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x4a,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_log_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x4e,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_rcp_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x54,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_rcp_iflag_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x56,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_rsq_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x5c,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_sqrt_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x66,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_sin_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x6a,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cos_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x6c,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_not_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x6e,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_bfrev_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x70,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_ffbh_u32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x72,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_ffbl_b32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x74,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_ffbh_i32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x76,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_frexp_exp_i32_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x7e,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_frexp_mant_f32_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x80,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_f16_u16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xa0,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_f16_i16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xa2,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_u16_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xa4,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_i16_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xa6,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_rcp_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xa8,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_sqrt_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xaa,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_rsq_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xac,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_log_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xae,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_exp_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xb0,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_frexp_mant_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xb2,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_frexp_exp_i16_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xb4,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_floor_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xb6,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_ceil_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xb8,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_trunc_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xba,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_rndne_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xbc,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_fract_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xbe,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_sin_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xc0,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cos_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xc2,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_sat_pk_u8_i16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xc4,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_norm_i16_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xc6,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_cvt_norm_u16_f16_dpp v5, v1 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0xc8,0x0a,0x7e,0x01,0x1b,0x04,0x00]

v_add_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x06,0x01,0x1b,0x04,0x00]

v_sub_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x08,0x01,0x1b,0x04,0x00]

v_subrev_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x0a,0x01,0x1b,0x04,0x00]

v_mul_legacy_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x0e,0x01,0x1b,0x04,0x00]

v_mul_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x10,0x01,0x1b,0x04,0x00]

v_mul_i32_i24_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x12,0x01,0x1b,0x04,0x00]

v_mul_hi_i32_i24_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x14,0x01,0x1b,0x04,0x00]

v_mul_u32_u24_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x16,0x01,0x1b,0x04,0x00]

v_mul_hi_u32_u24_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x18,0x01,0x1b,0x04,0x00]

v_min_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x1e,0x01,0x1b,0x04,0x00]

v_max_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x20,0x01,0x1b,0x04,0x00]

v_min_i32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x22,0x01,0x1b,0x04,0x00]

v_max_i32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x24,0x01,0x1b,0x04,0x00]

v_min_u32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x26,0x01,0x1b,0x04,0x00]

v_max_u32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x28,0x01,0x1b,0x04,0x00]

v_lshrrev_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x2c,0x01,0x1b,0x04,0x00]

v_ashrrev_i32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x30,0x01,0x1b,0x04,0x00]

v_lshlrev_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x34,0x01,0x1b,0x04,0x00]

v_and_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x36,0x01,0x1b,0x04,0x00]

v_or_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x38,0x01,0x1b,0x04,0x00]

v_xor_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x3a,0x01,0x1b,0x04,0x00]

v_xnor_b32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x3c,0x01,0x1b,0x04,0x00]

v_mac_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x3e,0x01,0x1b,0x04,0x00]

v_add_co_ci_u32_dpp v5, vcc_lo, v1, v2, vcc_lo quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// W32: [0xfa,0x04,0x0a,0x50,0x01,0x1b,0x04,0x00]
// W64-ERR: error: operands are not valid for this GPU or mode

v_sub_co_ci_u32_dpp v5, vcc_lo, v1, v2, vcc_lo quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// W32: [0xfa,0x04,0x0a,0x52,0x01,0x1b,0x04,0x00]
// W64-ERR: error: operands are not valid for this GPU or mode

v_subrev_co_ci_u32_dpp v5, vcc_lo, v1, v2, vcc_lo quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// W32: [0xfa,0x04,0x0a,0x54,0x01,0x1b,0x04,0x00]
// W64-ERR: error: operands are not valid for this GPU or mode

v_add_co_ci_u32_dpp v5, vcc, v1, v2, vcc quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// W64: [0xfa,0x04,0x0a,0x50,0x01,0x1b,0x04,0x00]
// W32-ERR: error: operands are not valid for this GPU or mode

v_sub_co_ci_u32_dpp v5, vcc, v1, v2, vcc quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// W64: [0xfa,0x04,0x0a,0x52,0x01,0x1b,0x04,0x00]
// W32-ERR: error: operands are not valid for this GPU or mode

v_subrev_co_ci_u32_dpp v5, vcc, v1, v2, vcc quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// W64: [0xfa,0x04,0x0a,0x54,0x01,0x1b,0x04,0x00]
// W32-ERR: error: operands are not valid for this GPU or mode

v_fmac_f32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x56,0x01,0x1b,0x04,0x00]

v_add_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x64,0x01,0x1b,0x04,0x00]

v_sub_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x66,0x01,0x1b,0x04,0x00]

v_subrev_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x68,0x01,0x1b,0x04,0x00]

v_mul_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x6a,0x01,0x1b,0x04,0x00]

v_fmac_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x6c,0x01,0x1b,0x04,0x00]

v_max_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x72,0x01,0x1b,0x04,0x00]

v_min_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x74,0x01,0x1b,0x04,0x00]

v_ldexp_f16_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x76,0x01,0x1b,0x04,0x00]

v_add_nc_u32_dpp v5, v1, v2 quad_perm:[0,1,2,3] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x4a,0x01,0xe4,0x00,0x00]

v_add_nc_u32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 bound_ctrl:0
// GFX10: [0xfa,0x04,0x0a,0x4a,0x01,0x1b,0x08,0x00]

v_add_nc_u32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x4a,0x01,0x1b,0x04,0x00]

v_sub_nc_u32_dpp v5, v1, v2 row_mirror row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x4c,0x01,0x40,0x01,0x00]

v_sub_nc_u32_dpp v5, v1, v2 row_half_mirror row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x4c,0x01,0x41,0x01,0x00]

v_sub_nc_u32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x4c,0x01,0x1b,0x04,0x00]

v_subrev_nc_u32_dpp v5, v1, v2 row_xmask:15 row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x4e,0x01,0x6f,0x01,0x00]

v_subrev_nc_u32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x1 bank_mask:0x0
// GFX10: [0xfa,0x04,0x0a,0x4e,0x01,0x1b,0x00,0x10]

v_subrev_nc_u32_dpp v5, v1, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x04,0x0a,0x4e,0x01,0x1b,0x04,0x00]

v_movreld_b32_dpp v1, v0 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x84,0x02,0x7e,0x00,0x1b,0x00,0x00]

v_movrels_b32_dpp v1, v0 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0 fi:1
// GFX10: [0xfa,0x86,0x02,0x7e,0x00,0x1b,0x04,0x00]

v_movrelsd_2_b32_dpp v0, v2 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x90,0x00,0x7e,0x02,0x1b,0x00,0x00]

v_movrelsd_b32_dpp v0, v255 quad_perm:[3,2,1,0] row_mask:0x0 bank_mask:0x0
// GFX10: [0xfa,0x88,0x00,0x7e,0xff,0x1b,0x00,0x00]
