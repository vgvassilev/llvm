; RUN: opt < %s -reassociate -S | FileCheck %s

; Check that a*a*b+a*a*c is turned into a*(a*(b+c)).

define float @fmultistep1(float %a, float %b, float %c) {
; CHECK-LABEL: @fmultistep1(
; CHECK-NEXT:    [[REASS_ADD1:%.*]] = fadd fast float %c, %b
; CHECK-NEXT:    [[REASS_MUL2:%.*]] = fmul fast float %a, %a
; CHECK-NEXT:    [[REASS_MUL:%.*]] = fmul fast float [[REASS_MUL:%.*]]2, [[REASS_ADD1]]
; CHECK-NEXT:    ret float [[REASS_MUL]]
;
  %t0 = fmul fast float %a, %b
  %t1 = fmul fast float %a, %t0 ; a*(a*b)
  %t2 = fmul fast float %a, %c
  %t3 = fmul fast float %a, %t2 ; a*(a*c)
  %t4 = fadd fast float %t1, %t3
  ret float %t4
}

; Check that a*b+a*c+d is turned into a*(b+c)+d.

define float @fmultistep2(float %a, float %b, float %c, float %d) {
; CHECK-LABEL: @fmultistep2(
; CHECK-NEXT:    [[REASS_ADD:%.*]] = fadd fast float %c, %b
; CHECK-NEXT:    [[REASS_MUL:%.*]] = fmul fast float [[REASS_ADD]], %a
; CHECK-NEXT:    [[T3:%.*]] = fadd fast float [[REASS_MUL]], %d
; CHECK-NEXT:    ret float [[T3]]
;
  %t0 = fmul fast float %a, %b
  %t1 = fmul fast float %a, %c
  %t2 = fadd fast float %t1, %d ; a*c+d
  %t3 = fadd fast float %t0, %t2 ; a*b+(a*c+d)
  ret float %t3
}

