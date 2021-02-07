; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn-amd-amdhsa -stop-after=irtranslator -o - %s | FileCheck %s

; Test 64-bit pointer with 64-bit index
define <2 x i32 addrspace(1)*> @vector_gep_v2p1_index_v2i64(<2 x i32 addrspace(1)*> %ptr, <2 x i64> %idx) {
  ; CHECK-LABEL: name: vector_gep_v2p1_index_v2i64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $sgpr30_sgpr31
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK:   [[COPY3:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; CHECK:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK:   [[MV1:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK:   [[BUILD_VECTOR:%[0-9]+]]:_(<2 x p1>) = G_BUILD_VECTOR [[MV]](p1), [[MV1]](p1)
  ; CHECK:   [[COPY4:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; CHECK:   [[COPY5:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; CHECK:   [[COPY6:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; CHECK:   [[COPY7:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; CHECK:   [[MV2:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY4]](s32), [[COPY5]](s32)
  ; CHECK:   [[MV3:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY6]](s32), [[COPY7]](s32)
  ; CHECK:   [[BUILD_VECTOR1:%[0-9]+]]:_(<2 x s64>) = G_BUILD_VECTOR [[MV2]](s64), [[MV3]](s64)
  ; CHECK:   [[COPY8:%[0-9]+]]:sgpr_64 = COPY $sgpr30_sgpr31
  ; CHECK:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; CHECK:   [[BUILD_VECTOR2:%[0-9]+]]:_(<2 x s64>) = G_BUILD_VECTOR [[C]](s64), [[C]](s64)
  ; CHECK:   [[MUL:%[0-9]+]]:_(<2 x s64>) = G_MUL [[BUILD_VECTOR1]], [[BUILD_VECTOR2]]
  ; CHECK:   [[PTR_ADD:%[0-9]+]]:_(<2 x p1>) = G_PTR_ADD [[BUILD_VECTOR]], [[MUL]](<2 x s64>)
  ; CHECK:   [[COPY9:%[0-9]+]]:_(<2 x p1>) = COPY [[PTR_ADD]](<2 x p1>)
  ; CHECK:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY9]](<2 x p1>)
  ; CHECK:   $vgpr0 = COPY [[UV]](s32)
  ; CHECK:   $vgpr1 = COPY [[UV1]](s32)
  ; CHECK:   $vgpr2 = COPY [[UV2]](s32)
  ; CHECK:   $vgpr3 = COPY [[UV3]](s32)
  ; CHECK:   [[COPY10:%[0-9]+]]:ccr_sgpr_64 = COPY [[COPY8]]
  ; CHECK:   S_SETPC_B64_return [[COPY10]], implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %gep = getelementptr i32, <2 x i32 addrspace(1)*> %ptr, <2 x i64> %idx
  ret <2 x i32 addrspace(1)*> %gep
}

; Test 32-bit pointer with 32-bit index
define <2 x i32 addrspace(3)*> @vector_gep_v2p3_index_v2i32(<2 x i32 addrspace(3)*> %ptr, <2 x i32> %idx) {
  ; CHECK-LABEL: name: vector_gep_v2p3_index_v2i32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $sgpr30_sgpr31
  ; CHECK:   [[COPY:%[0-9]+]]:_(p3) = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(p3) = COPY $vgpr1
  ; CHECK:   [[BUILD_VECTOR:%[0-9]+]]:_(<2 x p3>) = G_BUILD_VECTOR [[COPY]](p3), [[COPY1]](p3)
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK:   [[COPY3:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; CHECK:   [[BUILD_VECTOR1:%[0-9]+]]:_(<2 x s32>) = G_BUILD_VECTOR [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK:   [[COPY4:%[0-9]+]]:sgpr_64 = COPY $sgpr30_sgpr31
  ; CHECK:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 4
  ; CHECK:   [[BUILD_VECTOR2:%[0-9]+]]:_(<2 x s32>) = G_BUILD_VECTOR [[C]](s32), [[C]](s32)
  ; CHECK:   [[MUL:%[0-9]+]]:_(<2 x s32>) = G_MUL [[BUILD_VECTOR1]], [[BUILD_VECTOR2]]
  ; CHECK:   [[PTR_ADD:%[0-9]+]]:_(<2 x p3>) = G_PTR_ADD [[BUILD_VECTOR]], [[MUL]](<2 x s32>)
  ; CHECK:   [[COPY5:%[0-9]+]]:_(<2 x p3>) = COPY [[PTR_ADD]](<2 x p3>)
  ; CHECK:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY5]](<2 x p3>)
  ; CHECK:   $vgpr0 = COPY [[UV]](s32)
  ; CHECK:   $vgpr1 = COPY [[UV1]](s32)
  ; CHECK:   [[COPY6:%[0-9]+]]:ccr_sgpr_64 = COPY [[COPY4]]
  ; CHECK:   S_SETPC_B64_return [[COPY6]], implicit $vgpr0, implicit $vgpr1
  %gep = getelementptr i32, <2 x i32 addrspace(3)*> %ptr, <2 x i32> %idx
  ret <2 x i32 addrspace(3)*> %gep
}

; Test 64-bit pointer with 32-bit index
define <2 x i32 addrspace(1)*> @vector_gep_v2p1_index_v2i32(<2 x i32 addrspace(1)*> %ptr, <2 x i32> %idx) {
  ; CHECK-LABEL: name: vector_gep_v2p1_index_v2i32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $sgpr30_sgpr31
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK:   [[COPY3:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; CHECK:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK:   [[MV1:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK:   [[BUILD_VECTOR:%[0-9]+]]:_(<2 x p1>) = G_BUILD_VECTOR [[MV]](p1), [[MV1]](p1)
  ; CHECK:   [[COPY4:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; CHECK:   [[COPY5:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; CHECK:   [[BUILD_VECTOR1:%[0-9]+]]:_(<2 x s32>) = G_BUILD_VECTOR [[COPY4]](s32), [[COPY5]](s32)
  ; CHECK:   [[COPY6:%[0-9]+]]:sgpr_64 = COPY $sgpr30_sgpr31
  ; CHECK:   [[SEXT:%[0-9]+]]:_(<2 x s64>) = G_SEXT [[BUILD_VECTOR1]](<2 x s32>)
  ; CHECK:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; CHECK:   [[BUILD_VECTOR2:%[0-9]+]]:_(<2 x s64>) = G_BUILD_VECTOR [[C]](s64), [[C]](s64)
  ; CHECK:   [[MUL:%[0-9]+]]:_(<2 x s64>) = G_MUL [[SEXT]], [[BUILD_VECTOR2]]
  ; CHECK:   [[PTR_ADD:%[0-9]+]]:_(<2 x p1>) = G_PTR_ADD [[BUILD_VECTOR]], [[MUL]](<2 x s64>)
  ; CHECK:   [[COPY7:%[0-9]+]]:_(<2 x p1>) = COPY [[PTR_ADD]](<2 x p1>)
  ; CHECK:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY7]](<2 x p1>)
  ; CHECK:   $vgpr0 = COPY [[UV]](s32)
  ; CHECK:   $vgpr1 = COPY [[UV1]](s32)
  ; CHECK:   $vgpr2 = COPY [[UV2]](s32)
  ; CHECK:   $vgpr3 = COPY [[UV3]](s32)
  ; CHECK:   [[COPY8:%[0-9]+]]:ccr_sgpr_64 = COPY [[COPY6]]
  ; CHECK:   S_SETPC_B64_return [[COPY8]], implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %gep = getelementptr i32, <2 x i32 addrspace(1)*> %ptr, <2 x i32> %idx
  ret <2 x i32 addrspace(1)*> %gep
}

; Test 64-bit pointer with 64-bit scalar index
define <2 x i32 addrspace(1)*> @vector_gep_v2p1_index_i64(<2 x i32 addrspace(1)*> %ptr, i64 %idx) {
  ; CHECK-LABEL: name: vector_gep_v2p1_index_i64
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $sgpr30_sgpr31
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK:   [[COPY3:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; CHECK:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK:   [[MV1:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK:   [[BUILD_VECTOR:%[0-9]+]]:_(<2 x p1>) = G_BUILD_VECTOR [[MV]](p1), [[MV1]](p1)
  ; CHECK:   [[COPY4:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; CHECK:   [[COPY5:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; CHECK:   [[MV2:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY4]](s32), [[COPY5]](s32)
  ; CHECK:   [[COPY6:%[0-9]+]]:sgpr_64 = COPY $sgpr30_sgpr31
  ; CHECK:   [[BUILD_VECTOR1:%[0-9]+]]:_(<2 x s64>) = G_BUILD_VECTOR [[MV2]](s64), [[MV2]](s64)
  ; CHECK:   [[COPY7:%[0-9]+]]:_(<2 x s64>) = COPY [[BUILD_VECTOR1]](<2 x s64>)
  ; CHECK:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; CHECK:   [[BUILD_VECTOR2:%[0-9]+]]:_(<2 x s64>) = G_BUILD_VECTOR [[C]](s64), [[C]](s64)
  ; CHECK:   [[MUL:%[0-9]+]]:_(<2 x s64>) = G_MUL [[COPY7]], [[BUILD_VECTOR2]]
  ; CHECK:   [[PTR_ADD:%[0-9]+]]:_(<2 x p1>) = G_PTR_ADD [[BUILD_VECTOR]], [[MUL]](<2 x s64>)
  ; CHECK:   [[COPY8:%[0-9]+]]:_(<2 x p1>) = COPY [[PTR_ADD]](<2 x p1>)
  ; CHECK:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY8]](<2 x p1>)
  ; CHECK:   $vgpr0 = COPY [[UV]](s32)
  ; CHECK:   $vgpr1 = COPY [[UV1]](s32)
  ; CHECK:   $vgpr2 = COPY [[UV2]](s32)
  ; CHECK:   $vgpr3 = COPY [[UV3]](s32)
  ; CHECK:   [[COPY9:%[0-9]+]]:ccr_sgpr_64 = COPY [[COPY6]]
  ; CHECK:   S_SETPC_B64_return [[COPY9]], implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %gep = getelementptr i32, <2 x i32 addrspace(1)*> %ptr, i64 %idx
  ret <2 x i32 addrspace(1)*> %gep
}

; Test 64-bit pointer with 32-bit scalar index
define <2 x i32 addrspace(1)*> @vector_gep_v2p1_index_i32(<2 x i32 addrspace(1)*> %ptr, i32 %idx) {
  ; CHECK-LABEL: name: vector_gep_v2p1_index_i32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $sgpr30_sgpr31
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK:   [[COPY3:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; CHECK:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK:   [[MV1:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK:   [[BUILD_VECTOR:%[0-9]+]]:_(<2 x p1>) = G_BUILD_VECTOR [[MV]](p1), [[MV1]](p1)
  ; CHECK:   [[COPY4:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; CHECK:   [[COPY5:%[0-9]+]]:sgpr_64 = COPY $sgpr30_sgpr31
  ; CHECK:   [[BUILD_VECTOR1:%[0-9]+]]:_(<2 x s32>) = G_BUILD_VECTOR [[COPY4]](s32), [[COPY4]](s32)
  ; CHECK:   [[SEXT:%[0-9]+]]:_(<2 x s64>) = G_SEXT [[BUILD_VECTOR1]](<2 x s32>)
  ; CHECK:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; CHECK:   [[BUILD_VECTOR2:%[0-9]+]]:_(<2 x s64>) = G_BUILD_VECTOR [[C]](s64), [[C]](s64)
  ; CHECK:   [[MUL:%[0-9]+]]:_(<2 x s64>) = G_MUL [[SEXT]], [[BUILD_VECTOR2]]
  ; CHECK:   [[PTR_ADD:%[0-9]+]]:_(<2 x p1>) = G_PTR_ADD [[BUILD_VECTOR]], [[MUL]](<2 x s64>)
  ; CHECK:   [[COPY6:%[0-9]+]]:_(<2 x p1>) = COPY [[PTR_ADD]](<2 x p1>)
  ; CHECK:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY6]](<2 x p1>)
  ; CHECK:   $vgpr0 = COPY [[UV]](s32)
  ; CHECK:   $vgpr1 = COPY [[UV1]](s32)
  ; CHECK:   $vgpr2 = COPY [[UV2]](s32)
  ; CHECK:   $vgpr3 = COPY [[UV3]](s32)
  ; CHECK:   [[COPY7:%[0-9]+]]:ccr_sgpr_64 = COPY [[COPY5]]
  ; CHECK:   S_SETPC_B64_return [[COPY7]], implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %gep = getelementptr i32, <2 x i32 addrspace(1)*> %ptr, i32 %idx
  ret <2 x i32 addrspace(1)*> %gep
}

; Test 64-bit pointer with 64-bit constant, non-splat
define <2 x i32 addrspace(1)*> @vector_gep_v2p1_index_v2i64_constant(<2 x i32 addrspace(1)*> %ptr, <2 x i64> %idx) {
  ; CHECK-LABEL: name: vector_gep_v2p1_index_v2i64_constant
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $vgpr0, $vgpr1, $vgpr2, $vgpr3, $vgpr4, $vgpr5, $vgpr6, $vgpr7, $sgpr30_sgpr31
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $vgpr0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $vgpr1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $vgpr2
  ; CHECK:   [[COPY3:%[0-9]+]]:_(s32) = COPY $vgpr3
  ; CHECK:   [[MV:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY]](s32), [[COPY1]](s32)
  ; CHECK:   [[MV1:%[0-9]+]]:_(p1) = G_MERGE_VALUES [[COPY2]](s32), [[COPY3]](s32)
  ; CHECK:   [[BUILD_VECTOR:%[0-9]+]]:_(<2 x p1>) = G_BUILD_VECTOR [[MV]](p1), [[MV1]](p1)
  ; CHECK:   [[COPY4:%[0-9]+]]:_(s32) = COPY $vgpr4
  ; CHECK:   [[COPY5:%[0-9]+]]:_(s32) = COPY $vgpr5
  ; CHECK:   [[COPY6:%[0-9]+]]:_(s32) = COPY $vgpr6
  ; CHECK:   [[COPY7:%[0-9]+]]:_(s32) = COPY $vgpr7
  ; CHECK:   [[MV2:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY4]](s32), [[COPY5]](s32)
  ; CHECK:   [[MV3:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY6]](s32), [[COPY7]](s32)
  ; CHECK:   [[BUILD_VECTOR1:%[0-9]+]]:_(<2 x s64>) = G_BUILD_VECTOR [[MV2]](s64), [[MV3]](s64)
  ; CHECK:   [[COPY8:%[0-9]+]]:sgpr_64 = COPY $sgpr30_sgpr31
  ; CHECK:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 1
  ; CHECK:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 2
  ; CHECK:   [[BUILD_VECTOR2:%[0-9]+]]:_(<2 x s64>) = G_BUILD_VECTOR [[C]](s64), [[C1]](s64)
  ; CHECK:   [[C2:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; CHECK:   [[BUILD_VECTOR3:%[0-9]+]]:_(<2 x s64>) = G_BUILD_VECTOR [[C2]](s64), [[C2]](s64)
  ; CHECK:   [[MUL:%[0-9]+]]:_(<2 x s64>) = G_MUL [[BUILD_VECTOR2]], [[BUILD_VECTOR3]]
  ; CHECK:   [[PTR_ADD:%[0-9]+]]:_(<2 x p1>) = G_PTR_ADD [[BUILD_VECTOR]], [[MUL]](<2 x s64>)
  ; CHECK:   [[COPY9:%[0-9]+]]:_(<2 x p1>) = COPY [[PTR_ADD]](<2 x p1>)
  ; CHECK:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32), [[UV2:%[0-9]+]]:_(s32), [[UV3:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[COPY9]](<2 x p1>)
  ; CHECK:   $vgpr0 = COPY [[UV]](s32)
  ; CHECK:   $vgpr1 = COPY [[UV1]](s32)
  ; CHECK:   $vgpr2 = COPY [[UV2]](s32)
  ; CHECK:   $vgpr3 = COPY [[UV3]](s32)
  ; CHECK:   [[COPY10:%[0-9]+]]:ccr_sgpr_64 = COPY [[COPY8]]
  ; CHECK:   S_SETPC_B64_return [[COPY10]], implicit $vgpr0, implicit $vgpr1, implicit $vgpr2, implicit $vgpr3
  %gep = getelementptr i32, <2 x i32 addrspace(1)*> %ptr, <2 x i64> <i64 1, i64 2>
  ret <2 x i32 addrspace(1)*> %gep
}
