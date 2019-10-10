; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=-bmi < %s | FileCheck %s --check-prefix=CHECK-NOBMI
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=+bmi < %s | FileCheck %s --check-prefix=CHECK-BMI

; Compare if negative and select of constants where one constant is zero.

define i32 @neg_sel_constants(i32 %a) {
; CHECK-NOBMI-LABEL: neg_sel_constants:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    movl %edi, %eax
; CHECK-NOBMI-NEXT:    sarl $31, %eax
; CHECK-NOBMI-NEXT:    andl $5, %eax
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: neg_sel_constants:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    movl %edi, %eax
; CHECK-BMI-NEXT:    sarl $31, %eax
; CHECK-BMI-NEXT:    andl $5, %eax
; CHECK-BMI-NEXT:    retq
  %tmp.1 = icmp slt i32 %a, 0
  %retval = select i1 %tmp.1, i32 5, i32 0
  ret i32 %retval
}

; Compare if negative and select of constants where one constant is zero and the other is a single bit.

define i32 @neg_sel_special_constant(i32 %a) {
; CHECK-NOBMI-LABEL: neg_sel_special_constant:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    movl %edi, %eax
; CHECK-NOBMI-NEXT:    shrl $22, %eax
; CHECK-NOBMI-NEXT:    andl $512, %eax # imm = 0x200
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: neg_sel_special_constant:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    movl %edi, %eax
; CHECK-BMI-NEXT:    shrl $22, %eax
; CHECK-BMI-NEXT:    andl $512, %eax # imm = 0x200
; CHECK-BMI-NEXT:    retq
  %tmp.1 = icmp slt i32 %a, 0
  %retval = select i1 %tmp.1, i32 512, i32 0
  ret i32 %retval
}

; Compare if negative and select variable or zero.

define i32 @neg_sel_variable_and_zero(i32 %a, i32 %b) {
; CHECK-NOBMI-LABEL: neg_sel_variable_and_zero:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    movl %edi, %eax
; CHECK-NOBMI-NEXT:    sarl $31, %eax
; CHECK-NOBMI-NEXT:    andl %esi, %eax
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: neg_sel_variable_and_zero:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    movl %edi, %eax
; CHECK-BMI-NEXT:    sarl $31, %eax
; CHECK-BMI-NEXT:    andl %esi, %eax
; CHECK-BMI-NEXT:    retq
  %tmp.1 = icmp slt i32 %a, 0
  %retval = select i1 %tmp.1, i32 %b, i32 0
  ret i32 %retval
}

; Compare if not positive and select the same variable as being compared: smin(a, 0).

define i32 @not_pos_sel_same_variable(i32 %a) {
; CHECK-NOBMI-LABEL: not_pos_sel_same_variable:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    movl %edi, %eax
; CHECK-NOBMI-NEXT:    sarl $31, %eax
; CHECK-NOBMI-NEXT:    andl %edi, %eax
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: not_pos_sel_same_variable:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    movl %edi, %eax
; CHECK-BMI-NEXT:    sarl $31, %eax
; CHECK-BMI-NEXT:    andl %edi, %eax
; CHECK-BMI-NEXT:    retq
  %tmp = icmp slt i32 %a, 1
  %min = select i1 %tmp, i32 %a, i32 0
  ret i32 %min
}

; Flipping the comparison condition can be handled by getting the bitwise not of the sign mask.

; Compare if positive and select of constants where one constant is zero.

define i32 @pos_sel_constants(i32 %a) {
; CHECK-NOBMI-LABEL: pos_sel_constants:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NOBMI-NEXT:    notl %edi
; CHECK-NOBMI-NEXT:    shrl $31, %edi
; CHECK-NOBMI-NEXT:    leal (%rdi,%rdi,4), %eax
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: pos_sel_constants:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-BMI-NEXT:    notl %edi
; CHECK-BMI-NEXT:    shrl $31, %edi
; CHECK-BMI-NEXT:    leal (%rdi,%rdi,4), %eax
; CHECK-BMI-NEXT:    retq
  %tmp.1 = icmp sgt i32 %a, -1
  %retval = select i1 %tmp.1, i32 5, i32 0
  ret i32 %retval
}

; Compare if positive and select of constants where one constant is zero and the other is a single bit.

define i32 @pos_sel_special_constant(i32 %a) {
; CHECK-NOBMI-LABEL: pos_sel_special_constant:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    movl %edi, %eax
; CHECK-NOBMI-NEXT:    notl %eax
; CHECK-NOBMI-NEXT:    shrl $22, %eax
; CHECK-NOBMI-NEXT:    andl $512, %eax # imm = 0x200
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: pos_sel_special_constant:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    movl %edi, %eax
; CHECK-BMI-NEXT:    notl %eax
; CHECK-BMI-NEXT:    shrl $22, %eax
; CHECK-BMI-NEXT:    andl $512, %eax # imm = 0x200
; CHECK-BMI-NEXT:    retq
  %tmp.1 = icmp sgt i32 %a, -1
  %retval = select i1 %tmp.1, i32 512, i32 0
  ret i32 %retval
}

; Compare if positive and select variable or zero.

define i32 @pos_sel_variable_and_zero(i32 %a, i32 %b) {
; CHECK-NOBMI-LABEL: pos_sel_variable_and_zero:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    xorl %eax, %eax
; CHECK-NOBMI-NEXT:    testl %edi, %edi
; CHECK-NOBMI-NEXT:    cmovnsl %esi, %eax
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: pos_sel_variable_and_zero:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    sarl $31, %edi
; CHECK-BMI-NEXT:    andnl %esi, %edi, %eax
; CHECK-BMI-NEXT:    retq
  %tmp.1 = icmp sgt i32 %a, -1
  %retval = select i1 %tmp.1, i32 %b, i32 0
  ret i32 %retval
}

; Compare if not negative or zero and select the same variable as being compared: smax(a, 0).

define i32 @not_neg_sel_same_variable(i32 %a) {
; CHECK-NOBMI-LABEL: not_neg_sel_same_variable:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    xorl %eax, %eax
; CHECK-NOBMI-NEXT:    testl %edi, %edi
; CHECK-NOBMI-NEXT:    cmovnsl %edi, %eax
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: not_neg_sel_same_variable:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    movl %edi, %eax
; CHECK-BMI-NEXT:    sarl $31, %eax
; CHECK-BMI-NEXT:    andnl %edi, %eax, %eax
; CHECK-BMI-NEXT:    retq
  %tmp = icmp sgt i32 %a, 0
  %min = select i1 %tmp, i32 %a, i32 0
  ret i32 %min
}

; https://llvm.org/bugs/show_bug.cgi?id=31175

; ret = (x-y) > 0 ? x-y : 0
define i32 @PR31175(i32 %x, i32 %y) {
; CHECK-NOBMI-LABEL: PR31175:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    xorl %eax, %eax
; CHECK-NOBMI-NEXT:    subl %esi, %edi
; CHECK-NOBMI-NEXT:    cmovnsl %edi, %eax
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: PR31175:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    subl %esi, %edi
; CHECK-BMI-NEXT:    movl %edi, %eax
; CHECK-BMI-NEXT:    sarl $31, %eax
; CHECK-BMI-NEXT:    andnl %edi, %eax, %eax
; CHECK-BMI-NEXT:    retq
  %sub = sub nsw i32 %x, %y
  %cmp = icmp sgt i32 %sub, 0
  %sel = select i1 %cmp, i32 %sub, i32 0
  ret i32 %sel
}

define i8 @sel_shift_bool_i8(i1 %t) {
; CHECK-NOBMI-LABEL: sel_shift_bool_i8:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-NOBMI-NEXT:    notb %dil
; CHECK-NOBMI-NEXT:    shlb $7, %dil
; CHECK-NOBMI-NEXT:    leal -128(%rdi), %eax
; CHECK-NOBMI-NEXT:    # kill: def $al killed $al killed $eax
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: sel_shift_bool_i8:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    # kill: def $edi killed $edi def $rdi
; CHECK-BMI-NEXT:    notb %dil
; CHECK-BMI-NEXT:    shlb $7, %dil
; CHECK-BMI-NEXT:    leal -128(%rdi), %eax
; CHECK-BMI-NEXT:    # kill: def $al killed $al killed $eax
; CHECK-BMI-NEXT:    retq
  %shl = select i1 %t, i8 128, i8 0
  ret i8 %shl
}

define i16 @sel_shift_bool_i16(i1 %t) {
; CHECK-NOBMI-LABEL: sel_shift_bool_i16:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    movl %edi, %eax
; CHECK-NOBMI-NEXT:    andl $1, %eax
; CHECK-NOBMI-NEXT:    shll $7, %eax
; CHECK-NOBMI-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: sel_shift_bool_i16:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    movl %edi, %eax
; CHECK-BMI-NEXT:    andl $1, %eax
; CHECK-BMI-NEXT:    shll $7, %eax
; CHECK-BMI-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-BMI-NEXT:    retq
  %shl = select i1 %t, i16 128, i16 0
  ret i16 %shl
}

define i32 @sel_shift_bool_i32(i1 %t) {
; CHECK-NOBMI-LABEL: sel_shift_bool_i32:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    movl %edi, %eax
; CHECK-NOBMI-NEXT:    andl $1, %eax
; CHECK-NOBMI-NEXT:    shll $6, %eax
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: sel_shift_bool_i32:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    movl %edi, %eax
; CHECK-BMI-NEXT:    andl $1, %eax
; CHECK-BMI-NEXT:    shll $6, %eax
; CHECK-BMI-NEXT:    retq
  %shl = select i1 %t, i32 64, i32 0
  ret i32 %shl
}

define i64 @sel_shift_bool_i64(i1 %t) {
; CHECK-NOBMI-LABEL: sel_shift_bool_i64:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    movl %edi, %eax
; CHECK-NOBMI-NEXT:    andl $1, %eax
; CHECK-NOBMI-NEXT:    shlq $16, %rax
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: sel_shift_bool_i64:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    movl %edi, %eax
; CHECK-BMI-NEXT:    andl $1, %eax
; CHECK-BMI-NEXT:    shlq $16, %rax
; CHECK-BMI-NEXT:    retq
  %shl = select i1 %t, i64 65536, i64 0
  ret i64 %shl
}

define <16 x i8> @sel_shift_bool_v16i8(<16 x i1> %t) {
; CHECK-NOBMI-LABEL: sel_shift_bool_v16i8:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    psllw $7, %xmm0
; CHECK-NOBMI-NEXT:    pand {{.*}}(%rip), %xmm0
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: sel_shift_bool_v16i8:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    psllw $7, %xmm0
; CHECK-BMI-NEXT:    pand {{.*}}(%rip), %xmm0
; CHECK-BMI-NEXT:    retq
  %shl = select <16 x i1> %t, <16 x i8> <i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128>, <16 x i8> zeroinitializer
  ret <16 x i8> %shl
}

define <8 x i16> @sel_shift_bool_v8i16(<8 x i1> %t) {
; CHECK-NOBMI-LABEL: sel_shift_bool_v8i16:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    psllw $15, %xmm0
; CHECK-NOBMI-NEXT:    psraw $15, %xmm0
; CHECK-NOBMI-NEXT:    pand {{.*}}(%rip), %xmm0
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: sel_shift_bool_v8i16:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    psllw $15, %xmm0
; CHECK-BMI-NEXT:    psraw $15, %xmm0
; CHECK-BMI-NEXT:    pand {{.*}}(%rip), %xmm0
; CHECK-BMI-NEXT:    retq
  %shl= select <8 x i1> %t, <8 x i16> <i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128>, <8 x i16> zeroinitializer
  ret <8 x i16> %shl
}

define <4 x i32> @sel_shift_bool_v4i32(<4 x i1> %t) {
; CHECK-NOBMI-LABEL: sel_shift_bool_v4i32:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    pslld $31, %xmm0
; CHECK-NOBMI-NEXT:    psrad $31, %xmm0
; CHECK-NOBMI-NEXT:    pand {{.*}}(%rip), %xmm0
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: sel_shift_bool_v4i32:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    pslld $31, %xmm0
; CHECK-BMI-NEXT:    psrad $31, %xmm0
; CHECK-BMI-NEXT:    pand {{.*}}(%rip), %xmm0
; CHECK-BMI-NEXT:    retq
  %shl = select <4 x i1> %t, <4 x i32> <i32 64, i32 64, i32 64, i32 64>, <4 x i32> zeroinitializer
  ret <4 x i32> %shl
}

define <2 x i64> @sel_shift_bool_v2i64(<2 x i1> %t) {
; CHECK-NOBMI-LABEL: sel_shift_bool_v2i64:
; CHECK-NOBMI:       # %bb.0:
; CHECK-NOBMI-NEXT:    psllq $63, %xmm0
; CHECK-NOBMI-NEXT:    psrad $31, %xmm0
; CHECK-NOBMI-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; CHECK-NOBMI-NEXT:    pand {{.*}}(%rip), %xmm0
; CHECK-NOBMI-NEXT:    retq
;
; CHECK-BMI-LABEL: sel_shift_bool_v2i64:
; CHECK-BMI:       # %bb.0:
; CHECK-BMI-NEXT:    psllq $63, %xmm0
; CHECK-BMI-NEXT:    psrad $31, %xmm0
; CHECK-BMI-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; CHECK-BMI-NEXT:    pand {{.*}}(%rip), %xmm0
; CHECK-BMI-NEXT:    retq
  %shl = select <2 x i1> %t, <2 x i64> <i64 65536, i64 65536>, <2 x i64> zeroinitializer
  ret <2 x i64> %shl
}
