; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: llc -mtriple=amdgcn-amdhsa -verify-machineinstrs -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck -check-prefix=GCN %s
; RUN: opt -S -si-annotate-control-flow -mtriple=amdgcn-amdhsa -verify-machineinstrs -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck -check-prefix=SI-OPT %s

define hidden void @widget() {
; GCN-LABEL: widget:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_or_saveexec_b64 s[4:5], -1
; GCN-NEXT:    buffer_store_dword v40, off, s[0:3], s32 ; 4-byte Folded Spill
; GCN-NEXT:    s_mov_b64 exec, s[4:5]
; GCN-NEXT:    v_writelane_b32 v40, s33, 2
; GCN-NEXT:    s_mov_b32 s33, s32
; GCN-NEXT:    s_addk_i32 s32, 0x400
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    flat_load_dword v0, v[0:1]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cmp_gt_i32_e32 vcc, 21, v0
; GCN-NEXT:    s_and_b64 vcc, exec, vcc
; GCN-NEXT:    v_writelane_b32 v40, s30, 0
; GCN-NEXT:    v_writelane_b32 v40, s31, 1
; GCN-NEXT:    s_cbranch_vccz BB0_3
; GCN-NEXT:  ; %bb.1: ; %bb4
; GCN-NEXT:    v_cmp_ne_u32_e32 vcc, 9, v0
; GCN-NEXT:    s_and_b64 vcc, exec, vcc
; GCN-NEXT:    s_cbranch_vccnz BB0_4
; GCN-NEXT:  ; %bb.2: ; %bb7
; GCN-NEXT:    s_getpc_b64 s[4:5]
; GCN-NEXT:    s_add_u32 s4, s4, wibble@rel32@lo+4
; GCN-NEXT:    s_addc_u32 s5, s5, wibble@rel32@hi+12
; GCN-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; GCN-NEXT:    s_branch BB0_7
; GCN-NEXT:  BB0_3: ; %bb2
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 21, v0
; GCN-NEXT:    s_and_b64 vcc, exec, vcc
; GCN-NEXT:    s_cbranch_vccnz BB0_6
; GCN-NEXT:  BB0_4: ; %bb9
; GCN-NEXT:    s_getpc_b64 s[4:5]
; GCN-NEXT:    s_add_u32 s4, s4, wibble@rel32@lo+4
; GCN-NEXT:    s_addc_u32 s5, s5, wibble@rel32@hi+12
; GCN-NEXT:    s_swappc_b64 s[30:31], s[4:5]
; GCN-NEXT:    v_cmp_lt_f32_e32 vcc, 0, v0
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], vcc
; GCN-NEXT:    s_cbranch_execnz BB0_7
; GCN-NEXT:  ; %bb.5: ; %bb9.bb12_crit_edge
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:  BB0_6: ; %bb12
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    flat_store_dword v[0:1], v2
; GCN-NEXT:  BB0_7: ; %UnifiedReturnBlock
; GCN-NEXT:    v_readlane_b32 s4, v40, 0
; GCN-NEXT:    v_readlane_b32 s5, v40, 1
; GCN-NEXT:    s_addk_i32 s32, 0xfc00
; GCN-NEXT:    v_readlane_b32 s33, v40, 2
; GCN-NEXT:    s_or_saveexec_b64 s[6:7], -1
; GCN-NEXT:    buffer_load_dword v40, off, s[0:3], s32 ; 4-byte Folded Reload
; GCN-NEXT:    s_mov_b64 exec, s[6:7]
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[4:5]
; SI-OPT-LABEL: @widget(
; SI-OPT-NEXT:  bb:
; SI-OPT-NEXT:    [[TMP:%.*]] = load i32, i32 addrspace(1)* null, align 16
; SI-OPT-NEXT:    [[TMP1:%.*]] = icmp slt i32 [[TMP]], 21
; SI-OPT-NEXT:    br i1 [[TMP1]], label [[BB4:%.*]], label [[BB2:%.*]]
; SI-OPT:       bb2:
; SI-OPT-NEXT:    [[TMP3:%.*]] = icmp eq i32 [[TMP]], 21
; SI-OPT-NEXT:    br i1 [[TMP3]], label [[BB12:%.*]], label [[BB9:%.*]]
; SI-OPT:       bb4:
; SI-OPT-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[TMP]], 9
; SI-OPT-NEXT:    br i1 [[TMP5]], label [[BB7:%.*]], label [[BB9]]
; SI-OPT:       bb6:
; SI-OPT-NEXT:    ret void
; SI-OPT:       bb7:
; SI-OPT-NEXT:    [[TMP8:%.*]] = call float @wibble()
; SI-OPT-NEXT:    ret void
; SI-OPT:       bb9:
; SI-OPT-NEXT:    [[TMP10:%.*]] = call float @wibble()
; SI-OPT-NEXT:    [[TMP11:%.*]] = fcmp nsz ogt float [[TMP10]], 0.000000e+00
; SI-OPT-NEXT:    [[TMP0:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP11]])
; SI-OPT-NEXT:    [[TMP1:%.*]] = extractvalue { i1, i64 } [[TMP0]], 0
; SI-OPT-NEXT:    [[TMP2:%.*]] = extractvalue { i1, i64 } [[TMP0]], 1
; SI-OPT-NEXT:    br i1 [[TMP1]], label [[BB6:%.*]], label [[BB9_BB12_CRIT_EDGE:%.*]]
; SI-OPT:       bb9.bb12_crit_edge:
; SI-OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP2]])
; SI-OPT-NEXT:    br label [[BB12]]
; SI-OPT:       bb12:
; SI-OPT-NEXT:    store float 0.000000e+00, float addrspace(1)* null, align 8
; SI-OPT-NEXT:    ret void
;
bb:
  %tmp = load i32, i32 addrspace(1)* null, align 16
  %tmp1 = icmp slt i32 %tmp, 21
  br i1 %tmp1, label %bb4, label %bb2

bb2:                                              ; preds = %bb
  %tmp3 = icmp eq i32 %tmp, 21
  br i1 %tmp3, label %bb12, label %bb9

bb4:                                              ; preds = %bb
  %tmp5 = icmp eq i32 %tmp, 9
  br i1 %tmp5, label %bb7, label %bb9

bb6:                                              ; preds = %bb9
  ret void

bb7:                                              ; preds = %bb4
  %tmp8 = call float @wibble()
  ret void

bb9:                                              ; preds = %bb4, %bb2
  %tmp10 = call float @wibble()
  %tmp11 = fcmp nsz ogt float %tmp10, 0.000000e+00
  br i1 %tmp11, label %bb6, label %bb12

bb12:                                             ; preds = %bb9, %bb2
  store float 0.000000e+00, float addrspace(1)* null, align 8
  ret void
}

declare hidden float @wibble() local_unnamed_addr


define hidden void @blam() {
; SI-OPT-LABEL: @blam(
; SI-OPT-NEXT:  bb:
; SI-OPT-NEXT:    [[TMP:%.*]] = load float, float* null, align 16
; SI-OPT-NEXT:    br label [[BB2:%.*]]
; SI-OPT:       bb1:
; SI-OPT-NEXT:    br label [[BB2]]
; SI-OPT:       bb2:
; SI-OPT-NEXT:    [[TID:%.*]] = call i32 @llvm.amdgcn.workitem.id.x()
; SI-OPT-NEXT:    [[GEP:%.*]] = getelementptr inbounds i32, i32 addrspace(1)* null, i32 [[TID]]
; SI-OPT-NEXT:    [[TMP3:%.*]] = load i32, i32 addrspace(1)* [[GEP]], align 16
; SI-OPT-NEXT:    store float 0.000000e+00, float addrspace(5)* null, align 8
; SI-OPT-NEXT:    br label [[BB4:%.*]]
; SI-OPT:       bb4:
; SI-OPT-NEXT:    [[TMP5:%.*]] = icmp slt i32 [[TMP3]], 3
; SI-OPT-NEXT:    [[TMP0:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP5]])
; SI-OPT-NEXT:    [[TMP1:%.*]] = extractvalue { i1, i64 } [[TMP0]], 0
; SI-OPT-NEXT:    [[TMP2:%.*]] = extractvalue { i1, i64 } [[TMP0]], 1
; SI-OPT-NEXT:    br i1 [[TMP1]], label [[BB8:%.*]], label [[BB6:%.*]]
; SI-OPT:       bb6:
; SI-OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP2]])
; SI-OPT-NEXT:    [[TMP7:%.*]] = icmp eq i32 [[TMP3]], 3
; SI-OPT-NEXT:    br i1 [[TMP7]], label [[BB11:%.*]], label [[BB1:%.*]]
; SI-OPT:       bb8:
; SI-OPT-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[TMP3]], 1
; SI-OPT-NEXT:    [[TMP3:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP9]])
; SI-OPT-NEXT:    [[TMP4:%.*]] = extractvalue { i1, i64 } [[TMP3]], 0
; SI-OPT-NEXT:    [[TMP5:%.*]] = extractvalue { i1, i64 } [[TMP3]], 1
; SI-OPT-NEXT:    br i1 [[TMP4]], label [[BB10:%.*]], label [[BB8_BB1_CRIT_EDGE:%.*]]
; SI-OPT:       bb8.bb1_crit_edge:
; SI-OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP5]])
; SI-OPT-NEXT:    br label [[BB1]]
; SI-OPT:       bb10:
; SI-OPT-NEXT:    store float 0x7FF8000000000000, float addrspace(5)* null, align 16
; SI-OPT-NEXT:    br label [[BB18:%.*]]
; SI-OPT:       bb11:
; SI-OPT-NEXT:    [[TMP12:%.*]] = call float @spam()
; SI-OPT-NEXT:    [[TMP13:%.*]] = fcmp nsz oeq float [[TMP12]], 0.000000e+00
; SI-OPT-NEXT:    [[TMP6:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP13]])
; SI-OPT-NEXT:    [[TMP7:%.*]] = extractvalue { i1, i64 } [[TMP6]], 0
; SI-OPT-NEXT:    [[TMP8:%.*]] = extractvalue { i1, i64 } [[TMP6]], 1
; SI-OPT-NEXT:    br i1 [[TMP7]], label [[BB2]], label [[BB14:%.*]]
; SI-OPT:       bb14:
; SI-OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP8]])
; SI-OPT-NEXT:    [[TMP15:%.*]] = fcmp nsz oeq float [[TMP]], 0.000000e+00
; SI-OPT-NEXT:    [[TMP9:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP15]])
; SI-OPT-NEXT:    [[TMP10:%.*]] = extractvalue { i1, i64 } [[TMP9]], 0
; SI-OPT-NEXT:    [[TMP11:%.*]] = extractvalue { i1, i64 } [[TMP9]], 1
; SI-OPT-NEXT:    br i1 [[TMP10]], label [[BB17:%.*]], label [[BB16:%.*]]
; SI-OPT:       bb16:
; SI-OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP11]])
; SI-OPT-NEXT:    store float 0x7FF8000000000000, float addrspace(5)* null, align 16
; SI-OPT-NEXT:    br label [[BB17]]
; SI-OPT:       bb17:
; SI-OPT-NEXT:    store float [[TMP]], float addrspace(5)* null, align 16
; SI-OPT-NEXT:    br label [[BB18]]
; SI-OPT:       bb18:
; SI-OPT-NEXT:    store float 0x7FF8000000000000, float addrspace(5)* null, align 4
; SI-OPT-NEXT:    br label [[BB2]]
;
; GCN-LABEL: blam:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_or_saveexec_b64 s[4:5], -1
; GCN-NEXT:    buffer_store_dword v43, off, s[0:3], s32 offset:12 ; 4-byte Folded Spill
; GCN-NEXT:    s_mov_b64 exec, s[4:5]
; GCN-NEXT:    v_writelane_b32 v43, s33, 4
; GCN-NEXT:    s_mov_b32 s33, s32
; GCN-NEXT:    s_addk_i32 s32, 0x800
; GCN-NEXT:    buffer_store_dword v40, off, s[0:3], s33 offset:8 ; 4-byte Folded Spill
; GCN-NEXT:    buffer_store_dword v41, off, s[0:3], s33 offset:4 ; 4-byte Folded Spill
; GCN-NEXT:    buffer_store_dword v42, off, s[0:3], s33 ; 4-byte Folded Spill
; GCN-NEXT:    v_writelane_b32 v43, s34, 0
; GCN-NEXT:    v_writelane_b32 v43, s35, 1
; GCN-NEXT:    v_writelane_b32 v43, s36, 2
; GCN-NEXT:    v_writelane_b32 v43, s37, 3
; GCN-NEXT:    s_mov_b64 s[4:5], 0
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    v_and_b32_e32 v0, 0x3ff, v0
; GCN-NEXT:    flat_load_dword v40, v[1:2]
; GCN-NEXT:    v_mov_b32_e32 v42, 0
; GCN-NEXT:    s_getpc_b64 s[36:37]
; GCN-NEXT:    s_add_u32 s36, s36, spam@rel32@lo+4
; GCN-NEXT:    s_addc_u32 s37, s37, spam@rel32@hi+12
; GCN-NEXT:    v_lshlrev_b32_e32 v41, 2, v0
; GCN-NEXT:    s_waitcnt vmcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_cmp_eq_f32_e64 s[34:35], 0, v40
; GCN-NEXT:    s_branch BB1_3
; GCN-NEXT:  BB1_1: ; %bb10
; GCN-NEXT:    ; in Loop: Header=BB1_3 Depth=1
; GCN-NEXT:    s_or_b64 exec, exec, s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v0, 0x7fc00000
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:  BB1_2: ; %bb18
; GCN-NEXT:    ; in Loop: Header=BB1_3 Depth=1
; GCN-NEXT:    v_mov_b32_e32 v0, 0x7fc00000
; GCN-NEXT:    s_mov_b64 s[4:5], 0
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:  BB1_3: ; %bb2
; GCN-NEXT:    ; =>This Loop Header: Depth=1
; GCN-NEXT:    ; Child Loop BB1_4 Depth 2
; GCN-NEXT:    s_mov_b64 s[6:7], 0
; GCN-NEXT:  BB1_4: ; %bb2
; GCN-NEXT:    ; Parent Loop BB1_3 Depth=1
; GCN-NEXT:    ; => This Inner Loop Header: Depth=2
; GCN-NEXT:    flat_load_dword v0, v[41:42]
; GCN-NEXT:    v_mov_b32_e32 v1, 0
; GCN-NEXT:    buffer_store_dword v1, off, s[0:3], 0
; GCN-NEXT:    s_waitcnt vmcnt(1)
; GCN-NEXT:    v_cmp_gt_i32_e32 vcc, 3, v0
; GCN-NEXT:    s_and_saveexec_b64 s[8:9], vcc
; GCN-NEXT:    s_cbranch_execz BB1_6
; GCN-NEXT:  ; %bb.5: ; %bb8
; GCN-NEXT:    ; in Loop: Header=BB1_4 Depth=2
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 1, v0
; GCN-NEXT:    s_or_b64 s[6:7], vcc, s[6:7]
; GCN-NEXT:    s_mov_b64 s[4:5], 0
; GCN-NEXT:    s_andn2_b64 exec, exec, s[6:7]
; GCN-NEXT:    s_cbranch_execnz BB1_4
; GCN-NEXT:    s_branch BB1_1
; GCN-NEXT:  BB1_6: ; %bb6
; GCN-NEXT:    ; in Loop: Header=BB1_4 Depth=2
; GCN-NEXT:    s_or_b64 exec, exec, s[8:9]
; GCN-NEXT:    v_cmp_eq_u32_e32 vcc, 3, v0
; GCN-NEXT:    s_or_b64 s[4:5], vcc, s[4:5]
; GCN-NEXT:    s_mov_b64 s[6:7], 0
; GCN-NEXT:    s_andn2_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_cbranch_execnz BB1_4
; GCN-NEXT:  ; %bb.7: ; %bb11
; GCN-NEXT:    ; in Loop: Header=BB1_4 Depth=2
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_swappc_b64 s[30:31], s[36:37]
; GCN-NEXT:    v_cmp_eq_f32_e32 vcc, 0, v0
; GCN-NEXT:    s_mov_b64 s[4:5], 0
; GCN-NEXT:    s_mov_b64 s[6:7], 0
; GCN-NEXT:    s_and_saveexec_b64 s[8:9], vcc
; GCN-NEXT:    s_cbranch_execnz BB1_4
; GCN-NEXT:  ; %bb.8: ; %bb14
; GCN-NEXT:    ; in Loop: Header=BB1_3 Depth=1
; GCN-NEXT:    s_or_b64 exec, exec, s[8:9]
; GCN-NEXT:    s_and_saveexec_b64 s[4:5], s[34:35]
; GCN-NEXT:    s_cbranch_execnz BB1_10
; GCN-NEXT:  ; %bb.9: ; %bb16
; GCN-NEXT:    ; in Loop: Header=BB1_3 Depth=1
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    v_mov_b32_e32 v0, 0x7fc00000
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:  BB1_10: ; %bb17
; GCN-NEXT:    ; in Loop: Header=BB1_3 Depth=1
; GCN-NEXT:    buffer_store_dword v40, off, s[0:3], 0
; GCN-NEXT:    s_branch BB1_2
bb:
  %tmp = load float, float* null, align 16
  br label %bb2

bb1:                                              ; preds = %bb8, %bb6
  br label %bb2

bb2:
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %gep  = getelementptr inbounds i32, i32 addrspace(1)* null, i32 %tid
  %tmp3 = load i32, i32 addrspace(1)* %gep, align 16
  store float 0.000000e+00, float addrspace(5)* null, align 8
  br label %bb4

bb4:                                              ; preds = %bb2
  %tmp5 = icmp slt i32 %tmp3, 3
  br i1 %tmp5, label %bb8, label %bb6

bb6:                                              ; preds = %bb4
  %tmp7 = icmp eq i32 %tmp3, 3
  br i1 %tmp7, label %bb11, label %bb1

bb8:                                              ; preds = %bb4
  %tmp9 = icmp eq i32 %tmp3, 1
  br i1 %tmp9, label %bb10, label %bb1

bb10:                                             ; preds = %bb8
  store float 0x7FF8000000000000, float addrspace(5)* null, align 16
  br label %bb18

bb11:                                             ; preds = %bb6
  %tmp12 = call float @spam()
  %tmp13 = fcmp nsz oeq float %tmp12, 0.000000e+00
  br i1 %tmp13, label %bb2, label %bb14

bb14:                                             ; preds = %bb11
  %tmp15 = fcmp nsz oeq float %tmp, 0.000000e+00
  br i1 %tmp15, label %bb17, label %bb16

bb16:                                             ; preds = %bb14
  store float 0x7FF8000000000000, float addrspace(5)* null, align 16
  br label %bb17

bb17:                                             ; preds = %bb16, %bb14
  store float %tmp, float addrspace(5)* null, align 16
  br label %bb18

bb18:                                             ; preds = %bb17, %bb10
  store float 0x7FF8000000000000, float addrspace(5)* null, align 4
  br label %bb2
}

declare i32 @llvm.amdgcn.workitem.id.x()

declare hidden float @spam()
