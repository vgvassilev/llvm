; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=tahiti -verify-machineinstrs < %s | FileCheck -check-prefix=GFX68 %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=fiji -verify-machineinstrs < %s | FileCheck -check-prefix=GFX68 %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX10 %s

define amdgpu_ps float @load_1d_f32_x(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_f32_x:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    image_load v0, v0, s[0:7] dmask:0x1 unorm
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_f32_x:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x1 dim:SQ_RSRC_IMG_1D unorm
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call float @llvm.amdgcn.image.load.1d.f32.i32(i32 1, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret float %v
}

define amdgpu_ps float @load_1d_f32_y(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_f32_y:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    image_load v0, v0, s[0:7] dmask:0x2 unorm
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_f32_y:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x2 dim:SQ_RSRC_IMG_1D unorm
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call float @llvm.amdgcn.image.load.1d.f32.i32(i32 2, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret float %v
}

define amdgpu_ps float @load_1d_f32_z(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_f32_z:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    image_load v0, v0, s[0:7] dmask:0x4 unorm
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_f32_z:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x4 dim:SQ_RSRC_IMG_1D unorm
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call float @llvm.amdgcn.image.load.1d.f32.i32(i32 4, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret float %v
}

define amdgpu_ps float @load_1d_f32_w(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_f32_w:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    image_load v0, v0, s[0:7] dmask:0x8 unorm
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_f32_w:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v0, v0, s[0:7] dmask:0x8 dim:SQ_RSRC_IMG_1D unorm
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call float @llvm.amdgcn.image.load.1d.f32.i32(i32 8, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret float %v
}

define amdgpu_ps <2 x float> @load_1d_v2f32_xy(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_v2f32_xy:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x3 unorm
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v2f32_xy:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x3 dim:SQ_RSRC_IMG_1D unorm
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <2 x float> @llvm.amdgcn.image.load.1d.v2f32.i32(i32 3, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <2 x float> %v
}

define amdgpu_ps <2 x float> @load_1d_v2f32_xz(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_v2f32_xz:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x5 unorm
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v2f32_xz:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x5 dim:SQ_RSRC_IMG_1D unorm
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <2 x float> @llvm.amdgcn.image.load.1d.v2f32.i32(i32 5, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <2 x float> %v
}

define amdgpu_ps <2 x float> @load_1d_v2f32_xw(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_v2f32_xw:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x9 unorm
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v2f32_xw:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x9 dim:SQ_RSRC_IMG_1D unorm
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <2 x float> @llvm.amdgcn.image.load.1d.v2f32.i32(i32 9, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <2 x float> %v
}

define amdgpu_ps <2 x float> @load_1d_v2f32_yz(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_v2f32_yz:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x6 unorm
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v2f32_yz:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v[0:1], v0, s[0:7] dmask:0x6 dim:SQ_RSRC_IMG_1D unorm
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <2 x float> @llvm.amdgcn.image.load.1d.v2f32.i32(i32 6, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <2 x float> %v
}

define amdgpu_ps <3 x float> @load_1d_v3f32_xyz(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_v3f32_xyz:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    image_load v[0:2], v0, s[0:7] dmask:0x7 unorm
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v3f32_xyz:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v[0:2], v0, s[0:7] dmask:0x7 dim:SQ_RSRC_IMG_1D unorm
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <3 x float> @llvm.amdgcn.image.load.1d.v3f32.i32(i32 7, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <3 x float> %v
}

define amdgpu_ps <4 x float> @load_1d_v4f32_xyzw(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_v4f32_xyzw:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    image_load v[0:3], v0, s[0:7] dmask:0xf unorm
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v4f32_xyzw:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    image_load v[0:3], v0, s[0:7] dmask:0xf dim:SQ_RSRC_IMG_1D unorm
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    ; return to shader part epilog
  %v = call <4 x float> @llvm.amdgcn.image.load.1d.v4f32.i32(i32 15, i32 %s, <8 x i32> %rsrc, i32 0, i32 0)
  ret <4 x float> %v
}

define amdgpu_ps float @load_1d_f32_tfe_dmask_x(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_f32_tfe_dmask_x:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    v_mov_b32_e32 v1, 0
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    v_mov_b32_e32 v2, v1
; GFX68-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x1 unorm tfe
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    v_mov_b32_e32 v0, v2
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_f32_tfe_dmask_x:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    v_mov_b32_e32 v2, v1
; GFX10-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x1 dim:SQ_RSRC_IMG_1D unorm tfe
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-NEXT:    ; return to shader part epilog
  %v = call { float, i32 } @llvm.amdgcn.image.load.1d.sl_f32i32s.i32(i32 1, i32 %s, <8 x i32> %rsrc, i32 1, i32 0)
  %v.err = extractvalue { float, i32 } %v, 1
  %vv = bitcast i32 %v.err to float
  ret float %vv
}

define amdgpu_ps float @load_1d_v2f32_tfe_dmask_xy(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_v2f32_tfe_dmask_xy:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    v_mov_b32_e32 v1, 0
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    v_mov_b32_e32 v2, v1
; GFX68-NEXT:    v_mov_b32_e32 v3, v1
; GFX68-NEXT:    image_load v[1:3], v0, s[0:7] dmask:0x3 unorm tfe
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    v_mov_b32_e32 v0, v3
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v2f32_tfe_dmask_xy:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    v_mov_b32_e32 v2, v1
; GFX10-NEXT:    v_mov_b32_e32 v3, v1
; GFX10-NEXT:    image_load v[1:3], v0, s[0:7] dmask:0x3 dim:SQ_RSRC_IMG_1D unorm tfe
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, v3
; GFX10-NEXT:    ; return to shader part epilog
  %v = call { <2 x float>, i32 } @llvm.amdgcn.image.load.1d.sl_v2f32i32s.i32(i32 3, i32 %s, <8 x i32> %rsrc, i32 1, i32 0)
  %v.err = extractvalue { <2 x float>, i32 } %v, 1
  %vv = bitcast i32 %v.err to float
  ret float %vv
}

define amdgpu_ps float @load_1d_v3f32_tfe_dmask_xyz(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_v3f32_tfe_dmask_xyz:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    v_mov_b32_e32 v1, 0
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    v_mov_b32_e32 v2, v1
; GFX68-NEXT:    v_mov_b32_e32 v3, v1
; GFX68-NEXT:    v_mov_b32_e32 v4, v1
; GFX68-NEXT:    image_load v[1:4], v0, s[0:7] dmask:0x7 unorm tfe
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    v_mov_b32_e32 v0, v4
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v3f32_tfe_dmask_xyz:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    v_mov_b32_e32 v2, v1
; GFX10-NEXT:    v_mov_b32_e32 v3, v1
; GFX10-NEXT:    v_mov_b32_e32 v4, v1
; GFX10-NEXT:    image_load v[1:4], v0, s[0:7] dmask:0x7 dim:SQ_RSRC_IMG_1D unorm tfe
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, v4
; GFX10-NEXT:    ; return to shader part epilog
  %v = call { <3 x float>, i32 } @llvm.amdgcn.image.load.1d.sl_v3f32i32s.i32(i32 7, i32 %s, <8 x i32> %rsrc, i32 1, i32 0)
  %v.err = extractvalue { <3 x float>, i32 } %v, 1
  %vv = bitcast i32 %v.err to float
  ret float %vv
}

define amdgpu_ps float @load_1d_v4f32_tfe_dmask_xyzw(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_v4f32_tfe_dmask_xyzw:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    v_mov_b32_e32 v1, 0
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    v_mov_b32_e32 v2, v1
; GFX68-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x10 unorm tfe
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    v_mov_b32_e32 v0, v2
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_v4f32_tfe_dmask_xyzw:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    v_mov_b32_e32 v2, v1
; GFX10-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x10 dim:SQ_RSRC_IMG_1D unorm tfe
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-NEXT:    ; return to shader part epilog
  %v = call { <4 x float>, i32 } @llvm.amdgcn.image.load.1d.sl_v4f32i32s.i32(i32 16, i32 %s, <8 x i32> %rsrc, i32 1, i32 0)
  %v.err = extractvalue { <4 x float>, i32 } %v, 1
  %vv = bitcast i32 %v.err to float
  ret float %vv
}

define amdgpu_ps float @load_1d_f32_tfe_dmask_0(<8 x i32> inreg %rsrc, i32 %s) {
; GFX68-LABEL: load_1d_f32_tfe_dmask_0:
; GFX68:       ; %bb.0:
; GFX68-NEXT:    v_mov_b32_e32 v1, 0
; GFX68-NEXT:    s_mov_b32 s0, s2
; GFX68-NEXT:    s_mov_b32 s1, s3
; GFX68-NEXT:    s_mov_b32 s2, s4
; GFX68-NEXT:    s_mov_b32 s3, s5
; GFX68-NEXT:    s_mov_b32 s4, s6
; GFX68-NEXT:    s_mov_b32 s5, s7
; GFX68-NEXT:    s_mov_b32 s6, s8
; GFX68-NEXT:    s_mov_b32 s7, s9
; GFX68-NEXT:    v_mov_b32_e32 v2, v1
; GFX68-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x1 unorm tfe
; GFX68-NEXT:    s_waitcnt vmcnt(0)
; GFX68-NEXT:    v_mov_b32_e32 v0, v2
; GFX68-NEXT:    ; return to shader part epilog
;
; GFX10-LABEL: load_1d_f32_tfe_dmask_0:
; GFX10:       ; %bb.0:
; GFX10-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-NEXT:    s_mov_b32 s0, s2
; GFX10-NEXT:    s_mov_b32 s1, s3
; GFX10-NEXT:    s_mov_b32 s2, s4
; GFX10-NEXT:    s_mov_b32 s3, s5
; GFX10-NEXT:    s_mov_b32 s4, s6
; GFX10-NEXT:    s_mov_b32 s5, s7
; GFX10-NEXT:    s_mov_b32 s6, s8
; GFX10-NEXT:    s_mov_b32 s7, s9
; GFX10-NEXT:    v_mov_b32_e32 v2, v1
; GFX10-NEXT:    image_load v[1:2], v0, s[0:7] dmask:0x1 dim:SQ_RSRC_IMG_1D unorm tfe
; GFX10-NEXT:    s_waitcnt vmcnt(0)
; GFX10-NEXT:    v_mov_b32_e32 v0, v2
; GFX10-NEXT:    ; return to shader part epilog
  %v = call { float, i32 } @llvm.amdgcn.image.load.1d.sl_f32i32s.i32(i32 0, i32 %s, <8 x i32> %rsrc, i32 1, i32 0)
  %v.err = extractvalue { float, i32 } %v, 1
  %vv = bitcast i32 %v.err to float
  ret float %vv
}

declare float @llvm.amdgcn.image.load.1d.f32.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare <2 x float> @llvm.amdgcn.image.load.1d.v2f32.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare <3 x float> @llvm.amdgcn.image.load.1d.v3f32.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare <4 x float> @llvm.amdgcn.image.load.1d.v4f32.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0

declare { float, i32 } @llvm.amdgcn.image.load.1d.sl_f32i32s.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare { <2 x float>, i32 } @llvm.amdgcn.image.load.1d.sl_v2f32i32s.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare { <3 x float>, i32 } @llvm.amdgcn.image.load.1d.sl_v3f32i32s.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0
declare { <4 x float>, i32 } @llvm.amdgcn.image.load.1d.sl_v4f32i32s.i32(i32 immarg, i32, <8 x i32>, i32 immarg, i32 immarg) #0

attributes #0 = { nounwind readonly }
