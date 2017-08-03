; RUN: llc -mtriple=amdgcn-amd-amdhsa -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,CI %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=fiji -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,VI,VI-NOBUG %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=iceland -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN,VI,VI-BUG %s

; Make sure to run a GPU with the SGPR allocation bug.

; GCN-LABEL: {{^}}use_vcc:
; GCN: ; NumSgprs: 34
; GCN: ; NumVgprs: 0
define void @use_vcc() #1 {
  call void asm sideeffect "", "~{vcc}" () #0
  ret void
}

; GCN-LABEL: {{^}}indirect_use_vcc:
; GCN: v_writelane_b32 v32, s33, 0
; GCN: v_writelane_b32 v32, s34, 1
; GCN: v_writelane_b32 v32, s35, 2
; GCN: s_swappc_b64
; GCN: v_readlane_b32 s35, v32, 2
; GCN: v_readlane_b32 s34, v32, 1
; GCN: v_readlane_b32 s33, v32, 0
; GCN: ; NumSgprs: 38
; GCN: ; NumVgprs: 33
define void @indirect_use_vcc() #1 {
  call void @use_vcc()
  ret void
}

; GCN-LABEL: {{^}}indirect_2level_use_vcc_kernel:
; GCN: is_dynamic_callstack = 0
; CI: ; NumSgprs: 40
; VI-NOBUG: ; NumSgprs: 42
; VI-BUG: ; NumSgprs: 96
; GCN: ; NumVgprs: 33
define amdgpu_kernel void @indirect_2level_use_vcc_kernel(i32 addrspace(1)* %out) #0 {
  call void @indirect_use_vcc()
  ret void
}

; GCN-LABEL: {{^}}use_flat_scratch:
; CI: ; NumSgprs: 36
; VI: ; NumSgprs: 38
; GCN: ; NumVgprs: 0
define void @use_flat_scratch() #1 {
  call void asm sideeffect "", "~{flat_scratch}" () #0
  ret void
}

; GCN-LABEL: {{^}}indirect_use_flat_scratch:
; CI: ; NumSgprs: 40
; VI: ; NumSgprs: 42
; GCN: ; NumVgprs: 33
define void @indirect_use_flat_scratch() #1 {
  call void @use_flat_scratch()
  ret void
}

; GCN-LABEL: {{^}}indirect_2level_use_flat_scratch_kernel:
; GCN: is_dynamic_callstack = 0
; CI: ; NumSgprs: 40
; VI-NOBUG: ; NumSgprs: 42
; VI-BUG: ; NumSgprs: 96
; GCN: ; NumVgprs: 33
define amdgpu_kernel void @indirect_2level_use_flat_scratch_kernel(i32 addrspace(1)* %out) #0 {
  call void @indirect_use_flat_scratch()
  ret void
}

; GCN-LABEL: {{^}}use_10_vgpr:
; GCN: ; NumVgprs: 10
define void @use_10_vgpr() #1 {
  call void asm sideeffect "", "~{v0},~{v1},~{v2},~{v3},~{v4}"() #0
  call void asm sideeffect "", "~{v5},~{v6},~{v7},~{v8},~{v9}"() #0
  ret void
}

; GCN-LABEL: {{^}}indirect_use_10_vgpr:
; GCN: ; NumVgprs: 33
define void @indirect_use_10_vgpr() #0 {
  call void @use_10_vgpr()
  ret void
}

; GCN-LABEL: {{^}}indirect_2_level_use_10_vgpr:
; GCN: is_dynamic_callstack = 0
; GCN: ; NumVgprs: 10
define amdgpu_kernel void @indirect_2_level_use_10_vgpr() #0 {
  call void @indirect_use_10_vgpr()
  ret void
}

; GCN-LABEL: {{^}}use_40_vgpr:
; GCN: ; NumVgprs: 40
define void @use_40_vgpr() #1 {
  call void asm sideeffect "", "~{v39}"() #0
  ret void
}

; GCN-LABEL: {{^}}indirect_use_40_vgpr:
; GCN: ; NumVgprs: 40
define void @indirect_use_40_vgpr() #0 {
  call void @use_40_vgpr()
  ret void
}

; GCN-LABEL: {{^}}use_80_sgpr:
; GCN: ; NumSgprs: 80
define void @use_80_sgpr() #1 {
  call void asm sideeffect "", "~{s79}"() #0
  ret void
}

; GCN-LABEL: {{^}}indirect_use_80_sgpr:
; GCN: ; NumSgprs: 82
define void @indirect_use_80_sgpr() #1 {
  call void @use_80_sgpr()
  ret void
}

; GCN-LABEL: {{^}}indirect_2_level_use_80_sgpr:
; GCN: is_dynamic_callstack = 0
; CI: ; NumSgprs: 84
; VI-NOBUG: ; NumSgprs: 86
; VI-BUG: ; NumSgprs: 96
define amdgpu_kernel void @indirect_2_level_use_80_sgpr() #0 {
  call void @indirect_use_80_sgpr()
  ret void
}


; GCN-LABEL: {{^}}use_stack0:
; GCN: ScratchSize: 2052
define void @use_stack0() #1 {
  %alloca = alloca [512 x i32], align 4
  call void asm sideeffect "; use $0", "v"([512 x i32]* %alloca) #0
  ret void
}

; GCN-LABEL: {{^}}use_stack1:
; GCN: ScratchSize: 404
define void @use_stack1() #1 {
  %alloca = alloca [100 x i32], align 4
  call void asm sideeffect "; use $0", "v"([100 x i32]* %alloca) #0
  ret void
}

; GCN-LABEL: {{^}}indirect_use_stack:
; GCN: ScratchSize: 2124
define void @indirect_use_stack() #1 {
  %alloca = alloca [16 x i32], align 4
  call void asm sideeffect "; use $0", "v"([16 x i32]* %alloca) #0
  call void @use_stack0()
  ret void
}

; GCN-LABEL: {{^}}indirect_2_level_use_stack:
; GCN: is_dynamic_callstack = 0
; GCN: ScratchSize: 2124
define amdgpu_kernel void @indirect_2_level_use_stack() #0 {
  call void @indirect_use_stack()
  ret void
}


; Should be maximum of callee usage
; GCN-LABEL: {{^}}multi_call_use_use_stack:
; GCN: is_dynamic_callstack = 0
; GCN: ScratchSize: 2052
define amdgpu_kernel void @multi_call_use_use_stack() #0 {
  call void @use_stack0()
  call void @use_stack1()
  ret void
}


declare void @external() #0

; GCN-LABEL: {{^}}usage_external:
; GCN: is_dynamic_callstack = 1
; NumSgprs: 48
; NumVgprs: 24
; GCN: ScratchSize: 16384
define amdgpu_kernel void @usage_external() #0 {
  call void @external()
  ret void
}

declare void @external_recurse() #2

; GCN-LABEL: {{^}}usage_external_recurse:
; GCN: is_dynamic_callstack = 1
; NumSgprs: 48
; NumVgprs: 24
; GCN: ScratchSize: 16384
define amdgpu_kernel void @usage_external_recurse() #0 {
  call void @external_recurse()
  ret void
}

; GCN-LABEL: {{^}}direct_recursion_use_stack:
; GCN: ScratchSize: 2056
define void @direct_recursion_use_stack(i32 %val) #2 {
  %alloca = alloca [512 x i32], align 4
  call void asm sideeffect "; use $0", "v"([512 x i32]* %alloca) #0
  %cmp = icmp eq i32 %val, 0
  br i1 %cmp, label %ret, label %call

call:
  %val.sub1 = sub i32 %val, 1
  call void @direct_recursion_use_stack(i32 %val.sub1)
  br label %ret

ret:
  ret void
}

; GCN-LABEL: {{^}}usage_direct_recursion:
; GCN: is_ptr64 = 1
; GCN: is_dynamic_callstack = 1
; GCN: workitem_private_segment_byte_size = 2056
define amdgpu_kernel void @usage_direct_recursion(i32 %n) #0 {
  call void @direct_recursion_use_stack(i32 %n)
  ret void
}


attributes #0 = { nounwind norecurse }
attributes #1 = { nounwind noinline norecurse }
attributes #2 = { nounwind noinline }
