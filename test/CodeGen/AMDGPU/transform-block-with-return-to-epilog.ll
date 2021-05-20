; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx900 -verify-machineinstrs -stop-after=si-pre-emit-peephole -o - %s | FileCheck -check-prefix=GCN %s
; If the block containing the SI_RETURN_TO_EPILOG is not the last block, insert an empty block at the end and
; insert an unconditional jump there.
define amdgpu_ps float @simple_test_return_to_epilog(float %a) #0 {
  ; GCN-LABEL: name: simple_test_return_to_epilog
  ; GCN: bb.0.entry:
  ; GCN:   liveins: $vgpr0
  ; GCN:   SI_RETURN_TO_EPILOG killed $vgpr0
entry:
  ret float %a
}

define amdgpu_ps float @test_return_to_epilog_into_end_block(i32 inreg %a, float %b) #0 {
  ; GCN-LABEL: name: test_return_to_epilog_into_end_block
  ; GCN: bb.0.entry:
  ; GCN:   successors: %bb.1(0x80000000), %bb.2(0x00000000)
  ; GCN:   liveins: $sgpr2, $vgpr0
  ; GCN:   S_CMP_LT_I32 killed renamable $sgpr2, 1, implicit-def $scc
  ; GCN:   S_CBRANCH_SCC1 %bb.2, implicit killed $scc
  ; GCN: bb.1.if:
  ; GCN:   successors: %bb.3(0x80000000)
  ; GCN:   liveins: $vgpr0
  ; GCN:   S_BRANCH %bb.3
  ; GCN: bb.2.else:
  ; GCN:   successors:
  ; GCN:   renamable $vgpr0 = V_MOV_B32_e32 0, implicit $exec
  ; GCN:   GLOBAL_STORE_DWORD undef renamable $vgpr0_vgpr1, killed renamable $vgpr0, 0, 0, implicit $exec :: (volatile store (s32) into `i32 addrspace(1)* undef`, addrspace 1)
  ; GCN:   S_WAITCNT 3952
  ; GCN: bb.3:
entry:
  %cc = icmp sgt i32 %a, 0
  br i1 %cc, label %if, label %else
if:                                               ; preds = %entry
  ret float %b
else:                                             ; preds = %entry
  store volatile i32 0, i32 addrspace(1)* undef
  unreachable
}

define amdgpu_ps float @test_unify_return_to_epilog_into_end_block(i32 inreg %a, i32 inreg %b, float %c, float %d) #0 {
  ; GCN-LABEL: name: test_unify_return_to_epilog_into_end_block
  ; GCN: bb.0.entry:
  ; GCN:   successors: %bb.1(0x50000000), %bb.2(0x30000000)
  ; GCN:   liveins: $sgpr2, $sgpr3, $vgpr0, $vgpr1
  ; GCN:   S_CMP_LT_I32 killed renamable $sgpr2, 1, implicit-def $scc
  ; GCN:   S_CBRANCH_SCC1 %bb.2, implicit killed $scc
  ; GCN: bb.1.if:
  ; GCN:   successors: %bb.5(0x80000000)
  ; GCN:   liveins: $vgpr0
  ; GCN:   S_BRANCH %bb.5
  ; GCN: bb.2.else.if.cond:
  ; GCN:   successors: %bb.3(0x80000000), %bb.4(0x00000000)
  ; GCN:   liveins: $sgpr3, $vgpr1
  ; GCN:   S_CMP_LT_I32 killed renamable $sgpr3, 1, implicit-def $scc
  ; GCN:   S_CBRANCH_SCC1 %bb.4, implicit killed $scc
  ; GCN: bb.3.else.if:
  ; GCN:   successors: %bb.5(0x80000000)
  ; GCN:   liveins: $vgpr1
  ; GCN:   $vgpr0 = V_MOV_B32_e32 killed $vgpr1, implicit $exec, implicit $exec
  ; GCN:   S_BRANCH %bb.5
  ; GCN: bb.4.else:
  ; GCN:   successors:
  ; GCN:   renamable $vgpr0 = V_MOV_B32_e32 0, implicit $exec
  ; GCN:   GLOBAL_STORE_DWORD undef renamable $vgpr0_vgpr1, killed renamable $vgpr0, 0, 0, implicit $exec :: (volatile store (s32) into `i32 addrspace(1)* undef`, addrspace 1)
  ; GCN:   S_WAITCNT 3952
  ; GCN: bb.5:
entry:
  %cc = icmp sgt i32 %a, 0
  br i1 %cc, label %if, label %else.if.cond
if:                                               ; preds = %entry
  ret float %c
else.if.cond:                                     ; preds = %entry
  %cc1 = icmp sgt i32 %b, 0
  br i1 %cc1, label %else.if, label %else
else.if:                                          ; preds = %else.if.cond
  ret float %d
else:                                             ; preds = %else.if.cond
  store volatile i32 0, i32 addrspace(1)* undef
  unreachable
}

define amdgpu_ps { <4 x float> } @test_return_to_epilog_with_optimized_kill(float %val) #0 {
  ; GCN-LABEL: name: test_return_to_epilog_with_optimized_kill
  ; GCN: bb.0.entry:
  ; GCN:   successors: %bb.1(0x40000000), %bb.4(0x40000000)
  ; GCN:   liveins: $vgpr0
  ; GCN:   renamable $vgpr1 = nofpexcept V_RCP_F32_e32 $vgpr0, implicit $mode, implicit $exec
  ; GCN:   $sgpr0_sgpr1 = S_MOV_B64 $exec
  ; GCN:   nofpexcept V_CMP_NGT_F32_e32 0, killed $vgpr1, implicit-def $vcc, implicit $mode, implicit $exec
  ; GCN:   $sgpr2_sgpr3 = S_AND_SAVEEXEC_B64 killed $vcc, implicit-def $exec, implicit-def $scc, implicit $exec
  ; GCN:   renamable $sgpr2_sgpr3 = S_XOR_B64 $exec, killed renamable $sgpr2_sgpr3, implicit-def dead $scc
  ; GCN:   S_CBRANCH_EXECZ %bb.4, implicit $exec
  ; GCN: bb.1.flow.preheader:
  ; GCN:   successors: %bb.2(0x80000000)
  ; GCN:   liveins: $vgpr0, $sgpr0_sgpr1, $sgpr2_sgpr3
  ; GCN:   nofpexcept V_CMP_NGT_F32_e32 0, killed $vgpr0, implicit-def $vcc, implicit $mode, implicit $exec
  ; GCN:   renamable $sgpr4_sgpr5 = S_MOV_B64 0
  ; GCN: bb.2.flow:
  ; GCN:   successors: %bb.3(0x04000000), %bb.2(0x7c000000)
  ; GCN:   liveins: $vcc, $sgpr0_sgpr1, $sgpr2_sgpr3, $sgpr4_sgpr5
  ; GCN:   renamable $sgpr6_sgpr7 = S_AND_B64 $exec, renamable $vcc, implicit-def $scc
  ; GCN:   renamable $sgpr4_sgpr5 = S_OR_B64 killed renamable $sgpr6_sgpr7, killed renamable $sgpr4_sgpr5, implicit-def $scc
  ; GCN:   $exec = S_ANDN2_B64 $exec, renamable $sgpr4_sgpr5, implicit-def $scc
  ; GCN:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; GCN: bb.3.Flow:
  ; GCN:   successors: %bb.4(0x80000000)
  ; GCN:   liveins: $sgpr0_sgpr1, $sgpr2_sgpr3, $sgpr4_sgpr5
  ; GCN:   $exec = S_OR_B64 $exec, killed renamable $sgpr4_sgpr5, implicit-def $scc
  ; GCN: bb.4.Flow1:
  ; GCN:   successors: %bb.5(0x40000000), %bb.7(0x40000000)
  ; GCN:   liveins: $sgpr0_sgpr1, $sgpr2_sgpr3
  ; GCN:   renamable $sgpr2_sgpr3 = S_OR_SAVEEXEC_B64 killed renamable $sgpr2_sgpr3, implicit-def $exec, implicit-def $scc, implicit $exec
  ; GCN:   $exec = S_XOR_B64 $exec, renamable $sgpr2_sgpr3, implicit-def $scc
  ; GCN:   S_CBRANCH_EXECZ %bb.7, implicit $exec
  ; GCN: bb.5.kill0:
  ; GCN:   successors: %bb.6(0x40000000), %bb.8(0x40000000)
  ; GCN:   liveins: $sgpr0_sgpr1, $sgpr2_sgpr3
  ; GCN:   dead renamable $sgpr0_sgpr1 = S_ANDN2_B64 killed renamable $sgpr0_sgpr1, $exec, implicit-def $scc
  ; GCN:   S_CBRANCH_SCC0 %bb.8, implicit $scc
  ; GCN: bb.6.kill0:
  ; GCN:   successors: %bb.7(0x80000000)
  ; GCN:   liveins: $sgpr2_sgpr3, $scc
  ; GCN:   $exec = S_MOV_B64 0
  ; GCN: bb.7.end:
  ; GCN:   successors: %bb.9(0x80000000)
  ; GCN:   liveins: $sgpr2_sgpr3
  ; GCN:   $exec = S_OR_B64 $exec, killed renamable $sgpr2_sgpr3, implicit-def $scc
  ; GCN:   S_BRANCH %bb.9
  ; GCN: bb.8:
  ; GCN:   $exec = S_MOV_B64 0
  ; GCN:   EXP_DONE 9, undef $vgpr0, undef $vgpr0, undef $vgpr0, undef $vgpr0, 1, 0, 0, implicit $exec
  ; GCN:   S_ENDPGM 0
  ; GCN: bb.9:
entry:
  %.i0 = fdiv reassoc nnan nsz arcp contract afn float 1.000000e+00, %val
  %cmp0 = fcmp olt float %.i0, 0.000000e+00
  br i1 %cmp0, label %kill0, label %flow

kill0:                                            ; preds = %entry
  call void @llvm.amdgcn.kill(i1 false)
  br label %end

flow:                                             ; preds = %entry
  %cmp1 = fcmp olt float %val, 0.000000e+00
  br i1 %cmp1, label %flow, label %end

kill1:                                            ; preds = %flow
  call void @llvm.amdgcn.kill(i1 false)
  br label %end

end:                                              ; preds = %kill0, %kill1, %flow
  ret { <4 x float> } undef
}

declare void @llvm.amdgcn.kill(i1) #0

attributes #0 = { nounwind }
