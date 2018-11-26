; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-pc-windows | FileCheck %s

; We should be able to prodcue a single 128-bit load for these two 64-bit loads.
; But we previously weren't because we weren't consistently looking through
; WrapperRIP.

@f = local_unnamed_addr global [4 x float] zeroinitializer, align 16
@ms = common local_unnamed_addr global <4 x float> zeroinitializer, align 16

define void @foo2() {
; CHECK-LABEL: foo2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movaps {{.*}}(%rip), %xmm0
; CHECK-NEXT:    movaps %xmm0, {{.*}}(%rip)
; CHECK-NEXT:    retq
entry:
  %0 = load <2 x float>, <2 x float>* bitcast (float* getelementptr inbounds ([4 x float], [4 x float]* @f, i64 0, i64 2) to <2 x float>*), align 8
  %shuffle.i10 = shufflevector <2 x float> %0, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %1 = load <2 x float>, <2 x float>* bitcast ([4 x float]* @f to <2 x float>*), align 16
  %shuffle.i7 = shufflevector <2 x float> %1, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %shuffle.i = shufflevector <4 x float> %shuffle.i7, <4 x float> %shuffle.i10, <4 x i32> <i32 0, i32 1, i32 4, i32 5>
  store <4 x float> %shuffle.i, <4 x float>* @ms, align 16
  ret void
}
