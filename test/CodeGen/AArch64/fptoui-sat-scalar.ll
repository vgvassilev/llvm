; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 < %s | FileCheck %s

;
; 32-bit float to unsigned integer
;

declare   i1 @llvm.fptoui.sat.i1.f32  (float)
declare   i8 @llvm.fptoui.sat.i8.f32  (float)
declare  i13 @llvm.fptoui.sat.i13.f32 (float)
declare  i16 @llvm.fptoui.sat.i16.f32 (float)
declare  i19 @llvm.fptoui.sat.i19.f32 (float)
declare  i32 @llvm.fptoui.sat.i32.f32 (float)
declare  i50 @llvm.fptoui.sat.i50.f32 (float)
declare  i64 @llvm.fptoui.sat.i64.f32 (float)
declare i100 @llvm.fptoui.sat.i100.f32(float)
declare i128 @llvm.fptoui.sat.i128.f32(float)

define i1 @test_unsigned_i1_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i1_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    fmaxnm s0, s0, s1
; CHECK-NEXT:    fmov s1, #1.00000000
; CHECK-NEXT:    fminnm s0, s0, s1
; CHECK-NEXT:    fcvtzu w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
    %x = call i1 @llvm.fptoui.sat.i1.f32(float %f)
    ret i1 %x
}

define i8 @test_unsigned_i8_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i8_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    mov w8, #1132396544
; CHECK-NEXT:    fmaxnm s0, s0, s1
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fminnm s0, s0, s1
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
    %x = call i8 @llvm.fptoui.sat.i8.f32(float %f)
    ret i8 %x
}

define i13 @test_unsigned_i13_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i13_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #63488
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk w8, #17919, lsl #16
; CHECK-NEXT:    fmaxnm s0, s0, s1
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fminnm s0, s0, s1
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
    %x = call i13 @llvm.fptoui.sat.i13.f32(float %f)
    ret i13 %x
}

define i16 @test_unsigned_i16_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i16_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #65280
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk w8, #18303, lsl #16
; CHECK-NEXT:    fmaxnm s0, s0, s1
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fminnm s0, s0, s1
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
    %x = call i16 @llvm.fptoui.sat.i16.f32(float %f)
    ret i16 %x
}

define i19 @test_unsigned_i19_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i19_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #65504
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk w8, #18687, lsl #16
; CHECK-NEXT:    fmaxnm s0, s0, s1
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fminnm s0, s0, s1
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
    %x = call i19 @llvm.fptoui.sat.i19.f32(float %f)
    ret i19 %x
}

define i32 @test_unsigned_i32_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i32_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w9, #1333788671
; CHECK-NEXT:    fcvtzu w8, s0
; CHECK-NEXT:    fcmp s0, #0.0
; CHECK-NEXT:    fmov s1, w9
; CHECK-NEXT:    csel w8, wzr, w8, lt
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    csinv w0, w8, wzr, le
; CHECK-NEXT:    ret
    %x = call i32 @llvm.fptoui.sat.i32.f32(float %f)
    ret i32 %x
}

define i50 @test_unsigned_i50_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i50_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w9, #1484783615
; CHECK-NEXT:    fcvtzu x8, s0
; CHECK-NEXT:    fcmp s0, #0.0
; CHECK-NEXT:    fmov s1, w9
; CHECK-NEXT:    csel x8, xzr, x8, lt
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    mov x9, #1125899906842623
; CHECK-NEXT:    csel x0, x9, x8, gt
; CHECK-NEXT:    ret
    %x = call i50 @llvm.fptoui.sat.i50.f32(float %f)
    ret i50 %x
}

define i64 @test_unsigned_i64_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i64_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w9, #1602224127
; CHECK-NEXT:    fcvtzu x8, s0
; CHECK-NEXT:    fcmp s0, #0.0
; CHECK-NEXT:    fmov s1, w9
; CHECK-NEXT:    csel x8, xzr, x8, lt
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    csinv x0, x8, xzr, le
; CHECK-NEXT:    ret
    %x = call i64 @llvm.fptoui.sat.i64.f32(float %f)
    ret i64 %x
}

define i100 @test_unsigned_i100_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i100_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    mov v8.16b, v0.16b
; CHECK-NEXT:    bl __fixunssfti
; CHECK-NEXT:    mov w8, #1904214015
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    fcmp s8, #0.0
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov x9, #68719476735
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    csel x11, xzr, x1, lt
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    csel x1, x9, x11, gt
; CHECK-NEXT:    csinv x0, x10, xzr, le
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i100 @llvm.fptoui.sat.i100.f32(float %f)
    ret i100 %x
}

define i128 @test_unsigned_i128_f32(float %f) nounwind {
; CHECK-LABEL: test_unsigned_i128_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    mov v8.16b, v0.16b
; CHECK-NEXT:    bl __fixunssfti
; CHECK-NEXT:    mov w8, #2139095039
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    fcmp s8, #0.0
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    csel x9, xzr, x1, lt
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    csinv x0, x10, xzr, le
; CHECK-NEXT:    csinv x1, x9, xzr, le
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i128 @llvm.fptoui.sat.i128.f32(float %f)
    ret i128 %x
}

;
; 64-bit float to unsigned integer
;

declare   i1 @llvm.fptoui.sat.i1.f64  (double)
declare   i8 @llvm.fptoui.sat.i8.f64  (double)
declare  i13 @llvm.fptoui.sat.i13.f64 (double)
declare  i16 @llvm.fptoui.sat.i16.f64 (double)
declare  i19 @llvm.fptoui.sat.i19.f64 (double)
declare  i32 @llvm.fptoui.sat.i32.f64 (double)
declare  i50 @llvm.fptoui.sat.i50.f64 (double)
declare  i64 @llvm.fptoui.sat.i64.f64 (double)
declare i100 @llvm.fptoui.sat.i100.f64(double)
declare i128 @llvm.fptoui.sat.i128.f64(double)

define i1 @test_unsigned_i1_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i1_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    fmaxnm d0, d0, d1
; CHECK-NEXT:    fmov d1, #1.00000000
; CHECK-NEXT:    fminnm d0, d0, d1
; CHECK-NEXT:    fcvtzu w8, d0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
    %x = call i1 @llvm.fptoui.sat.i1.f64(double %f)
    ret i1 %x
}

define i8 @test_unsigned_i8_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i8_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #246290604621824
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk x8, #16495, lsl #48
; CHECK-NEXT:    fmaxnm d0, d0, d1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fminnm d0, d0, d1
; CHECK-NEXT:    fcvtzu w0, d0
; CHECK-NEXT:    ret
    %x = call i8 @llvm.fptoui.sat.i8.f64(double %f)
    ret i8 %x
}

define i13 @test_unsigned_i13_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i13_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #280375465082880
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk x8, #16575, lsl #48
; CHECK-NEXT:    fmaxnm d0, d0, d1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fminnm d0, d0, d1
; CHECK-NEXT:    fcvtzu w0, d0
; CHECK-NEXT:    ret
    %x = call i13 @llvm.fptoui.sat.i13.f64(double %f)
    ret i13 %x
}

define i16 @test_unsigned_i16_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i16_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #281337537757184
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk x8, #16623, lsl #48
; CHECK-NEXT:    fmaxnm d0, d0, d1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fminnm d0, d0, d1
; CHECK-NEXT:    fcvtzu w0, d0
; CHECK-NEXT:    ret
    %x = call i16 @llvm.fptoui.sat.i16.f64(double %f)
    ret i16 %x
}

define i19 @test_unsigned_i19_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i19_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #281457796841472
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk x8, #16671, lsl #48
; CHECK-NEXT:    fmaxnm d0, d0, d1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fminnm d0, d0, d1
; CHECK-NEXT:    fcvtzu w0, d0
; CHECK-NEXT:    ret
    %x = call i19 @llvm.fptoui.sat.i19.f64(double %f)
    ret i19 %x
}

define i32 @test_unsigned_i32_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i32_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #281474974613504
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk x8, #16879, lsl #48
; CHECK-NEXT:    fmaxnm d0, d0, d1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fminnm d0, d0, d1
; CHECK-NEXT:    fcvtzu w0, d0
; CHECK-NEXT:    ret
    %x = call i32 @llvm.fptoui.sat.i32.f64(double %f)
    ret i32 %x
}

define i50 @test_unsigned_i50_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i50_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #-8
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk x8, #17167, lsl #48
; CHECK-NEXT:    fmaxnm d0, d0, d1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fminnm d0, d0, d1
; CHECK-NEXT:    fcvtzu x0, d0
; CHECK-NEXT:    ret
    %x = call i50 @llvm.fptoui.sat.i50.f64(double %f)
    ret i50 %x
}

define i64 @test_unsigned_i64_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i64_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x9, #4895412794951729151
; CHECK-NEXT:    fcvtzu x8, d0
; CHECK-NEXT:    fcmp d0, #0.0
; CHECK-NEXT:    fmov d1, x9
; CHECK-NEXT:    csel x8, xzr, x8, lt
; CHECK-NEXT:    fcmp d0, d1
; CHECK-NEXT:    csinv x0, x8, xzr, le
; CHECK-NEXT:    ret
    %x = call i64 @llvm.fptoui.sat.i64.f64(double %f)
    ret i64 %x
}

define i100 @test_unsigned_i100_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i100_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    mov v8.16b, v0.16b
; CHECK-NEXT:    bl __fixunsdfti
; CHECK-NEXT:    mov x8, #5057542381537067007
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    fcmp d8, #0.0
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    mov x9, #68719476735
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    csel x11, xzr, x1, lt
; CHECK-NEXT:    fcmp d8, d0
; CHECK-NEXT:    csel x1, x9, x11, gt
; CHECK-NEXT:    csinv x0, x10, xzr, le
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i100 @llvm.fptoui.sat.i100.f64(double %f)
    ret i100 %x
}

define i128 @test_unsigned_i128_f64(double %f) nounwind {
; CHECK-LABEL: test_unsigned_i128_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    mov v8.16b, v0.16b
; CHECK-NEXT:    bl __fixunsdfti
; CHECK-NEXT:    mov x8, #5183643171103440895
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    fcmp d8, #0.0
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    csel x9, xzr, x1, lt
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    fcmp d8, d0
; CHECK-NEXT:    csinv x0, x10, xzr, le
; CHECK-NEXT:    csinv x1, x9, xzr, le
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i128 @llvm.fptoui.sat.i128.f64(double %f)
    ret i128 %x
}

;
; 16-bit float to unsigned integer
;

declare   i1 @llvm.fptoui.sat.i1.f16  (half)
declare   i8 @llvm.fptoui.sat.i8.f16  (half)
declare  i13 @llvm.fptoui.sat.i13.f16 (half)
declare  i16 @llvm.fptoui.sat.i16.f16 (half)
declare  i19 @llvm.fptoui.sat.i19.f16 (half)
declare  i32 @llvm.fptoui.sat.i32.f16 (half)
declare  i50 @llvm.fptoui.sat.i50.f16 (half)
declare  i64 @llvm.fptoui.sat.i64.f16 (half)
declare i100 @llvm.fptoui.sat.i100.f16(half)
declare i128 @llvm.fptoui.sat.i128.f16(half)

define i1 @test_unsigned_i1_f16(half %f) nounwind {
; CHECK-LABEL: test_unsigned_i1_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    fmaxnm s0, s0, s1
; CHECK-NEXT:    fmov s1, #1.00000000
; CHECK-NEXT:    fminnm s0, s0, s1
; CHECK-NEXT:    fcvtzu w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
    %x = call i1 @llvm.fptoui.sat.i1.f16(half %f)
    ret i1 %x
}

define i8 @test_unsigned_i8_f16(half %f) nounwind {
; CHECK-LABEL: test_unsigned_i8_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    mov w8, #1132396544
; CHECK-NEXT:    fmaxnm s0, s0, s1
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fminnm s0, s0, s1
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
    %x = call i8 @llvm.fptoui.sat.i8.f16(half %f)
    ret i8 %x
}

define i13 @test_unsigned_i13_f16(half %f) nounwind {
; CHECK-LABEL: test_unsigned_i13_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #63488
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk w8, #17919, lsl #16
; CHECK-NEXT:    fmaxnm s0, s0, s1
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fminnm s0, s0, s1
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
    %x = call i13 @llvm.fptoui.sat.i13.f16(half %f)
    ret i13 %x
}

define i16 @test_unsigned_i16_f16(half %f) nounwind {
; CHECK-LABEL: test_unsigned_i16_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #65280
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk w8, #18303, lsl #16
; CHECK-NEXT:    fmaxnm s0, s0, s1
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fminnm s0, s0, s1
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
    %x = call i16 @llvm.fptoui.sat.i16.f16(half %f)
    ret i16 %x
}

define i19 @test_unsigned_i19_f16(half %f) nounwind {
; CHECK-LABEL: test_unsigned_i19_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #65504
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    movi d1, #0000000000000000
; CHECK-NEXT:    movk w8, #18687, lsl #16
; CHECK-NEXT:    fmaxnm s0, s0, s1
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fminnm s0, s0, s1
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
    %x = call i19 @llvm.fptoui.sat.i19.f16(half %f)
    ret i19 %x
}

define i32 @test_unsigned_i32_f16(half %f) nounwind {
; CHECK-LABEL: test_unsigned_i32_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    mov w8, #1333788671
; CHECK-NEXT:    fcvtzu w9, s0
; CHECK-NEXT:    fcmp s0, #0.0
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    csel w8, wzr, w9, lt
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    csinv w0, w8, wzr, le
; CHECK-NEXT:    ret
    %x = call i32 @llvm.fptoui.sat.i32.f16(half %f)
    ret i32 %x
}

define i50 @test_unsigned_i50_f16(half %f) nounwind {
; CHECK-LABEL: test_unsigned_i50_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    mov w8, #1484783615
; CHECK-NEXT:    fcvtzu x9, s0
; CHECK-NEXT:    fcmp s0, #0.0
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    csel x8, xzr, x9, lt
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    mov x9, #1125899906842623
; CHECK-NEXT:    csel x0, x9, x8, gt
; CHECK-NEXT:    ret
    %x = call i50 @llvm.fptoui.sat.i50.f16(half %f)
    ret i50 %x
}

define i64 @test_unsigned_i64_f16(half %f) nounwind {
; CHECK-LABEL: test_unsigned_i64_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    mov w8, #1602224127
; CHECK-NEXT:    fcvtzu x9, s0
; CHECK-NEXT:    fcmp s0, #0.0
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    csel x8, xzr, x9, lt
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    csinv x0, x8, xzr, le
; CHECK-NEXT:    ret
    %x = call i64 @llvm.fptoui.sat.i64.f16(half %f)
    ret i64 %x
}

define i100 @test_unsigned_i100_f16(half %f) nounwind {
; CHECK-LABEL: test_unsigned_i100_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    fcvt s8, h0
; CHECK-NEXT:    mov v0.16b, v8.16b
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    bl __fixunssfti
; CHECK-NEXT:    mov w8, #1904214015
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    fcmp s8, #0.0
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    mov x9, #68719476735
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    csel x11, xzr, x1, lt
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    csel x1, x9, x11, gt
; CHECK-NEXT:    csinv x0, x10, xzr, le
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i100 @llvm.fptoui.sat.i100.f16(half %f)
    ret i100 %x
}

define i128 @test_unsigned_i128_f16(half %f) nounwind {
; CHECK-LABEL: test_unsigned_i128_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str d8, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    fcvt s8, h0
; CHECK-NEXT:    mov v0.16b, v8.16b
; CHECK-NEXT:    str x30, [sp, #8] // 8-byte Folded Spill
; CHECK-NEXT:    bl __fixunssfti
; CHECK-NEXT:    mov w8, #2139095039
; CHECK-NEXT:    ldr x30, [sp, #8] // 8-byte Folded Reload
; CHECK-NEXT:    fcmp s8, #0.0
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    csel x9, xzr, x1, lt
; CHECK-NEXT:    csel x10, xzr, x0, lt
; CHECK-NEXT:    fcmp s8, s0
; CHECK-NEXT:    csinv x0, x10, xzr, le
; CHECK-NEXT:    csinv x1, x9, xzr, le
; CHECK-NEXT:    ldr d8, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
    %x = call i128 @llvm.fptoui.sat.i128.f16(half %f)
    ret i128 %x
}
