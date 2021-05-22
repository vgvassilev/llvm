; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main -mattr=+mve -tail-predication=enabled %s -o - | FileCheck %s

define dso_local arm_aapcs_vfpcc void @sext_i8(i16* noalias nocapture %a, i8* nocapture readonly %b, i32 %N) {
; CHECK-LABEL: sext_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    it eq
; CHECK-NEXT:    popeq {r7, pc}
; CHECK-NEXT:  .LBB0_1: @ %vector.ph
; CHECK-NEXT:    dlstp.16 lr, r2
; CHECK-NEXT:  .LBB0_2: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrb.s16 q0, [r1], #8
; CHECK-NEXT:    vldrh.u16 q1, [r0]
; CHECK-NEXT:    vadd.i16 q0, q1, q0
; CHECK-NEXT:    vstrh.16 q0, [r0], #16
; CHECK-NEXT:    letp lr, .LBB0_2
; CHECK-NEXT:  @ %bb.3: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
entry:
  %cmp8 = icmp eq i32 %N, 0
  br i1 %cmp8, label %for.cond.cleanup, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.rnd.up = add i32 %N, 7
  %n.vec = and i32 %n.rnd.up, -8
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i8, i8* %b, i32 %index
  %1 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32 %index, i32 %N)
  %2 = bitcast i8* %0 to <8 x i8>*
  %wide.masked.load = call <8 x i8> @llvm.masked.load.v8i8.p0v8i8(<8 x i8>* %2, i32 1, <8 x i1> %1, <8 x i8> undef)
  %3 = sext <8 x i8> %wide.masked.load to <8 x i16>
  %4 = getelementptr inbounds i16, i16* %a, i32 %index
  %5 = bitcast i16* %4 to <8 x i16>*
  %wide.masked.load12 = call <8 x i16> @llvm.masked.load.v8i16.p0v8i16(<8 x i16>* %5, i32 2, <8 x i1> %1, <8 x i16> undef)
  %6 = add <8 x i16> %wide.masked.load12, %3
  %7 = bitcast i16* %4 to <8 x i16>*
  call void @llvm.masked.store.v8i16.p0v8i16(<8 x i16> %6, <8 x i16>* %7, i32 2, <8 x i1> %1)
  %index.next = add i32 %index, 8
  %8 = icmp eq i32 %index.next, %n.vec
  br i1 %8, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body, %entry
  ret void
}

; Function Attrs: nofree norecurse nounwind
define dso_local arm_aapcs_vfpcc void @zext_i8(i16* noalias nocapture %a, i8* nocapture readonly %b, i32 %N) local_unnamed_addr #0 {
; CHECK-LABEL: zext_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    it eq
; CHECK-NEXT:    popeq {r7, pc}
; CHECK-NEXT:  .LBB1_1: @ %vector.ph
; CHECK-NEXT:    dlstp.16 lr, r2
; CHECK-NEXT:  .LBB1_2: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrb.u16 q0, [r1], #8
; CHECK-NEXT:    vldrh.u16 q1, [r0]
; CHECK-NEXT:    vadd.i16 q0, q1, q0
; CHECK-NEXT:    vstrh.16 q0, [r0], #16
; CHECK-NEXT:    letp lr, .LBB1_2
; CHECK-NEXT:  @ %bb.3: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
entry:
  %cmp8 = icmp eq i32 %N, 0
  br i1 %cmp8, label %for.cond.cleanup, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.rnd.up = add i32 %N, 7
  %n.vec = and i32 %n.rnd.up, -8
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i8, i8* %b, i32 %index
  %1 = call <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32 %index, i32 %N)
  %2 = bitcast i8* %0 to <8 x i8>*
  %wide.masked.load = call <8 x i8> @llvm.masked.load.v8i8.p0v8i8(<8 x i8>* %2, i32 1, <8 x i1> %1, <8 x i8> undef)
  %3 = zext <8 x i8> %wide.masked.load to <8 x i16>
  %4 = getelementptr inbounds i16, i16* %a, i32 %index
  %5 = bitcast i16* %4 to <8 x i16>*
  %wide.masked.load12 = call <8 x i16> @llvm.masked.load.v8i16.p0v8i16(<8 x i16>* %5, i32 2, <8 x i1> %1, <8 x i16> undef)
  %6 = add <8 x i16> %wide.masked.load12, %3
  %7 = bitcast i16* %4 to <8 x i16>*
  call void @llvm.masked.store.v8i16.p0v8i16(<8 x i16> %6, <8 x i16>* %7, i32 2, <8 x i1> %1)
  %index.next = add i32 %index, 8
  %8 = icmp eq i32 %index.next, %n.vec
  br i1 %8, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body, %entry
  ret void
}

; Function Attrs: nofree norecurse nounwind
define dso_local arm_aapcs_vfpcc void @sext_i16(i32* noalias nocapture %a, i16* nocapture readonly %b, i32 %N) local_unnamed_addr #0 {
; CHECK-LABEL: sext_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    it eq
; CHECK-NEXT:    popeq {r7, pc}
; CHECK-NEXT:  .LBB2_1: @ %vector.ph
; CHECK-NEXT:    dlstp.32 lr, r2
; CHECK-NEXT:  .LBB2_2: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.s32 q0, [r1], #8
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vadd.i32 q0, q1, q0
; CHECK-NEXT:    vstrw.32 q0, [r0], #16
; CHECK-NEXT:    letp lr, .LBB2_2
; CHECK-NEXT:  @ %bb.3: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
entry:
  %cmp6 = icmp eq i32 %N, 0
  br i1 %cmp6, label %for.cond.cleanup, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.rnd.up = add i32 %N, 3
  %n.vec = and i32 %n.rnd.up, -4
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i16, i16* %b, i32 %index
  %1 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 %index, i32 %N)
  %2 = bitcast i16* %0 to <4 x i16>*
  %wide.masked.load = call <4 x i16> @llvm.masked.load.v4i16.p0v4i16(<4 x i16>* %2, i32 2, <4 x i1> %1, <4 x i16> undef)
  %3 = sext <4 x i16> %wide.masked.load to <4 x i32>
  %4 = getelementptr inbounds i32, i32* %a, i32 %index
  %5 = bitcast i32* %4 to <4 x i32>*
  %wide.masked.load10 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %5, i32 4, <4 x i1> %1, <4 x i32> undef)
  %6 = add nsw <4 x i32> %wide.masked.load10, %3
  %7 = bitcast i32* %4 to <4 x i32>*
  call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %6, <4 x i32>* %7, i32 4, <4 x i1> %1)
  %index.next = add i32 %index, 4
  %8 = icmp eq i32 %index.next, %n.vec
  br i1 %8, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body, %entry
  ret void
}

; Function Attrs: nofree norecurse nounwind
define dso_local arm_aapcs_vfpcc void @zext_i16(i32* noalias nocapture %a, i16* nocapture readonly %b, i32 %N) local_unnamed_addr #0 {
; CHECK-LABEL: zext_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    it eq
; CHECK-NEXT:    popeq {r7, pc}
; CHECK-NEXT:  .LBB3_1: @ %vector.ph
; CHECK-NEXT:    dlstp.32 lr, r2
; CHECK-NEXT:  .LBB3_2: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u32 q0, [r1], #8
; CHECK-NEXT:    vldrw.u32 q1, [r0]
; CHECK-NEXT:    vadd.i32 q0, q1, q0
; CHECK-NEXT:    vstrw.32 q0, [r0], #16
; CHECK-NEXT:    letp lr, .LBB3_2
; CHECK-NEXT:  @ %bb.3: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
entry:
  %cmp6 = icmp eq i32 %N, 0
  br i1 %cmp6, label %for.cond.cleanup, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.rnd.up = add i32 %N, 3
  %n.vec = and i32 %n.rnd.up, -4
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i16, i16* %b, i32 %index
  %1 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 %index, i32 %N)
  %2 = bitcast i16* %0 to <4 x i16>*
  %wide.masked.load = call <4 x i16> @llvm.masked.load.v4i16.p0v4i16(<4 x i16>* %2, i32 2, <4 x i1> %1, <4 x i16> undef)
  %3 = zext <4 x i16> %wide.masked.load to <4 x i32>
  %4 = getelementptr inbounds i32, i32* %a, i32 %index
  %5 = bitcast i32* %4 to <4 x i32>*
  %wide.masked.load10 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %5, i32 4, <4 x i1> %1, <4 x i32> undef)
  %6 = add <4 x i32> %wide.masked.load10, %3
  %7 = bitcast i32* %4 to <4 x i32>*
  call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %6, <4 x i32>* %7, i32 4, <4 x i1> %1)
  %index.next = add i32 %index, 4
  %8 = icmp eq i32 %index.next, %n.vec
  br i1 %8, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body, %entry
  ret void
}

declare <8 x i8> @llvm.masked.load.v8i8.p0v8i8(<8 x i8>*, i32 immarg, <8 x i1>, <8 x i8>)
declare <8 x i16> @llvm.masked.load.v8i16.p0v8i16(<8 x i16>*, i32 immarg, <8 x i1>, <8 x i16>)
declare void @llvm.masked.store.v8i16.p0v8i16(<8 x i16>, <8 x i16>*, i32 immarg, <8 x i1>)
declare <4 x i16> @llvm.masked.load.v4i16.p0v4i16(<4 x i16>*, i32 immarg, <4 x i1>, <4 x i16>)
declare <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>*, i32 immarg, <4 x i1>, <4 x i32>)
declare void @llvm.masked.store.v4i32.p0v4i32(<4 x i32>, <4 x i32>*, i32 immarg, <4 x i1>)

declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32, i32)
declare <8 x i1> @llvm.get.active.lane.mask.v8i1.i32(i32, i32)
