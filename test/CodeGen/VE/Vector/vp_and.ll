; RUN: llc < %s -march=ve -mattr=+vpu | FileCheck %s

declare <256 x i32> @llvm.vp.and.v256i32(<256 x i32>, <256 x i32>, <256 x i1>, i32)

define fastcc <256 x i32> @test_vp_and_v256i32(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_and_v256i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvand.lo %v0, %v0, %v1, %vm1
; CHECK-NEXT:    b.l.t (, %s10)
  %r0 = call <256 x i32> @llvm.vp.and.v256i32(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  ret <256 x i32> %r0
}


declare <256 x i64> @llvm.vp.and.v256i64(<256 x i64>, <256 x i64>, <256 x i1>, i32)

define fastcc <256 x i64> @test_vp_int_v256i64(<256 x i64> %i0, <256 x i64> %i1, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_int_v256i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vand %v0, %v0, %v1, %vm1
; CHECK-NEXT:    b.l.t (, %s10)
  %r0 = call <256 x i64> @llvm.vp.and.v256i64(<256 x i64> %i0, <256 x i64> %i1, <256 x i1> %m, i32 %n)
  ret <256 x i64> %r0
}
