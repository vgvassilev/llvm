; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown | FileCheck %s --check-prefixes=CHECK,X86,X86-FAST
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+slow-shld | FileCheck %s --check-prefixes=CHECK,X86,X86-SLOW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefixes=CHECK,X64,X64-FAST
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+slow-shld | FileCheck %s --check-prefixes=CHECK,X64,X64-SLOW

declare i8 @llvm.fshl.i8(i8, i8, i8) nounwind readnone
declare i16 @llvm.fshl.i16(i16, i16, i16) nounwind readnone
declare i32 @llvm.fshl.i32(i32, i32, i32) nounwind readnone
declare i64 @llvm.fshl.i64(i64, i64, i64) nounwind readnone

;
; Variable Funnel Shift
;

define i8 @var_shift_i8(i8 %x, i8 %y, i8 %z) nounwind {
; X86-LABEL: var_shift_i8:
; X86:       # %bb.0:
; X86-NEXT:    movb {{[0-9]+}}(%esp), %ah
; X86-NEXT:    movb {{[0-9]+}}(%esp), %al
; X86-NEXT:    movb {{[0-9]+}}(%esp), %dl
; X86-NEXT:    andb $7, %dl
; X86-NEXT:    movb %al, %ch
; X86-NEXT:    movb %dl, %cl
; X86-NEXT:    shlb %cl, %ch
; X86-NEXT:    movb $8, %cl
; X86-NEXT:    subb %dl, %cl
; X86-NEXT:    shrb %cl, %ah
; X86-NEXT:    testb %dl, %dl
; X86-NEXT:    je .LBB0_2
; X86-NEXT:  # %bb.1:
; X86-NEXT:    orb %ah, %ch
; X86-NEXT:    movb %ch, %al
; X86-NEXT:  .LBB0_2:
; X86-NEXT:    retl
;
; X64-LABEL: var_shift_i8:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    andb $7, %dl
; X64-NEXT:    movl %edx, %ecx
; X64-NEXT:    shlb %cl, %dil
; X64-NEXT:    movb $8, %cl
; X64-NEXT:    subb %dl, %cl
; X64-NEXT:    shrb %cl, %sil
; X64-NEXT:    testb %dl, %dl
; X64-NEXT:    je .LBB0_2
; X64-NEXT:  # %bb.1:
; X64-NEXT:    orb %sil, %dil
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:  .LBB0_2:
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %tmp = tail call i8 @llvm.fshl.i8(i8 %x, i8 %y, i8 %z)
  ret i8 %tmp
}

define i16 @var_shift_i16(i16 %x, i16 %y, i16 %z) nounwind {
; X86-FAST-LABEL: var_shift_i16:
; X86-FAST:       # %bb.0:
; X86-FAST-NEXT:    movzwl {{[0-9]+}}(%esp), %edx
; X86-FAST-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-FAST-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X86-FAST-NEXT:    andb $15, %cl
; X86-FAST-NEXT:    shldw %cl, %dx, %ax
; X86-FAST-NEXT:    retl
;
; X86-SLOW-LABEL: var_shift_i16:
; X86-SLOW:       # %bb.0:
; X86-SLOW-NEXT:    pushl %edi
; X86-SLOW-NEXT:    pushl %esi
; X86-SLOW-NEXT:    movzwl {{[0-9]+}}(%esp), %esi
; X86-SLOW-NEXT:    movb {{[0-9]+}}(%esp), %dl
; X86-SLOW-NEXT:    andb $15, %dl
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SLOW-NEXT:    movl %eax, %edi
; X86-SLOW-NEXT:    movl %edx, %ecx
; X86-SLOW-NEXT:    shll %cl, %edi
; X86-SLOW-NEXT:    movb $16, %cl
; X86-SLOW-NEXT:    subb %dl, %cl
; X86-SLOW-NEXT:    shrl %cl, %esi
; X86-SLOW-NEXT:    testb %dl, %dl
; X86-SLOW-NEXT:    je .LBB1_2
; X86-SLOW-NEXT:  # %bb.1:
; X86-SLOW-NEXT:    orl %esi, %edi
; X86-SLOW-NEXT:    movl %edi, %eax
; X86-SLOW-NEXT:  .LBB1_2:
; X86-SLOW-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-SLOW-NEXT:    popl %esi
; X86-SLOW-NEXT:    popl %edi
; X86-SLOW-NEXT:    retl
;
; X64-FAST-LABEL: var_shift_i16:
; X64-FAST:       # %bb.0:
; X64-FAST-NEXT:    movl %edx, %ecx
; X64-FAST-NEXT:    movl %edi, %eax
; X64-FAST-NEXT:    andb $15, %cl
; X64-FAST-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-FAST-NEXT:    shldw %cl, %si, %ax
; X64-FAST-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-FAST-NEXT:    retq
;
; X64-SLOW-LABEL: var_shift_i16:
; X64-SLOW:       # %bb.0:
; X64-SLOW-NEXT:    movzwl %si, %eax
; X64-SLOW-NEXT:    andb $15, %dl
; X64-SLOW-NEXT:    movl %edi, %esi
; X64-SLOW-NEXT:    movl %edx, %ecx
; X64-SLOW-NEXT:    shll %cl, %esi
; X64-SLOW-NEXT:    movb $16, %cl
; X64-SLOW-NEXT:    subb %dl, %cl
; X64-SLOW-NEXT:    shrl %cl, %eax
; X64-SLOW-NEXT:    orl %esi, %eax
; X64-SLOW-NEXT:    testb %dl, %dl
; X64-SLOW-NEXT:    cmovel %edi, %eax
; X64-SLOW-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-SLOW-NEXT:    retq
  %tmp = tail call i16 @llvm.fshl.i16(i16 %x, i16 %y, i16 %z)
  ret i16 %tmp
}

define i32 @var_shift_i32(i32 %x, i32 %y, i32 %z) nounwind {
; X86-FAST-LABEL: var_shift_i32:
; X86-FAST:       # %bb.0:
; X86-FAST-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-FAST-NEXT:    shldl %cl, %edx, %eax
; X86-FAST-NEXT:    retl
;
; X86-SLOW-LABEL: var_shift_i32:
; X86-SLOW:       # %bb.0:
; X86-SLOW-NEXT:    pushl %edi
; X86-SLOW-NEXT:    pushl %esi
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-SLOW-NEXT:    movb {{[0-9]+}}(%esp), %dl
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SLOW-NEXT:    movl %eax, %edi
; X86-SLOW-NEXT:    movl %edx, %ecx
; X86-SLOW-NEXT:    shll %cl, %edi
; X86-SLOW-NEXT:    andb $31, %dl
; X86-SLOW-NEXT:    movl %edx, %ecx
; X86-SLOW-NEXT:    negb %cl
; X86-SLOW-NEXT:    shrl %cl, %esi
; X86-SLOW-NEXT:    testb %dl, %dl
; X86-SLOW-NEXT:    je .LBB2_2
; X86-SLOW-NEXT:  # %bb.1:
; X86-SLOW-NEXT:    orl %esi, %edi
; X86-SLOW-NEXT:    movl %edi, %eax
; X86-SLOW-NEXT:  .LBB2_2:
; X86-SLOW-NEXT:    popl %esi
; X86-SLOW-NEXT:    popl %edi
; X86-SLOW-NEXT:    retl
;
; X64-FAST-LABEL: var_shift_i32:
; X64-FAST:       # %bb.0:
; X64-FAST-NEXT:    movl %edx, %ecx
; X64-FAST-NEXT:    movl %edi, %eax
; X64-FAST-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-FAST-NEXT:    shldl %cl, %esi, %eax
; X64-FAST-NEXT:    retq
;
; X64-SLOW-LABEL: var_shift_i32:
; X64-SLOW:       # %bb.0:
; X64-SLOW-NEXT:    movl %esi, %eax
; X64-SLOW-NEXT:    movl %edi, %esi
; X64-SLOW-NEXT:    movl %edx, %ecx
; X64-SLOW-NEXT:    shll %cl, %esi
; X64-SLOW-NEXT:    andb $31, %dl
; X64-SLOW-NEXT:    movl %edx, %ecx
; X64-SLOW-NEXT:    negb %cl
; X64-SLOW-NEXT:    shrl %cl, %eax
; X64-SLOW-NEXT:    orl %esi, %eax
; X64-SLOW-NEXT:    testb %dl, %dl
; X64-SLOW-NEXT:    cmovel %edi, %eax
; X64-SLOW-NEXT:    retq
  %tmp = tail call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 %z)
  ret i32 %tmp
}

define i64 @var_shift_i64(i64 %x, i64 %y, i64 %z) nounwind {
; X86-FAST-LABEL: var_shift_i64:
; X86-FAST:       # %bb.0:
; X86-FAST-NEXT:    pushl %ebp
; X86-FAST-NEXT:    pushl %ebx
; X86-FAST-NEXT:    pushl %edi
; X86-FAST-NEXT:    pushl %esi
; X86-FAST-NEXT:    pushl %eax
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-FAST-NEXT:    movl %eax, (%esp) # 4-byte Spill
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %ebp
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-FAST-NEXT:    andl $63, %ebx
; X86-FAST-NEXT:    movl %eax, %edi
; X86-FAST-NEXT:    movl %ebx, %ecx
; X86-FAST-NEXT:    shll %cl, %edi
; X86-FAST-NEXT:    shldl %cl, %eax, %ebp
; X86-FAST-NEXT:    testb $32, %bl
; X86-FAST-NEXT:    je .LBB3_2
; X86-FAST-NEXT:  # %bb.1:
; X86-FAST-NEXT:    movl %edi, %ebp
; X86-FAST-NEXT:    xorl %edi, %edi
; X86-FAST-NEXT:  .LBB3_2:
; X86-FAST-NEXT:    movb $64, %cl
; X86-FAST-NEXT:    subb %bl, %cl
; X86-FAST-NEXT:    movl %edx, %esi
; X86-FAST-NEXT:    shrl %cl, %esi
; X86-FAST-NEXT:    shrdl %cl, %edx, (%esp) # 4-byte Folded Spill
; X86-FAST-NEXT:    testb $32, %cl
; X86-FAST-NEXT:    jne .LBB3_3
; X86-FAST-NEXT:  # %bb.4:
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-FAST-NEXT:    movl (%esp), %ecx # 4-byte Reload
; X86-FAST-NEXT:    testl %ebx, %ebx
; X86-FAST-NEXT:    jne .LBB3_6
; X86-FAST-NEXT:    jmp .LBB3_7
; X86-FAST-NEXT:  .LBB3_3:
; X86-FAST-NEXT:    movl %esi, %ecx
; X86-FAST-NEXT:    xorl %esi, %esi
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-FAST-NEXT:    testl %ebx, %ebx
; X86-FAST-NEXT:    je .LBB3_7
; X86-FAST-NEXT:  .LBB3_6:
; X86-FAST-NEXT:    orl %esi, %ebp
; X86-FAST-NEXT:    orl %ecx, %edi
; X86-FAST-NEXT:    movl %edi, %eax
; X86-FAST-NEXT:    movl %ebp, %edx
; X86-FAST-NEXT:  .LBB3_7:
; X86-FAST-NEXT:    addl $4, %esp
; X86-FAST-NEXT:    popl %esi
; X86-FAST-NEXT:    popl %edi
; X86-FAST-NEXT:    popl %ebx
; X86-FAST-NEXT:    popl %ebp
; X86-FAST-NEXT:    retl
;
; X86-SLOW-LABEL: var_shift_i64:
; X86-SLOW:       # %bb.0:
; X86-SLOW-NEXT:    pushl %ebp
; X86-SLOW-NEXT:    pushl %ebx
; X86-SLOW-NEXT:    pushl %edi
; X86-SLOW-NEXT:    pushl %esi
; X86-SLOW-NEXT:    subl $8, %esp
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-SLOW-NEXT:    andl $63, %ebx
; X86-SLOW-NEXT:    movb $64, %dh
; X86-SLOW-NEXT:    subb %bl, %dh
; X86-SLOW-NEXT:    movl %eax, (%esp) # 4-byte Spill
; X86-SLOW-NEXT:    movb %dh, %cl
; X86-SLOW-NEXT:    shrl %cl, %eax
; X86-SLOW-NEXT:    movb %dh, %dl
; X86-SLOW-NEXT:    andb $31, %dl
; X86-SLOW-NEXT:    movl %edx, %ecx
; X86-SLOW-NEXT:    negb %cl
; X86-SLOW-NEXT:    movl %esi, %ebp
; X86-SLOW-NEXT:    shll %cl, %ebp
; X86-SLOW-NEXT:    testb %dl, %dl
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SLOW-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-SLOW-NEXT:    je .LBB3_2
; X86-SLOW-NEXT:  # %bb.1:
; X86-SLOW-NEXT:    orl %eax, %ebp
; X86-SLOW-NEXT:    movl %ebp, (%esp) # 4-byte Spill
; X86-SLOW-NEXT:  .LBB3_2:
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %ebp
; X86-SLOW-NEXT:    movl %ebp, %eax
; X86-SLOW-NEXT:    movl %ebx, %ecx
; X86-SLOW-NEXT:    shll %cl, %eax
; X86-SLOW-NEXT:    movb %bl, %ch
; X86-SLOW-NEXT:    andb $31, %ch
; X86-SLOW-NEXT:    movb %ch, %cl
; X86-SLOW-NEXT:    negb %cl
; X86-SLOW-NEXT:    shrl %cl, %edi
; X86-SLOW-NEXT:    testb %ch, %ch
; X86-SLOW-NEXT:    je .LBB3_4
; X86-SLOW-NEXT:  # %bb.3:
; X86-SLOW-NEXT:    orl %edi, %eax
; X86-SLOW-NEXT:    movl %eax, %ebp
; X86-SLOW-NEXT:  .LBB3_4:
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SLOW-NEXT:    movl %eax, %edi
; X86-SLOW-NEXT:    movl %ebx, %ecx
; X86-SLOW-NEXT:    shll %cl, %edi
; X86-SLOW-NEXT:    testb $32, %bl
; X86-SLOW-NEXT:    je .LBB3_6
; X86-SLOW-NEXT:  # %bb.5:
; X86-SLOW-NEXT:    movl %edi, %ebp
; X86-SLOW-NEXT:    xorl %edi, %edi
; X86-SLOW-NEXT:  .LBB3_6:
; X86-SLOW-NEXT:    movb %dh, %cl
; X86-SLOW-NEXT:    shrl %cl, %esi
; X86-SLOW-NEXT:    testb $32, %dh
; X86-SLOW-NEXT:    jne .LBB3_7
; X86-SLOW-NEXT:  # %bb.8:
; X86-SLOW-NEXT:    movl (%esp), %ecx # 4-byte Reload
; X86-SLOW-NEXT:    testl %ebx, %ebx
; X86-SLOW-NEXT:    jne .LBB3_10
; X86-SLOW-NEXT:    jmp .LBB3_11
; X86-SLOW-NEXT:  .LBB3_7:
; X86-SLOW-NEXT:    movl %esi, %ecx
; X86-SLOW-NEXT:    xorl %esi, %esi
; X86-SLOW-NEXT:    testl %ebx, %ebx
; X86-SLOW-NEXT:    je .LBB3_11
; X86-SLOW-NEXT:  .LBB3_10:
; X86-SLOW-NEXT:    orl %esi, %ebp
; X86-SLOW-NEXT:    orl %ecx, %edi
; X86-SLOW-NEXT:    movl %ebp, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X86-SLOW-NEXT:    movl %edi, %eax
; X86-SLOW-NEXT:  .LBB3_11:
; X86-SLOW-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X86-SLOW-NEXT:    addl $8, %esp
; X86-SLOW-NEXT:    popl %esi
; X86-SLOW-NEXT:    popl %edi
; X86-SLOW-NEXT:    popl %ebx
; X86-SLOW-NEXT:    popl %ebp
; X86-SLOW-NEXT:    retl
;
; X64-FAST-LABEL: var_shift_i64:
; X64-FAST:       # %bb.0:
; X64-FAST-NEXT:    movq %rdx, %rcx
; X64-FAST-NEXT:    movq %rdi, %rax
; X64-FAST-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-FAST-NEXT:    shldq %cl, %rsi, %rax
; X64-FAST-NEXT:    retq
;
; X64-SLOW-LABEL: var_shift_i64:
; X64-SLOW:       # %bb.0:
; X64-SLOW-NEXT:    movq %rsi, %rax
; X64-SLOW-NEXT:    movq %rdi, %rsi
; X64-SLOW-NEXT:    movl %edx, %ecx
; X64-SLOW-NEXT:    shlq %cl, %rsi
; X64-SLOW-NEXT:    andb $63, %dl
; X64-SLOW-NEXT:    movl %edx, %ecx
; X64-SLOW-NEXT:    negb %cl
; X64-SLOW-NEXT:    shrq %cl, %rax
; X64-SLOW-NEXT:    orq %rsi, %rax
; X64-SLOW-NEXT:    testb %dl, %dl
; X64-SLOW-NEXT:    cmoveq %rdi, %rax
; X64-SLOW-NEXT:    retq
  %tmp = tail call i64 @llvm.fshl.i64(i64 %x, i64 %y, i64 %z)
  ret i64 %tmp
}

;
; Const Funnel Shift
;

define i8 @const_shift_i8(i8 %x, i8 %y) nounwind {
; X86-LABEL: const_shift_i8:
; X86:       # %bb.0:
; X86-NEXT:    movb {{[0-9]+}}(%esp), %al
; X86-NEXT:    movb {{[0-9]+}}(%esp), %cl
; X86-NEXT:    shrb %cl
; X86-NEXT:    shlb $7, %al
; X86-NEXT:    orb %cl, %al
; X86-NEXT:    retl
;
; X64-LABEL: const_shift_i8:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %eax
; X64-NEXT:    shrb %sil
; X64-NEXT:    shlb $7, %al
; X64-NEXT:    orb %sil, %al
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %tmp = tail call i8 @llvm.fshl.i8(i8 %x, i8 %y, i8 7)
  ret i8 %tmp
}

define i16 @const_shift_i16(i16 %x, i16 %y) nounwind {
; X86-FAST-LABEL: const_shift_i16:
; X86-FAST:       # %bb.0:
; X86-FAST-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-FAST-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-FAST-NEXT:    shldw $7, %cx, %ax
; X86-FAST-NEXT:    retl
;
; X86-SLOW-LABEL: const_shift_i16:
; X86-SLOW:       # %bb.0:
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SLOW-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-SLOW-NEXT:    shrl $9, %ecx
; X86-SLOW-NEXT:    shll $7, %eax
; X86-SLOW-NEXT:    orl %ecx, %eax
; X86-SLOW-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-SLOW-NEXT:    retl
;
; X64-FAST-LABEL: const_shift_i16:
; X64-FAST:       # %bb.0:
; X64-FAST-NEXT:    movl %edi, %eax
; X64-FAST-NEXT:    shldw $7, %si, %ax
; X64-FAST-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-FAST-NEXT:    retq
;
; X64-SLOW-LABEL: const_shift_i16:
; X64-SLOW:       # %bb.0:
; X64-SLOW-NEXT:    movzwl %si, %eax
; X64-SLOW-NEXT:    shll $7, %edi
; X64-SLOW-NEXT:    shrl $9, %eax
; X64-SLOW-NEXT:    orl %edi, %eax
; X64-SLOW-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-SLOW-NEXT:    retq
  %tmp = tail call i16 @llvm.fshl.i16(i16 %x, i16 %y, i16 7)
  ret i16 %tmp
}

define i32 @const_shift_i32(i32 %x, i32 %y) nounwind {
; X86-FAST-LABEL: const_shift_i32:
; X86-FAST:       # %bb.0:
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-FAST-NEXT:    shldl $7, %ecx, %eax
; X86-FAST-NEXT:    retl
;
; X86-SLOW-LABEL: const_shift_i32:
; X86-SLOW:       # %bb.0:
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SLOW-NEXT:    shrl $25, %ecx
; X86-SLOW-NEXT:    shll $7, %eax
; X86-SLOW-NEXT:    orl %ecx, %eax
; X86-SLOW-NEXT:    retl
;
; X64-FAST-LABEL: const_shift_i32:
; X64-FAST:       # %bb.0:
; X64-FAST-NEXT:    movl %edi, %eax
; X64-FAST-NEXT:    shldl $7, %esi, %eax
; X64-FAST-NEXT:    retq
;
; X64-SLOW-LABEL: const_shift_i32:
; X64-SLOW:       # %bb.0:
; X64-SLOW-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-SLOW-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-SLOW-NEXT:    shrl $25, %esi
; X64-SLOW-NEXT:    shll $7, %edi
; X64-SLOW-NEXT:    leal (%rdi,%rsi), %eax
; X64-SLOW-NEXT:    retq
  %tmp = tail call i32 @llvm.fshl.i32(i32 %x, i32 %y, i32 7)
  ret i32 %tmp
}

define i64 @const_shift_i64(i64 %x, i64 %y) nounwind {
; X86-FAST-LABEL: const_shift_i64:
; X86-FAST:       # %bb.0:
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-FAST-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-FAST-NEXT:    shrdl $25, %ecx, %eax
; X86-FAST-NEXT:    shldl $7, %ecx, %edx
; X86-FAST-NEXT:    retl
;
; X86-SLOW-LABEL: const_shift_i64:
; X86-SLOW:       # %bb.0:
; X86-SLOW-NEXT:    pushl %esi
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-SLOW-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-SLOW-NEXT:    shrl $25, %esi
; X86-SLOW-NEXT:    movl %ecx, %eax
; X86-SLOW-NEXT:    shll $7, %eax
; X86-SLOW-NEXT:    orl %esi, %eax
; X86-SLOW-NEXT:    shrl $25, %ecx
; X86-SLOW-NEXT:    shll $7, %edx
; X86-SLOW-NEXT:    orl %ecx, %edx
; X86-SLOW-NEXT:    popl %esi
; X86-SLOW-NEXT:    retl
;
; X64-FAST-LABEL: const_shift_i64:
; X64-FAST:       # %bb.0:
; X64-FAST-NEXT:    movq %rdi, %rax
; X64-FAST-NEXT:    shldq $7, %rsi, %rax
; X64-FAST-NEXT:    retq
;
; X64-SLOW-LABEL: const_shift_i64:
; X64-SLOW:       # %bb.0:
; X64-SLOW-NEXT:    shrq $57, %rsi
; X64-SLOW-NEXT:    shlq $7, %rdi
; X64-SLOW-NEXT:    leaq (%rdi,%rsi), %rax
; X64-SLOW-NEXT:    retq
  %tmp = tail call i64 @llvm.fshl.i64(i64 %x, i64 %y, i64 7)
  ret i64 %tmp
}
