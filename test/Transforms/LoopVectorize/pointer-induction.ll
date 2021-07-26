; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s  -loop-vectorize -force-vector-interleave=1 -force-vector-width=4 -S | FileCheck %s
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"


; Function Attrs: nofree norecurse nounwind
define void @a(i8* readnone %b) {
; CHECK-LABEL: @a(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[B1:%.*]] = ptrtoint i8* [[B:%.*]] to i64
; CHECK-NEXT:    [[CMP_NOT4:%.*]] = icmp eq i8* [[B]], null
; CHECK-NEXT:    br i1 [[CMP_NOT4]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY_PREHEADER:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = sub i64 0, [[B1]]
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[TMP0]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[TMP0]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[TMP0]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP1:%.*]] = mul i64 [[N_VEC]], -1
; CHECK-NEXT:    [[IND_END:%.*]] = getelementptr i8, i8* null, i64 [[TMP1]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[POINTER_PHI:%.*]] = phi i8* [ null, [[VECTOR_PH]] ], [ [[PTR_IND:%.*]], [[PRED_STORE_CONTINUE7:%.*]] ]
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[PRED_STORE_CONTINUE7]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr i8, i8* [[POINTER_PHI]], <4 x i64> <i64 0, i64 -1, i64 -2, i64 -3>
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, <4 x i8*> [[TMP2]], i64 -1
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <4 x i8*> [[TMP3]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr i8, i8* [[TMP4]], i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr i8, i8* [[TMP5]], i32 -3
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast i8* [[TMP6]] to <4 x i8>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i8>, <4 x i8>* [[TMP7]], align 1
; CHECK-NEXT:    [[REVERSE:%.*]] = shufflevector <4 x i8> [[WIDE_LOAD]], <4 x i8> poison, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[TMP8:%.*]] = icmp eq <4 x i8> [[REVERSE]], zeroinitializer
; CHECK-NEXT:    [[TMP9:%.*]] = xor <4 x i1> [[TMP8]], <i1 true, i1 true, i1 true, i1 true>
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <4 x i1> [[TMP9]], i32 0
; CHECK-NEXT:    br i1 [[TMP10]], label [[PRED_STORE_IF:%.*]], label [[PRED_STORE_CONTINUE:%.*]]
; CHECK:       pred.store.if:
; CHECK-NEXT:    [[TMP11:%.*]] = extractelement <4 x i8*> [[TMP3]], i32 0
; CHECK-NEXT:    store i8 95, i8* [[TMP11]], align 1
; CHECK-NEXT:    br label [[PRED_STORE_CONTINUE]]
; CHECK:       pred.store.continue:
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <4 x i1> [[TMP9]], i32 1
; CHECK-NEXT:    br i1 [[TMP12]], label [[PRED_STORE_IF2:%.*]], label [[PRED_STORE_CONTINUE3:%.*]]
; CHECK:       pred.store.if2:
; CHECK-NEXT:    [[TMP13:%.*]] = extractelement <4 x i8*> [[TMP3]], i32 1
; CHECK-NEXT:    store i8 95, i8* [[TMP13]], align 1
; CHECK-NEXT:    br label [[PRED_STORE_CONTINUE3]]
; CHECK:       pred.store.continue3:
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <4 x i1> [[TMP9]], i32 2
; CHECK-NEXT:    br i1 [[TMP14]], label [[PRED_STORE_IF4:%.*]], label [[PRED_STORE_CONTINUE5:%.*]]
; CHECK:       pred.store.if4:
; CHECK-NEXT:    [[TMP15:%.*]] = extractelement <4 x i8*> [[TMP3]], i32 2
; CHECK-NEXT:    store i8 95, i8* [[TMP15]], align 1
; CHECK-NEXT:    br label [[PRED_STORE_CONTINUE5]]
; CHECK:       pred.store.continue5:
; CHECK-NEXT:    [[TMP16:%.*]] = extractelement <4 x i1> [[TMP9]], i32 3
; CHECK-NEXT:    br i1 [[TMP16]], label [[PRED_STORE_IF6:%.*]], label [[PRED_STORE_CONTINUE7]]
; CHECK:       pred.store.if6:
; CHECK-NEXT:    [[TMP17:%.*]] = extractelement <4 x i8*> [[TMP3]], i32 3
; CHECK-NEXT:    store i8 95, i8* [[TMP17]], align 1
; CHECK-NEXT:    br label [[PRED_STORE_CONTINUE7]]
; CHECK:       pred.store.continue7:
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP18:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    [[PTR_IND]] = getelementptr i8, i8* [[POINTER_PHI]], i64 -4
; CHECK-NEXT:    br i1 [[TMP18]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[TMP0]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i8* [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ null, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    [[C_05:%.*]] = phi i8* [ [[INCDEC_PTR:%.*]], [[IF_END:%.*]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds i8, i8* [[C_05]], i64 -1
; CHECK-NEXT:    [[TMP19:%.*]] = load i8, i8* [[INCDEC_PTR]], align 1
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i8 [[TMP19]], 0
; CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[IF_END]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    store i8 95, i8* [[INCDEC_PTR]], align 1
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i8* [[INCDEC_PTR]], [[B]]
; CHECK-NEXT:    br i1 [[CMP_NOT]], label [[FOR_COND_CLEANUP_LOOPEXIT]], label [[FOR_BODY]], !llvm.loop [[LOOP2:![0-9]+]]
;

entry:
  %cmp.not4 = icmp eq i8* %b, null
  br i1 %cmp.not4, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %if.end
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %if.end
  %c.05 = phi i8* [ %incdec.ptr, %if.end ], [ null, %for.body.preheader ]
  %incdec.ptr = getelementptr inbounds i8, i8* %c.05, i64 -1
  %0 = load i8, i8* %incdec.ptr, align 1
  %tobool.not = icmp eq i8 %0, 0
  br i1 %tobool.not, label %if.end, label %if.then

if.then:                                          ; preds = %for.body
  store i8 95, i8* %incdec.ptr, align 1
  br label %if.end

if.end:                                           ; preds = %for.body, %if.then
  %cmp.not = icmp eq i8* %incdec.ptr, %b
  br i1 %cmp.not, label %for.cond.cleanup.loopexit, label %for.body
}

; In the test below the pointer phi %ptr.iv.2 is used as
;  1. As a uniform address for the load, and
;  2. Non-uniform use by the getelementptr which is stored. This requires the
;     vector value.
define void @pointer_induction_used_as_vector(i8** noalias %start.1, i8* noalias %start.2, i64 %N) {
; CHECK-LABEL: @pointer_induction_used_as_vector(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[N:%.*]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N]], [[N_MOD_VF]]
; CHECK-NEXT:    [[IND_END:%.*]] = getelementptr i8*, i8** [[START_1:%.*]], i64 [[N_VEC]]
; CHECK-NEXT:    [[IND_END3:%.*]] = getelementptr i8, i8* [[START_2:%.*]], i64 [[N_VEC]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[NEXT_GEP:%.*]] = getelementptr i8*, i8** [[START_1]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP2:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[NEXT_GEP4:%.*]] = getelementptr i8, i8* [[START_2]], i64 [[TMP2]]
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[INDEX]], 1
; CHECK-NEXT:    [[NEXT_GEP5:%.*]] = getelementptr i8, i8* [[START_2]], i64 [[TMP3]]
; CHECK-NEXT:    [[TMP4:%.*]] = add i64 [[INDEX]], 2
; CHECK-NEXT:    [[NEXT_GEP6:%.*]] = getelementptr i8, i8* [[START_2]], i64 [[TMP4]]
; CHECK-NEXT:    [[TMP5:%.*]] = add i64 [[INDEX]], 3
; CHECK-NEXT:    [[NEXT_GEP7:%.*]] = getelementptr i8, i8* [[START_2]], i64 [[TMP5]]
; CHECK-NEXT:    [[TMP6:%.*]] = insertelement <4 x i8*> poison, i8* [[NEXT_GEP4]], i32 0
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x i8*> [[TMP6]], i8* [[NEXT_GEP5]], i32 1
; CHECK-NEXT:    [[TMP8:%.*]] = insertelement <4 x i8*> [[TMP7]], i8* [[NEXT_GEP6]], i32 2
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <4 x i8*> [[TMP8]], i8* [[NEXT_GEP7]], i32 3
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i8, <4 x i8*> [[TMP9]], i64 1
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr i8*, i8** [[NEXT_GEP]], i32 0
; CHECK-NEXT:    [[TMP12:%.*]] = bitcast i8** [[TMP11]] to <4 x i8*>*
; CHECK-NEXT:    store <4 x i8*> [[TMP10]], <4 x i8*>* [[TMP12]], align 8
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr i8, i8* [[NEXT_GEP4]], i32 0
; CHECK-NEXT:    [[TMP14:%.*]] = bitcast i8* [[TMP13]] to <4 x i8>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i8>, <4 x i8>* [[TMP14]], align 1
; CHECK-NEXT:    [[TMP15:%.*]] = add <4 x i8> [[WIDE_LOAD]], <i8 1, i8 1, i8 1, i8 1>
; CHECK-NEXT:    [[TMP16:%.*]] = bitcast i8* [[TMP13]] to <4 x i8>*
; CHECK-NEXT:    store <4 x i8> [[TMP15]], <4 x i8>* [[TMP16]], align 1
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP17:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP17]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[N]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL1:%.*]] = phi i8** [ [[IND_END]], [[MIDDLE_BLOCK]] ], [ [[START_1]], [[ENTRY]] ]
; CHECK-NEXT:    [[BC_RESUME_VAL2:%.*]] = phi i8* [ [[IND_END3]], [[MIDDLE_BLOCK]] ], [ [[START_2]], [[ENTRY]] ]
; CHECK-NEXT:    br label [[LOOP_BODY:%.*]]
; CHECK:       loop.body:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], [[LOOP_BODY]] ]
; CHECK-NEXT:    [[PTR_IV_1:%.*]] = phi i8** [ [[BC_RESUME_VAL1]], [[SCALAR_PH]] ], [ [[PTR_IV_1_NEXT:%.*]], [[LOOP_BODY]] ]
; CHECK-NEXT:    [[PTR_IV_2:%.*]] = phi i8* [ [[BC_RESUME_VAL2]], [[SCALAR_PH]] ], [ [[PTR_IV_2_NEXT:%.*]], [[LOOP_BODY]] ]
; CHECK-NEXT:    [[PTR_IV_1_NEXT]] = getelementptr inbounds i8*, i8** [[PTR_IV_1]], i64 1
; CHECK-NEXT:    [[PTR_IV_2_NEXT]] = getelementptr inbounds i8, i8* [[PTR_IV_2]], i64 1
; CHECK-NEXT:    store i8* [[PTR_IV_2_NEXT]], i8** [[PTR_IV_1]], align 8
; CHECK-NEXT:    [[LV:%.*]] = load i8, i8* [[PTR_IV_2]], align 1
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[LV]], 1
; CHECK-NEXT:    store i8 [[ADD]], i8* [[PTR_IV_2]], align 1
; CHECK-NEXT:    [[IV_NEXT]] = add nuw i64 [[IV]], 1
; CHECK-NEXT:    [[C:%.*]] = icmp ne i64 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_BODY]], label [[EXIT]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;

entry:
  br label %loop.body

loop.body:                                    ; preds = %loop.body, %entry
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.body ]
  %ptr.iv.1 = phi i8** [ %start.1, %entry ], [ %ptr.iv.1.next, %loop.body ]
  %ptr.iv.2 = phi i8* [ %start.2, %entry ], [ %ptr.iv.2.next, %loop.body ]
  %ptr.iv.1.next = getelementptr inbounds i8*, i8** %ptr.iv.1, i64 1
  %ptr.iv.2.next = getelementptr inbounds i8, i8* %ptr.iv.2, i64 1
  store i8* %ptr.iv.2.next, i8** %ptr.iv.1, align 8
  %lv = load i8, i8* %ptr.iv.2, align 1
  %add = add i8 %lv, 1
  store i8 %add, i8* %ptr.iv.2, align 1
  %iv.next = add nuw i64 %iv, 1
  %c = icmp ne i64 %iv.next, %N
  br i1 %c, label %loop.body, label %exit

exit:                            ; preds = %loop.body
  ret void
}
