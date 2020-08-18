; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=armv8.1m.main -mattr=+mve -tail-predication=enabled --verify-machineinstrs %s -o - | FileCheck %s

define void @arm_cmplx_mag_squared_q15_mve(i16* %pSrc, i16* %pDst, i32 %blockSize) {
; CHECK-LABEL: arm_cmplx_mag_squared_q15_mve:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    subs.w r12, r2, #8
; CHECK-NEXT:    dlstp.16 lr, r2
; CHECK-NEXT:  .LBB0_1: @ %do.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vld20.16 {q0, q1}, [r0]
; CHECK-NEXT:    vld21.16 {q0, q1}, [r0]!
; CHECK-NEXT:    vmulh.s16 q2, q1, q1
; CHECK-NEXT:    vmulh.s16 q0, q0, q0
; CHECK-NEXT:    vqadd.s16 q0, q0, q2
; CHECK-NEXT:    vshr.s16 q0, q0, #1
; CHECK-NEXT:    vstrh.16 q0, [r1], #16
; CHECK-NEXT:    letp lr, .LBB0_1
; CHECK-NEXT:  @ %bb.2: @ %do.end
; CHECK-NEXT:    pop {r7, pc}
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %blockSize.addr.0 = phi i32 [ %blockSize, %entry ], [ %sub, %do.body ]
  %pDst.addr.0 = phi i16* [ %pDst, %entry ], [ %add.ptr7, %do.body ]
  %pSrc.addr.0 = phi i16* [ %pSrc, %entry ], [ %add.ptr, %do.body ]
  %0 = tail call <8 x i1> @llvm.arm.mve.vctp16(i32 %blockSize.addr.0)
  %1 = tail call { <8 x i16>, <8 x i16> } @llvm.arm.mve.vld2q.v8i16.p0i16(i16* %pSrc.addr.0)
  %2 = extractvalue { <8 x i16>, <8 x i16> } %1, 0
  %3 = extractvalue { <8 x i16>, <8 x i16> } %1, 1
  %4 = tail call <8 x i16> @llvm.arm.mve.mulh.predicated.v8i16.v8i1(<8 x i16> %2, <8 x i16> %2, i32 0, <8 x i1> %0, <8 x i16> undef)
  %5 = tail call <8 x i16> @llvm.arm.mve.mulh.predicated.v8i16.v8i1(<8 x i16> %3, <8 x i16> %3, i32 0, <8 x i1> %0, <8 x i16> undef)
  %6 = tail call <8 x i16> @llvm.arm.mve.qadd.predicated.v8i16.v8i1(<8 x i16> %4, <8 x i16> %5, i32 0, <8 x i1> %0, <8 x i16> undef)
  %7 = tail call <8 x i16> @llvm.arm.mve.shr.imm.predicated.v8i16.v8i1(<8 x i16> %6, i32 1, i32 0, <8 x i1> %0, <8 x i16> undef)
  %8 = bitcast i16* %pDst.addr.0 to <8 x i16>*
  tail call void @llvm.masked.store.v8i16.p0v8i16(<8 x i16> %7, <8 x i16>* %8, i32 2, <8 x i1> %0)
  %add.ptr = getelementptr inbounds i16, i16* %pSrc.addr.0, i32 16
  %add.ptr7 = getelementptr inbounds i16, i16* %pDst.addr.0, i32 8
  %sub = add i32 %blockSize.addr.0, -8
  %cmp = icmp sgt i32 %sub, 0
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret void
}

define i32 @bad(i32* readonly %x, i32* nocapture readonly %y, i32 %n) {
; CHECK-LABEL: bad:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov r3, r2
; CHECK-NEXT:    cmp r2, #4
; CHECK-NEXT:    it ge
; CHECK-NEXT:    movge r3, #4
; CHECK-NEXT:    subs r3, r2, r3
; CHECK-NEXT:    add.w r12, r3, #3
; CHECK-NEXT:    movs r3, #1
; CHECK-NEXT:    add.w lr, r3, r12, lsr #2
; CHECK-NEXT:    mov.w r12, #0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:  .LBB1_1: @ %do.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vctp.32 r2
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vldrwt.u32 q0, [r0], #16
; CHECK-NEXT:    vldrw.u32 q1, [r1], #16
; CHECK-NEXT:    subs r2, #4
; CHECK-NEXT:    vmlava.s32 r12, q0, q1
; CHECK-NEXT:    le lr, .LBB1_1
; CHECK-NEXT:  @ %bb.2: @ %do.end
; CHECK-NEXT:    mov r0, r12
; CHECK-NEXT:    pop {r7, pc}
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %s.0 = phi i32 [ 0, %entry ], [ %5, %do.body ]
  %n.addr.0 = phi i32 [ %n, %entry ], [ %sub, %do.body ]
  %y.addr.0 = phi i32* [ %y, %entry ], [ %add.ptr1, %do.body ]
  %x.addr.0 = phi i32* [ %x, %entry ], [ %add.ptr, %do.body ]
  %0 = tail call <4 x i1> @llvm.arm.mve.vctp32(i32 %n.addr.0)
  %1 = bitcast i32* %x.addr.0 to <4 x i32>*
  %2 = tail call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %1, i32 4, <4 x i1> %0, <4 x i32> zeroinitializer)
  %add.ptr = getelementptr inbounds i32, i32* %x.addr.0, i32 4
  %3 = bitcast i32* %y.addr.0 to <4 x i32>*
  %4 = load <4 x i32>, <4 x i32>* %3, align 4
  %add.ptr1 = getelementptr inbounds i32, i32* %y.addr.0, i32 4
  %5 = tail call i32 @llvm.arm.mve.vmldava.v4i32(i32 0, i32 0, i32 0, i32 %s.0, <4 x i32> %2, <4 x i32> %4)
  %sub = add nsw i32 %n.addr.0, -4
  %cmp = icmp sgt i32 %n.addr.0, 4
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret i32 %5
}

define i32 @good(i32* readonly %x, i32* readonly %y, i32 %n) {
; CHECK-LABEL: good:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w r12, #0
; CHECK-NEXT:    dlstp.32 lr, r2
; CHECK-NEXT:  .LBB2_1: @ %do.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q0, [r1], #16
; CHECK-NEXT:    vldrw.u32 q1, [r0], #16
; CHECK-NEXT:    vmlava.s32 r12, q1, q0
; CHECK-NEXT:    letp lr, .LBB2_1
; CHECK-NEXT:  @ %bb.2: @ %do.end
; CHECK-NEXT:    mov r0, r12
; CHECK-NEXT:    pop {r7, pc}
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %s.0 = phi i32 [ 0, %entry ], [ %5, %do.body ]
  %n.addr.0 = phi i32 [ %n, %entry ], [ %sub, %do.body ]
  %y.addr.0 = phi i32* [ %y, %entry ], [ %add.ptr1, %do.body ]
  %x.addr.0 = phi i32* [ %x, %entry ], [ %add.ptr, %do.body ]
  %0 = tail call <4 x i1> @llvm.arm.mve.vctp32(i32 %n.addr.0)
  %1 = bitcast i32* %x.addr.0 to <4 x i32>*
  %2 = tail call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %1, i32 4, <4 x i1> %0, <4 x i32> zeroinitializer)
  %add.ptr = getelementptr inbounds i32, i32* %x.addr.0, i32 4
  %3 = bitcast i32* %y.addr.0 to <4 x i32>*
  %4 = tail call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %3, i32 4, <4 x i1> %0, <4 x i32> zeroinitializer)
  %add.ptr1 = getelementptr inbounds i32, i32* %y.addr.0, i32 4
  %5 = tail call i32 @llvm.arm.mve.vmldava.v4i32(i32 0, i32 0, i32 0, i32 %s.0, <4 x i32> %2, <4 x i32> %4)
  %sub = add nsw i32 %n.addr.0, -4
  %cmp = icmp sgt i32 %n.addr.0, 4
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret i32 %5
}

define i32 @good2(i32* nocapture readonly %x, i32* nocapture readonly %y, i32 %n) {
; CHECK-LABEL: good2:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w r12, #0
; CHECK-NEXT:    dlstp.32 lr, r2
; CHECK-NEXT:  .LBB3_1: @ %do.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q0, [r1], #16
; CHECK-NEXT:    vldrw.u32 q1, [r0], #16
; CHECK-NEXT:    vmlava.s32 r12, q1, q0
; CHECK-NEXT:    letp lr, .LBB3_1
; CHECK-NEXT:  @ %bb.2: @ %do.end
; CHECK-NEXT:    mov r0, r12
; CHECK-NEXT:    pop {r7, pc}
entry:
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %s.0 = phi i32 [ 0, %entry ], [ %5, %do.body ]
  %n.addr.0 = phi i32 [ %n, %entry ], [ %sub, %do.body ]
  %y.addr.0 = phi i32* [ %y, %entry ], [ %add.ptr1, %do.body ]
  %x.addr.0 = phi i32* [ %x, %entry ], [ %add.ptr, %do.body ]
  %0 = tail call <4 x i1> @llvm.arm.mve.vctp32(i32 %n.addr.0)
  %1 = bitcast i32* %x.addr.0 to <4 x i32>*
  %2 = load <4 x i32>, <4 x i32>* %1, align 4
  %add.ptr = getelementptr inbounds i32, i32* %x.addr.0, i32 4
  %3 = bitcast i32* %y.addr.0 to <4 x i32>*
  %4 = load <4 x i32>, <4 x i32>* %3, align 4
  %add.ptr1 = getelementptr inbounds i32, i32* %y.addr.0, i32 4
  %5 = tail call i32 @llvm.arm.mve.vmldava.predicated.v4i32.v4i1(i32 0, i32 0, i32 0, i32 %s.0, <4 x i32> %2, <4 x i32> %4, <4 x i1> %0)
  %sub = add nsw i32 %n.addr.0, -4
  %cmp = icmp sgt i32 %n.addr.0, 4
  br i1 %cmp, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  ret i32 %5
}

declare <8 x i1> @llvm.arm.mve.vctp16(i32)
declare { <8 x i16>, <8 x i16> } @llvm.arm.mve.vld2q.v8i16.p0i16(i16*)
declare <8 x i16> @llvm.arm.mve.mulh.predicated.v8i16.v8i1(<8 x i16>, <8 x i16>, i32, <8 x i1>, <8 x i16>)
declare <8 x i16> @llvm.arm.mve.qadd.predicated.v8i16.v8i1(<8 x i16>, <8 x i16>, i32, <8 x i1>, <8 x i16>)
declare <8 x i16> @llvm.arm.mve.shr.imm.predicated.v8i16.v8i1(<8 x i16>, i32, i32, <8 x i1>, <8 x i16>)
declare void @llvm.masked.store.v8i16.p0v8i16(<8 x i16>, <8 x i16>*, i32 immarg, <8 x i1>)
declare i32 @llvm.arm.mve.vmldava.predicated.v4i32.v4i1(i32, i32, i32, i32, <4 x i32>, <4 x i32>, <4 x i1>)
declare <4 x i1> @llvm.arm.mve.vctp32(i32) #1
declare <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>*, i32 immarg, <4 x i1>, <4 x i32>) #2
declare i32 @llvm.arm.mve.vmldava.v4i32(i32, i32, i32, i32, <4 x i32>, <4 x i32>) #1
