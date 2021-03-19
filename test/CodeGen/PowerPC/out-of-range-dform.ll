; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mcpu=pwr9 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -mtriple=powerpc64le-unknown-unknown < %s | FileCheck %s \
; RUN:   -check-prefix=CHECK-P9

@_ZL3num = external dso_local unnamed_addr global float, align 4

define dso_local void @main() local_unnamed_addr personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
; CHECK-P9-LABEL: main:
; CHECK-P9:       # %bb.0: # %bb
; CHECK-P9-NEXT:    mflr r0
; CHECK-P9-NEXT:    std r0, 16(r1)
; CHECK-P9-NEXT:    stdu r1, -32(r1)
; CHECK-P9-NEXT:    .cfi_def_cfa_offset 32
; CHECK-P9-NEXT:    .cfi_offset lr, 16
; CHECK-P9-NEXT:    bl malloc
; CHECK-P9-NEXT:    nop
; CHECK-P9-NEXT:    addis r4, r2, _ZL3num@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, -25400
; CHECK-P9-NEXT:    lfs f0, _ZL3num@toc@l(r4)
; CHECK-P9-NEXT:    addis r4, r2, .LCPI0_0@toc@ha
; CHECK-P9-NEXT:    lfs f1, .LCPI0_0@toc@l(r4)
; CHECK-P9-NEXT:    li r4, 0
; CHECK-P9-NEXT:    xsmulsp f0, f0, f1
; CHECK-P9-NEXT:    cmpldi r4, 0
; CHECK-P9-NEXT:    beq- cr0, .LBB0_2
; CHECK-P9-NEXT:    .p2align 5
; CHECK-P9-NEXT:  .LBB0_1: # %bb5
; CHECK-P9-NEXT:    #
; CHECK-P9-NEXT:    addi r3, r3, 25400
; CHECK-P9-NEXT:    addi r4, r4, 25400
; CHECK-P9-NEXT:    stfs f0, 15240(r3)
; CHECK-P9-NEXT:    cmpldi r4, 0
; CHECK-P9-NEXT:    bne+ cr0, .LBB0_1
; CHECK-P9-NEXT:  .LBB0_2: # %bb16
bb:
  %i = tail call noalias dereferenceable_or_null(6451600) i8* @malloc()
  %i1 = bitcast i8* %i to float*
  br label %bb2

bb2:                                              ; preds = %bb5, %bb
  %i3 = phi i64 [ 0, %bb ], [ %i15, %bb5 ]
  %i4 = icmp eq i64 %i3, 0
  br i1 %i4, label %bb16, label %bb5

bb5:                                              ; preds = %bb2
  %i6 = mul nuw nsw i64 %i3, 1270
  %i7 = add nuw nsw i64 %i6, 0
  %i8 = getelementptr inbounds float, float* %i1, i64 %i7
  store float undef, float* %i8, align 4
  %i9 = add nuw nsw i64 %i3, 3
  %i10 = load float, float* @_ZL3num, align 4
  %i11 = fmul float %i10, 0x3E00000000000000
  %i12 = mul nuw nsw i64 %i9, 1270
  %i13 = add nuw nsw i64 %i12, 0
  %i14 = getelementptr inbounds float, float* %i1, i64 %i13
  store float %i11, float* %i14, align 4
  %i15 = add nuw nsw i64 %i3, 5
  br label %bb2

bb16:                                             ; preds = %bb2
  unreachable
}

declare i32 @__gxx_personality_v0(...)

declare i8* @malloc() local_unnamed_addr
