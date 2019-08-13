; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture, i8* nocapture, i32, i1) nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture, i64, i1) nounwind

; Same src/dest.

define void @test1(i8* %a) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memcpy.p0i8.p0i8.i32(i8* %a, i8* %a, i32 100, i1 false)
  ret void
}

; PR8267 - same src/dest, but volatile.

define void @test2(i8* %a) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    tail call void @llvm.memcpy.p0i8.p0i8.i32(i8* [[A:%.*]], i8* [[A]], i32 100, i1 true)
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memcpy.p0i8.p0i8.i32(i8* %a, i8* %a, i32 100, i1 true)
  ret void
}

; 17179869184 == 0x400000000 - make sure that doesn't get truncated to 32-bit.

define void @test3(i8* %d, i8* %s) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias align 4 dereferenceable(17179869184) [[D:%.*]], i8* noalias align 4 dereferenceable(17179869184) [[S:%.*]], i64 17179869184, i1 false)
; CHECK-NEXT:    ret void
;
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %d, i8* align 4 %s, i64 17179869184, i1 false)
  ret void
}

@UnknownConstant = external constant i128

define void @memcpy_to_constant(i8* %src) {
; CHECK-LABEL: @memcpy_to_constant(
; CHECK-NEXT:    ret void
;
  %dest = bitcast i128* @UnknownConstant to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %dest, i8* %src, i32 16, i1 false)
  ret void
}
