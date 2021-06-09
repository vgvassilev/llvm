; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Test that the memset library call simplifier works correctly.
;
; RUN: opt < %s -instcombine -S | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128"

declare i8* @memset(i8*, i32, i32)
declare void @llvm.memset.p0i8.i32(i8* nocapture writeonly, i8, i32, i32, i1)
declare noalias i8* @malloc(i32) #1

; Check memset(mem1, val, size) -> llvm.memset(mem1, val, size, 1).

define i8* @test_simplify1(i8* %mem, i32 %val, i32 %size) {
; CHECK-LABEL: @test_simplify1(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[VAL:%.*]] to i8
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* align 1 [[MEM:%.*]], i8 [[TMP1]], i32 [[SIZE:%.*]], i1 false)
; CHECK-NEXT:    ret i8* [[MEM]]
;
  %ret = call i8* @memset(i8* %mem, i32 %val, i32 %size)
  ret i8* %ret
}

define i8* @pr25892_lite(i32 %size) #0 {
; CHECK-LABEL: @pr25892_lite(
; CHECK-NEXT:    [[CALLOC:%.*]] = call noalias noundef i8* @calloc(i32 noundef 1, i32 noundef [[SIZE:%.*]]) #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    ret i8* [[CALLOC]]
;
  %call1 = call i8* @malloc(i32 %size) #1
  %call2 = call i8* @memset(i8* %call1, i32 0, i32 %size) #1
  ret i8* %call2
}

; FIXME: A memset intrinsic should be handled similarly to a memset() libcall.

define i8* @malloc_and_memset_intrinsic(i32 %n) #0 {
; CHECK-LABEL: @malloc_and_memset_intrinsic(
; CHECK-NEXT:    [[CALL:%.*]] = call i8* @malloc(i32 [[N:%.*]])
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* align 1 [[CALL]], i8 0, i32 [[N]], i1 false)
; CHECK-NEXT:    ret i8* [[CALL]]
;
  %call = call i8* @malloc(i32 %n)
  call void @llvm.memset.p0i8.i32(i8* %call, i8 0, i32 %n, i32 1, i1 false)
  ret i8* %call
}

; This should not create a calloc and should not crash the compiler.

define i8* @notmalloc_memset(i32 %size, i8*(i32)* %notmalloc) {
; CHECK-LABEL: @notmalloc_memset(
; CHECK-NEXT:    [[CALL1:%.*]] = call i8* [[NOTMALLOC:%.*]](i32 [[SIZE:%.*]]) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* align 1 [[CALL1]], i8 0, i32 [[SIZE]], i1 false) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[CALL1]]
;
  %call1 = call i8* %notmalloc(i32 %size) #1
  %call2 = call i8* @memset(i8* %call1, i32 0, i32 %size) #1
  ret i8* %call2
}

; FIXME: memset(malloc(x), 0, x) -> calloc(1, x)
; This doesn't fire currently because the malloc has more than one use.

define float* @pr25892(i32 %size) #0 {
; CHECK-LABEL: @pr25892(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = tail call i8* @malloc(i32 [[SIZE:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8* [[CALL]], null
; CHECK-NEXT:    br i1 [[CMP]], label [[CLEANUP:%.*]], label [[IF_END:%.*]]
; CHECK:       if.end:
; CHECK-NEXT:    [[BC:%.*]] = bitcast i8* [[CALL]] to float*
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* nonnull align 1 [[CALL]], i8 0, i32 [[SIZE]], i1 false) #[[ATTR0]]
; CHECK-NEXT:    br label [[CLEANUP]]
; CHECK:       cleanup:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi float* [ [[BC]], [[IF_END]] ], [ null, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret float* [[RETVAL_0]]
;
entry:
  %call = tail call i8* @malloc(i32 %size) #1
  %cmp = icmp eq i8* %call, null
  br i1 %cmp, label %cleanup, label %if.end
if.end:
  %bc = bitcast i8* %call to float*
  %call2 = tail call i8* @memset(i8* nonnull %call, i32 0, i32 %size) #1
  br label %cleanup
cleanup:
  %retval.0 = phi float* [ %bc, %if.end ], [ null, %entry ]
  ret float* %retval.0
}

; If there's a calloc transform, the store must also be eliminated.

define i8* @buffer_is_modified_then_memset(i32 %size) {
; CHECK-LABEL: @buffer_is_modified_then_memset(
; CHECK-NEXT:    [[PTR:%.*]] = tail call i8* @malloc(i32 [[SIZE:%.*]]) #[[ATTR0]]
; CHECK-NEXT:    store i8 1, i8* [[PTR]], align 1
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* nonnull align 1 [[PTR]], i8 0, i32 [[SIZE]], i1 false) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[PTR]]
;
  %ptr = tail call i8* @malloc(i32 %size) #1
  store i8 1, i8* %ptr           ;; fdata[0] = 1;
  %memset = tail call i8* @memset(i8* nonnull %ptr, i32 0, i32 %size) #1
  ret i8* %memset
}

define i8* @memset_size_select(i1 %b, i8* %ptr) {
; CHECK-LABEL: @memset_size_select(
; CHECK-NEXT:    [[SIZE:%.*]] = select i1 [[B:%.*]], i32 10, i32 50
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* noundef nonnull align 1 dereferenceable(10) [[PTR:%.*]], i8 0, i32 [[SIZE]], i1 false) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[PTR]]
;
  %size = select i1 %b, i32 10, i32 50
  %memset = tail call i8* @memset(i8* nonnull %ptr, i32 0, i32 %size) #1
  ret i8* %memset
}


define i8* @memset_size_select2(i1 %b, i8* %ptr) {
; CHECK-LABEL: @memset_size_select2(
; CHECK-NEXT:    [[SIZE:%.*]] = select i1 [[B:%.*]], i32 10, i32 50
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* noundef nonnull align 1 dereferenceable(80) [[PTR:%.*]], i8 0, i32 [[SIZE]], i1 false) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[PTR]]
;
  %size = select i1 %b, i32 10, i32 50
  %memset = tail call i8* @memset(i8* nonnull dereferenceable(80) %ptr, i32 0, i32 %size) #1
  ret i8* %memset
}

define i8* @memset_size_select3(i1 %b, i8* %ptr) {
; CHECK-LABEL: @memset_size_select3(
; CHECK-NEXT:    [[SIZE:%.*]] = select i1 [[B:%.*]], i32 10, i32 50
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* noundef nonnull align 1 dereferenceable(40) [[PTR:%.*]], i8 0, i32 [[SIZE]], i1 false)
; CHECK-NEXT:    ret i8* [[PTR]]
;
  %size = select i1 %b, i32 10, i32 50
  %memset = tail call i8* @memset(i8* dereferenceable_or_null(40) %ptr, i32 0, i32 %size)
  ret i8* %memset
}

define i8* @memset_size_select4(i1 %b, i8* %ptr) {
; CHECK-LABEL: @memset_size_select4(
; CHECK-NEXT:    [[SIZE:%.*]] = select i1 [[B:%.*]], i32 10, i32 50
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* noundef nonnull align 1 dereferenceable(40) [[PTR:%.*]], i8 0, i32 [[SIZE]], i1 false) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[PTR]]
;
  %size = select i1 %b, i32 10, i32 50
  %memset = tail call i8* @memset(i8* nonnull dereferenceable_or_null(40) %ptr, i32 0, i32 %size) #1
  ret i8* %memset
}

define i8* @memset_size_ashr(i1 %b, i8* %ptr, i32 %v) {
; CHECK-LABEL: @memset_size_ashr(
; CHECK-NEXT:    [[SIZE:%.*]] = ashr i32 -2, [[V:%.*]]
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* noundef nonnull align 1 [[PTR:%.*]], i8 0, i32 [[SIZE]], i1 false) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[PTR]]
;
  %size = ashr i32 -2, %v
  %memset = tail call i8* @memset(i8* nonnull %ptr, i32 0, i32 %size) #1
  ret i8* %memset
}

define i8* @memset_attrs1(i1 %b, i8* %ptr, i32 %size) {
; CHECK-LABEL: @memset_attrs1(
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* align 1 dereferenceable_or_null(40) [[PTR:%.*]], i8 0, i32 [[SIZE:%.*]], i1 false) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[PTR]]
;
  %memset = tail call i8* @memset(i8* dereferenceable_or_null(40) %ptr, i32 0, i32 %size) #1
  ret i8* %memset
}

; be sure to drop nonnull since size is unknown and can be 0
; do not change dereferenceable attribute
define i8* @memset_attrs2(i1 %b, i8* %ptr, i32 %size) {
; CHECK-LABEL: @memset_attrs2(
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* nonnull align 1 dereferenceable(40) [[PTR:%.*]], i8 0, i32 [[SIZE:%.*]], i1 false) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[PTR]]
;
  %memset = tail call i8* @memset(i8* nonnull dereferenceable(40) %ptr, i32 0, i32 %size) #1
  ret i8* %memset
}

; size is unknown, just copy attrs, no changes in attrs
define i8* @memset_attrs3(i1 %b, i8* %ptr, i32 %size) {
; CHECK-LABEL: @memset_attrs3(
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* nonnull align 1 dereferenceable_or_null(40) [[PTR:%.*]], i8 0, i32 [[SIZE:%.*]], i1 false) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[PTR]]
;
  %memset = tail call i8* @memset(i8* nonnull dereferenceable_or_null(40) %ptr, i32 0, i32 %size) #1
  ret i8* %memset
}

; be sure to drop nonnull since size is unknown and can be 0
define i8* @memset_attrs4(i1 %b, i8* %ptr, i32 %size) {
; CHECK-LABEL: @memset_attrs4(
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* nonnull align 1 [[PTR:%.*]], i8 0, i32 [[SIZE:%.*]], i1 false) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[PTR]]
;
  %memset = tail call i8* @memset(i8* nonnull %ptr, i32 0, i32 %size) #1
  ret i8* %memset
}

define i8* @test_no_incompatible_attr(i8* %mem, i32 %val, i32 %size) {
; CHECK-LABEL: @test_no_incompatible_attr(
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[VAL:%.*]] to i8
; CHECK-NEXT:    call void @llvm.memset.p0i8.i32(i8* align 1 [[MEM:%.*]], i8 [[TMP1]], i32 [[SIZE:%.*]], i1 false)
; CHECK-NEXT:    ret i8* [[MEM]]
;
  %ret = call dereferenceable(1) i8* @memset(i8* %mem, i32 %val, i32 %size)
  ret i8* %ret
}

attributes #0 = { nounwind ssp uwtable }
attributes #1 = { nounwind }
attributes #2 = { nounwind readnone }

