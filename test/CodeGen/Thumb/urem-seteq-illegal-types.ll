; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumb-eabi < %s | FileCheck %s

define i1 @test_urem_odd(i13 %X) nounwind {
; CHECK-LABEL: test_urem_odd:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    ldr r1, .LCPI0_0
; CHECK-NEXT:    muls r1, r0, r1
; CHECK-NEXT:    ldr r0, .LCPI0_1
; CHECK-NEXT:    cmp r1, r0
; CHECK-NEXT:    blo .LBB0_2
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    bx lr
; CHECK-NEXT:  .LBB0_2:
; CHECK-NEXT:    movs r0, #1
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI0_0:
; CHECK-NEXT:    .long 1718091776 @ 0x66680000
; CHECK-NEXT:  .LCPI0_1:
; CHECK-NEXT:    .long 859308032 @ 0x33380000
  %urem = urem i13 %X, 5
  %cmp = icmp eq i13 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_even(i27 %X) nounwind {
; CHECK-LABEL: test_urem_even:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    ldr r1, .LCPI1_0
; CHECK-NEXT:    muls r1, r0, r1
; CHECK-NEXT:    lsls r0, r1, #26
; CHECK-NEXT:    ldr r2, .LCPI1_1
; CHECK-NEXT:    ands r2, r1
; CHECK-NEXT:    lsrs r1, r2, #1
; CHECK-NEXT:    adds r0, r1, r0
; CHECK-NEXT:    lsls r0, r0, #5
; CHECK-NEXT:    ldr r1, .LCPI1_2
; CHECK-NEXT:    cmp r0, r1
; CHECK-NEXT:    blo .LBB1_2
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    bx lr
; CHECK-NEXT:  .LBB1_2:
; CHECK-NEXT:    movs r0, #1
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI1_0:
; CHECK-NEXT:    .long 115043767 @ 0x6db6db7
; CHECK-NEXT:  .LCPI1_1:
; CHECK-NEXT:    .long 134217726 @ 0x7fffffe
; CHECK-NEXT:  .LCPI1_2:
; CHECK-NEXT:    .long 306783392 @ 0x124924a0
  %urem = urem i27 %X, 14
  %cmp = icmp eq i27 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_odd_setne(i4 %X) nounwind {
; CHECK-LABEL: test_urem_odd_setne:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    movs r1, #13
; CHECK-NEXT:    muls r1, r0, r1
; CHECK-NEXT:    movs r0, #15
; CHECK-NEXT:    ands r0, r1
; CHECK-NEXT:    cmp r0, #3
; CHECK-NEXT:    bhi .LBB2_2
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    bx lr
; CHECK-NEXT:  .LBB2_2:
; CHECK-NEXT:    movs r0, #1
; CHECK-NEXT:    bx lr
  %urem = urem i4 %X, 5
  %cmp = icmp ne i4 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_negative_odd(i9 %X) nounwind {
; CHECK-LABEL: test_urem_negative_odd:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    movs r1, #255
; CHECK-NEXT:    adds r1, #52
; CHECK-NEXT:    muls r1, r0, r1
; CHECK-NEXT:    ldr r0, .LCPI3_0
; CHECK-NEXT:    ands r0, r1
; CHECK-NEXT:    cmp r0, #1
; CHECK-NEXT:    bhi .LBB3_2
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    bx lr
; CHECK-NEXT:  .LBB3_2:
; CHECK-NEXT:    movs r0, #1
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI3_0:
; CHECK-NEXT:    .long 511 @ 0x1ff
  %urem = urem i9 %X, -5
  %cmp = icmp ne i9 %urem, 0
  ret i1 %cmp
}

define <3 x i1> @test_urem_vec(<3 x i11> %X) nounwind {
; CHECK-LABEL: test_urem_vec:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r7, lr}
; CHECK-NEXT:    push {r4, r5, r7, lr}
; CHECK-NEXT:    ldr r3, .LCPI4_0
; CHECK-NEXT:    muls r3, r0, r3
; CHECK-NEXT:    lsls r0, r3, #10
; CHECK-NEXT:    ldr r4, .LCPI4_1
; CHECK-NEXT:    ands r4, r3
; CHECK-NEXT:    lsrs r3, r4, #1
; CHECK-NEXT:    adds r0, r3, r0
; CHECK-NEXT:    ldr r3, .LCPI4_2
; CHECK-NEXT:    ands r3, r0
; CHECK-NEXT:    lsrs r0, r3, #1
; CHECK-NEXT:    movs r3, #1
; CHECK-NEXT:    movs r4, #0
; CHECK-NEXT:    cmp r0, #170
; CHECK-NEXT:    push {r3}
; CHECK-NEXT:    pop {r0}
; CHECK-NEXT:    bhi .LBB4_2
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:    movs r0, r4
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    ldr r5, .LCPI4_3
; CHECK-NEXT:    muls r5, r1, r5
; CHECK-NEXT:    ldr r1, .LCPI4_4
; CHECK-NEXT:    adds r1, r5, r1
; CHECK-NEXT:    movs r5, #73
; CHECK-NEXT:    lsls r5, r5, #23
; CHECK-NEXT:    cmp r1, r5
; CHECK-NEXT:    push {r3}
; CHECK-NEXT:    pop {r1}
; CHECK-NEXT:    bhi .LBB4_4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:    movs r1, r4
; CHECK-NEXT:  .LBB4_4:
; CHECK-NEXT:    ldr r5, .LCPI4_5
; CHECK-NEXT:    muls r5, r2, r5
; CHECK-NEXT:    ldr r2, .LCPI4_6
; CHECK-NEXT:    adds r2, r5, r2
; CHECK-NEXT:    ldr r5, .LCPI4_7
; CHECK-NEXT:    ands r5, r2
; CHECK-NEXT:    cmp r5, #1
; CHECK-NEXT:    bhi .LBB4_6
; CHECK-NEXT:  @ %bb.5:
; CHECK-NEXT:    movs r3, r4
; CHECK-NEXT:  .LBB4_6:
; CHECK-NEXT:    movs r2, r3
; CHECK-NEXT:    pop {r4, r5, r7}
; CHECK-NEXT:    pop {r3}
; CHECK-NEXT:    bx r3
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.7:
; CHECK-NEXT:  .LCPI4_0:
; CHECK-NEXT:    .long 683 @ 0x2ab
; CHECK-NEXT:  .LCPI4_1:
; CHECK-NEXT:    .long 2044 @ 0x7fc
; CHECK-NEXT:  .LCPI4_2:
; CHECK-NEXT:    .long 2046 @ 0x7fe
; CHECK-NEXT:  .LCPI4_3:
; CHECK-NEXT:    .long 3068133376 @ 0xb6e00000
; CHECK-NEXT:  .LCPI4_4:
; CHECK-NEXT:    .long 1226833920 @ 0x49200000
; CHECK-NEXT:  .LCPI4_5:
; CHECK-NEXT:    .long 819 @ 0x333
; CHECK-NEXT:  .LCPI4_6:
; CHECK-NEXT:    .long 4294965658 @ 0xfffff99a
; CHECK-NEXT:  .LCPI4_7:
; CHECK-NEXT:    .long 2047 @ 0x7ff
  %urem = urem <3 x i11> %X, <i11 6, i11 7, i11 -5>
  %cmp = icmp ne <3 x i11> %urem, <i11 0, i11 1, i11 2>
  ret <3 x i1> %cmp
}
