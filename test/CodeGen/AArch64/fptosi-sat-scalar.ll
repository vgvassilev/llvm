; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 < %s | FileCheck %s

;
; 32-bit float to signed integer
;

declare   i1 @llvm.fptosi.sat.i1.f32  (float)
declare   i8 @llvm.fptosi.sat.i8.f32  (float)
declare  i13 @llvm.fptosi.sat.i13.f32 (float)
declare  i16 @llvm.fptosi.sat.i16.f32 (float)
declare  i19 @llvm.fptosi.sat.i19.f32 (float)
declare  i32 @llvm.fptosi.sat.i32.f32 (float)
declare  i50 @llvm.fptosi.sat.i50.f32 (float)
declare  i64 @llvm.fptosi.sat.i64.f32 (float)
declare i100 @llvm.fptosi.sat.i100.f32(float)
declare i128 @llvm.fptosi.sat.i128.f32(float)

define i1 @test_signed_i1_f32(float %f) nounwind {
; CHECK-LABEL: test_signed_i1_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s1, #-1.00000000
; CHECK-NEXT:    movi d2, #0000000000000000
; CHECK-NEXT:    fmaxnm s1, s0, s1
; CHECK-NEXT:    fminnm s1, s1, s2
; CHECK-NEXT:    fcvtzs w8, s1
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w8, wzr, w8, vs
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
    %x = call i1 @llvm.fptosi.sat.i1.f32(float %f)
    ret i1 %x
}

define i8 @test_signed_i8_f32(float %f) nounwind {
; CHECK-LABEL: test_signed_i8_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-1023410176
; CHECK-NEXT:    mov w9, #1123942400
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fmaxnm s1, s0, s1
; CHECK-NEXT:    fmov s2, w9
; CHECK-NEXT:    fminnm s1, s1, s2
; CHECK-NEXT:    fcvtzs w8, s1
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i8 @llvm.fptosi.sat.i8.f32(float %f)
    ret i8 %x
}

define i13 @test_signed_i13_f32(float %f) nounwind {
; CHECK-LABEL: test_signed_i13_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-981467136
; CHECK-NEXT:    mov w9, #61440
; CHECK-NEXT:    movk w9, #17791, lsl #16
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fmaxnm s1, s0, s1
; CHECK-NEXT:    fmov s2, w9
; CHECK-NEXT:    fminnm s1, s1, s2
; CHECK-NEXT:    fcvtzs w8, s1
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i13 @llvm.fptosi.sat.i13.f32(float %f)
    ret i13 %x
}

define i16 @test_signed_i16_f32(float %f) nounwind {
; CHECK-LABEL: test_signed_i16_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-956301312
; CHECK-NEXT:    mov w9, #65024
; CHECK-NEXT:    movk w9, #18175, lsl #16
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fmaxnm s1, s0, s1
; CHECK-NEXT:    fmov s2, w9
; CHECK-NEXT:    fminnm s1, s1, s2
; CHECK-NEXT:    fcvtzs w8, s1
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i16 @llvm.fptosi.sat.i16.f32(float %f)
    ret i16 %x
}

define i19 @test_signed_i19_f32(float %f) nounwind {
; CHECK-LABEL: test_signed_i19_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-931135488
; CHECK-NEXT:    mov w9, #65472
; CHECK-NEXT:    movk w9, #18559, lsl #16
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fmaxnm s1, s0, s1
; CHECK-NEXT:    fmov s2, w9
; CHECK-NEXT:    fminnm s1, s1, s2
; CHECK-NEXT:    fcvtzs w8, s1
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i19 @llvm.fptosi.sat.i19.f32(float %f)
    ret i19 %x
}

define i32 @test_signed_i32_f32(float %f) nounwind {
; CHECK-LABEL: test_signed_i32_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w9, #-822083584
; CHECK-NEXT:    mov w11, #1325400063
; CHECK-NEXT:    fmov s1, w9
; CHECK-NEXT:    fcvtzs w8, s0
; CHECK-NEXT:    mov w10, #-2147483648
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    fmov s1, w11
; CHECK-NEXT:    mov w12, #2147483647
; CHECK-NEXT:    csel w8, w10, w8, lt
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    csel w8, w12, w8, gt
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i32 @llvm.fptosi.sat.i32.f32(float %f)
    ret i32 %x
}

define i50 @test_signed_i50_f32(float %f) nounwind {
; CHECK-LABEL: test_signed_i50_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w9, #-671088640
; CHECK-NEXT:    mov w11, #1476395007
; CHECK-NEXT:    fmov s1, w9
; CHECK-NEXT:    fcvtzs x8, s0
; CHECK-NEXT:    mov x10, #-562949953421312
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    fmov s1, w11
; CHECK-NEXT:    mov x12, #562949953421311
; CHECK-NEXT:    csel x8, x10, x8, lt
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    csel x8, x12, x8, gt
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel x0, xzr, x8, vs
; CHECK-NEXT:    ret
    %x = call i50 @llvm.fptosi.sat.i50.f32(float %f)
    ret i50 %x
}

define i64 @test_signed_i64_f32(float %f) nounwind {
; CHECK-LABEL: test_signed_i64_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w9, #-553648128
; CHECK-NEXT:    mov w11, #1593835519
; CHECK-NEXT:    fmov s1, w9
; CHECK-NEXT:    fcvtzs x8, s0
; CHECK-NEXT:    mov x10, #-9223372036854775808
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    fmov s1, w11
; CHECK-NEXT:    mov x12, #9223372036854775807
; CHECK-NEXT:    csel x8, x10, x8, lt
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    csel x8, x12, x8, gt
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel x0, xzr, x8, vs
; CHECK-NEXT:    ret
    %x = call i64 @llvm.fptosi.sat.i64.f32(float %f)
    ret i64 %x
}

define i100 @test_signed_i100_f32(float %f) nounwind {
; CHECK-LABEL: test_signed_i100_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    mov v8.16b, v0.16b
; CHECK-NEXT:    bl __fixsfti
; CHECK-NEXT:    mov w8, #-251658240
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov w8, #1895825407
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov x8, #-34359738368
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    csel x8, x8, x1, lt
; CHECK-NEXT:    mov x9, #34359738367
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    csel x8, x9, x8, gt
; CHECK-NEXT:    csinv x9, x10, xzr, le
; CHECK-NEXT:    fcmp s8, s8
; CHECK-NEXT:    csel x0, xzr, x9, vs
; CHECK-NEXT:    csel x1, xzr, x8, vs
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i100 @llvm.fptosi.sat.i100.f32(float %f)
    ret i100 %x
}

define i128 @test_signed_i128_f32(float %f) nounwind {
; CHECK-LABEL: test_signed_i128_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    mov v8.16b, v0.16b
; CHECK-NEXT:    bl __fixsfti
; CHECK-NEXT:    mov w8, #-16777216
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov w8, #2130706431
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov x8, #-9223372036854775808
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    csel x8, x8, x1, lt
; CHECK-NEXT:    mov x9, #9223372036854775807
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    csel x8, x9, x8, gt
; CHECK-NEXT:    csinv x9, x10, xzr, le
; CHECK-NEXT:    fcmp s8, s8
; CHECK-NEXT:    csel x0, xzr, x9, vs
; CHECK-NEXT:    csel x1, xzr, x8, vs
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i128 @llvm.fptosi.sat.i128.f32(float %f)
    ret i128 %x
}

;
; 64-bit float to signed integer
;

declare   i1 @llvm.fptosi.sat.i1.f64  (double)
declare   i8 @llvm.fptosi.sat.i8.f64  (double)
declare  i13 @llvm.fptosi.sat.i13.f64 (double)
declare  i16 @llvm.fptosi.sat.i16.f64 (double)
declare  i19 @llvm.fptosi.sat.i19.f64 (double)
declare  i32 @llvm.fptosi.sat.i32.f64 (double)
declare  i50 @llvm.fptosi.sat.i50.f64 (double)
declare  i64 @llvm.fptosi.sat.i64.f64 (double)
declare i100 @llvm.fptosi.sat.i100.f64(double)
declare i128 @llvm.fptosi.sat.i128.f64(double)

define i1 @test_signed_i1_f64(double %f) nounwind {
; CHECK-LABEL: test_signed_i1_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov d1, #-1.00000000
; CHECK-NEXT:    movi d2, #0000000000000000
; CHECK-NEXT:    fmaxnm d1, d0, d1
; CHECK-NEXT:    fminnm d1, d1, d2
; CHECK-NEXT:    fcvtzs w8, d1
; CHECK-NEXT:    fcmp d0, d0
; CHECK-NEXT:    csel w8, wzr, w8, vs
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
    %x = call i1 @llvm.fptosi.sat.i1.f64(double %f)
    ret i1 %x
}

define i8 @test_signed_i8_f64(double %f) nounwind {
; CHECK-LABEL: test_signed_i8_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-4584664420663164928
; CHECK-NEXT:    mov x9, #211106232532992
; CHECK-NEXT:    movk x9, #16479, lsl #48
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fmaxnm d1, d0, d1
; CHECK-NEXT:    fmov d2, x9
; CHECK-NEXT:    fminnm d1, d1, d2
; CHECK-NEXT:    fcvtzs w8, d1
; CHECK-NEXT:    fcmp d0, d0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i8 @llvm.fptosi.sat.i8.f64(double %f)
    ret i8 %x
}

define i13 @test_signed_i13_f64(double %f) nounwind {
; CHECK-LABEL: test_signed_i13_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-4562146422526312448
; CHECK-NEXT:    mov x9, #279275953455104
; CHECK-NEXT:    movk x9, #16559, lsl #48
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fmaxnm d1, d0, d1
; CHECK-NEXT:    fmov d2, x9
; CHECK-NEXT:    fminnm d1, d1, d2
; CHECK-NEXT:    fcvtzs w8, d1
; CHECK-NEXT:    fcmp d0, d0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i13 @llvm.fptosi.sat.i13.f64(double %f)
    ret i13 %x
}

define i16 @test_signed_i16_f64(double %f) nounwind {
; CHECK-LABEL: test_signed_i16_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-4548635623644200960
; CHECK-NEXT:    mov x9, #281200098803712
; CHECK-NEXT:    movk x9, #16607, lsl #48
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fmaxnm d1, d0, d1
; CHECK-NEXT:    fmov d2, x9
; CHECK-NEXT:    fminnm d1, d1, d2
; CHECK-NEXT:    fcvtzs w8, d1
; CHECK-NEXT:    fcmp d0, d0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i16 @llvm.fptosi.sat.i16.f64(double %f)
    ret i16 %x
}

define i19 @test_signed_i19_f64(double %f) nounwind {
; CHECK-LABEL: test_signed_i19_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-4535124824762089472
; CHECK-NEXT:    mov x9, #281440616972288
; CHECK-NEXT:    movk x9, #16655, lsl #48
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fmaxnm d1, d0, d1
; CHECK-NEXT:    fmov d2, x9
; CHECK-NEXT:    fminnm d1, d1, d2
; CHECK-NEXT:    fcvtzs w8, d1
; CHECK-NEXT:    fcmp d0, d0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i19 @llvm.fptosi.sat.i19.f64(double %f)
    ret i19 %x
}

define i32 @test_signed_i32_f64(double %f) nounwind {
; CHECK-LABEL: test_signed_i32_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-4476578029606273024
; CHECK-NEXT:    mov x9, #281474972516352
; CHECK-NEXT:    movk x9, #16863, lsl #48
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fmaxnm d1, d0, d1
; CHECK-NEXT:    fmov d2, x9
; CHECK-NEXT:    fminnm d1, d1, d2
; CHECK-NEXT:    fcvtzs w8, d1
; CHECK-NEXT:    fcmp d0, d0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i32 @llvm.fptosi.sat.i32.f64(double %f)
    ret i32 %x
}

define i50 @test_signed_i50_f64(double %f) nounwind {
; CHECK-LABEL: test_signed_i50_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-4395513236313604096
; CHECK-NEXT:    mov x9, #-16
; CHECK-NEXT:    movk x9, #17151, lsl #48
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fmaxnm d1, d0, d1
; CHECK-NEXT:    fmov d2, x9
; CHECK-NEXT:    fminnm d1, d1, d2
; CHECK-NEXT:    fcvtzs x8, d1
; CHECK-NEXT:    fcmp d0, d0
; CHECK-NEXT:    csel x0, xzr, x8, vs
; CHECK-NEXT:    ret
    %x = call i50 @llvm.fptosi.sat.i50.f64(double %f)
    ret i50 %x
}

define i64 @test_signed_i64_f64(double %f) nounwind {
; CHECK-LABEL: test_signed_i64_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x9, #-4332462841530417152
; CHECK-NEXT:    mov x11, #4890909195324358655
; CHECK-NEXT:    fmov d1, x9
; CHECK-NEXT:    fcvtzs x8, d0
; CHECK-NEXT:    mov x10, #-9223372036854775808
; CHECK-NEXT:    fcmp d0, d1
; CHECK-NEXT:    fmov d1, x11
; CHECK-NEXT:    mov x12, #9223372036854775807
; CHECK-NEXT:    csel x8, x10, x8, lt
; CHECK-NEXT:    fcmp d0, d1
; CHECK-NEXT:    csel x8, x12, x8, gt
; CHECK-NEXT:    fcmp d0, d0
; CHECK-NEXT:    csel x0, xzr, x8, vs
; CHECK-NEXT:    ret
    %x = call i64 @llvm.fptosi.sat.i64.f64(double %f)
    ret i64 %x
}

define i100 @test_signed_i100_f64(double %f) nounwind {
; CHECK-LABEL: test_signed_i100_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    mov v8.16b, v0.16b
; CHECK-NEXT:    bl __fixdfti
; CHECK-NEXT:    mov x8, #-4170333254945079296
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    mov x8, #5053038781909696511
; CHECK-NEXT:    fcmp d8, d0
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    mov x8, #-34359738368
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    csel x8, x8, x1, lt
; CHECK-NEXT:    mov x9, #34359738367
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    fcmp d8, d0
; CHECK-NEXT:    csel x8, x9, x8, gt
; CHECK-NEXT:    csinv x9, x10, xzr, le
; CHECK-NEXT:    fcmp d8, d8
; CHECK-NEXT:    csel x0, xzr, x9, vs
; CHECK-NEXT:    csel x1, xzr, x8, vs
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i100 @llvm.fptosi.sat.i100.f64(double %f)
    ret i100 %x
}

define i128 @test_signed_i128_f64(double %f) nounwind {
; CHECK-LABEL: test_signed_i128_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    mov v8.16b, v0.16b
; CHECK-NEXT:    bl __fixdfti
; CHECK-NEXT:    mov x8, #-4044232465378705408
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    mov x8, #5179139571476070399
; CHECK-NEXT:    fcmp d8, d0
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    mov x8, #-9223372036854775808
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    csel x8, x8, x1, lt
; CHECK-NEXT:    mov x9, #9223372036854775807
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    fcmp d8, d0
; CHECK-NEXT:    csel x8, x9, x8, gt
; CHECK-NEXT:    csinv x9, x10, xzr, le
; CHECK-NEXT:    fcmp d8, d8
; CHECK-NEXT:    csel x0, xzr, x9, vs
; CHECK-NEXT:    csel x1, xzr, x8, vs
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i128 @llvm.fptosi.sat.i128.f64(double %f)
    ret i128 %x
}

;
; 16-bit float to signed integer
;

declare   i1 @llvm.fptosi.sat.i1.f16  (half)
declare   i8 @llvm.fptosi.sat.i8.f16  (half)
declare  i13 @llvm.fptosi.sat.i13.f16 (half)
declare  i16 @llvm.fptosi.sat.i16.f16 (half)
declare  i19 @llvm.fptosi.sat.i19.f16 (half)
declare  i32 @llvm.fptosi.sat.i32.f16 (half)
declare  i50 @llvm.fptosi.sat.i50.f16 (half)
declare  i64 @llvm.fptosi.sat.i64.f16 (half)
declare i100 @llvm.fptosi.sat.i100.f16(half)
declare i128 @llvm.fptosi.sat.i128.f16(half)

define i1 @test_signed_i1_f16(half %f) nounwind {
; CHECK-LABEL: test_signed_i1_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    fmov s1, #-1.00000000
; CHECK-NEXT:    movi d2, #0000000000000000
; CHECK-NEXT:    fmaxnm s1, s0, s1
; CHECK-NEXT:    fminnm s1, s1, s2
; CHECK-NEXT:    fcvtzs w8, s1
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w8, wzr, w8, vs
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
    %x = call i1 @llvm.fptosi.sat.i1.f16(half %f)
    ret i1 %x
}

define i8 @test_signed_i8_f16(half %f) nounwind {
; CHECK-LABEL: test_signed_i8_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-1023410176
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    mov w9, #1123942400
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fmaxnm s1, s0, s1
; CHECK-NEXT:    fmov s2, w9
; CHECK-NEXT:    fminnm s1, s1, s2
; CHECK-NEXT:    fcvtzs w8, s1
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i8 @llvm.fptosi.sat.i8.f16(half %f)
    ret i8 %x
}

define i13 @test_signed_i13_f16(half %f) nounwind {
; CHECK-LABEL: test_signed_i13_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-981467136
; CHECK-NEXT:    mov w9, #61440
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    movk w9, #17791, lsl #16
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fmaxnm s1, s0, s1
; CHECK-NEXT:    fmov s2, w9
; CHECK-NEXT:    fminnm s1, s1, s2
; CHECK-NEXT:    fcvtzs w8, s1
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i13 @llvm.fptosi.sat.i13.f16(half %f)
    ret i13 %x
}

define i16 @test_signed_i16_f16(half %f) nounwind {
; CHECK-LABEL: test_signed_i16_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-956301312
; CHECK-NEXT:    mov w9, #65024
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    movk w9, #18175, lsl #16
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fmaxnm s1, s0, s1
; CHECK-NEXT:    fmov s2, w9
; CHECK-NEXT:    fminnm s1, s1, s2
; CHECK-NEXT:    fcvtzs w8, s1
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i16 @llvm.fptosi.sat.i16.f16(half %f)
    ret i16 %x
}

define i19 @test_signed_i19_f16(half %f) nounwind {
; CHECK-LABEL: test_signed_i19_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-931135488
; CHECK-NEXT:    mov w9, #65472
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    movk w9, #18559, lsl #16
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fmaxnm s1, s0, s1
; CHECK-NEXT:    fmov s2, w9
; CHECK-NEXT:    fminnm s1, s1, s2
; CHECK-NEXT:    fcvtzs w8, s1
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i19 @llvm.fptosi.sat.i19.f16(half %f)
    ret i19 %x
}

define i32 @test_signed_i32_f16(half %f) nounwind {
; CHECK-LABEL: test_signed_i32_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-822083584
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    mov w8, #1325400063
; CHECK-NEXT:    mov w9, #-2147483648
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fcvtzs w8, s0
; CHECK-NEXT:    csel w8, w9, w8, lt
; CHECK-NEXT:    mov w9, #2147483647
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    csel w8, w9, w8, gt
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel w0, wzr, w8, vs
; CHECK-NEXT:    ret
    %x = call i32 @llvm.fptosi.sat.i32.f16(half %f)
    ret i32 %x
}

define i50 @test_signed_i50_f16(half %f) nounwind {
; CHECK-LABEL: test_signed_i50_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-671088640
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    mov w8, #1476395007
; CHECK-NEXT:    mov x9, #-562949953421312
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fcvtzs x8, s0
; CHECK-NEXT:    csel x8, x9, x8, lt
; CHECK-NEXT:    mov x9, #562949953421311
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    csel x8, x9, x8, gt
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel x0, xzr, x8, vs
; CHECK-NEXT:    ret
    %x = call i50 @llvm.fptosi.sat.i50.f16(half %f)
    ret i50 %x
}

define i64 @test_signed_i64_f16(half %f) nounwind {
; CHECK-LABEL: test_signed_i64_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-553648128
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    mov w8, #1593835519
; CHECK-NEXT:    mov x9, #-9223372036854775808
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fcvtzs x8, s0
; CHECK-NEXT:    csel x8, x9, x8, lt
; CHECK-NEXT:    mov x9, #9223372036854775807
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    csel x8, x9, x8, gt
; CHECK-NEXT:    fcmp s0, s0
; CHECK-NEXT:    csel x0, xzr, x8, vs
; CHECK-NEXT:    ret
    %x = call i64 @llvm.fptosi.sat.i64.f16(half %f)
    ret i64 %x
}

define i100 @test_signed_i100_f16(half %f) nounwind {
; CHECK-LABEL: test_signed_i100_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    fcvt s8, h0
; CHECK-NEXT:    mov v0.16b, v8.16b
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    bl __fixsfti
; CHECK-NEXT:    mov w8, #-251658240
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov w8, #1895825407
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov x8, #-34359738368
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    csel x8, x8, x1, lt
; CHECK-NEXT:    mov x9, #34359738367
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    csel x8, x9, x8, gt
; CHECK-NEXT:    csinv x9, x10, xzr, le
; CHECK-NEXT:    fcmp s8, s8
; CHECK-NEXT:    csel x0, xzr, x9, vs
; CHECK-NEXT:    csel x1, xzr, x8, vs
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i100 @llvm.fptosi.sat.i100.f16(half %f)
    ret i100 %x
}

define i128 @test_signed_i128_f16(half %f) nounwind {
; CHECK-LABEL: test_signed_i128_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    fcvt s8, h0
; CHECK-NEXT:    mov v0.16b, v8.16b
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    bl __fixsfti
; CHECK-NEXT:    mov w8, #-16777216
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov w8, #2130706431
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov x8, #-9223372036854775808
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    csel x8, x8, x1, lt
; CHECK-NEXT:    mov x9, #9223372036854775807
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    csel x8, x9, x8, gt
; CHECK-NEXT:    csinv x9, x10, xzr, le
; CHECK-NEXT:    fcmp s8, s8
; CHECK-NEXT:    csel x0, xzr, x9, vs
; CHECK-NEXT:    csel x1, xzr, x8, vs
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i128 @llvm.fptosi.sat.i128.f16(half %f)
    ret i128 %x
}
