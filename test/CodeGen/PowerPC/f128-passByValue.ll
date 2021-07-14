; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mcpu=pwr9 -mtriple=powerpc64le-unknown-unknown -ppc-vsr-nums-as-vr \
; RUN:   -verify-machineinstrs -ppc-asm-full-reg-names < %s | FileCheck %s
; RUN: llc -mcpu=pwr8 -mtriple=powerpc64le-unknown-unknown -ppc-vsr-nums-as-vr \
; RUN:   -verify-machineinstrs -ppc-asm-full-reg-names < %s | FileCheck %s \
; RUN:   -check-prefix=CHECK-P8

; Function Attrs: norecurse nounwind readnone
define fp128 @loadConstant() {
; CHECK-LABEL: loadConstant:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addis r3, r2, .LCPI0_0@toc@ha
; CHECK-NEXT:    addi r3, r3, .LCPI0_0@toc@l
; CHECK-NEXT:    lxv v2, 0(r3)
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: loadConstant:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    addis r3, r2, .LCPI0_0@toc@ha
; CHECK-P8-NEXT:    addi r3, r3, .LCPI0_0@toc@l
; CHECK-P8-NEXT:    lvx v2, 0, r3
; CHECK-P8-NEXT:    blr
  entry:
    ret fp128 0xL00000000000000004001400000000000
}

; Function Attrs: norecurse nounwind readnone
define fp128 @loadConstant2(fp128 %a, fp128 %b) {
; CHECK-LABEL: loadConstant2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    addis r3, r2, .LCPI1_0@toc@ha
; CHECK-NEXT:    addi r3, r3, .LCPI1_0@toc@l
; CHECK-NEXT:    lxv v3, 0(r3)
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: loadConstant2:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -32(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 32
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    addis r3, r2, .LCPI1_0@toc@ha
; CHECK-P8-NEXT:    addi r3, r3, .LCPI1_0@toc@l
; CHECK-P8-NEXT:    lvx v3, 0, r3
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    addi r1, r1, 32
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
  entry:
    %add = fadd fp128 %a, %b
      %add1 = fadd fp128 %add, 0xL00000000000000004001400000000000
        ret fp128 %add1
}

; Test passing float128 by value.
; Function Attrs: norecurse nounwind readnone
define signext i32 @fp128Param(fp128 %a) {
; CHECK-LABEL: fp128Param:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xscvqpswz v2, v2
; CHECK-NEXT:    mfvsrwz r3, v2
; CHECK-NEXT:    extsw r3, r3
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: fp128Param:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -32(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 32
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    bl __fixkfsi
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    extsw r3, r3
; CHECK-P8-NEXT:    addi r1, r1, 32
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
entry:
  %conv = fptosi fp128 %a to i32
  ret i32 %conv
}

; Test float128 as return value.
; Function Attrs: norecurse nounwind readnone
define fp128 @fp128Return(fp128 %a, fp128 %b) {
; CHECK-LABEL: fp128Return:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: fp128Return:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -32(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 32
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    addi r1, r1, 32
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
entry:
  %add = fadd fp128 %a, %b
  ret fp128 %add
}

; array of float128 types
; Function Attrs: norecurse nounwind readonly
define fp128 @fp128Array(fp128* nocapture readonly %farray,
; CHECK-LABEL: fp128Array:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    sldi r4, r4, 4
; CHECK-NEXT:    lxv v2, 0(r3)
; CHECK-NEXT:    add r3, r3, r4
; CHECK-NEXT:    lxv v3, -16(r3)
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: fp128Array:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -32(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 32
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    sldi r4, r4, 4
; CHECK-P8-NEXT:    lvx v2, 0, r3
; CHECK-P8-NEXT:    add r4, r3, r4
; CHECK-P8-NEXT:    addi r4, r4, -16
; CHECK-P8-NEXT:    lvx v3, 0, r4
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    addi r1, r1, 32
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
                         i32 signext %loopcnt, fp128* nocapture readnone %sum) {
entry:
  %0 = load fp128, fp128* %farray, align 16
  %sub = add nsw i32 %loopcnt, -1
  %idxprom = sext i32 %sub to i64
  %arrayidx1 = getelementptr inbounds fp128, fp128* %farray, i64 %idxprom
  %1 = load fp128, fp128* %arrayidx1, align 16
  %add = fadd fp128 %0, %1
  ret fp128 %add
}

; Up to 12 qualified floating-point arguments can be passed in v2-v13.
; Function to test passing 13 float128 parameters.
; Function Attrs: norecurse nounwind readnone
define fp128 @maxVecParam(fp128 %p1, fp128 %p2, fp128 %p3, fp128 %p4, fp128 %p5,
; CHECK-LABEL: maxVecParam:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    lxv v0, 224(r1)
; CHECK-NEXT:    xsaddqp v2, v2, v4
; CHECK-NEXT:    xsaddqp v2, v2, v5
; CHECK-NEXT:    xsaddqp v2, v2, v6
; CHECK-NEXT:    xsaddqp v2, v2, v7
; CHECK-NEXT:    xsaddqp v2, v2, v8
; CHECK-NEXT:    xsaddqp v2, v2, v9
; CHECK-NEXT:    xsaddqp v2, v2, v10
; CHECK-NEXT:    xsaddqp v2, v2, v11
; CHECK-NEXT:    xsaddqp v2, v2, v12
; CHECK-NEXT:    xsaddqp v2, v2, v13
; CHECK-NEXT:    xssubqp v2, v2, v0
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: maxVecParam:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -224(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 224
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    .cfi_offset v21, -176
; CHECK-P8-NEXT:    .cfi_offset v22, -160
; CHECK-P8-NEXT:    .cfi_offset v23, -144
; CHECK-P8-NEXT:    .cfi_offset v24, -128
; CHECK-P8-NEXT:    .cfi_offset v25, -112
; CHECK-P8-NEXT:    .cfi_offset v26, -96
; CHECK-P8-NEXT:    .cfi_offset v27, -80
; CHECK-P8-NEXT:    .cfi_offset v28, -64
; CHECK-P8-NEXT:    .cfi_offset v29, -48
; CHECK-P8-NEXT:    .cfi_offset v30, -32
; CHECK-P8-NEXT:    .cfi_offset v31, -16
; CHECK-P8-NEXT:    li r3, 48
; CHECK-P8-NEXT:    stvx v21, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    li r3, 64
; CHECK-P8-NEXT:    vmr v21, v4
; CHECK-P8-NEXT:    stvx v22, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    li r3, 80
; CHECK-P8-NEXT:    vmr v22, v5
; CHECK-P8-NEXT:    stvx v23, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    li r3, 96
; CHECK-P8-NEXT:    vmr v23, v6
; CHECK-P8-NEXT:    stvx v24, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    li r3, 112
; CHECK-P8-NEXT:    vmr v24, v7
; CHECK-P8-NEXT:    stvx v25, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    li r3, 128
; CHECK-P8-NEXT:    vmr v25, v8
; CHECK-P8-NEXT:    stvx v26, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    li r3, 144
; CHECK-P8-NEXT:    vmr v26, v9
; CHECK-P8-NEXT:    stvx v27, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    li r3, 160
; CHECK-P8-NEXT:    vmr v27, v10
; CHECK-P8-NEXT:    stvx v28, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    li r3, 176
; CHECK-P8-NEXT:    vmr v28, v11
; CHECK-P8-NEXT:    stvx v29, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    li r3, 192
; CHECK-P8-NEXT:    stvx v30, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    li r3, 208
; CHECK-P8-NEXT:    vmr v30, v12
; CHECK-P8-NEXT:    stvx v31, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    addi r3, r1, 448
; CHECK-P8-NEXT:    vmr v31, v13
; CHECK-P8-NEXT:    lvx v29, 0, r3
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v21
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v22
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v23
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v24
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v25
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v26
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v27
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v28
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v30
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v31
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v29
; CHECK-P8-NEXT:    bl __subkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    li r3, 208
; CHECK-P8-NEXT:    lvx v31, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    li r3, 192
; CHECK-P8-NEXT:    lvx v30, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    li r3, 176
; CHECK-P8-NEXT:    lvx v29, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    li r3, 160
; CHECK-P8-NEXT:    lvx v28, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    li r3, 144
; CHECK-P8-NEXT:    lvx v27, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    li r3, 128
; CHECK-P8-NEXT:    lvx v26, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    li r3, 112
; CHECK-P8-NEXT:    lvx v25, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    li r3, 96
; CHECK-P8-NEXT:    lvx v24, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    li r3, 80
; CHECK-P8-NEXT:    lvx v23, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    li r3, 64
; CHECK-P8-NEXT:    lvx v22, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    li r3, 48
; CHECK-P8-NEXT:    lvx v21, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    addi r1, r1, 224
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
                          fp128 %p6, fp128 %p7, fp128 %p8, fp128 %p9, fp128 %p10,
                          fp128 %p11, fp128 %p12, fp128 %p13) {
entry:
  %add = fadd fp128 %p1, %p2
  %add1 = fadd fp128 %add, %p3
  %add2 = fadd fp128 %add1, %p4
  %add3 = fadd fp128 %add2, %p5
  %add4 = fadd fp128 %add3, %p6
  %add5 = fadd fp128 %add4, %p7
  %add6 = fadd fp128 %add5, %p8
  %add7 = fadd fp128 %add6, %p9
  %add8 = fadd fp128 %add7, %p10
  %add9 = fadd fp128 %add8, %p11
  %add10 = fadd fp128 %add9, %p12
  %sub = fsub fp128 %add10, %p13
  ret fp128 %sub
}

; Passing a mix of float128 and other type parameters.
; Function Attrs: norecurse nounwind readnone
define fp128 @mixParam_01(fp128 %a, i32 signext %i, fp128 %b) {
; CHECK-LABEL: mixParam_01:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    mtvsrwa v3, r5
; CHECK-NEXT:    xscvsdqp v3, v3
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: mixParam_01:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -80(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 80
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    .cfi_offset r30, -16
; CHECK-P8-NEXT:    .cfi_offset v31, -32
; CHECK-P8-NEXT:    li r3, 48
; CHECK-P8-NEXT:    std r30, 64(r1) # 8-byte Folded Spill
; CHECK-P8-NEXT:    mr r30, r5
; CHECK-P8-NEXT:    stvx v31, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    mr r3, r30
; CHECK-P8-NEXT:    vmr v31, v2
; CHECK-P8-NEXT:    bl __floatsikf
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v2
; CHECK-P8-NEXT:    vmr v2, v31
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    li r3, 48
; CHECK-P8-NEXT:    ld r30, 64(r1) # 8-byte Folded Reload
; CHECK-P8-NEXT:    lvx v31, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    addi r1, r1, 80
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
entry:
  %add = fadd fp128 %a, %b
  %conv = sitofp i32 %i to fp128
  %add1 = fadd fp128 %add, %conv
  ret fp128 %add1
}
; Function Attrs: norecurse nounwind readnone
define fastcc fp128 @mixParam_01f(fp128 %a, i32 signext %i, fp128 %b) {
; CHECK-LABEL: mixParam_01f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    mtvsrwa v3, r3
; CHECK-NEXT:    xscvsdqp v3, v3
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: mixParam_01f:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -80(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 80
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    .cfi_offset r30, -16
; CHECK-P8-NEXT:    .cfi_offset v31, -32
; CHECK-P8-NEXT:    li r4, 48
; CHECK-P8-NEXT:    std r30, 64(r1) # 8-byte Folded Spill
; CHECK-P8-NEXT:    mr r30, r3
; CHECK-P8-NEXT:    stvx v31, r1, r4 # 16-byte Folded Spill
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    mr r3, r30
; CHECK-P8-NEXT:    vmr v31, v2
; CHECK-P8-NEXT:    bl __floatsikf
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v2
; CHECK-P8-NEXT:    vmr v2, v31
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    li r3, 48
; CHECK-P8-NEXT:    ld r30, 64(r1) # 8-byte Folded Reload
; CHECK-P8-NEXT:    lvx v31, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    addi r1, r1, 80
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
entry:
  %add = fadd fp128 %a, %b
  %conv = sitofp i32 %i to fp128
  %add1 = fadd fp128 %add, %conv
  ret fp128 %add1
}

; Function Attrs: norecurse nounwind
define fp128 @mixParam_02(fp128 %p1, double %p2, i64* nocapture %p3,
; CHECK-LABEL: mixParam_02:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lwz r3, 96(r1)
; CHECK-NEXT:    add r4, r7, r9
; CHECK-NEXT:    xscpsgndp v3, f1, f1
; CHECK-NEXT:    add r4, r4, r10
; CHECK-NEXT:    xscvdpqp v3, v3
; CHECK-NEXT:    add r3, r4, r3
; CHECK-NEXT:    clrldi r3, r3, 32
; CHECK-NEXT:    std r3, 0(r6)
; CHECK-NEXT:    lxv v4, 0(r8)
; CHECK-NEXT:    xsaddqp v2, v4, v2
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: mixParam_02:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -80(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 80
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    .cfi_offset f31, -8
; CHECK-P8-NEXT:    .cfi_offset v31, -32
; CHECK-P8-NEXT:    li r3, 48
; CHECK-P8-NEXT:    add r4, r7, r9
; CHECK-P8-NEXT:    vmr v4, v2
; CHECK-P8-NEXT:    stfd f31, 72(r1) # 8-byte Folded Spill
; CHECK-P8-NEXT:    stvx v31, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    lwz r3, 176(r1)
; CHECK-P8-NEXT:    add r4, r4, r10
; CHECK-P8-NEXT:    fmr f31, f1
; CHECK-P8-NEXT:    add r3, r4, r3
; CHECK-P8-NEXT:    clrldi r3, r3, 32
; CHECK-P8-NEXT:    std r3, 0(r6)
; CHECK-P8-NEXT:    lvx v3, 0, r8
; CHECK-P8-NEXT:    vmr v2, v3
; CHECK-P8-NEXT:    vmr v3, v4
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    fmr f1, f31
; CHECK-P8-NEXT:    vmr v31, v2
; CHECK-P8-NEXT:    bl __extenddfkf2
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v2
; CHECK-P8-NEXT:    vmr v2, v31
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    li r3, 48
; CHECK-P8-NEXT:    lfd f31, 72(r1) # 8-byte Folded Reload
; CHECK-P8-NEXT:    lvx v31, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    addi r1, r1, 80
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
                          i16 signext %p4, fp128* nocapture readonly %p5,
                          i32 signext %p6, i8 zeroext %p7, i32 zeroext %p8) {
entry:
  %conv = sext i16 %p4 to i32
  %add = add nsw i32 %conv, %p6
  %conv1 = zext i8 %p7 to i32
  %add2 = add nsw i32 %add, %conv1
  %add3 = add i32 %add2, %p8
  %conv4 = zext i32 %add3 to i64
  store i64 %conv4, i64* %p3, align 8
  %0 = load fp128, fp128* %p5, align 16
  %add5 = fadd fp128 %0, %p1
  %conv6 = fpext double %p2 to fp128
  %add7 = fadd fp128 %add5, %conv6
  ret fp128 %add7
}

; Function Attrs: norecurse nounwind
define fastcc fp128 @mixParam_02f(fp128 %p1, double %p2, i64* nocapture %p3,
; CHECK-LABEL: mixParam_02f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    add r4, r4, r6
; CHECK-NEXT:    xscpsgndp v3, f1, f1
; CHECK-NEXT:    add r4, r4, r7
; CHECK-NEXT:    xscvdpqp v3, v3
; CHECK-NEXT:    add r4, r4, r8
; CHECK-NEXT:    clrldi r4, r4, 32
; CHECK-NEXT:    std r4, 0(r3)
; CHECK-NEXT:    lxv v4, 0(r5)
; CHECK-NEXT:    xsaddqp v2, v4, v2
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: mixParam_02f:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -80(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 80
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    .cfi_offset f31, -8
; CHECK-P8-NEXT:    .cfi_offset v31, -32
; CHECK-P8-NEXT:    add r4, r4, r6
; CHECK-P8-NEXT:    vmr v4, v2
; CHECK-P8-NEXT:    li r9, 48
; CHECK-P8-NEXT:    stfd f31, 72(r1) # 8-byte Folded Spill
; CHECK-P8-NEXT:    add r4, r4, r7
; CHECK-P8-NEXT:    stvx v31, r1, r9 # 16-byte Folded Spill
; CHECK-P8-NEXT:    fmr f31, f1
; CHECK-P8-NEXT:    add r4, r4, r8
; CHECK-P8-NEXT:    clrldi r4, r4, 32
; CHECK-P8-NEXT:    std r4, 0(r3)
; CHECK-P8-NEXT:    lvx v3, 0, r5
; CHECK-P8-NEXT:    vmr v2, v3
; CHECK-P8-NEXT:    vmr v3, v4
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    fmr f1, f31
; CHECK-P8-NEXT:    vmr v31, v2
; CHECK-P8-NEXT:    bl __extenddfkf2
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v2
; CHECK-P8-NEXT:    vmr v2, v31
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    li r3, 48
; CHECK-P8-NEXT:    lfd f31, 72(r1) # 8-byte Folded Reload
; CHECK-P8-NEXT:    lvx v31, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    addi r1, r1, 80
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
                                  i16 signext %p4, fp128* nocapture readonly %p5,
                                  i32 signext %p6, i8 zeroext %p7, i32 zeroext %p8) {
entry:
  %conv = sext i16 %p4 to i32
  %add = add nsw i32 %conv, %p6
  %conv1 = zext i8 %p7 to i32
  %add2 = add nsw i32 %add, %conv1
  %add3 = add i32 %add2, %p8
  %conv4 = zext i32 %add3 to i64
  store i64 %conv4, i64* %p3, align 8
  %0 = load fp128, fp128* %p5, align 16
  %add5 = fadd fp128 %0, %p1
  %conv6 = fpext double %p2 to fp128
  %add7 = fadd fp128 %add5, %conv6
  ret fp128 %add7
}

; Passing a mix of float128 and vector parameters.
; Function Attrs: norecurse nounwind
define void @mixParam_03(fp128 %f1, double* nocapture %d1, <4 x i32> %vec1,
; CHECK-LABEL: mixParam_03:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    ld r3, 104(r1)
; CHECK-NEXT:    stxv v2, 0(r9)
; CHECK-NEXT:    stxv v3, 0(r3)
; CHECK-NEXT:    mtvsrwa v3, r10
; CHECK-NEXT:    lxv v2, 0(r9)
; CHECK-NEXT:    xscvsdqp v3, v3
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    xscvqpdp v2, v2
; CHECK-NEXT:    stxsd v2, 0(r5)
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: mixParam_03:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -80(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 80
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    .cfi_offset r30, -16
; CHECK-P8-NEXT:    .cfi_offset v31, -32
; CHECK-P8-NEXT:    ld r4, 184(r1)
; CHECK-P8-NEXT:    li r3, 48
; CHECK-P8-NEXT:    stvx v2, 0, r9
; CHECK-P8-NEXT:    std r30, 64(r1) # 8-byte Folded Spill
; CHECK-P8-NEXT:    mr r30, r5
; CHECK-P8-NEXT:    stvx v31, r1, r3 # 16-byte Folded Spill
; CHECK-P8-NEXT:    mr r3, r10
; CHECK-P8-NEXT:    stvx v3, 0, r4
; CHECK-P8-NEXT:    lvx v31, 0, r9
; CHECK-P8-NEXT:    bl __floatsikf
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v2
; CHECK-P8-NEXT:    vmr v2, v31
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    bl __trunckfdf2
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    li r3, 48
; CHECK-P8-NEXT:    stfd f1, 0(r30)
; CHECK-P8-NEXT:    ld r30, 64(r1) # 8-byte Folded Reload
; CHECK-P8-NEXT:    lvx v31, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    addi r1, r1, 80
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
                         fp128* nocapture %f2, i32 signext %i1, i8 zeroext %c1,
                         <4 x i32>* nocapture %vec2) {
entry:
  store fp128 %f1, fp128* %f2, align 16
  store <4 x i32> %vec1, <4 x i32>* %vec2, align 16
  %0 = load fp128, fp128* %f2, align 16
  %conv = sitofp i32 %i1 to fp128
  %add = fadd fp128 %0, %conv
  %conv1 = fptrunc fp128 %add to double
  store double %conv1, double* %d1, align 8
  ret void
}

; Function Attrs: norecurse nounwind
define fastcc void @mixParam_03f(fp128 %f1, double* nocapture %d1, <4 x i32> %vec1,
; CHECK-LABEL: mixParam_03f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    stxv v2, 0(r4)
; CHECK-NEXT:    stxv v3, 0(r7)
; CHECK-NEXT:    lxv v2, 0(r4)
; CHECK-NEXT:    mtvsrwa v3, r5
; CHECK-NEXT:    xscvsdqp v3, v3
; CHECK-NEXT:    xsaddqp v2, v2, v3
; CHECK-NEXT:    xscvqpdp v2, v2
; CHECK-NEXT:    stxsd v2, 0(r3)
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: mixParam_03f:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -80(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 80
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    .cfi_offset r30, -16
; CHECK-P8-NEXT:    .cfi_offset v31, -32
; CHECK-P8-NEXT:    li r6, 48
; CHECK-P8-NEXT:    stvx v2, 0, r4
; CHECK-P8-NEXT:    stvx v3, 0, r7
; CHECK-P8-NEXT:    std r30, 64(r1) # 8-byte Folded Spill
; CHECK-P8-NEXT:    mr r30, r3
; CHECK-P8-NEXT:    mr r3, r5
; CHECK-P8-NEXT:    stvx v31, r1, r6 # 16-byte Folded Spill
; CHECK-P8-NEXT:    lvx v31, 0, r4
; CHECK-P8-NEXT:    bl __floatsikf
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    vmr v3, v2
; CHECK-P8-NEXT:    vmr v2, v31
; CHECK-P8-NEXT:    bl __addkf3
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    bl __trunckfdf2
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    li r3, 48
; CHECK-P8-NEXT:    stfd f1, 0(r30)
; CHECK-P8-NEXT:    ld r30, 64(r1) # 8-byte Folded Reload
; CHECK-P8-NEXT:    lvx v31, r1, r3 # 16-byte Folded Reload
; CHECK-P8-NEXT:    addi r1, r1, 80
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
                                 fp128* nocapture %f2, i32 signext %i1, i8 zeroext %c1,
                                 <4 x i32>* nocapture %vec2) {
entry:
  store fp128 %f1, fp128* %f2, align 16
  store <4 x i32> %vec1, <4 x i32>* %vec2, align 16
  %0 = load fp128, fp128* %f2, align 16
  %conv = sitofp i32 %i1 to fp128
  %add = fadd fp128 %0, %conv
  %conv1 = fptrunc fp128 %add to double
  store double %conv1, double* %d1, align 8
  ret void
}

; Function Attrs: noinline optnone
define signext i32 @noopt_call_crash() #0 {
; CHECK-LABEL: noopt_call_crash:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr r0
; CHECK-NEXT:    std r0, 16(r1)
; CHECK-NEXT:    stdu r1, -96(r1)
; CHECK-NEXT:    .cfi_def_cfa_offset 96
; CHECK-NEXT:    .cfi_offset lr, 16
; CHECK-NEXT:    bl in
; CHECK-NEXT:    nop
; CHECK-NEXT:    bl out
; CHECK-NEXT:    nop
; CHECK-NEXT:    li r3, 0
; CHECK-NEXT:    addi r1, r1, 96
; CHECK-NEXT:    ld r0, 16(r1)
; CHECK-NEXT:    mtlr r0
; CHECK-NEXT:    blr
;
; CHECK-P8-LABEL: noopt_call_crash:
; CHECK-P8:       # %bb.0: # %entry
; CHECK-P8-NEXT:    mflr r0
; CHECK-P8-NEXT:    std r0, 16(r1)
; CHECK-P8-NEXT:    stdu r1, -96(r1)
; CHECK-P8-NEXT:    .cfi_def_cfa_offset 96
; CHECK-P8-NEXT:    .cfi_offset lr, 16
; CHECK-P8-NEXT:    bl in
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    bl out
; CHECK-P8-NEXT:    nop
; CHECK-P8-NEXT:    li r3, 0
; CHECK-P8-NEXT:    addi r1, r1, 96
; CHECK-P8-NEXT:    ld r0, 16(r1)
; CHECK-P8-NEXT:    mtlr r0
; CHECK-P8-NEXT:    blr
entry:
  %call = call fp128 @in()
  call void @out(fp128 %call)
  ret i32 0
}

declare void @out(fp128)
declare fp128 @in()

attributes #0 = { noinline optnone }
