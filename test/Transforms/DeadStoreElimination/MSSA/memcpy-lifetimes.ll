; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -basic-aa -dse -S | FileCheck %s
; RUN: opt < %s -aa-pipeline=basic-aa -passes=dse -S | FileCheck %s

target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

%struct.Village = type { [4 x %struct.Village*], %struct.Village*, %struct.List, %struct.Hosp, i32, i64 }
%struct.List = type { %struct.List*, %struct.Patient*, %struct.List* }
%struct.Patient = type { i32, i32, i32, %struct.Village* }
%struct.Hosp = type { i32, i32, i32, %struct.List, %struct.List, %struct.List, %struct.List }

declare %struct.Village* @alloc(%struct.Village*)

define i8* @alloc_tree() {
; CHECK-LABEL: @alloc_tree(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[FVAL:%.*]] = alloca [4 x %struct.Village*], align 16
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast [4 x %struct.Village*]* [[FVAL]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull [[TMP0]])
; CHECK-NEXT:    [[CALL:%.*]] = tail call dereferenceable_or_null(192) i8* @malloc(i64 192)
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[CALL]] to %struct.Village*
; CHECK-NEXT:    [[CALL3:%.*]] = tail call %struct.Village* @alloc(%struct.Village* [[TMP1]])
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [4 x %struct.Village*], [4 x %struct.Village*]* [[FVAL]], i64 0, i64 3
; CHECK-NEXT:    store %struct.Village* [[CALL3]], %struct.Village** [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[CALL3_1:%.*]] = tail call %struct.Village* @alloc(%struct.Village* [[TMP1]])
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds [4 x %struct.Village*], [4 x %struct.Village*]* [[FVAL]], i64 0, i64 2
; CHECK-NEXT:    store %struct.Village* [[CALL3_1]], %struct.Village** [[ARRAYIDX_1]], align 16
; CHECK-NEXT:    [[CALL3_2:%.*]] = tail call %struct.Village* @alloc(%struct.Village* [[TMP1]])
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds [4 x %struct.Village*], [4 x %struct.Village*]* [[FVAL]], i64 0, i64 1
; CHECK-NEXT:    store %struct.Village* [[CALL3_2]], %struct.Village** [[ARRAYIDX_2]], align 8
; CHECK-NEXT:    [[CALL3_3:%.*]] = tail call %struct.Village* @alloc(%struct.Village* [[TMP1]])
; CHECK-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds [4 x %struct.Village*], [4 x %struct.Village*]* [[FVAL]], i64 0, i64 0
; CHECK-NEXT:    store %struct.Village* [[CALL3_3]], %struct.Village** [[ARRAYIDX_3]], align 16
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(32) [[CALL]], i8* nonnull align 16 dereferenceable(32) [[TMP0]], i64 32, i1 false)
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull [[TMP0]])
; CHECK-NEXT:    ret i8* [[CALL]]
;
entry:
  %fval = alloca [4 x %struct.Village*], align 16
  %0 = bitcast [4 x %struct.Village*]* %fval to i8*
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %0) #7
  %call = tail call dereferenceable_or_null(192) i8* @malloc(i64 192) #8
  %1 = bitcast i8* %call to %struct.Village*
  %call3 = tail call %struct.Village* @alloc(%struct.Village* %1)
  %arrayidx = getelementptr inbounds [4 x %struct.Village*], [4 x %struct.Village*]* %fval, i64 0, i64 3
  store %struct.Village* %call3, %struct.Village** %arrayidx, align 8
  %call3.1 = tail call %struct.Village* @alloc(%struct.Village* %1)
  %arrayidx.1 = getelementptr inbounds [4 x %struct.Village*], [4 x %struct.Village*]* %fval, i64 0, i64 2
  store %struct.Village* %call3.1, %struct.Village** %arrayidx.1, align 16
  %call3.2 = tail call %struct.Village* @alloc(%struct.Village* %1)
  %arrayidx.2 = getelementptr inbounds [4 x %struct.Village*], [4 x %struct.Village*]* %fval, i64 0, i64 1
  store %struct.Village* %call3.2, %struct.Village** %arrayidx.2, align 8
  %call3.3 = tail call %struct.Village* @alloc(%struct.Village* %1)
  %arrayidx.3 = getelementptr inbounds [4 x %struct.Village*], [4 x %struct.Village*]* %fval, i64 0, i64 0
  store %struct.Village* %call3.3, %struct.Village** %arrayidx.3, align 16
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(32) %call, i8* nonnull align 16 dereferenceable(32) %0, i64 32, i1 false)
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %0) #7
  ret i8* %call
}

declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture)
declare noalias i8* @malloc(i64)
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture)
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg)
