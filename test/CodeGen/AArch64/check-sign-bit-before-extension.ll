; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-gnu-linux -o - | FileCheck %s

; These tests make sure that the `cmp` instruction is rendered with an
; instruction that checks the sign bit of the original unextended data
; (%in) instead of the sign bit of the sign extended one that is
; created by the type legalization process.
;
; The tests are subdivided in tests that determine the sign bit
; looking through a `sign_extend_inreg` and tests that determine the
; sign bit looking through a `sign_extend`.

define i32 @f_i8_sign_extend_inreg(i8 %in, i32 %a, i32 %b) nounwind {
; CHECK-LABEL: f_i8_sign_extend_inreg:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    tbnz w0, #7, .LBB0_2
; CHECK-NEXT:  // %bb.1: // %A
; CHECK-NEXT:    add w0, w8, w1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB0_2: // %B
; CHECK-NEXT:    add w0, w8, w2
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i8 %in, -1
  %ext = zext i8 %in to i32
  br i1 %cmp, label %A, label %B

A:
  %retA = add i32 %ext, %a
  ret i32 %retA

B:
  %retB = add i32 %ext, %b
  ret i32 %retB
}

define i32 @f_i16_sign_extend_inreg(i16 %in, i32 %a, i32 %b) nounwind {
; CHECK-LABEL: f_i16_sign_extend_inreg:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    tbnz w0, #15, .LBB1_2
; CHECK-NEXT:  // %bb.1: // %A
; CHECK-NEXT:    add w0, w8, w1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB1_2: // %B
; CHECK-NEXT:    add w0, w8, w2
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i16 %in, -1
  %ext = zext i16 %in to i32
  br i1 %cmp, label %A, label %B

A:
  %retA = add i32 %ext, %a
  ret i32 %retA

B:
  %retB = add i32 %ext, %b
  ret i32 %retB
}

define i64 @f_i32_sign_extend_inreg(i32 %in, i64 %a, i64 %b) nounwind {
; CHECK-LABEL: f_i32_sign_extend_inreg:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    tbnz w0, #31, .LBB2_2
; CHECK-NEXT:  // %bb.1: // %A
; CHECK-NEXT:    add x0, x8, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB2_2: // %B
; CHECK-NEXT:    add x0, x8, x2
; CHECK-NEXT:    ret
entry:
  %cmp = icmp sgt i32 %in, -1
  %ext = zext i32 %in to i64
  br i1 %cmp, label %A, label %B

A:
  %retA = add i64 %ext, %a
  ret i64 %retA

B:
  %retB = add i64 %ext, %b
  ret i64 %retB
}

define i32 @g_i8_sign_extend_inreg(i8 %in, i32 %a, i32 %b) nounwind {
; CHECK-LABEL: g_i8_sign_extend_inreg:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    tbnz w0, #7, .LBB3_2
; CHECK-NEXT:  // %bb.1: // %B
; CHECK-NEXT:    add w0, w8, w2
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB3_2: // %A
; CHECK-NEXT:    add w0, w8, w1
; CHECK-NEXT:    ret
entry:
  %cmp = icmp slt i8 %in, 0
  %ext = zext i8 %in to i32
  br i1 %cmp, label %A, label %B

A:
  %retA = add i32 %ext, %a
  ret i32 %retA

B:
  %retB = add i32 %ext, %b
  ret i32 %retB
}

define i32 @g_i16_sign_extend_inreg(i16 %in, i32 %a, i32 %b) nounwind {
; CHECK-LABEL: g_i16_sign_extend_inreg:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    and w8, w0, #0xffff
; CHECK-NEXT:    tbnz w0, #15, .LBB4_2
; CHECK-NEXT:  // %bb.1: // %B
; CHECK-NEXT:    add w0, w8, w2
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB4_2: // %A
; CHECK-NEXT:    add w0, w8, w1
; CHECK-NEXT:    ret
entry:
  %cmp = icmp slt i16 %in, 0
  %ext = zext i16 %in to i32
  br i1 %cmp, label %A, label %B

A:
  %retA = add i32 %ext, %a
  ret i32 %retA

B:
  %retB = add i32 %ext, %b
  ret i32 %retB
}

define i64 @g_i32_sign_extend_inreg(i32 %in, i64 %a, i64 %b) nounwind {
; CHECK-LABEL: g_i32_sign_extend_inreg:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    tbnz w0, #31, .LBB5_2
; CHECK-NEXT:  // %bb.1: // %B
; CHECK-NEXT:    add x0, x8, x2
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB5_2: // %A
; CHECK-NEXT:    add x0, x8, x1
; CHECK-NEXT:    ret
entry:
  %cmp = icmp slt i32 %in, 0
  %ext = zext i32 %in to i64
  br i1 %cmp, label %A, label %B

A:
  %retA = add i64 %ext, %a
  ret i64 %retA

B:
  %retB = add i64 %ext, %b
  ret i64 %retB
}

define i64 @f_i32_sign_extend_i64(i32 %in, i64 %a, i64 %b) nounwind {
; CHECK-LABEL: f_i32_sign_extend_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    tbnz w0, #31, .LBB6_2
; CHECK-NEXT:  // %bb.1: // %A
; CHECK-NEXT:    add x0, x8, x1
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB6_2: // %B
; CHECK-NEXT:    add x0, x8, x2
; CHECK-NEXT:    ret
entry:
  %inext = sext i32 %in to i64
  %cmp = icmp sgt i64 %inext, -1
  %ext = zext i32 %in to i64
  br i1 %cmp, label %A, label %B

A:
  %retA = add i64 %ext, %a
  ret i64 %retA

B:
  %retB = add i64 %ext, %b
  ret i64 %retB
}

define i64 @g_i32_sign_extend_i64(i32 %in, i64 %a, i64 %b) nounwind {
; CHECK-LABEL: g_i32_sign_extend_i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    tbnz w0, #31, .LBB7_2
; CHECK-NEXT:  // %bb.1: // %B
; CHECK-NEXT:    add x0, x8, x2
; CHECK-NEXT:    ret
; CHECK-NEXT:  .LBB7_2: // %A
; CHECK-NEXT:    add x0, x8, x1
; CHECK-NEXT:    ret
entry:
  %inext = sext i32 %in to i64
  %cmp = icmp slt i64 %inext, 0
  %ext = zext i32 %in to i64
  br i1 %cmp, label %A, label %B

A:
  %retA = add i64 %ext, %a
  ret i64 %retA

B:
  %retB = add i64 %ext, %b
  ret i64 %retB
}
