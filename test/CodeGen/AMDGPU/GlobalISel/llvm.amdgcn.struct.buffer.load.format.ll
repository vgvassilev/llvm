; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=fiji -stop-after=instruction-select -verify-machineinstrs -o - %s | FileCheck %s
; XUN: llc -global-isel -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx810 -stop-after=instruction-select -verify-machineinstrs -o - %s | FileCheck %s

define amdgpu_ps float @struct_buffer_load_format_f32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_load_format_f32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; CHECK:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; CHECK:   [[BUFFER_LOAD_FORMAT_X_BOTHEN:%[0-9]+]]:vgpr_32 = BUFFER_LOAD_FORMAT_X_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable load 4 from custom "BufferResource", align 1, addrspace 4)
  ; CHECK:   $vgpr0 = COPY [[BUFFER_LOAD_FORMAT_X_BOTHEN]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = call float @llvm.amdgcn.struct.buffer.load.format.f32(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret float %val
}

define amdgpu_ps <2 x float> @struct_buffer_load_format_v2f32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_load_format_v2f32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; CHECK:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; CHECK:   [[BUFFER_LOAD_FORMAT_XY_BOTHEN:%[0-9]+]]:vreg_64 = BUFFER_LOAD_FORMAT_XY_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable load 8 from custom "BufferResource", align 1, addrspace 4)
  ; CHECK:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XY_BOTHEN]].sub0
  ; CHECK:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XY_BOTHEN]].sub1
  ; CHECK:   $vgpr0 = COPY [[COPY7]]
  ; CHECK:   $vgpr1 = COPY [[COPY8]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1
  %val = call <2 x float> @llvm.amdgcn.struct.buffer.load.format.v2f32(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret <2 x float> %val
}

define amdgpu_ps <3 x float> @struct_buffer_load_format_v3f32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_load_format_v3f32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; CHECK:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; CHECK:   [[BUFFER_LOAD_FORMAT_XYZ_BOTHEN:%[0-9]+]]:vreg_96 = BUFFER_LOAD_FORMAT_XYZ_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable load 12 from custom "BufferResource", align 1, addrspace 4)
  ; CHECK:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XYZ_BOTHEN]].sub0
  ; CHECK:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XYZ_BOTHEN]].sub1
  ; CHECK:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XYZ_BOTHEN]].sub2
  ; CHECK:   $vgpr0 = COPY [[COPY7]]
  ; CHECK:   $vgpr1 = COPY [[COPY8]]
  ; CHECK:   $vgpr2 = COPY [[COPY9]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2
  %val = call <3 x float> @llvm.amdgcn.struct.buffer.load.format.v3f32(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret <3 x float> %val
}

define amdgpu_ps <4 x float> @struct_buffer_load_format_v4f32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_load_format_v4f32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; CHECK:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; CHECK:   [[BUFFER_LOAD_FORMAT_XYZW_BOTHEN:%[0-9]+]]:vreg_128 = BUFFER_LOAD_FORMAT_XYZW_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable load 16 from custom "BufferResource", align 1, addrspace 4)
  ; CHECK:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XYZW_BOTHEN]].sub0
  ; CHECK:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XYZW_BOTHEN]].sub1
  ; CHECK:   [[COPY9:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XYZW_BOTHEN]].sub2
  ; CHECK:   [[COPY10:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XYZW_BOTHEN]].sub3
  ; CHECK:   $vgpr0 = COPY [[COPY7]]
  ; CHECK:   $vgpr1 = COPY [[COPY8]]
  ; CHECK:   $vgpr2 = COPY [[COPY9]]
  ; CHECK:   $vgpr3 = COPY [[COPY10]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %val = call <4 x float> @llvm.amdgcn.struct.buffer.load.format.v4f32(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret <4 x float> %val
}

; Waterfall for rsrc and soffset, copy for voffset
define amdgpu_ps <4 x float> @struct_buffer_load_format_v4f32__vpr_rsrc__sgpr_vindex__sgpr_voffset__vgpr_soffset(<4 x i32> %rsrc, i32 inreg %vindex, i32 inreg %voffset, i32 %soffset) {
  ; CHECK-LABEL: name: struct_buffer_load_format_v4f32__vpr_rsrc__sgpr_vindex__sgpr_voffset__vgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   successors: %bb.2(0x80000000)
  ; CHECK:   liveins: $sgpr2, $sgpr3, $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4
  ; CHECK:   [[COPY:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY2:%[0-9]+]]:vgpr_32 = COPY $vgpr2
  ; CHECK:   [[COPY3:%[0-9]+]]:vgpr_32 = COPY $vgpr3
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:vreg_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; CHECK:   [[COPY4:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY5:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY6:%[0-9]+]]:vgpr_32 = COPY $vgpr4
  ; CHECK:   [[COPY7:%[0-9]+]]:vgpr_32 = COPY [[COPY4]]
  ; CHECK:   [[COPY8:%[0-9]+]]:vgpr_32 = COPY [[COPY5]]
  ; CHECK:   [[COPY9:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub0_sub1
  ; CHECK:   [[COPY10:%[0-9]+]]:vreg_64 = COPY [[REG_SEQUENCE]].sub2_sub3
  ; CHECK:   [[S_MOV_B64_term:%[0-9]+]]:sreg_64_xexec = S_MOV_B64_term $exec
  ; CHECK: bb.2:
  ; CHECK:   successors: %bb.3(0x40000000), %bb.2(0x40000000)
  ; CHECK:   [[V_READFIRSTLANE_B32_:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY9]].sub0, implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_1:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY9]].sub1, implicit $exec
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1
  ; CHECK:   [[V_CMP_EQ_U64_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE1]], [[COPY9]], implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_2:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY10]].sub0, implicit $exec
  ; CHECK:   [[V_READFIRSTLANE_B32_3:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY10]].sub1, implicit $exec
  ; CHECK:   [[REG_SEQUENCE2:%[0-9]+]]:sreg_64_xexec = REG_SEQUENCE [[V_READFIRSTLANE_B32_2]], %subreg.sub0, [[V_READFIRSTLANE_B32_3]], %subreg.sub1
  ; CHECK:   [[V_CMP_EQ_U64_e64_1:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U64_e64 [[REG_SEQUENCE2]], [[COPY10]], implicit $exec
  ; CHECK:   [[S_AND_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U64_e64_1]], [[V_CMP_EQ_U64_e64_]], implicit-def $scc
  ; CHECK:   [[REG_SEQUENCE3:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[V_READFIRSTLANE_B32_]], %subreg.sub0, [[V_READFIRSTLANE_B32_1]], %subreg.sub1, [[V_READFIRSTLANE_B32_2]], %subreg.sub2, [[V_READFIRSTLANE_B32_3]], %subreg.sub3
  ; CHECK:   [[V_READFIRSTLANE_B32_4:%[0-9]+]]:sreg_32_xm0 = V_READFIRSTLANE_B32 [[COPY6]], implicit $exec
  ; CHECK:   [[V_CMP_EQ_U32_e64_:%[0-9]+]]:sreg_64_xexec = V_CMP_EQ_U32_e64 [[V_READFIRSTLANE_B32_4]], [[COPY6]], implicit $exec
  ; CHECK:   [[S_AND_B64_1:%[0-9]+]]:sreg_64_xexec = S_AND_B64 [[V_CMP_EQ_U32_e64_]], [[S_AND_B64_]], implicit-def $scc
  ; CHECK:   [[REG_SEQUENCE4:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY7]], %subreg.sub0, [[COPY8]], %subreg.sub1
  ; CHECK:   [[BUFFER_LOAD_FORMAT_XYZW_BOTHEN:%[0-9]+]]:vreg_128 = BUFFER_LOAD_FORMAT_XYZW_BOTHEN [[REG_SEQUENCE4]], [[REG_SEQUENCE3]], [[V_READFIRSTLANE_B32_4]], 0, 0, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable load 16 from custom "BufferResource", align 1, addrspace 4)
  ; CHECK:   [[S_AND_SAVEEXEC_B64_:%[0-9]+]]:sreg_64_xexec = S_AND_SAVEEXEC_B64 killed [[S_AND_B64_1]], implicit-def $exec, implicit-def $scc, implicit $exec
  ; CHECK:   $exec = S_XOR_B64_term $exec, [[S_AND_SAVEEXEC_B64_]], implicit-def $scc
  ; CHECK:   S_CBRANCH_EXECNZ %bb.2, implicit $exec
  ; CHECK: bb.3:
  ; CHECK:   successors: %bb.4(0x80000000)
  ; CHECK:   $exec = S_MOV_B64_term [[S_MOV_B64_term]]
  ; CHECK: bb.4:
  ; CHECK:   [[COPY11:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XYZW_BOTHEN]].sub0
  ; CHECK:   [[COPY12:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XYZW_BOTHEN]].sub1
  ; CHECK:   [[COPY13:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XYZW_BOTHEN]].sub2
  ; CHECK:   [[COPY14:%[0-9]+]]:vgpr_32 = COPY [[BUFFER_LOAD_FORMAT_XYZW_BOTHEN]].sub3
  ; CHECK:   $vgpr0 = COPY [[COPY11]]
  ; CHECK:   $vgpr1 = COPY [[COPY12]]
  ; CHECK:   $vgpr2 = COPY [[COPY13]]
  ; CHECK:   $vgpr3 = COPY [[COPY14]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %val = call <4 x float> @llvm.amdgcn.struct.buffer.load.format.v4f32(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret <4 x float> %val
}

define amdgpu_ps float @struct_buffer_load_format_f32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset_voffsset_add_4095(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset.base, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_load_format_f32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset_voffsset_add_4095
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; CHECK:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; CHECK:   [[BUFFER_LOAD_FORMAT_X_BOTHEN:%[0-9]+]]:vgpr_32 = BUFFER_LOAD_FORMAT_X_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 4095, 0, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable load 4 from custom "BufferResource" + 4095, align 1, addrspace 4)
  ; CHECK:   $vgpr0 = COPY [[BUFFER_LOAD_FORMAT_X_BOTHEN]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %voffset = add i32 %voffset.base, 4095
  %val = call float @llvm.amdgcn.struct.buffer.load.format.f32(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret float %val
}

define amdgpu_ps float @struct_buffer_load_format_i32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset(<4 x i32> inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
  ; CHECK-LABEL: name: struct_buffer_load_format_i32__sgpr_rsrc__vgpr_vindex__vgpr_voffset__sgpr_soffset
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $sgpr2, $sgpr3, $sgpr4, $sgpr5, $sgpr6, $vgpr0, $vgpr1
  ; CHECK:   [[COPY:%[0-9]+]]:sreg_32 = COPY $sgpr2
  ; CHECK:   [[COPY1:%[0-9]+]]:sreg_32 = COPY $sgpr3
  ; CHECK:   [[COPY2:%[0-9]+]]:sreg_32 = COPY $sgpr4
  ; CHECK:   [[COPY3:%[0-9]+]]:sreg_32 = COPY $sgpr5
  ; CHECK:   [[REG_SEQUENCE:%[0-9]+]]:sgpr_128 = REG_SEQUENCE [[COPY]], %subreg.sub0, [[COPY1]], %subreg.sub1, [[COPY2]], %subreg.sub2, [[COPY3]], %subreg.sub3
  ; CHECK:   [[COPY4:%[0-9]+]]:vgpr_32 = COPY $vgpr0
  ; CHECK:   [[COPY5:%[0-9]+]]:vgpr_32 = COPY $vgpr1
  ; CHECK:   [[COPY6:%[0-9]+]]:sreg_32 = COPY $sgpr6
  ; CHECK:   [[REG_SEQUENCE1:%[0-9]+]]:vreg_64 = REG_SEQUENCE [[COPY4]], %subreg.sub0, [[COPY5]], %subreg.sub1
  ; CHECK:   [[BUFFER_LOAD_FORMAT_X_BOTHEN:%[0-9]+]]:vgpr_32 = BUFFER_LOAD_FORMAT_X_BOTHEN [[REG_SEQUENCE1]], [[REG_SEQUENCE]], [[COPY6]], 0, 0, 0, 0, 0, 0, 0, implicit $exec :: (dereferenceable load 4 from custom "BufferResource", align 1, addrspace 4)
  ; CHECK:   $vgpr0 = COPY [[BUFFER_LOAD_FORMAT_X_BOTHEN]]
  ; CHECK:   SI_RETURN_TO_EPILOG implicit $vgpr0
  %val = call i32 @llvm.amdgcn.struct.buffer.load.format.i32(<4 x i32> %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  %fval = bitcast i32 %val to float
  ret float %fval
}

declare float @llvm.amdgcn.struct.buffer.load.format.f32(<4 x i32>, i32, i32, i32, i32 immarg) #0
declare <2 x float> @llvm.amdgcn.struct.buffer.load.format.v2f32(<4 x i32>, i32, i32, i32, i32 immarg) #0
declare <3 x float> @llvm.amdgcn.struct.buffer.load.format.v3f32(<4 x i32>, i32, i32, i32, i32 immarg) #0
declare <4 x float> @llvm.amdgcn.struct.buffer.load.format.v4f32(<4 x i32>, i32, i32, i32, i32 immarg) #0
declare i32 @llvm.amdgcn.struct.buffer.load.format.i32(<4 x i32>, i32, i32, i32, i32 immarg) #0

attributes #0 = { nounwind readonly }
