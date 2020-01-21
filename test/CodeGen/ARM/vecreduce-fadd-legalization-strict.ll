; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm-none-eabi -mattr=+neon | FileCheck %s --check-prefix=CHECK

declare half @llvm.experimental.vector.reduce.v2.fadd.f16.v1f16(half, <1 x half>)
declare float @llvm.experimental.vector.reduce.v2.fadd.f32.v1f32(float, <1 x float>)
declare double @llvm.experimental.vector.reduce.v2.fadd.f64.v1f64(double, <1 x double>)
declare fp128 @llvm.experimental.vector.reduce.v2.fadd.f128.v1f128(fp128, <1 x fp128>)

declare float @llvm.experimental.vector.reduce.v2.fadd.f32.v3f32(float, <3 x float>)
declare fp128 @llvm.experimental.vector.reduce.v2.fadd.f128.v2f128(fp128, <2 x fp128>)
declare float @llvm.experimental.vector.reduce.v2.fadd.f32.v16f32(float, <16 x float>)

define half @test_v1f16(<1 x half> %a) nounwind {
; CHECK-LABEL: test_v1f16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r11, lr}
; CHECK-NEXT:    push {r11, lr}
; CHECK-NEXT:    bl __aeabi_f2h
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    vldr s0, .LCPI0_0
; CHECK-NEXT:    vmov s2, r0
; CHECK-NEXT:    vadd.f32 s0, s2, s0
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    pop {r11, lr}
; CHECK-NEXT:    mov pc, lr
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI0_0:
; CHECK-NEXT:    .long 0 @ float 0
  %b = call half @llvm.experimental.vector.reduce.v2.fadd.f16.v1f16(half 0.0, <1 x half> %a)
  ret half %b
}

define float @test_v1f32(<1 x float> %a) nounwind {
; CHECK-LABEL: test_v1f32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr s0, .LCPI1_0
; CHECK-NEXT:    vmov s2, r0
; CHECK-NEXT:    vadd.f32 s0, s2, s0
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    mov pc, lr
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI1_0:
; CHECK-NEXT:    .long 0 @ float 0
  %b = call float @llvm.experimental.vector.reduce.v2.fadd.f32.v1f32(float 0.0, <1 x float> %a)
  ret float %b
}

define double @test_v1f64(<1 x double> %a) nounwind {
; CHECK-LABEL: test_v1f64:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov.i32 d16, #0x0
; CHECK-NEXT:    vmov d17, r0, r1
; CHECK-NEXT:    vadd.f64 d16, d17, d16
; CHECK-NEXT:    vmov r0, r1, d16
; CHECK-NEXT:    mov pc, lr
  %b = call double @llvm.experimental.vector.reduce.v2.fadd.f64.v1f64(double 0.0, <1 x double> %a)
  ret double %b
}

define fp128 @test_v1f128(<1 x fp128> %a) nounwind {
; CHECK-LABEL: test_v1f128:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r11, lr}
; CHECK-NEXT:    push {r11, lr}
; CHECK-NEXT:    .pad #16
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    mov r12, #0
; CHECK-NEXT:    str r12, [sp]
; CHECK-NEXT:    str r12, [sp, #4]
; CHECK-NEXT:    str r12, [sp, #8]
; CHECK-NEXT:    str r12, [sp, #12]
; CHECK-NEXT:    bl __addtf3
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    pop {r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call fp128 @llvm.experimental.vector.reduce.v2.fadd.f128.v1f128(fp128 zeroinitializer, <1 x fp128> %a)
  ret fp128 %b
}

define float @test_v3f32(<3 x float> %a) nounwind {
; CHECK-LABEL: test_v3f32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov d3, r2, r3
; CHECK-NEXT:    vldr s0, .LCPI4_0
; CHECK-NEXT:    vmov d2, r0, r1
; CHECK-NEXT:    vadd.f32 s0, s4, s0
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    mov pc, lr
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI4_0:
; CHECK-NEXT:    .long 0 @ float 0
  %b = call float @llvm.experimental.vector.reduce.v2.fadd.f32.v3f32(float 0.0, <3 x float> %a)
  ret float %b
}

define fp128 @test_v2f128(<2 x fp128> %a) nounwind {
; CHECK-LABEL: test_v2f128:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r11, lr}
; CHECK-NEXT:    push {r4, r5, r11, lr}
; CHECK-NEXT:    .pad #16
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    mov r12, #0
; CHECK-NEXT:    str r12, [sp]
; CHECK-NEXT:    str r12, [sp, #4]
; CHECK-NEXT:    str r12, [sp, #8]
; CHECK-NEXT:    str r12, [sp, #12]
; CHECK-NEXT:    bl __addtf3
; CHECK-NEXT:    ldr r12, [sp, #36]
; CHECK-NEXT:    ldr lr, [sp, #32]
; CHECK-NEXT:    ldr r4, [sp, #40]
; CHECK-NEXT:    ldr r5, [sp, #44]
; CHECK-NEXT:    str lr, [sp]
; CHECK-NEXT:    str r12, [sp, #4]
; CHECK-NEXT:    str r4, [sp, #8]
; CHECK-NEXT:    str r5, [sp, #12]
; CHECK-NEXT:    bl __addtf3
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    pop {r4, r5, r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call fp128 @llvm.experimental.vector.reduce.v2.fadd.f128.v2f128(fp128 zeroinitializer, <2 x fp128> %a)
  ret fp128 %b
}

define float @test_v16f32(<16 x float> %a) nounwind {
; CHECK-LABEL: test_v16f32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov d3, r2, r3
; CHECK-NEXT:    vldr s0, .LCPI6_0
; CHECK-NEXT:    vmov d2, r0, r1
; CHECK-NEXT:    mov r0, sp
; CHECK-NEXT:    vadd.f32 s0, s4, s0
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    vld1.64 {d2, d3}, [r0]
; CHECK-NEXT:    add r0, sp, #16
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    vld1.64 {d2, d3}, [r0]
; CHECK-NEXT:    add r0, sp, #32
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    vld1.64 {d2, d3}, [r0]
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    mov pc, lr
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI6_0:
; CHECK-NEXT:    .long 0 @ float 0
  %b = call float @llvm.experimental.vector.reduce.v2.fadd.f32.v16f32(float 0.0, <16 x float> %a)
  ret float %b
}
