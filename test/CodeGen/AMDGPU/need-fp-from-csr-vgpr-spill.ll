; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck %s

; FP is in CSR range, modified.
define hidden fastcc void @callee_has_fp() #1 {
; CHECK-LABEL: callee_has_fp:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_mov_b32 s4, s33
; CHECK-NEXT:    s_mov_b32 s33, s32
; CHECK-NEXT:    s_add_u32 s32, s32, 0x200
; CHECK-NEXT:    v_mov_b32_e32 v0, 1
; CHECK-NEXT:    buffer_store_dword v0, off, s[0:3], s33 offset:4
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    s_sub_u32 s32, s32, 0x200
; CHECK-NEXT:    s_mov_b32 s33, s4
; CHECK-NEXT:    s_setpc_b64 s[30:31]
  %alloca = alloca i32, addrspace(5)
  store volatile i32 1, i32 addrspace(5)* %alloca
  ret void
}

; Has no stack objects, but introduces them due to the CSR spill. We
; see the FP modified in the callee with IPRA. We should not have
; redundant spills of s33 or assert.
define internal fastcc void @csr_vgpr_spill_fp_callee() #0 {
; CHECK-LABEL: csr_vgpr_spill_fp_callee:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    s_mov_b32 s8, s33
; CHECK-NEXT:    s_mov_b32 s33, s32
; CHECK-NEXT:    s_add_u32 s32, s32, 0x400
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, callee_has_fp@rel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, callee_has_fp@rel32@hi+12
; CHECK-NEXT:    buffer_store_dword v40, off, s[0:3], s33 ; 4-byte Folded Spill
; CHECK-NEXT:    s_mov_b64 s[6:7], s[30:31]
; CHECK-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; clobber csr v40
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    buffer_load_dword v40, off, s[0:3], s33 ; 4-byte Folded Reload
; CHECK-NEXT:    s_sub_u32 s32, s32, 0x400
; CHECK-NEXT:    s_mov_b32 s33, s8
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    s_setpc_b64 s[6:7]
bb:
  call fastcc void @callee_has_fp()
  call void asm sideeffect "; clobber csr v40", "~{v40}"()
  ret void
}

define amdgpu_kernel void @kernel_call() {
; CHECK-LABEL: kernel_call:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_add_u32 flat_scratch_lo, s4, s7
; CHECK-NEXT:    s_addc_u32 flat_scratch_hi, s5, 0
; CHECK-NEXT:    s_add_u32 s0, s0, s7
; CHECK-NEXT:    s_addc_u32 s1, s1, 0
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, csr_vgpr_spill_fp_callee@rel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, csr_vgpr_spill_fp_callee@rel32@hi+12
; CHECK-NEXT:    s_mov_b32 s32, 0
; CHECK-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; CHECK-NEXT:    s_endpgm
bb:
  tail call fastcc void @csr_vgpr_spill_fp_callee()
  ret void
}

; Same, except with a tail call.
define internal fastcc void @csr_vgpr_spill_fp_tailcall_callee() #0 {
; CHECK-LABEL: csr_vgpr_spill_fp_tailcall_callee:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; CHECK-NEXT:    buffer_store_dword v40, off, s[0:3], s32 ; 4-byte Folded Spill
; CHECK-NEXT:    ;;#ASMSTART
; CHECK-NEXT:    ; clobber csr v40
; CHECK-NEXT:    ;;#ASMEND
; CHECK-NEXT:    buffer_load_dword v40, off, s[0:3], s32 ; 4-byte Folded Reload
; CHECK-NEXT:    v_writelane_b32 v1, s33, 0
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, callee_has_fp@rel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, callee_has_fp@rel32@hi+12
; CHECK-NEXT:    v_readlane_b32 s33, v1, 0
; CHECK-NEXT:    s_setpc_b64 s[4:5]
bb:
  call void asm sideeffect "; clobber csr v40", "~{v40}"()
  tail call fastcc void @callee_has_fp()
  ret void
}

define amdgpu_kernel void @kernel_tailcall() {
; CHECK-LABEL: kernel_tailcall:
; CHECK:       ; %bb.0: ; %bb
; CHECK-NEXT:    s_add_u32 flat_scratch_lo, s4, s7
; CHECK-NEXT:    s_addc_u32 flat_scratch_hi, s5, 0
; CHECK-NEXT:    s_add_u32 s0, s0, s7
; CHECK-NEXT:    s_addc_u32 s1, s1, 0
; CHECK-NEXT:    s_getpc_b64 s[4:5]
; CHECK-NEXT:    s_add_u32 s4, s4, csr_vgpr_spill_fp_tailcall_callee@rel32@lo+4
; CHECK-NEXT:    s_addc_u32 s5, s5, csr_vgpr_spill_fp_tailcall_callee@rel32@hi+12
; CHECK-NEXT:    s_mov_b32 s32, 0
; CHECK-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; CHECK-NEXT:    s_endpgm
bb:
  tail call fastcc void @csr_vgpr_spill_fp_tailcall_callee()
  ret void
}

attributes #0 = { "frame-pointer"="none" noinline }
attributes #1 = { "frame-pointer"="all" noinline }
