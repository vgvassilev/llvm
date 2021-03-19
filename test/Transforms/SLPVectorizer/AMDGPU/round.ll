; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=hawaii -slp-vectorizer %s | FileCheck -check-prefixes=GCN,GFX7 %s
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=fiji -slp-vectorizer %s | FileCheck -check-prefixes=GCN,GFX8 %s
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=gfx900 -slp-vectorizer %s | FileCheck -check-prefixes=GCN,GFX8 %s

define <2 x half> @round_v2f16(<2 x half> %arg) {
; GFX7-LABEL: @round_v2f16(
; GFX7-NEXT:  bb:
; GFX7-NEXT:    [[T:%.*]] = extractelement <2 x half> [[ARG:%.*]], i64 0
; GFX7-NEXT:    [[T1:%.*]] = tail call half @llvm.round.f16(half [[T]])
; GFX7-NEXT:    [[T2:%.*]] = insertelement <2 x half> undef, half [[T1]], i64 0
; GFX7-NEXT:    [[T3:%.*]] = extractelement <2 x half> [[ARG]], i64 1
; GFX7-NEXT:    [[T4:%.*]] = tail call half @llvm.round.f16(half [[T3]])
; GFX7-NEXT:    [[T5:%.*]] = insertelement <2 x half> [[T2]], half [[T4]], i64 1
; GFX7-NEXT:    ret <2 x half> [[T5]]
;
; GFX8-LABEL: @round_v2f16(
; GFX8-NEXT:  bb:
; GFX8-NEXT:    [[TMP0:%.*]] = call <2 x half> @llvm.round.v2f16(<2 x half> [[ARG:%.*]])
; GFX8-NEXT:    [[TMP1:%.*]] = extractelement <2 x half> [[TMP0]], i32 0
; GFX8-NEXT:    [[T2:%.*]] = insertelement <2 x half> undef, half [[TMP1]], i64 0
; GFX8-NEXT:    [[TMP2:%.*]] = extractelement <2 x half> [[TMP0]], i32 1
; GFX8-NEXT:    [[T5:%.*]] = insertelement <2 x half> [[T2]], half [[TMP2]], i64 1
; GFX8-NEXT:    ret <2 x half> [[T5]]
;
bb:
  %t = extractelement <2 x half> %arg, i64 0
  %t1 = tail call half @llvm.round.half(half %t)
  %t2 = insertelement <2 x half> undef, half %t1, i64 0
  %t3 = extractelement <2 x half> %arg, i64 1
  %t4 = tail call half @llvm.round.half(half %t3)
  %t5 = insertelement <2 x half> %t2, half %t4, i64 1
  ret <2 x half> %t5
}


define <2 x float> @round_v2f32(<2 x float> %arg) {
; GCN-LABEL: @round_v2f32(
; GCN-NEXT:  bb:
; GCN-NEXT:    [[T:%.*]] = extractelement <2 x float> [[ARG:%.*]], i64 0
; GCN-NEXT:    [[T1:%.*]] = tail call float @llvm.round.f32(float [[T]])
; GCN-NEXT:    [[T2:%.*]] = insertelement <2 x float> undef, float [[T1]], i64 0
; GCN-NEXT:    [[T3:%.*]] = extractelement <2 x float> [[ARG]], i64 1
; GCN-NEXT:    [[T4:%.*]] = tail call float @llvm.round.f32(float [[T3]])
; GCN-NEXT:    [[T5:%.*]] = insertelement <2 x float> [[T2]], float [[T4]], i64 1
; GCN-NEXT:    ret <2 x float> [[T5]]
;
bb:
  %t = extractelement <2 x float> %arg, i64 0
  %t1 = tail call float @llvm.round.f32(float %t)
  %t2 = insertelement <2 x float> undef, float %t1, i64 0
  %t3 = extractelement <2 x float> %arg, i64 1
  %t4 = tail call float @llvm.round.f32(float %t3)
  %t5 = insertelement <2 x float> %t2, float %t4, i64 1
  ret <2 x float> %t5
}

declare half @llvm.round.half(half) #0
declare float @llvm.round.f32(float) #0

attributes #0 = { nounwind readnone speculatable willreturn }
