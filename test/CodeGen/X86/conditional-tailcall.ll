; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-linux   -show-mc-encoding | FileCheck %s --check-prefix=CHECK --check-prefix=CHECK32
; RUN: llc < %s -mtriple=x86_64-linux -show-mc-encoding | FileCheck %s --check-prefix=CHECK --check-prefix=CHECK64
; RUN: llc < %s -mtriple=x86_64-win32 -show-mc-encoding | FileCheck %s --check-prefix=CHECK --check-prefix=WIN64

declare void @foo()
declare void @bar()

define void @f(i32 %x, i32 %y) optsize {
; CHECK32-LABEL: f:
; CHECK32:       # %bb.0: # %entry
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; CHECK32-NEXT:    cmpl {{[0-9]+}}(%esp), %eax # encoding: [0x3b,0x44,0x24,0x08]
; CHECK32-NEXT:    jne bar # TAILCALL
; CHECK32-NEXT:    # encoding: [0x75,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: bar-1, kind: FK_PCRel_1
; CHECK32-NEXT:  # %bb.1: # %bb1
; CHECK32-NEXT:    jmp foo # TAILCALL
; CHECK32-NEXT:    # encoding: [0xeb,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: foo-1, kind: FK_PCRel_1
;
; CHECK64-LABEL: f:
; CHECK64:       # %bb.0: # %entry
; CHECK64-NEXT:    cmpl %esi, %edi # encoding: [0x39,0xf7]
; CHECK64-NEXT:    jne bar # TAILCALL
; CHECK64-NEXT:    # encoding: [0x75,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: bar-1, kind: FK_PCRel_1
; CHECK64-NEXT:  # %bb.1: # %bb1
; CHECK64-NEXT:    jmp foo # TAILCALL
; CHECK64-NEXT:    # encoding: [0xeb,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: foo-1, kind: FK_PCRel_1
;
; WIN64-LABEL: f:
; WIN64:       # %bb.0: # %entry
; WIN64-NEXT:    cmpl %edx, %ecx # encoding: [0x39,0xd1]
; WIN64-NEXT:    jne bar # TAILCALL
; WIN64-NEXT:    # encoding: [0x75,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: bar-1, kind: FK_PCRel_1
; WIN64-NEXT:  # %bb.1: # %bb1
; WIN64-NEXT:    jmp foo # TAILCALL
; WIN64-NEXT:    # encoding: [0xeb,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: foo-1, kind: FK_PCRel_1
entry:
	%p = icmp eq i32 %x, %y
  br i1 %p, label %bb1, label %bb2
bb1:
  tail call void @foo()
  ret void
bb2:
  tail call void @bar()
  ret void

; Check that the asm doesn't just look good, but uses the correct encoding.
}

define void @f_non_leaf(i32 %x, i32 %y) optsize {
; CHECK32-LABEL: f_non_leaf:
; CHECK32:       # %bb.0: # %entry
; CHECK32-NEXT:    pushl %ebx # encoding: [0x53]
; CHECK32-NEXT:    .cfi_def_cfa_offset 8
; CHECK32-NEXT:    .cfi_offset %ebx, -8
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; CHECK32-NEXT:    #APP
; CHECK32-NEXT:    #NO_APP
; CHECK32-NEXT:    cmpl {{[0-9]+}}(%esp), %eax # encoding: [0x3b,0x44,0x24,0x0c]
; CHECK32-NEXT:    jne .LBB1_2 # encoding: [0x75,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB1_2-1, kind: FK_PCRel_1
; CHECK32-NEXT:  # %bb.1: # %bb1
; CHECK32-NEXT:    popl %ebx # encoding: [0x5b]
; CHECK32-NEXT:    .cfi_def_cfa_offset 4
; CHECK32-NEXT:    jmp foo # TAILCALL
; CHECK32-NEXT:    # encoding: [0xeb,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: foo-1, kind: FK_PCRel_1
; CHECK32-NEXT:  .LBB1_2: # %bb2
; CHECK32-NEXT:    .cfi_def_cfa_offset 8
; CHECK32-NEXT:    popl %ebx # encoding: [0x5b]
; CHECK32-NEXT:    .cfi_def_cfa_offset 4
; CHECK32-NEXT:    jmp bar # TAILCALL
; CHECK32-NEXT:    # encoding: [0xeb,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: bar-1, kind: FK_PCRel_1
;
; CHECK64-LABEL: f_non_leaf:
; CHECK64:       # %bb.0: # %entry
; CHECK64-NEXT:    pushq %rbx # encoding: [0x53]
; CHECK64-NEXT:    .cfi_def_cfa_offset 16
; CHECK64-NEXT:    .cfi_offset %rbx, -16
; CHECK64-NEXT:    #APP
; CHECK64-NEXT:    #NO_APP
; CHECK64-NEXT:    cmpl %esi, %edi # encoding: [0x39,0xf7]
; CHECK64-NEXT:    jne .LBB1_2 # encoding: [0x75,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB1_2-1, kind: FK_PCRel_1
; CHECK64-NEXT:  # %bb.1: # %bb1
; CHECK64-NEXT:    popq %rbx # encoding: [0x5b]
; CHECK64-NEXT:    .cfi_def_cfa_offset 8
; CHECK64-NEXT:    jmp foo # TAILCALL
; CHECK64-NEXT:    # encoding: [0xeb,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: foo-1, kind: FK_PCRel_1
; CHECK64-NEXT:  .LBB1_2: # %bb2
; CHECK64-NEXT:    .cfi_def_cfa_offset 16
; CHECK64-NEXT:    popq %rbx # encoding: [0x5b]
; CHECK64-NEXT:    .cfi_def_cfa_offset 8
; CHECK64-NEXT:    jmp bar # TAILCALL
; CHECK64-NEXT:    # encoding: [0xeb,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: bar-1, kind: FK_PCRel_1
;
; WIN64-LABEL: f_non_leaf:
; WIN64:       # %bb.0: # %entry
; WIN64-NEXT:    pushq %rbx # encoding: [0x53]
; WIN64-NEXT:    .seh_pushreg 3
; WIN64-NEXT:    .seh_endprologue
; WIN64-NEXT:    #APP
; WIN64-NEXT:    #NO_APP
; WIN64-NEXT:    cmpl %edx, %ecx # encoding: [0x39,0xd1]
; WIN64-NEXT:    jne .LBB1_2 # encoding: [0x75,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB1_2-1, kind: FK_PCRel_1
; WIN64-NEXT:  # %bb.1: # %bb1
; WIN64-NEXT:    popq %rbx # encoding: [0x5b]
; WIN64-NEXT:    jmp foo # TAILCALL
; WIN64-NEXT:    # encoding: [0xeb,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: foo-1, kind: FK_PCRel_1
; WIN64-NEXT:  .LBB1_2: # %bb2
; WIN64-NEXT:    nop # encoding: [0x90]
; WIN64-NEXT:    popq %rbx # encoding: [0x5b]
; WIN64-NEXT:    jmp bar # TAILCALL
; WIN64-NEXT:    # encoding: [0xeb,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: bar-1, kind: FK_PCRel_1
; WIN64-NEXT:    .seh_handlerdata
; WIN64-NEXT:    .text
; WIN64-NEXT:    .seh_endproc
entry:
  ; Force %ebx to be spilled on the stack, turning this into
  ; not a "leaf" function for Win64.
  tail call void asm sideeffect "", "~{ebx}"()

	%p = icmp eq i32 %x, %y
  br i1 %p, label %bb1, label %bb2
bb1:
  tail call void @foo()
  ret void
bb2:
  tail call void @bar()
  ret void

}

declare x86_thiscallcc zeroext i1 @baz(i8*, i32)
define x86_thiscallcc zeroext i1 @BlockPlacementTest(i8* %this, i32 %x) optsize {
; CHECK32-LABEL: BlockPlacementTest:
; CHECK32:       # %bb.0: # %entry
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %edx # encoding: [0x8b,0x54,0x24,0x04]
; CHECK32-NEXT:    testb $42, %dl # encoding: [0xf6,0xc2,0x2a]
; CHECK32-NEXT:    je .LBB2_3 # encoding: [0x74,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB2_3-1, kind: FK_PCRel_1
; CHECK32-NEXT:  # %bb.1: # %land.rhs
; CHECK32-NEXT:    movb $1, %al # encoding: [0xb0,0x01]
; CHECK32-NEXT:    testb $44, %dl # encoding: [0xf6,0xc2,0x2c]
; CHECK32-NEXT:    je baz # TAILCALL
; CHECK32-NEXT:    # encoding: [0x74,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: baz-1, kind: FK_PCRel_1
; CHECK32-NEXT:  .LBB2_2: # %land.end
; CHECK32-NEXT:    # kill: def $al killed $al killed $eax
; CHECK32-NEXT:    retl $4 # encoding: [0xc2,0x04,0x00]
; CHECK32-NEXT:  .LBB2_3:
; CHECK32-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK32-NEXT:    jmp .LBB2_2 # encoding: [0xeb,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB2_2-1, kind: FK_PCRel_1
;
; CHECK64-LABEL: BlockPlacementTest:
; CHECK64:       # %bb.0: # %entry
; CHECK64-NEXT:    testb $42, %sil # encoding: [0x40,0xf6,0xc6,0x2a]
; CHECK64-NEXT:    je .LBB2_3 # encoding: [0x74,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB2_3-1, kind: FK_PCRel_1
; CHECK64-NEXT:  # %bb.1: # %land.rhs
; CHECK64-NEXT:    movb $1, %al # encoding: [0xb0,0x01]
; CHECK64-NEXT:    testb $44, %sil # encoding: [0x40,0xf6,0xc6,0x2c]
; CHECK64-NEXT:    je baz # TAILCALL
; CHECK64-NEXT:    # encoding: [0x74,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: baz-1, kind: FK_PCRel_1
; CHECK64-NEXT:  .LBB2_2: # %land.end
; CHECK64-NEXT:    # kill: def $al killed $al killed $eax
; CHECK64-NEXT:    retq # encoding: [0xc3]
; CHECK64-NEXT:  .LBB2_3:
; CHECK64-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK64-NEXT:    jmp .LBB2_2 # encoding: [0xeb,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB2_2-1, kind: FK_PCRel_1
;
; WIN64-LABEL: BlockPlacementTest:
; WIN64:       # %bb.0: # %entry
; WIN64-NEXT:    testb $42, %dl # encoding: [0xf6,0xc2,0x2a]
; WIN64-NEXT:    je .LBB2_3 # encoding: [0x74,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB2_3-1, kind: FK_PCRel_1
; WIN64-NEXT:  # %bb.1: # %land.rhs
; WIN64-NEXT:    movb $1, %al # encoding: [0xb0,0x01]
; WIN64-NEXT:    testb $44, %dl # encoding: [0xf6,0xc2,0x2c]
; WIN64-NEXT:    je baz # TAILCALL
; WIN64-NEXT:    # encoding: [0x74,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: baz-1, kind: FK_PCRel_1
; WIN64-NEXT:  .LBB2_2: # %land.end
; WIN64-NEXT:    # kill: def $al killed $al killed $eax
; WIN64-NEXT:    retq # encoding: [0xc3]
; WIN64-NEXT:  .LBB2_3:
; WIN64-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; WIN64-NEXT:    jmp .LBB2_2 # encoding: [0xeb,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB2_2-1, kind: FK_PCRel_1
entry:
  %and = and i32 %x, 42
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %land.end, label %land.rhs

land.rhs:
  %and6 = and i32 %x, 44
  %tobool7 = icmp eq i32 %and6, 0
  br i1 %tobool7, label %lor.rhs, label %land.end

lor.rhs:
  %call = tail call x86_thiscallcc zeroext i1 @baz(i8* %this, i32 %x) #2
  br label %land.end

land.end:
  %0 = phi i1 [ false, %entry ], [ true, %land.rhs ], [ %call, %lor.rhs ]
  ret i1 %0

; Make sure machine block placement isn't confused by the conditional tail call,
; but sees that it can fall through to the next block.
}



%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
declare zeroext i1 @_Z20isValidIntegerSuffixN9__gnu_cxx17__normal_iteratorIPKcSsEES3_(i8*, i8*)

define zeroext i1 @pr31257(%"class.std::basic_string"* nocapture readonly dereferenceable(8) %s) minsize {
; CHECK32-LABEL: pr31257:
; CHECK32:       # %bb.0: # %entry
; CHECK32-NEXT:    pushl %ebp # encoding: [0x55]
; CHECK32-NEXT:    .cfi_def_cfa_offset 8
; CHECK32-NEXT:    pushl %ebx # encoding: [0x53]
; CHECK32-NEXT:    .cfi_def_cfa_offset 12
; CHECK32-NEXT:    pushl %edi # encoding: [0x57]
; CHECK32-NEXT:    .cfi_def_cfa_offset 16
; CHECK32-NEXT:    pushl %esi # encoding: [0x56]
; CHECK32-NEXT:    .cfi_def_cfa_offset 20
; CHECK32-NEXT:    subl $12, %esp # encoding: [0x83,0xec,0x0c]
; CHECK32-NEXT:    .cfi_def_cfa_offset 32
; CHECK32-NEXT:    .cfi_offset %esi, -20
; CHECK32-NEXT:    .cfi_offset %edi, -16
; CHECK32-NEXT:    .cfi_offset %ebx, -12
; CHECK32-NEXT:    .cfi_offset %ebp, -8
; CHECK32-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x20]
; CHECK32-NEXT:    movl (%eax), %eax # encoding: [0x8b,0x00]
; CHECK32-NEXT:    movl -24(%eax), %edx # encoding: [0x8b,0x50,0xe8]
; CHECK32-NEXT:    leal (%eax,%edx), %ebp # encoding: [0x8d,0x2c,0x10]
; CHECK32-NEXT:    xorl %ebx, %ebx # encoding: [0x31,0xdb]
; CHECK32-NEXT:    pushl $2 # encoding: [0x6a,0x02]
; CHECK32-NEXT:    .cfi_adjust_cfa_offset 4
; CHECK32-NEXT:    popl %esi # encoding: [0x5e]
; CHECK32-NEXT:    .cfi_adjust_cfa_offset -4
; CHECK32-NEXT:    xorl %edi, %edi # encoding: [0x31,0xff]
; CHECK32-NEXT:    incl %edi # encoding: [0x47]
; CHECK32-NEXT:  .LBB3_1: # %for.cond
; CHECK32-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK32-NEXT:    testl %edx, %edx # encoding: [0x85,0xd2]
; CHECK32-NEXT:    je .LBB3_13 # encoding: [0x74,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_13-1, kind: FK_PCRel_1
; CHECK32-NEXT:  # %bb.2: # %for.body
; CHECK32-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK32-NEXT:    cmpl $2, %ebx # encoding: [0x83,0xfb,0x02]
; CHECK32-NEXT:    je .LBB3_11 # encoding: [0x74,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_11-1, kind: FK_PCRel_1
; CHECK32-NEXT:  # %bb.3: # %for.body
; CHECK32-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK32-NEXT:    cmpl $1, %ebx # encoding: [0x83,0xfb,0x01]
; CHECK32-NEXT:    je .LBB3_9 # encoding: [0x74,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_9-1, kind: FK_PCRel_1
; CHECK32-NEXT:  # %bb.4: # %for.body
; CHECK32-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK32-NEXT:    testl %ebx, %ebx # encoding: [0x85,0xdb]
; CHECK32-NEXT:    jne .LBB3_10 # encoding: [0x75,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_10-1, kind: FK_PCRel_1
; CHECK32-NEXT:  # %bb.5: # %sw.bb
; CHECK32-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK32-NEXT:    movzbl (%eax), %ecx # encoding: [0x0f,0xb6,0x08]
; CHECK32-NEXT:    cmpl $43, %ecx # encoding: [0x83,0xf9,0x2b]
; CHECK32-NEXT:    movl %edi, %ebx # encoding: [0x89,0xfb]
; CHECK32-NEXT:    je .LBB3_10 # encoding: [0x74,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_10-1, kind: FK_PCRel_1
; CHECK32-NEXT:  # %bb.6: # %sw.bb
; CHECK32-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK32-NEXT:    cmpb $45, %cl # encoding: [0x80,0xf9,0x2d]
; CHECK32-NEXT:    movl %edi, %ebx # encoding: [0x89,0xfb]
; CHECK32-NEXT:    je .LBB3_10 # encoding: [0x74,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_10-1, kind: FK_PCRel_1
; CHECK32-NEXT:    jmp .LBB3_7 # encoding: [0xeb,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_7-1, kind: FK_PCRel_1
; CHECK32-NEXT:  .LBB3_11: # %sw.bb22
; CHECK32-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK32-NEXT:    movzbl (%eax), %ecx # encoding: [0x0f,0xb6,0x08]
; CHECK32-NEXT:    addl $-48, %ecx # encoding: [0x83,0xc1,0xd0]
; CHECK32-NEXT:    cmpl $10, %ecx # encoding: [0x83,0xf9,0x0a]
; CHECK32-NEXT:    movl %esi, %ebx # encoding: [0x89,0xf3]
; CHECK32-NEXT:    jb .LBB3_10 # encoding: [0x72,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_10-1, kind: FK_PCRel_1
; CHECK32-NEXT:    jmp .LBB3_12 # encoding: [0xeb,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_12-1, kind: FK_PCRel_1
; CHECK32-NEXT:  .LBB3_9: # %sw.bb14
; CHECK32-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK32-NEXT:    movzbl (%eax), %ecx # encoding: [0x0f,0xb6,0x08]
; CHECK32-NEXT:  .LBB3_7: # %if.else
; CHECK32-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK32-NEXT:    addl $-48, %ecx # encoding: [0x83,0xc1,0xd0]
; CHECK32-NEXT:    cmpl $10, %ecx # encoding: [0x83,0xf9,0x0a]
; CHECK32-NEXT:    movl %esi, %ebx # encoding: [0x89,0xf3]
; CHECK32-NEXT:    jae .LBB3_8 # encoding: [0x73,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_8-1, kind: FK_PCRel_1
; CHECK32-NEXT:  .LBB3_10: # %for.inc
; CHECK32-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK32-NEXT:    incl %eax # encoding: [0x40]
; CHECK32-NEXT:    decl %edx # encoding: [0x4a]
; CHECK32-NEXT:    jmp .LBB3_1 # encoding: [0xeb,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_1-1, kind: FK_PCRel_1
; CHECK32-NEXT:  .LBB3_13:
; CHECK32-NEXT:    cmpl $2, %ebx # encoding: [0x83,0xfb,0x02]
; CHECK32-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK32-NEXT:    jmp .LBB3_14 # encoding: [0xeb,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_14-1, kind: FK_PCRel_1
; CHECK32-NEXT:  .LBB3_8:
; CHECK32-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK32-NEXT:  .LBB3_14: # %cleanup.thread
; CHECK32-NEXT:    # kill: def $al killed $al killed $eax
; CHECK32-NEXT:    addl $12, %esp # encoding: [0x83,0xc4,0x0c]
; CHECK32-NEXT:    .cfi_def_cfa_offset 20
; CHECK32-NEXT:  .LBB3_15: # %cleanup.thread
; CHECK32-NEXT:    popl %esi # encoding: [0x5e]
; CHECK32-NEXT:    .cfi_def_cfa_offset 16
; CHECK32-NEXT:    popl %edi # encoding: [0x5f]
; CHECK32-NEXT:    .cfi_def_cfa_offset 12
; CHECK32-NEXT:    popl %ebx # encoding: [0x5b]
; CHECK32-NEXT:    .cfi_def_cfa_offset 8
; CHECK32-NEXT:    popl %ebp # encoding: [0x5d]
; CHECK32-NEXT:    .cfi_def_cfa_offset 4
; CHECK32-NEXT:    retl # encoding: [0xc3]
; CHECK32-NEXT:  .LBB3_12: # %if.else28
; CHECK32-NEXT:    .cfi_def_cfa_offset 32
; CHECK32-NEXT:    subl $8, %esp # encoding: [0x83,0xec,0x08]
; CHECK32-NEXT:    .cfi_adjust_cfa_offset 8
; CHECK32-NEXT:    pushl %ebp # encoding: [0x55]
; CHECK32-NEXT:    .cfi_adjust_cfa_offset 4
; CHECK32-NEXT:    pushl %eax # encoding: [0x50]
; CHECK32-NEXT:    .cfi_adjust_cfa_offset 4
; CHECK32-NEXT:    calll _Z20isValidIntegerSuffixN9__gnu_cxx17__normal_iteratorIPKcSsEES3_ # encoding: [0xe8,A,A,A,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: _Z20isValidIntegerSuffixN9__gnu_cxx17__normal_iteratorIPKcSsEES3_-4, kind: FK_PCRel_4
; CHECK32-NEXT:    addl $28, %esp # encoding: [0x83,0xc4,0x1c]
; CHECK32-NEXT:    .cfi_adjust_cfa_offset -28
; CHECK32-NEXT:    jmp .LBB3_15 # encoding: [0xeb,A]
; CHECK32-NEXT:    # fixup A - offset: 1, value: .LBB3_15-1, kind: FK_PCRel_1
;
; CHECK64-LABEL: pr31257:
; CHECK64:       # %bb.0: # %entry
; CHECK64-NEXT:    movq (%rdi), %rdi # encoding: [0x48,0x8b,0x3f]
; CHECK64-NEXT:    movq -24(%rdi), %rax # encoding: [0x48,0x8b,0x47,0xe8]
; CHECK64-NEXT:    leaq (%rdi,%rax), %rsi # encoding: [0x48,0x8d,0x34,0x07]
; CHECK64-NEXT:    xorl %ecx, %ecx # encoding: [0x31,0xc9]
; CHECK64-NEXT:    pushq $2 # encoding: [0x6a,0x02]
; CHECK64-NEXT:    .cfi_adjust_cfa_offset 8
; CHECK64-NEXT:    popq %r9 # encoding: [0x41,0x59]
; CHECK64-NEXT:    .cfi_adjust_cfa_offset -8
; CHECK64-NEXT:    pushq $1 # encoding: [0x6a,0x01]
; CHECK64-NEXT:    .cfi_adjust_cfa_offset 8
; CHECK64-NEXT:    popq %r8 # encoding: [0x41,0x58]
; CHECK64-NEXT:    .cfi_adjust_cfa_offset -8
; CHECK64-NEXT:  .LBB3_1: # %for.cond
; CHECK64-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK64-NEXT:    testq %rax, %rax # encoding: [0x48,0x85,0xc0]
; CHECK64-NEXT:    je .LBB3_12 # encoding: [0x74,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB3_12-1, kind: FK_PCRel_1
; CHECK64-NEXT:  # %bb.2: # %for.body
; CHECK64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK64-NEXT:    cmpl $2, %ecx # encoding: [0x83,0xf9,0x02]
; CHECK64-NEXT:    je .LBB3_10 # encoding: [0x74,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB3_10-1, kind: FK_PCRel_1
; CHECK64-NEXT:  # %bb.3: # %for.body
; CHECK64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK64-NEXT:    cmpl $1, %ecx # encoding: [0x83,0xf9,0x01]
; CHECK64-NEXT:    je .LBB3_8 # encoding: [0x74,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB3_8-1, kind: FK_PCRel_1
; CHECK64-NEXT:  # %bb.4: # %for.body
; CHECK64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK64-NEXT:    testl %ecx, %ecx # encoding: [0x85,0xc9]
; CHECK64-NEXT:    jne .LBB3_11 # encoding: [0x75,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB3_11-1, kind: FK_PCRel_1
; CHECK64-NEXT:  # %bb.5: # %sw.bb
; CHECK64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK64-NEXT:    movzbl (%rdi), %edx # encoding: [0x0f,0xb6,0x17]
; CHECK64-NEXT:    cmpl $43, %edx # encoding: [0x83,0xfa,0x2b]
; CHECK64-NEXT:    movl %r8d, %ecx # encoding: [0x44,0x89,0xc1]
; CHECK64-NEXT:    je .LBB3_11 # encoding: [0x74,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB3_11-1, kind: FK_PCRel_1
; CHECK64-NEXT:  # %bb.6: # %sw.bb
; CHECK64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK64-NEXT:    cmpb $45, %dl # encoding: [0x80,0xfa,0x2d]
; CHECK64-NEXT:    movl %r8d, %ecx # encoding: [0x44,0x89,0xc1]
; CHECK64-NEXT:    je .LBB3_11 # encoding: [0x74,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB3_11-1, kind: FK_PCRel_1
; CHECK64-NEXT:  # %bb.7: # %if.else
; CHECK64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK64-NEXT:    addl $-48, %edx # encoding: [0x83,0xc2,0xd0]
; CHECK64-NEXT:    cmpl $10, %edx # encoding: [0x83,0xfa,0x0a]
; CHECK64-NEXT:    jmp .LBB3_9 # encoding: [0xeb,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB3_9-1, kind: FK_PCRel_1
; CHECK64-NEXT:  .LBB3_8: # %sw.bb14
; CHECK64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK64-NEXT:    movzbl (%rdi), %ecx # encoding: [0x0f,0xb6,0x0f]
; CHECK64-NEXT:    addl $-48, %ecx # encoding: [0x83,0xc1,0xd0]
; CHECK64-NEXT:    cmpl $10, %ecx # encoding: [0x83,0xf9,0x0a]
; CHECK64-NEXT:  .LBB3_9: # %if.else
; CHECK64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK64-NEXT:    movl %r9d, %ecx # encoding: [0x44,0x89,0xc9]
; CHECK64-NEXT:    jb .LBB3_11 # encoding: [0x72,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB3_11-1, kind: FK_PCRel_1
; CHECK64-NEXT:    jmp .LBB3_13 # encoding: [0xeb,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB3_13-1, kind: FK_PCRel_1
; CHECK64-NEXT:  .LBB3_10: # %sw.bb22
; CHECK64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK64-NEXT:    movzbl (%rdi), %ecx # encoding: [0x0f,0xb6,0x0f]
; CHECK64-NEXT:    addl $-48, %ecx # encoding: [0x83,0xc1,0xd0]
; CHECK64-NEXT:    cmpl $10, %ecx # encoding: [0x83,0xf9,0x0a]
; CHECK64-NEXT:    movl %r9d, %ecx # encoding: [0x44,0x89,0xc9]
; CHECK64-NEXT:    jae _Z20isValidIntegerSuffixN9__gnu_cxx17__normal_iteratorIPKcSsEES3_ # TAILCALL
; CHECK64-NEXT:    # encoding: [0x73,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: _Z20isValidIntegerSuffixN9__gnu_cxx17__normal_iteratorIPKcSsEES3_-1, kind: FK_PCRel_1
; CHECK64-NEXT:  .LBB3_11: # %for.inc
; CHECK64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; CHECK64-NEXT:    incq %rdi # encoding: [0x48,0xff,0xc7]
; CHECK64-NEXT:    decq %rax # encoding: [0x48,0xff,0xc8]
; CHECK64-NEXT:    jmp .LBB3_1 # encoding: [0xeb,A]
; CHECK64-NEXT:    # fixup A - offset: 1, value: .LBB3_1-1, kind: FK_PCRel_1
; CHECK64-NEXT:  .LBB3_12:
; CHECK64-NEXT:    cmpl $2, %ecx # encoding: [0x83,0xf9,0x02]
; CHECK64-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK64-NEXT:    # kill: def $al killed $al killed $eax
; CHECK64-NEXT:    retq # encoding: [0xc3]
; CHECK64-NEXT:  .LBB3_13:
; CHECK64-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK64-NEXT:    # kill: def $al killed $al killed $eax
; CHECK64-NEXT:    retq # encoding: [0xc3]
;
; WIN64-LABEL: pr31257:
; WIN64:       # %bb.0: # %entry
; WIN64-NEXT:    movq (%rcx), %rcx # encoding: [0x48,0x8b,0x09]
; WIN64-NEXT:    movq -24(%rcx), %r8 # encoding: [0x4c,0x8b,0x41,0xe8]
; WIN64-NEXT:    leaq (%rcx,%r8), %rdx # encoding: [0x4a,0x8d,0x14,0x01]
; WIN64-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; WIN64-NEXT:  .LBB3_1: # %for.cond
; WIN64-NEXT:    # =>This Inner Loop Header: Depth=1
; WIN64-NEXT:    testq %r8, %r8 # encoding: [0x4d,0x85,0xc0]
; WIN64-NEXT:    je .LBB3_11 # encoding: [0x74,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB3_11-1, kind: FK_PCRel_1
; WIN64-NEXT:  # %bb.2: # %for.body
; WIN64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; WIN64-NEXT:    cmpl $2, %eax # encoding: [0x83,0xf8,0x02]
; WIN64-NEXT:    je .LBB3_9 # encoding: [0x74,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB3_9-1, kind: FK_PCRel_1
; WIN64-NEXT:  # %bb.3: # %for.body
; WIN64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; WIN64-NEXT:    cmpl $1, %eax # encoding: [0x83,0xf8,0x01]
; WIN64-NEXT:    je .LBB3_7 # encoding: [0x74,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB3_7-1, kind: FK_PCRel_1
; WIN64-NEXT:  # %bb.4: # %for.body
; WIN64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; WIN64-NEXT:    testl %eax, %eax # encoding: [0x85,0xc0]
; WIN64-NEXT:    jne .LBB3_10 # encoding: [0x75,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB3_10-1, kind: FK_PCRel_1
; WIN64-NEXT:  # %bb.5: # %sw.bb
; WIN64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; WIN64-NEXT:    movzbl (%rcx), %r9d # encoding: [0x44,0x0f,0xb6,0x09]
; WIN64-NEXT:    cmpl $43, %r9d # encoding: [0x41,0x83,0xf9,0x2b]
; WIN64-NEXT:    movl $1, %eax # encoding: [0xb8,0x01,0x00,0x00,0x00]
; WIN64-NEXT:    je .LBB3_10 # encoding: [0x74,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB3_10-1, kind: FK_PCRel_1
; WIN64-NEXT:  # %bb.6: # %sw.bb
; WIN64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; WIN64-NEXT:    cmpb $45, %r9b # encoding: [0x41,0x80,0xf9,0x2d]
; WIN64-NEXT:    je .LBB3_10 # encoding: [0x74,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB3_10-1, kind: FK_PCRel_1
; WIN64-NEXT:    jmp .LBB3_8 # encoding: [0xeb,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB3_8-1, kind: FK_PCRel_1
; WIN64-NEXT:  .LBB3_7: # %sw.bb14
; WIN64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; WIN64-NEXT:    movzbl (%rcx), %r9d # encoding: [0x44,0x0f,0xb6,0x09]
; WIN64-NEXT:  .LBB3_8: # %if.else
; WIN64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; WIN64-NEXT:    addl $-48, %r9d # encoding: [0x41,0x83,0xc1,0xd0]
; WIN64-NEXT:    movl $2, %eax # encoding: [0xb8,0x02,0x00,0x00,0x00]
; WIN64-NEXT:    cmpl $10, %r9d # encoding: [0x41,0x83,0xf9,0x0a]
; WIN64-NEXT:    jb .LBB3_10 # encoding: [0x72,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB3_10-1, kind: FK_PCRel_1
; WIN64-NEXT:    jmp .LBB3_12 # encoding: [0xeb,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB3_12-1, kind: FK_PCRel_1
; WIN64-NEXT:  .LBB3_9: # %sw.bb22
; WIN64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; WIN64-NEXT:    movzbl (%rcx), %r9d # encoding: [0x44,0x0f,0xb6,0x09]
; WIN64-NEXT:    addl $-48, %r9d # encoding: [0x41,0x83,0xc1,0xd0]
; WIN64-NEXT:    movl $2, %eax # encoding: [0xb8,0x02,0x00,0x00,0x00]
; WIN64-NEXT:    cmpl $10, %r9d # encoding: [0x41,0x83,0xf9,0x0a]
; WIN64-NEXT:    jae _Z20isValidIntegerSuffixN9__gnu_cxx17__normal_iteratorIPKcSsEES3_ # TAILCALL
; WIN64-NEXT:    # encoding: [0x73,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: _Z20isValidIntegerSuffixN9__gnu_cxx17__normal_iteratorIPKcSsEES3_-1, kind: FK_PCRel_1
; WIN64-NEXT:  .LBB3_10: # %for.inc
; WIN64-NEXT:    # in Loop: Header=BB3_1 Depth=1
; WIN64-NEXT:    incq %rcx # encoding: [0x48,0xff,0xc1]
; WIN64-NEXT:    decq %r8 # encoding: [0x49,0xff,0xc8]
; WIN64-NEXT:    jmp .LBB3_1 # encoding: [0xeb,A]
; WIN64-NEXT:    # fixup A - offset: 1, value: .LBB3_1-1, kind: FK_PCRel_1
; WIN64-NEXT:  .LBB3_11:
; WIN64-NEXT:    cmpl $2, %eax # encoding: [0x83,0xf8,0x02]
; WIN64-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; WIN64-NEXT:    # kill: def $al killed $al killed $eax
; WIN64-NEXT:    retq # encoding: [0xc3]
; WIN64-NEXT:  .LBB3_12:
; WIN64-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; WIN64-NEXT:    # kill: def $al killed $al killed $eax
; WIN64-NEXT:    retq # encoding: [0xc3]
entry:
  %_M_p.i.i = getelementptr inbounds %"class.std::basic_string", %"class.std::basic_string"* %s, i64 0, i32 0, i32 0
  %0 = load i8*, i8** %_M_p.i.i, align 8
  %arrayidx.i.i.i54 = getelementptr inbounds i8, i8* %0, i64 -24
  %_M_length.i.i55 = bitcast i8* %arrayidx.i.i.i54 to i64*
  %1 = load i64, i64* %_M_length.i.i55, align 8
  %add.ptr.i56 = getelementptr inbounds i8, i8* %0, i64 %1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %it.sroa.0.0 = phi i8* [ %0, %entry ], [ %incdec.ptr.i, %for.inc ]
  %state.0 = phi i32 [ 0, %entry ], [ %state.1, %for.inc ]
  %cmp.i = icmp eq i8* %it.sroa.0.0, %add.ptr.i56
  br i1 %cmp.i, label %5, label %for.body

for.body:                                         ; preds = %for.cond
  switch i32 %state.0, label %for.inc [
    i32 0, label %sw.bb
    i32 1, label %sw.bb14
    i32 2, label %sw.bb22
  ]

sw.bb:                                            ; preds = %for.body
  %2 = load i8, i8* %it.sroa.0.0, align 1
  switch i8 %2, label %if.else [
    i8 43, label %for.inc
    i8 45, label %for.inc
  ]

if.else:                                          ; preds = %sw.bb
  %conv9 = zext i8 %2 to i32
  %isdigittmp45 = add nsw i32 %conv9, -48
  %isdigit46 = icmp ult i32 %isdigittmp45, 10
  br i1 %isdigit46, label %for.inc, label %cleanup.thread.loopexit

sw.bb14:                                          ; preds = %for.body
  %3 = load i8, i8* %it.sroa.0.0, align 1
  %conv16 = zext i8 %3 to i32
  %isdigittmp43 = add nsw i32 %conv16, -48
  %isdigit44 = icmp ult i32 %isdigittmp43, 10
  br i1 %isdigit44, label %for.inc, label %cleanup.thread.loopexit

sw.bb22:                                          ; preds = %for.body
  %4 = load i8, i8* %it.sroa.0.0, align 1
  %conv24 = zext i8 %4 to i32
  %isdigittmp = add nsw i32 %conv24, -48
  %isdigit = icmp ult i32 %isdigittmp, 10
  br i1 %isdigit, label %for.inc, label %if.else28

; Make sure Machine Copy Propagation doesn't delete the mov to %ecx becaue it
; thinks the conditional tail call clobbers it.

if.else28:                                        ; preds = %sw.bb22
  %call34 = tail call zeroext i1 @_Z20isValidIntegerSuffixN9__gnu_cxx17__normal_iteratorIPKcSsEES3_(i8* nonnull %it.sroa.0.0, i8* %add.ptr.i56)
  br label %cleanup.thread

for.inc:                                          ; preds = %sw.bb, %sw.bb, %sw.bb22, %sw.bb14, %if.else, %for.body
  %state.1 = phi i32 [ %state.0, %for.body ], [ 1, %sw.bb ], [ 2, %if.else ], [ 2, %sw.bb14 ], [ 2, %sw.bb22 ], [ 1, %sw.bb ]
  %incdec.ptr.i = getelementptr inbounds i8, i8* %it.sroa.0.0, i64 1
  br label %for.cond

; <label>:5:                                      ; preds = %for.cond
  %cmp37 = icmp eq i32 %state.0, 2
  br label %cleanup.thread

cleanup.thread.loopexit:                          ; preds = %if.else, %sw.bb14
  br label %cleanup.thread

cleanup.thread:                                   ; preds = %cleanup.thread.loopexit, %if.else28, %5
  %6 = phi i1 [ %cmp37, %5 ], [ %call34, %if.else28 ], [ false, %cleanup.thread.loopexit ]
  ret i1 %6
}
