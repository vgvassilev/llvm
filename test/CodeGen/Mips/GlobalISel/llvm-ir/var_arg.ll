; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc  -O0 -mtriple=mipsel-linux-gnu -global-isel  -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32

@.str = private unnamed_addr constant [11 x i8] c"string %s\0A\00", align 1
declare void @llvm.va_start(i8*)
declare void @llvm.va_copy(i8*, i8*)
declare i32 @printf(i8*, ...)

define void @testVaCopyArg(i8* %fmt, ...) {
; MIPS32-LABEL: testVaCopyArg:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $sp, $sp, -40
; MIPS32-NEXT:    .cfi_def_cfa_offset 40
; MIPS32-NEXT:    sw $ra, 36($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    .cfi_offset 31, -4
; MIPS32-NEXT:    move $3, $4
; MIPS32-NEXT:    addiu $1, $sp, 44
; MIPS32-NEXT:    sw $5, 0($1)
; MIPS32-NEXT:    addiu $1, $sp, 48
; MIPS32-NEXT:    sw $6, 0($1)
; MIPS32-NEXT:    addiu $1, $sp, 52
; MIPS32-NEXT:    sw $7, 0($1)
; MIPS32-NEXT:    lui $1, %hi($.str)
; MIPS32-NEXT:    addiu $4, $1, %lo($.str)
; MIPS32-NEXT:    addiu $6, $sp, 32
; MIPS32-NEXT:    addiu $2, $sp, 28
; MIPS32-NEXT:    addiu $5, $sp, 24
; MIPS32-NEXT:    addiu $1, $sp, 20
; MIPS32-NEXT:    sw $3, 0($6)
; MIPS32-NEXT:    addiu $3, $sp, 44
; MIPS32-NEXT:    sw $3, 0($2)
; MIPS32-NEXT:    lw $2, 0($2)
; MIPS32-NEXT:    sw $2, 0($5)
; MIPS32-NEXT:    lw $2, 0($5)
; MIPS32-NEXT:    ori $3, $zero, 4
; MIPS32-NEXT:    addu $3, $2, $3
; MIPS32-NEXT:    sw $3, 0($5)
; MIPS32-NEXT:    lw $2, 0($2)
; MIPS32-NEXT:    sw $2, 0($1)
; MIPS32-NEXT:    lw $5, 0($1)
; MIPS32-NEXT:    jal printf
; MIPS32-NEXT:    nop
; MIPS32-NEXT:    lw $ra, 36($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 40
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %fmt.addr = alloca i8*, align 4
  %ap = alloca i8*, align 4
  %aq = alloca i8*, align 4
  %s = alloca i8*, align 4
  store i8* %fmt, i8** %fmt.addr, align 4
  %ap1 = bitcast i8** %ap to i8*
  call void @llvm.va_start(i8* %ap1)
  %0 = bitcast i8** %aq to i8*
  %1 = bitcast i8** %ap to i8*
  call void @llvm.va_copy(i8* %0, i8* %1)
  %argp.cur = load i8*, i8** %aq, align 4
  %argp.next = getelementptr inbounds i8, i8* %argp.cur, i32 4
  store i8* %argp.next, i8** %aq, align 4
  %2 = bitcast i8* %argp.cur to i8**
  %3 = load i8*, i8** %2, align 4
  store i8* %3, i8** %s, align 4
  %4 = load i8*, i8** %s, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0), i8* %4)
  ret void
}
