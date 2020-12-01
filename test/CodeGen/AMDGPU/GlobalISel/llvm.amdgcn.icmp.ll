; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -global-isel-abort=1 -march=amdgcn -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

define amdgpu_ps void @test_intr_icmp_eq_i64(i64 addrspace(1)* %out, i32 %src) #0 {
; GCN-LABEL: test_intr_icmp_eq_i64:
; GCN:       ; %bb.0:
; GCN-NEXT:    v_cmp_eq_u32_e64 s[0:1], 0x64, v2
; GCN-NEXT:    v_mov_b32_e32 v3, s1
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_dwordx2 v[0:1], v[2:3], off
; GCN-NEXT:    s_endpgm
  %result = call i64 @llvm.amdgcn.icmp.i64.i32(i32 %src, i32 100, i32 32)
  store i64 %result, i64 addrspace(1)* %out
  ret void
}

define amdgpu_ps void @test_intr_icmp_ne_i32(i32 addrspace(1)* %out, i32 %src) #1 {
; GCN-LABEL: test_intr_icmp_ne_i32:
; GCN:       ; %bb.0:
; GCN-NEXT:    v_cmp_ne_u32_e64 s0, 0x64, v2
; GCN-NEXT:    v_mov_b32_e32 v2, s0
; GCN-NEXT:    global_store_dword v[0:1], v2, off
; GCN-NEXT:    s_endpgm
  %result = call i32 @llvm.amdgcn.icmp.i32.i32(i32 %src, i32 100, i32 33)
  store i32 %result, i32 addrspace(1)* %out
  ret void
}
declare i64 @llvm.amdgcn.icmp.i64.i32(i32, i32, i32)
declare i32 @llvm.amdgcn.icmp.i32.i32(i32, i32, i32)
attributes #0 = { "target-features"="+wavefrontsize64" }
attributes #1 = { "target-features"="+wavefrontsize32" }
