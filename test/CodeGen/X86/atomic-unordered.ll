; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 < %s -mtriple=x86_64-linux-generic -verify-machineinstrs -mattr=sse2 | FileCheck --check-prefix=CHECK-O0 %s
; RUN: llc -O3 < %s -mtriple=x86_64-linux-generic -verify-machineinstrs -mattr=sse2 | FileCheck --check-prefix=CHECK-O3 %s

define i8 @load_i8(i8* %ptr) {
; CHECK-O0-LABEL: load_i8:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movb (%rdi), %al
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_i8:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movb (%rdi), %al
; CHECK-O3-NEXT:    retq
  %v = load atomic i8, i8* %ptr unordered, align 1
  ret i8 %v
}

define void @store_i8(i8* %ptr, i8 %v) {
; CHECK-O0-LABEL: store_i8:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movb %sil, %al
; CHECK-O0-NEXT:    movb %al, (%rdi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: store_i8:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movb %sil, (%rdi)
; CHECK-O3-NEXT:    retq
  store atomic i8 %v, i8* %ptr unordered, align 1
  ret void
}

define i16 @load_i16(i16* %ptr) {
; CHECK-O0-LABEL: load_i16:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movw (%rdi), %ax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_i16:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movzwl (%rdi), %eax
; CHECK-O3-NEXT:    retq
  %v = load atomic i16, i16* %ptr unordered, align 2
  ret i16 %v
}


define void @store_i16(i16* %ptr, i16 %v) {
; CHECK-O0-LABEL: store_i16:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movw %si, %ax
; CHECK-O0-NEXT:    movw %ax, (%rdi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: store_i16:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movw %si, (%rdi)
; CHECK-O3-NEXT:    retq
  store atomic i16 %v, i16* %ptr unordered, align 2
  ret void
}

define i32 @load_i32(i32* %ptr) {
; CHECK-O0-LABEL: load_i32:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movl (%rdi), %eax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_i32:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movl (%rdi), %eax
; CHECK-O3-NEXT:    retq
  %v = load atomic i32, i32* %ptr unordered, align 4
  ret i32 %v
}

define void @store_i32(i32* %ptr, i32 %v) {
; CHECK-O0-LABEL: store_i32:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movl %esi, (%rdi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: store_i32:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movl %esi, (%rdi)
; CHECK-O3-NEXT:    retq
  store atomic i32 %v, i32* %ptr unordered, align 4
  ret void
}

define i64 @load_i64(i64* %ptr) {
; CHECK-O0-LABEL: load_i64:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_i64:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %ptr unordered, align 8
  ret i64 %v
}

define void @store_i64(i64* %ptr, i64 %v) {
; CHECK-O0-LABEL: store_i64:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq %rsi, (%rdi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: store_i64:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq %rsi, (%rdi)
; CHECK-O3-NEXT:    retq
  store atomic i64 %v, i64* %ptr unordered, align 8
  ret void
}

;; The next batch of tests are intended to show transforms which we
;; either *can't* do for legality, or don't currently implement.  The later
;; are noted carefully where relevant.

; Must use a full width op, not a byte op
define void @narrow_writeback_or(i64* %ptr) {
; CHECK-O0-LABEL: narrow_writeback_or:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    orq $7, %rax
; CHECK-O0-NEXT:    movq %rax, (%rdi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: narrow_writeback_or:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    orq $7, (%rdi)
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %ptr unordered, align 8
  %v.new = or i64 %v, 7
  store atomic i64 %v.new, i64* %ptr unordered, align 8
  ret void
}

; Must use a full width op, not a byte op
define void @narrow_writeback_and(i64* %ptr) {
; CHECK-O0-LABEL: narrow_writeback_and:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    movl %eax, %ecx
; CHECK-O0-NEXT:    andl $-256, %ecx
; CHECK-O0-NEXT:    movl %ecx, %eax
; CHECK-O0-NEXT:    movq %rax, (%rdi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: narrow_writeback_and:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movl $4294967040, %eax # imm = 0xFFFFFF00
; CHECK-O3-NEXT:    andq %rax, (%rdi)
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %ptr unordered, align 8
  %v.new = and i64 %v, 4294967040 ;; 0xFFFF_FF00
  store atomic i64 %v.new, i64* %ptr unordered, align 8
  ret void
}

; Must use a full width op, not a byte op
define void @narrow_writeback_xor(i64* %ptr) {
; CHECK-O0-LABEL: narrow_writeback_xor:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    xorq $7, %rax
; CHECK-O0-NEXT:    movq %rax, (%rdi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: narrow_writeback_xor:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    xorq $7, (%rdi)
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %ptr unordered, align 8
  %v.new = xor i64 %v, 7
  store atomic i64 %v.new, i64* %ptr unordered, align 8
  ret void
}

; Legal if wider type is also atomic (TODO)
define void @widen_store(i32* %p0, i32 %v1, i32 %v2) {
; CHECK-O0-LABEL: widen_store:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movl %esi, (%rdi)
; CHECK-O0-NEXT:    movl %edx, 4(%rdi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: widen_store:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movl %esi, (%rdi)
; CHECK-O3-NEXT:    movl %edx, 4(%rdi)
; CHECK-O3-NEXT:    retq
  %p1 = getelementptr i32, i32* %p0, i64 1
  store atomic i32 %v1, i32* %p0 unordered, align 8
  store atomic i32 %v2, i32* %p1 unordered, align 4
  ret void
}

; Legal if wider type is also atomic (TODO)
define void @widen_broadcast(i32* %p0, i32 %v) {
; CHECK-O0-LABEL: widen_broadcast:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movl %esi, (%rdi)
; CHECK-O0-NEXT:    movl %esi, 4(%rdi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: widen_broadcast:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movl %esi, (%rdi)
; CHECK-O3-NEXT:    movl %esi, 4(%rdi)
; CHECK-O3-NEXT:    retq
  %p1 = getelementptr i32, i32* %p0, i64 1
  store atomic i32 %v, i32* %p0 unordered, align 8
  store atomic i32 %v, i32* %p1 unordered, align 4
  ret void
}

; Legal if wider type is also atomic (TODO)
define void @vec_store(i32* %p0, <2 x i32> %vec) {
; CHECK-O0-LABEL: vec_store:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movd %xmm0, %eax
; CHECK-O0-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; CHECK-O0-NEXT:    movd %xmm0, %ecx
; CHECK-O0-NEXT:    movl %eax, (%rdi)
; CHECK-O0-NEXT:    movl %ecx, 4(%rdi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: vec_store:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movd %xmm0, %eax
; CHECK-O3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; CHECK-O3-NEXT:    movd %xmm0, %ecx
; CHECK-O3-NEXT:    movl %eax, (%rdi)
; CHECK-O3-NEXT:    movl %ecx, 4(%rdi)
; CHECK-O3-NEXT:    retq
  %v1 = extractelement <2 x i32> %vec, i32 0
  %v2 = extractelement <2 x i32> %vec, i32 1
  %p1 = getelementptr i32, i32* %p0, i64 1
  store atomic i32 %v1, i32* %p0 unordered, align 8
  store atomic i32 %v2, i32* %p1 unordered, align 4
  ret void
}


; Legal if wider type is also atomic (TODO)
; Also, can avoid register move from xmm to eax (TODO)
define void @widen_broadcast2(i32* %p0, <2 x i32> %vec) {
; CHECK-O0-LABEL: widen_broadcast2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movd %xmm0, %eax
; CHECK-O0-NEXT:    movl %eax, (%rdi)
; CHECK-O0-NEXT:    movl %eax, 4(%rdi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: widen_broadcast2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movd %xmm0, %eax
; CHECK-O3-NEXT:    movl %eax, (%rdi)
; CHECK-O3-NEXT:    movl %eax, 4(%rdi)
; CHECK-O3-NEXT:    retq
  %v1 = extractelement <2 x i32> %vec, i32 0
  %p1 = getelementptr i32, i32* %p0, i64 1
  store atomic i32 %v1, i32* %p0 unordered, align 8
  store atomic i32 %v1, i32* %p1 unordered, align 4
  ret void
}


; Legal if wider type is also atomic (TODO)
define void @widen_zero_init(i32* %p0, i32 %v1, i32 %v2) {
; CHECK-O0-LABEL: widen_zero_init:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movl $0, (%rdi)
; CHECK-O0-NEXT:    movl $0, 4(%rdi)
; CHECK-O0-NEXT:    movl %esi, {{[-0-9]+}}(%r{{[sb]}}p) # 4-byte Spill
; CHECK-O0-NEXT:    movl %edx, {{[-0-9]+}}(%r{{[sb]}}p) # 4-byte Spill
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: widen_zero_init:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movl $0, (%rdi)
; CHECK-O3-NEXT:    movl $0, 4(%rdi)
; CHECK-O3-NEXT:    retq
  %p1 = getelementptr i32, i32* %p0, i64 1
  store atomic i32 0, i32* %p0 unordered, align 8
  store atomic i32 0, i32* %p1 unordered, align 4
  ret void
}

; Legal, as expected
define i64 @load_fold_add1(i64* %p) {
; CHECK-O0-LABEL: load_fold_add1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    addq $15, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_add1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    addq $15, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = add i64 %v, 15
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_add2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_add2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    addq (%rdi), %rsi
; CHECK-O0-NEXT:    movq %rsi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_add2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    addq %rsi, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = add i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_add3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_add3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    addq (%rsi), %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_add3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rcx
; CHECK-O3-NEXT:    movq (%rsi), %rax
; CHECK-O3-NEXT:    addq %rcx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = add i64 %v, %v2
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_sub1(i64* %p) {
; CHECK-O0-LABEL: load_fold_sub1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    subq $15, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_sub1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    addq $-15, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = sub i64 %v, 15
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_sub2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_sub2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    subq %rsi, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_sub2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    subq %rsi, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = sub i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_sub3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_sub3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    subq (%rsi), %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_sub3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    movq (%rsi), %rcx
; CHECK-O3-NEXT:    subq %rcx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = sub i64 %v, %v2
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_mul1(i64* %p) {
; CHECK-O0-LABEL: load_fold_mul1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    imulq $15, (%rdi), %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_mul1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    leaq (%rax,%rax,4), %rax
; CHECK-O3-NEXT:    leaq (%rax,%rax,2), %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = mul i64 %v, 15
  ret i64 %ret
}

; Legal, O0 is better than O3 codegen (TODO)
define i64 @load_fold_mul2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_mul2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    imulq (%rdi), %rsi
; CHECK-O0-NEXT:    movq %rsi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_mul2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    imulq %rsi, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = mul i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_mul3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_mul3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    imulq (%rsi), %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_mul3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rcx
; CHECK-O3-NEXT:    movq (%rsi), %rax
; CHECK-O3-NEXT:    imulq %rcx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = mul i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_sdiv1(i64* %p) {
; CHECK-O0-LABEL: load_fold_sdiv1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    cqto
; CHECK-O0-NEXT:    movl $15, %edi
; CHECK-O0-NEXT:    idivq %rdi
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_sdiv1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rcx
; CHECK-O3-NEXT:    movabsq $-8608480567731124087, %rdx # imm = 0x8888888888888889
; CHECK-O3-NEXT:    movq %rcx, %rax
; CHECK-O3-NEXT:    imulq %rdx
; CHECK-O3-NEXT:    addq %rcx, %rdx
; CHECK-O3-NEXT:    movq %rdx, %rax
; CHECK-O3-NEXT:    shrq $63, %rax
; CHECK-O3-NEXT:    sarq $3, %rdx
; CHECK-O3-NEXT:    leaq (%rdx,%rax), %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = sdiv i64 %v, 15
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_sdiv2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_sdiv2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    cqto
; CHECK-O0-NEXT:    idivq %rsi
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_sdiv2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    cqto
; CHECK-O3-NEXT:    idivq %rsi
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = sdiv i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_sdiv3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_sdiv3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    cqto
; CHECK-O0-NEXT:    idivq (%rsi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_sdiv3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    movq (%rsi), %rcx
; CHECK-O3-NEXT:    cqto
; CHECK-O3-NEXT:    idivq %rcx
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = sdiv i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_udiv1(i64* %p) {
; CHECK-O0-LABEL: load_fold_udiv1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    xorl %ecx, %ecx
; CHECK-O0-NEXT:    movl %ecx, %edx
; CHECK-O0-NEXT:    movl $15, %edi
; CHECK-O0-NEXT:    divq %rdi
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_udiv1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    movabsq $-8608480567731124087, %rcx # imm = 0x8888888888888889
; CHECK-O3-NEXT:    mulq %rcx
; CHECK-O3-NEXT:    movq %rdx, %rax
; CHECK-O3-NEXT:    shrq $3, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = udiv i64 %v, 15
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_udiv2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_udiv2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    xorl %ecx, %ecx
; CHECK-O0-NEXT:    movl %ecx, %edx
; CHECK-O0-NEXT:    divq %rsi
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_udiv2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    xorl %edx, %edx
; CHECK-O3-NEXT:    divq %rsi
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = udiv i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_udiv3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_udiv3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    xorl %ecx, %ecx
; CHECK-O0-NEXT:    movl %ecx, %edx
; CHECK-O0-NEXT:    divq (%rsi)
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_udiv3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    movq (%rsi), %rcx
; CHECK-O3-NEXT:    xorl %edx, %edx
; CHECK-O3-NEXT:    divq %rcx
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = udiv i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_srem1(i64* %p) {
; CHECK-O0-LABEL: load_fold_srem1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    cqto
; CHECK-O0-NEXT:    movl $15, %edi
; CHECK-O0-NEXT:    idivq %rdi
; CHECK-O0-NEXT:    movq %rdx, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_srem1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rcx
; CHECK-O3-NEXT:    movabsq $-8608480567731124087, %rdx # imm = 0x8888888888888889
; CHECK-O3-NEXT:    movq %rcx, %rax
; CHECK-O3-NEXT:    imulq %rdx
; CHECK-O3-NEXT:    addq %rcx, %rdx
; CHECK-O3-NEXT:    movq %rdx, %rax
; CHECK-O3-NEXT:    shrq $63, %rax
; CHECK-O3-NEXT:    sarq $3, %rdx
; CHECK-O3-NEXT:    addq %rax, %rdx
; CHECK-O3-NEXT:    leaq (%rdx,%rdx,4), %rax
; CHECK-O3-NEXT:    leaq (%rax,%rax,2), %rax
; CHECK-O3-NEXT:    subq %rax, %rcx
; CHECK-O3-NEXT:    movq %rcx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = srem i64 %v, 15
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_srem2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_srem2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    cqto
; CHECK-O0-NEXT:    idivq %rsi
; CHECK-O0-NEXT:    movq %rdx, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_srem2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    cqto
; CHECK-O3-NEXT:    idivq %rsi
; CHECK-O3-NEXT:    movq %rdx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = srem i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_srem3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_srem3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    cqto
; CHECK-O0-NEXT:    idivq (%rsi)
; CHECK-O0-NEXT:    movq %rdx, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_srem3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    movq (%rsi), %rcx
; CHECK-O3-NEXT:    cqto
; CHECK-O3-NEXT:    idivq %rcx
; CHECK-O3-NEXT:    movq %rdx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = srem i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_urem1(i64* %p) {
; CHECK-O0-LABEL: load_fold_urem1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    xorl %ecx, %ecx
; CHECK-O0-NEXT:    movl %ecx, %edx
; CHECK-O0-NEXT:    movl $15, %edi
; CHECK-O0-NEXT:    divq %rdi
; CHECK-O0-NEXT:    movq %rdx, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_urem1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rcx
; CHECK-O3-NEXT:    movabsq $-8608480567731124087, %rdx # imm = 0x8888888888888889
; CHECK-O3-NEXT:    movq %rcx, %rax
; CHECK-O3-NEXT:    mulq %rdx
; CHECK-O3-NEXT:    shrq $3, %rdx
; CHECK-O3-NEXT:    leaq (%rdx,%rdx,4), %rax
; CHECK-O3-NEXT:    leaq (%rax,%rax,2), %rax
; CHECK-O3-NEXT:    subq %rax, %rcx
; CHECK-O3-NEXT:    movq %rcx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = urem i64 %v, 15
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_urem2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_urem2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    xorl %ecx, %ecx
; CHECK-O0-NEXT:    movl %ecx, %edx
; CHECK-O0-NEXT:    divq %rsi
; CHECK-O0-NEXT:    movq %rdx, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_urem2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    xorl %edx, %edx
; CHECK-O3-NEXT:    divq %rsi
; CHECK-O3-NEXT:    movq %rdx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = urem i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_urem3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_urem3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rax
; CHECK-O0-NEXT:    xorl %ecx, %ecx
; CHECK-O0-NEXT:    movl %ecx, %edx
; CHECK-O0-NEXT:    divq (%rsi)
; CHECK-O0-NEXT:    movq %rdx, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_urem3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    movq (%rsi), %rcx
; CHECK-O3-NEXT:    xorl %edx, %edx
; CHECK-O3-NEXT:    divq %rcx
; CHECK-O3-NEXT:    movq %rdx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = urem i64 %v, %v2
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_shl1(i64* %p) {
; CHECK-O0-LABEL: load_fold_shl1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    shlq $15, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_shl1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    shlq $15, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = shl i64 %v, 15
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_shl2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_shl2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    movq %rsi, %rcx
; CHECK-O0-NEXT:    # kill: def $cl killed $rcx
; CHECK-O0-NEXT:    shlq %cl, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_shl2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq %rsi, %rcx
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-O3-NEXT:    shlq %cl, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = shl i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_shl3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_shl3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    movq (%rsi), %rcx
; CHECK-O0-NEXT:    # kill: def $cl killed $rcx
; CHECK-O0-NEXT:    shlq %cl, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_shl3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    movq (%rsi), %rcx
; CHECK-O3-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-O3-NEXT:    shlq %cl, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = shl i64 %v, %v2
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_lshr1(i64* %p) {
; CHECK-O0-LABEL: load_fold_lshr1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    shrq $15, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_lshr1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    shrq $15, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = lshr i64 %v, 15
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_lshr2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_lshr2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    movq %rsi, %rcx
; CHECK-O0-NEXT:    # kill: def $cl killed $rcx
; CHECK-O0-NEXT:    shrq %cl, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_lshr2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq %rsi, %rcx
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-O3-NEXT:    shrq %cl, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = lshr i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_lshr3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_lshr3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    movq (%rsi), %rcx
; CHECK-O0-NEXT:    # kill: def $cl killed $rcx
; CHECK-O0-NEXT:    shrq %cl, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_lshr3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    movq (%rsi), %rcx
; CHECK-O3-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-O3-NEXT:    shrq %cl, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = lshr i64 %v, %v2
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_ashr1(i64* %p) {
; CHECK-O0-LABEL: load_fold_ashr1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    sarq $15, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_ashr1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    sarq $15, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = ashr i64 %v, 15
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_ashr2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_ashr2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    movq %rsi, %rcx
; CHECK-O0-NEXT:    # kill: def $cl killed $rcx
; CHECK-O0-NEXT:    sarq %cl, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_ashr2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq %rsi, %rcx
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-O3-NEXT:    sarq %cl, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = ashr i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_ashr3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_ashr3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    movq (%rsi), %rcx
; CHECK-O0-NEXT:    # kill: def $cl killed $rcx
; CHECK-O0-NEXT:    sarq %cl, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_ashr3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    movq (%rsi), %rcx
; CHECK-O3-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-O3-NEXT:    sarq %cl, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = ashr i64 %v, %v2
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_and1(i64* %p) {
; CHECK-O0-LABEL: load_fold_and1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    andq $15, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_and1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    andl $15, %eax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = and i64 %v, 15
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_and2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_and2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    andq (%rdi), %rsi
; CHECK-O0-NEXT:    movq %rsi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_and2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    andq %rsi, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = and i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_and3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_and3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    andq (%rsi), %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_and3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rcx
; CHECK-O3-NEXT:    movq (%rsi), %rax
; CHECK-O3-NEXT:    andq %rcx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = and i64 %v, %v2
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_or1(i64* %p) {
; CHECK-O0-LABEL: load_fold_or1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    orq $15, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_or1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    orq $15, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = or i64 %v, 15
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_or2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_or2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    orq (%rdi), %rsi
; CHECK-O0-NEXT:    movq %rsi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_or2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    orq %rsi, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = or i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_or3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_or3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    orq (%rsi), %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_or3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rcx
; CHECK-O3-NEXT:    movq (%rsi), %rax
; CHECK-O3-NEXT:    orq %rcx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = or i64 %v, %v2
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_xor1(i64* %p) {
; CHECK-O0-LABEL: load_fold_xor1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    xorq $15, %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_xor1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    xorq $15, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = xor i64 %v, 15
  ret i64 %ret
}

; Legal, as expected
define i64 @load_fold_xor2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_xor2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    xorq (%rdi), %rsi
; CHECK-O0-NEXT:    movq %rsi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_xor2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    xorq %rsi, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = xor i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i64 @load_fold_xor3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_xor3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    xorq (%rsi), %rdi
; CHECK-O0-NEXT:    movq %rdi, %rax
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_xor3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rcx
; CHECK-O3-NEXT:    movq (%rsi), %rax
; CHECK-O3-NEXT:    xorq %rcx, %rax
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = xor i64 %v, %v2
  ret i64 %ret
}

; Legal to fold (TODO)
define i1 @load_fold_icmp1(i64* %p) {
; CHECK-O0-LABEL: load_fold_icmp1:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    subq $15, %rdi
; CHECK-O0-NEXT:    sete %al
; CHECK-O0-NEXT:    movq %rdi, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_icmp1:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    cmpq $15, %rax
; CHECK-O3-NEXT:    sete %al
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = icmp eq i64 %v, 15
  ret i1 %ret
}

; Legal to fold (TODO)
define i1 @load_fold_icmp2(i64* %p, i64 %v2) {
; CHECK-O0-LABEL: load_fold_icmp2:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    subq %rsi, %rdi
; CHECK-O0-NEXT:    sete %al
; CHECK-O0-NEXT:    movq %rdi, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_icmp2:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    cmpq %rsi, %rax
; CHECK-O3-NEXT:    sete %al
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p unordered, align 8
  %ret = icmp eq i64 %v, %v2
  ret i1 %ret
}

; Legal to fold (TODO)
define i1 @load_fold_icmp3(i64* %p1, i64* %p2) {
; CHECK-O0-LABEL: load_fold_icmp3:
; CHECK-O0:       # %bb.0:
; CHECK-O0-NEXT:    movq (%rdi), %rdi
; CHECK-O0-NEXT:    movq (%rsi), %rsi
; CHECK-O0-NEXT:    subq %rsi, %rdi
; CHECK-O0-NEXT:    sete %al
; CHECK-O0-NEXT:    movq %rdi, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-O0-NEXT:    retq
;
; CHECK-O3-LABEL: load_fold_icmp3:
; CHECK-O3:       # %bb.0:
; CHECK-O3-NEXT:    movq (%rdi), %rax
; CHECK-O3-NEXT:    movq (%rsi), %rcx
; CHECK-O3-NEXT:    cmpq %rcx, %rax
; CHECK-O3-NEXT:    sete %al
; CHECK-O3-NEXT:    retq
  %v = load atomic i64, i64* %p1 unordered, align 8
  %v2 = load atomic i64, i64* %p2 unordered, align 8
  %ret = icmp eq i64 %v, %v2
  ret i1 %ret
}
