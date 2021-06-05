; Test memset 0 with variable length
;
; RUN: llc < %s -mtriple=s390x-linux-gnu | FileCheck %s

define void @fun0(i8* %Addr, i64 %Len) {
; CHECK-LABEL: fun0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    aghi %r3, -1
; CHECK-NEXT:    cgibe %r3, -1, 0(%r14)
; CHECK-NEXT:  .LBB0_1:
; CHECK-NEXT:    srlg %r0, %r3, 8
; CHECK-NEXT:    cgije %r0, 0, .LBB0_3
; CHECK-NEXT:  .LBB0_2: # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    xc 0(256,%r2), 0(%r2)
; CHECK-NEXT:    la %r2, 256(%r2)
; CHECK-NEXT:    brctg %r0, .LBB0_2
; CHECK-NEXT:  .LBB0_3:
; CHECK-NEXT:    exrl %r3, .Ltmp0
; CHECK-NEXT:    br %r14
  tail call void @llvm.memset.p0i8.i64(i8* %Addr, i8 0, i64 %Len, i1 false)
  ret void
}

define void @fun1(i8* %Addr, i32 %Len) {
; CHECK-LABEL: fun1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    llgfr %r1, %r3
; CHECK-NEXT:    aghi %r1, -1
; CHECK-NEXT:    cgibe %r1, -1, 0(%r14)
; CHECK-NEXT:  .LBB1_1:
; CHECK-NEXT:    srlg %r0, %r1, 8
; CHECK-NEXT:    cgije %r0, 0, .LBB1_3
; CHECK-NEXT:  .LBB1_2: # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    xc 0(256,%r2), 0(%r2)
; CHECK-NEXT:    la %r2, 256(%r2)
; CHECK-NEXT:    brctg %r0, .LBB1_2
; CHECK-NEXT:  .LBB1_3:
; CHECK-NEXT:    exrl %r1, .Ltmp0
; CHECK-NEXT:    br %r14
  tail call void @llvm.memset.p0i8.i32(i8* %Addr, i8 0, i32 %Len, i1 false)
  ret void
}

; Test that identical target instructions get reused.
define void @fun2(i8* %Addr, i32 %Len) {
; CHECK-LABEL: fun2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    llgfr %r1, %r3
; CHECK-NEXT:    aghi %r1, -1
; CHECK-NEXT:    srlg %r0, %r1, 8
; CHECK-NEXT:    cgije %r1, -1, .LBB2_5
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    lgr %r3, %r2
; CHECK-NEXT:    cgije %r0, 0, .LBB2_4
; CHECK-NEXT:  # %bb.2:
; CHECK-NEXT:    lgr %r3, %r2
; CHECK-NEXT:    lgr %r4, %r0
; CHECK-NEXT:  .LBB2_3: # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    xc 0(256,%r3), 0(%r3)
; CHECK-NEXT:    la %r3, 256(%r3)
; CHECK-NEXT:    brctg %r4, .LBB2_3
; CHECK-NEXT:  .LBB2_4:
; CHECK-NEXT:    exrl %r1, .Ltmp1
; CHECK-NEXT:  .LBB2_5:
; CHECK-NEXT:    cgije %r1, -1, .LBB2_10
; CHECK-NEXT:  # %bb.6:
; CHECK-NEXT:    lgr %r3, %r2
; CHECK-NEXT:    cgije %r0, 0, .LBB2_9
; CHECK-NEXT:  # %bb.7:
; CHECK-NEXT:    lgr %r3, %r2
; CHECK-NEXT:    lgr %r4, %r0
; CHECK-NEXT:  .LBB2_8: # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    xc 0(256,%r3), 0(%r3)
; CHECK-NEXT:    la %r3, 256(%r3)
; CHECK-NEXT:    brctg %r4, .LBB2_8
; CHECK-NEXT:  .LBB2_9:
; CHECK-NEXT:    exrl %r1, .Ltmp1
; CHECK-NEXT:  .LBB2_10:
; CHECK-NEXT:    cgibe %r1, -1, 0(%r14)
; CHECK-NEXT:  .LBB2_11:
; CHECK-NEXT:    cgije %r0, 0, .LBB2_13
; CHECK-NEXT:  .LBB2_12: # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    xc 0(256,%r2), 0(%r2)
; CHECK-NEXT:    la %r2, 256(%r2)
; CHECK-NEXT:    brctg %r0, .LBB2_12
; CHECK-NEXT:  .LBB2_13:
; CHECK-NEXT:    exrl %r1, .Ltmp0
; CHECK-NEXT:    br %r14
  tail call void @llvm.memset.p0i8.i32(i8* %Addr, i8 0, i32 %Len, i1 false)
  tail call void @llvm.memset.p0i8.i32(i8* %Addr, i8 0, i32 %Len, i1 false)
  tail call void @llvm.memset.p0i8.i32(i8* %Addr, i8 0, i32 %Len, i1 false)
  ret void
}

; CHECK:       .Ltmp0:
; CHECK-NEXT:    xc 0(1,%r2), 0(%r2)
; CHECK-NEXT:  .Ltmp1:
; CHECK-NEXT:    xc 0(1,%r3), 0(%r3)

declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg)
declare void @llvm.memset.p0i8.i32(i8* nocapture writeonly, i8, i32, i1 immarg)
