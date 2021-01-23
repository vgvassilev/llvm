; RUN: llc < %s -march=avr | FileCheck %s

; Optimize for speed.
; CHECK-LABEL: shift_i8_i8_speed
define i8 @shift_i8_i8_speed(i8 %a, i8 %b) {
  ; CHECK:        dec r22
  ; CHECK-NEXT:   brmi .LBB0_2
  ; CHECK-NEXT: .LBB0_1:
  ; CHECK-NEXT:   lsl r24
  ; CHECK-NEXT:   dec r22
  ; CHECK-NEXT:   brpl .LBB0_1
  ; CHECK-NEXT: .LBB0_2:
  ; CHECK-NEXT:   ret
  %result = shl i8 %a, %b
  ret i8 %result
}

; Optimize for size (producing slightly smaller code).
; CHECK-LABEL: shift_i8_i8_size
define i8 @shift_i8_i8_size(i8 %a, i8 %b) optsize {
  ; CHECK:      .LBB1_1:
  ; CHECK-NEXT:   dec r22
  ; CHECK-NEXT:   brmi .LBB1_3
  ; CHECK:        lsl r24
  ; CHECK-NEXT:   rjmp .LBB1_1
  ; CHECK-NEXT: .LBB1_3:
  ; CHECK-NEXT:   ret
  %result = shl i8 %a, %b
  ret i8 %result
}

; CHECK-LABEL: shift_i16_i16
define i16 @shift_i16_i16(i16 %a, i16 %b) {
  ; CHECK:        dec r22
  ; CHECK-NEXT:   brmi .LBB2_2
  ; CHECK-NEXT: .LBB2_1:
  ; CHECK-NEXT:   lsl r24
  ; CHECK-NEXT:   rol r25
  ; CHECK-NEXT:   dec r22
  ; CHECK-NEXT:   brpl .LBB2_1
  ; CHECK-NEXT: .LBB2_2:
  ; CHECK-NEXT:   ret
  %result = shl i16 %a, %b
  ret i16 %result
}

; CHECK-LABEL: shift_i64_i64
define i64 @shift_i64_i64(i64 %a, i64 %b) {
  ; CHECK: call    __ashldi3
  %result = shl i64 %a, %b
  ret i64 %result
}

define i8 @lsl_i8_1(i8 %a) {
; CHECK-LABEL: lsl_i8_1:
; CHECK:       lsl r24
  %res = shl i8 %a, 1
  ret i8 %res
}

define i8 @lsl_i8_2(i8 %a) {
; CHECK-LABEL: lsl_i8_2:
; CHECK:       lsl r24
; CHECK-NEXT:  lsl r24
  %res = shl i8 %a, 2
  ret i8 %res
}

define i8 @lsl_i8_3(i8 %a) {
; CHECK-LABEL: lsl_i8_3:
; CHECK:       lsl r24
; CHECK-NEXT:  lsl r24
; CHECK-NEXT:  lsl r24
  %res = shl i8 %a, 3
  ret i8 %res
}

define i8 @lsl_i8_4(i8 %a) {
; CHECK-LABEL: lsl_i8_4:
; CHECK:       swap r24
; CHECK-NEXT:  andi r24, -16
  %res = shl i8 %a, 4
  ret i8 %res
}

define i8 @lsl_i8_5(i8 %a) {
; CHECK-LABEL: lsl_i8_5:
; CHECK:       swap r24
; CHECK-NEXT:  andi r24, -16
; CHECK-NEXT:  lsl r24
  %res = shl i8 %a, 5
  ret i8 %res
}

define i8 @lsl_i8_6(i8 %a) {
; CHECK-LABEL: lsl_i8_6:
; CHECK:       swap r24
; CHECK-NEXT:  andi r24, -16
; CHECK-NEXT:  lsl r24
; CHECK-NEXT:  lsl r24
  %res = shl i8 %a, 6
  ret i8 %res
}

define i8 @lsr_i8_1(i8 %a) {
; CHECK-LABEL: lsr_i8_1:
; CHECK:       lsr r24
  %res = lshr i8 %a, 1
  ret i8 %res
}

define i8 @lsr_i8_2(i8 %a) {
; CHECK-LABEL: lsr_i8_2:
; CHECK:       lsr r24
; CHECK-NEXT:  lsr r24
  %res = lshr i8 %a, 2
  ret i8 %res
}

define i8 @lsr_i8_3(i8 %a) {
; CHECK-LABEL: lsr_i8_3:
; CHECK:       lsr r24
; CHECK-NEXT:  lsr r24
; CHECK-NEXT:  lsr r24
  %res = lshr i8 %a, 3
  ret i8 %res
}

define i8 @lsr_i8_4(i8 %a) {
; CHECK-LABEL: lsr_i8_4:
; CHECK:       swap r24
; CHECK-NEXT:  andi r24, 15
  %res = lshr i8 %a, 4
  ret i8 %res
}

define i8 @lsr_i8_5(i8 %a) {
; CHECK-LABEL: lsr_i8_5:
; CHECK:       swap r24
; CHECK-NEXT:  andi r24, 15
; CHECK-NEXT:  lsr r24
  %res = lshr i8 %a, 5
  ret i8 %res
}

define i8 @lsr_i8_6(i8 %a) {
; CHECK-LABEL: lsr_i8_6:
; CHECK:       swap r24
; CHECK-NEXT:  andi r24, 15
; CHECK-NEXT:  lsr r24
; CHECK-NEXT:  lsr r24
  %res = lshr i8 %a, 6
  ret i8 %res
}
