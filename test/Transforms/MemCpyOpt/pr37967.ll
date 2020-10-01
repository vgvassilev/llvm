; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -debugify -memcpyopt -check-debugify -S < %s 2>&1 | FileCheck %s

; CHECK: CheckModuleDebugify: PASS

%struct.Foo = type { i64, i64, i64 }

@a = dso_local global %struct.Foo* null, align 8

define dso_local void @_Z3bar3Foo(%struct.Foo* byval(%struct.Foo) align 8 %0) {
; CHECK-LABEL: @_Z3bar3Foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[AGG_TMP:%.*]] = alloca [[STRUCT_FOO:%.*]], align 8, [[DBG13:!dbg !.*]]
; CHECK-NEXT:    call void @llvm.dbg.value(metadata %struct.Foo* [[AGG_TMP]], [[META9:metadata !.*]], metadata !DIExpression()), [[DBG13]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i8*, i8** bitcast (%struct.Foo** @a to i8**), align 8, [[DBG14:!dbg !.*]]
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[TMP1]], [[META11:metadata !.*]], metadata !DIExpression()), [[DBG14]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast %struct.Foo* [[AGG_TMP]] to i8*, [[DBG15:!dbg !.*]]
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i8* [[TMP2]], [[META12:metadata !.*]], metadata !DIExpression()), [[DBG15]]
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(24) [[TMP2]], i8* nonnull align 8 dereferenceable(24) [[TMP1]], i64 24, i1 false), [[DBG16:!dbg !.*]]
; CHECK-NEXT:    [[TMPCAST:%.*]] = bitcast i8* [[TMP1]] to %struct.Foo*, [[DBG16]]
; CHECK-NEXT:    call void @_Z3bar3Foo(%struct.Foo* nonnull byval(%struct.Foo) align 8 [[TMPCAST]]), [[DBG17:!dbg !.*]]
; CHECK-NEXT:    ret void, [[DBG18:!dbg !.*]]
;
entry:
  %agg.tmp = alloca %struct.Foo, align 8
  %1 = load i8*, i8** bitcast (%struct.Foo** @a to i8**), align 8
  %2 = bitcast %struct.Foo* %agg.tmp to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 dereferenceable(24) %2, i8* nonnull align 8 dereferenceable(24) %1, i64 24, i1 false)
  call void @_Z3bar3Foo(%struct.Foo* nonnull byval(%struct.Foo) align 8 %agg.tmp)
  ret void
}

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #0
