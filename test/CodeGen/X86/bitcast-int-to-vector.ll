; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=i686-unknown -mattr=+sse2 | FileCheck %s --check-prefix=X86-SSE
; RUN: llc < %s -mtriple=x86_64-unknown | FileCheck %s --check-prefix=X64

define i1 @foo(i64 %a) {
; X86-LABEL: foo:
; X86:       # %bb.0:
; X86-NEXT:    flds {{[0-9]+}}(%esp)
; X86-NEXT:    flds {{[0-9]+}}(%esp)
; X86-NEXT:    fucompp
; X86-NEXT:    fnstsw %ax
; X86-NEXT:    # kill: def $ah killed $ah killed $ax
; X86-NEXT:    sahf
; X86-NEXT:    setp %al
; X86-NEXT:    retl
;
; X86-SSE-LABEL: foo:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; X86-SSE-NEXT:    movaps %xmm0, %xmm1
; X86-SSE-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1],xmm0[2,3]
; X86-SSE-NEXT:    ucomiss %xmm1, %xmm0
; X86-SSE-NEXT:    setp %al
; X86-SSE-NEXT:    retl
;
; X64-LABEL: foo:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %xmm0
; X64-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,2,3]
; X64-NEXT:    ucomiss %xmm1, %xmm0
; X64-NEXT:    setp %al
; X64-NEXT:    retq
  %t = bitcast i64 %a to <2 x float>
  %r = extractelement <2 x float> %t, i32 0
  %s = extractelement <2 x float> %t, i32 1
  %b = fcmp uno float %r, %s
  ret i1 %b
}
