; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s  -cost-model -analyze -mtriple=thumbv8.1m.main-none-eabi -mattr=+mve.fp | FileCheck %s --check-prefix=CHECK-MVE-RECIP
; RUN: opt < %s  -cost-model -analyze -mtriple=thumbv7-apple-ios6.0.0 -mcpu=swift | FileCheck %s --check-prefix=CHECK-NEON-RECIP
; RUN: opt < %s  -cost-model -analyze -mtriple=thumbv8m.base | FileCheck %s --check-prefix=CHECK-THUMB1-RECIP
; RUN: opt < %s  -cost-model -analyze -mtriple=thumbv8m.main | FileCheck %s --check-prefix=CHECK-THUMB2-RECIP
; RUN: opt < %s  -cost-model -analyze -cost-kind=code-size -mtriple=thumbv8.1m.main-none-eabi -mattr=+mve.fp | FileCheck %s --check-prefix=CHECK-MVE-SIZE
; RUN: opt < %s  -cost-model -analyze -cost-kind=code-size -mtriple=thumbv7-apple-ios6.0.0 -mcpu=swift | FileCheck %s --check-prefix=CHECK-NEON-SIZE
; RUN: opt < %s  -cost-model -analyze -cost-kind=code-size -mtriple=thumbv8m.base | FileCheck %s --check-prefix=CHECK-THUMB1-SIZE
; RUN: opt < %s  -cost-model -analyze -cost-kind=code-size -mtriple=thumbv8m.main | FileCheck %s --check-prefix=CHECK-THUMB2-SIZE

define void @op() {
  ; Logical and/or - select's cost must be equivalent to that of binop
; CHECK-MVE-RECIP-LABEL: 'op'
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sand = select i1 undef, i1 undef, i1 false
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %band = and i1 undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sor = select i1 undef, i1 true, i1 undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bor = or i1 undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-NEON-RECIP-LABEL: 'op'
; CHECK-NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sand = select i1 undef, i1 undef, i1 false
; CHECK-NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %band = and i1 undef, undef
; CHECK-NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sor = select i1 undef, i1 true, i1 undef
; CHECK-NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bor = or i1 undef, undef
; CHECK-NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-THUMB1-RECIP-LABEL: 'op'
; CHECK-THUMB1-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sand = select i1 undef, i1 undef, i1 false
; CHECK-THUMB1-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %band = and i1 undef, undef
; CHECK-THUMB1-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sor = select i1 undef, i1 true, i1 undef
; CHECK-THUMB1-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bor = or i1 undef, undef
; CHECK-THUMB1-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-THUMB2-RECIP-LABEL: 'op'
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sand = select i1 undef, i1 undef, i1 false
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %band = and i1 undef, undef
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sor = select i1 undef, i1 true, i1 undef
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bor = or i1 undef, undef
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-MVE-SIZE-LABEL: 'op'
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sand = select i1 undef, i1 undef, i1 false
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %band = and i1 undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %sor = select i1 undef, i1 true, i1 undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %bor = or i1 undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-NEON-SIZE-LABEL: 'op'
; CHECK-NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sand = select i1 undef, i1 undef, i1 false
; CHECK-NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %band = and i1 undef, undef
; CHECK-NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %sor = select i1 undef, i1 true, i1 undef
; CHECK-NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %bor = or i1 undef, undef
; CHECK-NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-THUMB1-SIZE-LABEL: 'op'
; CHECK-THUMB1-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sand = select i1 undef, i1 undef, i1 false
; CHECK-THUMB1-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %band = and i1 undef, undef
; CHECK-THUMB1-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %sor = select i1 undef, i1 true, i1 undef
; CHECK-THUMB1-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %bor = or i1 undef, undef
; CHECK-THUMB1-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-THUMB2-SIZE-LABEL: 'op'
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sand = select i1 undef, i1 undef, i1 false
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %band = and i1 undef, undef
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %sor = select i1 undef, i1 true, i1 undef
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %bor = or i1 undef, undef
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %sand = select i1 undef, i1 undef, i1 false
  %band = and i1 undef, undef
  %sor = select i1 undef, i1 true, i1 undef
  %bor = or i1 undef, undef

  ret void
}

define void @vecop() {
; CHECK-MVE-RECIP-LABEL: 'vecop'
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sand = select <4 x i1> undef, <4 x i1> undef, <4 x i1> zeroinitializer
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %band = and <4 x i1> undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %sor = select <4 x i1> undef, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i1> undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %bor = or <4 x i1> undef, undef
; CHECK-MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-NEON-RECIP-LABEL: 'vecop'
; CHECK-NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sand = select <4 x i1> undef, <4 x i1> undef, <4 x i1> zeroinitializer
; CHECK-NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %band = and <4 x i1> undef, undef
; CHECK-NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sor = select <4 x i1> undef, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i1> undef
; CHECK-NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bor = or <4 x i1> undef, undef
; CHECK-NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; CHECK-THUMB1-RECIP-LABEL: 'vecop'
; CHECK-THUMB1-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %sand = select <4 x i1> undef, <4 x i1> undef, <4 x i1> zeroinitializer
; CHECK-THUMB1-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %band = and <4 x i1> undef, undef
; CHECK-THUMB1-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %sor = select <4 x i1> undef, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i1> undef
; CHECK-THUMB1-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bor = or <4 x i1> undef, undef
; CHECK-THUMB1-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-THUMB2-RECIP-LABEL: 'vecop'
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %sand = select <4 x i1> undef, <4 x i1> undef, <4 x i1> zeroinitializer
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %band = and <4 x i1> undef, undef
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %sor = select <4 x i1> undef, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i1> undef
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bor = or <4 x i1> undef, undef
; CHECK-THUMB2-RECIP-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-MVE-SIZE-LABEL: 'vecop'
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sand = select <4 x i1> undef, <4 x i1> undef, <4 x i1> zeroinitializer
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %band = and <4 x i1> undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sor = select <4 x i1> undef, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i1> undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bor = or <4 x i1> undef, undef
; CHECK-MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-NEON-SIZE-LABEL: 'vecop'
; CHECK-NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sand = select <4 x i1> undef, <4 x i1> undef, <4 x i1> zeroinitializer
; CHECK-NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %band = and <4 x i1> undef, undef
; CHECK-NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %sor = select <4 x i1> undef, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i1> undef
; CHECK-NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %bor = or <4 x i1> undef, undef
; CHECK-NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-THUMB1-SIZE-LABEL: 'vecop'
; CHECK-THUMB1-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %sand = select <4 x i1> undef, <4 x i1> undef, <4 x i1> zeroinitializer
; CHECK-THUMB1-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %band = and <4 x i1> undef, undef
; CHECK-THUMB1-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %sor = select <4 x i1> undef, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i1> undef
; CHECK-THUMB1-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bor = or <4 x i1> undef, undef
; CHECK-THUMB1-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; CHECK-THUMB2-SIZE-LABEL: 'vecop'
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %sand = select <4 x i1> undef, <4 x i1> undef, <4 x i1> zeroinitializer
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %band = and <4 x i1> undef, undef
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %sor = select <4 x i1> undef, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i1> undef
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %bor = or <4 x i1> undef, undef
; CHECK-THUMB2-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
  %sand = select <4 x i1> undef, <4 x i1> undef, <4 x i1> <i1 false, i1 false, i1 false, i1 false>
  %band = and <4 x i1> undef, undef
  %sor = select <4 x i1> undef, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, <4 x i1> undef
  %bor = or <4 x i1> undef, undef

  ret void
}
