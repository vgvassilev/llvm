; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mcpu=pwr7 -mattr=+altivec \
; RUN:     -vec-extabi -mtriple powerpc-ibm-aix-xcoff < %s | \
; RUN: FileCheck %s --check-prefixes=32BIT,LITERAL

; RUN: llc -verify-machineinstrs -mcpu=pwr7 -mattr=+altivec \
; RUN:     -vec-extabi -mtriple powerpc64-ibm-aix-xcoff < %s | \
; RUN: FileCheck %s --check-prefixes=64BIT,LITERAL

define dso_local i32 @vec_caller() {
; LITERAL:       L..CPI0_0:
; LITERAL-NEXT:    .vbyte  4, 53
; LITERAL-NEXT:    .vbyte  4, 54
; LITERAL-NEXT:    .vbyte  4, 55
; LITERAL-NEXT:    .vbyte  4, 56
; LITERAL-NEXT:  L..CPI0_1:
; LITERAL-NEXT:    .vbyte  4, 49
; LITERAL-NEXT:    .vbyte  4, 50
; LITERAL-NEXT:    .vbyte  4, 51
; LITERAL-NEXT:    .vbyte  4, 52

; 32BIT-LABEL: vec_caller:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stw 0, 8(1)
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    lwz 3, L..C0(2)
; 32BIT-NEXT:    lwz 4, L..C1(2)
; 32BIT-NEXT:    xxlxor 34, 34, 34
; 32BIT-NEXT:    xxlxor 35, 35, 35
; 32BIT-NEXT:    xxlxor 36, 36, 36
; 32BIT-NEXT:    lxvw4x 0, 0, 3
; 32BIT-NEXT:    lxvw4x 1, 0, 4
; 32BIT-NEXT:    xxlxor 37, 37, 37
; 32BIT-NEXT:    li 3, 48
; 32BIT-NEXT:    xxlxor 38, 38, 38
; 32BIT-NEXT:    li 4, 32
; 32BIT-NEXT:    xxlxor 39, 39, 39
; 32BIT-NEXT:    xxlxor 40, 40, 40
; 32BIT-NEXT:    stxvw4x 0, 1, 3
; 32BIT-NEXT:    xxlxor 41, 41, 41
; 32BIT-NEXT:    stxvw4x 1, 1, 4
; 32BIT-NEXT:    xxlxor 42, 42, 42
; 32BIT-NEXT:    xxlxor 43, 43, 43
; 32BIT-NEXT:    xxlxor 44, 44, 44
; 32BIT-NEXT:    xxlxor 45, 45, 45
; 32BIT-NEXT:    bl .vec_callee_stack[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 64
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr


; 64BIT-LABEL: vec_caller:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    std 0, 16(1)
; 64BIT-NEXT:    stdu 1, -112(1)
; 64BIT-NEXT:    ld 3, L..C0(2)
; 64BIT-NEXT:    ld 4, L..C1(2)
; 64BIT-NEXT:    xxlxor 34, 34, 34
; 64BIT-NEXT:    xxlxor 35, 35, 35
; 64BIT-NEXT:    xxlxor 36, 36, 36
; 64BIT-NEXT:    lxvw4x 0, 0, 3
; 64BIT-NEXT:    lxvw4x 1, 0, 4
; 64BIT-NEXT:    xxlxor 37, 37, 37
; 64BIT-NEXT:    li 3, 64
; 64BIT-NEXT:    xxlxor 38, 38, 38
; 64BIT-NEXT:    li 4, 48
; 64BIT-NEXT:    xxlxor 39, 39, 39
; 64BIT-NEXT:    xxlxor 40, 40, 40
; 64BIT-NEXT:    stxvw4x 0, 1, 3
; 64BIT-NEXT:    xxlxor 41, 41, 41
; 64BIT-NEXT:    stxvw4x 1, 1, 4
; 64BIT-NEXT:    xxlxor 42, 42, 42
; 64BIT-NEXT:    xxlxor 43, 43, 43
; 64BIT-NEXT:    xxlxor 44, 44, 44
; 64BIT-NEXT:    xxlxor 45, 45, 45
; 64BIT-NEXT:    bl .vec_callee_stack[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 112
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr

; LITERAL:         .toc
; LITERAL:       L..C0:
; LITERAL-NEXT:    .tc L..CPI0_0[TC],L..CPI0_0
; LITERAL-NEXT:  L..C1:
; LITERAL-NEXT:    .tc L..CPI0_1[TC],L..CPI0_1

entry:
  %call = call i32 bitcast (i32 (...)* @vec_callee_stack to i32 (<4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>, <4 x i32>)*)(<4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 0, i32 0, i32 0, i32 0>, <4 x i32> <i32 49, i32 50, i32 51, i32 52>, <4 x i32> <i32 53, i32 54, i32 55, i32 56>)
  ret i32 %call
}

declare i32 @vec_callee_stack(...)
