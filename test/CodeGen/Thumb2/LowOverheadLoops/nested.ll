; RUN: opt -mtriple=armv8.1m.main -mattr=+mve -S -mve-tail-predication -disable-mve-tail-predication=false %s -o - | FileCheck %s

; TODO: Support extending loads
; CHECK-LABEL: mat_vec_sext_i16
; CHECK-NOT: call {{.*}} @llvm.arm.vctp
define void @mat_vec_sext_i16(i16** nocapture readonly %A, i16* nocapture readonly %B, i32* noalias nocapture %C, i32 %N) {
entry:
  %cmp24 = icmp eq i32 %N, 0
  br i1 %cmp24, label %for.cond.cleanup, label %for.cond1.preheader.us.preheader

for.cond1.preheader.us.preheader:                 ; preds = %entry
  %n.rnd.up = add i32 %N, 3
  %n.vec = and i32 %n.rnd.up, -4
  %trip.count.minus.1 = add i32 %N, -1
  %broadcast.splatinsert28 = insertelement <4 x i32> undef, i32 %trip.count.minus.1, i32 0
  %broadcast.splat29 = shufflevector <4 x i32> %broadcast.splatinsert28, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp = add i32 %n.vec, -4
  %tmp1 = lshr i32 %tmp, 2
  %tmp2 = add nuw nsw i32 %tmp1, 1
  br label %for.cond1.preheader.us

for.cond1.preheader.us:                           ; preds = %middle.block, %for.cond1.preheader.us.preheader
  %i.025.us = phi i32 [ %inc10.us, %middle.block ], [ 0, %for.cond1.preheader.us.preheader ]
  %arrayidx.us = getelementptr inbounds i16*, i16** %A, i32 %i.025.us
  %tmp3 = load i16*, i16** %arrayidx.us, align 4
  %arrayidx8.us = getelementptr inbounds i32, i32* %C, i32 %i.025.us
  %arrayidx8.promoted.us = load i32, i32* %arrayidx8.us, align 4
  %tmp4 = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %arrayidx8.promoted.us, i32 0
  call void @llvm.set.loop.iterations.i32(i32 %tmp2)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %for.cond1.preheader.us
  %index = phi i32 [ 0, %for.cond1.preheader.us ], [ %index.next, %vector.body ]
  %vec.phi = phi <4 x i32> [ %tmp4, %for.cond1.preheader.us ], [ %tmp14, %vector.body ]
  %tmp5 = phi i32 [ %tmp2, %for.cond1.preheader.us ], [ %tmp15, %vector.body ]
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %index, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %induction = add <4 x i32> %broadcast.splat, <i32 0, i32 1, i32 2, i32 3>
  %tmp6 = getelementptr inbounds i16, i16* %tmp3, i32 %index
  %tmp7 = icmp ule <4 x i32> %induction, %broadcast.splat29
  %tmp8 = bitcast i16* %tmp6 to <4 x i16>*
  %wide.masked.load = call <4 x i16> @llvm.masked.load.v4i16.p0v4i16(<4 x i16>* %tmp8, i32 2, <4 x i1> %tmp7, <4 x i16> undef)
  %tmp9 = sext <4 x i16> %wide.masked.load to <4 x i32>
  %tmp10 = getelementptr inbounds i16, i16* %B, i32 %index
  %tmp11 = bitcast i16* %tmp10 to <4 x i16>*
  %wide.masked.load30 = call <4 x i16> @llvm.masked.load.v4i16.p0v4i16(<4 x i16>* %tmp11, i32 2, <4 x i1> %tmp7, <4 x i16> undef)
  %tmp12 = sext <4 x i16> %wide.masked.load30 to <4 x i32>
  %tmp13 = mul nsw <4 x i32> %tmp12, %tmp9
  %tmp14 = add nsw <4 x i32> %tmp13, %vec.phi
  %index.next = add i32 %index, 4
  %tmp15 = call i32 @llvm.loop.decrement.reg.i32.i32.i32(i32 %tmp5, i32 1)
  %tmp16 = icmp ne i32 %tmp15, 0
  br i1 %tmp16, label %vector.body, label %middle.block

middle.block:                                     ; preds = %vector.body
  %tmp17 = select <4 x i1> %tmp7, <4 x i32> %tmp14, <4 x i32> %vec.phi
  %tmp18 = call i32 @llvm.experimental.vector.reduce.add.v4i32(<4 x i32> %tmp17)
  store i32 %tmp18, i32* %arrayidx8.us, align 4
  %inc10.us = add nuw i32 %i.025.us, 1
  %exitcond27 = icmp eq i32 %inc10.us, %N
  br i1 %exitcond27, label %for.cond.cleanup, label %for.cond1.preheader.us

for.cond.cleanup:                                 ; preds = %middle.block, %entry
  ret void
}

; CHECK-LABEL: mat_vec_i32
; CHECK: phi
; CHECK: phi
; CHECK: phi
; CHECK: [[IV:%[^ ]+]] = phi i32 [ %N, %for.cond1.preheader.us ], [ [[REM:%[^ ]+]], %vector.body ]
; CHECK: [[VCTP:%[^ ]+]] = call <4 x i1> @llvm.arm.vctp32(i32 [[IV]])
; CHECK: [[REM]] = sub i32 [[IV]], 4
; CHECK: call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* {{.*}}, i32 4, <4 x i1> [[VCTP]], <4 x i32> undef)
; CHECK: call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* {{.*}}, i32 4, <4 x i1> [[VCTP]], <4 x i32> undef)
define void @mat_vec_i32(i32** nocapture readonly %A, i32* nocapture readonly %B, i32* noalias nocapture %C, i32 %N) {
entry:
  %cmp23 = icmp eq i32 %N, 0
  br i1 %cmp23, label %for.cond.cleanup, label %for.cond1.preheader.us.preheader

for.cond1.preheader.us.preheader:                 ; preds = %entry
  %n.rnd.up = add i32 %N, 3
  %n.vec = and i32 %n.rnd.up, -4
  %trip.count.minus.1 = add i32 %N, -1
  %broadcast.splatinsert27 = insertelement <4 x i32> undef, i32 %trip.count.minus.1, i32 0
  %broadcast.splat28 = shufflevector <4 x i32> %broadcast.splatinsert27, <4 x i32> undef, <4 x i32> zeroinitializer
  %tmp = add i32 %n.vec, -4
  %tmp1 = lshr i32 %tmp, 2
  %tmp2 = add nuw nsw i32 %tmp1, 1
  br label %for.cond1.preheader.us

for.cond1.preheader.us:                           ; preds = %middle.block, %for.cond1.preheader.us.preheader
  %i.024.us = phi i32 [ %inc9.us, %middle.block ], [ 0, %for.cond1.preheader.us.preheader ]
  %arrayidx.us = getelementptr inbounds i32*, i32** %A, i32 %i.024.us
  %tmp3 = load i32*, i32** %arrayidx.us, align 4
  %arrayidx7.us = getelementptr inbounds i32, i32* %C, i32 %i.024.us
  %arrayidx7.promoted.us = load i32, i32* %arrayidx7.us, align 4
  %tmp4 = insertelement <4 x i32> <i32 undef, i32 0, i32 0, i32 0>, i32 %arrayidx7.promoted.us, i32 0
  call void @llvm.set.loop.iterations.i32(i32 %tmp2)
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %for.cond1.preheader.us
  %index = phi i32 [ 0, %for.cond1.preheader.us ], [ %index.next, %vector.body ]
  %vec.phi = phi <4 x i32> [ %tmp4, %for.cond1.preheader.us ], [ %tmp12, %vector.body ]
  %tmp5 = phi i32 [ %tmp2, %for.cond1.preheader.us ], [ %tmp13, %vector.body ]
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %index, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %induction = add <4 x i32> %broadcast.splat, <i32 0, i32 1, i32 2, i32 3>
  %tmp6 = getelementptr inbounds i32, i32* %tmp3, i32 %index
  %tmp7 = icmp ule <4 x i32> %induction, %broadcast.splat28
  %tmp8 = bitcast i32* %tmp6 to <4 x i32>*
  %wide.masked.load = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %tmp8, i32 4, <4 x i1> %tmp7, <4 x i32> undef)
  %tmp9 = getelementptr inbounds i32, i32* %B, i32 %index
  %tmp10 = bitcast i32* %tmp9 to <4 x i32>*
  %wide.masked.load29 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %tmp10, i32 4, <4 x i1> %tmp7, <4 x i32> undef)
  %tmp11 = mul nsw <4 x i32> %wide.masked.load29, %wide.masked.load
  %tmp12 = add nsw <4 x i32> %vec.phi, %tmp11
  %index.next = add i32 %index, 4
  %tmp13 = call i32 @llvm.loop.decrement.reg.i32.i32.i32(i32 %tmp5, i32 1)
  %tmp14 = icmp ne i32 %tmp13, 0
  br i1 %tmp14, label %vector.body, label %middle.block

middle.block:                                     ; preds = %vector.body
  %tmp15 = select <4 x i1> %tmp7, <4 x i32> %tmp12, <4 x i32> %vec.phi
  %tmp16 = call i32 @llvm.experimental.vector.reduce.add.v4i32(<4 x i32> %tmp15)
  store i32 %tmp16, i32* %arrayidx7.us, align 4
  %inc9.us = add nuw i32 %i.024.us, 1
  %exitcond26 = icmp eq i32 %inc9.us, %N
  br i1 %exitcond26, label %for.cond.cleanup, label %for.cond1.preheader.us

for.cond.cleanup:                                 ; preds = %middle.block, %entry
  ret void
}

; Function Attrs: argmemonly nounwind readonly willreturn
declare <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>*, i32 immarg, <4 x i1>, <4 x i32>) #0

; Function Attrs: argmemonly nounwind readonly willreturn
declare <4 x i16> @llvm.masked.load.v4i16.p0v4i16(<4 x i16>*, i32 immarg, <4 x i1>, <4 x i16>) #0

; Function Attrs: nounwind readnone willreturn
declare i32 @llvm.experimental.vector.reduce.add.v4i32(<4 x i32>) #1

; Function Attrs: noduplicate nounwind
declare void @llvm.set.loop.iterations.i32(i32) #2

; Function Attrs: noduplicate nounwind
declare i32 @llvm.loop.decrement.reg.i32.i32.i32(i32, i32) #2

attributes #0 = { argmemonly nounwind readonly willreturn }
attributes #1 = { nounwind readnone willreturn }
attributes #2 = { noduplicate nounwind }
