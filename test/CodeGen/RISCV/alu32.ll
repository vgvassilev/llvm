; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64I

; These tests are each targeted at a particular RISC-V ALU instruction. Most
; other files in this folder exercise LLVM IR instructions that don't directly
; match a RISC-V instruction.

; Register-immediate instructions.

; TODO: Sign-extension would also work when promoting the operands of
; sltu/sltiu on RV64 and is cheaper than zero-extension (1 instruction vs 2).

define i32 @addi(i32 %a) nounwind {
; RV32I-LABEL: addi:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, 1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: addi:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, 1
; RV64I-NEXT:    ret
  %1 = add i32 %a, 1
  ret i32 %1
}

define i32 @slti(i32 %a) nounwind {
; RV32I-LABEL: slti:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slti a0, a0, 2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: slti:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    slti a0, a0, 2
; RV64I-NEXT:    ret
  %1 = icmp slt i32 %a, 2
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @sltiu(i32 %a) nounwind {
; RV32I-LABEL: sltiu:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltiu a0, a0, 3
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sltiu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    sltiu a0, a0, 3
; RV64I-NEXT:    ret
  %1 = icmp ult i32 %a, 3
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @xori(i32 %a) nounwind {
; RV32I-LABEL: xori:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xori a0, a0, 4
; RV32I-NEXT:    ret
;
; RV64I-LABEL: xori:
; RV64I:       # %bb.0:
; RV64I-NEXT:    xori a0, a0, 4
; RV64I-NEXT:    ret
  %1 = xor i32 %a, 4
  ret i32 %1
}

define i32 @ori(i32 %a) nounwind {
; RV32I-LABEL: ori:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ori a0, a0, 5
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ori:
; RV64I:       # %bb.0:
; RV64I-NEXT:    ori a0, a0, 5
; RV64I-NEXT:    ret
  %1 = or i32 %a, 5
  ret i32 %1
}

define i32 @andi(i32 %a) nounwind {
; RV32I-LABEL: andi:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 6
; RV32I-NEXT:    ret
;
; RV64I-LABEL: andi:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a0, a0, 6
; RV64I-NEXT:    ret
  %1 = and i32 %a, 6
  ret i32 %1
}

define i32 @slli(i32 %a) nounwind {
; RV32I-LABEL: slli:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 7
; RV32I-NEXT:    ret
;
; RV64I-LABEL: slli:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 7
; RV64I-NEXT:    ret
  %1 = shl i32 %a, 7
  ret i32 %1
}

define i32 @srli(i32 %a) nounwind {
; RV32I-LABEL: srli:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a0, a0, 8
; RV32I-NEXT:    ret
;
; RV64I-LABEL: srli:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srliw a0, a0, 8
; RV64I-NEXT:    ret
  %1 = lshr i32 %a, 8
  ret i32 %1
}

define i32 @srai(i32 %a) nounwind {
; RV32I-LABEL: srai:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srai a0, a0, 9
; RV32I-NEXT:    ret
;
; RV64I-LABEL: srai:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sraiw a0, a0, 9
; RV64I-NEXT:    ret
  %1 = ashr i32 %a, 9
  ret i32 %1
}

; Register-register instructions

define i32 @add(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: add:
; RV32I:       # %bb.0:
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: add:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = add i32 %a, %b
  ret i32 %1
}

define i32 @sub(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sub:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sub:
; RV64I:       # %bb.0:
; RV64I-NEXT:    subw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = sub i32 %a, %b
  ret i32 %1
}

define i32 @sll(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sll:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sll a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sll:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sllw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = shl i32 %a, %b
  ret i32 %1
}

define i32 @slt(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: slt:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slt a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: slt:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a1, a1
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    slt a0, a0, a1
; RV64I-NEXT:    ret
  %1 = icmp slt i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @sltu(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sltu:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sltu a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sltu:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a1, a1
; RV64I-NEXT:    sext.w a0, a0
; RV64I-NEXT:    sltu a0, a0, a1
; RV64I-NEXT:    ret
  %1 = icmp ult i32 %a, %b
  %2 = zext i1 %1 to i32
  ret i32 %2
}

define i32 @xor(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: xor:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: xor:
; RV64I:       # %bb.0:
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    ret
  %1 = xor i32 %a, %b
  ret i32 %1
}

define i32 @srl(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: srl:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srl a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: srl:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srlw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = lshr i32 %a, %b
  ret i32 %1
}

define i32 @sra(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: sra:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sra a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: sra:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sraw a0, a0, a1
; RV64I-NEXT:    ret
  %1 = ashr i32 %a, %b
  ret i32 %1
}

define i32 @or(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: or:
; RV32I:       # %bb.0:
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: or:
; RV64I:       # %bb.0:
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    ret
  %1 = or i32 %a, %b
  ret i32 %1
}

define i32 @and(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: and:
; RV32I:       # %bb.0:
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: and:
; RV64I:       # %bb.0:
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    ret
  %1 = and i32 %a, %b
  ret i32 %1
}
