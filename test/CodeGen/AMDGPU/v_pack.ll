; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -amdgpu-scalarize-global-loads=false -march=amdgcn -mcpu=gfx1010 -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=GCN %s
; RUN: llc -global-isel -amdgpu-scalarize-global-loads=false -march=amdgcn -mcpu=gfx1010 -mattr=-flat-for-global -verify-machineinstrs < %s | FileCheck -enable-var-scope -check-prefix=GISEL %s

declare i32 @llvm.amdgcn.workitem.id.x() #1

define amdgpu_kernel void @v_pack_b32_v2f16(half addrspace(1)* %in0, half addrspace(1)* %in1) #0 {
; GCN-LABEL: v_pack_b32_v2f16:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    global_load_ushort v1, v0, s[0:1] glc dlc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    global_load_ushort v2, v0, s[2:3] glc dlc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_f16_e32 v0, 2.0, v1
; GCN-NEXT:    v_add_f16_e32 v1, 2.0, v2
; GCN-NEXT:    v_pack_b32_f16 v0, v0, v1
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; use v0
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_endpgm
;
; GISEL-LABEL: v_pack_b32_v2f16:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GISEL-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-NEXT:    global_load_ushort v1, v0, s[0:1] glc dlc
; GISEL-NEXT:    s_waitcnt vmcnt(0)
; GISEL-NEXT:    global_load_ushort v2, v0, s[2:3] glc dlc
; GISEL-NEXT:    s_waitcnt vmcnt(0)
; GISEL-NEXT:    s_waitcnt_depctr 0xffe3
; GISEL-NEXT:    s_movk_i32 s0, 0x4000
; GISEL-NEXT:    v_add_f16_e32 v0, 2.0, v1
; GISEL-NEXT:    v_add_f16_sdwa v1, v2, s0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; GISEL-NEXT:    v_and_or_b32 v0, 0xffff, v0, v1
; GISEL-NEXT:    ;;#ASMSTART
; GISEL-NEXT:    ; use v0
; GISEL-NEXT:    ;;#ASMEND
; GISEL-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in0.gep = getelementptr inbounds half, half addrspace(1)* %in0, i64 %tid.ext
  %in1.gep = getelementptr inbounds half, half addrspace(1)* %in1, i64 %tid.ext
  %v0 = load volatile half, half addrspace(1)* %in0.gep
  %v1 = load volatile half, half addrspace(1)* %in1.gep
  %v0.add = fadd half %v0, 2.0
  %v1.add = fadd half %v1, 2.0
  %vec.0 = insertelement <2 x half> undef, half %v0.add, i32 0
  %vec.1 = insertelement <2 x half> %vec.0, half %v1.add, i32 1
  %vec.i32 = bitcast <2 x half> %vec.1 to i32
  call void asm sideeffect "; use $0", "v"(i32 %vec.i32) #0
  ret void
}

define amdgpu_kernel void @v_pack_b32_v2f16_sub(half addrspace(1)* %in0, half addrspace(1)* %in1) #0 {
; GCN-LABEL: v_pack_b32_v2f16_sub:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    global_load_ushort v1, v0, s[0:1] glc dlc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    global_load_ushort v2, v0, s[2:3] glc dlc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_subrev_f16_e32 v0, 2.0, v1
; GCN-NEXT:    v_add_f16_e32 v1, 2.0, v2
; GCN-NEXT:    v_pack_b32_f16 v0, v0, v1
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; use v0
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_endpgm
;
; GISEL-LABEL: v_pack_b32_v2f16_sub:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GISEL-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-NEXT:    global_load_ushort v1, v0, s[0:1] glc dlc
; GISEL-NEXT:    s_waitcnt vmcnt(0)
; GISEL-NEXT:    global_load_ushort v2, v0, s[2:3] glc dlc
; GISEL-NEXT:    s_waitcnt vmcnt(0)
; GISEL-NEXT:    v_mov_b32_e32 v0, 0x4000
; GISEL-NEXT:    v_add_f16_e32 v1, -2.0, v1
; GISEL-NEXT:    v_add_f16_sdwa v0, v2, v0 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; GISEL-NEXT:    v_and_or_b32 v0, 0xffff, v1, v0
; GISEL-NEXT:    ;;#ASMSTART
; GISEL-NEXT:    ; use v0
; GISEL-NEXT:    ;;#ASMEND
; GISEL-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in0.gep = getelementptr inbounds half, half addrspace(1)* %in0, i64 %tid.ext
  %in1.gep = getelementptr inbounds half, half addrspace(1)* %in1, i64 %tid.ext
  %v0 = load volatile half, half addrspace(1)* %in0.gep
  %v1 = load volatile half, half addrspace(1)* %in1.gep
  %v0.add = fsub half %v0, 2.0
  %v1.add = fadd half %v1, 2.0
  %vec.0 = insertelement <2 x half> undef, half %v0.add, i32 0
  %vec.1 = insertelement <2 x half> %vec.0, half %v1.add, i32 1
  %vec.i32 = bitcast <2 x half> %vec.1 to i32
  call void asm sideeffect "; use $0", "v"(i32 %vec.i32) #0
  ret void
}

define amdgpu_kernel void @fptrunc(
; GCN-LABEL: fptrunc:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    s_mov_b32 s6, -1
; GCN-NEXT:    s_mov_b32 s7, 0x31016000
; GCN-NEXT:    s_mov_b32 s10, s6
; GCN-NEXT:    s_mov_b32 s11, s7
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_mov_b32 s8, s2
; GCN-NEXT:    s_mov_b32 s9, s3
; GCN-NEXT:    s_mov_b32 s4, s0
; GCN-NEXT:    buffer_load_dwordx2 v[0:1], off, s[8:11], 0
; GCN-NEXT:    s_mov_b32 s5, s1
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cvt_f16_f32_e32 v1, v1
; GCN-NEXT:    v_cvt_f16_f32_e32 v0, v0
; GCN-NEXT:    v_pack_b32_f16 v0, v0, v1
; GCN-NEXT:    buffer_store_dword v0, off, s[4:7], 0
; GCN-NEXT:    s_endpgm
;
; GISEL-LABEL: fptrunc:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-NEXT:    s_load_dwordx2 s[2:3], s[2:3], 0x0
; GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-NEXT:    v_cvt_f16_f32_e32 v0, s2
; GISEL-NEXT:    v_cvt_f16_f32_sdwa v1, s3 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD
; GISEL-NEXT:    v_and_or_b32 v0, 0xffff, v0, v1
; GISEL-NEXT:    v_mov_b32_e32 v1, 0
; GISEL-NEXT:    global_store_dword v1, v0, s[0:1]
; GISEL-NEXT:    s_endpgm
    <2 x half> addrspace(1)* %r,
    <2 x float> addrspace(1)* %a) {
  %a.val = load <2 x float>, <2 x float> addrspace(1)* %a
  %r.val = fptrunc <2 x float> %a.val to <2 x half>
  store <2 x half> %r.val, <2 x half> addrspace(1)* %r
  ret void
}

define amdgpu_kernel void @v_pack_b32.fabs(half addrspace(1)* %in0, half addrspace(1)* %in1) #0 {
; GCN-LABEL: v_pack_b32.fabs:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    global_load_ushort v1, v0, s[0:1] glc dlc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    global_load_ushort v2, v0, s[2:3] glc dlc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_f16_e32 v0, 2.0, v1
; GCN-NEXT:    v_add_f16_e32 v1, 2.0, v2
; GCN-NEXT:    v_pack_b32_f16 v0, |v0|, |v1|
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; use v0
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_endpgm
;
; GISEL-LABEL: v_pack_b32.fabs:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GISEL-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-NEXT:    global_load_ushort v1, v0, s[0:1] glc dlc
; GISEL-NEXT:    s_waitcnt vmcnt(0)
; GISEL-NEXT:    global_load_ushort v2, v0, s[2:3] glc dlc
; GISEL-NEXT:    s_waitcnt vmcnt(0)
; GISEL-NEXT:    s_waitcnt_depctr 0xffe3
; GISEL-NEXT:    s_movk_i32 s0, 0x7fff
; GISEL-NEXT:    v_add_f16_e32 v0, 2.0, v1
; GISEL-NEXT:    v_add_f16_e32 v1, 2.0, v2
; GISEL-NEXT:    v_and_b32_e32 v0, s0, v0
; GISEL-NEXT:    v_and_b32_sdwa v1, s0, v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; GISEL-NEXT:    v_and_or_b32 v0, 0xffff, v0, v1
; GISEL-NEXT:    ;;#ASMSTART
; GISEL-NEXT:    ; use v0
; GISEL-NEXT:    ;;#ASMEND
; GISEL-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in0.gep = getelementptr inbounds half, half addrspace(1)* %in0, i64 %tid.ext
  %in1.gep = getelementptr inbounds half, half addrspace(1)* %in1, i64 %tid.ext
  %v0 = load volatile half, half addrspace(1)* %in0.gep
  %v1 = load volatile half, half addrspace(1)* %in1.gep
  %v0.add = fadd half %v0, 2.0
  %v1.add = fadd half %v1, 2.0
  %v0.fabs = call half @llvm.fabs.f16(half %v0.add)
  %v1.fabs = call half @llvm.fabs.f16(half %v1.add)
  %vec.0 = insertelement <2 x half> undef, half %v0.fabs, i32 0
  %vec.1 = insertelement <2 x half> %vec.0, half %v1.fabs, i32 1
  %vec.i32 = bitcast <2 x half> %vec.1 to i32
  call void asm sideeffect "; use $0", "v"(i32 %vec.i32) #0
  ret void
}

define amdgpu_kernel void @v_pack_b32.fneg(half addrspace(1)* %in0, half addrspace(1)* %in1) #0 {
; GCN-LABEL: v_pack_b32.fneg:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    global_load_ushort v1, v0, s[0:1] glc dlc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    global_load_ushort v2, v0, s[2:3] glc dlc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_add_f16_e32 v0, 2.0, v1
; GCN-NEXT:    v_add_f16_e32 v1, 2.0, v2
; GCN-NEXT:    v_pack_b32_f16 v0, -v0, -v1
; GCN-NEXT:    ;;#ASMSTART
; GCN-NEXT:    ; use v0
; GCN-NEXT:    ;;#ASMEND
; GCN-NEXT:    s_endpgm
;
; GISEL-LABEL: v_pack_b32.fneg:
; GISEL:       ; %bb.0:
; GISEL-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GISEL-NEXT:    v_lshlrev_b32_e32 v0, 1, v0
; GISEL-NEXT:    s_waitcnt lgkmcnt(0)
; GISEL-NEXT:    global_load_ushort v1, v0, s[0:1] glc dlc
; GISEL-NEXT:    s_waitcnt vmcnt(0)
; GISEL-NEXT:    global_load_ushort v2, v0, s[2:3] glc dlc
; GISEL-NEXT:    s_waitcnt vmcnt(0)
; GISEL-NEXT:    s_waitcnt_depctr 0xffe3
; GISEL-NEXT:    s_mov_b32 s0, 0x8000
; GISEL-NEXT:    v_add_f16_e32 v0, 2.0, v1
; GISEL-NEXT:    v_add_f16_e32 v1, 2.0, v2
; GISEL-NEXT:    v_add_f16_e64 v0, s0, -v0
; GISEL-NEXT:    v_add_f16_sdwa v1, s0, -v1 dst_sel:WORD_1 dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:DWORD
; GISEL-NEXT:    v_and_or_b32 v0, 0xffff, v0, v1
; GISEL-NEXT:    ;;#ASMSTART
; GISEL-NEXT:    ; use v0
; GISEL-NEXT:    ;;#ASMEND
; GISEL-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %in0.gep = getelementptr inbounds half, half addrspace(1)* %in0, i64 %tid.ext
  %in1.gep = getelementptr inbounds half, half addrspace(1)* %in1, i64 %tid.ext
  %v0 = load volatile half, half addrspace(1)* %in0.gep
  %v1 = load volatile half, half addrspace(1)* %in1.gep
  %v0.add = fadd half %v0, 2.0
  %v1.add = fadd half %v1, 2.0
  %v0.fneg = fsub half -0.0, %v0.add
  %v1.fneg = fsub half -0.0, %v1.add
  %vec.0 = insertelement <2 x half> undef, half %v0.fneg, i32 0
  %vec.1 = insertelement <2 x half> %vec.0, half %v1.fneg, i32 1
  %vec.i32 = bitcast <2 x half> %vec.1 to i32
  call void asm sideeffect "; use $0", "v"(i32 %vec.i32) #0
  ret void
}

declare half @llvm.fabs.f16(half) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

