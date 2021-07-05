; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mcpu=core-avx2 | FileCheck %s

%v8_uniform_FVector3 = type { float, float, float }

declare <8 x float> @llvm.x86.avx.hadd.ps.256(<8 x float>, <8 x float>)

define void @foo(%v8_uniform_FVector3* %Out, float* %In, <8 x i32> %__mask) {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %allocas
; CHECK-NEXT:    vmovups (%rsi), %xmm0
; CHECK-NEXT:    vhaddps 32(%rsi), %xmm0, %xmm0
; CHECK-NEXT:    vpermpd {{.*#+}} ymm0 = ymm0[0,0,1,1]
; CHECK-NEXT:    vhaddps %ymm0, %ymm0, %ymm0
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm1
; CHECK-NEXT:    vaddss %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vmovss %xmm0, (%rdi)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
allocas:
  %ptr_cast_for_load = bitcast float* %In to <8 x float>*
  %ptr_masked_load74 = load <8 x float>, <8 x float>* %ptr_cast_for_load, align 4
  %ptr8096 = getelementptr float, float* %In, i64 8
  %ptr_cast_for_load81 = bitcast float* %ptr8096 to <8 x float>*
  %ptr80_masked_load82 = load <8 x float>, <8 x float>* %ptr_cast_for_load81, align 4
  %ret_7.i.i = shufflevector <8 x float> %ptr_masked_load74, <8 x float> %ptr80_masked_load82, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
  %Out_load19 = getelementptr %v8_uniform_FVector3, %v8_uniform_FVector3* %Out, i64 0, i32 0
  %v1.i.i100 = tail call <8 x float> @llvm.x86.avx.hadd.ps.256(<8 x float> %ret_7.i.i, <8 x float> %ret_7.i.i)
  %v2.i.i101 = tail call <8 x float> @llvm.x86.avx.hadd.ps.256(<8 x float> %v1.i.i100, <8 x float> %v1.i.i100)
  %scalar1.i.i102 = extractelement <8 x float> %v2.i.i101, i32 0
  %scalar2.i.i103 = extractelement <8 x float> %v2.i.i101, i32 4
  %sum.i.i104 = fadd float %scalar1.i.i102, %scalar2.i.i103
  store float %sum.i.i104, float* %Out_load19, align 4
  ret void
}
