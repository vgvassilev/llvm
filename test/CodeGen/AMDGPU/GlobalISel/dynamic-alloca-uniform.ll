; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck --check-prefix=GFX9 %s
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck --check-prefix=GFX10 %s

@gv = external addrspace(4) constant i32

define amdgpu_kernel void @kernel_dynamic_stackalloc_sgpr_align4(i32 %n) {
; GFX9-LABEL: kernel_dynamic_stackalloc_sgpr_align4:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX9-NEXT:    s_add_u32 flat_scratch_lo, s6, s9
; GFX9-NEXT:    s_addc_u32 flat_scratch_hi, s7, 0
; GFX9-NEXT:    s_add_u32 s0, s0, s9
; GFX9-NEXT:    s_addc_u32 s1, s1, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX9-NEXT:    s_and_b32 s4, s4, -16
; GFX9-NEXT:    s_movk_i32 s32, 0x400
; GFX9-NEXT:    s_lshl_b32 s4, s4, 6
; GFX9-NEXT:    s_add_u32 s4, s32, s4
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    v_mov_b32_e32 v1, s4
; GFX9-NEXT:    s_mov_b32 s33, 0
; GFX9-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX9-NEXT:    s_endpgm
;
; GFX10-LABEL: kernel_dynamic_stackalloc_sgpr_align4:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_add_u32 s6, s6, s9
; GFX10-NEXT:    s_movk_i32 s32, 0x200
; GFX10-NEXT:    s_mov_b32 s33, 0
; GFX10-NEXT:    s_addc_u32 s7, s7, 0
; GFX10-NEXT:    s_setreg_b32 hwreg(HW_REG_FLAT_SCR_LO), s6
; GFX10-NEXT:    s_setreg_b32 hwreg(HW_REG_FLAT_SCR_HI), s7
; GFX10-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX10-NEXT:    s_add_u32 s0, s0, s9
; GFX10-NEXT:    s_addc_u32 s1, s1, 0
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX10-NEXT:    s_and_b32 s4, s4, -16
; GFX10-NEXT:    s_lshl_b32 s4, s4, 5
; GFX10-NEXT:    s_add_u32 s4, s32, s4
; GFX10-NEXT:    v_mov_b32_e32 v1, s4
; GFX10-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX10-NEXT:    s_endpgm
  %alloca = alloca i32, i32 %n, align 4, addrspace(5)
  store i32 0, i32 addrspace(5)* %alloca
  ret void
}

define void @func_dynamic_stackalloc_sgpr_align4() {
; GFX9-LABEL: func_dynamic_stackalloc_sgpr_align4:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    s_mov_b32 s6, s33
; GFX9-NEXT:    s_mov_b32 s33, s32
; GFX9-NEXT:    s_addk_i32 s32, 0x400
; GFX9-NEXT:    s_getpc_b64 s[4:5]
; GFX9-NEXT:    s_add_u32 s4, s4, gv@gotpcrel32@lo+4
; GFX9-NEXT:    s_addc_u32 s5, s5, gv@gotpcrel32@hi+12
; GFX9-NEXT:    s_load_dwordx2 s[4:5], s[4:5], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_mov_b32 s33, s6
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX9-NEXT:    s_and_b32 s4, s4, -16
; GFX9-NEXT:    s_lshl_b32 s4, s4, 6
; GFX9-NEXT:    s_add_u32 s4, s32, s4
; GFX9-NEXT:    v_mov_b32_e32 v1, s4
; GFX9-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX9-NEXT:    s_addk_i32 s32, 0xfc00
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: func_dynamic_stackalloc_sgpr_align4:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    s_mov_b32 s6, s33
; GFX10-NEXT:    s_mov_b32 s33, s32
; GFX10-NEXT:    s_addk_i32 s32, 0x200
; GFX10-NEXT:    s_getpc_b64 s[4:5]
; GFX10-NEXT:    s_add_u32 s4, s4, gv@gotpcrel32@lo+4
; GFX10-NEXT:    s_addc_u32 s5, s5, gv@gotpcrel32@hi+12
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    s_load_dwordx2 s[4:5], s[4:5], 0x0
; GFX10-NEXT:    s_mov_b32 s33, s6
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX10-NEXT:    s_and_b32 s4, s4, -16
; GFX10-NEXT:    s_lshl_b32 s4, s4, 5
; GFX10-NEXT:    s_add_u32 s4, s32, s4
; GFX10-NEXT:    s_addk_i32 s32, 0xfe00
; GFX10-NEXT:    v_mov_b32_e32 v1, s4
; GFX10-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %n = load i32, i32 addrspace(4)* @gv, align 4
  %alloca = alloca i32, i32 %n, addrspace(5)
  store i32 0, i32 addrspace(5)* %alloca
  ret void
}

define amdgpu_kernel void @kernel_dynamic_stackalloc_sgpr_align16(i32 %n) {
; GFX9-LABEL: kernel_dynamic_stackalloc_sgpr_align16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX9-NEXT:    s_add_u32 flat_scratch_lo, s6, s9
; GFX9-NEXT:    s_addc_u32 flat_scratch_hi, s7, 0
; GFX9-NEXT:    s_add_u32 s0, s0, s9
; GFX9-NEXT:    s_addc_u32 s1, s1, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX9-NEXT:    s_and_b32 s4, s4, -16
; GFX9-NEXT:    s_movk_i32 s32, 0x400
; GFX9-NEXT:    s_lshl_b32 s4, s4, 6
; GFX9-NEXT:    s_add_u32 s4, s32, s4
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    v_mov_b32_e32 v1, s4
; GFX9-NEXT:    s_mov_b32 s33, 0
; GFX9-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX9-NEXT:    s_endpgm
;
; GFX10-LABEL: kernel_dynamic_stackalloc_sgpr_align16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_add_u32 s6, s6, s9
; GFX10-NEXT:    s_movk_i32 s32, 0x200
; GFX10-NEXT:    s_mov_b32 s33, 0
; GFX10-NEXT:    s_addc_u32 s7, s7, 0
; GFX10-NEXT:    s_setreg_b32 hwreg(HW_REG_FLAT_SCR_LO), s6
; GFX10-NEXT:    s_setreg_b32 hwreg(HW_REG_FLAT_SCR_HI), s7
; GFX10-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX10-NEXT:    s_add_u32 s0, s0, s9
; GFX10-NEXT:    s_addc_u32 s1, s1, 0
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX10-NEXT:    s_and_b32 s4, s4, -16
; GFX10-NEXT:    s_lshl_b32 s4, s4, 5
; GFX10-NEXT:    s_add_u32 s4, s32, s4
; GFX10-NEXT:    v_mov_b32_e32 v1, s4
; GFX10-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX10-NEXT:    s_endpgm
  %alloca = alloca i32, i32 %n, align 16, addrspace(5)
  store i32 0, i32 addrspace(5)* %alloca
  ret void
}

define void @func_dynamic_stackalloc_sgpr_align16() {
; GFX9-LABEL: func_dynamic_stackalloc_sgpr_align16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    s_mov_b32 s6, s33
; GFX9-NEXT:    s_mov_b32 s33, s32
; GFX9-NEXT:    s_addk_i32 s32, 0x400
; GFX9-NEXT:    s_getpc_b64 s[4:5]
; GFX9-NEXT:    s_add_u32 s4, s4, gv@gotpcrel32@lo+4
; GFX9-NEXT:    s_addc_u32 s5, s5, gv@gotpcrel32@hi+12
; GFX9-NEXT:    s_load_dwordx2 s[4:5], s[4:5], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_mov_b32 s33, s6
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX9-NEXT:    s_and_b32 s4, s4, -16
; GFX9-NEXT:    s_lshl_b32 s4, s4, 6
; GFX9-NEXT:    s_add_u32 s4, s32, s4
; GFX9-NEXT:    v_mov_b32_e32 v1, s4
; GFX9-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX9-NEXT:    s_addk_i32 s32, 0xfc00
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: func_dynamic_stackalloc_sgpr_align16:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    s_mov_b32 s6, s33
; GFX10-NEXT:    s_mov_b32 s33, s32
; GFX10-NEXT:    s_addk_i32 s32, 0x200
; GFX10-NEXT:    s_getpc_b64 s[4:5]
; GFX10-NEXT:    s_add_u32 s4, s4, gv@gotpcrel32@lo+4
; GFX10-NEXT:    s_addc_u32 s5, s5, gv@gotpcrel32@hi+12
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    s_load_dwordx2 s[4:5], s[4:5], 0x0
; GFX10-NEXT:    s_mov_b32 s33, s6
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX10-NEXT:    s_and_b32 s4, s4, -16
; GFX10-NEXT:    s_lshl_b32 s4, s4, 5
; GFX10-NEXT:    s_add_u32 s4, s32, s4
; GFX10-NEXT:    s_addk_i32 s32, 0xfe00
; GFX10-NEXT:    v_mov_b32_e32 v1, s4
; GFX10-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %n = load i32, i32 addrspace(4)* @gv, align 16
  %alloca = alloca i32, i32 %n, addrspace(5)
  store i32 0, i32 addrspace(5)* %alloca
  ret void
}

define amdgpu_kernel void @kernel_dynamic_stackalloc_sgpr_align32(i32 %n) {
; GFX9-LABEL: kernel_dynamic_stackalloc_sgpr_align32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX9-NEXT:    s_add_u32 flat_scratch_lo, s6, s9
; GFX9-NEXT:    s_addc_u32 flat_scratch_hi, s7, 0
; GFX9-NEXT:    s_add_u32 s0, s0, s9
; GFX9-NEXT:    s_addc_u32 s1, s1, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX9-NEXT:    s_and_b32 s4, s4, -16
; GFX9-NEXT:    s_movk_i32 s32, 0x800
; GFX9-NEXT:    s_lshl_b32 s4, s4, 6
; GFX9-NEXT:    s_add_u32 s4, s32, s4
; GFX9-NEXT:    s_and_b32 s4, s4, 0xfffff800
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    v_mov_b32_e32 v1, s4
; GFX9-NEXT:    s_mov_b32 s33, 0
; GFX9-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX9-NEXT:    s_endpgm
;
; GFX10-LABEL: kernel_dynamic_stackalloc_sgpr_align32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_add_u32 s6, s6, s9
; GFX10-NEXT:    s_movk_i32 s32, 0x400
; GFX10-NEXT:    s_mov_b32 s33, 0
; GFX10-NEXT:    s_addc_u32 s7, s7, 0
; GFX10-NEXT:    s_setreg_b32 hwreg(HW_REG_FLAT_SCR_LO), s6
; GFX10-NEXT:    s_setreg_b32 hwreg(HW_REG_FLAT_SCR_HI), s7
; GFX10-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX10-NEXT:    s_add_u32 s0, s0, s9
; GFX10-NEXT:    s_addc_u32 s1, s1, 0
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX10-NEXT:    s_and_b32 s4, s4, -16
; GFX10-NEXT:    s_lshl_b32 s4, s4, 5
; GFX10-NEXT:    s_add_u32 s4, s32, s4
; GFX10-NEXT:    s_and_b32 s4, s4, 0xfffffc00
; GFX10-NEXT:    v_mov_b32_e32 v1, s4
; GFX10-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX10-NEXT:    s_endpgm
  %alloca = alloca i32, i32 %n, align 32, addrspace(5)
  store i32 0, i32 addrspace(5)* %alloca
  ret void
}

define void @func_dynamic_stackalloc_sgpr_align32(i32 addrspace(1)* %out) {
; GFX9-LABEL: func_dynamic_stackalloc_sgpr_align32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX9-NEXT:    s_mov_b32 s6, s33
; GFX9-NEXT:    s_add_i32 s33, s32, 0x7c0
; GFX9-NEXT:    s_and_b32 s33, s33, 0xfffff800
; GFX9-NEXT:    s_addk_i32 s32, 0x1000
; GFX9-NEXT:    s_getpc_b64 s[4:5]
; GFX9-NEXT:    s_add_u32 s4, s4, gv@gotpcrel32@lo+4
; GFX9-NEXT:    s_addc_u32 s5, s5, gv@gotpcrel32@hi+12
; GFX9-NEXT:    s_load_dwordx2 s[4:5], s[4:5], 0x0
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_mov_b32 s33, s6
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX9-NEXT:    s_and_b32 s4, s4, -16
; GFX9-NEXT:    s_lshl_b32 s4, s4, 6
; GFX9-NEXT:    s_add_u32 s4, s32, s4
; GFX9-NEXT:    s_and_b32 s4, s4, 0xfffff800
; GFX9-NEXT:    v_mov_b32_e32 v1, s4
; GFX9-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX9-NEXT:    s_addk_i32 s32, 0xf000
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    s_setpc_b64 s[30:31]
;
; GFX10-LABEL: func_dynamic_stackalloc_sgpr_align32:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    s_mov_b32 s6, s33
; GFX10-NEXT:    s_add_i32 s33, s32, 0x3e0
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    s_and_b32 s33, s33, 0xfffffc00
; GFX10-NEXT:    s_addk_i32 s32, 0x800
; GFX10-NEXT:    s_getpc_b64 s[4:5]
; GFX10-NEXT:    s_add_u32 s4, s4, gv@gotpcrel32@lo+4
; GFX10-NEXT:    s_addc_u32 s5, s5, gv@gotpcrel32@hi+12
; GFX10-NEXT:    s_mov_b32 s33, s6
; GFX10-NEXT:    s_load_dwordx2 s[4:5], s[4:5], 0x0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_load_dword s4, s[4:5], 0x0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_lshl2_add_u32 s4, s4, 15
; GFX10-NEXT:    s_and_b32 s4, s4, -16
; GFX10-NEXT:    s_lshl_b32 s4, s4, 5
; GFX10-NEXT:    s_add_u32 s4, s32, s4
; GFX10-NEXT:    s_and_b32 s4, s4, 0xfffffc00
; GFX10-NEXT:    s_addk_i32 s32, 0xf800
; GFX10-NEXT:    v_mov_b32_e32 v1, s4
; GFX10-NEXT:    buffer_store_dword v0, v1, s[0:3], 0 offen
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    s_setpc_b64 s[30:31]
  %n = load i32, i32 addrspace(4)* @gv
  %alloca = alloca i32, i32 %n, align 32, addrspace(5)
  store i32 0, i32 addrspace(5)* %alloca
  ret void
}
