; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IFD %s

define double @func(double %d, i32 %n) nounwind {
; RV32IFD-LABEL: func:
; RV32IFD:       # %bb.0: # %entry
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw ra, 28(sp)
; RV32IFD-NEXT:    sw a0, 16(sp)
; RV32IFD-NEXT:    sw a1, 20(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    beqz a2, .LBB0_2
; RV32IFD-NEXT:  # %bb.1: # %if.else
; RV32IFD-NEXT:    addi a2, a2, -1
; RV32IFD-NEXT:    lui a0, %hi(func)
; RV32IFD-NEXT:    addi a3, a0, %lo(func)
; RV32IFD-NEXT:    fsd ft0, 16(sp)
; RV32IFD-NEXT:    lw a0, 16(sp)
; RV32IFD-NEXT:    lw a1, 20(sp)
; RV32IFD-NEXT:    fsd ft0, 8(sp)
; RV32IFD-NEXT:    jalr a3
; RV32IFD-NEXT:    sw a0, 16(sp)
; RV32IFD-NEXT:    sw a1, 20(sp)
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    fld ft1, 8(sp)
; RV32IFD-NEXT:    fadd.d ft0, ft0, ft1
; RV32IFD-NEXT:  .LBB0_2: # %return
; RV32IFD-NEXT:    fsd ft0, 16(sp)
; RV32IFD-NEXT:    lw a0, 16(sp)
; RV32IFD-NEXT:    lw a1, 20(sp)
; RV32IFD-NEXT:    lw ra, 28(sp)
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
entry:
  %cmp = icmp eq i32 %n, 0
  br i1 %cmp, label %return, label %if.else

if.else:
  %sub = add i32 %n, -1
  %call = tail call double @func(double %d, i32 %sub)
  %add = fadd double %call, %d
  ret double %add

return:
  ret double %d
}
