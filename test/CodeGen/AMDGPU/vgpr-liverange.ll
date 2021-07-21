; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -mcpu=gfx1010 -amdgpu-opt-vgpr-liverange=true -verify-machineinstrs < %s | FileCheck -check-prefix=SI %s

; a normal if-else
define amdgpu_ps float @else1(i32 %z, float %v) #0 {
; SI-LABEL: else1:
; SI:       ; %bb.0: ; %main_body
; SI-NEXT:    v_cmp_gt_i32_e32 vcc_lo, 6, v0
; SI-NEXT:    ; implicit-def: $vgpr0
; SI-NEXT:    s_and_saveexec_b32 s0, vcc_lo
; SI-NEXT:    s_xor_b32 s0, exec_lo, s0
; SI-NEXT:  ; %bb.1: ; %else
; SI-NEXT:    v_mul_f32_e32 v0, 0x40400000, v1
; SI-NEXT:    ; implicit-def: $vgpr1
; SI-NEXT:  ; %bb.2: ; %Flow
; SI-NEXT:    s_or_saveexec_b32 s0, s0
; SI-NEXT:    s_xor_b32 exec_lo, exec_lo, s0
; SI-NEXT:  ; %bb.3: ; %if
; SI-NEXT:    v_add_f32_e32 v0, v1, v1
; SI-NEXT:  ; %bb.4: ; %end
; SI-NEXT:    s_or_b32 exec_lo, exec_lo, s0
; SI-NEXT:    ; return to shader part epilog
main_body:
  %cc = icmp sgt i32 %z, 5
  br i1 %cc, label %if, label %else

if:
  %v.if = fmul float %v, 2.0
  br label %end

else:
  %v.else = fmul float %v, 3.0
  br label %end

end:
  %r = phi float [ %v.if, %if ], [ %v.else, %else ]
  ret float %r
}


; %v was used after if-else
define amdgpu_ps float @else2(i32 %z, float %v) #0 {
; SI-LABEL: else2:
; SI:       ; %bb.0: ; %main_body
; SI-NEXT:    v_cmp_gt_i32_e32 vcc_lo, 6, v0
; SI-NEXT:    ; implicit-def: $vgpr0
; SI-NEXT:    s_and_saveexec_b32 s0, vcc_lo
; SI-NEXT:    s_xor_b32 s0, exec_lo, s0
; SI-NEXT:  ; %bb.1: ; %else
; SI-NEXT:    v_mul_f32_e32 v0, 0x40400000, v1
; SI-NEXT:  ; %bb.2: ; %Flow
; SI-NEXT:    s_or_saveexec_b32 s0, s0
; SI-NEXT:    s_xor_b32 exec_lo, exec_lo, s0
; SI-NEXT:  ; %bb.3: ; %if
; SI-NEXT:    v_add_f32_e32 v1, v1, v1
; SI-NEXT:    v_mov_b32_e32 v0, v1
; SI-NEXT:  ; %bb.4: ; %end
; SI-NEXT:    s_or_b32 exec_lo, exec_lo, s0
; SI-NEXT:    v_add_f32_e32 v0, v1, v0
; SI-NEXT:    ; return to shader part epilog
main_body:
  %cc = icmp sgt i32 %z, 5
  br i1 %cc, label %if, label %else

if:
  %v.if = fmul float %v, 2.0
  br label %end

else:
  %v.else = fmul float %v, 3.0
  br label %end

end:
  %r0 = phi float [ %v.if, %if ], [ %v, %else ]
  %r1 = phi float [ %v.if, %if ], [ %v.else, %else ]
  %r2 = fadd float %r0, %r1
  ret float %r2
}

; if-else inside loop, %x can be optimized, but %v cannot be.
define amdgpu_ps float @else3(i32 %z, float %v, i32 inreg %bound, i32 %x0) #0 {
; SI-LABEL: else3:
; SI:       ; %bb.0: ; %entry
; SI-NEXT:    v_cmp_gt_i32_e32 vcc_lo, 6, v0
; SI-NEXT:    s_mov_b32 s1, 0
; SI-NEXT:    s_branch BB2_2
; SI-NEXT:  BB2_1: ; %if.end
; SI-NEXT:    ; in Loop: Header=BB2_2 Depth=1
; SI-NEXT:    s_or_b32 exec_lo, exec_lo, s2
; SI-NEXT:    v_add_nc_u32_e32 v2, 1, v0
; SI-NEXT:    s_add_i32 s1, s1, 1
; SI-NEXT:    s_cmp_lt_i32 s1, s0
; SI-NEXT:    s_cbranch_scc0 BB2_6
; SI-NEXT:  BB2_2: ; %for.body
; SI-NEXT:    ; =>This Inner Loop Header: Depth=1
; SI-NEXT:    ; implicit-def: $vgpr0
; SI-NEXT:    ; implicit-def: $vgpr3
; SI-NEXT:    s_and_saveexec_b32 s2, vcc_lo
; SI-NEXT:    s_xor_b32 s2, exec_lo, s2
; SI-NEXT:  ; %bb.3: ; %else
; SI-NEXT:    ; in Loop: Header=BB2_2 Depth=1
; SI-NEXT:    v_mul_lo_u32 v0, v2, 3
; SI-NEXT:    v_mul_f32_e32 v3, v1, v2
; SI-NEXT:    ; implicit-def: $vgpr2
; SI-NEXT:  ; %bb.4: ; %Flow
; SI-NEXT:    ; in Loop: Header=BB2_2 Depth=1
; SI-NEXT:    s_or_saveexec_b32 s2, s2
; SI-NEXT:    s_xor_b32 exec_lo, exec_lo, s2
; SI-NEXT:    s_cbranch_execz BB2_1
; SI-NEXT:  ; %bb.5: ; %if
; SI-NEXT:    ; in Loop: Header=BB2_2 Depth=1
; SI-NEXT:    v_mul_f32_e32 v3, s1, v1
; SI-NEXT:    v_add_nc_u32_e32 v0, 1, v2
; SI-NEXT:    s_branch BB2_1
; SI-NEXT:  BB2_6: ; %for.end
; SI-NEXT:    v_add_f32_e32 v0, v0, v3
; SI-NEXT:    ; return to shader part epilog
entry:
;  %break = icmp sgt i32 %bound, 0
;  br i1 %break, label %for.body, label %for.end
  br label %for.body

for.body:
  %i = phi i32 [ 0, %entry ], [ %inc, %if.end ]
  %x = phi i32 [ %x0, %entry ], [ %xinc, %if.end ]
  %cc = icmp sgt i32 %z, 5
  br i1 %cc, label %if, label %else

if:
  %i.tmp = bitcast i32 %i to float
  %v.if = fmul float %v, %i.tmp
  %x.if = add i32 %x, 1
  br label %if.end

else:
  %x.tmp = bitcast i32 %x to float
  %v.else = fmul float %v, %x.tmp
  %x.else = mul i32 %x, 3
  br label %if.end

if.end:
  %v.endif = phi float [ %v.if, %if ], [ %v.else, %else ]
  %x.endif = phi i32 [ %x.if, %if ], [ %x.else, %else ]

  %xinc = add i32 %x.endif, 1
  %inc = add i32 %i, 1
  %cond = icmp slt i32 %inc, %bound
  br i1 %cond, label %for.body, label %for.end

for.end:
  %x_float = bitcast i32 %x.endif to float
  %r = fadd float %x_float, %v.endif
  ret float %r
}

; a loop inside an if-else
define amdgpu_ps float @loop(i32 %z, float %v, i32 inreg %bound, float(float)* %extern_func, float(float)* %extern_func2) #0 {
; SI-LABEL: loop:
; SI:       ; %bb.0: ; %main_body
; SI-NEXT:    s_mov_b32 s36, SCRATCH_RSRC_DWORD0
; SI-NEXT:    s_mov_b32 s37, SCRATCH_RSRC_DWORD1
; SI-NEXT:    s_mov_b32 s38, -1
; SI-NEXT:    v_cmp_gt_i32_e32 vcc_lo, 6, v0
; SI-NEXT:    v_mov_b32_e32 v40, v1
; SI-NEXT:    s_mov_b32 s39, 0x31c16000
; SI-NEXT:    s_add_u32 s36, s36, s1
; SI-NEXT:    s_addc_u32 s37, s37, 0
; SI-NEXT:    ; implicit-def: $vgpr0
; SI-NEXT:    s_mov_b32 s32, 0
; SI-NEXT:    s_and_saveexec_b32 s0, vcc_lo
; SI-NEXT:    s_xor_b32 s33, exec_lo, s0
; SI-NEXT:    s_cbranch_execz BB3_4
; SI-NEXT:  ; %bb.1: ; %else
; SI-NEXT:    s_mov_b32 s34, exec_lo
; SI-NEXT:  BB3_2: ; =>This Inner Loop Header: Depth=1
; SI-NEXT:    v_readfirstlane_b32 s4, v4
; SI-NEXT:    v_readfirstlane_b32 s5, v5
; SI-NEXT:    v_cmp_eq_u64_e32 vcc_lo, s[4:5], v[4:5]
; SI-NEXT:    s_and_saveexec_b32 s35, vcc_lo
; SI-NEXT:    v_mov_b32_e32 v0, v40
; SI-NEXT:    s_mov_b64 s[0:1], s[36:37]
; SI-NEXT:    s_mov_b64 s[2:3], s[38:39]
; SI-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; SI-NEXT:    ; implicit-def: $vgpr4_vgpr5
; SI-NEXT:    s_xor_b32 exec_lo, exec_lo, s35
; SI-NEXT:    s_cbranch_execnz BB3_2
; SI-NEXT:  ; %bb.3:
; SI-NEXT:    s_mov_b32 exec_lo, s34
; SI-NEXT:    ; implicit-def: $vgpr2
; SI-NEXT:  BB3_4: ; %Flow
; SI-NEXT:    s_or_saveexec_b32 s33, s33
; SI-NEXT:    s_xor_b32 exec_lo, exec_lo, s33
; SI-NEXT:    s_cbranch_execz BB3_8
; SI-NEXT:  ; %bb.5: ; %if
; SI-NEXT:    s_mov_b32 s34, exec_lo
; SI-NEXT:  BB3_6: ; =>This Inner Loop Header: Depth=1
; SI-NEXT:    v_readfirstlane_b32 s4, v2
; SI-NEXT:    v_readfirstlane_b32 s5, v3
; SI-NEXT:    v_cmp_eq_u64_e32 vcc_lo, s[4:5], v[2:3]
; SI-NEXT:    s_and_saveexec_b32 s35, vcc_lo
; SI-NEXT:    v_mov_b32_e32 v0, v40
; SI-NEXT:    s_mov_b64 s[0:1], s[36:37]
; SI-NEXT:    s_mov_b64 s[2:3], s[38:39]
; SI-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; SI-NEXT:    ; implicit-def: $vgpr2_vgpr3
; SI-NEXT:    ; implicit-def: $vgpr40
; SI-NEXT:    s_xor_b32 exec_lo, exec_lo, s35
; SI-NEXT:    s_cbranch_execnz BB3_6
; SI-NEXT:  ; %bb.7:
; SI-NEXT:    s_mov_b32 exec_lo, s34
; SI-NEXT:  BB3_8: ; %end
; SI-NEXT:    s_or_b32 exec_lo, exec_lo, s33
; SI-NEXT:    ; return to shader part epilog
main_body:
  %cc = icmp sgt i32 %z, 5
  br i1 %cc, label %if, label %else

if:
  %v.if = call amdgpu_gfx float %extern_func(float %v)
  br label %end

else:
  %v.else = call amdgpu_gfx float %extern_func2(float %v)
  br label %end

end:
  %r = phi float [ %v.if, %if ], [ %v.else, %else ]
  ret float %r
}

; a loop inside an if-else, but the variable is still in use after the if-else
define amdgpu_ps float @loop_with_use(i32 %z, float %v, i32 inreg %bound, float(float)* %extern_func, float(float)* %extern_func2) #0 {
; SI-LABEL: loop_with_use:
; SI:       ; %bb.0: ; %main_body
; SI-NEXT:    s_mov_b32 s36, SCRATCH_RSRC_DWORD0
; SI-NEXT:    s_mov_b32 s37, SCRATCH_RSRC_DWORD1
; SI-NEXT:    s_mov_b32 s38, -1
; SI-NEXT:    v_cmp_gt_i32_e32 vcc_lo, 6, v0
; SI-NEXT:    v_mov_b32_e32 v40, v1
; SI-NEXT:    s_mov_b32 s39, 0x31c16000
; SI-NEXT:    s_add_u32 s36, s36, s1
; SI-NEXT:    s_addc_u32 s37, s37, 0
; SI-NEXT:    ; implicit-def: $vgpr0
; SI-NEXT:    s_mov_b32 s32, 0
; SI-NEXT:    s_and_saveexec_b32 s0, vcc_lo
; SI-NEXT:    s_xor_b32 s33, exec_lo, s0
; SI-NEXT:    s_cbranch_execz BB4_4
; SI-NEXT:  ; %bb.1: ; %else
; SI-NEXT:    s_mov_b32 s34, exec_lo
; SI-NEXT:  BB4_2: ; =>This Inner Loop Header: Depth=1
; SI-NEXT:    v_readfirstlane_b32 s4, v4
; SI-NEXT:    v_readfirstlane_b32 s5, v5
; SI-NEXT:    v_cmp_eq_u64_e32 vcc_lo, s[4:5], v[4:5]
; SI-NEXT:    s_and_saveexec_b32 s35, vcc_lo
; SI-NEXT:    v_mov_b32_e32 v0, v40
; SI-NEXT:    s_mov_b64 s[0:1], s[36:37]
; SI-NEXT:    s_mov_b64 s[2:3], s[38:39]
; SI-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; SI-NEXT:    ; implicit-def: $vgpr4_vgpr5
; SI-NEXT:    s_xor_b32 exec_lo, exec_lo, s35
; SI-NEXT:    s_cbranch_execnz BB4_2
; SI-NEXT:  ; %bb.3:
; SI-NEXT:    s_mov_b32 exec_lo, s34
; SI-NEXT:    ; implicit-def: $vgpr2
; SI-NEXT:  BB4_4: ; %Flow
; SI-NEXT:    s_or_saveexec_b32 s33, s33
; SI-NEXT:    s_xor_b32 exec_lo, exec_lo, s33
; SI-NEXT:    s_cbranch_execz BB4_8
; SI-NEXT:  ; %bb.5: ; %if
; SI-NEXT:    s_mov_b32 s34, exec_lo
; SI-NEXT:  BB4_6: ; =>This Inner Loop Header: Depth=1
; SI-NEXT:    v_readfirstlane_b32 s4, v2
; SI-NEXT:    v_readfirstlane_b32 s5, v3
; SI-NEXT:    v_cmp_eq_u64_e32 vcc_lo, s[4:5], v[2:3]
; SI-NEXT:    s_and_saveexec_b32 s35, vcc_lo
; SI-NEXT:    v_mov_b32_e32 v0, v40
; SI-NEXT:    s_mov_b64 s[0:1], s[36:37]
; SI-NEXT:    s_mov_b64 s[2:3], s[38:39]
; SI-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; SI-NEXT:    ; implicit-def: $vgpr2_vgpr3
; SI-NEXT:    s_xor_b32 exec_lo, exec_lo, s35
; SI-NEXT:    s_cbranch_execnz BB4_6
; SI-NEXT:  ; %bb.7:
; SI-NEXT:    s_mov_b32 exec_lo, s34
; SI-NEXT:  BB4_8: ; %end
; SI-NEXT:    s_or_b32 exec_lo, exec_lo, s33
; SI-NEXT:    v_add_f32_e32 v0, v0, v40
; SI-NEXT:    ; return to shader part epilog
main_body:
  %cc = icmp sgt i32 %z, 5
  br i1 %cc, label %if, label %else

if:
  %v.if = call amdgpu_gfx float %extern_func(float %v)
  br label %end

else:
  %v.else = call amdgpu_gfx float %extern_func2(float %v)
  br label %end

end:
  %r = phi float [ %v.if, %if ], [ %v.else, %else ]
  %r2 = fadd float %r, %v
  ret float %r2
}

attributes #0 = { nounwind }
