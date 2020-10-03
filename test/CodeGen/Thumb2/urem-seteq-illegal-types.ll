; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv7-none-eabi < %s | FileCheck %s

define i1 @test_urem_odd(i13 %X) nounwind {
; CHECK-LABEL: test_urem_odd:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    movw r1, #3277
; CHECK-NEXT:    movw r2, #1639
; CHECK-NEXT:    muls r1, r0, r1
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    bfc r1, #13, #19
; CHECK-NEXT:    cmp r1, r2
; CHECK-NEXT:    it lo
; CHECK-NEXT:    movlo r0, #1
; CHECK-NEXT:    bx lr
  %urem = urem i13 %X, 5
  %cmp = icmp eq i13 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_even(i27 %X) nounwind {
; CHECK-LABEL: test_urem_even:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    movw r1, #28087
; CHECK-NEXT:    movw r2, #18725
; CHECK-NEXT:    movt r1, #1755
; CHECK-NEXT:    movt r2, #146
; CHECK-NEXT:    muls r0, r1, r0
; CHECK-NEXT:    ubfx r1, r0, #1, #26
; CHECK-NEXT:    orr.w r0, r1, r0, lsl #26
; CHECK-NEXT:    bic r1, r0, #-134217728
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    cmp r1, r2
; CHECK-NEXT:    it lo
; CHECK-NEXT:    movlo r0, #1
; CHECK-NEXT:    bx lr
  %urem = urem i27 %X, 14
  %cmp = icmp eq i27 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_odd_setne(i4 %X) nounwind {
; CHECK-LABEL: test_urem_odd_setne:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    movs r1, #13
; CHECK-NEXT:    muls r0, r1, r0
; CHECK-NEXT:    and r1, r0, #15
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    cmp r1, #3
; CHECK-NEXT:    it hi
; CHECK-NEXT:    movhi r0, #1
; CHECK-NEXT:    bx lr
  %urem = urem i4 %X, 5
  %cmp = icmp ne i4 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_negative_odd(i9 %X) nounwind {
; CHECK-LABEL: test_urem_negative_odd:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    movw r1, #307
; CHECK-NEXT:    muls r1, r0, r1
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    bfc r1, #9, #23
; CHECK-NEXT:    cmp r1, #1
; CHECK-NEXT:    it hi
; CHECK-NEXT:    movhi r0, #1
; CHECK-NEXT:    bx lr
  %urem = urem i9 %X, -5
  %cmp = icmp ne i9 %urem, 0
  ret i1 %cmp
}

define <3 x i1> @test_urem_vec(<3 x i11> %X) nounwind {
; CHECK-LABEL: test_urem_vec:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov.16 d16[0], r0
; CHECK-NEXT:    vldr d17, .LCPI4_0
; CHECK-NEXT:    vmov.16 d16[1], r1
; CHECK-NEXT:    vldr d19, .LCPI4_3
; CHECK-NEXT:    vmov.16 d16[2], r2
; CHECK-NEXT:    vsub.i16 d16, d16, d17
; CHECK-NEXT:    vldr d17, .LCPI4_1
; CHECK-NEXT:    vmul.i16 d16, d16, d17
; CHECK-NEXT:    vldr d17, .LCPI4_2
; CHECK-NEXT:    vneg.s16 d17, d17
; CHECK-NEXT:    vshl.i16 d18, d16, #1
; CHECK-NEXT:    vbic.i16 d16, #0xf800
; CHECK-NEXT:    vshl.u16 d16, d16, d17
; CHECK-NEXT:    vshl.u16 d17, d18, d19
; CHECK-NEXT:    vorr d16, d16, d17
; CHECK-NEXT:    vldr d17, .LCPI4_4
; CHECK-NEXT:    vbic.i16 d16, #0xf800
; CHECK-NEXT:    vcgt.u16 d16, d16, d17
; CHECK-NEXT:    vmov.u16 r0, d16[0]
; CHECK-NEXT:    vmov.u16 r1, d16[1]
; CHECK-NEXT:    vmov.u16 r2, d16[2]
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 3
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI4_0:
; CHECK-NEXT:    .short 0 @ 0x0
; CHECK-NEXT:    .short 1 @ 0x1
; CHECK-NEXT:    .short 2 @ 0x2
; CHECK-NEXT:    .zero 2
; CHECK-NEXT:  .LCPI4_1:
; CHECK-NEXT:    .short 683 @ 0x2ab
; CHECK-NEXT:    .short 1463 @ 0x5b7
; CHECK-NEXT:    .short 819 @ 0x333
; CHECK-NEXT:    .zero 2
; CHECK-NEXT:  .LCPI4_2:
; CHECK-NEXT:    .short 1 @ 0x1
; CHECK-NEXT:    .short 0 @ 0x0
; CHECK-NEXT:    .short 0 @ 0x0
; CHECK-NEXT:    .short 0 @ 0x0
; CHECK-NEXT:  .LCPI4_3:
; CHECK-NEXT:    .short 9 @ 0x9
; CHECK-NEXT:    .short 10 @ 0xa
; CHECK-NEXT:    .short 10 @ 0xa
; CHECK-NEXT:    .short 10 @ 0xa
; CHECK-NEXT:  .LCPI4_4:
; CHECK-NEXT:    .short 341 @ 0x155
; CHECK-NEXT:    .short 292 @ 0x124
; CHECK-NEXT:    .short 1 @ 0x1
; CHECK-NEXT:    .short 0 @ 0x0
  %urem = urem <3 x i11> %X, <i11 6, i11 7, i11 -5>
  %cmp = icmp ne <3 x i11> %urem, <i11 0, i11 1, i11 2>
  ret <3 x i1> %cmp
}
