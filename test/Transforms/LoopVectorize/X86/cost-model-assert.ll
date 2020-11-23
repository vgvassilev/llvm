; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s  -loop-vectorize -S | FileCheck %s

; This is a bugpoint reduction of a test from PR43582:
; https://bugs.llvm.org/show_bug.cgi?id=43582

; ...but it's over-simplifying the underlying question:
; TODO: Should this be vectorized rather than allowing the backend to load combine?
;       The original code is a bswap pattern.

target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-w64-windows-gnu"

define void @cff_index_load_offsets(i1 %cond, i8 %x, i8* %p) #0 {
; CHECK-LABEL: @cff_index_load_offsets(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[IF_THEN:%.*]], label [[EXIT:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    br i1 true, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i8> undef, i8 [[X:%.*]], i32 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i8> [[BROADCAST_SPLATINSERT]], <4 x i8> undef, <4 x i32> zeroinitializer
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 4
; CHECK-NEXT:    [[NEXT_GEP:%.*]] = getelementptr i8, i8* null, i64 [[TMP1]]
; CHECK-NEXT:    [[TMP2:%.*]] = zext <4 x i8> [[BROADCAST_SPLAT]] to <4 x i32>
; CHECK-NEXT:    [[TMP3:%.*]] = shl nuw <4 x i32> [[TMP2]], <i32 24, i32 24, i32 24, i32 24>
; CHECK-NEXT:    [[TMP4:%.*]] = load i8, i8* [[P:%.*]], align 1, [[TBAA1:!tbaa !.*]]
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT1:%.*]] = insertelement <4 x i8> undef, i8 [[TMP4]], i32 0
; CHECK-NEXT:    [[BROADCAST_SPLAT2:%.*]] = shufflevector <4 x i8> [[BROADCAST_SPLATINSERT1]], <4 x i8> undef, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = zext <4 x i8> [[BROADCAST_SPLAT2]] to <4 x i32>
; CHECK-NEXT:    [[TMP6:%.*]] = shl nuw nsw <4 x i32> [[TMP5]], <i32 16, i32 16, i32 16, i32 16>
; CHECK-NEXT:    [[TMP7:%.*]] = or <4 x i32> [[TMP6]], [[TMP3]]
; CHECK-NEXT:    [[TMP8:%.*]] = load i8, i8* undef, align 1, [[TBAA1]]
; CHECK-NEXT:    [[TMP9:%.*]] = load i8, i8* undef, align 1, [[TBAA1]]
; CHECK-NEXT:    [[TMP10:%.*]] = load i8, i8* undef, align 1, [[TBAA1]]
; CHECK-NEXT:    [[TMP11:%.*]] = load i8, i8* undef, align 1, [[TBAA1]]
; CHECK-NEXT:    [[TMP12:%.*]] = or <4 x i32> [[TMP7]], zeroinitializer
; CHECK-NEXT:    [[TMP13:%.*]] = or <4 x i32> [[TMP12]], zeroinitializer
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <4 x i32> [[TMP13]], i32 0
; CHECK-NEXT:    store i32 [[TMP14]], i32* undef, align 4, [[TBAA4:!tbaa !.*]]
; CHECK-NEXT:    [[TMP15:%.*]] = extractelement <4 x i32> [[TMP13]], i32 1
; CHECK-NEXT:    store i32 [[TMP15]], i32* undef, align 4, [[TBAA4]]
; CHECK-NEXT:    [[TMP16:%.*]] = extractelement <4 x i32> [[TMP13]], i32 2
; CHECK-NEXT:    store i32 [[TMP16]], i32* undef, align 4, [[TBAA4]]
; CHECK-NEXT:    [[TMP17:%.*]] = extractelement <4 x i32> [[TMP13]], i32 3
; CHECK-NEXT:    store i32 [[TMP17]], i32* undef, align 4, [[TBAA4]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP18:%.*]] = icmp eq i64 [[INDEX_NEXT]], 0
; CHECK-NEXT:    br i1 [[TMP18]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP6:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 1, 0
; CHECK-NEXT:    br i1 [[CMP_N]], label [[SW_EPILOG:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i8* [ null, [[MIDDLE_BLOCK]] ], [ null, [[IF_THEN]] ]
; CHECK-NEXT:    br label [[FOR_BODY68:%.*]]
; CHECK:       for.body68:
; CHECK-NEXT:    [[P_359:%.*]] = phi i8* [ [[ADD_PTR86:%.*]], [[FOR_BODY68]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[CONV70:%.*]] = zext i8 [[X]] to i32
; CHECK-NEXT:    [[SHL71:%.*]] = shl nuw i32 [[CONV70]], 24
; CHECK-NEXT:    [[TMP19:%.*]] = load i8, i8* [[P]], align 1, [[TBAA1]]
; CHECK-NEXT:    [[CONV73:%.*]] = zext i8 [[TMP19]] to i32
; CHECK-NEXT:    [[SHL74:%.*]] = shl nuw nsw i32 [[CONV73]], 16
; CHECK-NEXT:    [[OR75:%.*]] = or i32 [[SHL74]], [[SHL71]]
; CHECK-NEXT:    [[TMP20:%.*]] = load i8, i8* undef, align 1, [[TBAA1]]
; CHECK-NEXT:    [[SHL78:%.*]] = shl nuw nsw i32 undef, 8
; CHECK-NEXT:    [[OR79:%.*]] = or i32 [[OR75]], [[SHL78]]
; CHECK-NEXT:    [[CONV81:%.*]] = zext i8 undef to i32
; CHECK-NEXT:    [[OR83:%.*]] = or i32 [[OR79]], [[CONV81]]
; CHECK-NEXT:    store i32 [[OR83]], i32* undef, align 4, [[TBAA4]]
; CHECK-NEXT:    [[ADD_PTR86]] = getelementptr inbounds i8, i8* [[P_359]], i64 4
; CHECK-NEXT:    [[CMP66:%.*]] = icmp ult i8* [[ADD_PTR86]], undef
; CHECK-NEXT:    br i1 [[CMP66]], label [[FOR_BODY68]], label [[SW_EPILOG]], [[LOOP8:!llvm.loop !.*]]
; CHECK:       sw.epilog:
; CHECK-NEXT:    unreachable
; CHECK:       Exit:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %cond, label %if.then, label %Exit

if.then:                                          ; preds = %entry
  br label %for.body68

for.body68:                                       ; preds = %for.body68, %if.then
  %p.359 = phi i8* [ %add.ptr86, %for.body68 ], [ null, %if.then ]
  %conv70 = zext i8 %x to i32
  %shl71 = shl nuw i32 %conv70, 24
  %0 = load i8, i8* %p, align 1, !tbaa !1
  %conv73 = zext i8 %0 to i32
  %shl74 = shl nuw nsw i32 %conv73, 16
  %or75 = or i32 %shl74, %shl71
  %1 = load i8, i8* undef, align 1, !tbaa !1
  %shl78 = shl nuw nsw i32 undef, 8
  %or79 = or i32 %or75, %shl78
  %conv81 = zext i8 undef to i32
  %or83 = or i32 %or79, %conv81
  store i32 %or83, i32* undef, align 4, !tbaa !4
  %add.ptr86 = getelementptr inbounds i8, i8* %p.359, i64 4
  %cmp66 = icmp ult i8* %add.ptr86, undef
  br i1 %cmp66, label %for.body68, label %sw.epilog

sw.epilog:                                        ; preds = %for.body68
  unreachable

Exit:                                             ; preds = %entry
  ret void
}

attributes #0 = { "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 10.0.0 (https://github.com/llvm/llvm-project.git 0fedc26a0dc0066f3968b9fea6a4e1f746c8d5a4)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"omnipotent char", !3, i64 0}
!3 = !{!"Simple C/C++ TBAA"}
!4 = !{!5, !5, i64 0}
!5 = !{!"long", !2, i64 0}
