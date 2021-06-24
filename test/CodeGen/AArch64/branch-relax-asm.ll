; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-apple-ios7.0 -disable-block-placement -aarch64-tbz-offset-bits=4 -o - %s | FileCheck %s
define i32 @test_asm_length(i32 %in) {
  ; It would be more natural to use just one "tbnz %false" here, but if the
  ; number of instructions in the asm is counted reasonably, that block is out
  ; of the limited range we gave tbz. So branch relaxation has to invert the
  ; condition.
; CHECK-LABEL: test_asm_length:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    tbz w0, #0, LBB0_2
; CHECK-NEXT:  ; %bb.1:
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    ret
; CHECK-NEXT:  LBB0_2: ; %true
; CHECK-NEXT:    mov w0, #4
; CHECK-NEXT:    ; InlineAsm Start
; CHECK-NEXT:    nop
; CHECK-NEXT:    nop
; CHECK-NEXT:    nop
; CHECK-NEXT:    nop
; CHECK-NEXT:    nop
; CHECK-NEXT:    nop
; CHECK-NEXT:    ; InlineAsm End
; CHECK-NEXT:    ret
  %val = and i32 %in, 1
  %tst = icmp eq i32 %val, 0
  br i1 %tst, label %true, label %false

true:
  call void asm sideeffect "nop\0A\09nop\0A\09nop\0A\09nop\0A\09nop\0A\09nop", ""()
  ret i32 4

false:
  ret i32 0
}
