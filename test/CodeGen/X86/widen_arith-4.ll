; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=CHECK,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.2 | FileCheck %s --check-prefixes=CHECK,SSE41

; Widen a v5i16 to v8i16 to do a vector sub and multiple

define void @update(<5 x i16>* %dst, <5 x i16>* %src, i32 %n) nounwind {
; SSE2-LABEL: update:
; SSE2:       # %bb.0: # %entry
; SSE2-NEXT:    movq %rdi, -{{[0-9]+}}(%rsp)
; SSE2-NEXT:    movq %rsi, -{{[0-9]+}}(%rsp)
; SSE2-NEXT:    movl %edx, -{{[0-9]+}}(%rsp)
; SSE2-NEXT:    movabsq $4295032833, %rax # imm = 0x100010001
; SSE2-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; SSE2-NEXT:    movw $0, -{{[0-9]+}}(%rsp)
; SSE2-NEXT:    movl $0, -{{[0-9]+}}(%rsp)
; SSE2-NEXT:    movdqa {{.*#+}} xmm0 = <271,271,271,271,271,u,u,u>
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = <2,4,2,2,2,u,u,u>
; SSE2-NEXT:    .p2align 4, 0x90
; SSE2-NEXT:  .LBB0_1: # %forcond
; SSE2-NEXT:    # =>This Inner Loop Header: Depth=1
; SSE2-NEXT:    movl -{{[0-9]+}}(%rsp), %eax
; SSE2-NEXT:    cmpl -{{[0-9]+}}(%rsp), %eax
; SSE2-NEXT:    jge .LBB0_3
; SSE2-NEXT:  # %bb.2: # %forbody
; SSE2-NEXT:    # in Loop: Header=BB0_1 Depth=1
; SSE2-NEXT:    movslq -{{[0-9]+}}(%rsp), %rax
; SSE2-NEXT:    movq -{{[0-9]+}}(%rsp), %rcx
; SSE2-NEXT:    shlq $4, %rax
; SSE2-NEXT:    movq -{{[0-9]+}}(%rsp), %rdx
; SSE2-NEXT:    movdqa (%rdx,%rax), %xmm2
; SSE2-NEXT:    psubw %xmm0, %xmm2
; SSE2-NEXT:    pmullw %xmm1, %xmm2
; SSE2-NEXT:    movq %xmm2, (%rcx,%rax)
; SSE2-NEXT:    pextrw $4, %xmm2, %edx
; SSE2-NEXT:    movw %dx, 8(%rcx,%rax)
; SSE2-NEXT:    incl -{{[0-9]+}}(%rsp)
; SSE2-NEXT:    jmp .LBB0_1
; SSE2-NEXT:  .LBB0_3: # %afterfor
; SSE2-NEXT:    retq
;
; SSE41-LABEL: update:
; SSE41:       # %bb.0: # %entry
; SSE41-NEXT:    movq %rdi, -{{[0-9]+}}(%rsp)
; SSE41-NEXT:    movq %rsi, -{{[0-9]+}}(%rsp)
; SSE41-NEXT:    movl %edx, -{{[0-9]+}}(%rsp)
; SSE41-NEXT:    movabsq $4295032833, %rax # imm = 0x100010001
; SSE41-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; SSE41-NEXT:    movw $0, -{{[0-9]+}}(%rsp)
; SSE41-NEXT:    movl $0, -{{[0-9]+}}(%rsp)
; SSE41-NEXT:    movdqa {{.*#+}} xmm0 = <271,271,271,271,271,u,u,u>
; SSE41-NEXT:    .p2align 4, 0x90
; SSE41-NEXT:  .LBB0_1: # %forcond
; SSE41-NEXT:    # =>This Inner Loop Header: Depth=1
; SSE41-NEXT:    movl -{{[0-9]+}}(%rsp), %eax
; SSE41-NEXT:    cmpl -{{[0-9]+}}(%rsp), %eax
; SSE41-NEXT:    jge .LBB0_3
; SSE41-NEXT:  # %bb.2: # %forbody
; SSE41-NEXT:    # in Loop: Header=BB0_1 Depth=1
; SSE41-NEXT:    movslq -{{[0-9]+}}(%rsp), %rax
; SSE41-NEXT:    movq -{{[0-9]+}}(%rsp), %rcx
; SSE41-NEXT:    shlq $4, %rax
; SSE41-NEXT:    movq -{{[0-9]+}}(%rsp), %rdx
; SSE41-NEXT:    movdqa (%rdx,%rax), %xmm1
; SSE41-NEXT:    psubw %xmm0, %xmm1
; SSE41-NEXT:    movdqa %xmm1, %xmm2
; SSE41-NEXT:    psllw $2, %xmm2
; SSE41-NEXT:    psllw $1, %xmm1
; SSE41-NEXT:    pblendw {{.*#+}} xmm2 = xmm1[0],xmm2[1],xmm1[2,3,4,5,6,7]
; SSE41-NEXT:    pextrw $4, %xmm1, 8(%rcx,%rax)
; SSE41-NEXT:    movq %xmm2, (%rcx,%rax)
; SSE41-NEXT:    incl -{{[0-9]+}}(%rsp)
; SSE41-NEXT:    jmp .LBB0_1
; SSE41-NEXT:  .LBB0_3: # %afterfor
; SSE41-NEXT:    retq
entry:
	%dst.addr = alloca <5 x i16>*
	%src.addr = alloca <5 x i16>*
	%n.addr = alloca i32
	%v = alloca <5 x i16>, align 16
	%i = alloca i32, align 4
	store <5 x i16>* %dst, <5 x i16>** %dst.addr
	store <5 x i16>* %src, <5 x i16>** %src.addr
	store i32 %n, i32* %n.addr
	store <5 x i16> < i16 1, i16 1, i16 1, i16 0, i16 0 >, <5 x i16>* %v
	store i32 0, i32* %i
	br label %forcond

forcond:
	%tmp = load i32, i32* %i
	%tmp1 = load i32, i32* %n.addr
	%cmp = icmp slt i32 %tmp, %tmp1
	br i1 %cmp, label %forbody, label %afterfor

forbody:
	%tmp2 = load i32, i32* %i
	%tmp3 = load <5 x i16>*, <5 x i16>** %dst.addr
	%arrayidx = getelementptr <5 x i16>, <5 x i16>* %tmp3, i32 %tmp2
	%tmp4 = load i32, i32* %i
	%tmp5 = load <5 x i16>*, <5 x i16>** %src.addr
	%arrayidx6 = getelementptr <5 x i16>, <5 x i16>* %tmp5, i32 %tmp4
	%tmp7 = load <5 x i16>, <5 x i16>* %arrayidx6
	%sub = sub <5 x i16> %tmp7, < i16 271, i16 271, i16 271, i16 271, i16 271 >
	%mul = mul <5 x i16> %sub, < i16 2, i16 4, i16 2, i16 2, i16 2 >
	store <5 x i16> %mul, <5 x i16>* %arrayidx
	br label %forinc

forinc:
	%tmp8 = load i32, i32* %i
	%inc = add i32 %tmp8, 1
	store i32 %inc, i32* %i
	br label %forcond

afterfor:
	ret void
}

