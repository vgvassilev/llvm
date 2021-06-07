; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+fma | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+fma | FileCheck %s --check-prefix=X64

define float @f1(float %a, float %b, float %c) {
; X86-LABEL: f1:
; X86:       # %bb.0:
; X86-NEXT:    pushl %eax
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X86-NEXT:    vmovss {{.*#+}} xmm1 = mem[0],zero,zero,zero
; X86-NEXT:    vfmadd213ss {{.*#+}} xmm1 = (xmm0 * xmm1) + mem
; X86-NEXT:    vmovss %xmm1, (%esp)
; X86-NEXT:    flds (%esp)
; X86-NEXT:    popl %eax
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: f1:
; X64:       # %bb.0:
; X64-NEXT:    vfmadd213ss {{.*#+}} xmm0 = (xmm1 * xmm0) + xmm2
; X64-NEXT:    retq
  %mul = fmul fast float %b, %a
  %add = fadd fast float %mul, %c
  ret float %add
}

define float @f2(float %a, float %b, float %c) {
; X86-LABEL: f2:
; X86:       # %bb.0:
; X86-NEXT:    pushl %eax
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X86-NEXT:    vmulss {{[0-9]+}}(%esp), %xmm0, %xmm0
; X86-NEXT:    #ARITH_FENCE
; X86-NEXT:    vaddss {{[0-9]+}}(%esp), %xmm0, %xmm0
; X86-NEXT:    vmovss %xmm0, (%esp)
; X86-NEXT:    flds (%esp)
; X86-NEXT:    popl %eax
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    retl
;
; X64-LABEL: f2:
; X64:       # %bb.0:
; X64-NEXT:    vmulss %xmm0, %xmm1, %xmm0
; X64-NEXT:    #ARITH_FENCE
; X64-NEXT:    vaddss %xmm2, %xmm0, %xmm0
; X64-NEXT:    retq
  %mul = fmul fast float %b, %a
  %tmp = call float @llvm.arithmetic.fence.f32(float %mul)
  %add = fadd fast float %tmp, %c
  ret float %add
}

define double @f3(double %a) {
; X86-LABEL: f3:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %ebp, -8
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    .cfi_def_cfa_register %ebp
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $8, %esp
; X86-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    vmulsd {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0, %xmm0
; X86-NEXT:    vmovsd %xmm0, (%esp)
; X86-NEXT:    fldl (%esp)
; X86-NEXT:    movl %ebp, %esp
; X86-NEXT:    popl %ebp
; X86-NEXT:    .cfi_def_cfa %esp, 4
; X86-NEXT:    retl
;
; X64-LABEL: f3:
; X64:       # %bb.0:
; X64-NEXT:    vmulsd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    retq
  %1 = fadd fast double %a, %a
  %2 = fadd fast double %a, %a
  %3 = fadd fast double %1, %2
  ret double %3
}

define double @f4(double %a) {
; X86-LABEL: f4:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebp
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %ebp, -8
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    .cfi_def_cfa_register %ebp
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $8, %esp
; X86-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    vaddsd %xmm0, %xmm0, %xmm0
; X86-NEXT:    vmovapd %xmm0, %xmm1
; X86-NEXT:    #ARITH_FENCE
; X86-NEXT:    vaddsd %xmm0, %xmm1, %xmm0
; X86-NEXT:    vmovsd %xmm0, (%esp)
; X86-NEXT:    fldl (%esp)
; X86-NEXT:    movl %ebp, %esp
; X86-NEXT:    popl %ebp
; X86-NEXT:    .cfi_def_cfa %esp, 4
; X86-NEXT:    retl
;
; X64-LABEL: f4:
; X64:       # %bb.0:
; X64-NEXT:    vaddsd %xmm0, %xmm0, %xmm0
; X64-NEXT:    vmovapd %xmm0, %xmm1
; X64-NEXT:    #ARITH_FENCE
; X64-NEXT:    vaddsd %xmm0, %xmm1, %xmm0
; X64-NEXT:    retq
  %1 = fadd fast double %a, %a
  %t = call double @llvm.arithmetic.fence.f64(double %1)
  %2 = fadd fast double %a, %a
  %3 = fadd fast double %t, %2
  ret double %3
}

define <2 x float> @f5(<2 x float> %a) {
; X86-LABEL: f5:
; X86:       # %bb.0:
; X86-NEXT:    vmulps {{\.?LCPI[0-9]+_[0-9]+}}, %xmm0, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: f5:
; X64:       # %bb.0:
; X64-NEXT:    vmulps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; X64-NEXT:    retq
  %1 = fadd fast <2 x float> %a, %a
  %2 = fadd fast <2 x float> %a, %a
  %3 = fadd fast <2 x float> %1, %2
  ret <2 x float> %3
}

define <2 x float> @f6(<2 x float> %a) {
; X86-LABEL: f6:
; X86:       # %bb.0:
; X86-NEXT:    vaddps %xmm0, %xmm0, %xmm0
; X86-NEXT:    vmovaps %xmm0, %xmm1
; X86-NEXT:    #ARITH_FENCE
; X86-NEXT:    vaddps %xmm0, %xmm1, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: f6:
; X64:       # %bb.0:
; X64-NEXT:    vaddps %xmm0, %xmm0, %xmm0
; X64-NEXT:    vmovaps %xmm0, %xmm1
; X64-NEXT:    #ARITH_FENCE
; X64-NEXT:    vaddps %xmm0, %xmm1, %xmm0
; X64-NEXT:    retq
  %1 = fadd fast <2 x float> %a, %a
  %t = call <2 x float> @llvm.arithmetic.fence.v2f32(<2 x float> %1)
  %2 = fadd fast <2 x float> %a, %a
  %3 = fadd fast <2 x float> %t, %2
  ret <2 x float> %3
}

declare float @llvm.arithmetic.fence.f32(float)
declare double @llvm.arithmetic.fence.f64(double)
declare <2 x float> @llvm.arithmetic.fence.v2f32(<2 x float>)
