; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv32 -mattr=+experimental-b -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32IB
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zbt -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32IBT

define i32 @cmix_i32(i32 %a, i32 %b, i32 %c) nounwind {
; RV32I-LABEL: cmix_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    not a1, a1
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    or a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: cmix_i32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    cmix a0, a1, a0, a2
; RV32IB-NEXT:    ret
;
; RV32IBT-LABEL: cmix_i32:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    cmix a0, a1, a0, a2
; RV32IBT-NEXT:    ret
  %and = and i32 %b, %a
  %neg = xor i32 %b, -1
  %and1 = and i32 %neg, %c
  %or = or i32 %and1, %and
  ret i32 %or
}

define i64 @cmix_i64(i64 %a, i64 %b, i64 %c) nounwind {
; RV32I-LABEL: cmix_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    and a1, a3, a1
; RV32I-NEXT:    and a0, a2, a0
; RV32I-NEXT:    not a2, a2
; RV32I-NEXT:    not a3, a3
; RV32I-NEXT:    and a3, a3, a5
; RV32I-NEXT:    and a2, a2, a4
; RV32I-NEXT:    or a0, a2, a0
; RV32I-NEXT:    or a1, a3, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: cmix_i64:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    cmix a0, a2, a0, a4
; RV32IB-NEXT:    cmix a1, a3, a1, a5
; RV32IB-NEXT:    ret
;
; RV32IBT-LABEL: cmix_i64:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    cmix a0, a2, a0, a4
; RV32IBT-NEXT:    cmix a1, a3, a1, a5
; RV32IBT-NEXT:    ret
  %and = and i64 %b, %a
  %neg = xor i64 %b, -1
  %and1 = and i64 %neg, %c
  %or = or i64 %and1, %and
  ret i64 %or
}

define i32 @cmov_i32(i32 %a, i32 %b, i32 %c) nounwind {
; RV32I-LABEL: cmov_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    beqz a1, .LBB2_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a2, a0
; RV32I-NEXT:  .LBB2_2:
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: cmov_i32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    cmov a0, a1, a0, a2
; RV32IB-NEXT:    ret
;
; RV32IBT-LABEL: cmov_i32:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    cmov a0, a1, a0, a2
; RV32IBT-NEXT:    ret
  %tobool.not = icmp eq i32 %b, 0
  %cond = select i1 %tobool.not, i32 %c, i32 %a
  ret i32 %cond
}

define i64 @cmov_i64(i64 %a, i64 %b, i64 %c) nounwind {
; RV32I-LABEL: cmov_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    or a2, a2, a3
; RV32I-NEXT:    beqz a2, .LBB3_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a4, a0
; RV32I-NEXT:    mv a5, a1
; RV32I-NEXT:  .LBB3_2:
; RV32I-NEXT:    mv a0, a4
; RV32I-NEXT:    mv a1, a5
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: cmov_i64:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    or a2, a2, a3
; RV32IB-NEXT:    cmov a0, a2, a0, a4
; RV32IB-NEXT:    cmov a1, a2, a1, a5
; RV32IB-NEXT:    ret
;
; RV32IBT-LABEL: cmov_i64:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    or a2, a2, a3
; RV32IBT-NEXT:    cmov a0, a2, a0, a4
; RV32IBT-NEXT:    cmov a1, a2, a1, a5
; RV32IBT-NEXT:    ret
  %tobool.not = icmp eq i64 %b, 0
  %cond = select i1 %tobool.not, i64 %c, i64 %a
  ret i64 %cond
}

declare i32 @llvm.fshl.i32(i32, i32, i32)

define i32 @fshl_i32(i32 %a, i32 %b, i32 %c) nounwind {
; RV32I-LABEL: fshl_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sll a0, a0, a2
; RV32I-NEXT:    not a2, a2
; RV32I-NEXT:    srli a1, a1, 1
; RV32I-NEXT:    srl a1, a1, a2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: fshl_i32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    fsl a0, a0, a2, a1
; RV32IB-NEXT:    ret
;
; RV32IBT-LABEL: fshl_i32:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    fsl a0, a0, a2, a1
; RV32IBT-NEXT:    ret
  %1 = tail call i32 @llvm.fshl.i32(i32 %a, i32 %b, i32 %c)
  ret i32 %1
}

; As we are not matching directly i64 code patterns on RV32 some i64 patterns
; don't have yet an efficient pattern-matching with bit manipulation
; instructions on RV32.
; This test is presented here in case future expansions of the experimental-b
; extension introduce instructions that can match more efficiently this pattern.

declare i64 @llvm.fshl.i64(i64, i64, i64)

define i64 @fshl_i64(i64 %a, i64 %b, i64 %c) nounwind {
; RV32I-LABEL: fshl_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a5, a4, 63
; RV32I-NEXT:    addi t1, a5, -32
; RV32I-NEXT:    addi a6, zero, 31
; RV32I-NEXT:    bltz t1, .LBB5_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    sll a7, a0, t1
; RV32I-NEXT:    j .LBB5_3
; RV32I-NEXT:  .LBB5_2:
; RV32I-NEXT:    sll a7, a1, a4
; RV32I-NEXT:    sub a5, a6, a5
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    srl a1, a1, a5
; RV32I-NEXT:    or a7, a7, a1
; RV32I-NEXT:  .LBB5_3:
; RV32I-NEXT:    not a1, a4
; RV32I-NEXT:    andi t3, a1, 63
; RV32I-NEXT:    addi a5, t3, -32
; RV32I-NEXT:    srli t2, a3, 1
; RV32I-NEXT:    bltz a5, .LBB5_7
; RV32I-NEXT:  # %bb.4:
; RV32I-NEXT:    mv t0, zero
; RV32I-NEXT:    bgez a5, .LBB5_8
; RV32I-NEXT:  .LBB5_5:
; RV32I-NEXT:    slli a3, a3, 31
; RV32I-NEXT:    srli a2, a2, 1
; RV32I-NEXT:    or a2, a2, a3
; RV32I-NEXT:    srl a1, a2, a1
; RV32I-NEXT:    sub a2, a6, t3
; RV32I-NEXT:    slli a3, t2, 1
; RV32I-NEXT:    sll a2, a3, a2
; RV32I-NEXT:    or a2, a1, a2
; RV32I-NEXT:    or a1, a7, t0
; RV32I-NEXT:    bgez t1, .LBB5_9
; RV32I-NEXT:  .LBB5_6:
; RV32I-NEXT:    sll a0, a0, a4
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB5_7:
; RV32I-NEXT:    srl t0, t2, a1
; RV32I-NEXT:    bltz a5, .LBB5_5
; RV32I-NEXT:  .LBB5_8:
; RV32I-NEXT:    srl a2, t2, a5
; RV32I-NEXT:    or a1, a7, t0
; RV32I-NEXT:    bltz t1, .LBB5_6
; RV32I-NEXT:  .LBB5_9:
; RV32I-NEXT:    or a0, zero, a2
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: fshl_i64:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    andi a5, a4, 63
; RV32IB-NEXT:    addi t2, a5, -32
; RV32IB-NEXT:    addi a6, zero, 31
; RV32IB-NEXT:    bltz t2, .LBB5_2
; RV32IB-NEXT:  # %bb.1:
; RV32IB-NEXT:    sll a7, a0, t2
; RV32IB-NEXT:    j .LBB5_3
; RV32IB-NEXT:  .LBB5_2:
; RV32IB-NEXT:    sll a7, a1, a4
; RV32IB-NEXT:    sub a5, a6, a5
; RV32IB-NEXT:    srli a1, a0, 1
; RV32IB-NEXT:    srl a1, a1, a5
; RV32IB-NEXT:    or a7, a7, a1
; RV32IB-NEXT:  .LBB5_3:
; RV32IB-NEXT:    not t1, a4
; RV32IB-NEXT:    addi a1, zero, 63
; RV32IB-NEXT:    andn a5, a1, a4
; RV32IB-NEXT:    addi a1, a5, -32
; RV32IB-NEXT:    srli t3, a3, 1
; RV32IB-NEXT:    bltz a1, .LBB5_7
; RV32IB-NEXT:  # %bb.4:
; RV32IB-NEXT:    mv t0, zero
; RV32IB-NEXT:    bgez a1, .LBB5_8
; RV32IB-NEXT:  .LBB5_5:
; RV32IB-NEXT:    fsl a1, a3, a6, a2
; RV32IB-NEXT:    srl a1, a1, t1
; RV32IB-NEXT:    sub a2, a6, a5
; RV32IB-NEXT:    slli a3, t3, 1
; RV32IB-NEXT:    sll a2, a3, a2
; RV32IB-NEXT:    or a2, a1, a2
; RV32IB-NEXT:    or a1, a7, t0
; RV32IB-NEXT:    bgez t2, .LBB5_9
; RV32IB-NEXT:  .LBB5_6:
; RV32IB-NEXT:    sll a0, a0, a4
; RV32IB-NEXT:    or a0, a0, a2
; RV32IB-NEXT:    ret
; RV32IB-NEXT:  .LBB5_7:
; RV32IB-NEXT:    srl t0, t3, t1
; RV32IB-NEXT:    bltz a1, .LBB5_5
; RV32IB-NEXT:  .LBB5_8:
; RV32IB-NEXT:    srl a2, t3, a1
; RV32IB-NEXT:    or a1, a7, t0
; RV32IB-NEXT:    bltz t2, .LBB5_6
; RV32IB-NEXT:  .LBB5_9:
; RV32IB-NEXT:    or a0, zero, a2
; RV32IB-NEXT:    ret
;
; RV32IBT-LABEL: fshl_i64:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    andi a5, a4, 63
; RV32IBT-NEXT:    addi t1, a5, -32
; RV32IBT-NEXT:    addi a6, zero, 31
; RV32IBT-NEXT:    bltz t1, .LBB5_2
; RV32IBT-NEXT:  # %bb.1:
; RV32IBT-NEXT:    sll a7, a0, t1
; RV32IBT-NEXT:    j .LBB5_3
; RV32IBT-NEXT:  .LBB5_2:
; RV32IBT-NEXT:    sll a7, a1, a4
; RV32IBT-NEXT:    sub a5, a6, a5
; RV32IBT-NEXT:    srli a1, a0, 1
; RV32IBT-NEXT:    srl a1, a1, a5
; RV32IBT-NEXT:    or a7, a7, a1
; RV32IBT-NEXT:  .LBB5_3:
; RV32IBT-NEXT:    not a1, a4
; RV32IBT-NEXT:    andi t3, a1, 63
; RV32IBT-NEXT:    addi a5, t3, -32
; RV32IBT-NEXT:    srli t2, a3, 1
; RV32IBT-NEXT:    bltz a5, .LBB5_7
; RV32IBT-NEXT:  # %bb.4:
; RV32IBT-NEXT:    mv t0, zero
; RV32IBT-NEXT:    bgez a5, .LBB5_8
; RV32IBT-NEXT:  .LBB5_5:
; RV32IBT-NEXT:    fsl a2, a3, a6, a2
; RV32IBT-NEXT:    srl a1, a2, a1
; RV32IBT-NEXT:    sub a2, a6, t3
; RV32IBT-NEXT:    slli a3, t2, 1
; RV32IBT-NEXT:    sll a2, a3, a2
; RV32IBT-NEXT:    or a2, a1, a2
; RV32IBT-NEXT:    or a1, a7, t0
; RV32IBT-NEXT:    bgez t1, .LBB5_9
; RV32IBT-NEXT:  .LBB5_6:
; RV32IBT-NEXT:    sll a0, a0, a4
; RV32IBT-NEXT:    or a0, a0, a2
; RV32IBT-NEXT:    ret
; RV32IBT-NEXT:  .LBB5_7:
; RV32IBT-NEXT:    srl t0, t2, a1
; RV32IBT-NEXT:    bltz a5, .LBB5_5
; RV32IBT-NEXT:  .LBB5_8:
; RV32IBT-NEXT:    srl a2, t2, a5
; RV32IBT-NEXT:    or a1, a7, t0
; RV32IBT-NEXT:    bltz t1, .LBB5_6
; RV32IBT-NEXT:  .LBB5_9:
; RV32IBT-NEXT:    or a0, zero, a2
; RV32IBT-NEXT:    ret
  %1 = tail call i64 @llvm.fshl.i64(i64 %a, i64 %b, i64 %c)
  ret i64 %1
}

declare i32 @llvm.fshr.i32(i32, i32, i32)

define i32 @fshr_i32(i32 %a, i32 %b, i32 %c) nounwind {
; RV32I-LABEL: fshr_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srl a1, a1, a2
; RV32I-NEXT:    not a2, a2
; RV32I-NEXT:    slli a0, a0, 1
; RV32I-NEXT:    sll a0, a0, a2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: fshr_i32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    fsr a0, a0, a2, a1
; RV32IB-NEXT:    ret
;
; RV32IBT-LABEL: fshr_i32:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    fsr a0, a0, a2, a1
; RV32IBT-NEXT:    ret
  %1 = tail call i32 @llvm.fshr.i32(i32 %a, i32 %b, i32 %c)
  ret i32 %1
}

; As we are not matching directly i64 code patterns on RV32 some i64 patterns
; don't have yet an efficient pattern-matching with bit manipulation
; instructions on RV32.
; This test is presented here in case future expansions of the experimental-b
; extension introduce instructions that can match more efficiently this pattern.

declare i64 @llvm.fshr.i64(i64, i64, i64)

define i64 @fshr_i64(i64 %a, i64 %b, i64 %c) nounwind {
; RV32I-LABEL: fshr_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a5, a4, 63
; RV32I-NEXT:    addi t1, a5, -32
; RV32I-NEXT:    addi a6, zero, 31
; RV32I-NEXT:    bltz t1, .LBB7_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srl a7, a3, t1
; RV32I-NEXT:    j .LBB7_3
; RV32I-NEXT:  .LBB7_2:
; RV32I-NEXT:    srl a7, a2, a4
; RV32I-NEXT:    sub a5, a6, a5
; RV32I-NEXT:    slli a2, a3, 1
; RV32I-NEXT:    sll a2, a2, a5
; RV32I-NEXT:    or a7, a7, a2
; RV32I-NEXT:  .LBB7_3:
; RV32I-NEXT:    not a2, a4
; RV32I-NEXT:    andi t2, a2, 63
; RV32I-NEXT:    addi a5, t2, -32
; RV32I-NEXT:    slli t3, a0, 1
; RV32I-NEXT:    bltz a5, .LBB7_7
; RV32I-NEXT:  # %bb.4:
; RV32I-NEXT:    mv t0, zero
; RV32I-NEXT:    bgez a5, .LBB7_8
; RV32I-NEXT:  .LBB7_5:
; RV32I-NEXT:    lui a5, 524288
; RV32I-NEXT:    addi a5, a5, -1
; RV32I-NEXT:    and t3, a0, a5
; RV32I-NEXT:    sub a5, a6, t2
; RV32I-NEXT:    srl a5, t3, a5
; RV32I-NEXT:    srli a0, a0, 31
; RV32I-NEXT:    slli a1, a1, 1
; RV32I-NEXT:    or a0, a1, a0
; RV32I-NEXT:    sll a0, a0, a2
; RV32I-NEXT:    or a1, a0, a5
; RV32I-NEXT:    or a0, t0, a7
; RV32I-NEXT:    bgez t1, .LBB7_9
; RV32I-NEXT:  .LBB7_6:
; RV32I-NEXT:    srl a2, a3, a4
; RV32I-NEXT:    or a1, a1, a2
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB7_7:
; RV32I-NEXT:    sll t0, t3, a2
; RV32I-NEXT:    bltz a5, .LBB7_5
; RV32I-NEXT:  .LBB7_8:
; RV32I-NEXT:    sll a1, t3, a5
; RV32I-NEXT:    or a0, t0, a7
; RV32I-NEXT:    bltz t1, .LBB7_6
; RV32I-NEXT:  .LBB7_9:
; RV32I-NEXT:    or a1, a1, zero
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: fshr_i64:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    andi a5, a4, 63
; RV32IB-NEXT:    addi t2, a5, -32
; RV32IB-NEXT:    addi a6, zero, 31
; RV32IB-NEXT:    bltz t2, .LBB7_2
; RV32IB-NEXT:  # %bb.1:
; RV32IB-NEXT:    srl a7, a3, t2
; RV32IB-NEXT:    j .LBB7_3
; RV32IB-NEXT:  .LBB7_2:
; RV32IB-NEXT:    srl a7, a2, a4
; RV32IB-NEXT:    sub a5, a6, a5
; RV32IB-NEXT:    slli a2, a3, 1
; RV32IB-NEXT:    sll a2, a2, a5
; RV32IB-NEXT:    or a7, a7, a2
; RV32IB-NEXT:  .LBB7_3:
; RV32IB-NEXT:    not t1, a4
; RV32IB-NEXT:    addi a2, zero, 63
; RV32IB-NEXT:    andn a2, a2, a4
; RV32IB-NEXT:    addi a5, a2, -32
; RV32IB-NEXT:    slli t3, a0, 1
; RV32IB-NEXT:    bltz a5, .LBB7_7
; RV32IB-NEXT:  # %bb.4:
; RV32IB-NEXT:    mv t0, zero
; RV32IB-NEXT:    bgez a5, .LBB7_8
; RV32IB-NEXT:  .LBB7_5:
; RV32IB-NEXT:    addi a5, zero, 1
; RV32IB-NEXT:    fsl a1, a1, a5, a0
; RV32IB-NEXT:    sll a1, a1, t1
; RV32IB-NEXT:    sub a2, a6, a2
; RV32IB-NEXT:    lui a5, 524288
; RV32IB-NEXT:    addi a5, a5, -1
; RV32IB-NEXT:    and a0, a0, a5
; RV32IB-NEXT:    srl a0, a0, a2
; RV32IB-NEXT:    or a1, a1, a0
; RV32IB-NEXT:    or a0, t0, a7
; RV32IB-NEXT:    bgez t2, .LBB7_9
; RV32IB-NEXT:  .LBB7_6:
; RV32IB-NEXT:    srl a2, a3, a4
; RV32IB-NEXT:    or a1, a1, a2
; RV32IB-NEXT:    ret
; RV32IB-NEXT:  .LBB7_7:
; RV32IB-NEXT:    sll t0, t3, t1
; RV32IB-NEXT:    bltz a5, .LBB7_5
; RV32IB-NEXT:  .LBB7_8:
; RV32IB-NEXT:    sll a1, t3, a5
; RV32IB-NEXT:    or a0, t0, a7
; RV32IB-NEXT:    bltz t2, .LBB7_6
; RV32IB-NEXT:  .LBB7_9:
; RV32IB-NEXT:    or a1, a1, zero
; RV32IB-NEXT:    ret
;
; RV32IBT-LABEL: fshr_i64:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    not a7, a4
; RV32IBT-NEXT:    andi t1, a7, 63
; RV32IBT-NEXT:    addi t0, zero, 31
; RV32IBT-NEXT:    addi t2, t1, -32
; RV32IBT-NEXT:    slli a6, a0, 1
; RV32IBT-NEXT:    bltz t2, .LBB7_2
; RV32IBT-NEXT:  # %bb.1:
; RV32IBT-NEXT:    sll t1, a6, t2
; RV32IBT-NEXT:    j .LBB7_3
; RV32IBT-NEXT:  .LBB7_2:
; RV32IBT-NEXT:    addi a5, zero, 1
; RV32IBT-NEXT:    fsl a1, a1, a5, a0
; RV32IBT-NEXT:    sll a1, a1, a7
; RV32IBT-NEXT:    lui a5, 524288
; RV32IBT-NEXT:    addi a5, a5, -1
; RV32IBT-NEXT:    and a0, a0, a5
; RV32IBT-NEXT:    sub a5, t0, t1
; RV32IBT-NEXT:    srl a0, a0, a5
; RV32IBT-NEXT:    or t1, a1, a0
; RV32IBT-NEXT:  .LBB7_3:
; RV32IBT-NEXT:    andi a0, a4, 63
; RV32IBT-NEXT:    addi a5, a0, -32
; RV32IBT-NEXT:    bltz a5, .LBB7_7
; RV32IBT-NEXT:  # %bb.4:
; RV32IBT-NEXT:    mv a1, zero
; RV32IBT-NEXT:    bgez a5, .LBB7_8
; RV32IBT-NEXT:  .LBB7_5:
; RV32IBT-NEXT:    srl a2, a2, a4
; RV32IBT-NEXT:    sub a0, t0, a0
; RV32IBT-NEXT:    slli a3, a3, 1
; RV32IBT-NEXT:    sll a0, a3, a0
; RV32IBT-NEXT:    or a2, a2, a0
; RV32IBT-NEXT:    or a1, t1, a1
; RV32IBT-NEXT:    bgez t2, .LBB7_9
; RV32IBT-NEXT:  .LBB7_6:
; RV32IBT-NEXT:    sll a0, a6, a7
; RV32IBT-NEXT:    or a0, a0, a2
; RV32IBT-NEXT:    ret
; RV32IBT-NEXT:  .LBB7_7:
; RV32IBT-NEXT:    srl a1, a3, a4
; RV32IBT-NEXT:    bltz a5, .LBB7_5
; RV32IBT-NEXT:  .LBB7_8:
; RV32IBT-NEXT:    srl a2, a3, a5
; RV32IBT-NEXT:    or a1, t1, a1
; RV32IBT-NEXT:    bltz t2, .LBB7_6
; RV32IBT-NEXT:  .LBB7_9:
; RV32IBT-NEXT:    or a0, zero, a2
; RV32IBT-NEXT:    ret
  %1 = tail call i64 @llvm.fshr.i64(i64 %a, i64 %b, i64 %c)
  ret i64 %1
}

define i32 @fshri_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: fshri_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a1, a1, 5
; RV32I-NEXT:    slli a0, a0, 27
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: fshri_i32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    fsri a0, a0, a1, 5
; RV32IB-NEXT:    ret
;
; RV32IBT-LABEL: fshri_i32:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    fsri a0, a0, a1, 5
; RV32IBT-NEXT:    ret
  %1 = tail call i32 @llvm.fshr.i32(i32 %a, i32 %b, i32 5)
  ret i32 %1
}

define i64 @fshri_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: fshri_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a3, 27
; RV32I-NEXT:    srli a2, a2, 5
; RV32I-NEXT:    or a2, a2, a1
; RV32I-NEXT:    srli a1, a3, 5
; RV32I-NEXT:    slli a0, a0, 27
; RV32I-NEXT:    or a1, a0, a1
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    ret
;
; RV32IB-LABEL: fshri_i64:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    addi a1, zero, 27
; RV32IB-NEXT:    fsl a2, a3, a1, a2
; RV32IB-NEXT:    fsl a1, a0, a1, a3
; RV32IB-NEXT:    mv a0, a2
; RV32IB-NEXT:    ret
;
; RV32IBT-LABEL: fshri_i64:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    addi a1, zero, 27
; RV32IBT-NEXT:    fsl a2, a3, a1, a2
; RV32IBT-NEXT:    fsl a1, a0, a1, a3
; RV32IBT-NEXT:    mv a0, a2
; RV32IBT-NEXT:    ret
  %1 = tail call i64 @llvm.fshr.i64(i64 %a, i64 %b, i64 5)
  ret i64 %1
}
