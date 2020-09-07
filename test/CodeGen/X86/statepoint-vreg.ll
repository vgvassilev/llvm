; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -max-registers-for-gc-values=4 -fixup-allow-gcptr-in-csr=true < %s | FileCheck %s

target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

declare i1 @return_i1()
declare void @func()
declare void @"some_call"(i64 addrspace(1)*)
declare void @consume(i32 addrspace(1)*)
declare i32 @consume1(i32) gc "statepoint-example"
declare void @consume2(i32 addrspace(1)*, i32 addrspace(1)*)
declare void @consume3(float) gc "statepoint-example"
declare float @consume4(i64) gc "statepoint-example"
declare void @consume5(i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*)

declare void @use1(i32 addrspace(1)*, i8 addrspace(1)*)
declare i32 @"personality_function"()

; test most simple relocate
define i1 @test_relocate(i32 addrspace(1)* %a) gc "statepoint-example" {
; CHECK-LABEL: test_relocate:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset %rbx, -24
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movq %rdi, (%rsp)
; CHECK-NEXT:    callq return_i1
; CHECK-NEXT:  .Ltmp0:
; CHECK-NEXT:    movl %eax, %ebp
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    callq consume
; CHECK-NEXT:    movl %ebp, %eax
; CHECK-NEXT:    addq $8, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %safepoint_token = tail call token (i64, i32, i1 ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_i1f(i64 0, i32 0, i1 ()* @return_i1, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %a)]
  %rel1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  %res1 = call zeroext i1 @llvm.experimental.gc.result.i1(token %safepoint_token)
  call void @consume(i32 addrspace(1)* %rel1)
  ret i1 %res1
}

; test pointer variables intermixed with pointer constants
define void @test_mixed(i32 addrspace(1)* %a, i32 addrspace(1)* %b, i32 addrspace(1)* %c) gc "statepoint-example" {
; CHECK-LABEL: test_mixed:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %r15
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    subq $32, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    .cfi_offset %rbx, -32
; CHECK-NEXT:    .cfi_offset %r14, -24
; CHECK-NEXT:    .cfi_offset %r15, -16
; CHECK-NEXT:    movq %rdx, %r14
; CHECK-NEXT:    movq %rsi, %r15
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movq %rsi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq %rdx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq %rdi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp1:
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    xorl %esi, %esi
; CHECK-NEXT:    movq %r15, %rdx
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    movq %r14, %r8
; CHECK-NEXT:    callq consume5
; CHECK-NEXT:    addq $32, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %r15
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %safepoint_token = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %a, i32 addrspace(1)* null, i32 addrspace(1)* %b, i32 addrspace(1)* null, i32 addrspace(1)* %c)]
  %rel1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  %rel2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 1)
  %rel3 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 2, i32 2)
  %rel4 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 3, i32 3)
  %rel5 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 4, i32 4)
  call void @consume5(i32 addrspace(1)* %rel1, i32 addrspace(1)* %rel2, i32 addrspace(1)* %rel3, i32 addrspace(1)* %rel4, i32 addrspace(1)* %rel5)
  ret void
}

; same as above, but for alloca
define i32 addrspace(1)* @test_alloca(i32 addrspace(1)* %ptr) gc "statepoint-example" {
; CHECK-LABEL: test_alloca:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    subq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset %rbx, -24
; CHECK-NEXT:    .cfi_offset %r14, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movq %rdi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq %rdi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    callq return_i1
; CHECK-NEXT:  .Ltmp2:
; CHECK-NEXT:    movq {{[0-9]+}}(%rsp), %r14
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    callq consume
; CHECK-NEXT:    movq %r14, %rax
; CHECK-NEXT:    addq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %alloca = alloca i32 addrspace(1)*, align 8
  store i32 addrspace(1)* %ptr, i32 addrspace(1)** %alloca
  %safepoint_token = call token (i64, i32, i1 ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_i1f(i64 0, i32 0, i1 ()* @return_i1, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)** %alloca, i32 addrspace(1)* %ptr)]
  %rel1 = load i32 addrspace(1)*, i32 addrspace(1)** %alloca
  %rel2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 1)
  call void @consume(i32 addrspace(1)* %rel2)
  ret i32 addrspace(1)* %rel1
}

; test base != derived
define void @test_base_derived(i32 addrspace(1)* %base, i32 addrspace(1)* %derived) gc "statepoint-example" {
; CHECK-LABEL: test_base_derived:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    subq $16, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rsi, %rbx
; CHECK-NEXT:    movq %rdi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp3:
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    callq consume
; CHECK-NEXT:    addq $16, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %safepoint_token = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %base, i32 addrspace(1)* %derived)]
  %reloc = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 1)
  call void @consume(i32 addrspace(1)* %reloc)
  ret void
}

; deopt GC pointer not present in GC args must be spilled
define void @test_deopt_gcpointer(i32 addrspace(1)* %a, i32 addrspace(1)* %b) gc "statepoint-example" {
; CHECK-LABEL: test_deopt_gcpointer:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    subq $16, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rsi, %rbx
; CHECK-NEXT:    movq %rsi, (%rsp)
; CHECK-NEXT:    movq %rdi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp4:
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    callq consume
; CHECK-NEXT:    addq $16, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %safepoint_token = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* @func, i32 0, i32 0, i32 0, i32 0) ["deopt" (i32 addrspace(1)* %a), "gc-live" (i32 addrspace(1)* %b)]
  %rel = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  call void @consume(i32 addrspace(1)* %rel)
  ret void
}

;; Two gc.relocates of the same input, should require only a single spill/fill
define void @test_gcrelocate_uniqueing(i32 addrspace(1)* %ptr) gc "statepoint-example" {
; CHECK-LABEL: test_gcrelocate_uniqueing:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    subq $16, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movq %rdi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp5:
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    movq %rbx, %rsi
; CHECK-NEXT:    callq consume2
; CHECK-NEXT:    addq $16, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %tok = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* @func, i32 0, i32 0, i32 0, i32 0) ["deopt" (i32 addrspace(1)* %ptr, i32 undef), "gc-live" (i32 addrspace(1)* %ptr, i32 addrspace(1)* %ptr)]
  %a = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %tok, i32 0, i32 0)
  %b = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %tok, i32 1, i32 1)
  call void @consume2(i32 addrspace(1)* %a, i32 addrspace(1)* %b)
  ret void
}

; Two gc.relocates of a bitcasted pointer should only require a single spill/fill
define void @test_gcptr_uniqueing(i32 addrspace(1)* %ptr) gc "statepoint-example" {
; CHECK-LABEL: test_gcptr_uniqueing:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    subq $16, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movq %rdi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp6:
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    movq %rbx, %rsi
; CHECK-NEXT:    callq use1
; CHECK-NEXT:    addq $16, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %ptr2 = bitcast i32 addrspace(1)* %ptr to i8 addrspace(1)*
  %tok = tail call token (i64, i32, void ()*, i32, i32, ...)
      @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* @func, i32 0, i32 0, i32 0, i32 0) ["deopt" (i32 addrspace(1)* %ptr, i32 undef), "gc-live" (i32 addrspace(1)* %ptr, i8 addrspace(1)* %ptr2)]
  %a = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %tok, i32 0, i32 0)
  %b = call i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token %tok, i32 1, i32 1)
  call void @use1(i32 addrspace(1)* %a, i8 addrspace(1)* %b)
  ret void
}

;
; Cross-basicblock relocates are handled with spilling for now.
define i1 @test_cross_bb(i32 addrspace(1)* %a, i1 %external_cond) gc "statepoint-example" {
; CHECK-LABEL: test_cross_bb:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    subq $16, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset %rbx, -32
; CHECK-NEXT:    .cfi_offset %r14, -24
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movl %esi, %ebp
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movq %rdi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    callq return_i1
; CHECK-NEXT:  .Ltmp7:
; CHECK-NEXT:    testb $1, %bpl
; CHECK-NEXT:    je .LBB7_2
; CHECK-NEXT:  # %bb.1: # %left
; CHECK-NEXT:    movl %eax, %r14d
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    callq consume
; CHECK-NEXT:    movl %r14d, %eax
; CHECK-NEXT:    jmp .LBB7_3
; CHECK-NEXT:  .LBB7_2: # %right
; CHECK-NEXT:    movb $1, %al
; CHECK-NEXT:  .LBB7_3: # %right
; CHECK-NEXT:    addq $16, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %safepoint_token = tail call token (i64, i32, i1 ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_i1f(i64 0, i32 0, i1 ()* @return_i1, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %a)]
  br i1 %external_cond, label %left, label %right

left:
  %call1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  %call2 = call zeroext i1 @llvm.experimental.gc.result.i1(token %safepoint_token)
  call void @consume(i32 addrspace(1)* %call1)
  ret i1 %call2

right:
  ret i1 true
}

; No need to check post-regalloc output as it is the same
define i1 @duplicate_reloc() gc "statepoint-example" {
; CHECK-LABEL: duplicate_reloc:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp8:
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp9:
; CHECK-NEXT:    movb $1, %al
; CHECK-NEXT:    popq %rcx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %safepoint_token = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* null, i32 addrspace(1)* null)]
  %base = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  %derived = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 1)
  %safepoint_token2 = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %base, i32 addrspace(1)* %derived)]
  %base_reloc = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token2,  i32 0, i32 0)
  %derived_reloc = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token2,  i32 0, i32 1)
  %cmp1 = icmp eq i32 addrspace(1)* %base_reloc, null
  %cmp2 = icmp eq i32 addrspace(1)* %derived_reloc, null
  %cmp = and i1 %cmp1, %cmp2
  ret i1 %cmp
}

; Vectors cannot go in VRegs
; No need to check post-regalloc output as it is lowered using old scheme
define <2 x i8 addrspace(1)*> @test_vector(<2 x i8 addrspace(1)*> %obj) gc "statepoint-example" {
; CHECK-LABEL: test_vector:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    subq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    movaps %xmm0, (%rsp)
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp10:
; CHECK-NEXT:    movaps (%rsp), %xmm0
; CHECK-NEXT:    addq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %safepoint_token = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (<2 x i8 addrspace(1)*> %obj)]
  %obj.relocated = call coldcc <2 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v2p1i8(token %safepoint_token, i32 0, i32 0) ; (%obj, %obj)
  ret <2 x i8 addrspace(1)*> %obj.relocated
}


; test limit on amount of vregs
define void @test_limit(i32 addrspace(1)* %a, i32 addrspace(1)* %b, i32 addrspace(1)* %c, i32 addrspace(1)* %d, i32 addrspace(1)*  %e) gc "statepoint-example" {
; CHECK-LABEL: test_limit:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %r15
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    pushq %r12
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 40
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 80
; CHECK-NEXT:    .cfi_offset %rbx, -40
; CHECK-NEXT:    .cfi_offset %r12, -32
; CHECK-NEXT:    .cfi_offset %r14, -24
; CHECK-NEXT:    .cfi_offset %r15, -16
; CHECK-NEXT:    movq %r8, %r14
; CHECK-NEXT:    movq %rcx, %r15
; CHECK-NEXT:    movq %rdx, %r12
; CHECK-NEXT:    movq %rsi, %rbx
; CHECK-NEXT:    movq %rcx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq %r8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq %rdx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq %rsi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq %rdi, (%rsp)
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp11:
; CHECK-NEXT:    movq (%rsp), %rdi
; CHECK-NEXT:    movq %rbx, %rsi
; CHECK-NEXT:    movq %r12, %rdx
; CHECK-NEXT:    movq %r15, %rcx
; CHECK-NEXT:    movq %r14, %r8
; CHECK-NEXT:    callq consume5
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 40
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    popq %r12
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %r15
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %safepoint_token = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* @func, i32 0, i32 0, i32 0, i32 0) ["gc-live" (i32 addrspace(1)* %a, i32 addrspace(1)* %b, i32 addrspace(1)* %c, i32 addrspace(1)* %d, i32 addrspace(1)* %e)]
  %rel1 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 0, i32 0)
  %rel2 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 1, i32 1)
  %rel3 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 2, i32 2)
  %rel4 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 3, i32 3)
  %rel5 = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %safepoint_token,  i32 4, i32 4)
  call void @consume5(i32 addrspace(1)* %rel1, i32 addrspace(1)* %rel2, i32 addrspace(1)* %rel3, i32 addrspace(1)* %rel4, i32 addrspace(1)* %rel5)
  ret void
}

define i64 addrspace(1)* @test_basic_invoke(i64 addrspace(1)* %obj,
; CHECK-LABEL: test_basic_invoke:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    subq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset %rbx, -24
; CHECK-NEXT:    .cfi_offset %r14, -16
; CHECK-NEXT:    movq %rsi, %r14
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movq %rdi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq %rsi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:  .Ltmp12:
; CHECK-NEXT:    callq some_call
; CHECK-NEXT:  .Ltmp15:
; CHECK-NEXT:  .Ltmp13:
; CHECK-NEXT:  # %bb.1: # %normal_return
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:  .LBB11_2: # %normal_return
; CHECK-NEXT:    addq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB11_3: # %exceptional_return
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:  .Ltmp14:
; CHECK-NEXT:    movq %r14, %rax
; CHECK-NEXT:    jmp .LBB11_2
                                            i64 addrspace(1)* %obj1) gc "statepoint-example" personality i32 ()* @"personality_function" {
entry:
  %0 = invoke token (i64, i32, void (i64 addrspace(1)*)*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidp1i64f(i64 0, i32 0, void (i64 addrspace(1)*)* @some_call, i32 1, i32 0, i64 addrspace(1)* %obj, i32 0, i32 0) ["gc-live" (i64 addrspace(1)* %obj, i64 addrspace(1)* %obj1), "deopt" (i32 0, i32 -1, i32 0, i32 0, i32 0)]
          to label %invoke_safepoint_normal_dest unwind label %exceptional_return

invoke_safepoint_normal_dest:
  %obj.relocated = call coldcc i64 addrspace(1)* @llvm.experimental.gc.relocate.p1i64(token %0, i32 0, i32 0)
  %obj1.relocated = call coldcc i64 addrspace(1)* @llvm.experimental.gc.relocate.p1i64(token %0, i32 1, i32 1)
  br label %normal_return

normal_return:
  ret i64 addrspace(1)* %obj.relocated

exceptional_return:
  %landing_pad = landingpad token
          cleanup
  %obj.relocated1 = call coldcc i64 addrspace(1)* @llvm.experimental.gc.relocate.p1i64(token %landing_pad, i32 0, i32 0)
  %obj1.relocated1 = call coldcc i64 addrspace(1)* @llvm.experimental.gc.relocate.p1i64(token %landing_pad, i32 1, i32 1)
  ret i64 addrspace(1)* %obj1.relocated1
}

define i64 addrspace(1)* @test_invoke_same_val(i1 %cond, i64 addrspace(1)* %val1, i64 addrspace(1)* %val2, i64 addrspace(1)* %val3) gc "statepoint-example" personality i32 ()* @"personality_function" {
; CHECK-LABEL: test_invoke_same_val:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushq %r15
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 40
; CHECK-NEXT:    subq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    .cfi_offset %rbx, -40
; CHECK-NEXT:    .cfi_offset %r14, -32
; CHECK-NEXT:    .cfi_offset %r15, -24
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movq %rdx, %rbx
; CHECK-NEXT:    movq %rsi, %rbp
; CHECK-NEXT:    movl %edi, %r14d
; CHECK-NEXT:    testb $1, %r14b
; CHECK-NEXT:    je .LBB12_2
; CHECK-NEXT:  # %bb.1: # %left
; CHECK-NEXT:    movq %rbp, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq %rbx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:  .Ltmp19:
; CHECK-NEXT:    movq %rbp, %rdi
; CHECK-NEXT:    callq some_call
; CHECK-NEXT:  .Ltmp22:
; CHECK-NEXT:  .Ltmp20:
; CHECK-NEXT:    jmp .LBB12_4
; CHECK-NEXT:  .LBB12_2: # %right
; CHECK-NEXT:    movq %rcx, %r15
; CHECK-NEXT:    movq %rbx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq %rcx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:  .Ltmp16:
; CHECK-NEXT:    movq %rbp, %rdi
; CHECK-NEXT:    callq some_call
; CHECK-NEXT:  .Ltmp23:
; CHECK-NEXT:  .Ltmp17:
; CHECK-NEXT:  # %bb.3: # %right.relocs
; CHECK-NEXT:    movq %r15, %rbp
; CHECK-NEXT:  .LBB12_4: # %normal_return
; CHECK-NEXT:    testb $1, %r14b
; CHECK-NEXT:    cmoveq %rbx, %rbp
; CHECK-NEXT:  .LBB12_6: # %exceptional_return.left
; CHECK-NEXT:    movq %rbp, %rax
; CHECK-NEXT:  .LBB12_7: # %exceptional_return.left
; CHECK-NEXT:    addq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 40
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    popq %r15
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB12_8: # %exceptional_return.right
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:  .Ltmp18:
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    jmp .LBB12_7
; CHECK-NEXT:  .LBB12_5: # %exceptional_return.left
; CHECK-NEXT:  .Ltmp21:
; CHECK-NEXT:    jmp .LBB12_6
entry:
  br i1 %cond, label %left, label %right

left:
  %sp1 = invoke token (i64, i32, void (i64 addrspace(1)*)*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidp1i64f(i64 0, i32 0, void (i64 addrspace(1)*)* @some_call, i32 1, i32 0, i64 addrspace(1)* %val1, i32 0, i32 0) ["gc-live"(i64 addrspace(1)* %val1, i64 addrspace(1)* %val2)]
           to label %left.relocs unwind label %exceptional_return.left

left.relocs:
  %val1.relocated = call coldcc i64 addrspace(1)* @llvm.experimental.gc.relocate.p1i64(token %sp1, i32 0, i32 0)
  %val2.relocated_left = call coldcc i64 addrspace(1)* @llvm.experimental.gc.relocate.p1i64(token %sp1, i32 1, i32 1)
  br label %normal_return

right:
  %sp2 = invoke token (i64, i32, void (i64 addrspace(1)*)*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidp1i64f(i64 0, i32 0, void (i64 addrspace(1)*)* @some_call, i32 1, i32 0, i64 addrspace(1)* %val1, i32 0, i32 0) ["gc-live"(i64 addrspace(1)* %val2, i64 addrspace(1)* %val3)]
           to label %right.relocs unwind label %exceptional_return.right

right.relocs:
  %val2.relocated_right = call coldcc i64 addrspace(1)* @llvm.experimental.gc.relocate.p1i64(token %sp2, i32 0, i32 0)
  %val3.relocated = call coldcc i64 addrspace(1)* @llvm.experimental.gc.relocate.p1i64(token %sp2, i32 1, i32 1)
  br label %normal_return

normal_return:
  %a1 = phi i64 addrspace(1)* [%val1.relocated, %left.relocs], [%val3.relocated, %right.relocs]
  %a2 = phi i64 addrspace(1)* [%val2.relocated_left, %left.relocs], [%val2.relocated_right, %right.relocs]
  %ret = select i1 %cond, i64 addrspace(1)* %a1, i64 addrspace(1)* %a2
  ret i64 addrspace(1)* %ret

exceptional_return.left:
  %landing_pad = landingpad token
          cleanup
  %val.relocated2 = call coldcc i64 addrspace(1)* @llvm.experimental.gc.relocate.p1i64(token %landing_pad, i32 0, i32 0)
  ret i64 addrspace(1)* %val.relocated2

exceptional_return.right:
  %landing_pad1 = landingpad token
          cleanup
  %val.relocated3 = call coldcc i64 addrspace(1)* @llvm.experimental.gc.relocate.p1i64(token %landing_pad1, i32 0, i32 0)
  ret i64 addrspace(1)* %val.relocated3
}

; test ISEL for constant base pointer - must properly tie operands
define void @test_const_base(i32 addrspace(1)* %a) gc "statepoint-example" {
; CHECK-LABEL: test_const_base:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp24:
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    callq consume
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %token1 = tail call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 0, i32 0, void ()* @func, i32 0, i32 0, i32 0, i32 0) ["deopt" (i32 0, i32 1, i32 7, i32 addrspace(1)* null, i32 9), "gc-live" (i32 addrspace(1)* null, i32 addrspace(1)* %a)]
  %rel = call i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token %token1,  i32 0, i32 1)
  call void @consume(i32 addrspace(1)* %rel)
  ret void
}

; test multiple statepoints/relocates within single block.
; relocates must be properly scheduled w.r.t. statepoints
define void @test_sched(float %0, i32 %1, i8 addrspace(1)* %2) gc "statepoint-example" {
; CHECK-LABEL: test_sched:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    subq $40, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    .cfi_offset %rbx, -24
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movq %rsi, %rbx
; CHECK-NEXT:    movl %edi, %ebp
; CHECK-NEXT:    movss %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 4-byte Spill
; CHECK-NEXT:    movq %rsi, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    callq consume3
; CHECK-NEXT:  .Ltmp25:
; CHECK-NEXT:    xorps %xmm0, %xmm0
; CHECK-NEXT:    cvtsi2sd %ebp, %xmm0
; CHECK-NEXT:    movsd %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movq %rbx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    nopl 8(%rax,%rax)
; CHECK-NEXT:  .Ltmp26:
; CHECK-NEXT:    movsd {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 8-byte Reload
; CHECK-NEXT:    # xmm0 = mem[0],zero
; CHECK-NEXT:    movsd %xmm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movss {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 4-byte Reload
; CHECK-NEXT:    # xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    movss %xmm0, (%rsp)
; CHECK-NEXT:    movq %rbx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    nopl 8(%rax,%rax)
; CHECK-NEXT:  .Ltmp27:
; CHECK-NEXT:    movsd {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 8-byte Reload
; CHECK-NEXT:    # xmm0 = mem[0],zero
; CHECK-NEXT:    movsd %xmm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movss {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 4-byte Reload
; CHECK-NEXT:    # xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    movss %xmm0, (%rsp)
; CHECK-NEXT:    movq %rbx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    nopl 8(%rax,%rax)
; CHECK-NEXT:  .Ltmp28:
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    xorpd %xmm0, %xmm0
; CHECK-NEXT:    movsd {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 8-byte Reload
; CHECK-NEXT:    # xmm1 = mem[0],zero
; CHECK-NEXT:    ucomisd %xmm0, %xmm1
; CHECK-NEXT:    movabsq $9223372036854775807, %rdi # imm = 0x7FFFFFFFFFFFFFFF
; CHECK-NEXT:    cmovbeq %rax, %rdi
; CHECK-NEXT:    movsd %xmm1, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movss {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 4-byte Reload
; CHECK-NEXT:    # xmm0 = mem[0],zero,zero,zero
; CHECK-NEXT:    movss %xmm0, (%rsp)
; CHECK-NEXT:    nopl 8(%rax,%rax)
; CHECK-NEXT:  .Ltmp29:
; CHECK-NEXT:    addq $40, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %token0 = call token (i64, i32, void (float)*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf32f(i64 2, i32 0, void (float)* nonnull @consume3, i32 1, i32 0, float %0, i32 0, i32 0) [ "gc-live"(i8 addrspace(1)* %2) ]
  %reloc1 = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token %token0, i32 0, i32 0) ; (%2, %2)
  %tmp1 = sitofp i32 %1 to double
  %to_max.i29 = fcmp ogt double %tmp1, 0.000000e+00
  %token1 = call token (i64, i32, i32 (i32)*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_i32i32f(i64 2, i32 5, i32 (i32)* nonnull @consume1, i32 1, i32 0, i32 undef, i32 0, i32 0) [ "gc-live"(i8 addrspace(1)* %reloc1) ]
  %reloc2 = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token %token1, i32 0, i32 0) ; (%reloc1, %reloc1)
  %reloc3 = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token %token1, i32 0, i32 0) ; (%reloc1, %reloc1)
  %token2 = call token (i64, i32, i32 (i32)*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_i32i32f(i64 2, i32 5, i32 (i32)* nonnull @consume1, i32 1, i32 0, i32 undef, i32 0, i32 0) [ "deopt"(float %0, double %tmp1), "gc-live"(i8 addrspace(1)* %reloc2, i8 addrspace(1)* %reloc3) ]
  %reloc4 = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token %token2, i32 0, i32 0) ; (%reloc3, %reloc2)
  %reloc5 = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token %token2, i32 1, i32 1) ; (%reloc3, %reloc3)
  %token3 = call token (i64, i32, void (float)*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf32f(i64 2, i32 5, void (float)* nonnull @consume3, i32 1, i32 0, float %0, i32 0, i32 0) [ "deopt"(float %0, double %tmp1), "gc-live"(i8 addrspace(1)* %reloc4, i8 addrspace(1)* %reloc5) ]
  %reloc6 = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token %token3, i32 1, i32 0) ; (%reloc5, %reloc4)
  %tmp5 = select i1 %to_max.i29, i64 9223372036854775807, i64 0
  %token4 = call token (i64, i32, float (i64)*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_f32i64f(i64 2, i32 5, float (i64)* nonnull @consume4, i32 1, i32 0, i64 %tmp5, i32 0, i32 0) [ "deopt"(float %0, double %tmp1), "gc-live"() ]
ret void
}

declare token @llvm.experimental.gc.statepoint.p0f_f32i64f(i64 immarg, i32 immarg, float (i64)*, i32 immarg, i32 immarg, ...)
declare token @llvm.experimental.gc.statepoint.p0f_i32i32f(i64 immarg, i32 immarg, i32 (i32)*, i32 immarg, i32 immarg, ...)
declare token @llvm.experimental.gc.statepoint.p0f_isVoidf32f(i64 immarg, i32 immarg, void (float)*, i32 immarg, i32 immarg, ...)
declare token @llvm.experimental.gc.statepoint.p0f_i1f(i64, i32, i1 ()*, i32, i32, ...)
declare token @llvm.experimental.gc.statepoint.p0f_isVoidf(i64, i32, void ()*, i32, i32, ...)
declare token @llvm.experimental.gc.statepoint.p0f_isVoidp1i64f(i64, i32, void (i64 addrspace(1)*)*, i32, i32, ...)
declare i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token, i32, i32)
declare i64 addrspace(1)* @llvm.experimental.gc.relocate.p1i64(token, i32, i32)
declare i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token, i32, i32)
declare <2 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v2p1i8(token, i32, i32)
declare i1 @llvm.experimental.gc.result.i1(token)
