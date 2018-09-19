; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-linux-gnu                       -global-isel -verify-machineinstrs < %s -o - | FileCheck %s --check-prefix=ALL --check-prefix=SSE_FAST
; RUN: llc -mtriple=x86_64-linux-gnu -regbankselect-greedy -global-isel -verify-machineinstrs < %s -o - | FileCheck %s --check-prefix=ALL --check-prefix=SSE_GREEDY

define i1 @test_load_i1(i1 * %p1) {
; ALL-LABEL: test_load_i1:
; ALL:       # %bb.0:
; ALL-NEXT:    movb (%rdi), %al
; ALL-NEXT:    retq
  %r = load i1, i1* %p1
  ret i1 %r
}

define i8 @test_load_i8(i8 * %p1) {
; ALL-LABEL: test_load_i8:
; ALL:       # %bb.0:
; ALL-NEXT:    movb (%rdi), %al
; ALL-NEXT:    retq
  %r = load i8, i8* %p1
  ret i8 %r
}

define i16 @test_load_i16(i16 * %p1) {
; ALL-LABEL: test_load_i16:
; ALL:       # %bb.0:
; ALL-NEXT:    movzwl (%rdi), %eax
; ALL-NEXT:    retq
  %r = load i16, i16* %p1
  ret i16 %r
}

define i32 @test_load_i32(i32 * %p1) {
; ALL-LABEL: test_load_i32:
; ALL:       # %bb.0:
; ALL-NEXT:    movl (%rdi), %eax
; ALL-NEXT:    retq
  %r = load i32, i32* %p1
  ret i32 %r
}

define i64 @test_load_i64(i64 * %p1) {
; ALL-LABEL: test_load_i64:
; ALL:       # %bb.0:
; ALL-NEXT:    movq (%rdi), %rax
; ALL-NEXT:    retq
  %r = load i64, i64* %p1
  ret i64 %r
}

define float @test_load_float(float * %p1) {
; SSE-LABEL: test_load_float:
; SSE:       # %bb.0:
; SSE-NEXT:    movl (%rdi), %eax
; SSE-NEXT:    movd %eax, %xmm0
; SSE-NEXT:    retq
;
; ALL-LABEL: test_load_float:
; ALL:       # %bb.0:
; ALL-NEXT:    movl (%rdi), %eax
; ALL-NEXT:    movd %eax, %xmm0
; ALL-NEXT:    retq
  %r = load float, float* %p1
  ret float %r
}

define double @test_load_double(double * %p1) {
; SSE-LABEL: test_load_double:
; SSE:       # %bb.0:
; SSE-NEXT:    movq (%rdi), %rax
; SSE-NEXT:    movq %rax, %xmm0
; SSE-NEXT:    retq
;
; ALL-LABEL: test_load_double:
; ALL:       # %bb.0:
; ALL-NEXT:    movq (%rdi), %rax
; ALL-NEXT:    movq %rax, %xmm0
; ALL-NEXT:    retq
  %r = load double, double* %p1
  ret double %r
}

define i1 * @test_store_i1(i1 %val, i1 * %p1) {
; ALL-LABEL: test_store_i1:
; ALL:       # %bb.0:
; ALL-NEXT:    movq %rsi, %rax
; ALL-NEXT:    andb $1, %dil
; ALL-NEXT:    movb %dil, (%rsi)
; ALL-NEXT:    retq
  store i1 %val, i1* %p1
  ret i1 * %p1;
}

define i32 * @test_store_i32(i32 %val, i32 * %p1) {
; ALL-LABEL: test_store_i32:
; ALL:       # %bb.0:
; ALL-NEXT:    movq %rsi, %rax
; ALL-NEXT:    movl %edi, (%rsi)
; ALL-NEXT:    retq
  store i32 %val, i32* %p1
  ret i32 * %p1;
}

define i64 * @test_store_i64(i64 %val, i64 * %p1) {
; ALL-LABEL: test_store_i64:
; ALL:       # %bb.0:
; ALL-NEXT:    movq %rsi, %rax
; ALL-NEXT:    movq %rdi, (%rsi)
; ALL-NEXT:    retq
  store i64 %val, i64* %p1
  ret i64 * %p1;
}

define float * @test_store_float(float %val, float * %p1) {
;
; SSE_FAST-LABEL: test_store_float:
; SSE_FAST:       # %bb.0:
; SSE_FAST-NEXT:    movq %rdi, %rax
; SSE_FAST-NEXT:    movd %xmm0, %ecx
; SSE_FAST-NEXT:    movl %ecx, (%rdi)
; SSE_FAST-NEXT:    retq
;
; SSE_GREEDY-LABEL: test_store_float:
; SSE_GREEDY:       # %bb.0:
; SSE_GREEDY-NEXT:    movq %rdi, %rax
; SSE_GREEDY-NEXT:    movss %xmm0, (%rdi)
; SSE_GREEDY-NEXT:    retq
  store float %val, float* %p1
  ret float * %p1;
}

define double * @test_store_double(double %val, double * %p1) {
;
; SSE_FAST-LABEL: test_store_double:
; SSE_FAST:       # %bb.0:
; SSE_FAST-NEXT:    movq %rdi, %rax
; SSE_FAST-NEXT:    movq %xmm0, %rcx
; SSE_FAST-NEXT:    movq %rcx, (%rdi)
; SSE_FAST-NEXT:    retq
;
; SSE_GREEDY-LABEL: test_store_double:
; SSE_GREEDY:       # %bb.0:
; SSE_GREEDY-NEXT:    movq %rdi, %rax
; SSE_GREEDY-NEXT:    movsd %xmm0, (%rdi)
; SSE_GREEDY-NEXT:    retq
  store double %val, double* %p1
  ret double * %p1;
}

define i32* @test_load_ptr(i32** %ptr1) {
; ALL-LABEL: test_load_ptr:
; ALL:       # %bb.0:
; ALL-NEXT:    movq (%rdi), %rax
; ALL-NEXT:    retq
  %p = load i32*, i32** %ptr1
  ret i32* %p
}

define void @test_store_ptr(i32** %ptr1, i32* %a) {
; ALL-LABEL: test_store_ptr:
; ALL:       # %bb.0:
; ALL-NEXT:    movq %rsi, (%rdi)
; ALL-NEXT:    retq
  store i32* %a, i32** %ptr1
  ret void
}

define i32 @test_gep_folding(i32* %arr, i32 %val) {
; ALL-LABEL: test_gep_folding:
; ALL:       # %bb.0:
; ALL-NEXT:    movl %esi, 20(%rdi)
; ALL-NEXT:    movl 20(%rdi), %eax
; ALL-NEXT:    retq
  %arrayidx = getelementptr i32, i32* %arr, i32 5
  store i32 %val, i32* %arrayidx
  %r = load i32, i32* %arrayidx
  ret i32 %r
}

; check that gep index doesn't folded into memory operand
define i32 @test_gep_folding_largeGepIndex(i32* %arr, i32 %val) {
; ALL-LABEL: test_gep_folding_largeGepIndex:
; ALL:       # %bb.0:
; ALL-NEXT:    movabsq $228719476720, %rax # imm = 0x3540BE3FF0
; ALL-NEXT:    leaq (%rdi,%rax), %rax
; ALL-NEXT:    movl %esi, (%rax)
; ALL-NEXT:    movl (%rax), %eax
; ALL-NEXT:    retq
  %arrayidx = getelementptr i32, i32* %arr, i64 57179869180
  store i32 %val, i32* %arrayidx
  %r = load i32, i32* %arrayidx
  ret i32 %r
}
