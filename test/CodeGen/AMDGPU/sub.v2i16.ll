; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx900 -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck %s -enable-var-scope -check-prefixes=GCN,GFX89,GFX9
; RUN: llc -march=amdgcn -mcpu=tonga -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck %s -enable-var-scope -check-prefixes=GCN,GFX89,VI

; FIXME: Need to handle non-uniform case for function below (load without gep).
define amdgpu_kernel void @v_test_sub_v2i16(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in0, <2 x i16> addrspace(1)* %in1) #1 {
; GFX9-LABEL: v_test_sub_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, s7
; GFX9-NEXT:    v_add_co_u32_e32 v0, vcc, s6, v2
; GFX9-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GFX9-NEXT:    v_mov_b32_e32 v3, s9
; GFX9-NEXT:    v_add_co_u32_e32 v2, vcc, s8, v2
; GFX9-NEXT:    v_addc_co_u32_e32 v3, vcc, 0, v3, vcc
; GFX9-NEXT:    global_load_dword v0, v[0:1], off
; GFX9-NEXT:    global_load_dword v1, v[2:3], off
; GFX9-NEXT:    s_mov_b32 s0, s4
; GFX9-NEXT:    s_mov_b32 s1, s5
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v0, v0, v1
; GFX9-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_test_sub_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v3, s9
; VI-NEXT:    v_add_u32_e32 v2, vcc, s8, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    flat_load_dword v1, v[2:3]
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; VI-NEXT:    v_sub_u16_e32 v2, v0, v1
; VI-NEXT:    v_sub_u16_sdwa v0, v0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_or_b32_e32 v0, v2, v0
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.out = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %out, i32 %tid
  %gep.in0 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in0, i32 %tid
  %gep.in1 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in1, i32 %tid
  %a = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in0
  %b = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in1
  %add = sub <2 x i16> %a, %b
  store <2 x i16> %add, <2 x i16> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @s_test_sub_v2i16(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(4)* %in0, <2 x i16> addrspace(4)* %in1) #1 {
; GFX9-LABEL: s_test_sub_v2i16:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_mov_b32 s0, s4
; GFX9-NEXT:    s_mov_b32 s1, s5
; GFX9-NEXT:    s_load_dword s4, s[6:7], 0x0
; GFX9-NEXT:    s_load_dword s5, s[8:9], 0x0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, s5
; GFX9-NEXT:    v_pk_sub_i16 v0, s4, v0
; GFX9-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: s_test_sub_v2i16:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_load_dword s4, s[6:7], 0x0
; VI-NEXT:    s_load_dword s5, s[8:9], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_lshr_b32 s6, s4, 16
; VI-NEXT:    s_lshr_b32 s7, s5, 16
; VI-NEXT:    s_sub_i32 s4, s4, s5
; VI-NEXT:    s_sub_i32 s5, s6, s7
; VI-NEXT:    s_and_b32 s4, s4, 0xffff
; VI-NEXT:    s_lshl_b32 s5, s5, 16
; VI-NEXT:    s_or_b32 s4, s4, s5
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %a = load <2 x i16>, <2 x i16> addrspace(4)* %in0
  %b = load <2 x i16>, <2 x i16> addrspace(4)* %in1
  %add = sub <2 x i16> %a, %b
  store <2 x i16> %add, <2 x i16> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @s_test_sub_self_v2i16(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(4)* %in0) #1 {
; GCN-LABEL: s_test_sub_self_v2i16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x24
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_endpgm
  %a = load <2 x i16>, <2 x i16> addrspace(4)* %in0
  %add = sub <2 x i16> %a, %a
  store <2 x i16> %add, <2 x i16> addrspace(1)* %out
  ret void
}

; FIXME: VI should not scalarize arg access.
define amdgpu_kernel void @s_test_sub_v2i16_kernarg(<2 x i16> addrspace(1)* %out, <2 x i16> %a, <2 x i16> %b) #1 {
; GFX9-LABEL: s_test_sub_v2i16_kernarg:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x24
; GFX9-NEXT:    s_load_dword s2, s[0:1], 0x2c
; GFX9-NEXT:    s_load_dword s0, s[0:1], 0x30
; GFX9-NEXT:    s_mov_b32 s7, 0xf000
; GFX9-NEXT:    s_mov_b32 s6, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v0, s0
; GFX9-NEXT:    v_pk_sub_i16 v0, s2, v0
; GFX9-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: s_test_sub_v2i16_kernarg:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x24
; VI-NEXT:    s_load_dword s2, s[0:1], 0x2c
; VI-NEXT:    s_load_dword s0, s[0:1], 0x30
; VI-NEXT:    s_mov_b32 s7, 0xf000
; VI-NEXT:    s_mov_b32 s6, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_lshr_b32 s1, s2, 16
; VI-NEXT:    s_lshr_b32 s3, s0, 16
; VI-NEXT:    s_sub_i32 s1, s1, s3
; VI-NEXT:    s_sub_i32 s0, s2, s0
; VI-NEXT:    s_lshl_b32 s1, s1, 16
; VI-NEXT:    s_and_b32 s0, s0, 0xffff
; VI-NEXT:    s_or_b32 s0, s0, s1
; VI-NEXT:    v_mov_b32_e32 v0, s0
; VI-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; VI-NEXT:    s_endpgm
  %add = sub <2 x i16> %a, %b
  store <2 x i16> %add, <2 x i16> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @v_test_sub_v2i16_constant(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in0) #1 {
; GFX9-LABEL: v_test_sub_v2i16_constant:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, s7
; GFX9-NEXT:    v_add_co_u32_e32 v0, vcc, s6, v0
; GFX9-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GFX9-NEXT:    global_load_dword v0, v[0:1], off
; GFX9-NEXT:    s_mov_b32 s0, s4
; GFX9-NEXT:    s_mov_b32 s4, 0x1c8007b
; GFX9-NEXT:    s_mov_b32 s1, s5
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v0, v0, s4
; GFX9-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_test_sub_v2i16_constant:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; VI-NEXT:    v_mov_b32_e32 v2, 0xfffffe38
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; VI-NEXT:    v_add_u16_e32 v1, 0xffffff85, v0
; VI-NEXT:    v_add_u16_sdwa v0, v0, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v0, v1, v0
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.out = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %out, i32 %tid
  %gep.in0 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in0, i32 %tid
  %a = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in0
  %add = sub <2 x i16> %a, <i16 123, i16 456>
  store <2 x i16> %add, <2 x i16> addrspace(1)* %out
  ret void
}

; FIXME: Need to handle non-uniform case for function below (load without gep).
define amdgpu_kernel void @v_test_sub_v2i16_neg_constant(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in0) #1 {
; GFX9-LABEL: v_test_sub_v2i16_neg_constant:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, s7
; GFX9-NEXT:    v_add_co_u32_e32 v0, vcc, s6, v0
; GFX9-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GFX9-NEXT:    global_load_dword v0, v[0:1], off
; GFX9-NEXT:    s_mov_b32 s0, s4
; GFX9-NEXT:    s_mov_b32 s4, 0xfc21fcb3
; GFX9-NEXT:    s_mov_b32 s1, s5
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v0, v0, s4
; GFX9-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_test_sub_v2i16_neg_constant:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; VI-NEXT:    v_mov_b32_e32 v2, 0x3df
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; VI-NEXT:    v_add_u16_e32 v1, 0x34d, v0
; VI-NEXT:    v_add_u16_sdwa v0, v0, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v0, v1, v0
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.out = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %out, i32 %tid
  %gep.in0 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in0, i32 %tid
  %a = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in0
  %add = sub <2 x i16> %a, <i16 -845, i16 -991>
  store <2 x i16> %add, <2 x i16> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @v_test_sub_v2i16_inline_neg1(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in0) #1 {
; GFX9-LABEL: v_test_sub_v2i16_inline_neg1:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, s7
; GFX9-NEXT:    v_add_co_u32_e32 v0, vcc, s6, v0
; GFX9-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GFX9-NEXT:    global_load_dword v0, v[0:1], off
; GFX9-NEXT:    s_mov_b32 s0, s4
; GFX9-NEXT:    s_mov_b32 s1, s5
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v0, v0, -1 op_sel_hi:[1,0]
; GFX9-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_test_sub_v2i16_inline_neg1:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; VI-NEXT:    v_mov_b32_e32 v2, 1
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; VI-NEXT:    v_add_u16_e32 v1, 1, v0
; VI-NEXT:    v_add_u16_sdwa v0, v0, v2 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_or_b32_e32 v0, v1, v0
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.out = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %out, i32 %tid
  %gep.in0 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in0, i32 %tid
  %a = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in0
  %add = sub <2 x i16> %a, <i16 -1, i16 -1>
  store <2 x i16> %add, <2 x i16> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @v_test_sub_v2i16_inline_lo_zero_hi(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in0) #1 {
; GFX9-LABEL: v_test_sub_v2i16_inline_lo_zero_hi:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, s7
; GFX9-NEXT:    v_add_co_u32_e32 v0, vcc, s6, v0
; GFX9-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GFX9-NEXT:    global_load_dword v0, v[0:1], off
; GFX9-NEXT:    s_mov_b32 s0, s4
; GFX9-NEXT:    s_mov_b32 s1, s5
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v0, v0, 32
; GFX9-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_test_sub_v2i16_inline_lo_zero_hi:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; VI-NEXT:    v_and_b32_e32 v1, 0xffff0000, v0
; VI-NEXT:    v_subrev_u16_e32 v0, 32, v0
; VI-NEXT:    v_or_b32_e32 v0, v0, v1
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.out = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %out, i32 %tid
  %gep.in0 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in0, i32 %tid
  %a = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in0
  %add = sub <2 x i16> %a, <i16 32, i16 0>
  store <2 x i16> %add, <2 x i16> addrspace(1)* %out
  ret void
}

; The high element gives fp
define amdgpu_kernel void @v_test_sub_v2i16_inline_fp_split(<2 x i16> addrspace(1)* %out, <2 x i16> addrspace(1)* %in0) #1 {
; GFX9-LABEL: v_test_sub_v2i16_inline_fp_split:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, s7
; GFX9-NEXT:    v_add_co_u32_e32 v0, vcc, s6, v0
; GFX9-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GFX9-NEXT:    global_load_dword v0, v[0:1], off
; GFX9-NEXT:    s_mov_b32 s0, s4
; GFX9-NEXT:    s_mov_b32 s4, 1.0
; GFX9-NEXT:    s_mov_b32 s1, s5
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v0, v0, s4
; GFX9-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_test_sub_v2i16_inline_fp_split:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v0
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    v_mov_b32_e32 v1, 0xffffc080
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; VI-NEXT:    v_add_u16_sdwa v1, v0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:DWORD
; VI-NEXT:    v_or_b32_sdwa v0, v0, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_0 src1_sel:DWORD
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.out = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %out, i32 %tid
  %gep.in0 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in0, i32 %tid
  %a = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in0
  %add = sub <2 x i16> %a, <i16 0, i16 16256>
  store <2 x i16> %add, <2 x i16> addrspace(1)* %out
  ret void
}

; FIXME: Need to handle non-uniform case for function below (load without gep).
define amdgpu_kernel void @v_test_sub_v2i16_zext_to_v2i32(<2 x i32> addrspace(1)* %out, <2 x i16> addrspace(1)* %in0, <2 x i16> addrspace(1)* %in1) #1 {
; GFX9-LABEL: v_test_sub_v2i16_zext_to_v2i32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, s7
; GFX9-NEXT:    v_add_co_u32_e32 v0, vcc, s6, v2
; GFX9-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GFX9-NEXT:    v_mov_b32_e32 v3, s9
; GFX9-NEXT:    v_add_co_u32_e32 v2, vcc, s8, v2
; GFX9-NEXT:    v_addc_co_u32_e32 v3, vcc, 0, v3, vcc
; GFX9-NEXT:    global_load_dword v0, v[0:1], off
; GFX9-NEXT:    global_load_dword v1, v[2:3], off
; GFX9-NEXT:    s_mov_b32 s0, s4
; GFX9-NEXT:    s_mov_b32 s1, s5
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v0, v0, v1
; GFX9-NEXT:    v_lshrrev_b32_e32 v1, 16, v0
; GFX9-NEXT:    v_and_b32_e32 v0, 0xffff, v0
; GFX9-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_test_sub_v2i16_zext_to_v2i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v3, s9
; VI-NEXT:    v_add_u32_e32 v2, vcc, s8, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v1, v[0:1]
; VI-NEXT:    flat_load_dword v2, v[2:3]
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; VI-NEXT:    v_sub_u16_e32 v0, v1, v2
; VI-NEXT:    v_sub_u16_sdwa v1, v1, v2 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.out = getelementptr inbounds <2 x i32>, <2 x i32> addrspace(1)* %out, i32 %tid
  %gep.in0 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in0, i32 %tid
  %gep.in1 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in1, i32 %tid
  %a = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in0
  %b = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in1
  %add = sub <2 x i16> %a, %b
  %ext = zext <2 x i16> %add to <2 x i32>
  store <2 x i32> %ext, <2 x i32> addrspace(1)* %out
  ret void
}

; FIXME: Need to handle non-uniform case for function below (load without gep).
define amdgpu_kernel void @v_test_sub_v2i16_zext_to_v2i64(<2 x i64> addrspace(1)* %out, <2 x i16> addrspace(1)* %in0, <2 x i16> addrspace(1)* %in1) #1 {
; GFX9-LABEL: v_test_sub_v2i16_zext_to_v2i64:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, s7
; GFX9-NEXT:    v_add_co_u32_e32 v0, vcc, s6, v2
; GFX9-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GFX9-NEXT:    v_mov_b32_e32 v3, s9
; GFX9-NEXT:    v_add_co_u32_e32 v4, vcc, s8, v2
; GFX9-NEXT:    v_addc_co_u32_e32 v5, vcc, 0, v3, vcc
; GFX9-NEXT:    global_load_dword v0, v[0:1], off
; GFX9-NEXT:    global_load_dword v1, v[4:5], off
; GFX9-NEXT:    s_mov_b32 s0, s4
; GFX9-NEXT:    s_mov_b32 s1, s5
; GFX9-NEXT:    v_mov_b32_e32 v3, 0
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v1, v0, v1
; GFX9-NEXT:    v_and_b32_e32 v0, 0xffff, v1
; GFX9-NEXT:    v_lshrrev_b32_e32 v2, 16, v1
; GFX9-NEXT:    v_mov_b32_e32 v1, 0
; GFX9-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_test_sub_v2i16_zext_to_v2i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v3, s9
; VI-NEXT:    v_add_u32_e32 v2, vcc, s8, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v4, v[0:1]
; VI-NEXT:    flat_load_dword v2, v[2:3]
; VI-NEXT:    v_mov_b32_e32 v1, 0
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    v_mov_b32_e32 v3, v1
; VI-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; VI-NEXT:    v_sub_u16_e32 v0, v4, v2
; VI-NEXT:    v_sub_u16_sdwa v2, v4, v2 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.out = getelementptr inbounds <2 x i64>, <2 x i64> addrspace(1)* %out, i32 %tid
  %gep.in0 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in0, i32 %tid
  %gep.in1 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in1, i32 %tid
  %a = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in0
  %b = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in1
  %add = sub <2 x i16> %a, %b
  %ext = zext <2 x i16> %add to <2 x i64>
  store <2 x i64> %ext, <2 x i64> addrspace(1)* %out
  ret void
}

; FIXME: Need to handle non-uniform case for function below (load without gep).
define amdgpu_kernel void @v_test_sub_v2i16_sext_to_v2i32(<2 x i32> addrspace(1)* %out, <2 x i16> addrspace(1)* %in0, <2 x i16> addrspace(1)* %in1) #1 {
; GFX9-LABEL: v_test_sub_v2i16_sext_to_v2i32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, s7
; GFX9-NEXT:    v_add_co_u32_e32 v0, vcc, s6, v2
; GFX9-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GFX9-NEXT:    v_mov_b32_e32 v3, s9
; GFX9-NEXT:    v_add_co_u32_e32 v2, vcc, s8, v2
; GFX9-NEXT:    v_addc_co_u32_e32 v3, vcc, 0, v3, vcc
; GFX9-NEXT:    global_load_dword v0, v[0:1], off
; GFX9-NEXT:    global_load_dword v1, v[2:3], off
; GFX9-NEXT:    s_mov_b32 s0, s4
; GFX9-NEXT:    s_mov_b32 s1, s5
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v0, v0, v1
; GFX9-NEXT:    v_ashrrev_i32_e32 v1, 16, v0
; GFX9-NEXT:    v_bfe_i32 v0, v0, 0, 16
; GFX9-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_test_sub_v2i16_sext_to_v2i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v3, s9
; VI-NEXT:    v_add_u32_e32 v2, vcc, s8, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    flat_load_dword v1, v[2:3]
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; VI-NEXT:    v_sub_u16_sdwa v2, v0, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_sub_u16_e32 v0, v0, v1
; VI-NEXT:    v_bfe_i32 v0, v0, 0, 16
; VI-NEXT:    v_bfe_i32 v1, v2, 0, 16
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.out = getelementptr inbounds <2 x i32>, <2 x i32> addrspace(1)* %out, i32 %tid
  %gep.in0 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in0, i32 %tid
  %gep.in1 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in1, i32 %tid
  %a = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in0
  %b = load volatile <2 x i16>, <2 x i16> addrspace(1)* %gep.in1
  %add = sub <2 x i16> %a, %b
  %ext = sext <2 x i16> %add to <2 x i32>
  store <2 x i32> %ext, <2 x i32> addrspace(1)* %out
  ret void
}

; FIXME: Need to handle non-uniform case for function below (load without gep).
define amdgpu_kernel void @v_test_sub_v2i16_sext_to_v2i64(<2 x i64> addrspace(1)* %out, <2 x i16> addrspace(1)* %in0, <2 x i16> addrspace(1)* %in1) #1 {
; GFX9-LABEL: v_test_sub_v2i16_sext_to_v2i64:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; GFX9-NEXT:    s_mov_b32 s3, 0xf000
; GFX9-NEXT:    s_mov_b32 s2, -1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, s7
; GFX9-NEXT:    v_add_co_u32_e32 v0, vcc, s6, v2
; GFX9-NEXT:    v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
; GFX9-NEXT:    v_mov_b32_e32 v3, s9
; GFX9-NEXT:    v_add_co_u32_e32 v2, vcc, s8, v2
; GFX9-NEXT:    v_addc_co_u32_e32 v3, vcc, 0, v3, vcc
; GFX9-NEXT:    global_load_dword v0, v[0:1], off
; GFX9-NEXT:    global_load_dword v1, v[2:3], off
; GFX9-NEXT:    s_mov_b32 s0, s4
; GFX9-NEXT:    s_mov_b32 s1, s5
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_pk_sub_i16 v1, v0, v1
; GFX9-NEXT:    v_lshrrev_b32_e32 v2, 16, v1
; GFX9-NEXT:    v_bfe_i32 v0, v1, 0, 16
; GFX9-NEXT:    v_bfe_i32 v2, v2, 0, 16
; GFX9-NEXT:    v_ashrrev_i32_e32 v1, 31, v0
; GFX9-NEXT:    v_ashrrev_i32_e32 v3, 31, v2
; GFX9-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; GFX9-NEXT:    s_endpgm
;
; VI-LABEL: v_test_sub_v2i16_sext_to_v2i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[8:9], s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v3, s9
; VI-NEXT:    v_add_u32_e32 v2, vcc, s8, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    flat_load_dword v1, v[2:3]
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; VI-NEXT:    v_sub_u16_sdwa v2, v0, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1 src1_sel:WORD_1
; VI-NEXT:    v_sub_u16_e32 v0, v0, v1
; VI-NEXT:    v_bfe_i32 v0, v0, 0, 16
; VI-NEXT:    v_bfe_i32 v2, v2, 0, 16
; VI-NEXT:    v_ashrrev_i32_e32 v1, 31, v0
; VI-NEXT:    v_ashrrev_i32_e32 v3, 31, v2
; VI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep.out = getelementptr inbounds <2 x i64>, <2 x i64> addrspace(1)* %out, i32 %tid
  %gep.in0 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in0, i32 %tid
  %gep.in1 = getelementptr inbounds <2 x i16>, <2 x i16> addrspace(1)* %in1, i32 %tid
  %a = load <2 x i16>, <2 x i16> addrspace(1)* %gep.in0
  %b = load <2 x i16>, <2 x i16> addrspace(1)* %gep.in1
  %add = sub <2 x i16> %a, %b
  %ext = sext <2 x i16> %add to <2 x i64>
  store <2 x i64> %ext, <2 x i64> addrspace(1)* %out
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #0

attributes #0 = { nounwind readnone }
attributes #1 = { nounwind }
