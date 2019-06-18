; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-linux -mattr=+sse4.2 | FileCheck %s --check-prefix=X86 --check-prefix=X86-SSE
; RUN: llc < %s -mtriple=i686-linux -mattr=+avx    | FileCheck %s --check-prefix=X86 --check-prefix=X86-AVX --check-prefix=X86-AVX1
; RUN: llc < %s -mtriple=i686-linux -mattr=+avx2   | FileCheck %s --check-prefix=X86 --check-prefix=X86-AVX --check-prefix=X86-AVX2
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+sse4.2 | FileCheck %s --check-prefix=X64 --check-prefix=X64-SSE
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+avx    | FileCheck %s --check-prefix=X64 --check-prefix=X64-AVX --check-prefix=X64-AVX1
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+avx2   | FileCheck %s --check-prefix=X64 --check-prefix=X64-AVX --check-prefix=X64-AVX2

; PR27708

define <7 x i64> @load7_aligned(<7 x i64>* %x) {
; X86-SSE-LABEL: load7_aligned:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE-NEXT:    movaps (%ecx), %xmm0
; X86-SSE-NEXT:    movaps 16(%ecx), %xmm1
; X86-SSE-NEXT:    movaps 32(%ecx), %xmm2
; X86-SSE-NEXT:    movl 48(%ecx), %edx
; X86-SSE-NEXT:    movl 52(%ecx), %ecx
; X86-SSE-NEXT:    movl %ecx, 52(%eax)
; X86-SSE-NEXT:    movl %edx, 48(%eax)
; X86-SSE-NEXT:    movaps %xmm2, 32(%eax)
; X86-SSE-NEXT:    movaps %xmm1, 16(%eax)
; X86-SSE-NEXT:    movaps %xmm0, (%eax)
; X86-SSE-NEXT:    retl $4
;
; X86-AVX-LABEL: load7_aligned:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX-NEXT:    vmovaps (%ecx), %ymm0
; X86-AVX-NEXT:    vmovaps 48(%ecx), %xmm1
; X86-AVX-NEXT:    vextractps $1, %xmm1, 52(%eax)
; X86-AVX-NEXT:    vmovss %xmm1, 48(%eax)
; X86-AVX-NEXT:    vmovaps 32(%ecx), %xmm1
; X86-AVX-NEXT:    vmovaps %xmm1, 32(%eax)
; X86-AVX-NEXT:    vmovaps %ymm0, (%eax)
; X86-AVX-NEXT:    vzeroupper
; X86-AVX-NEXT:    retl $4
;
; X64-SSE-LABEL: load7_aligned:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movq %rdi, %rax
; X64-SSE-NEXT:    movaps (%rsi), %xmm0
; X64-SSE-NEXT:    movaps 16(%rsi), %xmm1
; X64-SSE-NEXT:    movaps 32(%rsi), %xmm2
; X64-SSE-NEXT:    movq 48(%rsi), %rcx
; X64-SSE-NEXT:    movq %rcx, 48(%rdi)
; X64-SSE-NEXT:    movaps %xmm2, 32(%rdi)
; X64-SSE-NEXT:    movaps %xmm1, 16(%rdi)
; X64-SSE-NEXT:    movaps %xmm0, (%rdi)
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: load7_aligned:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    movq %rdi, %rax
; X64-AVX-NEXT:    vmovaps (%rsi), %ymm0
; X64-AVX-NEXT:    movq 48(%rsi), %rcx
; X64-AVX-NEXT:    movq %rcx, 48(%rdi)
; X64-AVX-NEXT:    vmovaps 32(%rsi), %xmm1
; X64-AVX-NEXT:    vmovaps %xmm1, 32(%rdi)
; X64-AVX-NEXT:    vmovaps %ymm0, (%rdi)
; X64-AVX-NEXT:    vzeroupper
; X64-AVX-NEXT:    retq
  %x1 = load <7 x i64>, <7 x i64>* %x
  ret <7 x i64> %x1
}

define <7 x i64> @load7_unaligned(<7 x i64>* %x) {
; X86-SSE-LABEL: load7_unaligned:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE-NEXT:    movups (%ecx), %xmm0
; X86-SSE-NEXT:    movups 16(%ecx), %xmm1
; X86-SSE-NEXT:    movups 32(%ecx), %xmm2
; X86-SSE-NEXT:    movl 48(%ecx), %edx
; X86-SSE-NEXT:    movl 52(%ecx), %ecx
; X86-SSE-NEXT:    movl %ecx, 52(%eax)
; X86-SSE-NEXT:    movl %edx, 48(%eax)
; X86-SSE-NEXT:    movaps %xmm2, 32(%eax)
; X86-SSE-NEXT:    movaps %xmm1, 16(%eax)
; X86-SSE-NEXT:    movaps %xmm0, (%eax)
; X86-SSE-NEXT:    retl $4
;
; X86-AVX-LABEL: load7_unaligned:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX-NEXT:    vmovups (%ecx), %ymm0
; X86-AVX-NEXT:    vmovups 32(%ecx), %xmm1
; X86-AVX-NEXT:    movl 48(%ecx), %edx
; X86-AVX-NEXT:    movl 52(%ecx), %ecx
; X86-AVX-NEXT:    movl %ecx, 52(%eax)
; X86-AVX-NEXT:    movl %edx, 48(%eax)
; X86-AVX-NEXT:    vmovaps %xmm1, 32(%eax)
; X86-AVX-NEXT:    vmovaps %ymm0, (%eax)
; X86-AVX-NEXT:    vzeroupper
; X86-AVX-NEXT:    retl $4
;
; X64-SSE-LABEL: load7_unaligned:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movq %rdi, %rax
; X64-SSE-NEXT:    movups (%rsi), %xmm0
; X64-SSE-NEXT:    movups 16(%rsi), %xmm1
; X64-SSE-NEXT:    movups 32(%rsi), %xmm2
; X64-SSE-NEXT:    movq 48(%rsi), %rcx
; X64-SSE-NEXT:    movq %rcx, 48(%rdi)
; X64-SSE-NEXT:    movaps %xmm2, 32(%rdi)
; X64-SSE-NEXT:    movaps %xmm1, 16(%rdi)
; X64-SSE-NEXT:    movaps %xmm0, (%rdi)
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: load7_unaligned:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    movq %rdi, %rax
; X64-AVX-NEXT:    vmovups (%rsi), %ymm0
; X64-AVX-NEXT:    vmovups 32(%rsi), %xmm1
; X64-AVX-NEXT:    movq 48(%rsi), %rcx
; X64-AVX-NEXT:    movq %rcx, 48(%rdi)
; X64-AVX-NEXT:    vmovaps %xmm1, 32(%rdi)
; X64-AVX-NEXT:    vmovaps %ymm0, (%rdi)
; X64-AVX-NEXT:    vzeroupper
; X64-AVX-NEXT:    retq
  %x1 = load <7 x i64>, <7 x i64>* %x, align 1
  ret <7 x i64> %x1
}

; PR42305 - https://bugs.llvm.org/show_bug.cgi?id=42305

define void @load_split(<8 x float>* %ld, <4 x float>* %st1, <4 x float>* %st2) nounwind {
; X86-SSE-LABEL: load_split:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-SSE-NEXT:    movups (%edx), %xmm0
; X86-SSE-NEXT:    movups 16(%edx), %xmm1
; X86-SSE-NEXT:    movups %xmm0, (%ecx)
; X86-SSE-NEXT:    movups %xmm1, (%eax)
; X86-SSE-NEXT:    retl
;
; X86-AVX-LABEL: load_split:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-AVX-NEXT:    vmovups (%edx), %xmm0
; X86-AVX-NEXT:    vmovups 16(%edx), %xmm1
; X86-AVX-NEXT:    vmovups %xmm0, (%ecx)
; X86-AVX-NEXT:    vmovups %xmm1, (%eax)
; X86-AVX-NEXT:    retl
;
; X64-SSE-LABEL: load_split:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movups (%rdi), %xmm0
; X64-SSE-NEXT:    movups 16(%rdi), %xmm1
; X64-SSE-NEXT:    movups %xmm0, (%rsi)
; X64-SSE-NEXT:    movups %xmm1, (%rdx)
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: load_split:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovups (%rdi), %xmm0
; X64-AVX-NEXT:    vmovups 16(%rdi), %xmm1
; X64-AVX-NEXT:    vmovups %xmm0, (%rsi)
; X64-AVX-NEXT:    vmovups %xmm1, (%rdx)
; X64-AVX-NEXT:    retq
  %t256 = load <8 x float>, <8 x float>* %ld, align 1
  %b128 = shufflevector <8 x float> %t256, <8 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  store <4 x float> %b128, <4 x float>* %st1, align 1
  %t128 = shufflevector <8 x float> %t256, <8 x float> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  store <4 x float> %t128, <4 x float>* %st2, align 1
  ret void
}

define void @load_split_more(float* %src, i32* %idx, float* %dst) nounwind {
; X86-SSE-LABEL: load_split_more:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    pushl %esi
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-SSE-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-SSE-NEXT:    movl (%edx), %esi
; X86-SSE-NEXT:    movups (%ecx), %xmm0
; X86-SSE-NEXT:    movups 16(%ecx), %xmm1
; X86-SSE-NEXT:    movups %xmm0, (%eax,%esi,4)
; X86-SSE-NEXT:    movl 4(%edx), %ecx
; X86-SSE-NEXT:    movups %xmm1, (%eax,%ecx,4)
; X86-SSE-NEXT:    popl %esi
; X86-SSE-NEXT:    retl
;
; X86-AVX-LABEL: load_split_more:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    pushl %esi
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-AVX-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-AVX-NEXT:    movl (%edx), %esi
; X86-AVX-NEXT:    vmovups (%ecx), %xmm0
; X86-AVX-NEXT:    vmovups 16(%ecx), %xmm1
; X86-AVX-NEXT:    vmovups %xmm0, (%eax,%esi,4)
; X86-AVX-NEXT:    movl 4(%edx), %ecx
; X86-AVX-NEXT:    vmovups %xmm1, (%eax,%ecx,4)
; X86-AVX-NEXT:    popl %esi
; X86-AVX-NEXT:    retl
;
; X64-SSE-LABEL: load_split_more:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movslq (%rsi), %rax
; X64-SSE-NEXT:    movups (%rdi), %xmm0
; X64-SSE-NEXT:    movups 16(%rdi), %xmm1
; X64-SSE-NEXT:    movups %xmm0, (%rdx,%rax,4)
; X64-SSE-NEXT:    movslq 4(%rsi), %rax
; X64-SSE-NEXT:    movups %xmm1, (%rdx,%rax,4)
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: load_split_more:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    movslq (%rsi), %rax
; X64-AVX-NEXT:    vmovups (%rdi), %xmm0
; X64-AVX-NEXT:    vmovups 16(%rdi), %xmm1
; X64-AVX-NEXT:    vmovups %xmm0, (%rdx,%rax,4)
; X64-AVX-NEXT:    movslq 4(%rsi), %rax
; X64-AVX-NEXT:    vmovups %xmm1, (%rdx,%rax,4)
; X64-AVX-NEXT:    retq
  %v.i = bitcast float* %src to <8 x float>*
  %tmp = load <8 x float>, <8 x float>* %v.i, align 1
  %tmp1 = load i32, i32* %idx, align 4
  %idx.ext = sext i32 %tmp1 to i64
  %add.ptr1 = getelementptr inbounds float, float* %dst, i64 %idx.ext
  %extract = shufflevector <8 x float> %tmp, <8 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %v.i11 = bitcast float* %add.ptr1 to <4 x float>*
  store <4 x float> %extract, <4 x float>* %v.i11, align 1
  %arrayidx2 = getelementptr inbounds i32, i32* %idx, i64 1
  %tmp2 = load i32, i32* %arrayidx2, align 4
  %idx.ext3 = sext i32 %tmp2 to i64
  %add.ptr4 = getelementptr inbounds float, float* %dst, i64 %idx.ext3
  %extract5 = shufflevector <8 x float> %tmp, <8 x float> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %v.i10 = bitcast float* %add.ptr4 to <4 x float>*
  store <4 x float> %extract5, <4 x float>* %v.i10, align 1
  ret void
}
