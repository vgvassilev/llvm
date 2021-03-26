; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- | FileCheck %s

declare <4 x double> @llvm.sin.v4f64(<4 x double> %p)
declare <4 x double> @llvm.cos.v4f64(<4 x double> %p)
declare <4 x double> @llvm.pow.v4f64(<4 x double> %p, <4 x double> %q)
declare <4 x double> @llvm.powi.v4f64.i32(<4 x double> %p, i32)

define <4 x double> @foo(<4 x double> %p)
; CHECK-LABEL: foo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $56, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq sin@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    callq sin@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    callq sin@PLT
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    callq sin@PLT
; CHECK-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    addq $56, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
{
  %t = call <4 x double> @llvm.sin.v4f64(<4 x double> %p)
  ret <4 x double> %t
}
define <4 x double> @goo(<4 x double> %p)
; CHECK-LABEL: goo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $56, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq cos@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    callq cos@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    callq cos@PLT
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    callq cos@PLT
; CHECK-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    addq $56, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
{
  %t = call <4 x double> @llvm.cos.v4f64(<4 x double> %p)
  ret <4 x double> %t
}
define <4 x double> @moo(<4 x double> %p, <4 x double> %q)
; CHECK-LABEL: moo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $88, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 96
; CHECK-NEXT:    movaps %xmm3, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps %xmm2, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps %xmm2, %xmm1
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    addq $88, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
{
  %t = call <4 x double> @llvm.pow.v4f64(<4 x double> %p, <4 x double> %q)
  ret <4 x double> %t
}
define <4 x double> @zoo(<4 x double> %p, i32 %q)
; CHECK-LABEL: zoo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    subq $48, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NEXT:    .cfi_offset %rbx, -16
; CHECK-NEXT:    movl %edi, %ebx
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movl %ebx, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movl %ebx, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movl %ebx, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    addq $48, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
{
  %t = call <4 x double> @llvm.powi.v4f64.i32(<4 x double> %p, i32 %q)
  ret <4 x double> %t
}


declare <9 x double> @llvm.exp.v9f64(<9 x double> %a)
declare <9 x double> @llvm.pow.v9f64(<9 x double> %a, <9 x double> %b)
declare <9 x double> @llvm.powi.v9f64.i32(<9 x double> %a, i32)

define void @a(<9 x double>* %p) nounwind {
; CHECK-LABEL: a:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $96, %rsp
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    movsd %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movaps (%rdi), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps 16(%rdi), %xmm0
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movaps 32(%rdi), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps 48(%rdi), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    callq exp@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    callq exp@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    callq exp@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    callq exp@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    callq exp@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    callq exp@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    callq exp@PLT
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    callq exp@PLT
; CHECK-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movsd {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 8-byte Reload
; CHECK-NEXT:    # xmm0 = mem[0],zero
; CHECK-NEXT:    callq exp@PLT
; CHECK-NEXT:    movsd %xmm0, 64(%rbx)
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, (%rbx)
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, 16(%rbx)
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, 32(%rbx)
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, 48(%rbx)
; CHECK-NEXT:    addq $96, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    retq
  %a = load <9 x double>, <9 x double>* %p
  %r = call <9 x double> @llvm.exp.v9f64(<9 x double> %a)
  store <9 x double> %r, <9 x double>* %p
  ret void
}
define void @b(<9 x double>* %p, <9 x double>* %q) nounwind {
; CHECK-LABEL: b:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $160, %rsp
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    movsd %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movaps (%rdi), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps 16(%rdi), %xmm0
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movaps 32(%rdi), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps 48(%rdi), %xmm2
; CHECK-NEXT:    movaps %xmm2, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    movsd %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movaps (%rsi), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps 16(%rsi), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps 32(%rsi), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps 48(%rsi), %xmm1
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps %xmm2, %xmm0
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm1 = xmm1[1,1]
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movsd {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 8-byte Reload
; CHECK-NEXT:    # xmm0 = mem[0],zero
; CHECK-NEXT:    movsd {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 8-byte Reload
; CHECK-NEXT:    # xmm1 = mem[0],zero
; CHECK-NEXT:    callq pow@PLT
; CHECK-NEXT:    movsd %xmm0, 64(%rbx)
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, (%rbx)
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, 16(%rbx)
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, 32(%rbx)
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, 48(%rbx)
; CHECK-NEXT:    addq $160, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    retq
  %a = load <9 x double>, <9 x double>* %p
  %b = load <9 x double>, <9 x double>* %q
  %r = call <9 x double> @llvm.pow.v9f64(<9 x double> %a, <9 x double> %b)
  store <9 x double> %r, <9 x double>* %p
  ret void
}
define void @c(<9 x double>* %p, i32 %n) nounwind {
; CHECK-LABEL: c:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $104, %rsp
; CHECK-NEXT:    movl %esi, %ebp
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; CHECK-NEXT:    movsd %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 8-byte Spill
; CHECK-NEXT:    movaps (%rdi), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps 16(%rdi), %xmm0
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movaps 32(%rdi), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps 48(%rdi), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movl %esi, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movl %ebp, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movl %ebp, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movl %ebp, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movl %ebp, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movl %ebp, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, {{[-0-9]+}}(%r{{[sb]}}p) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movl %ebp, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movhlps {{.*#+}} xmm0 = xmm0[1,1]
; CHECK-NEXT:    movl %ebp, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movaps (%rsp), %xmm1 # 16-byte Reload
; CHECK-NEXT:    movlhps {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; CHECK-NEXT:    movaps %xmm1, (%rsp) # 16-byte Spill
; CHECK-NEXT:    movsd {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 8-byte Reload
; CHECK-NEXT:    # xmm0 = mem[0],zero
; CHECK-NEXT:    movl %ebp, %edi
; CHECK-NEXT:    callq __powidf2@PLT
; CHECK-NEXT:    movsd %xmm0, 64(%rbx)
; CHECK-NEXT:    movaps (%rsp), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, (%rbx)
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, 16(%rbx)
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, 32(%rbx)
; CHECK-NEXT:    movaps {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 # 16-byte Reload
; CHECK-NEXT:    movaps %xmm0, 48(%rbx)
; CHECK-NEXT:    addq $104, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    retq
  %a = load <9 x double>, <9 x double>* %p
  %r = call <9 x double> @llvm.powi.v9f64.i32(<9 x double> %a, i32 %n)
  store <9 x double> %r, <9 x double>* %p
  ret void
}
