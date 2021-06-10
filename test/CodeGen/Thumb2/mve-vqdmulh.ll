; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s

define arm_aapcs_vfpcc i32 @vqdmulh_i8(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: vqdmulh_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqdmulh.s8 q0, q1, q0
; CHECK-NEXT:    vaddv.s8 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %l2 = sext <16 x i8> %s0 to <16 x i32>
  %l5 = sext <16 x i8> %s1 to <16 x i32>
  %l6 = mul nsw <16 x i32> %l5, %l2
  %l7 = ashr <16 x i32> %l6, <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  %l8 = icmp slt <16 x i32> %l7, <i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127>
  %l9 = select <16 x i1> %l8, <16 x i32> %l7, <16 x i32> <i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127>
  %l10 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %l9)
  ret i32 %l10
}

define arm_aapcs_vfpcc <16 x i8> @vqdmulh_i8_b(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: vqdmulh_i8_b:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqdmulh.s8 q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %l2 = sext <16 x i8> %s0 to <16 x i32>
  %l5 = sext <16 x i8> %s1 to <16 x i32>
  %l6 = mul nsw <16 x i32> %l5, %l2
  %l7 = ashr <16 x i32> %l6, <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  %l8 = icmp slt <16 x i32> %l7, <i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127>
  %l9 = select <16 x i1> %l8, <16 x i32> %l7, <16 x i32> <i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127>
  %l10 = trunc <16 x i32> %l9 to <16 x i8>
  ret <16 x i8> %l10
}

define arm_aapcs_vfpcc i32 @vqdmulh_i16(<8 x i16> %s0, <8 x i16> %s1) {
; CHECK-LABEL: vqdmulh_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqdmulh.s16 q0, q1, q0
; CHECK-NEXT:    vaddv.s16 r0, q0
; CHECK-NEXT:    bx lr
entry:
  %l2 = sext <8 x i16> %s0 to <8 x i32>
  %l5 = sext <8 x i16> %s1 to <8 x i32>
  %l6 = mul nsw <8 x i32> %l5, %l2
  %l7 = ashr <8 x i32> %l6, <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>
  %l8 = icmp slt <8 x i32> %l7, <i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767>
  %l9 = select <8 x i1> %l8, <8 x i32> %l7, <8 x i32> <i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767>
  %l10 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %l9)
  ret i32 %l10
}

define arm_aapcs_vfpcc <8 x i16> @vqdmulh_i16_b(<8 x i16> %s0, <8 x i16> %s1) {
; CHECK-LABEL: vqdmulh_i16_b:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqdmulh.s16 q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %l2 = sext <8 x i16> %s0 to <8 x i32>
  %l5 = sext <8 x i16> %s1 to <8 x i32>
  %l6 = mul nsw <8 x i32> %l5, %l2
  %l7 = ashr <8 x i32> %l6, <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>
  %l8 = icmp slt <8 x i32> %l7, <i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767>
  %l9 = select <8 x i1> %l8, <8 x i32> %l7, <8 x i32> <i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767>
  %l10 = trunc <8 x i32> %l9 to <8 x i16>
  ret <8 x i16> %l10
}

define arm_aapcs_vfpcc <8 x i16> @vqdmulh_i16_c(<8 x i16> %s0, <8 x i16> %s1) {
; CHECK-LABEL: vqdmulh_i16_c:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov q2, q0
; CHECK-NEXT:    vmov.u16 r0, q0[2]
; CHECK-NEXT:    vmov.u16 r1, q0[0]
; CHECK-NEXT:    vmov q0[2], q0[0], r1, r0
; CHECK-NEXT:    vmov.u16 r0, q2[3]
; CHECK-NEXT:    vmov.u16 r1, q2[1]
; CHECK-NEXT:    vmov q0[3], q0[1], r1, r0
; CHECK-NEXT:    vmov.u16 r0, q1[2]
; CHECK-NEXT:    vmov.u16 r1, q1[0]
; CHECK-NEXT:    vmov q3[2], q3[0], r1, r0
; CHECK-NEXT:    vmov.u16 r0, q1[3]
; CHECK-NEXT:    vmov.u16 r1, q1[1]
; CHECK-NEXT:    vmov q3[3], q3[1], r1, r0
; CHECK-NEXT:    vmullb.s16 q0, q3, q0
; CHECK-NEXT:    vshl.i32 q0, q0, #10
; CHECK-NEXT:    vshr.s32 q0, q0, #10
; CHECK-NEXT:    vshr.s32 q3, q0, #15
; CHECK-NEXT:    vmov r0, r1, d6
; CHECK-NEXT:    vmov.16 q0[0], r0
; CHECK-NEXT:    vmov.16 q0[1], r1
; CHECK-NEXT:    vmov r0, r1, d7
; CHECK-NEXT:    vmov.16 q0[2], r0
; CHECK-NEXT:    vmov.u16 r0, q2[6]
; CHECK-NEXT:    vmov.16 q0[3], r1
; CHECK-NEXT:    vmov.u16 r1, q2[4]
; CHECK-NEXT:    vmov q3[2], q3[0], r1, r0
; CHECK-NEXT:    vmov.u16 r0, q2[7]
; CHECK-NEXT:    vmov.u16 r1, q2[5]
; CHECK-NEXT:    vmov q3[3], q3[1], r1, r0
; CHECK-NEXT:    vmov.u16 r0, q1[6]
; CHECK-NEXT:    vmov.u16 r1, q1[4]
; CHECK-NEXT:    vmov q2[2], q2[0], r1, r0
; CHECK-NEXT:    vmov.u16 r0, q1[7]
; CHECK-NEXT:    vmov.u16 r1, q1[5]
; CHECK-NEXT:    vmov q2[3], q2[1], r1, r0
; CHECK-NEXT:    vmullb.s16 q1, q2, q3
; CHECK-NEXT:    vshl.i32 q1, q1, #10
; CHECK-NEXT:    vshr.s32 q1, q1, #10
; CHECK-NEXT:    vshr.s32 q1, q1, #15
; CHECK-NEXT:    vmov r0, r1, d2
; CHECK-NEXT:    vmov.16 q0[4], r0
; CHECK-NEXT:    vmov.16 q0[5], r1
; CHECK-NEXT:    vmov r0, r1, d3
; CHECK-NEXT:    vmov.16 q0[6], r0
; CHECK-NEXT:    vmov.16 q0[7], r1
; CHECK-NEXT:    bx lr
entry:
  %l2 = sext <8 x i16> %s0 to <8 x i22>
  %l5 = sext <8 x i16> %s1 to <8 x i22>
  %l6 = mul nsw <8 x i22> %l5, %l2
  %l7 = ashr <8 x i22> %l6, <i22 15, i22 15, i22 15, i22 15, i22 15, i22 15, i22 15, i22 15>
  %l8 = icmp slt <8 x i22> %l7, <i22 32767, i22 32767, i22 32767, i22 32767, i22 32767, i22 32767, i22 32767, i22 32767>
  %l9 = select <8 x i1> %l8, <8 x i22> %l7, <8 x i22> <i22 32767, i22 32767, i22 32767, i22 32767, i22 32767, i22 32767, i22 32767, i22 32767>
  %l10 = trunc <8 x i22> %l9 to <8 x i16>
  ret <8 x i16> %l10
}

define arm_aapcs_vfpcc <8 x i16> @vqdmulh_i16_interleaved(<8 x i16> %s0, <8 x i16> %s1) {
; CHECK-LABEL: vqdmulh_i16_interleaved:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqdmulh.s16 q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %0 = shufflevector <8 x i16> %s0, <8 x i16> undef, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 1, i32 3, i32 5, i32 7>
  %1 = sext <8 x i16> %0 to <8 x i32>
  %l2 = sext <8 x i16> %s0 to <8 x i32>
  %2 = shufflevector <8 x i16> %s1, <8 x i16> undef, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 1, i32 3, i32 5, i32 7>
  %3 = sext <8 x i16> %2 to <8 x i32>
  %l5 = sext <8 x i16> %s1 to <8 x i32>
  %l6 = mul nsw <8 x i32> %3, %1
  %l7 = ashr <8 x i32> %l6, <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>
  %l8 = icmp slt <8 x i32> %l7, <i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767>
  %l9 = select <8 x i1> %l8, <8 x i32> %l7, <8 x i32> <i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767>
  %l10 = trunc <8 x i32> %l9 to <8 x i16>
  %4 = shufflevector <8 x i16> %l10, <8 x i16> undef, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  ret <8 x i16> %4
}

define arm_aapcs_vfpcc i64 @vqdmulh_i32(<4 x i32> %s0, <4 x i32> %s1) {
; CHECK-LABEL: vqdmulh_i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqdmulh.s32 q0, q1, q0
; CHECK-NEXT:    vaddlv.s32 r0, r1, q0
; CHECK-NEXT:    bx lr
entry:
  %l2 = sext <4 x i32> %s0 to <4 x i64>
  %l5 = sext <4 x i32> %s1 to <4 x i64>
  %l6 = mul nsw <4 x i64> %l5, %l2
  %l7 = ashr <4 x i64> %l6, <i64 31, i64 31, i64 31, i64 31>
  %l8 = icmp slt <4 x i64> %l7, <i64 2147483647, i64 2147483647, i64 2147483647, i64 2147483647>
  %l9 = select <4 x i1> %l8, <4 x i64> %l7, <4 x i64> <i64 2147483647, i64 2147483647, i64 2147483647, i64 2147483647>
  %l10 = call i64 @llvm.vector.reduce.add.v4i64(<4 x i64> %l9)
  ret i64 %l10
}

define arm_aapcs_vfpcc <4 x i32> @vqdmulh_i32_b(<4 x i32> %s0, <4 x i32> %s1) {
; CHECK-LABEL: vqdmulh_i32_b:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vqdmulh.s32 q0, q1, q0
; CHECK-NEXT:    bx lr
entry:
  %l2 = sext <4 x i32> %s0 to <4 x i64>
  %l5 = sext <4 x i32> %s1 to <4 x i64>
  %l6 = mul nsw <4 x i64> %l5, %l2
  %l7 = ashr <4 x i64> %l6, <i64 31, i64 31, i64 31, i64 31>
  %l8 = icmp slt <4 x i64> %l7, <i64 2147483647, i64 2147483647, i64 2147483647, i64 2147483647>
  %l9 = select <4 x i1> %l8, <4 x i64> %l7, <4 x i64> <i64 2147483647, i64 2147483647, i64 2147483647, i64 2147483647>
  %l10 = trunc <4 x i64> %l9 to <4 x i32>
  ret <4 x i32> %l10
}




define void @vqdmulh_loop_i8(i8* nocapture readonly %x, i8* nocapture readonly %y, i8* noalias nocapture %z, i32 %n) local_unnamed_addr #0 {
; CHECK-LABEL: vqdmulh_loop_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #64
; CHECK-NEXT:  .LBB8_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrb.u8 q0, [r0], #16
; CHECK-NEXT:    vldrb.u8 q1, [r1], #16
; CHECK-NEXT:    vqdmulh.s8 q0, q1, q0
; CHECK-NEXT:    vstrb.8 q0, [r2], #16
; CHECK-NEXT:    le lr, .LBB8_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i8, i8* %x, i32 %index
  %1 = bitcast i8* %0 to <16 x i8>*
  %wide.load = load <16 x i8>, <16 x i8>* %1, align 1
  %2 = sext <16 x i8> %wide.load to <16 x i32>
  %3 = getelementptr inbounds i8, i8* %y, i32 %index
  %4 = bitcast i8* %3 to <16 x i8>*
  %wide.load26 = load <16 x i8>, <16 x i8>* %4, align 1
  %5 = sext <16 x i8> %wide.load26 to <16 x i32>
  %6 = mul nsw <16 x i32> %5, %2
  %7 = ashr <16 x i32> %6, <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  %8 = icmp slt <16 x i32> %7, <i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127>
  %9 = select <16 x i1> %8, <16 x i32> %7, <16 x i32> <i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127>
  %10 = trunc <16 x i32> %9 to <16 x i8>
  %11 = getelementptr inbounds i8, i8* %z, i32 %index
  %12 = bitcast i8* %11 to <16 x i8>*
  store <16 x i8> %10, <16 x i8>* %12, align 1
  %index.next = add i32 %index, 16
  %13 = icmp eq i32 %index.next, 1024
  br i1 %13, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @vqdmulh_loop_i16(i16* nocapture readonly %x, i16* nocapture readonly %y, i16* noalias nocapture %z, i32 %n) {
; CHECK-LABEL: vqdmulh_loop_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #128
; CHECK-NEXT:  .LBB9_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u16 q0, [r0], #16
; CHECK-NEXT:    vldrh.u16 q1, [r1], #16
; CHECK-NEXT:    vqdmulh.s16 q0, q1, q0
; CHECK-NEXT:    vstrb.8 q0, [r2], #16
; CHECK-NEXT:    le lr, .LBB9_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i16, i16* %x, i32 %index
  %1 = bitcast i16* %0 to <8 x i16>*
  %wide.load = load <8 x i16>, <8 x i16>* %1, align 2
  %2 = sext <8 x i16> %wide.load to <8 x i32>
  %3 = getelementptr inbounds i16, i16* %y, i32 %index
  %4 = bitcast i16* %3 to <8 x i16>*
  %wide.load30 = load <8 x i16>, <8 x i16>* %4, align 2
  %5 = sext <8 x i16> %wide.load30 to <8 x i32>
  %6 = mul nsw <8 x i32> %5, %2
  %7 = ashr <8 x i32> %6, <i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15, i32 15>
  %8 = icmp slt <8 x i32> %7, <i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767>
  %9 = select <8 x i1> %8, <8 x i32> %7, <8 x i32> <i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767, i32 32767>
  %10 = trunc <8 x i32> %9 to <8 x i16>
  %11 = getelementptr inbounds i16, i16* %z, i32 %index
  %12 = bitcast i16* %11 to <8 x i16>*
  store <8 x i16> %10, <8 x i16>* %12, align 2
  %index.next = add i32 %index, 8
  %13 = icmp eq i32 %index.next, 1024
  br i1 %13, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @vqdmulh_loop_i32(i32* nocapture readonly %x, i32* nocapture readonly %y, i32* noalias nocapture %z, i32 %n) {
; CHECK-LABEL: vqdmulh_loop_i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #256
; CHECK-NEXT:  .LBB10_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q0, [r0], #16
; CHECK-NEXT:    vldrw.u32 q1, [r1], #16
; CHECK-NEXT:    vqdmulh.s32 q0, q1, q0
; CHECK-NEXT:    vstrb.8 q0, [r2], #16
; CHECK-NEXT:    le lr, .LBB10_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i32, i32* %x, i32 %index
  %1 = bitcast i32* %0 to <4 x i32>*
  %wide.load = load <4 x i32>, <4 x i32>* %1, align 4
  %2 = sext <4 x i32> %wide.load to <4 x i64>
  %3 = getelementptr inbounds i32, i32* %y, i32 %index
  %4 = bitcast i32* %3 to <4 x i32>*
  %wide.load30 = load <4 x i32>, <4 x i32>* %4, align 4
  %5 = sext <4 x i32> %wide.load30 to <4 x i64>
  %6 = mul nsw <4 x i64> %5, %2
  %7 = ashr <4 x i64> %6, <i64 31, i64 31, i64 31, i64 31>
  %8 = icmp slt <4 x i64> %7, <i64 2147483647, i64 2147483647, i64 2147483647, i64 2147483647>
  %9 = select <4 x i1> %8, <4 x i64> %7, <4 x i64> <i64 2147483647, i64 2147483647, i64 2147483647, i64 2147483647>
  %10 = trunc <4 x i64> %9 to <4 x i32>
  %11 = getelementptr inbounds i32, i32* %z, i32 %index
  %12 = bitcast i32* %11 to <4 x i32>*
  store <4 x i32> %10, <4 x i32>* %12, align 4
  %index.next = add i32 %index, 4
  %13 = icmp eq i32 %index.next, 1024
  br i1 %13, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

declare i64 @llvm.vector.reduce.add.v4i64(<4 x i64>)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>)
