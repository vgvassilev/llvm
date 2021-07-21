; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -stop-after=regbankselect -regbankselect-fast -o - %s | FileCheck %s
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -stop-after=regbankselect -regbankselect-greedy -o - %s | FileCheck %s

; Natural mapping
define amdgpu_ps void @struct_buffer_store__sgpr_rsrc__vgpr_val__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, float %val, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_store__sgpr_rsrc__vgpr_val__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1, $vgpr2
  ; CHECK:   [[COPY:%[0-9]+]]:sgpr(s32) = COPY $sgpr2
  ; CHECK:   [[COPY1:%[0-9]+]]:sgpr(s32) = COPY $sgpr3
  ; CHECK:   [[COPY2:%[0-9]+]]:sgpr(s32) = COPY $sgpr4
  ; CHECK:   [[COPY3:%[0-9]+]]:sgpr(s32) = COPY $sgpr5
  ; CHECK:   [[BUILD_VECTOR:%[0-9]+]]:sgpr(<4 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr(s32) = COPY $vgpr0
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr(s32) = COPY $vgpr1
  ; CHECK:   [[COPY6:%[0-9]+]]:vgpr(s32) = COPY $vgpr2
  ; CHECK:   [[COPY7:%[0-9]+]]:sgpr(s32) = COPY $sgpr6
  ; CHECK:   G_AMDGPU_BUFFER_STORE [[COPY4]](s32), [[BUILD_VECTOR]](<4 x s32>), [[COPY5]](s32), [[COPY6]], [[COPY7]], 0, 0, -1 :: (dereferenceable store (s32), align 1, addrspace 4)
  ; CHECK:   S_ENDPGM 0
  call void @llvm.amdgcn.struct.buffer.store.f32(float %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

; Copies for VGPR arguments
define amdgpu_ps void @struct_buffer_store__sgpr_rsrc__sgpr_val__sgpr_vindex__sgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, float inreg %val, i32 inreg %vindex, i32 inreg %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_store__sgpr_rsrc__sgpr_val__sgpr_vindex__sgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $sgpr7, $sgpr8, $sgpr9
  ; CHECK:   [[COPY:%[0-9]+]]:sgpr(s32) = COPY $sgpr2
  ; CHECK:   [[COPY1:%[0-9]+]]:sgpr(s32) = COPY $sgpr3
  ; CHECK:   [[COPY2:%[0-9]+]]:sgpr(s32) = COPY $sgpr4
  ; CHECK:   [[COPY3:%[0-9]+]]:sgpr(s32) = COPY $sgpr5
  ; CHECK:   [[BUILD_VECTOR:%[0-9]+]]:sgpr(<4 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK:   [[COPY4:%[0-9]+]]:sgpr(s32) = COPY $sgpr6
  ; CHECK:   [[COPY5:%[0-9]+]]:sgpr(s32) = COPY $sgpr7
  ; CHECK:   [[COPY6:%[0-9]+]]:sgpr(s32) = COPY $sgpr8
  ; CHECK:   [[COPY7:%[0-9]+]]:sgpr(s32) = COPY $sgpr9
  ; CHECK:   [[COPY8:%[0-9]+]]:vgpr(s32) = COPY [[COPY4]](s32)
  ; CHECK:   [[COPY9:%[0-9]+]]:vgpr(s32) = COPY [[COPY5]](s32)
  ; CHECK:   [[COPY10:%[0-9]+]]:vgpr(s32) = COPY [[COPY6]](s32)
  ; CHECK:   G_AMDGPU_BUFFER_STORE [[COPY8]](s32), [[BUILD_VECTOR]](<4 x s32>), [[COPY9]](s32), [[COPY10]], [[COPY7]], 0, 0, -1 :: (dereferenceable store (s32), align 1, addrspace 4)
  ; CHECK:   S_ENDPGM 0
  call void @llvm.amdgcn.struct.buffer.store.f32(float %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

; Waterfall for rsrc
define amdgpu_ps void @struct_buffer_store__vgpr_rsrc__vgpr_val__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> %rsrc, float %val, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_store__vgpr_rsrc__vgpr_val__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   successors: %bb.2(0x80000000)
  ; CHECK:   liveins: $sgpr2, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6
  ; CHECK:   [[COPY:%[0-9]+]]:vgpr(s32) = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:vgpr(s32) = COPY $vgpr1
  ; CHECK:   [[COPY2:%[0-9]+]]:vgpr(s32) = COPY $vgpr2
  ; CHECK:   [[COPY3:%[0-9]+]]:vgpr(s32) = COPY $vgpr3
  ; CHECK:   [[BUILD_VECTOR:%[0-9]+]]:vgpr(<4 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr(s32) = COPY $vgpr4
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr(s32) = COPY $vgpr5
  ; CHECK:   [[COPY6:%[0-9]+]]:vgpr(s32) = COPY $vgpr6
  ; CHECK:   [[COPY7:%[0-9]+]]:sgpr(s32) = COPY $sgpr2
  ; CHECK:   [[DEF:%[0-9]+]]:sreg_64_xexec = IMPLICIT_DEF
  ; CHECK:   [[UV:%[0-9]+]]:vreg_64(s64), [[UV1:%[0-9]+]]:vreg_64(s64) = G_UNMERGE_VALUES [[BUILD_VECTOR]](<4 x s32>)
  ; CHECK:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; CHECK: bb.2:
  ; CHECK:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; CHECK:   [[PHI:%[0-9]+]]:sreg_64_xexec = PHI [[DEF]], %bb.1, %14, %bb.2
  ; CHECK:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0(s32) = V_READFIRSTLANE_B32 [[UV]].sub0(s64), implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32_xm0(s32) = V_READFIRSTLANE_B32 [[UV]].sub1(s64), implicit $exec
  ; CHECK:   [[MV:%[0-9]+]]:sreg_64_xexec(s64) = G_MERGE_VALUES [[V_READFIRSTLANE_B32_]](s32), [[V_READFIRSTLANE_B32_1]](s32)
  ; CHECK:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[MV]](s64), [[UV]](s64), implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32_xm0(s32) = V_READFIRSTLANE_B32 [[UV1]].sub0(s64), implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32_xm0(s32) = V_READFIRSTLANE_B32 [[UV1]].sub1(s64), implicit $exec
  ; CHECK:   [[MV1:%[0-9]+]]:sreg_64_xexec(s64) = G_MERGE_VALUES [[V_READFIRSTLANE_B32_2]](s32), [[V_READFIRSTLANE_B32_3]](s32)
  ; CHECK:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[MV1]](s64), [[UV1]](s64), implicit $exec
  ; CHECK:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_1]], [[V_CMP_EQ_U64_e64_]], implicit-def $scc
  ; CHECK:   [[BUILD_VECTOR1:%[0-9]+]]:sgpr(<4 x s32>) = G_BUILD_VECTOR [[V_READFIRSTLANE_B32_]](s32), [[V_READFIRSTLANE_B32_1]](s32), [[V_READFIRSTLANE_B32_2]](s32), [[V_READFIRSTLANE_B32_3]](s32)
  ; CHECK:   G_AMDGPU_BUFFER_STORE [[COPY4]](s32), [[BUILD_VECTOR1]](<4 x s32>), [[COPY5]](s32), [[COPY6]], [[COPY7]], 0, 0, -1 :: (dereferenceable store (s32), align 1, addrspace 4)
  ; CHECK:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; CHECK:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; CHECK:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; CHECK: bb.3:
  ; CHECK:   successors: %bb.4(0x80000000)
  ; CHECK:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; CHECK: bb.4:
  ; CHECK:   S_ENDPGM 0
  call void @llvm.amdgcn.struct.buffer.store.f32(float %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

; Waterfall for soffset
define amdgpu_ps void @struct_buffer_store__sgpr_rsrc__vgpr_val__vgpr_vindex__vgpr_voffset__vgpr_soffset(<4 x i32> inreg %rsrc, float %val, i32 %vindex, i32 %voffset, i32 %soffset) {
  ; CHECK-LABEL: name: struct_buffer_store__sgpr_rsrc__vgpr_val__vgpr_vindex__vgpr_voffset__vgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   successors: %bb.2(0x80000000)
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $vgpr0, $vgpr1, $vgpr2, $vgpr3
  ; CHECK:   [[COPY:%[0-9]+]]:sgpr(s32) = COPY $sgpr2
  ; CHECK:   [[COPY1:%[0-9]+]]:sgpr(s32) = COPY $sgpr3
  ; CHECK:   [[COPY2:%[0-9]+]]:sgpr(s32) = COPY $sgpr4
  ; CHECK:   [[COPY3:%[0-9]+]]:sgpr(s32) = COPY $sgpr5
  ; CHECK:   [[BUILD_VECTOR:%[0-9]+]]:sgpr(<4 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr(s32) = COPY $vgpr0
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr(s32) = COPY $vgpr1
  ; CHECK:   [[COPY6:%[0-9]+]]:vgpr(s32) = COPY $vgpr2
  ; CHECK:   [[COPY7:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr3
  ; CHECK:   [[DEF:%[0-9]+]]:sreg_64_xexec = IMPLICIT_DEF
  ; CHECK:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; CHECK: bb.2:
  ; CHECK:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; CHECK:   [[PHI:%[0-9]+]]:sreg_64_xexec = PHI [[DEF]], %bb.1, %14, %bb.2
  ; CHECK:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0(s32) = V_READFIRSTLANE_B32 [[COPY7]](s32), implicit $exec
  ; CHECK:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_]](s32), [[COPY7]](s32), implicit $exec
  ; CHECK:   G_AMDGPU_BUFFER_STORE [[COPY4]](s32), [[BUILD_VECTOR]](<4 x s32>), [[COPY5]](s32), [[COPY6]], [[V_READFIRSTLANE_B32_]], 0, 0, -1 :: (dereferenceable store (s32), align 1, addrspace 4)
  ; CHECK:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[V_CMP_EQ_U32_e64_]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; CHECK:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; CHECK:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; CHECK: bb.3:
  ; CHECK:   successors: %bb.4(0x80000000)
  ; CHECK:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; CHECK: bb.4:
  ; CHECK:   S_ENDPGM 0
  call void @llvm.amdgcn.struct.buffer.store.f32(float %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

; Waterfall for rsrc and soffset
define amdgpu_ps void @struct_buffer_store__vgpr_rsrc__vgpr_val__vgpr_vindex__vgpr_voffset__vgpr_soffset(<4 x i32> %rsrc, float %val, i32 %vindex, i32 %voffset, i32 %soffset) {
  ; CHECK-LABEL: name: struct_buffer_store__vgpr_rsrc__vgpr_val__vgpr_vindex__vgpr_voffset__vgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   successors: %bb.2(0x80000000)
  ; CHECK:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7
  ; CHECK:   [[COPY:%[0-9]+]]:vgpr(s32) = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:vgpr(s32) = COPY $vgpr1
  ; CHECK:   [[COPY2:%[0-9]+]]:vgpr(s32) = COPY $vgpr2
  ; CHECK:   [[COPY3:%[0-9]+]]:vgpr(s32) = COPY $vgpr3
  ; CHECK:   [[BUILD_VECTOR:%[0-9]+]]:vgpr(<4 x s32>) = G_BUILD_VECTOR [[COPY]](s32), [[COPY1]](s32), [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr(s32) = COPY $vgpr4
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr(s32) = COPY $vgpr5
  ; CHECK:   [[COPY6:%[0-9]+]]:vgpr(s32) = COPY $vgpr6
  ; CHECK:   [[COPY7:%[0-9]+]]:vgpr_32(s32) = COPY $vgpr7
  ; CHECK:   [[DEF:%[0-9]+]]:sreg_64_xexec = IMPLICIT_DEF
  ; CHECK:   [[UV:%[0-9]+]]:vreg_64(s64), [[UV1:%[0-9]+]]:vreg_64(s64) = G_UNMERGE_VALUES [[BUILD_VECTOR]](<4 x s32>)
  ; CHECK:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; CHECK: bb.2:
  ; CHECK:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; CHECK:   [[PHI:%[0-9]+]]:sreg_64_xexec = PHI [[DEF]], %bb.1, %14, %bb.2
  ; CHECK:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0(s32) = V_READFIRSTLANE_B32 [[UV]].sub0(s64), implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32_xm0(s32) = V_READFIRSTLANE_B32 [[UV]].sub1(s64), implicit $exec
  ; CHECK:   [[MV:%[0-9]+]]:sreg_64_xexec(s64) = G_MERGE_VALUES [[V_READFIRSTLANE_B32_]](s32), [[V_READFIRSTLANE_B32_1]](s32)
  ; CHECK:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[MV]](s64), [[UV]](s64), implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32_xm0(s32) = V_READFIRSTLANE_B32 [[UV1]].sub0(s64), implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32_xm0(s32) = V_READFIRSTLANE_B32 [[UV1]].sub1(s64), implicit $exec
  ; CHECK:   [[MV1:%[0-9]+]]:sreg_64_xexec(s64) = G_MERGE_VALUES [[V_READFIRSTLANE_B32_2]](s32), [[V_READFIRSTLANE_B32_3]](s32)
  ; CHECK:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[MV1]](s64), [[UV1]](s64), implicit $exec
  ; CHECK:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_1]], [[V_CMP_EQ_U64_e64_]], implicit-def $scc
  ; CHECK:   [[BUILD_VECTOR1:%[0-9]+]]:sgpr(<4 x s32>) = G_BUILD_VECTOR [[V_READFIRSTLANE_B32_]](s32), [[V_READFIRSTLANE_B32_1]](s32), [[V_READFIRSTLANE_B32_2]](s32), [[V_READFIRSTLANE_B32_3]](s32)
  ; CHECK:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32_xm0(s32) = V_READFIRSTLANE_B32 [[COPY7]](s32), implicit $exec
  ; CHECK:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]](s32), [[COPY7]](s32), implicit $exec
  ; CHECK:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U32_e64_]], [[S_AND_B64_]], implicit-def $scc
  ; CHECK:   G_AMDGPU_BUFFER_STORE [[COPY4]](s32), [[BUILD_VECTOR1]](<4 x s32>), [[COPY5]](s32), [[COPY6]], [[V_READFIRSTLANE_B32_4]], 0, 0, -1 :: (dereferenceable store (s32), align 1, addrspace 4)
  ; CHECK:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; CHECK:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; CHECK:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; CHECK: bb.3:
  ; CHECK:   successors: %bb.4(0x80000000)
  ; CHECK:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; CHECK: bb.4:
  ; CHECK:   S_ENDPGM 0
  call void @llvm.amdgcn.struct.buffer.store.f32(float %val, <4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

declare void @llvm.amdgcn.struct.buffer.store.f32(float, <4 x i32>, i32, i32, i32, i32 immarg)
