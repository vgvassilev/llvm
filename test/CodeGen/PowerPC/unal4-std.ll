; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs < %s -mcpu=pwr7 -mattr=-vsx| FileCheck %s
; RUN: llc -verify-machineinstrs < %s -mcpu=pwr7 -mattr=+vsx | FileCheck -check-prefix=CHECK-VSX %s
target datalayout = "E-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-f128:128:128-v128:128:128-n32:64"
target triple = "powerpc64-unknown-linux-gnu"

define void @copy_to_conceal(<8 x i16>* %inp) #0 {
; CHECK-LABEL: copy_to_conceal:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vxor 2, 2, 2
; CHECK-NEXT:    addi 4, 1, -16
; CHECK-NEXT:    stvx 2, 0, 4
; CHECK-NEXT:    ld 4, -8(1)
; CHECK-NEXT:    std 4, 8(3)
; CHECK-NEXT:    ld 4, -16(1)
; CHECK-NEXT:    std 4, 0(3)
; CHECK-NEXT:    blr
;
; CHECK-VSX-LABEL: copy_to_conceal:
; CHECK-VSX:       # %bb.0: # %entry
; CHECK-VSX-NEXT:    xxlxor 0, 0, 0
; CHECK-VSX-NEXT:    stxvw4x 0, 0, 3
; CHECK-VSX-NEXT:    blr
entry:
  store <8 x i16> zeroinitializer, <8 x i16>* %inp, align 2
  br label %if.end210

if.end210:                                        ; preds = %entry
  ret void

; This will generate two align-1 i64 stores. Make sure that they are
; indexed stores and not in r+i form (which require the offset to be
; a multiple of 4).

}

attributes #0 = { nounwind "frame-pointer"="non-leaf" "use-soft-float"="false" }
