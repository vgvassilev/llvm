; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main -mattr=+mve.fp,+fp-armv8d16sp,+fp16,+fullfp16 -tail-predication=enabled %s -o - | FileCheck %s

define arm_aapcs_vfpcc void @fast_float_mul(float* nocapture %a, float* nocapture readonly %b, float* nocapture readonly %c, i32 %N) {
; CHECK-LABEL: fast_float_mul:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r4, r5, r6, r7, lr}
; CHECK-NEXT:    cmp r3, #0
; CHECK-NEXT:    beq.w .LBB0_11
; CHECK-NEXT:  @ %bb.1: @ %vector.memcheck
; CHECK-NEXT:    add.w r5, r0, r3, lsl #2
; CHECK-NEXT:    add.w r4, r2, r3, lsl #2
; CHECK-NEXT:    cmp r5, r2
; CHECK-NEXT:    cset r12, hi
; CHECK-NEXT:    cmp r4, r0
; CHECK-NEXT:    cset lr, hi
; CHECK-NEXT:    cmp r5, r1
; CHECK-NEXT:    add.w r5, r1, r3, lsl #2
; CHECK-NEXT:    cset r4, hi
; CHECK-NEXT:    cmp r5, r0
; CHECK-NEXT:    cset r5, hi
; CHECK-NEXT:    tst r5, r4
; CHECK-NEXT:    it eq
; CHECK-NEXT:    andseq.w r5, lr, r12
; CHECK-NEXT:    beq .LBB0_4
; CHECK-NEXT:  @ %bb.2: @ %for.body.preheader
; CHECK-NEXT:    subs r5, r3, #1
; CHECK-NEXT:    and r12, r3, #3
; CHECK-NEXT:    cmp r5, #3
; CHECK-NEXT:    bhs .LBB0_6
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:    movs r3, #0
; CHECK-NEXT:    b .LBB0_8
; CHECK-NEXT:  .LBB0_4: @ %vector.ph
; CHECK-NEXT:    mov.w r12, #0
; CHECK-NEXT:    dlstp.32 lr, r3
; CHECK-NEXT:  .LBB0_5: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    add.w r12, r12, #4
; CHECK-NEXT:    vldrw.u32 q0, [r1], #16
; CHECK-NEXT:    vldrw.u32 q1, [r2], #16
; CHECK-NEXT:    vmul.f32 q0, q1, q0
; CHECK-NEXT:    vstrw.32 q0, [r0], #16
; CHECK-NEXT:    letp lr, .LBB0_5
; CHECK-NEXT:    b .LBB0_11
; CHECK-NEXT:  .LBB0_6: @ %for.body.preheader.new
; CHECK-NEXT:    sub.w lr, r3, r12
; CHECK-NEXT:    movs r4, #0
; CHECK-NEXT:    movs r3, #0
; CHECK-NEXT:  .LBB0_7: @ %for.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    adds r5, r1, r4
; CHECK-NEXT:    adds r6, r2, r4
; CHECK-NEXT:    adds r7, r0, r4
; CHECK-NEXT:    adds r3, #4
; CHECK-NEXT:    vldr s0, [r5]
; CHECK-NEXT:    adds r4, #16
; CHECK-NEXT:    vldr s2, [r6]
; CHECK-NEXT:    cmp lr, r3
; CHECK-NEXT:    vmul.f32 s0, s2, s0
; CHECK-NEXT:    vstr s0, [r7]
; CHECK-NEXT:    vldr s0, [r5, #4]
; CHECK-NEXT:    vldr s2, [r6, #4]
; CHECK-NEXT:    vmul.f32 s0, s2, s0
; CHECK-NEXT:    vstr s0, [r7, #4]
; CHECK-NEXT:    vldr s0, [r5, #8]
; CHECK-NEXT:    vldr s2, [r6, #8]
; CHECK-NEXT:    vmul.f32 s0, s2, s0
; CHECK-NEXT:    vstr s0, [r7, #8]
; CHECK-NEXT:    vldr s0, [r5, #12]
; CHECK-NEXT:    vldr s2, [r6, #12]
; CHECK-NEXT:    vmul.f32 s0, s2, s0
; CHECK-NEXT:    vstr s0, [r7, #12]
; CHECK-NEXT:    bne .LBB0_7
; CHECK-NEXT:  .LBB0_8: @ %for.cond.cleanup.loopexit.unr-lcssa
; CHECK-NEXT:    wls lr, r12, .LBB0_11
; CHECK-NEXT:  @ %bb.9: @ %for.body.epil.preheader
; CHECK-NEXT:    add.w r1, r1, r3, lsl #2
; CHECK-NEXT:    add.w r2, r2, r3, lsl #2
; CHECK-NEXT:    add.w r0, r0, r3, lsl #2
; CHECK-NEXT:  .LBB0_10: @ %for.body.epil
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldmia r1!, {s0}
; CHECK-NEXT:    vldmia r2!, {s2}
; CHECK-NEXT:    vmul.f32 s0, s2, s0
; CHECK-NEXT:    vstmia r0!, {s0}
; CHECK-NEXT:    le lr, .LBB0_10
; CHECK-NEXT:  .LBB0_11: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r4, r5, r6, r7, pc}
entry:
  %cmp8 = icmp eq i32 %N, 0
  br i1 %cmp8, label %for.cond.cleanup, label %vector.memcheck

vector.memcheck:                                  ; preds = %entry
  %scevgep = getelementptr float, float* %a, i32 %N
  %scevgep13 = getelementptr float, float* %b, i32 %N
  %scevgep16 = getelementptr float, float* %c, i32 %N
  %bound0 = icmp ugt float* %scevgep13, %a
  %bound1 = icmp ugt float* %scevgep, %b
  %found.conflict = and i1 %bound0, %bound1
  %bound018 = icmp ugt float* %scevgep16, %a
  %bound119 = icmp ugt float* %scevgep, %c
  %found.conflict20 = and i1 %bound018, %bound119
  %conflict.rdx = or i1 %found.conflict, %found.conflict20
  br i1 %conflict.rdx, label %for.body.preheader, label %vector.ph

for.body.preheader:                               ; preds = %vector.memcheck
  %0 = add i32 %N, -1
  %xtraiter = and i32 %N, 3
  %1 = icmp ult i32 %0, 3
  br i1 %1, label %for.cond.cleanup.loopexit.unr-lcssa, label %for.body.preheader.new

for.body.preheader.new:                           ; preds = %for.body.preheader
  %unroll_iter = sub i32 %N, %xtraiter
  br label %for.body

vector.ph:                                        ; preds = %vector.memcheck
  %n.rnd.up = add i32 %N, 3
  %n.vec = and i32 %n.rnd.up, -4
  %trip.count.minus.1 = add i32 %N, -1
  %broadcast.splatinsert21 = insertelement <4 x i32> undef, i32 %trip.count.minus.1, i32 0
  %broadcast.splat22 = shufflevector <4 x i32> %broadcast.splatinsert21, <4 x i32> undef, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %index, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %induction = add <4 x i32> %broadcast.splat, <i32 0, i32 1, i32 2, i32 3>
  %2 = getelementptr inbounds float, float* %b, i32 %index

  ; %3 = icmp ule <4 x i32> %induction, %broadcast.splat22
  %3 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 %index, i32 %N)

  %4 = bitcast float* %2 to <4 x float>*
  %wide.masked.load = call <4 x float> @llvm.masked.load.v4f32.p0v4f32(<4 x float>* %4, i32 4, <4 x i1> %3, <4 x float> undef)
  %5 = getelementptr inbounds float, float* %c, i32 %index
  %6 = bitcast float* %5 to <4 x float>*
  %wide.masked.load23 = call <4 x float> @llvm.masked.load.v4f32.p0v4f32(<4 x float>* %6, i32 4, <4 x i1> %3, <4 x float> undef)
  %7 = fmul fast <4 x float> %wide.masked.load23, %wide.masked.load
  %8 = getelementptr inbounds float, float* %a, i32 %index
  %9 = bitcast float* %8 to <4 x float>*
  call void @llvm.masked.store.v4f32.p0v4f32(<4 x float> %7, <4 x float>* %9, i32 4, <4 x i1> %3)
  %index.next = add i32 %index, 4
  %10 = icmp eq i32 %index.next, %n.vec
  br i1 %10, label %for.cond.cleanup, label %vector.body

for.cond.cleanup.loopexit.unr-lcssa:              ; preds = %for.body, %for.body.preheader
  %i.09.unr = phi i32 [ 0, %for.body.preheader ], [ %inc.3, %for.body ]
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %for.cond.cleanup, label %for.body.epil

for.body.epil:                                    ; preds = %for.cond.cleanup.loopexit.unr-lcssa, %for.body.epil
  %i.09.epil = phi i32 [ %inc.epil, %for.body.epil ], [ %i.09.unr, %for.cond.cleanup.loopexit.unr-lcssa ]
  %epil.iter = phi i32 [ %epil.iter.sub, %for.body.epil ], [ %xtraiter, %for.cond.cleanup.loopexit.unr-lcssa ]
  %arrayidx.epil = getelementptr inbounds float, float* %b, i32 %i.09.epil
  %11 = load float, float* %arrayidx.epil, align 4
  %arrayidx1.epil = getelementptr inbounds float, float* %c, i32 %i.09.epil
  %12 = load float, float* %arrayidx1.epil, align 4
  %mul.epil = fmul fast float %12, %11
  %arrayidx2.epil = getelementptr inbounds float, float* %a, i32 %i.09.epil
  store float %mul.epil, float* %arrayidx2.epil, align 4
  %inc.epil = add nuw i32 %i.09.epil, 1
  %epil.iter.sub = add i32 %epil.iter, -1
  %epil.iter.cmp = icmp eq i32 %epil.iter.sub, 0
  br i1 %epil.iter.cmp, label %for.cond.cleanup, label %for.body.epil

for.cond.cleanup:                                 ; preds = %vector.body, %for.cond.cleanup.loopexit.unr-lcssa, %for.body.epil, %entry
  ret void

for.body:                                         ; preds = %for.body, %for.body.preheader.new
  %i.09 = phi i32 [ 0, %for.body.preheader.new ], [ %inc.3, %for.body ]
  %niter = phi i32 [ %unroll_iter, %for.body.preheader.new ], [ %niter.nsub.3, %for.body ]
  %arrayidx = getelementptr inbounds float, float* %b, i32 %i.09
  %13 = load float, float* %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds float, float* %c, i32 %i.09
  %14 = load float, float* %arrayidx1, align 4
  %mul = fmul fast float %14, %13
  %arrayidx2 = getelementptr inbounds float, float* %a, i32 %i.09
  store float %mul, float* %arrayidx2, align 4
  %inc = or i32 %i.09, 1
  %arrayidx.1 = getelementptr inbounds float, float* %b, i32 %inc
  %15 = load float, float* %arrayidx.1, align 4
  %arrayidx1.1 = getelementptr inbounds float, float* %c, i32 %inc
  %16 = load float, float* %arrayidx1.1, align 4
  %mul.1 = fmul fast float %16, %15
  %arrayidx2.1 = getelementptr inbounds float, float* %a, i32 %inc
  store float %mul.1, float* %arrayidx2.1, align 4
  %inc.1 = or i32 %i.09, 2
  %arrayidx.2 = getelementptr inbounds float, float* %b, i32 %inc.1
  %17 = load float, float* %arrayidx.2, align 4
  %arrayidx1.2 = getelementptr inbounds float, float* %c, i32 %inc.1
  %18 = load float, float* %arrayidx1.2, align 4
  %mul.2 = fmul fast float %18, %17
  %arrayidx2.2 = getelementptr inbounds float, float* %a, i32 %inc.1
  store float %mul.2, float* %arrayidx2.2, align 4
  %inc.2 = or i32 %i.09, 3
  %arrayidx.3 = getelementptr inbounds float, float* %b, i32 %inc.2
  %19 = load float, float* %arrayidx.3, align 4
  %arrayidx1.3 = getelementptr inbounds float, float* %c, i32 %inc.2
  %20 = load float, float* %arrayidx1.3, align 4
  %mul.3 = fmul fast float %20, %19
  %arrayidx2.3 = getelementptr inbounds float, float* %a, i32 %inc.2
  store float %mul.3, float* %arrayidx2.3, align 4
  %inc.3 = add nuw i32 %i.09, 4
  %niter.nsub.3 = add i32 %niter, -4
  %niter.ncmp.3 = icmp eq i32 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %for.cond.cleanup.loopexit.unr-lcssa, label %for.body
}

define arm_aapcs_vfpcc float @fast_float_mac(float* nocapture readonly %b, float* nocapture readonly %c, i32 %N) {
; CHECK-LABEL: fast_float_mac:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    cbz r2, .LBB1_4
; CHECK-NEXT:  @ %bb.1: @ %vector.ph
; CHECK-NEXT:    adds r3, r2, #3
; CHECK-NEXT:    mov.w r12, #1
; CHECK-NEXT:    bic r3, r3, #3
; CHECK-NEXT:    vmov.i32 q0, #0x0
; CHECK-NEXT:    subs r3, #4
; CHECK-NEXT:    add.w r12, r12, r3, lsr #2
; CHECK-NEXT:    movs r3, #0
; CHECK-NEXT:    dls lr, r12
; CHECK-NEXT:  .LBB1_2: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vctp.32 r2
; CHECK-NEXT:    adds r3, #4
; CHECK-NEXT:    subs r2, #4
; CHECK-NEXT:    vmov q1, q0
; CHECK-NEXT:    vpstt
; CHECK-NEXT:    vldrwt.u32 q2, [r0], #16
; CHECK-NEXT:    vldrwt.u32 q3, [r1], #16
; CHECK-NEXT:    vfma.f32 q0, q3, q2
; CHECK-NEXT:    le lr, .LBB1_2
; CHECK-NEXT:  @ %bb.3: @ %middle.block
; CHECK-NEXT:    vpsel q0, q0, q1
; CHECK-NEXT:    vmov.f32 s4, s2
; CHECK-NEXT:    vmov.f32 s5, s3
; CHECK-NEXT:    vadd.f32 q0, q0, q1
; CHECK-NEXT:    vmov r0, s1
; CHECK-NEXT:    vadd.f32 q0, q0, r0
; CHECK-NEXT:    @ kill: def $s0 killed $s0 killed $q0
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:  .LBB1_4:
; CHECK-NEXT:    vldr s0, .LCPI1_0
; CHECK-NEXT:    @ kill: def $s0 killed $s0 killed $q0
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.5:
; CHECK-NEXT:  .LCPI1_0:
; CHECK-NEXT:    .long 0x00000000 @ float 0
entry:
  %cmp8 = icmp eq i32 %N, 0
  br i1 %cmp8, label %for.cond.cleanup, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.rnd.up = add i32 %N, 3
  %n.vec = and i32 %n.rnd.up, -4
  %trip.count.minus.1 = add i32 %N, -1
  %broadcast.splatinsert11 = insertelement <4 x i32> undef, i32 %trip.count.minus.1, i32 0
  %broadcast.splat12 = shufflevector <4 x i32> %broadcast.splatinsert11, <4 x i32> undef, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <4 x float> [ zeroinitializer, %vector.ph ], [ %6, %vector.body ]
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %index, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %induction = add <4 x i32> %broadcast.splat, <i32 0, i32 1, i32 2, i32 3>
  %0 = getelementptr inbounds float, float* %b, i32 %index

;  %1 = icmp ule <4 x i32> %induction, %broadcast.splat12
  %1 = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 %index, i32 %N)

  %2 = bitcast float* %0 to <4 x float>*
  %wide.masked.load = call <4 x float> @llvm.masked.load.v4f32.p0v4f32(<4 x float>* %2, i32 4, <4 x i1> %1, <4 x float> undef)
  %3 = getelementptr inbounds float, float* %c, i32 %index
  %4 = bitcast float* %3 to <4 x float>*
  %wide.masked.load13 = call <4 x float> @llvm.masked.load.v4f32.p0v4f32(<4 x float>* %4, i32 4, <4 x i1> %1, <4 x float> undef)
  %5 = fmul fast <4 x float> %wide.masked.load13, %wide.masked.load
  %6 = fadd fast <4 x float> %5, %vec.phi
  %index.next = add i32 %index, 4
  %7 = icmp eq i32 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %8 = select <4 x i1> %1, <4 x float> %6, <4 x float> %vec.phi
  %rdx.shuf = shufflevector <4 x float> %8, <4 x float> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx = fadd fast <4 x float> %8, %rdx.shuf
  %rdx.shuf14 = shufflevector <4 x float> %bin.rdx, <4 x float> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx15 = fadd fast <4 x float> %bin.rdx, %rdx.shuf14
  %9 = extractelement <4 x float> %bin.rdx15, i32 0
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %middle.block, %entry
  %a.0.lcssa = phi float [ 0.000000e+00, %entry ], [ %9, %middle.block ]
  ret float %a.0.lcssa
}

define arm_aapcs_vfpcc float @fast_float_half_mac(half* nocapture readonly %b, half* nocapture readonly %c, i32 %N) {
; CHECK-LABEL: fast_float_half_mac:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    push {r4, r5, r7, lr}
; CHECK-NEXT:    vpush {d8, d9, d10, d11, d12, d13, d14}
; CHECK-NEXT:    sub sp, #8
; CHECK-NEXT:    cmp r2, #0
; CHECK-NEXT:    beq.w .LBB2_20
; CHECK-NEXT:  @ %bb.1: @ %vector.ph
; CHECK-NEXT:    adds r3, r2, #3
; CHECK-NEXT:    vmov.i32 q5, #0x0
; CHECK-NEXT:    bic r3, r3, #3
; CHECK-NEXT:    sub.w r12, r3, #4
; CHECK-NEXT:    movs r3, #1
; CHECK-NEXT:    add.w lr, r3, r12, lsr #2
; CHECK-NEXT:    sub.w r12, r2, #1
; CHECK-NEXT:    adr r2, .LCPI2_1
; CHECK-NEXT:    mov lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:    movs r3, #0
; CHECK-NEXT:    vdup.32 q1, r12
; CHECK-NEXT:    vdup.32 q2, r12
; CHECK-NEXT:    b .LBB2_3
; CHECK-NEXT:  .LBB2_2: @ %else26
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    vmul.f16 q5, q6, q5
; CHECK-NEXT:    adds r0, #8
; CHECK-NEXT:    vcvtt.f32.f16 s27, s21
; CHECK-NEXT:    adds r1, #8
; CHECK-NEXT:    vcvtb.f32.f16 s26, s21
; CHECK-NEXT:    adds r3, #4
; CHECK-NEXT:    vcvtt.f32.f16 s25, s20
; CHECK-NEXT:    vcvtb.f32.f16 s24, s20
; CHECK-NEXT:    vadd.f32 q5, q3, q6
; CHECK-NEXT:    subs.w lr, lr, #1
; CHECK-NEXT:    bne .LBB2_3
; CHECK-NEXT:    b .LBB2_19
; CHECK-NEXT:  .LBB2_3: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vadd.i32 q4, q0, r3
; CHECK-NEXT:    vmov q3, q5
; CHECK-NEXT:    vcmp.u32 cs, q1, q4
; CHECK-NEXT:    @ implicit-def: $q5
; CHECK-NEXT:    vmrs r4, p0
; CHECK-NEXT:    and r2, r4, #1
; CHECK-NEXT:    rsbs r5, r2, #0
; CHECK-NEXT:    movs r2, #0
; CHECK-NEXT:    bfi r2, r5, #0, #1
; CHECK-NEXT:    ubfx r5, r4, #4, #1
; CHECK-NEXT:    rsbs r5, r5, #0
; CHECK-NEXT:    bfi r2, r5, #1, #1
; CHECK-NEXT:    ubfx r5, r4, #8, #1
; CHECK-NEXT:    ubfx r4, r4, #12, #1
; CHECK-NEXT:    rsbs r5, r5, #0
; CHECK-NEXT:    bfi r2, r5, #2, #1
; CHECK-NEXT:    rsbs r4, r4, #0
; CHECK-NEXT:    bfi r2, r4, #3, #1
; CHECK-NEXT:    lsls r4, r2, #31
; CHECK-NEXT:    bne .LBB2_12
; CHECK-NEXT:  @ %bb.4: @ %else
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    lsls r4, r2, #30
; CHECK-NEXT:    bmi .LBB2_13
; CHECK-NEXT:  .LBB2_5: @ %else7
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    lsls r4, r2, #29
; CHECK-NEXT:    bmi .LBB2_14
; CHECK-NEXT:  .LBB2_6: @ %else10
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    lsls r2, r2, #28
; CHECK-NEXT:    bpl .LBB2_8
; CHECK-NEXT:  .LBB2_7: @ %cond.load12
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    vldr.16 s24, [r0, #6]
; CHECK-NEXT:    vins.f16 s21, s24
; CHECK-NEXT:  .LBB2_8: @ %else13
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    vcmp.u32 cs, q2, q4
; CHECK-NEXT:    @ implicit-def: $q6
; CHECK-NEXT:    vmrs r4, p0
; CHECK-NEXT:    and r2, r4, #1
; CHECK-NEXT:    rsbs r5, r2, #0
; CHECK-NEXT:    movs r2, #0
; CHECK-NEXT:    bfi r2, r5, #0, #1
; CHECK-NEXT:    ubfx r5, r4, #4, #1
; CHECK-NEXT:    rsbs r5, r5, #0
; CHECK-NEXT:    bfi r2, r5, #1, #1
; CHECK-NEXT:    ubfx r5, r4, #8, #1
; CHECK-NEXT:    ubfx r4, r4, #12, #1
; CHECK-NEXT:    rsbs r5, r5, #0
; CHECK-NEXT:    bfi r2, r5, #2, #1
; CHECK-NEXT:    rsbs r4, r4, #0
; CHECK-NEXT:    bfi r2, r4, #3, #1
; CHECK-NEXT:    lsls r4, r2, #31
; CHECK-NEXT:    bne .LBB2_15
; CHECK-NEXT:  @ %bb.9: @ %else17
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    lsls r4, r2, #30
; CHECK-NEXT:    bmi .LBB2_16
; CHECK-NEXT:  .LBB2_10: @ %else20
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    lsls r4, r2, #29
; CHECK-NEXT:    bmi .LBB2_17
; CHECK-NEXT:  .LBB2_11: @ %else23
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    lsls r2, r2, #28
; CHECK-NEXT:    bpl .LBB2_2
; CHECK-NEXT:    b .LBB2_18
; CHECK-NEXT:  .LBB2_12: @ %cond.load
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    vldr.16 s20, [r0]
; CHECK-NEXT:    lsls r4, r2, #30
; CHECK-NEXT:    bpl .LBB2_5
; CHECK-NEXT:  .LBB2_13: @ %cond.load6
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    vldr.16 s24, [r0, #2]
; CHECK-NEXT:    vins.f16 s20, s24
; CHECK-NEXT:    lsls r4, r2, #29
; CHECK-NEXT:    bpl .LBB2_6
; CHECK-NEXT:  .LBB2_14: @ %cond.load9
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    vmovx.f16 s24, s21
; CHECK-NEXT:    vldr.16 s21, [r0, #4]
; CHECK-NEXT:    vins.f16 s21, s24
; CHECK-NEXT:    lsls r2, r2, #28
; CHECK-NEXT:    bmi .LBB2_7
; CHECK-NEXT:    b .LBB2_8
; CHECK-NEXT:  .LBB2_15: @ %cond.load16
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    vldr.16 s24, [r1]
; CHECK-NEXT:    lsls r4, r2, #30
; CHECK-NEXT:    bpl .LBB2_10
; CHECK-NEXT:  .LBB2_16: @ %cond.load19
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    vldr.16 s28, [r1, #2]
; CHECK-NEXT:    vins.f16 s24, s28
; CHECK-NEXT:    lsls r4, r2, #29
; CHECK-NEXT:    bpl .LBB2_11
; CHECK-NEXT:  .LBB2_17: @ %cond.load22
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    vmovx.f16 s28, s25
; CHECK-NEXT:    vldr.16 s25, [r1, #4]
; CHECK-NEXT:    vins.f16 s25, s28
; CHECK-NEXT:    lsls r2, r2, #28
; CHECK-NEXT:    bpl.w .LBB2_2
; CHECK-NEXT:  .LBB2_18: @ %cond.load25
; CHECK-NEXT:    @ in Loop: Header=BB2_3 Depth=1
; CHECK-NEXT:    vldr.16 s28, [r1, #6]
; CHECK-NEXT:    vins.f16 s25, s28
; CHECK-NEXT:    b .LBB2_2
; CHECK-NEXT:  .LBB2_19: @ %middle.block
; CHECK-NEXT:    vdup.32 q0, r12
; CHECK-NEXT:    vcmp.u32 cs, q0, q4
; CHECK-NEXT:    vpsel q0, q5, q3
; CHECK-NEXT:    vmov.f32 s4, s2
; CHECK-NEXT:    vmov.f32 s5, s3
; CHECK-NEXT:    vadd.f32 q0, q0, q1
; CHECK-NEXT:    vmov r0, s1
; CHECK-NEXT:    vadd.f32 q0, q0, r0
; CHECK-NEXT:    b .LBB2_21
; CHECK-NEXT:  .LBB2_20:
; CHECK-NEXT:    vldr s0, .LCPI2_0
; CHECK-NEXT:  .LBB2_21: @ %for.cond.cleanup
; CHECK-NEXT:    @ kill: def $s0 killed $s0 killed $q0
; CHECK-NEXT:    add sp, #8
; CHECK-NEXT:    vpop {d8, d9, d10, d11, d12, d13, d14}
; CHECK-NEXT:    pop {r4, r5, r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.22:
; CHECK-NEXT:  .LCPI2_1:
; CHECK-NEXT:    .long 0 @ 0x0
; CHECK-NEXT:    .long 1 @ 0x1
; CHECK-NEXT:    .long 2 @ 0x2
; CHECK-NEXT:    .long 3 @ 0x3
; CHECK-NEXT:  .LCPI2_0:
; CHECK-NEXT:    .long 0x00000000 @ float 0
entry:
  %cmp8 = icmp eq i32 %N, 0
  br i1 %cmp8, label %for.cond.cleanup, label %vector.ph

vector.ph:                                        ; preds = %entry
  %n.rnd.up = add i32 %N, 3
  %n.vec = and i32 %n.rnd.up, -4
  %trip.count.minus.1 = add i32 %N, -1
  %broadcast.splatinsert11 = insertelement <4 x i32> undef, i32 %trip.count.minus.1, i32 0
  %broadcast.splat12 = shufflevector <4 x i32> %broadcast.splatinsert11, <4 x i32> undef, <4 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <4 x float> [ zeroinitializer, %vector.ph ], [ %7, %vector.body ]
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %index, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %induction = add <4 x i32> %broadcast.splat, <i32 0, i32 1, i32 2, i32 3>
  %0 = getelementptr inbounds half, half* %b, i32 %index
  %1 = icmp ule <4 x i32> %induction, %broadcast.splat12
  %2 = bitcast half* %0 to <4 x half>*
  %wide.masked.load = call <4 x half> @llvm.masked.load.v4f16.p0v4f16(<4 x half>* %2, i32 2, <4 x i1> %1, <4 x half> undef)
  %3 = getelementptr inbounds half, half* %c, i32 %index
  %4 = bitcast half* %3 to <4 x half>*
  %wide.masked.load13 = call <4 x half> @llvm.masked.load.v4f16.p0v4f16(<4 x half>* %4, i32 2, <4 x i1> %1, <4 x half> undef)
  %5 = fmul fast <4 x half> %wide.masked.load13, %wide.masked.load
  %6 = fpext <4 x half> %5 to <4 x float>
  %7 = fadd fast <4 x float> %vec.phi, %6
  %index.next = add i32 %index, 4
  %8 = icmp eq i32 %index.next, %n.vec
  br i1 %8, label %middle.block, label %vector.body

middle.block:                                     ; preds = %vector.body
  %9 = select <4 x i1> %1, <4 x float> %7, <4 x float> %vec.phi
  %rdx.shuf = shufflevector <4 x float> %9, <4 x float> undef, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>
  %bin.rdx = fadd fast <4 x float> %9, %rdx.shuf
  %rdx.shuf14 = shufflevector <4 x float> %bin.rdx, <4 x float> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %bin.rdx15 = fadd fast <4 x float> %bin.rdx, %rdx.shuf14
  %10 = extractelement <4 x float> %bin.rdx15, i32 0
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %middle.block, %entry
  %a.0.lcssa = phi float [ 0.000000e+00, %entry ], [ %10, %middle.block ]
  ret float %a.0.lcssa
}

; Function Attrs: argmemonly nounwind readonly willreturn
declare <4 x float> @llvm.masked.load.v4f32.p0v4f32(<4 x float>*, i32 immarg, <4 x i1>, <4 x float>)

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.masked.store.v4f32.p0v4f32(<4 x float>, <4 x float>*, i32 immarg, <4 x i1>)

; Function Attrs: argmemonly nounwind readonly willreturn
declare <4 x half> @llvm.masked.load.v4f16.p0v4f16(<4 x half>*, i32 immarg, <4 x i1>, <4 x half>)

declare <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32, i32)
