; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu | FileCheck %s

define i8* @test_memcpy1_generic(i8* %P, i8* %Q) {
; CHECK-LABEL: test_memcpy1_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memcpy_element_unordered_atomic_1
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(i8* align 4 %P, i8* align 4 %Q, i32 1024, i32 1)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memcpy2_generic(i8* %P, i8* %Q) {
; CHECK-LABEL: test_memcpy2_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memcpy_element_unordered_atomic_2
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(i8* align 4 %P, i8* align 4 %Q, i32 1024, i32 2)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memcpy4_generic(i8* %P, i8* %Q) {
; CHECK-LABEL: test_memcpy4_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memcpy_element_unordered_atomic_4
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(i8* align 4 %P, i8* align 4 %Q, i32 1024, i32 4)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memcpy8(i8* %P, i8* %Q) {
; CHECK-LABEL: test_memcpy8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memcpy_element_unordered_atomic_8
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(i8* align 8 %P, i8* align 8 %Q, i32 1024, i32 8)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memcpy16_generic(i8* %P, i8* %Q) {
; CHECK-LABEL: test_memcpy16_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memcpy_element_unordered_atomic_16
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(i8* align 16 %P, i8* align 16 %Q, i32 1024, i32 16)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define void @test_memcpy_args(i8** %Storage) {
; CHECK-LABEL: test_memcpy_args:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    movq 8(%rdi), %rsi
; CHECK-NEXT:    movq %rax, %rdi
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memcpy_element_unordered_atomic_4
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %Dst = load i8*, i8** %Storage
  %Src.addr = getelementptr i8*, i8** %Storage, i64 1
  %Src = load i8*, i8** %Src.addr

  ; 1st arg (%rdi)
  ; 2nd arg (%rsi)
  ; 3rd arg (%edx) -- length
  call void @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(i8* align 4 %Dst, i8* align 4 %Src, i32 1024, i32 4)
  ret void
}

define i8* @test_memmove1_generic(i8* %P, i8* %Q) {
; CHECK-LABEL: test_memmove1_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memmove_element_unordered_atomic_1
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(i8* align 4 %P, i8* align 4 %Q, i32 1024, i32 1)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memmove2_generic(i8* %P, i8* %Q) {
; CHECK-LABEL: test_memmove2_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memmove_element_unordered_atomic_2
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(i8* align 4 %P, i8* align 4 %Q, i32 1024, i32 2)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memmove4_generic(i8* %P, i8* %Q) {
; CHECK-LABEL: test_memmove4_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memmove_element_unordered_atomic_4
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(i8* align 4 %P, i8* align 4 %Q, i32 1024, i32 4)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memmove8_generic(i8* %P, i8* %Q) {
; CHECK-LABEL: test_memmove8_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memmove_element_unordered_atomic_8
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(i8* align 8 %P, i8* align 8 %Q, i32 1024, i32 8)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memmove16_generic(i8* %P, i8* %Q) {
; CHECK-LABEL: test_memmove16_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memmove_element_unordered_atomic_16
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(i8* align 16 %P, i8* align 16 %Q, i32 1024, i32 16)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define void @test_memmove_args(i8** %Storage) {
; CHECK-LABEL: test_memmove_args:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    movq (%rdi), %rax
; CHECK-NEXT:    movq 8(%rdi), %rsi
; CHECK-NEXT:    movq %rax, %rdi
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memmove_element_unordered_atomic_4
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %Dst = load i8*, i8** %Storage
  %Src.addr = getelementptr i8*, i8** %Storage, i64 1
  %Src = load i8*, i8** %Src.addr

  ; 1st arg (%rdi)
  ; 2nd arg (%rsi)
  ; 3rd arg (%edx) -- length
  call void @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(i8* align 4 %Dst, i8* align 4 %Src, i32 1024, i32 4)
  ret void
}

define i8* @test_memset1_generic(i8* %P, i8 %V) {
; CHECK-LABEL: test_memset1_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memset_element_unordered_atomic_1
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memset.element.unordered.atomic.p0i8.i32(i8* align 1 %P, i8 %V, i32 1024, i32 1)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memset2_generic(i8* %P, i8 %V) {
; CHECK-LABEL: test_memset2_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memset_element_unordered_atomic_2
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memset.element.unordered.atomic.p0i8.i32(i8* align 2 %P, i8 %V, i32 1024, i32 2)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memset4_generic(i8* %P, i8 %V) {
; CHECK-LABEL: test_memset4_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memset_element_unordered_atomic_4
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memset.element.unordered.atomic.p0i8.i32(i8* align 4 %P, i8 %V, i32 1024, i32 4)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memset8_generic(i8* %P, i8 %V) {
; CHECK-LABEL: test_memset8_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memset_element_unordered_atomic_8
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memset.element.unordered.atomic.p0i8.i32(i8* align 8 %P, i8 %V, i32 1024, i32 8)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define i8* @test_memset16_generic(i8* %P, i8 %V) {
; CHECK-LABEL: test_memset16_generic:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memset_element_unordered_atomic_16
; CHECK-NEXT:    movq %rbx, %rax
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @llvm.memset.element.unordered.atomic.p0i8.i32(i8* align 16 %P, i8 %V, i32 1024, i32 16)
  ret i8* %P
  ; 3rd arg (%edx) -- length
}

define void @test_memset_args(i8** %Storage, i8* %V) {
; CHECK-LABEL: test_memset_args:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    movq (%rdi), %rdi
; CHECK-NEXT:    movzbl (%rsi), %esi
; CHECK-NEXT:    movl $1024, %edx # imm = 0x400
; CHECK-NEXT:    callq __llvm_memset_element_unordered_atomic_4
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %Dst = load i8*, i8** %Storage
  %Val = load i8, i8* %V

  ; 1st arg (%rdi)
  ; 2nd arg (%rsi)
  ; 3rd arg (%edx) -- length
  call void @llvm.memset.element.unordered.atomic.p0i8.i32(i8* align 4 %Dst, i8 %Val, i32 1024, i32 4)
  ret void
}

declare void @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(i8* nocapture, i8* nocapture, i32, i32) nounwind
declare void @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(i8* nocapture, i8* nocapture, i32, i32) nounwind
declare void @llvm.memset.element.unordered.atomic.p0i8.i32(i8* nocapture, i8, i32, i32) nounwind
