; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc %s -o - -mtriple=thumbv8m.main -mattr=+fp-armv8d16sp,+dsp -float-abi=hard | \
; RUN:   FileCheck %s --check-prefix=CHECK-8M --check-prefix=CHECK-8M-LE
; RUN: llc %s -o - -mtriple=thumbebv8m.main -mattr=+fp-armv8d16sp,+dsp -float-abi=hard | \
; RUN:   FileCheck %s --check-prefix=CHECK-8M --check-prefix=CHECK-8M-BE
; RUN: llc %s -o - -mtriple=thumbv8.1m.main -mattr=+fp-armv8d16sp,+dsp -float-abi=hard | \
; RUN:   FileCheck %s --check-prefix=CHECK-81M --check-prefix=CHECK-81M-LE
; RUN: llc %s -o - -mtriple=thumbebv8.1m.main -mattr=+fp-armv8d16sp,+dsp -float-abi=hard | \
; RUN:   FileCheck %s --check-prefix=CHECK-81M --check-prefix=CHECK-81M-BE
; RUN: llc %s -o - -mtriple=thumbv8.1m.main -mattr=+mve.fp -float-abi=hard | \
; RUN:   FileCheck %s --check-prefix=CHECK-81M --check-prefix=CHECK-81M-LE
; RUN: llc %s -o - -mtriple=thumbebv8.1m.main -mattr=+mve.fp -float-abi=hard | \
; RUN:   FileCheck %s --check-prefix=CHECK-81M --check-prefix=CHECK-81M-BE

define float @f1(float (float)* nocapture %fptr) #0 {
; CHECK-8M-LABEL: f1:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    push {r7, lr}
; CHECK-8M-NEXT:    vmov.f32 s0, #1.000000e+01
; CHECK-8M-NEXT:    blx r0
; CHECK-8M-NEXT:    pop.w {r7, lr}
; CHECK-8M-NEXT:    mrs r12, control
; CHECK-8M-NEXT:    tst.w r12, #8
; CHECK-8M-NEXT:    beq .LBB0_2
; CHECK-8M-NEXT:  @ %bb.1: @ %entry
; CHECK-8M-NEXT:    vmrs r12, fpscr
; CHECK-8M-NEXT:    bic r12, r12, #159
; CHECK-8M-NEXT:    bic r12, r12, #4026531840
; CHECK-8M-NEXT:    vmov s1, lr
; CHECK-8M-NEXT:    vmov d1, lr, lr
; CHECK-8M-NEXT:    vmsr fpscr, r12
; CHECK-8M-NEXT:    vmov d2, lr, lr
; CHECK-8M-NEXT:    vmov d3, lr, lr
; CHECK-8M-NEXT:    vmov d4, lr, lr
; CHECK-8M-NEXT:    vmov d5, lr, lr
; CHECK-8M-NEXT:    vmov d6, lr, lr
; CHECK-8M-NEXT:    vmov d7, lr, lr
; CHECK-8M-NEXT:  .LBB0_2: @ %entry
; CHECK-8M-NEXT:    mov r0, lr
; CHECK-8M-NEXT:    mov r1, lr
; CHECK-8M-NEXT:    mov r2, lr
; CHECK-8M-NEXT:    mov r3, lr
; CHECK-8M-NEXT:    mov r12, lr
; CHECK-8M-NEXT:    msr apsr_nzcvqg, lr
; CHECK-8M-NEXT:    bxns lr
;
; CHECK-81M-LABEL: f1:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    vstr fpcxtns, [sp, #-4]!
; CHECK-81M-NEXT:    push {r7, lr}
; CHECK-81M-NEXT:    sub sp, #4
; CHECK-81M-NEXT:    vmov.f32 s0, #1.000000e+01
; CHECK-81M-NEXT:    blx r0
; CHECK-81M-NEXT:    add sp, #4
; CHECK-81M-NEXT:    pop.w {r7, lr}
; CHECK-81M-NEXT:    vscclrm {s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, vpr}
; CHECK-81M-NEXT:    vldr fpcxtns, [sp], #4
; CHECK-81M-NEXT:    clrm {r0, r1, r2, r3, r12, apsr}
; CHECK-81M-NEXT:    bxns lr
entry:
  %call = call float %fptr(float 10.0) #1
  ret float %call
}

attributes #0 = { "cmse_nonsecure_entry" nounwind }
attributes #1 = { nounwind }

define double @d1(double (double)* nocapture %fptr) #0 {
; CHECK-8M-LE-LABEL: d1:
; CHECK-8M-LE:       @ %bb.0: @ %entry
; CHECK-8M-LE-NEXT:    push {r7, lr}
; CHECK-8M-LE-NEXT:    vldr d0, .LCPI1_0
; CHECK-8M-LE-NEXT:    blx r0
; CHECK-8M-LE-NEXT:    pop.w {r7, lr}
; CHECK-8M-LE-NEXT:    mrs r12, control
; CHECK-8M-LE-NEXT:    tst.w r12, #8
; CHECK-8M-LE-NEXT:    beq .LBB1_2
; CHECK-8M-LE-NEXT:  @ %bb.1: @ %entry
; CHECK-8M-LE-NEXT:    vmrs r12, fpscr
; CHECK-8M-LE-NEXT:    bic r12, r12, #159
; CHECK-8M-LE-NEXT:    bic r12, r12, #4026531840
; CHECK-8M-LE-NEXT:    vmov d1, lr, lr
; CHECK-8M-LE-NEXT:    vmov d2, lr, lr
; CHECK-8M-LE-NEXT:    vmsr fpscr, r12
; CHECK-8M-LE-NEXT:    vmov d3, lr, lr
; CHECK-8M-LE-NEXT:    vmov d4, lr, lr
; CHECK-8M-LE-NEXT:    vmov d5, lr, lr
; CHECK-8M-LE-NEXT:    vmov d6, lr, lr
; CHECK-8M-LE-NEXT:    vmov d7, lr, lr
; CHECK-8M-LE-NEXT:  .LBB1_2: @ %entry
; CHECK-8M-LE-NEXT:    mov r0, lr
; CHECK-8M-LE-NEXT:    mov r1, lr
; CHECK-8M-LE-NEXT:    mov r2, lr
; CHECK-8M-LE-NEXT:    mov r3, lr
; CHECK-8M-LE-NEXT:    mov r12, lr
; CHECK-8M-LE-NEXT:    msr apsr_nzcvqg, lr
; CHECK-8M-LE-NEXT:    bxns lr
; CHECK-8M-LE-NEXT:    .p2align 3
; CHECK-8M-LE-NEXT:  @ %bb.3:
; CHECK-8M-LE-NEXT:  .LCPI1_0:
; CHECK-8M-LE-NEXT:    .long 0 @ double 10
; CHECK-8M-LE-NEXT:    .long 1076101120
;
; CHECK-8M-BE-LABEL: d1:
; CHECK-8M-BE:       @ %bb.0: @ %entry
; CHECK-8M-BE-NEXT:    push {r7, lr}
; CHECK-8M-BE-NEXT:    vldr d0, .LCPI1_0
; CHECK-8M-BE-NEXT:    blx r0
; CHECK-8M-BE-NEXT:    pop.w {r7, lr}
; CHECK-8M-BE-NEXT:    mrs r12, control
; CHECK-8M-BE-NEXT:    tst.w r12, #8
; CHECK-8M-BE-NEXT:    beq .LBB1_2
; CHECK-8M-BE-NEXT:  @ %bb.1: @ %entry
; CHECK-8M-BE-NEXT:    vmrs r12, fpscr
; CHECK-8M-BE-NEXT:    bic r12, r12, #159
; CHECK-8M-BE-NEXT:    bic r12, r12, #4026531840
; CHECK-8M-BE-NEXT:    vmov d1, lr, lr
; CHECK-8M-BE-NEXT:    vmov d2, lr, lr
; CHECK-8M-BE-NEXT:    vmsr fpscr, r12
; CHECK-8M-BE-NEXT:    vmov d3, lr, lr
; CHECK-8M-BE-NEXT:    vmov d4, lr, lr
; CHECK-8M-BE-NEXT:    vmov d5, lr, lr
; CHECK-8M-BE-NEXT:    vmov d6, lr, lr
; CHECK-8M-BE-NEXT:    vmov d7, lr, lr
; CHECK-8M-BE-NEXT:  .LBB1_2: @ %entry
; CHECK-8M-BE-NEXT:    mov r0, lr
; CHECK-8M-BE-NEXT:    mov r1, lr
; CHECK-8M-BE-NEXT:    mov r2, lr
; CHECK-8M-BE-NEXT:    mov r3, lr
; CHECK-8M-BE-NEXT:    mov r12, lr
; CHECK-8M-BE-NEXT:    msr apsr_nzcvqg, lr
; CHECK-8M-BE-NEXT:    bxns lr
; CHECK-8M-BE-NEXT:    .p2align 3
; CHECK-8M-BE-NEXT:  @ %bb.3:
; CHECK-8M-BE-NEXT:  .LCPI1_0:
; CHECK-8M-BE-NEXT:    .long 1076101120 @ double 10
; CHECK-8M-BE-NEXT:    .long 0
;
; CHECK-81M-LE-LABEL: d1:
; CHECK-81M-LE:       @ %bb.0: @ %entry
; CHECK-81M-LE-NEXT:    vstr fpcxtns, [sp, #-4]!
; CHECK-81M-LE-NEXT:    push {r7, lr}
; CHECK-81M-LE-NEXT:    sub sp, #4
; CHECK-81M-LE-NEXT:    vldr d0, .LCPI1_0
; CHECK-81M-LE-NEXT:    blx r0
; CHECK-81M-LE-NEXT:    add sp, #4
; CHECK-81M-LE-NEXT:    pop.w {r7, lr}
; CHECK-81M-LE-NEXT:    vscclrm {s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, vpr}
; CHECK-81M-LE-NEXT:    vldr fpcxtns, [sp], #4
; CHECK-81M-LE-NEXT:    clrm {r0, r1, r2, r3, r12, apsr}
; CHECK-81M-LE-NEXT:    bxns lr
; CHECK-81M-LE-NEXT:    .p2align 3
; CHECK-81M-LE-NEXT:  @ %bb.1:
; CHECK-81M-LE-NEXT:  .LCPI1_0:
; CHECK-81M-LE-NEXT:    .long 0 @ double 10
; CHECK-81M-LE-NEXT:    .long 1076101120
;
; CHECK-81M-BE-LABEL: d1:
; CHECK-81M-BE:       @ %bb.0: @ %entry
; CHECK-81M-BE-NEXT:    vstr fpcxtns, [sp, #-4]!
; CHECK-81M-BE-NEXT:    push {r7, lr}
; CHECK-81M-BE-NEXT:    sub sp, #4
; CHECK-81M-BE-NEXT:    vldr d0, .LCPI1_0
; CHECK-81M-BE-NEXT:    blx r0
; CHECK-81M-BE-NEXT:    add sp, #4
; CHECK-81M-BE-NEXT:    pop.w {r7, lr}
; CHECK-81M-BE-NEXT:    vscclrm {s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, vpr}
; CHECK-81M-BE-NEXT:    vldr fpcxtns, [sp], #4
; CHECK-81M-BE-NEXT:    clrm {r0, r1, r2, r3, r12, apsr}
; CHECK-81M-BE-NEXT:    bxns lr
; CHECK-81M-BE-NEXT:    .p2align 3
; CHECK-81M-BE-NEXT:  @ %bb.1:
; CHECK-81M-BE-NEXT:  .LCPI1_0:
; CHECK-81M-BE-NEXT:    .long 1076101120 @ double 10
; CHECK-81M-BE-NEXT:    .long 0
entry:
  %call = call double %fptr(double 10.0) #1
  ret double %call
}

define float @f2(float (float)* nocapture %fptr) #2 {
; CHECK-8M-LABEL: f2:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    push {r7, lr}
; CHECK-8M-NEXT:    vmov.f32 s0, #1.000000e+01
; CHECK-8M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    bic r0, r0, #1
; CHECK-8M-NEXT:    sub sp, #136
; CHECK-8M-NEXT:    vmov r12, s0
; CHECK-8M-NEXT:    vlstm sp
; CHECK-8M-NEXT:    vmov s0, r12
; CHECK-8M-NEXT:    ldr r1, [sp, #64]
; CHECK-8M-NEXT:    bic r1, r1, #159
; CHECK-8M-NEXT:    bic r1, r1, #4026531840
; CHECK-8M-NEXT:    vmsr fpscr, r1
; CHECK-8M-NEXT:    mov r1, r0
; CHECK-8M-NEXT:    mov r2, r0
; CHECK-8M-NEXT:    mov r3, r0
; CHECK-8M-NEXT:    mov r4, r0
; CHECK-8M-NEXT:    mov r5, r0
; CHECK-8M-NEXT:    mov r6, r0
; CHECK-8M-NEXT:    mov r7, r0
; CHECK-8M-NEXT:    mov r8, r0
; CHECK-8M-NEXT:    mov r9, r0
; CHECK-8M-NEXT:    mov r10, r0
; CHECK-8M-NEXT:    mov r11, r0
; CHECK-8M-NEXT:    msr apsr_nzcvqg, r0
; CHECK-8M-NEXT:    blxns r0
; CHECK-8M-NEXT:    vmov r12, s0
; CHECK-8M-NEXT:    vlldm sp
; CHECK-8M-NEXT:    vmov s0, r12
; CHECK-8M-NEXT:    add sp, #136
; CHECK-8M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    pop {r7, pc}
;
; CHECK-81M-LABEL: f2:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    push {r7, lr}
; CHECK-81M-NEXT:    vmov.f32 s0, #1.000000e+01
; CHECK-81M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    bic r0, r0, #1
; CHECK-81M-NEXT:    vpush {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    vscclrm {s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, vpr}
; CHECK-81M-NEXT:    vstr fpcxts, [sp, #-8]!
; CHECK-81M-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-NEXT:    blxns r0
; CHECK-81M-NEXT:    vldr fpcxts, [sp], #8
; CHECK-81M-NEXT:    vpop {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    pop {r7, pc}
entry:
  %call = call float %fptr(float 10.0) #3
  ret float %call
}

attributes #2 = { nounwind }
attributes #3 = { "cmse_nonsecure_call" nounwind }

define double @d2(double (double)* nocapture %fptr) #2 {
; CHECK-8M-LE-LABEL: d2:
; CHECK-8M-LE:       @ %bb.0: @ %entry
; CHECK-8M-LE-NEXT:    push {r7, lr}
; CHECK-8M-LE-NEXT:    vldr d0, .LCPI3_0
; CHECK-8M-LE-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-LE-NEXT:    bic r0, r0, #1
; CHECK-8M-LE-NEXT:    sub sp, #136
; CHECK-8M-LE-NEXT:    vmov r11, r12, d0
; CHECK-8M-LE-NEXT:    vlstm sp
; CHECK-8M-LE-NEXT:    vmov d0, r11, r12
; CHECK-8M-LE-NEXT:    ldr r1, [sp, #64]
; CHECK-8M-LE-NEXT:    bic r1, r1, #159
; CHECK-8M-LE-NEXT:    bic r1, r1, #4026531840
; CHECK-8M-LE-NEXT:    vmsr fpscr, r1
; CHECK-8M-LE-NEXT:    mov r1, r0
; CHECK-8M-LE-NEXT:    mov r2, r0
; CHECK-8M-LE-NEXT:    mov r3, r0
; CHECK-8M-LE-NEXT:    mov r4, r0
; CHECK-8M-LE-NEXT:    mov r5, r0
; CHECK-8M-LE-NEXT:    mov r6, r0
; CHECK-8M-LE-NEXT:    mov r7, r0
; CHECK-8M-LE-NEXT:    mov r8, r0
; CHECK-8M-LE-NEXT:    mov r9, r0
; CHECK-8M-LE-NEXT:    mov r10, r0
; CHECK-8M-LE-NEXT:    msr apsr_nzcvqg, r0
; CHECK-8M-LE-NEXT:    blxns r0
; CHECK-8M-LE-NEXT:    vmov r11, r12, d0
; CHECK-8M-LE-NEXT:    vlldm sp
; CHECK-8M-LE-NEXT:    vmov d0, r11, r12
; CHECK-8M-LE-NEXT:    add sp, #136
; CHECK-8M-LE-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-LE-NEXT:    pop {r7, pc}
; CHECK-8M-LE-NEXT:    .p2align 3
; CHECK-8M-LE-NEXT:  @ %bb.1:
; CHECK-8M-LE-NEXT:  .LCPI3_0:
; CHECK-8M-LE-NEXT:    .long 0 @ double 10
; CHECK-8M-LE-NEXT:    .long 1076101120
;
; CHECK-8M-BE-LABEL: d2:
; CHECK-8M-BE:       @ %bb.0: @ %entry
; CHECK-8M-BE-NEXT:    push {r7, lr}
; CHECK-8M-BE-NEXT:    vldr d0, .LCPI3_0
; CHECK-8M-BE-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-BE-NEXT:    bic r0, r0, #1
; CHECK-8M-BE-NEXT:    sub sp, #136
; CHECK-8M-BE-NEXT:    vmov r11, r12, d0
; CHECK-8M-BE-NEXT:    vlstm sp
; CHECK-8M-BE-NEXT:    vmov d0, r11, r12
; CHECK-8M-BE-NEXT:    ldr r1, [sp, #64]
; CHECK-8M-BE-NEXT:    bic r1, r1, #159
; CHECK-8M-BE-NEXT:    bic r1, r1, #4026531840
; CHECK-8M-BE-NEXT:    vmsr fpscr, r1
; CHECK-8M-BE-NEXT:    mov r1, r0
; CHECK-8M-BE-NEXT:    mov r2, r0
; CHECK-8M-BE-NEXT:    mov r3, r0
; CHECK-8M-BE-NEXT:    mov r4, r0
; CHECK-8M-BE-NEXT:    mov r5, r0
; CHECK-8M-BE-NEXT:    mov r6, r0
; CHECK-8M-BE-NEXT:    mov r7, r0
; CHECK-8M-BE-NEXT:    mov r8, r0
; CHECK-8M-BE-NEXT:    mov r9, r0
; CHECK-8M-BE-NEXT:    mov r10, r0
; CHECK-8M-BE-NEXT:    msr apsr_nzcvqg, r0
; CHECK-8M-BE-NEXT:    blxns r0
; CHECK-8M-BE-NEXT:    vmov r11, r12, d0
; CHECK-8M-BE-NEXT:    vlldm sp
; CHECK-8M-BE-NEXT:    vmov d0, r11, r12
; CHECK-8M-BE-NEXT:    add sp, #136
; CHECK-8M-BE-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-BE-NEXT:    pop {r7, pc}
; CHECK-8M-BE-NEXT:    .p2align 3
; CHECK-8M-BE-NEXT:  @ %bb.1:
; CHECK-8M-BE-NEXT:  .LCPI3_0:
; CHECK-8M-BE-NEXT:    .long 1076101120 @ double 10
; CHECK-8M-BE-NEXT:    .long 0
;
; CHECK-81M-LE-LABEL: d2:
; CHECK-81M-LE:       @ %bb.0: @ %entry
; CHECK-81M-LE-NEXT:    push {r7, lr}
; CHECK-81M-LE-NEXT:    vldr d0, .LCPI3_0
; CHECK-81M-LE-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-LE-NEXT:    bic r0, r0, #1
; CHECK-81M-LE-NEXT:    vpush {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-LE-NEXT:    vscclrm {s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, vpr}
; CHECK-81M-LE-NEXT:    vstr fpcxts, [sp, #-8]!
; CHECK-81M-LE-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-LE-NEXT:    blxns r0
; CHECK-81M-LE-NEXT:    vldr fpcxts, [sp], #8
; CHECK-81M-LE-NEXT:    vpop {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-LE-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-LE-NEXT:    pop {r7, pc}
; CHECK-81M-LE-NEXT:    .p2align 3
; CHECK-81M-LE-NEXT:  @ %bb.1:
; CHECK-81M-LE-NEXT:  .LCPI3_0:
; CHECK-81M-LE-NEXT:    .long 0 @ double 10
; CHECK-81M-LE-NEXT:    .long 1076101120
;
; CHECK-81M-BE-LABEL: d2:
; CHECK-81M-BE:       @ %bb.0: @ %entry
; CHECK-81M-BE-NEXT:    push {r7, lr}
; CHECK-81M-BE-NEXT:    vldr d0, .LCPI3_0
; CHECK-81M-BE-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-BE-NEXT:    bic r0, r0, #1
; CHECK-81M-BE-NEXT:    vpush {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-BE-NEXT:    vscclrm {s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, vpr}
; CHECK-81M-BE-NEXT:    vstr fpcxts, [sp, #-8]!
; CHECK-81M-BE-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-BE-NEXT:    blxns r0
; CHECK-81M-BE-NEXT:    vldr fpcxts, [sp], #8
; CHECK-81M-BE-NEXT:    vpop {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-BE-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-BE-NEXT:    pop {r7, pc}
; CHECK-81M-BE-NEXT:    .p2align 3
; CHECK-81M-BE-NEXT:  @ %bb.1:
; CHECK-81M-BE-NEXT:  .LCPI3_0:
; CHECK-81M-BE-NEXT:    .long 1076101120 @ double 10
; CHECK-81M-BE-NEXT:    .long 0
entry:
  %call = call double %fptr(double 10.0) #3
  ret double %call
}

define float @f3(float (float)* nocapture %fptr) #4 {
; CHECK-8M-LABEL: f3:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    push {r7, lr}
; CHECK-8M-NEXT:    vmov.f32 s0, #1.000000e+01
; CHECK-8M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    bic r0, r0, #1
; CHECK-8M-NEXT:    sub sp, #136
; CHECK-8M-NEXT:    vmov r12, s0
; CHECK-8M-NEXT:    vlstm sp
; CHECK-8M-NEXT:    vmov s0, r12
; CHECK-8M-NEXT:    ldr r1, [sp, #64]
; CHECK-8M-NEXT:    bic r1, r1, #159
; CHECK-8M-NEXT:    bic r1, r1, #4026531840
; CHECK-8M-NEXT:    vmsr fpscr, r1
; CHECK-8M-NEXT:    mov r1, r0
; CHECK-8M-NEXT:    mov r2, r0
; CHECK-8M-NEXT:    mov r3, r0
; CHECK-8M-NEXT:    mov r4, r0
; CHECK-8M-NEXT:    mov r5, r0
; CHECK-8M-NEXT:    mov r6, r0
; CHECK-8M-NEXT:    mov r7, r0
; CHECK-8M-NEXT:    mov r8, r0
; CHECK-8M-NEXT:    mov r9, r0
; CHECK-8M-NEXT:    mov r10, r0
; CHECK-8M-NEXT:    mov r11, r0
; CHECK-8M-NEXT:    msr apsr_nzcvqg, r0
; CHECK-8M-NEXT:    blxns r0
; CHECK-8M-NEXT:    vmov r12, s0
; CHECK-8M-NEXT:    vlldm sp
; CHECK-8M-NEXT:    vmov s0, r12
; CHECK-8M-NEXT:    add sp, #136
; CHECK-8M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    pop {r7, pc}
;
; CHECK-81M-LABEL: f3:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    push {r7, lr}
; CHECK-81M-NEXT:    vmov.f32 s0, #1.000000e+01
; CHECK-81M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    bic r0, r0, #1
; CHECK-81M-NEXT:    vpush {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    vscclrm {s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, vpr}
; CHECK-81M-NEXT:    vstr fpcxts, [sp, #-8]!
; CHECK-81M-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-NEXT:    blxns r0
; CHECK-81M-NEXT:    vldr fpcxts, [sp], #8
; CHECK-81M-NEXT:    vpop {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    pop {r7, pc}
entry:
  %call = tail call float %fptr(float 10.0) #5
  ret float %call
}

attributes #4 = { nounwind }
attributes #5 = { "cmse_nonsecure_call" nounwind }

define double @d3(double (double)* nocapture %fptr) #4 {
; CHECK-8M-LE-LABEL: d3:
; CHECK-8M-LE:       @ %bb.0: @ %entry
; CHECK-8M-LE-NEXT:    push {r7, lr}
; CHECK-8M-LE-NEXT:    vldr d0, .LCPI5_0
; CHECK-8M-LE-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-LE-NEXT:    bic r0, r0, #1
; CHECK-8M-LE-NEXT:    sub sp, #136
; CHECK-8M-LE-NEXT:    vmov r11, r12, d0
; CHECK-8M-LE-NEXT:    vlstm sp
; CHECK-8M-LE-NEXT:    vmov d0, r11, r12
; CHECK-8M-LE-NEXT:    ldr r1, [sp, #64]
; CHECK-8M-LE-NEXT:    bic r1, r1, #159
; CHECK-8M-LE-NEXT:    bic r1, r1, #4026531840
; CHECK-8M-LE-NEXT:    vmsr fpscr, r1
; CHECK-8M-LE-NEXT:    mov r1, r0
; CHECK-8M-LE-NEXT:    mov r2, r0
; CHECK-8M-LE-NEXT:    mov r3, r0
; CHECK-8M-LE-NEXT:    mov r4, r0
; CHECK-8M-LE-NEXT:    mov r5, r0
; CHECK-8M-LE-NEXT:    mov r6, r0
; CHECK-8M-LE-NEXT:    mov r7, r0
; CHECK-8M-LE-NEXT:    mov r8, r0
; CHECK-8M-LE-NEXT:    mov r9, r0
; CHECK-8M-LE-NEXT:    mov r10, r0
; CHECK-8M-LE-NEXT:    msr apsr_nzcvqg, r0
; CHECK-8M-LE-NEXT:    blxns r0
; CHECK-8M-LE-NEXT:    vmov r11, r12, d0
; CHECK-8M-LE-NEXT:    vlldm sp
; CHECK-8M-LE-NEXT:    vmov d0, r11, r12
; CHECK-8M-LE-NEXT:    add sp, #136
; CHECK-8M-LE-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-LE-NEXT:    pop {r7, pc}
; CHECK-8M-LE-NEXT:    .p2align 3
; CHECK-8M-LE-NEXT:  @ %bb.1:
; CHECK-8M-LE-NEXT:  .LCPI5_0:
; CHECK-8M-LE-NEXT:    .long 0 @ double 10
; CHECK-8M-LE-NEXT:    .long 1076101120
;
; CHECK-8M-BE-LABEL: d3:
; CHECK-8M-BE:       @ %bb.0: @ %entry
; CHECK-8M-BE-NEXT:    push {r7, lr}
; CHECK-8M-BE-NEXT:    vldr d0, .LCPI5_0
; CHECK-8M-BE-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-BE-NEXT:    bic r0, r0, #1
; CHECK-8M-BE-NEXT:    sub sp, #136
; CHECK-8M-BE-NEXT:    vmov r11, r12, d0
; CHECK-8M-BE-NEXT:    vlstm sp
; CHECK-8M-BE-NEXT:    vmov d0, r11, r12
; CHECK-8M-BE-NEXT:    ldr r1, [sp, #64]
; CHECK-8M-BE-NEXT:    bic r1, r1, #159
; CHECK-8M-BE-NEXT:    bic r1, r1, #4026531840
; CHECK-8M-BE-NEXT:    vmsr fpscr, r1
; CHECK-8M-BE-NEXT:    mov r1, r0
; CHECK-8M-BE-NEXT:    mov r2, r0
; CHECK-8M-BE-NEXT:    mov r3, r0
; CHECK-8M-BE-NEXT:    mov r4, r0
; CHECK-8M-BE-NEXT:    mov r5, r0
; CHECK-8M-BE-NEXT:    mov r6, r0
; CHECK-8M-BE-NEXT:    mov r7, r0
; CHECK-8M-BE-NEXT:    mov r8, r0
; CHECK-8M-BE-NEXT:    mov r9, r0
; CHECK-8M-BE-NEXT:    mov r10, r0
; CHECK-8M-BE-NEXT:    msr apsr_nzcvqg, r0
; CHECK-8M-BE-NEXT:    blxns r0
; CHECK-8M-BE-NEXT:    vmov r11, r12, d0
; CHECK-8M-BE-NEXT:    vlldm sp
; CHECK-8M-BE-NEXT:    vmov d0, r11, r12
; CHECK-8M-BE-NEXT:    add sp, #136
; CHECK-8M-BE-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-BE-NEXT:    pop {r7, pc}
; CHECK-8M-BE-NEXT:    .p2align 3
; CHECK-8M-BE-NEXT:  @ %bb.1:
; CHECK-8M-BE-NEXT:  .LCPI5_0:
; CHECK-8M-BE-NEXT:    .long 1076101120 @ double 10
; CHECK-8M-BE-NEXT:    .long 0
;
; CHECK-81M-LE-LABEL: d3:
; CHECK-81M-LE:       @ %bb.0: @ %entry
; CHECK-81M-LE-NEXT:    push {r7, lr}
; CHECK-81M-LE-NEXT:    vldr d0, .LCPI5_0
; CHECK-81M-LE-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-LE-NEXT:    bic r0, r0, #1
; CHECK-81M-LE-NEXT:    vpush {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-LE-NEXT:    vscclrm {s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, vpr}
; CHECK-81M-LE-NEXT:    vstr fpcxts, [sp, #-8]!
; CHECK-81M-LE-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-LE-NEXT:    blxns r0
; CHECK-81M-LE-NEXT:    vldr fpcxts, [sp], #8
; CHECK-81M-LE-NEXT:    vpop {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-LE-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-LE-NEXT:    pop {r7, pc}
; CHECK-81M-LE-NEXT:    .p2align 3
; CHECK-81M-LE-NEXT:  @ %bb.1:
; CHECK-81M-LE-NEXT:  .LCPI5_0:
; CHECK-81M-LE-NEXT:    .long 0 @ double 10
; CHECK-81M-LE-NEXT:    .long 1076101120
;
; CHECK-81M-BE-LABEL: d3:
; CHECK-81M-BE:       @ %bb.0: @ %entry
; CHECK-81M-BE-NEXT:    push {r7, lr}
; CHECK-81M-BE-NEXT:    vldr d0, .LCPI5_0
; CHECK-81M-BE-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-BE-NEXT:    bic r0, r0, #1
; CHECK-81M-BE-NEXT:    vpush {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-BE-NEXT:    vscclrm {s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, vpr}
; CHECK-81M-BE-NEXT:    vstr fpcxts, [sp, #-8]!
; CHECK-81M-BE-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-BE-NEXT:    blxns r0
; CHECK-81M-BE-NEXT:    vldr fpcxts, [sp], #8
; CHECK-81M-BE-NEXT:    vpop {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-BE-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-BE-NEXT:    pop {r7, pc}
; CHECK-81M-BE-NEXT:    .p2align 3
; CHECK-81M-BE-NEXT:  @ %bb.1:
; CHECK-81M-BE-NEXT:  .LCPI5_0:
; CHECK-81M-BE-NEXT:    .long 1076101120 @ double 10
; CHECK-81M-BE-NEXT:    .long 0
entry:
  %call = tail call double %fptr(double 10.0) #5
  ret double %call
}

define float @f4(float ()* nocapture %fptr) #6 {
; CHECK-8M-LABEL: f4:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    push {r7, lr}
; CHECK-8M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    bic r0, r0, #1
; CHECK-8M-NEXT:    sub sp, #136
; CHECK-8M-NEXT:    vlstm sp
; CHECK-8M-NEXT:    mov r1, r0
; CHECK-8M-NEXT:    mov r2, r0
; CHECK-8M-NEXT:    mov r3, r0
; CHECK-8M-NEXT:    mov r4, r0
; CHECK-8M-NEXT:    mov r5, r0
; CHECK-8M-NEXT:    mov r6, r0
; CHECK-8M-NEXT:    mov r7, r0
; CHECK-8M-NEXT:    mov r8, r0
; CHECK-8M-NEXT:    mov r9, r0
; CHECK-8M-NEXT:    mov r10, r0
; CHECK-8M-NEXT:    mov r11, r0
; CHECK-8M-NEXT:    mov r12, r0
; CHECK-8M-NEXT:    msr apsr_nzcvqg, r0
; CHECK-8M-NEXT:    blxns r0
; CHECK-8M-NEXT:    vmov r12, s0
; CHECK-8M-NEXT:    vlldm sp
; CHECK-8M-NEXT:    vmov s0, r12
; CHECK-8M-NEXT:    add sp, #136
; CHECK-8M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    pop {r7, pc}
;
; CHECK-81M-LABEL: f4:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    push {r7, lr}
; CHECK-81M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    bic r0, r0, #1
; CHECK-81M-NEXT:    vpush {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    vscclrm {s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, vpr}
; CHECK-81M-NEXT:    vstr fpcxts, [sp, #-8]!
; CHECK-81M-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-NEXT:    blxns r0
; CHECK-81M-NEXT:    vldr fpcxts, [sp], #8
; CHECK-81M-NEXT:    vpop {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    pop {r7, pc}
entry:
  %call = call float %fptr() #7
  ret float %call
}

attributes #6 = { nounwind }
attributes #7 = { "cmse_nonsecure_call" nounwind }

define double @d4(double ()* nocapture %fptr) #6 {
; CHECK-8M-LABEL: d4:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    push {r7, lr}
; CHECK-8M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    bic r0, r0, #1
; CHECK-8M-NEXT:    sub sp, #136
; CHECK-8M-NEXT:    vlstm sp
; CHECK-8M-NEXT:    mov r1, r0
; CHECK-8M-NEXT:    mov r2, r0
; CHECK-8M-NEXT:    mov r3, r0
; CHECK-8M-NEXT:    mov r4, r0
; CHECK-8M-NEXT:    mov r5, r0
; CHECK-8M-NEXT:    mov r6, r0
; CHECK-8M-NEXT:    mov r7, r0
; CHECK-8M-NEXT:    mov r8, r0
; CHECK-8M-NEXT:    mov r9, r0
; CHECK-8M-NEXT:    mov r10, r0
; CHECK-8M-NEXT:    mov r11, r0
; CHECK-8M-NEXT:    mov r12, r0
; CHECK-8M-NEXT:    msr apsr_nzcvqg, r0
; CHECK-8M-NEXT:    blxns r0
; CHECK-8M-NEXT:    vmov r11, r12, d0
; CHECK-8M-NEXT:    vlldm sp
; CHECK-8M-NEXT:    vmov d0, r11, r12
; CHECK-8M-NEXT:    add sp, #136
; CHECK-8M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    pop {r7, pc}
;
; CHECK-81M-LABEL: d4:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    push {r7, lr}
; CHECK-81M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    bic r0, r0, #1
; CHECK-81M-NEXT:    vpush {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    vscclrm {s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, vpr}
; CHECK-81M-NEXT:    vstr fpcxts, [sp, #-8]!
; CHECK-81M-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-NEXT:    blxns r0
; CHECK-81M-NEXT:    vldr fpcxts, [sp], #8
; CHECK-81M-NEXT:    vpop {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    pop {r7, pc}
entry:
  %call = call double %fptr() #7
  ret double %call
}

define void @fd(void (float, double)* %f, float %a, double %b) #8 {
; CHECK-8M-LABEL: fd:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    push {r7, lr}
; CHECK-8M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    bic r0, r0, #1
; CHECK-8M-NEXT:    sub sp, #136
; CHECK-8M-NEXT:    vmov r12, s0
; CHECK-8M-NEXT:    vmov r10, r11, d1
; CHECK-8M-NEXT:    vlstm sp
; CHECK-8M-NEXT:    vmov s0, r12
; CHECK-8M-NEXT:    vmov d1, r10, r11
; CHECK-8M-NEXT:    ldr r1, [sp, #64]
; CHECK-8M-NEXT:    bic r1, r1, #159
; CHECK-8M-NEXT:    bic r1, r1, #4026531840
; CHECK-8M-NEXT:    vmsr fpscr, r1
; CHECK-8M-NEXT:    mov r1, r0
; CHECK-8M-NEXT:    mov r2, r0
; CHECK-8M-NEXT:    mov r3, r0
; CHECK-8M-NEXT:    mov r4, r0
; CHECK-8M-NEXT:    mov r5, r0
; CHECK-8M-NEXT:    mov r6, r0
; CHECK-8M-NEXT:    mov r7, r0
; CHECK-8M-NEXT:    mov r8, r0
; CHECK-8M-NEXT:    mov r9, r0
; CHECK-8M-NEXT:    msr apsr_nzcvqg, r0
; CHECK-8M-NEXT:    blxns r0
; CHECK-8M-NEXT:    vlldm sp
; CHECK-8M-NEXT:    add sp, #136
; CHECK-8M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    pop {r7, pc}
;
; CHECK-81M-LABEL: fd:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    push {r7, lr}
; CHECK-81M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    bic r0, r0, #1
; CHECK-81M-NEXT:    vpush {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    vscclrm {s1, vpr}
; CHECK-81M-NEXT:    vscclrm {s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, vpr}
; CHECK-81M-NEXT:    vstr fpcxts, [sp, #-8]!
; CHECK-81M-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-NEXT:    blxns r0
; CHECK-81M-NEXT:    vldr fpcxts, [sp], #8
; CHECK-81M-NEXT:    vpop {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    pop {r7, pc}
entry:
  call void %f(float %a, double %b) #9
  ret void
}

attributes #8 = { nounwind }
attributes #9 = { "cmse_nonsecure_call" nounwind }

define void @fdff(void (float, double, float, float)* %f, float %a, double %b, float %c, float %d) #8 {
; CHECK-8M-LABEL: fdff:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    push {r7, lr}
; CHECK-8M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    bic r0, r0, #1
; CHECK-8M-NEXT:    sub sp, #136
; CHECK-8M-NEXT:    vmov r12, s0
; CHECK-8M-NEXT:    vmov r10, r11, d1
; CHECK-8M-NEXT:    vmov r9, s1
; CHECK-8M-NEXT:    vmov r8, s4
; CHECK-8M-NEXT:    vlstm sp
; CHECK-8M-NEXT:    vmov s0, r12
; CHECK-8M-NEXT:    vmov d1, r10, r11
; CHECK-8M-NEXT:    vmov s1, r9
; CHECK-8M-NEXT:    vmov s4, r8
; CHECK-8M-NEXT:    ldr r1, [sp, #64]
; CHECK-8M-NEXT:    bic r1, r1, #159
; CHECK-8M-NEXT:    bic r1, r1, #4026531840
; CHECK-8M-NEXT:    vmsr fpscr, r1
; CHECK-8M-NEXT:    mov r1, r0
; CHECK-8M-NEXT:    mov r2, r0
; CHECK-8M-NEXT:    mov r3, r0
; CHECK-8M-NEXT:    mov r4, r0
; CHECK-8M-NEXT:    mov r5, r0
; CHECK-8M-NEXT:    mov r6, r0
; CHECK-8M-NEXT:    mov r7, r0
; CHECK-8M-NEXT:    msr apsr_nzcvqg, r0
; CHECK-8M-NEXT:    blxns r0
; CHECK-8M-NEXT:    vlldm sp
; CHECK-8M-NEXT:    add sp, #136
; CHECK-8M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    pop {r7, pc}
;
; CHECK-81M-LABEL: fdff:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    push {r7, lr}
; CHECK-81M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    bic r0, r0, #1
; CHECK-81M-NEXT:    vpush {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    vscclrm {s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, vpr}
; CHECK-81M-NEXT:    vstr fpcxts, [sp, #-8]!
; CHECK-81M-NEXT:    clrm {r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, apsr}
; CHECK-81M-NEXT:    blxns r0
; CHECK-81M-NEXT:    vldr fpcxts, [sp], #8
; CHECK-81M-NEXT:    vpop {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    pop {r7, pc}
entry:
  call void %f(float %a, double %b, float %c, float %d) #9
  ret void
}

define void @fidififid(void (float, i32, double, i32, float, i32, float, i32, double)* %fu, float %a, i32 %b, double %c, i32 %d, float %e, i32 %f, float %g, i32 %h, double %i) #8 {
; CHECK-8M-LABEL: fidififid:
; CHECK-8M:       @ %bb.0: @ %entry
; CHECK-8M-NEXT:    push {r7, lr}
; CHECK-8M-NEXT:    mov lr, r3
; CHECK-8M-NEXT:    mov r12, r0
; CHECK-8M-NEXT:    mov r0, r1
; CHECK-8M-NEXT:    mov r1, r2
; CHECK-8M-NEXT:    ldr r3, [sp, #8]
; CHECK-8M-NEXT:    mov r2, lr
; CHECK-8M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    bic r12, r12, #1
; CHECK-8M-NEXT:    sub sp, #136
; CHECK-8M-NEXT:    vmov r11, s0
; CHECK-8M-NEXT:    vmov r9, r10, d1
; CHECK-8M-NEXT:    vmov r8, s1
; CHECK-8M-NEXT:    vmov r7, s4
; CHECK-8M-NEXT:    vmov r5, r6, d3
; CHECK-8M-NEXT:    vlstm sp
; CHECK-8M-NEXT:    vmov s0, r11
; CHECK-8M-NEXT:    vmov d1, r9, r10
; CHECK-8M-NEXT:    vmov s1, r8
; CHECK-8M-NEXT:    vmov s4, r7
; CHECK-8M-NEXT:    vmov d3, r5, r6
; CHECK-8M-NEXT:    ldr r4, [sp, #64]
; CHECK-8M-NEXT:    bic r4, r4, #159
; CHECK-8M-NEXT:    bic r4, r4, #4026531840
; CHECK-8M-NEXT:    vmsr fpscr, r4
; CHECK-8M-NEXT:    mov r4, r12
; CHECK-8M-NEXT:    msr apsr_nzcvqg, r12
; CHECK-8M-NEXT:    blxns r12
; CHECK-8M-NEXT:    vlldm sp
; CHECK-8M-NEXT:    add sp, #136
; CHECK-8M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-8M-NEXT:    pop {r7, pc}
;
; CHECK-81M-LABEL: fidififid:
; CHECK-81M:       @ %bb.0: @ %entry
; CHECK-81M-NEXT:    push {r7, lr}
; CHECK-81M-NEXT:    mov lr, r3
; CHECK-81M-NEXT:    mov r12, r0
; CHECK-81M-NEXT:    mov r0, r1
; CHECK-81M-NEXT:    mov r1, r2
; CHECK-81M-NEXT:    ldr r3, [sp, #8]
; CHECK-81M-NEXT:    mov r2, lr
; CHECK-81M-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    bic r12, r12, #1
; CHECK-81M-NEXT:    vpush {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    vscclrm {s5, vpr}
; CHECK-81M-NEXT:    vscclrm {s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, vpr}
; CHECK-81M-NEXT:    vstr fpcxts, [sp, #-8]!
; CHECK-81M-NEXT:    clrm {r4, r5, r6, r7, r8, r9, r10, r11, apsr}
; CHECK-81M-NEXT:    blxns r12
; CHECK-81M-NEXT:    vldr fpcxts, [sp], #8
; CHECK-81M-NEXT:    vpop {s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31}
; CHECK-81M-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11}
; CHECK-81M-NEXT:    pop {r7, pc}
entry:
  call void %fu(float %a, i32 %b, double %c, i32 %d, float %e, i32 %f, float %g, i32 %h, double %i) #9
  ret void
}

