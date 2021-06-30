; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=i686-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=CHECK,X86
; RUN: llc -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=CHECK,X64

;------------------------------------------------------------------------------;
; Odd divisors
;------------------------------------------------------------------------------;

define i32 @test_urem_odd(i32 %X) nounwind {
; X86-LABEL: test_urem_odd:
; X86:       # %bb.0:
; X86-NEXT:    imull $-858993459, {{[0-9]+}}(%esp), %ecx # imm = 0xCCCCCCCD
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $858993460, %ecx # imm = 0x33333334
; X86-NEXT:    setb %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_odd:
; X64:       # %bb.0:
; X64-NEXT:    imull $-858993459, %edi, %ecx # imm = 0xCCCCCCCD
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $858993460, %ecx # imm = 0x33333334
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %urem = urem i32 %X, 5
  %cmp = icmp eq i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

define i32 @test_urem_odd_25(i32 %X) nounwind {
; X86-LABEL: test_urem_odd_25:
; X86:       # %bb.0:
; X86-NEXT:    imull $-1030792151, {{[0-9]+}}(%esp), %ecx # imm = 0xC28F5C29
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $171798692, %ecx # imm = 0xA3D70A4
; X86-NEXT:    setb %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_odd_25:
; X64:       # %bb.0:
; X64-NEXT:    imull $-1030792151, %edi, %ecx # imm = 0xC28F5C29
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $171798692, %ecx # imm = 0xA3D70A4
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %urem = urem i32 %X, 25
  %cmp = icmp eq i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; This is like test_urem_odd, except the divisor has bit 30 set.
define i32 @test_urem_odd_bit30(i32 %X) nounwind {
; X86-LABEL: test_urem_odd_bit30:
; X86:       # %bb.0:
; X86-NEXT:    imull $1789569707, {{[0-9]+}}(%esp), %ecx # imm = 0x6AAAAAAB
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $4, %ecx
; X86-NEXT:    setb %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_odd_bit30:
; X64:       # %bb.0:
; X64-NEXT:    imull $1789569707, %edi, %ecx # imm = 0x6AAAAAAB
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $4, %ecx
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %urem = urem i32 %X, 1073741827
  %cmp = icmp eq i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; This is like test_urem_odd, except the divisor has bit 31 set.
define i32 @test_urem_odd_bit31(i32 %X) nounwind {
; X86-LABEL: test_urem_odd_bit31:
; X86:       # %bb.0:
; X86-NEXT:    imull $715827883, {{[0-9]+}}(%esp), %ecx # imm = 0x2AAAAAAB
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $2, %ecx
; X86-NEXT:    setb %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_odd_bit31:
; X64:       # %bb.0:
; X64-NEXT:    imull $715827883, %edi, %ecx # imm = 0x2AAAAAAB
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $2, %ecx
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %urem = urem i32 %X, 2147483651
  %cmp = icmp eq i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

;------------------------------------------------------------------------------;
; Even divisors
;------------------------------------------------------------------------------;

define i16 @test_urem_even(i16 %X) nounwind {
; X86-LABEL: test_urem_even:
; X86:       # %bb.0:
; X86-NEXT:    imull $28087, {{[0-9]+}}(%esp), %eax # imm = 0x6DB7
; X86-NEXT:    rorw %ax
; X86-NEXT:    movzwl %ax, %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $4682, %ecx # imm = 0x124A
; X86-NEXT:    setae %al
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_even:
; X64:       # %bb.0:
; X64-NEXT:    imull $28087, %edi, %eax # imm = 0x6DB7
; X64-NEXT:    rorw %ax
; X64-NEXT:    movzwl %ax, %ecx
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $4682, %ecx # imm = 0x124A
; X64-NEXT:    setae %al
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %urem = urem i16 %X, 14
  %cmp = icmp ne i16 %urem, 0
  %ret = zext i1 %cmp to i16
  ret i16 %ret
}

define i32 @test_urem_even_100(i32 %X) nounwind {
; X86-LABEL: test_urem_even_100:
; X86:       # %bb.0:
; X86-NEXT:    imull $-1030792151, {{[0-9]+}}(%esp), %ecx # imm = 0xC28F5C29
; X86-NEXT:    rorl $2, %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $42949673, %ecx # imm = 0x28F5C29
; X86-NEXT:    setb %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_even_100:
; X64:       # %bb.0:
; X64-NEXT:    imull $-1030792151, %edi, %ecx # imm = 0xC28F5C29
; X64-NEXT:    rorl $2, %ecx
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $42949673, %ecx # imm = 0x28F5C29
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %urem = urem i32 %X, 100
  %cmp = icmp eq i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; This is like test_urem_even, except the divisor has bit 30 set.
define i32 @test_urem_even_bit30(i32 %X) nounwind {
; X86-LABEL: test_urem_even_bit30:
; X86:       # %bb.0:
; X86-NEXT:    imull $-51622203, {{[0-9]+}}(%esp), %ecx # imm = 0xFCEC4EC5
; X86-NEXT:    rorl $3, %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $4, %ecx
; X86-NEXT:    setb %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_even_bit30:
; X64:       # %bb.0:
; X64-NEXT:    imull $-51622203, %edi, %ecx # imm = 0xFCEC4EC5
; X64-NEXT:    rorl $3, %ecx
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $4, %ecx
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %urem = urem i32 %X, 1073741928
  %cmp = icmp eq i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; This is like test_urem_odd, except the divisor has bit 31 set.
define i32 @test_urem_even_bit31(i32 %X) nounwind {
; X86-LABEL: test_urem_even_bit31:
; X86:       # %bb.0:
; X86-NEXT:    imull $-1157956869, {{[0-9]+}}(%esp), %ecx # imm = 0xBAFAFAFB
; X86-NEXT:    rorl %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $2, %ecx
; X86-NEXT:    setb %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_even_bit31:
; X64:       # %bb.0:
; X64-NEXT:    imull $-1157956869, %edi, %ecx # imm = 0xBAFAFAFB
; X64-NEXT:    rorl %ecx
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $2, %ecx
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %urem = urem i32 %X, 2147483750
  %cmp = icmp eq i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

;------------------------------------------------------------------------------;
; Special case
;------------------------------------------------------------------------------;

; 'NE' predicate is fine too.
define i32 @test_urem_odd_setne(i32 %X) nounwind {
; X86-LABEL: test_urem_odd_setne:
; X86:       # %bb.0:
; X86-NEXT:    imull $-858993459, {{[0-9]+}}(%esp), %ecx # imm = 0xCCCCCCCD
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $858993460, %ecx # imm = 0x33333334
; X86-NEXT:    setae %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_odd_setne:
; X64:       # %bb.0:
; X64-NEXT:    imull $-858993459, %edi, %ecx # imm = 0xCCCCCCCD
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $858993460, %ecx # imm = 0x33333334
; X64-NEXT:    setae %al
; X64-NEXT:    retq
  %urem = urem i32 %X, 5
  %cmp = icmp ne i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; The fold is only valid for positive divisors, negative-ones should be negated.
define i32 @test_urem_negative_odd(i32 %X) nounwind {
; X86-LABEL: test_urem_negative_odd:
; X86:       # %bb.0:
; X86-NEXT:    imull $858993459, {{[0-9]+}}(%esp), %ecx # imm = 0x33333333
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $2, %ecx
; X86-NEXT:    setae %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_negative_odd:
; X64:       # %bb.0:
; X64-NEXT:    imull $858993459, %edi, %ecx # imm = 0x33333333
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $2, %ecx
; X64-NEXT:    setae %al
; X64-NEXT:    retq
  %urem = urem i32 %X, -5
  %cmp = icmp ne i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}
define i32 @test_urem_negative_even(i32 %X) nounwind {
; X86-LABEL: test_urem_negative_even:
; X86:       # %bb.0:
; X86-NEXT:    imull $-920350135, {{[0-9]+}}(%esp), %ecx # imm = 0xC9249249
; X86-NEXT:    rorl %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $2, %ecx
; X86-NEXT:    setae %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_negative_even:
; X64:       # %bb.0:
; X64-NEXT:    imull $-920350135, %edi, %ecx # imm = 0xC9249249
; X64-NEXT:    rorl %ecx
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $2, %ecx
; X64-NEXT:    setae %al
; X64-NEXT:    retq
  %urem = urem i32 %X, -14
  %cmp = icmp ne i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

;------------------------------------------------------------------------------;
; Negative tests
;------------------------------------------------------------------------------;

; We can lower remainder of division by one much better elsewhere.
define i32 @test_urem_one(i32 %X) nounwind {
; CHECK-LABEL: test_urem_one:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    ret{{[l|q]}}
  %urem = urem i32 %X, 1
  %cmp = icmp eq i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; We can lower remainder of division by powers of two much better elsewhere.
define i32 @test_urem_pow2(i32 %X) nounwind {
; X86-LABEL: test_urem_pow2:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    testb $15, {{[0-9]+}}(%esp)
; X86-NEXT:    sete %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_pow2:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    testb $15, %dil
; X64-NEXT:    sete %al
; X64-NEXT:    retq
  %urem = urem i32 %X, 16
  %cmp = icmp eq i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; The fold is only valid for positive divisors, and we can't negate INT_MIN.
define i32 @test_urem_int_min(i32 %X) nounwind {
; X86-LABEL: test_urem_int_min:
; X86:       # %bb.0:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    testl $2147483647, {{[0-9]+}}(%esp) # imm = 0x7FFFFFFF
; X86-NEXT:    sete %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_int_min:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    testl $2147483647, %edi # imm = 0x7FFFFFFF
; X64-NEXT:    sete %al
; X64-NEXT:    retq
  %urem = urem i32 %X, 2147483648
  %cmp = icmp eq i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; We can lower remainder of division by all-ones much better elsewhere.
define i32 @test_urem_allones(i32 %X) nounwind {
; X86-LABEL: test_urem_allones:
; X86:       # %bb.0:
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    cmpl $2, %ecx
; X86-NEXT:    setb %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_allones:
; X64:       # %bb.0:
; X64-NEXT:    negl %edi
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl $2, %edi
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %urem = urem i32 %X, 4294967295
  %cmp = icmp eq i32 %urem, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret
}

; Check illegal types.

; https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=34366
define void @ossfuzz34366() {
; X86-LABEL: ossfuzz34366:
; X86:       # %bb.0:
; X86-NEXT:    movl (%eax), %eax
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    andl $2147483647, %ecx # imm = 0x7FFFFFFF
; X86-NEXT:    orl %eax, %ecx
; X86-NEXT:    orl %eax, %ecx
; X86-NEXT:    orl %eax, %ecx
; X86-NEXT:    orl %eax, %ecx
; X86-NEXT:    sete (%eax)
; X86-NEXT:    retl
;
; X64-LABEL: ossfuzz34366:
; X64:       # %bb.0:
; X64-NEXT:    movq (%rax), %rax
; X64-NEXT:    movabsq $9223372036854775807, %rcx # imm = 0x7FFFFFFFFFFFFFFF
; X64-NEXT:    andq %rax, %rcx
; X64-NEXT:    orq %rax, %rcx
; X64-NEXT:    orq %rax, %rcx
; X64-NEXT:    orq %rax, %rcx
; X64-NEXT:    sete (%rax)
; X64-NEXT:    retq
  %L10 = load i448, i448* undef, align 4
  %B18 = urem i448 %L10, -363419362147803445274661903944002267176820680343659030140745099590319644056698961663095525356881782780381260803133088966767300814307328
  %C13 = icmp ule i448 %B18, 0
  store i1 %C13, i1* undef, align 1
  ret void
}
