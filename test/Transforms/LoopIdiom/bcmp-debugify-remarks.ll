; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -debugify -loop-idiom < %s -S 2>&1 | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"

; Check that everything still works when debuginfo is present, and that it is reasonably propagated.

; #include <algorithm>
;
; bool index_iteration_eq_variable_size_no_overlap(char const* ptr, size_t count) {
;   char const* ptr0 = ptr;
;   char const* ptr1 = ptr + count;
;   for(size_t i = 0; i < count; i++) {
;     if(ptr0[i] != ptr1[i])
;       return false;
;   }
;   return true;
; }
;
; void sink(bool);
; void loop_within_loop(size_t outer_count, char const** ptr0, char const** ptr1, size_t* count) {
;   for(size_t i = 0; i != outer_count; ++i)
;     sink(std::equal(ptr0[i], ptr0[i] + count[i], ptr1[i]));
; }

define i1 @_Z43index_iteration_eq_variable_size_no_overlapPKcm(i8* nocapture %ptr, i64 %count) {
; CHECK-LABEL: @_Z43index_iteration_eq_variable_size_no_overlapPKcm(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i8, i8* [[PTR:%.*]], i64 [[COUNT:%.*]], !dbg !22
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[ADD_PTR]], metadata !9, metadata !DIExpression()), !dbg !22
; CHECK-NEXT:    [[CMP14:%.*]] = icmp eq i64 [[COUNT]], 0, !dbg !23
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i1 [[CMP14]], metadata !11, metadata !DIExpression()), !dbg !23
; CHECK-NEXT:    br i1 [[CMP14]], label [[CLEANUP:%.*]], label [[FOR_BODY_PREHEADER:%.*]], !dbg !24
; CHECK:       for.body.preheader:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]], !dbg !25
; CHECK:       for.cond:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[INC:%.*]], [[COUNT]], !dbg !26
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i1 [[CMP]], metadata !13, metadata !DIExpression()), !dbg !26
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[CLEANUP_LOOPEXIT:%.*]], !dbg !27
; CHECK:       for.body:
; CHECK-NEXT:    [[I_015:%.*]] = phi i64 [ [[INC]], [[FOR_COND:%.*]] ], [ 0, [[FOR_BODY_PREHEADER]] ], !dbg !28
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i64 [[I_015]], metadata !14, metadata !DIExpression()), !dbg !28
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i8, i8* [[PTR]], i64 [[I_015]], !dbg !25
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[ARRAYIDX]], metadata !15, metadata !DIExpression()), !dbg !25
; CHECK-NEXT:    [[V0:%.*]] = load i8, i8* [[ARRAYIDX]], !dbg !29
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8 [[V0]], metadata !16, metadata !DIExpression()), !dbg !29
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i8, i8* [[ADD_PTR]], i64 [[I_015]], !dbg !30
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[ARRAYIDX1]], metadata !17, metadata !DIExpression()), !dbg !30
; CHECK-NEXT:    [[V1:%.*]] = load i8, i8* [[ARRAYIDX1]], !dbg !31
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8 [[V1]], metadata !18, metadata !DIExpression()), !dbg !31
; CHECK-NEXT:    [[CMP3:%.*]] = icmp eq i8 [[V0]], [[V1]], !dbg !32
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i1 [[CMP3]], metadata !19, metadata !DIExpression()), !dbg !32
; CHECK-NEXT:    [[INC]] = add nuw i64 [[I_015]], 1, !dbg !33
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i64 [[INC]], metadata !20, metadata !DIExpression()), !dbg !33
; CHECK-NEXT:    br i1 [[CMP3]], label [[FOR_COND]], label [[CLEANUP_LOOPEXIT]], !dbg !34
; CHECK:       cleanup.loopexit:
; CHECK-NEXT:    [[RES_PH:%.*]] = phi i1 [ false, [[FOR_BODY]] ], [ true, [[FOR_COND]] ]
; CHECK-NEXT:    br label [[CLEANUP]], !dbg !35
; CHECK:       cleanup:
; CHECK-NEXT:    [[RES:%.*]] = phi i1 [ true, [[ENTRY:%.*]] ], [ [[RES_PH]], [[CLEANUP_LOOPEXIT]] ], !dbg !36
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i1 [[RES]], metadata !21, metadata !DIExpression()), !dbg !36
; CHECK-NEXT:    ret i1 [[RES]], !dbg !35
;
entry:
  %add.ptr = getelementptr inbounds i8, i8* %ptr, i64 %count
  %cmp14 = icmp eq i64 %count, 0
  br i1 %cmp14, label %cleanup, label %for.body

for.cond:                                         ; preds = %for.body
  %cmp = icmp ult i64 %inc, %count
  br i1 %cmp, label %for.body, label %cleanup

for.body:                                         ; preds = %entry, %for.cond
  %i.015 = phi i64 [ %inc, %for.cond ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i8, i8* %ptr, i64 %i.015
  %v0 = load i8, i8* %arrayidx
  %arrayidx1 = getelementptr inbounds i8, i8* %add.ptr, i64 %i.015
  %v1 = load i8, i8* %arrayidx1
  %cmp3 = icmp eq i8 %v0, %v1
  %inc = add nuw i64 %i.015, 1
  br i1 %cmp3, label %for.cond, label %cleanup

cleanup:                                          ; preds = %for.body, %for.cond, %entry
  %res = phi i1 [ true, %entry ], [ true, %for.cond ], [ false, %for.body ]
  ret i1 %res
}

define void @_Z16loop_within_loopmPPKcS1_Pm(i64 %outer_count, i8** %ptr0, i8** %ptr1, i64* %count) {
; CHECK-LABEL: @_Z16loop_within_loopmPPKcS1_Pm(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP11:%.*]] = icmp eq i64 [[OUTER_COUNT:%.*]], 0, !dbg !60
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i1 [[CMP11]], metadata !39, metadata !DIExpression()), !dbg !60
; CHECK-NEXT:    br i1 [[CMP11]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY_PREHEADER:%.*]], !dbg !61
; CHECK:       for.body.preheader:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]], !dbg !62
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]], !dbg !63
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void, !dbg !63
; CHECK:       for.body:
; CHECK-NEXT:    [[I_012:%.*]] = phi i64 [ [[INC:%.*]], [[_ZNST3__15EQUALIPKCS2_EEBT_S3_T0__EXIT:%.*]] ], [ 0, [[FOR_BODY_PREHEADER]] ], !dbg !64
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i64 [[I_012]], metadata !40, metadata !DIExpression()), !dbg !64
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i8*, i8** [[PTR0:%.*]], i64 [[I_012]], !dbg !62
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8** [[ARRAYIDX]], metadata !41, metadata !DIExpression()), !dbg !62
; CHECK-NEXT:    [[T0:%.*]] = load i8*, i8** [[ARRAYIDX]], !dbg !65
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[T0]], metadata !42, metadata !DIExpression()), !dbg !65
; CHECK-NEXT:    [[ARRAYIDX2:%.*]] = getelementptr inbounds i64, i64* [[COUNT:%.*]], i64 [[I_012]], !dbg !66
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i64* [[ARRAYIDX2]], metadata !43, metadata !DIExpression()), !dbg !66
; CHECK-NEXT:    [[T1:%.*]] = load i64, i64* [[ARRAYIDX2]], !dbg !67
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i64 [[T1]], metadata !44, metadata !DIExpression()), !dbg !67
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i8, i8* [[T0]], i64 [[T1]], !dbg !68
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[ADD_PTR]], metadata !45, metadata !DIExpression()), !dbg !68
; CHECK-NEXT:    [[CMP5_I_I:%.*]] = icmp eq i64 [[T1]], 0, !dbg !69
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i1 [[CMP5_I_I]], metadata !46, metadata !DIExpression()), !dbg !69
; CHECK-NEXT:    br i1 [[CMP5_I_I]], label [[_ZNST3__15EQUALIPKCS2_EEBT_S3_T0__EXIT]], label [[FOR_BODY_I_I_PREHEADER:%.*]], !dbg !70
; CHECK:       for.body.i.i.preheader:
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds i8*, i8** [[PTR1:%.*]], i64 [[I_012]], !dbg !71
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8** [[ARRAYIDX3]], metadata !47, metadata !DIExpression()), !dbg !71
; CHECK-NEXT:    [[T2:%.*]] = load i8*, i8** [[ARRAYIDX3]], !dbg !72
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[T2]], metadata !48, metadata !DIExpression()), !dbg !72
; CHECK-NEXT:    br label [[FOR_BODY_I_I:%.*]], !dbg !73
; CHECK:       for.body.i.i:
; CHECK-NEXT:    [[__FIRST2_ADDR_07_I_I:%.*]] = phi i8* [ [[INCDEC_PTR1_I_I:%.*]], [[FOR_INC_I_I:%.*]] ], [ [[T2]], [[FOR_BODY_I_I_PREHEADER]] ], !dbg !74
; CHECK-NEXT:    [[__FIRST1_ADDR_06_I_I:%.*]] = phi i8* [ [[INCDEC_PTR_I_I:%.*]], [[FOR_INC_I_I]] ], [ [[T0]], [[FOR_BODY_I_I_PREHEADER]] ], !dbg !75
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[__FIRST2_ADDR_07_I_I]], metadata !49, metadata !DIExpression()), !dbg !74
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[__FIRST1_ADDR_06_I_I]], metadata !50, metadata !DIExpression()), !dbg !75
; CHECK-NEXT:    [[T3:%.*]] = load i8, i8* [[__FIRST1_ADDR_06_I_I]], !dbg !76
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8 [[T3]], metadata !51, metadata !DIExpression()), !dbg !76
; CHECK-NEXT:    [[T4:%.*]] = load i8, i8* [[__FIRST2_ADDR_07_I_I]], !dbg !77
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8 [[T4]], metadata !52, metadata !DIExpression()), !dbg !77
; CHECK-NEXT:    [[CMP_I_I_I:%.*]] = icmp eq i8 [[T3]], [[T4]], !dbg !78
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i1 [[CMP_I_I_I]], metadata !53, metadata !DIExpression()), !dbg !78
; CHECK-NEXT:    br i1 [[CMP_I_I_I]], label [[FOR_INC_I_I]], label [[_ZNST3__15EQUALIPKCS2_EEBT_S3_T0__EXIT_LOOPEXIT:%.*]], !dbg !79
; CHECK:       for.inc.i.i:
; CHECK-NEXT:    [[INCDEC_PTR_I_I]] = getelementptr inbounds i8, i8* [[__FIRST1_ADDR_06_I_I]], i64 1, !dbg !80
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[INCDEC_PTR_I_I]], metadata !54, metadata !DIExpression()), !dbg !80
; CHECK-NEXT:    [[INCDEC_PTR1_I_I]] = getelementptr inbounds i8, i8* [[__FIRST2_ADDR_07_I_I]], i64 1, !dbg !81
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[INCDEC_PTR1_I_I]], metadata !55, metadata !DIExpression()), !dbg !81
; CHECK-NEXT:    [[CMP_I_I:%.*]] = icmp eq i8* [[INCDEC_PTR_I_I]], [[ADD_PTR]], !dbg !82
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i1 [[CMP_I_I]], metadata !56, metadata !DIExpression()), !dbg !82
; CHECK-NEXT:    br i1 [[CMP_I_I]], label [[_ZNST3__15EQUALIPKCS2_EEBT_S3_T0__EXIT_LOOPEXIT]], label [[FOR_BODY_I_I]], !dbg !83
; CHECK:       _ZNSt3__15equalIPKcS2_EEbT_S3_T0_.exit.loopexit:
; CHECK-NEXT:    [[RETVAL_0_I_I_PH:%.*]] = phi i1 [ false, [[FOR_BODY_I_I]] ], [ true, [[FOR_INC_I_I]] ]
; CHECK-NEXT:    br label [[_ZNST3__15EQUALIPKCS2_EEBT_S3_T0__EXIT]], !dbg !84
; CHECK:       _ZNSt3__15equalIPKcS2_EEbT_S3_T0_.exit:
; CHECK-NEXT:    [[RETVAL_0_I_I:%.*]] = phi i1 [ true, [[FOR_BODY]] ], [ [[RETVAL_0_I_I_PH]], [[_ZNST3__15EQUALIPKCS2_EEBT_S3_T0__EXIT_LOOPEXIT]] ], !dbg !85
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i1 [[RETVAL_0_I_I]], metadata !57, metadata !DIExpression()), !dbg !85
; CHECK-NEXT:    tail call void @_Z4sinkb(i1 [[RETVAL_0_I_I]]), !dbg !84
; CHECK-NEXT:    [[INC]] = add nuw i64 [[I_012]], 1, !dbg !86
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i64 [[INC]], metadata !58, metadata !DIExpression()), !dbg !86
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i64 [[INC]], [[OUTER_COUNT]], !dbg !87
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i1 [[CMP]], metadata !59, metadata !DIExpression()), !dbg !87
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[FOR_BODY]], !dbg !88
;
entry:
  %cmp11 = icmp eq i64 %outer_count, 0
  br i1 %cmp11, label %for.cond.cleanup, label %for.body

for.cond.cleanup:                                 ; preds = %_ZNSt3__15equalIPKcS2_EEbT_S3_T0_.exit, %entry
  ret void

for.body:                                         ; preds = %entry, %_ZNSt3__15equalIPKcS2_EEbT_S3_T0_.exit
  %i.012 = phi i64 [ %inc, %_ZNSt3__15equalIPKcS2_EEbT_S3_T0_.exit ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i8*, i8** %ptr0, i64 %i.012
  %t0 = load i8*, i8** %arrayidx
  %arrayidx2 = getelementptr inbounds i64, i64* %count, i64 %i.012
  %t1 = load i64, i64* %arrayidx2
  %add.ptr = getelementptr inbounds i8, i8* %t0, i64 %t1
  %cmp5.i.i = icmp eq i64 %t1, 0
  br i1 %cmp5.i.i, label %_ZNSt3__15equalIPKcS2_EEbT_S3_T0_.exit, label %for.body.i.i.preheader

for.body.i.i.preheader:                           ; preds = %for.body
  %arrayidx3 = getelementptr inbounds i8*, i8** %ptr1, i64 %i.012
  %t2 = load i8*, i8** %arrayidx3
  br label %for.body.i.i

for.body.i.i:                                     ; preds = %for.body.i.i.preheader, %for.inc.i.i
  %__first2.addr.07.i.i = phi i8* [ %incdec.ptr1.i.i, %for.inc.i.i ], [ %t2, %for.body.i.i.preheader ]
  %__first1.addr.06.i.i = phi i8* [ %incdec.ptr.i.i, %for.inc.i.i ], [ %t0, %for.body.i.i.preheader ]
  %t3 = load i8, i8* %__first1.addr.06.i.i
  %t4 = load i8, i8* %__first2.addr.07.i.i
  %cmp.i.i.i = icmp eq i8 %t3, %t4
  br i1 %cmp.i.i.i, label %for.inc.i.i, label %_ZNSt3__15equalIPKcS2_EEbT_S3_T0_.exit

for.inc.i.i:                                      ; preds = %for.body.i.i
  %incdec.ptr.i.i = getelementptr inbounds i8, i8* %__first1.addr.06.i.i, i64 1
  %incdec.ptr1.i.i = getelementptr inbounds i8, i8* %__first2.addr.07.i.i, i64 1
  %cmp.i.i = icmp eq i8* %incdec.ptr.i.i, %add.ptr
  br i1 %cmp.i.i, label %_ZNSt3__15equalIPKcS2_EEbT_S3_T0_.exit, label %for.body.i.i

_ZNSt3__15equalIPKcS2_EEbT_S3_T0_.exit:           ; preds = %for.body.i.i, %for.inc.i.i, %for.body
  %retval.0.i.i = phi i1 [ true, %for.body ], [ true, %for.inc.i.i ], [ false, %for.body.i.i ]
  tail call void @_Z4sinkb(i1 %retval.0.i.i)
  %inc = add nuw i64 %i.012, 1
  %cmp = icmp eq i64 %inc, %outer_count
  br i1 %cmp, label %for.cond.cleanup, label %for.body
}
declare void @_Z4sinkb(i1)
