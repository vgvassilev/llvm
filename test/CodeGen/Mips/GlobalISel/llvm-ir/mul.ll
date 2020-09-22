; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc  -O0 -mtriple=mipsel-linux-gnu -global-isel  -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32
define i32 @mul_i32(i32 %x, i32 %y) {
; MIPS32-LABEL: mul_i32:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $2, $4, $5
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %z = mul i32 %x, %y
  ret i32 %z
}

define signext i8 @mul_i8_sext(i8 signext %a, i8 signext %b) {
; MIPS32-LABEL: mul_i8_sext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $1, $5, $4
; MIPS32-NEXT:    sll $1, $1, 24
; MIPS32-NEXT:    sra $2, $1, 24
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i8 %b, %a
  ret i8 %mul
}

define zeroext i8 @mul_i8_zext(i8 zeroext %a, i8 zeroext %b) {
; MIPS32-LABEL: mul_i8_zext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $1, $5, $4
; MIPS32-NEXT:    andi $2, $1, 255
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i8 %b, %a
  ret i8 %mul
}

define i8 @mul_i8_aext(i8 %a, i8 %b) {
; MIPS32-LABEL: mul_i8_aext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $2, $5, $4
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i8 %b, %a
  ret i8 %mul
}

define signext i16 @mul_i16_sext(i16 signext %a, i16 signext %b) {
; MIPS32-LABEL: mul_i16_sext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $1, $5, $4
; MIPS32-NEXT:    sll $1, $1, 16
; MIPS32-NEXT:    sra $2, $1, 16
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i16 %b, %a
  ret i16 %mul
}

define zeroext i16 @mul_i16_zext(i16 zeroext %a, i16 zeroext %b) {
; MIPS32-LABEL: mul_i16_zext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $1, $5, $4
; MIPS32-NEXT:    andi $2, $1, 65535
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i16 %b, %a
  ret i16 %mul
}

define i16 @mul_i16_aext(i16 %a, i16 %b) {
; MIPS32-LABEL: mul_i16_aext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $2, $5, $4
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i16 %b, %a
  ret i16 %mul
}

define i64 @mul_i64(i64 %a, i64 %b) {
; MIPS32-LABEL: mul_i64:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    move $3, $4
; MIPS32-NEXT:    mul $2, $6, $3
; MIPS32-NEXT:    mul $1, $7, $3
; MIPS32-NEXT:    mul $4, $6, $5
; MIPS32-NEXT:    multu $6, $3
; MIPS32-NEXT:    mfhi $3
; MIPS32-NEXT:    addu $1, $1, $4
; MIPS32-NEXT:    addu $3, $1, $3
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i64 %b, %a
  ret i64 %mul
}

define i128 @mul_i128(i128 %a, i128 %b) {
; MIPS32-LABEL: mul_i128:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    move $14, $4
; MIPS32-NEXT:    move $13, $5
; MIPS32-NEXT:    move $12, $6
; MIPS32-NEXT:    move $9, $7
; MIPS32-NEXT:    addiu $1, $sp, 16
; MIPS32-NEXT:    lw $6, 0($1)
; MIPS32-NEXT:    addiu $1, $sp, 20
; MIPS32-NEXT:    lw $7, 0($1)
; MIPS32-NEXT:    addiu $1, $sp, 24
; MIPS32-NEXT:    lw $8, 0($1)
; MIPS32-NEXT:    addiu $1, $sp, 28
; MIPS32-NEXT:    lw $1, 0($1)
; MIPS32-NEXT:    mul $2, $6, $14
; MIPS32-NEXT:    mul $3, $7, $14
; MIPS32-NEXT:    mul $4, $6, $13
; MIPS32-NEXT:    multu $6, $14
; MIPS32-NEXT:    mfhi $5
; MIPS32-NEXT:    addu $3, $3, $4
; MIPS32-NEXT:    sltu $4, $3, $4
; MIPS32-NEXT:    andi $4, $4, 1
; MIPS32-NEXT:    addu $3, $3, $5
; MIPS32-NEXT:    sltu $5, $3, $5
; MIPS32-NEXT:    andi $5, $5, 1
; MIPS32-NEXT:    addu $10, $4, $5
; MIPS32-NEXT:    mul $4, $8, $14
; MIPS32-NEXT:    mul $5, $7, $13
; MIPS32-NEXT:    mul $24, $6, $12
; MIPS32-NEXT:    multu $7, $14
; MIPS32-NEXT:    mfhi $15
; MIPS32-NEXT:    multu $6, $13
; MIPS32-NEXT:    mfhi $11
; MIPS32-NEXT:    addu $4, $4, $5
; MIPS32-NEXT:    sltu $5, $4, $5
; MIPS32-NEXT:    andi $5, $5, 1
; MIPS32-NEXT:    addu $4, $4, $24
; MIPS32-NEXT:    sltu $24, $4, $24
; MIPS32-NEXT:    andi $24, $24, 1
; MIPS32-NEXT:    addu $5, $5, $24
; MIPS32-NEXT:    addu $4, $4, $15
; MIPS32-NEXT:    sltu $15, $4, $15
; MIPS32-NEXT:    andi $15, $15, 1
; MIPS32-NEXT:    addu $5, $5, $15
; MIPS32-NEXT:    addu $4, $4, $11
; MIPS32-NEXT:    sltu $11, $4, $11
; MIPS32-NEXT:    andi $11, $11, 1
; MIPS32-NEXT:    addu $5, $5, $11
; MIPS32-NEXT:    addu $4, $4, $10
; MIPS32-NEXT:    sltu $10, $4, $10
; MIPS32-NEXT:    andi $10, $10, 1
; MIPS32-NEXT:    addu $5, $5, $10
; MIPS32-NEXT:    mul $1, $1, $14
; MIPS32-NEXT:    mul $11, $8, $13
; MIPS32-NEXT:    mul $10, $7, $12
; MIPS32-NEXT:    mul $9, $6, $9
; MIPS32-NEXT:    multu $8, $14
; MIPS32-NEXT:    mfhi $8
; MIPS32-NEXT:    multu $7, $13
; MIPS32-NEXT:    mfhi $7
; MIPS32-NEXT:    multu $6, $12
; MIPS32-NEXT:    mfhi $6
; MIPS32-NEXT:    addu $1, $1, $11
; MIPS32-NEXT:    addu $1, $1, $10
; MIPS32-NEXT:    addu $1, $1, $9
; MIPS32-NEXT:    addu $1, $1, $8
; MIPS32-NEXT:    addu $1, $1, $7
; MIPS32-NEXT:    addu $1, $1, $6
; MIPS32-NEXT:    addu $5, $1, $5
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i128 %b, %a
  ret i128 %mul
}

declare { i32, i1 } @llvm.umul.with.overflow.i32(i32, i32)
define void @umul_with_overflow(i32 %lhs, i32 %rhs, i32* %pmul, i1* %pcarry_flag) {
; MIPS32-LABEL: umul_with_overflow:
; MIPS32:       # %bb.0:
; MIPS32-NEXT:    multu $4, $5
; MIPS32-NEXT:    mfhi $2
; MIPS32-NEXT:    mul $1, $4, $5
; MIPS32-NEXT:    sltu $2, $zero, $2
; MIPS32-NEXT:    andi $2, $2, 1
; MIPS32-NEXT:    sb $2, 0($7)
; MIPS32-NEXT:    sw $1, 0($6)
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
  %res = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 %lhs, i32 %rhs)
  %carry_flag = extractvalue { i32, i1 } %res, 1
  %mul = extractvalue { i32, i1 } %res, 0
  store i1 %carry_flag, i1* %pcarry_flag
  store i32 %mul, i32* %pmul
  ret void
}
