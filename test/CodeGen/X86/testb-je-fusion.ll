; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mcpu=corei7-avx | FileCheck %s

; testb should be scheduled right before je to enable macro-fusion.

define i32 @check_flag(i32 %flags, ...) nounwind {
; CHECK-LABEL: check_flag:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    testl $512, %edi # imm = 0x200
; CHECK-NEXT:    je .LBB0_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:  .LBB0_2: # %if.end
; CHECK-NEXT:    retq
entry:
  %and = and i32 %flags, 512
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:
  br label %if.end

if.end:
  %hasflag = phi i32 [ 1, %if.then ], [ 0, %entry ]
  ret i32 %hasflag
}
