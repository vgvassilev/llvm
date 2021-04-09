; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+bmi | FileCheck %s

define zeroext i1 @all_bits_clear(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: all_bits_clear:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl %esi, %edi
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
  %a = icmp eq i32 %P, 0
  %b = icmp eq i32 %Q, 0
  %c = and i1 %a, %b
  ret i1 %c
}

define zeroext i1 @all_sign_bits_clear(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: all_sign_bits_clear:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl %esi, %edi
; CHECK-NEXT:    setns %al
; CHECK-NEXT:    retq
  %a = icmp sgt i32 %P, -1
  %b = icmp sgt i32 %Q, -1
  %c = and i1 %a, %b
  ret i1 %c
}

define zeroext i1 @all_bits_set(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: all_bits_set:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andl %esi, %edi
; CHECK-NEXT:    cmpl $-1, %edi
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
  %a = icmp eq i32 %P, -1
  %b = icmp eq i32 %Q, -1
  %c = and i1 %a, %b
  ret i1 %c
}

define zeroext i1 @all_sign_bits_set(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: all_sign_bits_set:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    andl %esi, %eax
; CHECK-NEXT:    shrl $31, %eax
; CHECK-NEXT:    # kill: def $al killed $al killed $eax
; CHECK-NEXT:    retq
  %a = icmp slt i32 %P, 0
  %b = icmp slt i32 %Q, 0
  %c = and i1 %a, %b
  ret i1 %c
}

define zeroext i1 @any_bits_set(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: any_bits_set:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl %esi, %edi
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    retq
  %a = icmp ne i32 %P, 0
  %b = icmp ne i32 %Q, 0
  %c = or i1 %a, %b
  ret i1 %c
}

define zeroext i1 @any_sign_bits_set(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: any_sign_bits_set:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    orl %esi, %eax
; CHECK-NEXT:    shrl $31, %eax
; CHECK-NEXT:    # kill: def $al killed $al killed $eax
; CHECK-NEXT:    retq
  %a = icmp slt i32 %P, 0
  %b = icmp slt i32 %Q, 0
  %c = or i1 %a, %b
  ret i1 %c
}

define zeroext i1 @any_bits_clear(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: any_bits_clear:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andl %esi, %edi
; CHECK-NEXT:    cmpl $-1, %edi
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    retq
  %a = icmp ne i32 %P, -1
  %b = icmp ne i32 %Q, -1
  %c = or i1 %a, %b
  ret i1 %c
}

define zeroext i1 @any_sign_bits_clear(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: any_sign_bits_clear:
; CHECK:       # %bb.0:
; CHECK-NEXT:    testl %esi, %edi
; CHECK-NEXT:    setns %al
; CHECK-NEXT:    retq
  %a = icmp sgt i32 %P, -1
  %b = icmp sgt i32 %Q, -1
  %c = or i1 %a, %b
  ret i1 %c
}

; PR3351 - (P == 0) & (Q == 0) -> (P|Q) == 0
define i32 @all_bits_clear_branch(i32* %P, i32* %Q) nounwind {
; CHECK-LABEL: all_bits_clear_branch:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orq %rsi, %rdi
; CHECK-NEXT:    jne .LBB8_2
; CHECK-NEXT:  # %bb.1: # %bb1
; CHECK-NEXT:    movl $4, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB8_2: # %return
; CHECK-NEXT:    movl $192, %eax
; CHECK-NEXT:    retq
entry:
  %a = icmp eq i32* %P, null
  %b = icmp eq i32* %Q, null
  %c = and i1 %a, %b
  br i1 %c, label %bb1, label %return

bb1:
  ret i32 4

return:
  ret i32 192
}

define i32 @all_sign_bits_clear_branch(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: all_sign_bits_clear_branch:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    js .LBB9_3
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    testl %esi, %esi
; CHECK-NEXT:    js .LBB9_3
; CHECK-NEXT:  # %bb.2: # %bb1
; CHECK-NEXT:    movl $4, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB9_3: # %return
; CHECK-NEXT:    movl $192, %eax
; CHECK-NEXT:    retq
entry:
  %a = icmp sgt i32 %P, -1
  %b = icmp sgt i32 %Q, -1
  %c = and i1 %a, %b
  br i1 %c, label %bb1, label %return

bb1:
  ret i32 4

return:
  ret i32 192
}

define i32 @all_bits_set_branch(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: all_bits_set_branch:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $-1, %edi
; CHECK-NEXT:    jne .LBB10_3
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    cmpl $-1, %esi
; CHECK-NEXT:    jne .LBB10_3
; CHECK-NEXT:  # %bb.2: # %bb1
; CHECK-NEXT:    movl $4, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB10_3: # %return
; CHECK-NEXT:    movl $192, %eax
; CHECK-NEXT:    retq
entry:
  %a = icmp eq i32 %P, -1
  %b = icmp eq i32 %Q, -1
  %c = and i1 %a, %b
  br i1 %c, label %bb1, label %return

bb1:
  ret i32 4

return:
  ret i32 192
}

define i32 @all_sign_bits_set_branch(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: all_sign_bits_set_branch:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    jns .LBB11_3
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    testl %esi, %esi
; CHECK-NEXT:    jns .LBB11_3
; CHECK-NEXT:  # %bb.2: # %bb1
; CHECK-NEXT:    movl $4, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB11_3: # %return
; CHECK-NEXT:    movl $192, %eax
; CHECK-NEXT:    retq
entry:
  %a = icmp slt i32 %P, 0
  %b = icmp slt i32 %Q, 0
  %c = and i1 %a, %b
  br i1 %c, label %bb1, label %return

bb1:
  ret i32 4

return:
  ret i32 192
}

; PR3351 - (P != 0) | (Q != 0) -> (P|Q) != 0
define i32 @any_bits_set_branch(i32* %P, i32* %Q) nounwind {
; CHECK-LABEL: any_bits_set_branch:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    orq %rsi, %rdi
; CHECK-NEXT:    je .LBB12_2
; CHECK-NEXT:  # %bb.1: # %bb1
; CHECK-NEXT:    movl $4, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB12_2: # %return
; CHECK-NEXT:    movl $192, %eax
; CHECK-NEXT:    retq
entry:
  %a = icmp ne i32* %P, null
  %b = icmp ne i32* %Q, null
  %c = or i1 %a, %b
  br i1 %c, label %bb1, label %return

bb1:
  ret i32 4

return:
  ret i32 192
}

define i32 @any_sign_bits_set_branch(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: any_sign_bits_set_branch:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    js .LBB13_2
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    testl %esi, %esi
; CHECK-NEXT:    js .LBB13_2
; CHECK-NEXT:  # %bb.3: # %return
; CHECK-NEXT:    movl $192, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB13_2: # %bb1
; CHECK-NEXT:    movl $4, %eax
; CHECK-NEXT:    retq
entry:
  %a = icmp slt i32 %P, 0
  %b = icmp slt i32 %Q, 0
  %c = or i1 %a, %b
  br i1 %c, label %bb1, label %return

bb1:
  ret i32 4

return:
  ret i32 192
}

define i32 @any_bits_clear_branch(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: any_bits_clear_branch:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $-1, %edi
; CHECK-NEXT:    jne .LBB14_2
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    cmpl $-1, %esi
; CHECK-NEXT:    jne .LBB14_2
; CHECK-NEXT:  # %bb.3: # %return
; CHECK-NEXT:    movl $192, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB14_2: # %bb1
; CHECK-NEXT:    movl $4, %eax
; CHECK-NEXT:    retq
entry:
  %a = icmp ne i32 %P, -1
  %b = icmp ne i32 %Q, -1
  %c = or i1 %a, %b
  br i1 %c, label %bb1, label %return

bb1:
  ret i32 4

return:
  ret i32 192
}

define i32 @any_sign_bits_clear_branch(i32 %P, i32 %Q) nounwind {
; CHECK-LABEL: any_sign_bits_clear_branch:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    jns .LBB15_2
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    testl %esi, %esi
; CHECK-NEXT:    jns .LBB15_2
; CHECK-NEXT:  # %bb.3: # %return
; CHECK-NEXT:    movl $192, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB15_2: # %bb1
; CHECK-NEXT:    movl $4, %eax
; CHECK-NEXT:    retq
entry:
  %a = icmp sgt i32 %P, -1
  %b = icmp sgt i32 %Q, -1
  %c = or i1 %a, %b
  br i1 %c, label %bb1, label %return

bb1:
  ret i32 4

return:
  ret i32 192
}

; PR44565 - https://bugs.llvm.org/show_bug.cgi?id=44565

define i32 @vec_extract_branch(<2 x double> %x)  {
; CHECK-LABEL: vec_extract_branch:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorpd %xmm1, %xmm1
; CHECK-NEXT:    cmpltpd %xmm0, %xmm1
; CHECK-NEXT:    movmskpd %xmm1, %eax
; CHECK-NEXT:    cmpb $3, %al
; CHECK-NEXT:    jne .LBB16_2
; CHECK-NEXT:  # %bb.1: # %true
; CHECK-NEXT:    movl $42, %eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB16_2: # %false
; CHECK-NEXT:    movl $88, %eax
; CHECK-NEXT:    retq
  %t1 = fcmp ogt <2 x double> %x, zeroinitializer
  %t2 = extractelement <2 x i1> %t1, i32 0
  %t3 = extractelement <2 x i1> %t1, i32 1
  %t4 = and i1 %t2, %t3
  br i1 %t4, label %true, label %false
true:
  ret i32 42
false:
  ret i32 88
}

define <4 x i1> @all_bits_clear_vec(<4 x i32> %P, <4 x i32> %Q) nounwind {
; CHECK-LABEL: all_bits_clear_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    por %xmm1, %xmm0
; CHECK-NEXT:    pxor %xmm1, %xmm1
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %a = icmp eq <4 x i32> %P, zeroinitializer
  %b = icmp eq <4 x i32> %Q, zeroinitializer
  %c = and <4 x i1> %a, %b
  ret <4 x i1> %c
}

define <4 x i1> @all_sign_bits_clear_vec(<4 x i32> %P, <4 x i32> %Q) nounwind {
; CHECK-LABEL: all_sign_bits_clear_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    por %xmm1, %xmm0
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm1
; CHECK-NEXT:    pcmpgtd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %a = icmp sgt <4 x i32> %P, <i32 -1, i32 -1, i32 -1, i32 -1>
  %b = icmp sgt <4 x i32> %Q, <i32 -1, i32 -1, i32 -1, i32 -1>
  %c = and <4 x i1> %a, %b
  ret <4 x i1> %c
}

define <4 x i1> @all_bits_set_vec(<4 x i32> %P, <4 x i32> %Q) nounwind {
; CHECK-LABEL: all_bits_set_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pand %xmm1, %xmm0
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm1
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %a = icmp eq <4 x i32> %P, <i32 -1, i32 -1, i32 -1, i32 -1>
  %b = icmp eq <4 x i32> %Q, <i32 -1, i32 -1, i32 -1, i32 -1>
  %c = and <4 x i1> %a, %b
  ret <4 x i1> %c
}

define <4 x i1> @all_sign_bits_set_vec(<4 x i32> %P, <4 x i32> %Q) nounwind {
; CHECK-LABEL: all_sign_bits_set_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pand %xmm1, %xmm0
; CHECK-NEXT:    pxor %xmm1, %xmm1
; CHECK-NEXT:    pcmpgtd %xmm0, %xmm1
; CHECK-NEXT:    movdqa %xmm1, %xmm0
; CHECK-NEXT:    retq
  %a = icmp slt <4 x i32> %P, zeroinitializer
  %b = icmp slt <4 x i32> %Q, zeroinitializer
  %c = and <4 x i1> %a, %b
  ret <4 x i1> %c
}

define <4 x i1> @any_bits_set_vec(<4 x i32> %P, <4 x i32> %Q) nounwind {
; CHECK-LABEL: any_bits_set_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    por %xmm1, %xmm0
; CHECK-NEXT:    pxor %xmm1, %xmm1
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm0
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm1
; CHECK-NEXT:    pxor %xmm1, %xmm0
; CHECK-NEXT:    retq
  %a = icmp ne <4 x i32> %P, zeroinitializer
  %b = icmp ne <4 x i32> %Q, zeroinitializer
  %c = or <4 x i1> %a, %b
  ret <4 x i1> %c
}

define <4 x i1> @any_sign_bits_set_vec(<4 x i32> %P, <4 x i32> %Q) nounwind {
; CHECK-LABEL: any_sign_bits_set_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    por %xmm1, %xmm0
; CHECK-NEXT:    pxor %xmm1, %xmm1
; CHECK-NEXT:    pcmpgtd %xmm0, %xmm1
; CHECK-NEXT:    movdqa %xmm1, %xmm0
; CHECK-NEXT:    retq
  %a = icmp slt <4 x i32> %P, zeroinitializer
  %b = icmp slt <4 x i32> %Q, zeroinitializer
  %c = or <4 x i1> %a, %b
  ret <4 x i1> %c
}

define <4 x i1> @any_bits_clear_vec(<4 x i32> %P, <4 x i32> %Q) nounwind {
; CHECK-LABEL: any_bits_clear_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pand %xmm1, %xmm0
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm1
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm0
; CHECK-NEXT:    pxor %xmm1, %xmm0
; CHECK-NEXT:    retq
  %a = icmp ne <4 x i32> %P, <i32 -1, i32 -1, i32 -1, i32 -1>
  %b = icmp ne <4 x i32> %Q, <i32 -1, i32 -1, i32 -1, i32 -1>
  %c = or <4 x i1> %a, %b
  ret <4 x i1> %c
}

define <4 x i1> @any_sign_bits_clear_vec(<4 x i32> %P, <4 x i32> %Q) nounwind {
; CHECK-LABEL: any_sign_bits_clear_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pand %xmm1, %xmm0
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm1
; CHECK-NEXT:    pcmpgtd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %a = icmp sgt <4 x i32> %P, <i32 -1, i32 -1, i32 -1, i32 -1>
  %b = icmp sgt <4 x i32> %Q, <i32 -1, i32 -1, i32 -1, i32 -1>
  %c = or <4 x i1> %a, %b
  ret <4 x i1> %c
}

define zeroext i1 @ne_neg1_and_ne_zero(i64 %x) nounwind {
; CHECK-LABEL: ne_neg1_and_ne_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    incq %rdi
; CHECK-NEXT:    cmpq $1, %rdi
; CHECK-NEXT:    seta %al
; CHECK-NEXT:    retq
  %cmp1 = icmp ne i64 %x, -1
  %cmp2 = icmp ne i64 %x, 0
  %and = and i1 %cmp1, %cmp2
  ret i1 %and
}

; PR32401 - https://bugs.llvm.org/show_bug.cgi?id=32401

define zeroext i1 @and_eq(i8 %a, i8 %b, i8 %c, i8 %d) nounwind {
; CHECK-LABEL: and_eq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorl %esi, %edi
; CHECK-NEXT:    xorl %ecx, %edx
; CHECK-NEXT:    orb %dl, %dil
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
  %cmp1 = icmp eq i8 %a, %b
  %cmp2 = icmp eq i8 %c, %d
  %and = and i1 %cmp1, %cmp2
  ret i1 %and
}

define zeroext i1 @or_ne(i8 %a, i8 %b, i8 %c, i8 %d) nounwind {
; CHECK-LABEL: or_ne:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorl %esi, %edi
; CHECK-NEXT:    xorl %ecx, %edx
; CHECK-NEXT:    orb %dl, %dil
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    retq
  %cmp1 = icmp ne i8 %a, %b
  %cmp2 = icmp ne i8 %c, %d
  %or = or i1 %cmp1, %cmp2
  ret i1 %or
}

; This should not be transformed because vector compares + bitwise logic are faster.

define <4 x i1> @and_eq_vec(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c, <4 x i32> %d) nounwind {
; CHECK-LABEL: and_eq_vec:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm0
; CHECK-NEXT:    pcmpeqd %xmm3, %xmm2
; CHECK-NEXT:    pand %xmm2, %xmm0
; CHECK-NEXT:    retq
  %cmp1 = icmp eq <4 x i32> %a, %b
  %cmp2 = icmp eq <4 x i32> %c, %d
  %and = and <4 x i1> %cmp1, %cmp2
  ret <4 x i1> %and
}

define i1 @or_icmps_const_1bit_diff(i8 %x) {
; CHECK-LABEL: or_icmps_const_1bit_diff:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addb $-43, %dil
; CHECK-NEXT:    testb $-3, %dil
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
  %a = icmp eq i8 %x, 43
  %b = icmp eq i8 %x, 45
  %r = or i1 %a, %b
  ret i1 %r
}

define i1 @and_icmps_const_1bit_diff(i32 %x) {
; CHECK-LABEL: and_icmps_const_1bit_diff:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addl $-44, %edi
; CHECK-NEXT:    testl $-17, %edi
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    retq
  %a = icmp ne i32 %x, 44
  %b = icmp ne i32 %x, 60
  %r = and i1 %a, %b
  ret i1 %r
}

; Negative test - extra use prevents optimization

define i1 @or_icmps_const_1bit_diff_extra_use(i8 %x, i8* %p) {
; CHECK-LABEL: or_icmps_const_1bit_diff_extra_use:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpb $45, %dil
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    cmpb $43, %dil
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    sete (%rsi)
; CHECK-NEXT:    orb %cl, %al
; CHECK-NEXT:    retq
  %a = icmp eq i8 %x, 43
  %b = icmp eq i8 %x, 45
  %r = or i1 %a, %b
  %z = zext i1 %a to i8
  store i8 %z, i8* %p
  ret i1 %r
}

; Negative test - constant diff is >1 bit

define i1 @and_icmps_const_not1bit_diff(i32 %x) {
; CHECK-LABEL: and_icmps_const_not1bit_diff:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpl $44, %edi
; CHECK-NEXT:    setne %cl
; CHECK-NEXT:    cmpl $92, %edi
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    andb %cl, %al
; CHECK-NEXT:    retq
  %a = icmp ne i32 %x, 44
  %b = icmp ne i32 %x, 92
  %r = and i1 %a, %b
  ret i1 %r
}

; Negative test - wrong comparison

define i1 @and_icmps_const_1bit_diff_wrong_pred(i32 %x) {
; CHECK-LABEL: and_icmps_const_1bit_diff_wrong_pred:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpl $43, %edi
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    cmpl $45, %edi
; CHECK-NEXT:    setl %al
; CHECK-NEXT:    orb %cl, %al
; CHECK-NEXT:    retq
  %a = icmp eq i32 %x, 43
  %b = icmp slt i32 %x, 45
  %r = or i1 %a, %b
  ret i1 %r
}

; Negative test - no common operand

define i1 @and_icmps_const_1bit_diff_common_op(i32 %x, i32 %y) {
; CHECK-LABEL: and_icmps_const_1bit_diff_common_op:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpl $43, %edi
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    cmpl $45, %esi
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    orb %cl, %al
; CHECK-NEXT:    retq
  %a = icmp eq i32 %x, 43
  %b = icmp eq i32 %y, 45
  %r = or i1 %a, %b
  ret i1 %r
}

; TODO: PR44136 - fold cmpeq(or(X,Y),X) --> cmpeq(and(~X,Y),0)

define i1 @or_cmp_eq_i64(i64 %x, i64 %y) {
; CHECK-LABEL: or_cmp_eq_i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orq %rdi, %rsi
; CHECK-NEXT:    cmpq %rdi, %rsi
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
  %o = or i64 %x, %y
  %c = icmp eq i64 %o, %x
  ret i1 %c
}

define i1 @or_cmp_eq_i32(i32 %x, i32 %y) {
; CHECK-LABEL: or_cmp_eq_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl %esi, %edi
; CHECK-NEXT:    cmpl %esi, %edi
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
  %o = or i32 %x, %y
  %c = icmp eq i32 %o, %y
  ret i1 %c
}

define i1 @or_cmp_eq_i16(i16 zeroext %x, i16 zeroext %y) {
; CHECK-LABEL: or_cmp_eq_i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl %edi, %esi
; CHECK-NEXT:    cmpw %si, %di
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
  %o = or i16 %x, %y
  %c = icmp eq i16 %x, %o
  ret i1 %c
}

define i1 @or_cmp_eq_i8(i8 zeroext %x, i8 zeroext %y) {
; CHECK-LABEL: or_cmp_eq_i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    orl %esi, %edi
; CHECK-NEXT:    cmpb %dil, %sil
; CHECK-NEXT:    sete %al
; CHECK-NEXT:    retq
  %o = or i8 %x, %y
  %c = icmp eq i8 %y, %o
  ret i1 %c
}

; Don't fold vectors.
define <4 x i32> @or_cmp_eq_v4i32(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: or_cmp_eq_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    por %xmm0, %xmm1
; CHECK-NEXT:    pcmpeqd %xmm1, %xmm0
; CHECK-NEXT:    retq
  %o = or <4 x i32> %x, %y
  %c = icmp eq <4 x i32> %o, %x
  %s = sext <4 x i1> %c to <4 x i32>
  ret <4 x i32> %s
}
