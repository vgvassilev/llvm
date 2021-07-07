; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp -enable-arm-maskedldst %s -o - | FileCheck %s


define arm_aapcs_vfpcc void @scatter_inc_minipred_4i32(<4 x i32> %data, i32* %dst, <4 x i32> %offs) {
; CHECK-LABEL: scatter_inc_minipred_4i32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    movw r1, #3855
; CHECK-NEXT:    vmov.i32 q2, #0x4
; CHECK-NEXT:    vadd.i32 q1, q1, q2
; CHECK-NEXT:    vmsr p0, r1
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vstrwt.32 q0, [r0, q1, uxtw #2]
; CHECK-NEXT:    bx lr
  %1 = add <4 x i32> %offs, <i32 4, i32 4, i32 4, i32 4>
  %2 = getelementptr inbounds i32, i32* %dst, <4 x i32> %1
  call void @llvm.masked.scatter.v4i32.v4p0i32(<4 x i32> %data, <4 x i32*> %2, i32 4, <4 x i1> <i1 true, i1 false, i1 true, i1 false>)
  ret void
}

define arm_aapcs_vfpcc void @scatter_inc_mini_8i16(<8 x i16> %data, i16* %dst, <8 x i32> %offs) {
; CHECK-LABEL: scatter_inc_mini_8i16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r6, lr}
; CHECK-NEXT:    push {r4, r5, r6, lr}
; CHECK-NEXT:    vshl.i32 q1, q1, #1
; CHECK-NEXT:    vmov.i32 q3, #0x10
; CHECK-NEXT:    vadd.i32 q1, q1, r0
; CHECK-NEXT:    vmov.u16 r6, q0[0]
; CHECK-NEXT:    vadd.i32 q1, q1, q3
; CHECK-NEXT:    vmov r1, r2, d2
; CHECK-NEXT:    vmov r3, r12, d3
; CHECK-NEXT:    vshl.i32 q1, q2, #1
; CHECK-NEXT:    vadd.i32 q1, q1, r0
; CHECK-NEXT:    vadd.i32 q1, q1, q3
; CHECK-NEXT:    vmov r0, lr, d2
; CHECK-NEXT:    vmov r4, r5, d3
; CHECK-NEXT:    strh r6, [r1]
; CHECK-NEXT:    vmov.u16 r1, q0[1]
; CHECK-NEXT:    strh r1, [r2]
; CHECK-NEXT:    vmov.u16 r1, q0[2]
; CHECK-NEXT:    strh r1, [r3]
; CHECK-NEXT:    vmov.u16 r1, q0[3]
; CHECK-NEXT:    strh.w r1, [r12]
; CHECK-NEXT:    vmov.u16 r1, q0[4]
; CHECK-NEXT:    strh r1, [r0]
; CHECK-NEXT:    vmov.u16 r0, q0[5]
; CHECK-NEXT:    strh.w r0, [lr]
; CHECK-NEXT:    vmov.u16 r0, q0[6]
; CHECK-NEXT:    strh r0, [r4]
; CHECK-NEXT:    vmov.u16 r0, q0[7]
; CHECK-NEXT:    strh r0, [r5]
; CHECK-NEXT:    pop {r4, r5, r6, pc}
  %1 = add <8 x i32> %offs, <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>
  %2 = getelementptr inbounds i16, i16* %dst, <8 x i32> %1
  call void @llvm.masked.scatter.v8i16.v8p0i16(<8 x i16> %data, <8 x i16*> %2, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>)
  ret void
}

define arm_aapcs_vfpcc void @scatter_inc_mini_16i8(<16 x i8> %data, i8* %dst, <16 x i32> %offs) {
; CHECK-LABEL: scatter_inc_mini_16i8:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r6, r7, r8, r9, lr}
; CHECK-NEXT:    push.w {r4, r5, r6, r7, r8, r9, lr}
; CHECK-NEXT:    .pad #4
; CHECK-NEXT:    sub sp, #4
; CHECK-NEXT:    .vsave {d8, d9}
; CHECK-NEXT:    vpush {d8, d9}
; CHECK-NEXT:    vmov.i32 q4, #0x10
; CHECK-NEXT:    vadd.i32 q1, q1, r0
; CHECK-NEXT:    vadd.i32 q1, q1, q4
; CHECK-NEXT:    add r5, sp, #48
; CHECK-NEXT:    vmov r1, r2, d2
; CHECK-NEXT:    vadd.i32 q3, q3, r0
; CHECK-NEXT:    vmov r3, r12, d3
; CHECK-NEXT:    vadd.i32 q1, q2, r0
; CHECK-NEXT:    vadd.i32 q2, q1, q4
; CHECK-NEXT:    vldrw.u32 q1, [r5]
; CHECK-NEXT:    vmov lr, r7, d4
; CHECK-NEXT:    vmov.u8 r6, q0[0]
; CHECK-NEXT:    vadd.i32 q1, q1, r0
; CHECK-NEXT:    vmov r0, r8, d5
; CHECK-NEXT:    vadd.i32 q2, q3, q4
; CHECK-NEXT:    vmov.u8 r4, q0[4]
; CHECK-NEXT:    vadd.i32 q1, q1, q4
; CHECK-NEXT:    vmov.u8 r5, q0[6]
; CHECK-NEXT:    strb r6, [r1]
; CHECK-NEXT:    vmov.u8 r1, q0[1]
; CHECK-NEXT:    strb r1, [r2]
; CHECK-NEXT:    vmov.u8 r6, q0[2]
; CHECK-NEXT:    vmov r1, r9, d4
; CHECK-NEXT:    strb r6, [r3]
; CHECK-NEXT:    vmov.u8 r3, q0[3]
; CHECK-NEXT:    vmov.u8 r2, q0[8]
; CHECK-NEXT:    strb.w r3, [r12]
; CHECK-NEXT:    vmov r3, r6, d5
; CHECK-NEXT:    strb.w r4, [lr]
; CHECK-NEXT:    vmov.u8 r4, q0[5]
; CHECK-NEXT:    strb r4, [r7]
; CHECK-NEXT:    vmov r7, r4, d2
; CHECK-NEXT:    strb r5, [r0]
; CHECK-NEXT:    vmov.u8 r0, q0[7]
; CHECK-NEXT:    strb.w r0, [r8]
; CHECK-NEXT:    vmov r0, r5, d3
; CHECK-NEXT:    strb r2, [r1]
; CHECK-NEXT:    vmov.u8 r1, q0[9]
; CHECK-NEXT:    strb.w r1, [r9]
; CHECK-NEXT:    vmov.u8 r1, q0[10]
; CHECK-NEXT:    strb r1, [r3]
; CHECK-NEXT:    vmov.u8 r1, q0[11]
; CHECK-NEXT:    strb r1, [r6]
; CHECK-NEXT:    vmov.u8 r1, q0[12]
; CHECK-NEXT:    strb r1, [r7]
; CHECK-NEXT:    vmov.u8 r1, q0[13]
; CHECK-NEXT:    strb r1, [r4]
; CHECK-NEXT:    vmov.u8 r1, q0[14]
; CHECK-NEXT:    strb r1, [r0]
; CHECK-NEXT:    vmov.u8 r0, q0[15]
; CHECK-NEXT:    strb r0, [r5]
; CHECK-NEXT:    vpop {d8, d9}
; CHECK-NEXT:    add sp, #4
; CHECK-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, pc}
  %1 = add <16 x i32> %offs, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %2 = getelementptr inbounds i8, i8* %dst, <16 x i32> %1
  call void @llvm.masked.scatter.v16i8.v16p0i8(<16 x i8> %data, <16 x i8*> %2, i32 2, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>)
  ret void
}

define arm_aapcs_vfpcc void @scatter_inc_v4i32_complex(<4 x i32> %data1, <4 x i32> %data2, <4 x i32> %data3, i32* %dst, i32 %n) {
; CHECK-LABEL: scatter_inc_v4i32_complex:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, lr}
; CHECK-NEXT:    push {r4, lr}
; CHECK-NEXT:    .vsave {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    vpush {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    .pad #16
; CHECK-NEXT:    sub sp, #16
; CHECK-NEXT:    cmp r1, #1
; CHECK-NEXT:    blt .LBB3_5
; CHECK-NEXT:  @ %bb.1: @ %vector.ph.preheader
; CHECK-NEXT:    adr r4, .LCPI3_2
; CHECK-NEXT:    bic r2, r1, #3
; CHECK-NEXT:    vldrw.u32 q3, [r4]
; CHECK-NEXT:    sub.w r12, r2, #4
; CHECK-NEXT:    adr.w lr, .LCPI3_1
; CHECK-NEXT:    movs r3, #1
; CHECK-NEXT:    vadd.i32 q3, q3, r0
; CHECK-NEXT:    add.w r3, r3, r12, lsr #2
; CHECK-NEXT:    vstrw.32 q3, [sp] @ 16-byte Spill
; CHECK-NEXT:    vldrw.u32 q3, [lr]
; CHECK-NEXT:    adr.w r12, .LCPI3_0
; CHECK-NEXT:    vadd.i32 q4, q3, r0
; CHECK-NEXT:    vldrw.u32 q3, [r12]
; CHECK-NEXT:    vadd.i32 q3, q3, r0
; CHECK-NEXT:  .LBB3_2: @ %vector.ph
; CHECK-NEXT:    @ =>This Loop Header: Depth=1
; CHECK-NEXT:    @ Child Loop BB3_3 Depth 2
; CHECK-NEXT:    dls lr, r3
; CHECK-NEXT:    vmov q6, q4
; CHECK-NEXT:    vldrw.u32 q7, [sp] @ 16-byte Reload
; CHECK-NEXT:    vmov q5, q3
; CHECK-NEXT:  .LBB3_3: @ %vector.body
; CHECK-NEXT:    @ Parent Loop BB3_2 Depth=1
; CHECK-NEXT:    @ => This Inner Loop Header: Depth=2
; CHECK-NEXT:    vstrw.32 q0, [q5, #48]!
; CHECK-NEXT:    vstrw.32 q1, [q6, #48]!
; CHECK-NEXT:    vstrw.32 q2, [q7, #48]!
; CHECK-NEXT:    le lr, .LBB3_3
; CHECK-NEXT:  @ %bb.4: @ %middle.block
; CHECK-NEXT:    @ in Loop: Header=BB3_2 Depth=1
; CHECK-NEXT:    cmp r2, r1
; CHECK-NEXT:    bne .LBB3_2
; CHECK-NEXT:  .LBB3_5: @ %for.cond.cleanup
; CHECK-NEXT:    add sp, #16
; CHECK-NEXT:    vpop {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    pop {r4, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.6:
; CHECK-NEXT:  .LCPI3_0:
; CHECK-NEXT:    .long 4294967248 @ 0xffffffd0
; CHECK-NEXT:    .long 4294967260 @ 0xffffffdc
; CHECK-NEXT:    .long 4294967272 @ 0xffffffe8
; CHECK-NEXT:    .long 4294967284 @ 0xfffffff4
; CHECK-NEXT:  .LCPI3_1:
; CHECK-NEXT:    .long 4294967252 @ 0xffffffd4
; CHECK-NEXT:    .long 4294967264 @ 0xffffffe0
; CHECK-NEXT:    .long 4294967276 @ 0xffffffec
; CHECK-NEXT:    .long 4294967288 @ 0xfffffff8
; CHECK-NEXT:  .LCPI3_2:
; CHECK-NEXT:    .long 4294967256 @ 0xffffffd8
; CHECK-NEXT:    .long 4294967268 @ 0xffffffe4
; CHECK-NEXT:    .long 4294967280 @ 0xfffffff0
; CHECK-NEXT:    .long 4294967292 @ 0xfffffffc
entry:
  %cmp22 = icmp sgt i32 %n, 0
  br i1 %cmp22, label %vector.ph, label %for.cond.cleanup

vector.ph:                                        ; preds = %for.body.preheader
  %n.vec = and i32 %n, -4
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %0 = mul nuw nsw <4 x i32> %vec.ind, <i32 3, i32 3, i32 3, i32 3>
  %1 = getelementptr inbounds i32, i32* %dst, <4 x i32> %0
  call void @llvm.masked.scatter.v4i32.v4p0i32(<4 x i32> %data1, <4 x i32*> %1, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>)
  %2 = add nuw nsw <4 x i32> %0, <i32 1, i32 1, i32 1, i32 1>
  %3 = getelementptr inbounds i32, i32* %dst, <4 x i32> %2
  call void @llvm.masked.scatter.v4i32.v4p0i32(<4 x i32> %data2, <4 x i32*> %3, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>)
  %4 = add nuw nsw <4 x i32> %0, <i32 2, i32 2, i32 2, i32 2>
  %5 = getelementptr inbounds i32, i32* %dst, <4 x i32> %4
  call void @llvm.masked.scatter.v4i32.v4p0i32(<4 x i32> %data3, <4 x i32*> %5, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>)
  %index.next = add i32 %index, 4
  %vec.ind.next = add <4 x i32> %vec.ind, <i32 4, i32 4, i32 4, i32 4>
  %6 = icmp eq i32 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %n
  br i1 %cmp.n, label %for.cond.cleanup, label %vector.ph

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  ret void
}

define arm_aapcs_vfpcc void @scatter_inc_v4i32_complex_opaque(<4 x i32> %data1, <4 x i32> %data2, <4 x i32> %data3, ptr %dst, i32 %n) {
; CHECK-LABEL: scatter_inc_v4i32_complex_opaque:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, lr}
; CHECK-NEXT:    push {r4, lr}
; CHECK-NEXT:    .vsave {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    vpush {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    .pad #16
; CHECK-NEXT:    sub sp, #16
; CHECK-NEXT:    cmp r1, #1
; CHECK-NEXT:    blt .LBB4_5
; CHECK-NEXT:  @ %bb.1: @ %vector.ph.preheader
; CHECK-NEXT:    adr r4, .LCPI4_2
; CHECK-NEXT:    bic r2, r1, #3
; CHECK-NEXT:    vldrw.u32 q3, [r4]
; CHECK-NEXT:    sub.w r12, r2, #4
; CHECK-NEXT:    adr.w lr, .LCPI4_1
; CHECK-NEXT:    movs r3, #1
; CHECK-NEXT:    vadd.i32 q3, q3, r0
; CHECK-NEXT:    add.w r3, r3, r12, lsr #2
; CHECK-NEXT:    vstrw.32 q3, [sp] @ 16-byte Spill
; CHECK-NEXT:    vldrw.u32 q3, [lr]
; CHECK-NEXT:    adr.w r12, .LCPI4_0
; CHECK-NEXT:    vadd.i32 q4, q3, r0
; CHECK-NEXT:    vldrw.u32 q3, [r12]
; CHECK-NEXT:    vadd.i32 q3, q3, r0
; CHECK-NEXT:  .LBB4_2: @ %vector.ph
; CHECK-NEXT:    @ =>This Loop Header: Depth=1
; CHECK-NEXT:    @ Child Loop BB4_3 Depth 2
; CHECK-NEXT:    dls lr, r3
; CHECK-NEXT:    vmov q6, q4
; CHECK-NEXT:    vldrw.u32 q7, [sp] @ 16-byte Reload
; CHECK-NEXT:    vmov q5, q3
; CHECK-NEXT:  .LBB4_3: @ %vector.body
; CHECK-NEXT:    @ Parent Loop BB4_2 Depth=1
; CHECK-NEXT:    @ => This Inner Loop Header: Depth=2
; CHECK-NEXT:    vstrw.32 q0, [q5, #48]!
; CHECK-NEXT:    vstrw.32 q1, [q6, #48]!
; CHECK-NEXT:    vstrw.32 q2, [q7, #48]!
; CHECK-NEXT:    le lr, .LBB4_3
; CHECK-NEXT:  @ %bb.4: @ %middle.block
; CHECK-NEXT:    @ in Loop: Header=BB4_2 Depth=1
; CHECK-NEXT:    cmp r2, r1
; CHECK-NEXT:    bne .LBB4_2
; CHECK-NEXT:  .LBB4_5: @ %for.cond.cleanup
; CHECK-NEXT:    add sp, #16
; CHECK-NEXT:    vpop {d8, d9, d10, d11, d12, d13, d14, d15}
; CHECK-NEXT:    pop {r4, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.6:
; CHECK-NEXT:  .LCPI4_0:
; CHECK-NEXT:    .long 4294967248 @ 0xffffffd0
; CHECK-NEXT:    .long 4294967260 @ 0xffffffdc
; CHECK-NEXT:    .long 4294967272 @ 0xffffffe8
; CHECK-NEXT:    .long 4294967284 @ 0xfffffff4
; CHECK-NEXT:  .LCPI4_1:
; CHECK-NEXT:    .long 4294967252 @ 0xffffffd4
; CHECK-NEXT:    .long 4294967264 @ 0xffffffe0
; CHECK-NEXT:    .long 4294967276 @ 0xffffffec
; CHECK-NEXT:    .long 4294967288 @ 0xfffffff8
; CHECK-NEXT:  .LCPI4_2:
; CHECK-NEXT:    .long 4294967256 @ 0xffffffd8
; CHECK-NEXT:    .long 4294967268 @ 0xffffffe4
; CHECK-NEXT:    .long 4294967280 @ 0xfffffff0
; CHECK-NEXT:    .long 4294967292 @ 0xfffffffc
entry:
  %cmp22 = icmp sgt i32 %n, 0
  br i1 %cmp22, label %vector.ph, label %for.cond.cleanup

vector.ph:                                        ; preds = %for.body.preheader
  %n.vec = and i32 %n, -4
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.ind = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %0 = mul nuw nsw <4 x i32> %vec.ind, <i32 3, i32 3, i32 3, i32 3>
  %1 = getelementptr inbounds i32, ptr %dst, <4 x i32> %0
  call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> %data1, <4 x ptr> %1, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>)
  %2 = add nuw nsw <4 x i32> %0, <i32 1, i32 1, i32 1, i32 1>
  %3 = getelementptr inbounds i32, ptr %dst, <4 x i32> %2
  call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> %data2, <4 x ptr> %3, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>)
  %4 = add nuw nsw <4 x i32> %0, <i32 2, i32 2, i32 2, i32 2>
  %5 = getelementptr inbounds i32, ptr %dst, <4 x i32> %4
  call void @llvm.masked.scatter.v4i32.v4p0(<4 x i32> %data3, <4 x ptr> %5, i32 4, <4 x i1> <i1 true, i1 true, i1 true, i1 true>)
  %index.next = add i32 %index, 4
  %vec.ind.next = add <4 x i32> %vec.ind, <i32 4, i32 4, i32 4, i32 4>
  %6 = icmp eq i32 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %n
  br i1 %cmp.n, label %for.cond.cleanup, label %vector.ph

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  ret void
}

declare void @llvm.masked.scatter.v8i8.v8p0i8(<8 x i8>, <8 x i8*>, i32, <8 x i1>)
declare void @llvm.masked.scatter.v8i16.v8p0i16(<8 x i16>, <8 x i16*>, i32, <8 x i1>)
declare void @llvm.masked.scatter.v8f16.v8p0f16(<8 x half>, <8 x half*>, i32, <8 x i1>)
declare void @llvm.masked.scatter.v16i8.v16p0i8(<16 x i8>, <16 x i8*>, i32, <16 x i1>)
declare void @llvm.masked.scatter.v4i8.v4p0i8(<4 x i8>, <4 x i8*>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v4i16.v4p0i16(<4 x i16>, <4 x i16*>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v4f16.v4p0f16(<4 x half>, <4 x half*>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v4i32.v4p0i32(<4 x i32>, <4 x i32*>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v4i32.v4p0(<4 x i32>, <4 x ptr>, i32, <4 x i1>)
declare void @llvm.masked.scatter.v4f32.v4p0f32(<4 x float>, <4 x float*>, i32, <4 x i1>)
