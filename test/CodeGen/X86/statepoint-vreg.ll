; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -max-registers-for-gc-values=4 < %s | FileCheck %s

target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

declare i1 @return_i1()
declare void @func()
declare void @consume(i32 addrspace(1)*)
declare void @consume2(i32 addrspace(1)*, i32 addrspace(1)*)
declare void @consume5(i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*, i32 addrspace(1)*)
declare void @use1(i32 addrspace(1)*, i8 addrspace(1)*)

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
; CHECK-NEXT:    .cfi_offset %rbx, -32
; CHECK-NEXT:    .cfi_offset %r14, -24
; CHECK-NEXT:    .cfi_offset %r15, -16
; CHECK-NEXT:    movq %rdx, %r14
; CHECK-NEXT:    movq %rsi, %r15
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp1:
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    xorl %esi, %esi
; CHECK-NEXT:    movq %r15, %rdx
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    movq %r14, %r8
; CHECK-NEXT:    callq consume5
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
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset %rbx, -24
; CHECK-NEXT:    .cfi_offset %r14, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movq %rdi, (%rsp)
; CHECK-NEXT:    callq return_i1
; CHECK-NEXT:  .Ltmp2:
; CHECK-NEXT:    movq (%rsp), %r14
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    callq consume
; CHECK-NEXT:    movq %r14, %rax
; CHECK-NEXT:    addq $8, %rsp
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
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp5:
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    movq %rbx, %rsi
; CHECK-NEXT:    callq consume2
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
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp6:
; CHECK-NEXT:    movq %rbx, %rdi
; CHECK-NEXT:    movq %rbx, %rsi
; CHECK-NEXT:    callq use1
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
; No need to check post-RA output
define i1 @test_cross_bb(i32 addrspace(1)* %a, i1 %external_cond) gc "statepoint-example" {
; CHECK-LABEL: test_cross_bb:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset %rbx, -24
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movl %esi, %ebp
; CHECK-NEXT:    movq %rdi, (%rsp)
; CHECK-NEXT:    callq return_i1
; CHECK-NEXT:  .Ltmp7:
; CHECK-NEXT:    testb $1, %bpl
; CHECK-NEXT:    je .LBB7_2
; CHECK-NEXT:  # %bb.1: # %left
; CHECK-NEXT:    movl %eax, %ebx
; CHECK-NEXT:    movq (%rsp), %rdi
; CHECK-NEXT:    callq consume
; CHECK-NEXT:    movl %ebx, %eax
; CHECK-NEXT:    jmp .LBB7_3
; CHECK-NEXT:  .LBB7_2: # %right
; CHECK-NEXT:    movb $1, %al
; CHECK-NEXT:  .LBB7_3: # %right
; CHECK-NEXT:    addq $8, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    popq %rbx
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
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset %rbx, -40
; CHECK-NEXT:    .cfi_offset %r12, -32
; CHECK-NEXT:    .cfi_offset %r14, -24
; CHECK-NEXT:    .cfi_offset %r15, -16
; CHECK-NEXT:    movq %r8, %r14
; CHECK-NEXT:    movq %rcx, %r15
; CHECK-NEXT:    movq %rdx, %r12
; CHECK-NEXT:    movq %rsi, %rbx
; CHECK-NEXT:    movq %rdi, (%rsp)
; CHECK-NEXT:    callq func
; CHECK-NEXT:  .Ltmp11:
; CHECK-NEXT:    movq (%rsp), %rdi
; CHECK-NEXT:    movq %rbx, %rsi
; CHECK-NEXT:    movq %r12, %rdx
; CHECK-NEXT:    movq %r15, %rcx
; CHECK-NEXT:    movq %r14, %r8
; CHECK-NEXT:    callq consume5
; CHECK-NEXT:    addq $8, %rsp
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

declare token @llvm.experimental.gc.statepoint.p0f_i1f(i64, i32, i1 ()*, i32, i32, ...)
declare token @llvm.experimental.gc.statepoint.p0f_isVoidf(i64, i32, void ()*, i32, i32, ...)
declare i32 addrspace(1)* @llvm.experimental.gc.relocate.p1i32(token, i32, i32)
declare i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token, i32, i32)
declare <2 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v2p1i8(token, i32, i32)
declare i1 @llvm.experimental.gc.result.i1(token)
