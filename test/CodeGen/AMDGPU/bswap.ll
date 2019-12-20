; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=amdgcn-- -verify-machineinstrs | FileCheck %s --check-prefixes=FUNC,GCN,SI
; RUN: llc < %s -mtriple=amdgcn-- -mcpu=tonga -mattr=-flat-for-global -verify-machineinstrs | FileCheck %s -check-prefixes=FUNC,GCN,VI

declare i16 @llvm.bswap.i16(i16) nounwind readnone
declare i32 @llvm.bswap.i32(i32) nounwind readnone
declare <2 x i32> @llvm.bswap.v2i32(<2 x i32>) nounwind readnone
declare <4 x i32> @llvm.bswap.v4i32(<4 x i32>) nounwind readnone
declare <8 x i32> @llvm.bswap.v8i32(<8 x i32>) nounwind readnone
declare i64 @llvm.bswap.i64(i64) nounwind readnone
declare <2 x i64> @llvm.bswap.v2i64(<2 x i64>) nounwind readnone
declare <4 x i64> @llvm.bswap.v4i64(<4 x i64>) nounwind readnone

define amdgpu_kernel void @test_bswap_i32(i32 addrspace(1)* %out, i32 addrspace(1)* %in) nounwind {
; SI-LABEL: test_bswap_i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_load_dword s4, s[2:3], 0x0
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_alignbit_b32 v0, s4, s4, 8
; SI-NEXT:    v_alignbit_b32 v1, s4, s4, 24
; SI-NEXT:    s_mov_b32 s4, 0xff00ff
; SI-NEXT:    v_bfi_b32 v0, s4, v1, v0
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_bswap_i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_load_dword s4, s[6:7], 0x0
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_alignbit_b32 v0, s4, s4, 8
; VI-NEXT:    v_alignbit_b32 v1, s4, s4, 24
; VI-NEXT:    s_mov_b32 s4, 0xff00ff
; VI-NEXT:    v_bfi_b32 v0, s4, v1, v0
; VI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %val = load i32, i32 addrspace(1)* %in, align 4
  %bswap = call i32 @llvm.bswap.i32(i32 %val) nounwind readnone
  store i32 %bswap, i32 addrspace(1)* %out, align 4
  ret void
}

define amdgpu_kernel void @test_bswap_v2i32(<2 x i32> addrspace(1)* %out, <2 x i32> addrspace(1)* %in) nounwind {
; SI-LABEL: test_bswap_v2i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0x0
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_mov_b32 s6, 0xff00ff
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_alignbit_b32 v0, s5, s5, 8
; SI-NEXT:    v_alignbit_b32 v1, s5, s5, 24
; SI-NEXT:    v_alignbit_b32 v2, s4, s4, 8
; SI-NEXT:    v_alignbit_b32 v3, s4, s4, 24
; SI-NEXT:    v_bfi_b32 v1, s6, v1, v0
; SI-NEXT:    v_bfi_b32 v0, s6, v3, v2
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_bswap_v2i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s8, 0xff00ff
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_load_dwordx2 s[4:5], s[6:7], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_alignbit_b32 v0, s5, s5, 8
; VI-NEXT:    v_alignbit_b32 v1, s5, s5, 24
; VI-NEXT:    v_alignbit_b32 v2, s4, s4, 8
; VI-NEXT:    v_alignbit_b32 v3, s4, s4, 24
; VI-NEXT:    v_bfi_b32 v1, s8, v1, v0
; VI-NEXT:    v_bfi_b32 v0, s8, v3, v2
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %val = load <2 x i32>, <2 x i32> addrspace(1)* %in, align 8
  %bswap = call <2 x i32> @llvm.bswap.v2i32(<2 x i32> %val) nounwind readnone
  store <2 x i32> %bswap, <2 x i32> addrspace(1)* %out, align 8
  ret void
}

define amdgpu_kernel void @test_bswap_v4i32(<4 x i32> addrspace(1)* %out, <4 x i32> addrspace(1)* %in) nounwind {
; SI-LABEL: test_bswap_v4i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x0
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_mov_b32 s8, 0xff00ff
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_alignbit_b32 v0, s7, s7, 8
; SI-NEXT:    v_alignbit_b32 v1, s7, s7, 24
; SI-NEXT:    v_alignbit_b32 v2, s6, s6, 8
; SI-NEXT:    v_alignbit_b32 v4, s6, s6, 24
; SI-NEXT:    v_alignbit_b32 v5, s5, s5, 8
; SI-NEXT:    v_alignbit_b32 v6, s5, s5, 24
; SI-NEXT:    v_alignbit_b32 v7, s4, s4, 8
; SI-NEXT:    v_alignbit_b32 v8, s4, s4, 24
; SI-NEXT:    v_bfi_b32 v3, s8, v1, v0
; SI-NEXT:    v_bfi_b32 v2, s8, v4, v2
; SI-NEXT:    v_bfi_b32 v1, s8, v6, v5
; SI-NEXT:    v_bfi_b32 v0, s8, v8, v7
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_bswap_v4i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s8, 0xff00ff
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_load_dwordx4 s[4:7], s[6:7], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_alignbit_b32 v0, s7, s7, 8
; VI-NEXT:    v_alignbit_b32 v1, s7, s7, 24
; VI-NEXT:    v_bfi_b32 v3, s8, v1, v0
; VI-NEXT:    v_alignbit_b32 v2, s6, s6, 8
; VI-NEXT:    v_alignbit_b32 v4, s6, s6, 24
; VI-NEXT:    v_alignbit_b32 v0, s5, s5, 8
; VI-NEXT:    v_alignbit_b32 v1, s5, s5, 24
; VI-NEXT:    v_bfi_b32 v2, s8, v4, v2
; VI-NEXT:    v_bfi_b32 v1, s8, v1, v0
; VI-NEXT:    v_alignbit_b32 v0, s4, s4, 8
; VI-NEXT:    v_alignbit_b32 v4, s4, s4, 24
; VI-NEXT:    v_bfi_b32 v0, s8, v4, v0
; VI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %val = load <4 x i32>, <4 x i32> addrspace(1)* %in, align 16
  %bswap = call <4 x i32> @llvm.bswap.v4i32(<4 x i32> %val) nounwind readnone
  store <4 x i32> %bswap, <4 x i32> addrspace(1)* %out, align 16
  ret void
}

define amdgpu_kernel void @test_bswap_v8i32(<8 x i32> addrspace(1)* %out, <8 x i32> addrspace(1)* %in) nounwind {
; SI-LABEL: test_bswap_v8i32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[8:11], s[0:1], 0x9
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_load_dwordx8 s[0:7], s[10:11], 0x0
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_mov_b32 s10, -1
; SI-NEXT:    s_mov_b32 s12, 0xff00ff
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_alignbit_b32 v0, s3, s3, 8
; SI-NEXT:    v_alignbit_b32 v1, s3, s3, 24
; SI-NEXT:    v_alignbit_b32 v2, s2, s2, 8
; SI-NEXT:    v_alignbit_b32 v4, s2, s2, 24
; SI-NEXT:    v_alignbit_b32 v5, s1, s1, 8
; SI-NEXT:    v_alignbit_b32 v6, s1, s1, 24
; SI-NEXT:    v_alignbit_b32 v7, s0, s0, 8
; SI-NEXT:    v_alignbit_b32 v8, s0, s0, 24
; SI-NEXT:    v_alignbit_b32 v9, s7, s7, 8
; SI-NEXT:    v_alignbit_b32 v10, s7, s7, 24
; SI-NEXT:    v_alignbit_b32 v11, s6, s6, 8
; SI-NEXT:    v_alignbit_b32 v12, s6, s6, 24
; SI-NEXT:    v_alignbit_b32 v13, s5, s5, 8
; SI-NEXT:    v_alignbit_b32 v14, s5, s5, 24
; SI-NEXT:    v_alignbit_b32 v15, s4, s4, 8
; SI-NEXT:    v_alignbit_b32 v16, s4, s4, 24
; SI-NEXT:    v_bfi_b32 v3, s12, v1, v0
; SI-NEXT:    v_bfi_b32 v2, s12, v4, v2
; SI-NEXT:    v_bfi_b32 v1, s12, v6, v5
; SI-NEXT:    v_bfi_b32 v0, s12, v8, v7
; SI-NEXT:    v_bfi_b32 v7, s12, v10, v9
; SI-NEXT:    v_bfi_b32 v6, s12, v12, v11
; SI-NEXT:    v_bfi_b32 v5, s12, v14, v13
; SI-NEXT:    v_bfi_b32 v4, s12, v16, v15
; SI-NEXT:    buffer_store_dwordx4 v[4:7], off, s[8:11], 0 offset:16
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[8:11], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_bswap_v8i32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s12, 0xff00ff
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_load_dwordx8 s[4:11], s[6:7], 0x0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_alignbit_b32 v0, s7, s7, 8
; VI-NEXT:    v_alignbit_b32 v1, s7, s7, 24
; VI-NEXT:    v_bfi_b32 v3, s12, v1, v0
; VI-NEXT:    v_alignbit_b32 v2, s6, s6, 8
; VI-NEXT:    v_alignbit_b32 v4, s6, s6, 24
; VI-NEXT:    v_alignbit_b32 v0, s5, s5, 8
; VI-NEXT:    v_alignbit_b32 v1, s5, s5, 24
; VI-NEXT:    v_bfi_b32 v2, s12, v4, v2
; VI-NEXT:    v_bfi_b32 v1, s12, v1, v0
; VI-NEXT:    v_alignbit_b32 v0, s4, s4, 8
; VI-NEXT:    v_alignbit_b32 v4, s4, s4, 24
; VI-NEXT:    v_bfi_b32 v0, s12, v4, v0
; VI-NEXT:    v_alignbit_b32 v4, s11, s11, 8
; VI-NEXT:    v_alignbit_b32 v5, s11, s11, 24
; VI-NEXT:    v_bfi_b32 v7, s12, v5, v4
; VI-NEXT:    v_alignbit_b32 v4, s10, s10, 8
; VI-NEXT:    v_alignbit_b32 v5, s10, s10, 24
; VI-NEXT:    v_bfi_b32 v6, s12, v5, v4
; VI-NEXT:    v_alignbit_b32 v4, s9, s9, 8
; VI-NEXT:    v_alignbit_b32 v5, s9, s9, 24
; VI-NEXT:    v_bfi_b32 v5, s12, v5, v4
; VI-NEXT:    v_alignbit_b32 v4, s8, s8, 8
; VI-NEXT:    v_alignbit_b32 v8, s8, s8, 24
; VI-NEXT:    v_bfi_b32 v4, s12, v8, v4
; VI-NEXT:    buffer_store_dwordx4 v[4:7], off, s[0:3], 0 offset:16
; VI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %val = load <8 x i32>, <8 x i32> addrspace(1)* %in, align 32
  %bswap = call <8 x i32> @llvm.bswap.v8i32(<8 x i32> %val) nounwind readnone
  store <8 x i32> %bswap, <8 x i32> addrspace(1)* %out, align 32
  ret void
}

define amdgpu_kernel void @test_bswap_i64(i64 addrspace(1)* %out, i64 addrspace(1)* %in) nounwind {
; SI-LABEL: test_bswap_i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_load_dwordx2 s[6:7], s[6:7], 0x0
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_mov_b32 s19, 0xff0000
; SI-NEXT:    s_mov_b32 s9, 0
; SI-NEXT:    s_mov_b32 s15, 0xff00
; SI-NEXT:    s_mov_b32 s11, s9
; SI-NEXT:    s_mov_b32 s12, s9
; SI-NEXT:    s_mov_b32 s14, s9
; SI-NEXT:    s_mov_b32 s16, s9
; SI-NEXT:    s_mov_b32 s18, s9
; SI-NEXT:    s_mov_b32 s0, s4
; SI-NEXT:    s_mov_b32 s1, s5
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s6
; SI-NEXT:    v_alignbit_b32 v1, s7, v0, 24
; SI-NEXT:    v_alignbit_b32 v0, s7, v0, 8
; SI-NEXT:    s_lshr_b32 s8, s7, 24
; SI-NEXT:    s_lshr_b32 s10, s7, 8
; SI-NEXT:    s_lshl_b64 s[4:5], s[6:7], 8
; SI-NEXT:    s_lshl_b64 s[20:21], s[6:7], 24
; SI-NEXT:    s_lshl_b32 s17, s6, 24
; SI-NEXT:    s_lshl_b32 s4, s6, 8
; SI-NEXT:    v_and_b32_e32 v1, s19, v1
; SI-NEXT:    v_and_b32_e32 v0, 0xff000000, v0
; SI-NEXT:    s_and_b32 s10, s10, s15
; SI-NEXT:    s_and_b32 s13, s5, 0xff
; SI-NEXT:    s_and_b32 s15, s21, s15
; SI-NEXT:    s_and_b32 s19, s4, s19
; SI-NEXT:    v_or_b32_e32 v0, v0, v1
; SI-NEXT:    s_or_b64 s[4:5], s[10:11], s[8:9]
; SI-NEXT:    s_or_b64 s[6:7], s[14:15], s[12:13]
; SI-NEXT:    s_or_b64 s[8:9], s[16:17], s[18:19]
; SI-NEXT:    v_or_b32_e32 v0, s4, v0
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    s_or_b64 s[4:5], s[8:9], s[6:7]
; SI-NEXT:    v_or_b32_e32 v0, s4, v0
; SI-NEXT:    v_or_b32_e32 v1, s5, v1
; SI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_bswap_i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s12, 0xff0000
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_load_dwordx2 s[6:7], s[6:7], 0x0
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_mov_b32 s5, 0
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s9, s5
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s6
; VI-NEXT:    v_alignbit_b32 v1, s7, v0, 24
; VI-NEXT:    v_alignbit_b32 v0, s7, v0, 8
; VI-NEXT:    s_bfe_u32 s8, s7, 0x80010
; VI-NEXT:    v_and_b32_e32 v1, s12, v1
; VI-NEXT:    v_and_b32_e32 v0, 0xff000000, v0
; VI-NEXT:    s_lshr_b32 s4, s7, 24
; VI-NEXT:    s_lshl_b32 s8, s8, 8
; VI-NEXT:    s_or_b64 s[8:9], s[8:9], s[4:5]
; VI-NEXT:    v_or_b32_e32 v0, v0, v1
; VI-NEXT:    s_lshl_b64 s[10:11], s[6:7], 24
; VI-NEXT:    v_or_b32_e32 v0, s8, v0
; VI-NEXT:    v_mov_b32_e32 v1, s9
; VI-NEXT:    s_lshl_b64 s[8:9], s[6:7], 8
; VI-NEXT:    s_lshl_b32 s4, s6, 8
; VI-NEXT:    s_and_b32 s9, s9, 0xff
; VI-NEXT:    s_mov_b32 s8, s5
; VI-NEXT:    s_and_b32 s11, s11, 0xff00
; VI-NEXT:    s_mov_b32 s10, s5
; VI-NEXT:    s_or_b64 s[8:9], s[10:11], s[8:9]
; VI-NEXT:    s_lshl_b32 s11, s6, 24
; VI-NEXT:    s_and_b32 s7, s4, s12
; VI-NEXT:    s_mov_b32 s6, s5
; VI-NEXT:    s_or_b64 s[4:5], s[10:11], s[6:7]
; VI-NEXT:    s_or_b64 s[4:5], s[4:5], s[8:9]
; VI-NEXT:    v_or_b32_e32 v0, s4, v0
; VI-NEXT:    v_or_b32_e32 v1, s5, v1
; VI-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %val = load i64, i64 addrspace(1)* %in, align 8
  %bswap = call i64 @llvm.bswap.i64(i64 %val) nounwind readnone
  store i64 %bswap, i64 addrspace(1)* %out, align 8
  ret void
}

define amdgpu_kernel void @test_bswap_v2i64(<2 x i64> addrspace(1)* %out, <2 x i64> addrspace(1)* %in) nounwind {
; SI-LABEL: test_bswap_v2i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_mov_b32 s31, 0xff0000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_load_dwordx4 s[8:11], s[6:7], 0x0
; SI-NEXT:    s_mov_b32 s7, 0
; SI-NEXT:    s_mov_b32 s22, 0xff000000
; SI-NEXT:    s_mov_b32 s27, 0xff00
; SI-NEXT:    s_movk_i32 s25, 0xff
; SI-NEXT:    s_mov_b32 s13, s7
; SI-NEXT:    s_mov_b32 s14, s7
; SI-NEXT:    s_mov_b32 s16, s7
; SI-NEXT:    s_mov_b32 s18, s7
; SI-NEXT:    s_mov_b32 s20, s7
; SI-NEXT:    s_mov_b32 s23, s7
; SI-NEXT:    s_mov_b32 s24, s7
; SI-NEXT:    s_mov_b32 s26, s7
; SI-NEXT:    s_mov_b32 s28, s7
; SI-NEXT:    s_mov_b32 s30, s7
; SI-NEXT:    s_mov_b32 s0, s4
; SI-NEXT:    s_mov_b32 s1, s5
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s10
; SI-NEXT:    v_alignbit_b32 v1, s11, v0, 24
; SI-NEXT:    v_alignbit_b32 v0, s11, v0, 8
; SI-NEXT:    s_lshr_b32 s6, s11, 24
; SI-NEXT:    s_lshr_b32 s12, s11, 8
; SI-NEXT:    s_lshl_b64 s[4:5], s[10:11], 8
; SI-NEXT:    s_lshl_b64 s[32:33], s[10:11], 24
; SI-NEXT:    s_lshl_b32 s19, s10, 24
; SI-NEXT:    s_lshl_b32 s21, s10, 8
; SI-NEXT:    v_mov_b32_e32 v2, s8
; SI-NEXT:    v_alignbit_b32 v3, s9, v2, 24
; SI-NEXT:    v_alignbit_b32 v2, s9, v2, 8
; SI-NEXT:    s_lshr_b32 s32, s9, 8
; SI-NEXT:    s_lshl_b64 s[10:11], s[8:9], 8
; SI-NEXT:    s_and_b32 s15, s5, s25
; SI-NEXT:    s_lshl_b64 s[4:5], s[8:9], 24
; SI-NEXT:    s_lshl_b32 s29, s8, 24
; SI-NEXT:    s_lshl_b32 s4, s8, 8
; SI-NEXT:    v_and_b32_e32 v1, s31, v1
; SI-NEXT:    v_and_b32_e32 v0, s22, v0
; SI-NEXT:    s_and_b32 s12, s12, s27
; SI-NEXT:    s_and_b32 s17, s33, s27
; SI-NEXT:    s_and_b32 s21, s21, s31
; SI-NEXT:    v_and_b32_e32 v3, s31, v3
; SI-NEXT:    v_and_b32_e32 v2, s22, v2
; SI-NEXT:    s_and_b32 s22, s32, s27
; SI-NEXT:    s_and_b32 s25, s11, s25
; SI-NEXT:    s_and_b32 s27, s5, s27
; SI-NEXT:    s_and_b32 s31, s4, s31
; SI-NEXT:    v_or_b32_e32 v0, v0, v1
; SI-NEXT:    s_or_b64 s[4:5], s[12:13], s[6:7]
; SI-NEXT:    s_or_b64 s[10:11], s[16:17], s[14:15]
; SI-NEXT:    s_or_b64 s[12:13], s[18:19], s[20:21]
; SI-NEXT:    v_or_b32_e32 v1, v2, v3
; SI-NEXT:    s_lshr_b32 s6, s9, 24
; SI-NEXT:    s_or_b64 s[8:9], s[26:27], s[24:25]
; SI-NEXT:    s_or_b64 s[14:15], s[28:29], s[30:31]
; SI-NEXT:    v_or_b32_e32 v0, s4, v0
; SI-NEXT:    v_mov_b32_e32 v3, s5
; SI-NEXT:    s_or_b64 s[4:5], s[12:13], s[10:11]
; SI-NEXT:    s_or_b64 s[6:7], s[22:23], s[6:7]
; SI-NEXT:    s_or_b64 s[8:9], s[14:15], s[8:9]
; SI-NEXT:    v_or_b32_e32 v2, s4, v0
; SI-NEXT:    v_or_b32_e32 v3, s5, v3
; SI-NEXT:    v_or_b32_e32 v0, s6, v1
; SI-NEXT:    v_mov_b32_e32 v1, s7
; SI-NEXT:    v_or_b32_e32 v0, s8, v0
; SI-NEXT:    v_or_b32_e32 v1, s9, v1
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_bswap_v2i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s9, 0
; VI-NEXT:    s_mov_b32 s14, 0xff0000
; VI-NEXT:    s_mov_b32 s15, 0xff000000
; VI-NEXT:    s_mov_b32 s11, s9
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_load_dwordx4 s[4:7], s[6:7], 0x0
; VI-NEXT:    s_movk_i32 s16, 0xff
; VI-NEXT:    s_mov_b32 s17, 0xff00
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s6
; VI-NEXT:    v_alignbit_b32 v1, s7, v0, 24
; VI-NEXT:    v_alignbit_b32 v0, s7, v0, 8
; VI-NEXT:    s_bfe_u32 s10, s7, 0x80010
; VI-NEXT:    v_and_b32_e32 v1, s14, v1
; VI-NEXT:    v_and_b32_e32 v0, s15, v0
; VI-NEXT:    s_lshr_b32 s8, s7, 24
; VI-NEXT:    s_lshl_b32 s10, s10, 8
; VI-NEXT:    s_or_b64 s[10:11], s[10:11], s[8:9]
; VI-NEXT:    v_or_b32_e32 v0, v0, v1
; VI-NEXT:    s_lshl_b64 s[12:13], s[6:7], 24
; VI-NEXT:    v_or_b32_e32 v0, s10, v0
; VI-NEXT:    v_mov_b32_e32 v1, s11
; VI-NEXT:    s_lshl_b64 s[10:11], s[6:7], 8
; VI-NEXT:    s_and_b32 s11, s11, s16
; VI-NEXT:    s_mov_b32 s10, s9
; VI-NEXT:    s_and_b32 s13, s13, s17
; VI-NEXT:    s_mov_b32 s12, s9
; VI-NEXT:    s_or_b64 s[10:11], s[12:13], s[10:11]
; VI-NEXT:    s_lshl_b32 s13, s6, 24
; VI-NEXT:    s_lshl_b32 s6, s6, 8
; VI-NEXT:    s_and_b32 s7, s6, s14
; VI-NEXT:    s_mov_b32 s6, s9
; VI-NEXT:    s_or_b64 s[6:7], s[12:13], s[6:7]
; VI-NEXT:    s_or_b64 s[6:7], s[6:7], s[10:11]
; VI-NEXT:    v_or_b32_e32 v2, s6, v0
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    v_or_b32_e32 v3, s7, v1
; VI-NEXT:    v_alignbit_b32 v1, s5, v0, 24
; VI-NEXT:    v_alignbit_b32 v0, s5, v0, 8
; VI-NEXT:    s_bfe_u32 s6, s5, 0x80010
; VI-NEXT:    v_and_b32_e32 v1, s14, v1
; VI-NEXT:    v_and_b32_e32 v0, s15, v0
; VI-NEXT:    s_lshr_b32 s8, s5, 24
; VI-NEXT:    s_lshl_b32 s6, s6, 8
; VI-NEXT:    s_mov_b32 s7, s9
; VI-NEXT:    v_or_b32_e32 v0, v0, v1
; VI-NEXT:    s_or_b64 s[6:7], s[6:7], s[8:9]
; VI-NEXT:    s_lshl_b64 s[10:11], s[4:5], 24
; VI-NEXT:    v_or_b32_e32 v0, s6, v0
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    s_lshl_b64 s[6:7], s[4:5], 8
; VI-NEXT:    s_and_b32 s7, s7, s16
; VI-NEXT:    s_mov_b32 s6, s9
; VI-NEXT:    s_and_b32 s11, s11, s17
; VI-NEXT:    s_mov_b32 s10, s9
; VI-NEXT:    s_or_b64 s[6:7], s[10:11], s[6:7]
; VI-NEXT:    s_lshl_b32 s11, s4, 24
; VI-NEXT:    s_lshl_b32 s4, s4, 8
; VI-NEXT:    s_and_b32 s5, s4, s14
; VI-NEXT:    s_mov_b32 s4, s9
; VI-NEXT:    s_or_b64 s[4:5], s[10:11], s[4:5]
; VI-NEXT:    s_or_b64 s[4:5], s[4:5], s[6:7]
; VI-NEXT:    v_or_b32_e32 v0, s4, v0
; VI-NEXT:    v_or_b32_e32 v1, s5, v1
; VI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %val = load <2 x i64>, <2 x i64> addrspace(1)* %in, align 16
  %bswap = call <2 x i64> @llvm.bswap.v2i64(<2 x i64> %val) nounwind readnone
  store <2 x i64> %bswap, <2 x i64> addrspace(1)* %out, align 16
  ret void
}

define amdgpu_kernel void @test_bswap_v4i64(<4 x i64> addrspace(1)* %out, <4 x i64> addrspace(1)* %in) nounwind {
; SI-LABEL: test_bswap_v4i64:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[12:15], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_mov_b32 s31, 0xff0000
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_load_dwordx8 s[4:11], s[14:15], 0x0
; SI-NEXT:    s_mov_b32 s27, 0xff000000
; SI-NEXT:    s_mov_b32 s34, 0xff00
; SI-NEXT:    s_mov_b32 s14, 0
; SI-NEXT:    s_movk_i32 s36, 0xff
; SI-NEXT:    s_mov_b32 s16, s14
; SI-NEXT:    s_mov_b32 s18, s14
; SI-NEXT:    s_mov_b32 s20, s14
; SI-NEXT:    s_mov_b32 s22, s14
; SI-NEXT:    s_mov_b32 s24, s14
; SI-NEXT:    s_mov_b32 s26, s14
; SI-NEXT:    s_mov_b32 s28, s14
; SI-NEXT:    s_mov_b32 s30, s14
; SI-NEXT:    s_mov_b32 s0, s12
; SI-NEXT:    s_mov_b32 s1, s13
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s6
; SI-NEXT:    v_alignbit_b32 v1, s7, v0, 24
; SI-NEXT:    v_alignbit_b32 v0, s7, v0, 8
; SI-NEXT:    s_lshr_b32 s35, s7, 24
; SI-NEXT:    s_lshr_b32 s37, s7, 8
; SI-NEXT:    v_mov_b32_e32 v2, s4
; SI-NEXT:    v_alignbit_b32 v3, s5, v2, 24
; SI-NEXT:    v_alignbit_b32 v2, s5, v2, 8
; SI-NEXT:    s_lshr_b32 s38, s5, 24
; SI-NEXT:    s_lshr_b32 s39, s5, 8
; SI-NEXT:    s_lshl_b64 s[12:13], s[6:7], 8
; SI-NEXT:    s_lshl_b64 s[32:33], s[6:7], 24
; SI-NEXT:    s_lshl_b32 s7, s6, 8
; SI-NEXT:    s_and_b32 s15, s13, s36
; SI-NEXT:    s_lshl_b64 s[12:13], s[4:5], 8
; SI-NEXT:    s_and_b32 s17, s33, s34
; SI-NEXT:    s_lshl_b64 s[32:33], s[4:5], 24
; SI-NEXT:    s_lshl_b32 s5, s4, 8
; SI-NEXT:    v_mov_b32_e32 v4, s10
; SI-NEXT:    v_alignbit_b32 v5, s11, v4, 24
; SI-NEXT:    v_alignbit_b32 v4, s11, v4, 8
; SI-NEXT:    s_and_b32 s21, s33, s34
; SI-NEXT:    s_lshl_b64 s[32:33], s[10:11], 24
; SI-NEXT:    s_and_b32 s25, s33, s34
; SI-NEXT:    s_lshl_b64 s[32:33], s[8:9], 24
; SI-NEXT:    s_and_b32 s29, s33, s34
; SI-NEXT:    s_lshr_b32 s12, s11, 24
; SI-NEXT:    s_lshr_b32 s40, s11, 8
; SI-NEXT:    v_mov_b32_e32 v6, s8
; SI-NEXT:    v_alignbit_b32 v7, s9, v6, 24
; SI-NEXT:    v_alignbit_b32 v6, s9, v6, 8
; SI-NEXT:    s_and_b32 s19, s7, s31
; SI-NEXT:    s_lshr_b32 s7, s9, 24
; SI-NEXT:    s_and_b32 s23, s5, s31
; SI-NEXT:    s_lshr_b32 s5, s9, 8
; SI-NEXT:    v_and_b32_e32 v0, s27, v0
; SI-NEXT:    v_and_b32_e32 v2, s27, v2
; SI-NEXT:    v_and_b32_e32 v4, s27, v4
; SI-NEXT:    v_and_b32_e32 v6, s27, v6
; SI-NEXT:    s_lshl_b32 s27, s10, 8
; SI-NEXT:    s_and_b32 s27, s27, s31
; SI-NEXT:    s_lshl_b32 s32, s8, 8
; SI-NEXT:    v_and_b32_e32 v1, s31, v1
; SI-NEXT:    v_and_b32_e32 v3, s31, v3
; SI-NEXT:    v_and_b32_e32 v5, s31, v5
; SI-NEXT:    v_and_b32_e32 v7, s31, v7
; SI-NEXT:    s_and_b32 s31, s32, s31
; SI-NEXT:    s_lshl_b64 s[32:33], s[10:11], 8
; SI-NEXT:    s_and_b32 s11, s37, s34
; SI-NEXT:    s_and_b32 s32, s39, s34
; SI-NEXT:    s_and_b32 s37, s40, s34
; SI-NEXT:    s_and_b32 s5, s5, s34
; SI-NEXT:    s_or_b32 s11, s11, s35
; SI-NEXT:    s_lshl_b64 s[34:35], s[8:9], 8
; SI-NEXT:    v_or_b32_e32 v0, v0, v1
; SI-NEXT:    v_or_b32_e32 v1, v2, v3
; SI-NEXT:    s_or_b32 s9, s32, s38
; SI-NEXT:    s_or_b64 s[16:17], s[16:17], s[14:15]
; SI-NEXT:    s_lshl_b32 s15, s6, 24
; SI-NEXT:    v_or_b32_e32 v3, v4, v5
; SI-NEXT:    s_or_b32 s12, s37, s12
; SI-NEXT:    v_or_b32_e32 v4, v6, v7
; SI-NEXT:    s_or_b32 s32, s5, s7
; SI-NEXT:    v_or_b32_e32 v2, s11, v0
; SI-NEXT:    v_or_b32_e32 v0, s9, v1
; SI-NEXT:    s_or_b64 s[6:7], s[14:15], s[18:19]
; SI-NEXT:    s_and_b32 s15, s13, s36
; SI-NEXT:    v_or_b32_e32 v6, s12, v3
; SI-NEXT:    s_or_b64 s[6:7], s[6:7], s[16:17]
; SI-NEXT:    s_or_b64 s[12:13], s[20:21], s[14:15]
; SI-NEXT:    s_lshl_b32 s15, s4, 24
; SI-NEXT:    s_or_b64 s[4:5], s[14:15], s[22:23]
; SI-NEXT:    s_and_b32 s15, s33, s36
; SI-NEXT:    s_or_b64 s[4:5], s[4:5], s[12:13]
; SI-NEXT:    s_or_b64 s[12:13], s[24:25], s[14:15]
; SI-NEXT:    s_lshl_b32 s15, s10, 24
; SI-NEXT:    s_or_b64 s[10:11], s[14:15], s[26:27]
; SI-NEXT:    s_and_b32 s15, s35, s36
; SI-NEXT:    s_or_b64 s[10:11], s[10:11], s[12:13]
; SI-NEXT:    s_or_b64 s[12:13], s[28:29], s[14:15]
; SI-NEXT:    s_lshl_b32 s15, s8, 24
; SI-NEXT:    s_or_b64 s[8:9], s[14:15], s[30:31]
; SI-NEXT:    s_or_b64 s[8:9], s[8:9], s[12:13]
; SI-NEXT:    v_or_b32_e32 v4, s32, v4
; SI-NEXT:    v_mov_b32_e32 v3, s7
; SI-NEXT:    v_mov_b32_e32 v1, s5
; SI-NEXT:    v_mov_b32_e32 v7, s11
; SI-NEXT:    v_mov_b32_e32 v5, s9
; SI-NEXT:    buffer_store_dwordx4 v[4:7], off, s[0:3], 0 offset:16
; SI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: test_bswap_v4i64:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_mov_b32 s16, 0xff0000
; VI-NEXT:    s_mov_b32 s17, 0xff000000
; VI-NEXT:    s_movk_i32 s18, 0xff
; VI-NEXT:    s_mov_b32 s19, 0xff00
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    s_mov_b32 s0, s4
; VI-NEXT:    s_mov_b32 s1, s5
; VI-NEXT:    s_load_dwordx8 s[4:11], s[6:7], 0x0
; VI-NEXT:    s_mov_b32 s3, 0xf000
; VI-NEXT:    s_mov_b32 s2, -1
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s6
; VI-NEXT:    v_alignbit_b32 v1, s7, v0, 24
; VI-NEXT:    v_alignbit_b32 v0, s7, v0, 8
; VI-NEXT:    s_bfe_u32 s13, s7, 0x80010
; VI-NEXT:    v_and_b32_e32 v1, s16, v1
; VI-NEXT:    v_and_b32_e32 v0, s17, v0
; VI-NEXT:    s_lshr_b32 s12, s7, 24
; VI-NEXT:    s_lshl_b32 s13, s13, 8
; VI-NEXT:    s_or_b32 s12, s13, s12
; VI-NEXT:    v_or_b32_e32 v0, v0, v1
; VI-NEXT:    v_or_b32_e32 v2, s12, v0
; VI-NEXT:    v_mov_b32_e32 v0, s4
; VI-NEXT:    v_alignbit_b32 v1, s5, v0, 24
; VI-NEXT:    v_alignbit_b32 v0, s5, v0, 8
; VI-NEXT:    s_bfe_u32 s13, s5, 0x80010
; VI-NEXT:    v_and_b32_e32 v1, s16, v1
; VI-NEXT:    v_and_b32_e32 v0, s17, v0
; VI-NEXT:    s_lshr_b32 s12, s5, 24
; VI-NEXT:    s_lshl_b32 s13, s13, 8
; VI-NEXT:    v_or_b32_e32 v0, v0, v1
; VI-NEXT:    s_or_b32 s12, s13, s12
; VI-NEXT:    v_or_b32_e32 v0, s12, v0
; VI-NEXT:    s_lshl_b64 s[12:13], s[6:7], 8
; VI-NEXT:    s_lshl_b64 s[14:15], s[6:7], 24
; VI-NEXT:    s_mov_b32 s12, 0
; VI-NEXT:    s_and_b32 s13, s13, s18
; VI-NEXT:    s_and_b32 s15, s15, s19
; VI-NEXT:    s_mov_b32 s14, s12
; VI-NEXT:    s_or_b64 s[14:15], s[14:15], s[12:13]
; VI-NEXT:    s_lshl_b32 s13, s6, 24
; VI-NEXT:    s_lshl_b32 s6, s6, 8
; VI-NEXT:    s_and_b32 s7, s6, s16
; VI-NEXT:    s_mov_b32 s6, s12
; VI-NEXT:    s_or_b64 s[6:7], s[12:13], s[6:7]
; VI-NEXT:    s_or_b64 s[6:7], s[6:7], s[14:15]
; VI-NEXT:    s_lshl_b64 s[14:15], s[4:5], 8
; VI-NEXT:    s_and_b32 s13, s15, s18
; VI-NEXT:    s_lshl_b64 s[14:15], s[4:5], 24
; VI-NEXT:    s_and_b32 s15, s15, s19
; VI-NEXT:    s_mov_b32 s14, s12
; VI-NEXT:    s_or_b64 s[14:15], s[14:15], s[12:13]
; VI-NEXT:    s_lshl_b32 s13, s4, 24
; VI-NEXT:    s_lshl_b32 s4, s4, 8
; VI-NEXT:    s_and_b32 s5, s4, s16
; VI-NEXT:    s_mov_b32 s4, s12
; VI-NEXT:    s_or_b64 s[4:5], s[12:13], s[4:5]
; VI-NEXT:    v_mov_b32_e32 v1, s10
; VI-NEXT:    v_alignbit_b32 v3, s11, v1, 24
; VI-NEXT:    s_or_b64 s[4:5], s[4:5], s[14:15]
; VI-NEXT:    v_alignbit_b32 v1, s11, v1, 8
; VI-NEXT:    s_bfe_u32 s6, s11, 0x80010
; VI-NEXT:    v_and_b32_e32 v3, s16, v3
; VI-NEXT:    v_and_b32_e32 v1, s17, v1
; VI-NEXT:    s_lshr_b32 s4, s11, 24
; VI-NEXT:    s_lshl_b32 s6, s6, 8
; VI-NEXT:    s_or_b32 s4, s6, s4
; VI-NEXT:    v_or_b32_e32 v1, v1, v3
; VI-NEXT:    v_or_b32_e32 v6, s4, v1
; VI-NEXT:    v_mov_b32_e32 v1, s8
; VI-NEXT:    v_alignbit_b32 v3, s9, v1, 24
; VI-NEXT:    v_alignbit_b32 v1, s9, v1, 8
; VI-NEXT:    s_bfe_u32 s6, s9, 0x80010
; VI-NEXT:    s_lshl_b64 s[14:15], s[10:11], 8
; VI-NEXT:    v_and_b32_e32 v3, s16, v3
; VI-NEXT:    v_and_b32_e32 v1, s17, v1
; VI-NEXT:    s_lshr_b32 s4, s9, 24
; VI-NEXT:    s_lshl_b32 s6, s6, 8
; VI-NEXT:    v_or_b32_e32 v1, v1, v3
; VI-NEXT:    s_or_b32 s4, s6, s4
; VI-NEXT:    s_and_b32 s13, s15, s18
; VI-NEXT:    s_lshl_b64 s[14:15], s[10:11], 24
; VI-NEXT:    v_or_b32_e32 v4, s4, v1
; VI-NEXT:    s_lshl_b32 s4, s10, 8
; VI-NEXT:    s_and_b32 s15, s15, s19
; VI-NEXT:    s_mov_b32 s14, s12
; VI-NEXT:    s_or_b64 s[14:15], s[14:15], s[12:13]
; VI-NEXT:    s_lshl_b32 s13, s10, 24
; VI-NEXT:    s_and_b32 s11, s4, s16
; VI-NEXT:    s_mov_b32 s10, s12
; VI-NEXT:    s_or_b64 s[10:11], s[12:13], s[10:11]
; VI-NEXT:    s_or_b64 s[10:11], s[10:11], s[14:15]
; VI-NEXT:    s_lshl_b64 s[14:15], s[8:9], 8
; VI-NEXT:    s_and_b32 s13, s15, s18
; VI-NEXT:    s_lshl_b64 s[14:15], s[8:9], 24
; VI-NEXT:    s_lshl_b32 s4, s8, 8
; VI-NEXT:    s_and_b32 s15, s15, s19
; VI-NEXT:    s_mov_b32 s14, s12
; VI-NEXT:    s_or_b64 s[14:15], s[14:15], s[12:13]
; VI-NEXT:    s_lshl_b32 s13, s8, 24
; VI-NEXT:    s_and_b32 s9, s4, s16
; VI-NEXT:    s_mov_b32 s8, s12
; VI-NEXT:    s_or_b64 s[8:9], s[12:13], s[8:9]
; VI-NEXT:    s_or_b64 s[8:9], s[8:9], s[14:15]
; VI-NEXT:    v_mov_b32_e32 v5, s9
; VI-NEXT:    v_mov_b32_e32 v7, s11
; VI-NEXT:    v_mov_b32_e32 v1, s5
; VI-NEXT:    v_mov_b32_e32 v3, s7
; VI-NEXT:    buffer_store_dwordx4 v[4:7], off, s[0:3], 0 offset:16
; VI-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; VI-NEXT:    s_endpgm
  %val = load <4 x i64>, <4 x i64> addrspace(1)* %in, align 32
  %bswap = call <4 x i64> @llvm.bswap.v4i64(<4 x i64> %val) nounwind readnone
  store <4 x i64> %bswap, <4 x i64> addrspace(1)* %out, align 32
  ret void
}

define float @missing_truncate_promote_bswap(i32 %arg) {
; SI-LABEL: missing_truncate_promote_bswap:
; SI:       ; %bb.0: ; %bb
; SI-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; SI-NEXT:    v_alignbit_b32 v1, v0, v0, 8
; SI-NEXT:    v_alignbit_b32 v0, v0, v0, 24
; SI-NEXT:    s_mov_b32 s4, 0xff00ff
; SI-NEXT:    v_bfi_b32 v0, s4, v0, v1
; SI-NEXT:    v_lshrrev_b32_e32 v0, 16, v0
; SI-NEXT:    v_cvt_f32_f16_e32 v0, v0
; SI-NEXT:    s_setpc_b64 s[30:31]
;
; VI-LABEL: missing_truncate_promote_bswap:
; VI:       ; %bb.0: ; %bb
; VI-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; VI-NEXT:    v_alignbit_b32 v1, v0, v0, 8
; VI-NEXT:    v_alignbit_b32 v0, v0, v0, 24
; VI-NEXT:    s_mov_b32 s4, 0xff00ff
; VI-NEXT:    v_bfi_b32 v0, s4, v0, v1
; VI-NEXT:    v_cvt_f32_f16_sdwa v0, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:WORD_1
; VI-NEXT:    s_setpc_b64 s[30:31]
bb:
  %tmp = trunc i32 %arg to i16
  %tmp1 = call i16 @llvm.bswap.i16(i16 %tmp)
  %tmp2 = bitcast i16 %tmp1 to half
  %tmp3 = fpext half %tmp2 to float
  ret float %tmp3
}
