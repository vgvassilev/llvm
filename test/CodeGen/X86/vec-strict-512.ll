; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx512f -mattr=+avx512vl -O3 | FileCheck %s
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f -mattr=+avx512vl -O3 | FileCheck %s

declare <8 x double> @llvm.experimental.constrained.fadd.v8f64(<8 x double>, <8 x double>, metadata, metadata)
declare <16 x float> @llvm.experimental.constrained.fadd.v16f32(<16 x float>, <16 x float>, metadata, metadata)
declare <8 x double> @llvm.experimental.constrained.fsub.v8f64(<8 x double>, <8 x double>, metadata, metadata)
declare <16 x float> @llvm.experimental.constrained.fsub.v16f32(<16 x float>, <16 x float>, metadata, metadata)
declare <8 x double> @llvm.experimental.constrained.fmul.v8f64(<8 x double>, <8 x double>, metadata, metadata)
declare <16 x float> @llvm.experimental.constrained.fmul.v16f32(<16 x float>, <16 x float>, metadata, metadata)
declare <8 x double> @llvm.experimental.constrained.fdiv.v8f64(<8 x double>, <8 x double>, metadata, metadata)
declare <16 x float> @llvm.experimental.constrained.fdiv.v16f32(<16 x float>, <16 x float>, metadata, metadata)
declare <8 x double> @llvm.experimental.constrained.sqrt.v8f64(<8 x double>, metadata, metadata)
declare <16 x float> @llvm.experimental.constrained.sqrt.v16f32(<16 x float>, metadata, metadata)
declare <8 x double> @llvm.experimental.constrained.fpext.v8f64.v8f32(<8 x float>, metadata)
declare <8 x float> @llvm.experimental.constrained.fptrunc.v8f32.v8f64(<8 x double>, metadata, metadata)
declare <8 x double> @llvm.experimental.constrained.fma.v8f64(<8 x double>, <8 x double>, <8 x double>, metadata, metadata)
declare <16 x float> @llvm.experimental.constrained.fma.v16f32(<16 x float>, <16 x float>, <16 x float>, metadata, metadata)
declare <16 x float> @llvm.experimental.constrained.ceil.v16f32(<16 x float>, metadata)
declare <8 x double>  @llvm.experimental.constrained.ceil.v8f64(<8 x double>, metadata)
declare <16 x float> @llvm.experimental.constrained.floor.v16f32(<16 x float>, metadata)
declare <8 x double> @llvm.experimental.constrained.floor.v8f64(<8 x double>, metadata)
declare <16 x float> @llvm.experimental.constrained.trunc.v16f32(<16 x float>, metadata)
declare <8 x double> @llvm.experimental.constrained.trunc.v8f64(<8 x double>, metadata)
declare <16 x float> @llvm.experimental.constrained.rint.v16f32(<16 x float>, metadata, metadata)
declare <8 x double> @llvm.experimental.constrained.rint.v8f64(<8 x double>, metadata, metadata)
declare <16 x float> @llvm.experimental.constrained.nearbyint.v16f32(<16 x float>, metadata, metadata)
declare <8 x double> @llvm.experimental.constrained.nearbyint.v8f64(<8 x double>, metadata, metadata)


define <8 x double> @f1(<8 x double> %a, <8 x double> %b) #0 {
; CHECK-LABEL: f1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vaddpd %zmm1, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <8 x double> @llvm.experimental.constrained.fadd.v8f64(<8 x double> %a, <8 x double> %b,
                                                                     metadata !"round.dynamic",
                                                                     metadata !"fpexcept.strict") #0
  ret <8 x double> %ret
}

define <16 x float> @f2(<16 x float> %a, <16 x float> %b) #0 {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vaddps %zmm1, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <16 x float> @llvm.experimental.constrained.fadd.v16f32(<16 x float> %a, <16 x float> %b,
                                                                      metadata !"round.dynamic",
                                                                      metadata !"fpexcept.strict") #0
  ret <16 x float> %ret
}

define <8 x double> @f3(<8 x double> %a, <8 x double> %b) #0 {
; CHECK-LABEL: f3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsubpd %zmm1, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <8 x double> @llvm.experimental.constrained.fsub.v8f64(<8 x double> %a, <8 x double> %b,
                                                                     metadata !"round.dynamic",
                                                                     metadata !"fpexcept.strict") #0
  ret <8 x double> %ret
}

define <16 x float> @f4(<16 x float> %a, <16 x float> %b) #0 {
; CHECK-LABEL: f4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsubps %zmm1, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <16 x float> @llvm.experimental.constrained.fsub.v16f32(<16 x float> %a, <16 x float> %b,
                                                                      metadata !"round.dynamic",
                                                                      metadata !"fpexcept.strict") #0
  ret <16 x float> %ret
}

define <8 x double> @f5(<8 x double> %a, <8 x double> %b) #0 {
; CHECK-LABEL: f5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmulpd %zmm1, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <8 x double> @llvm.experimental.constrained.fmul.v8f64(<8 x double> %a, <8 x double> %b,
                                                                     metadata !"round.dynamic",
                                                                     metadata !"fpexcept.strict") #0
  ret <8 x double> %ret
}

define <16 x float> @f6(<16 x float> %a, <16 x float> %b) #0 {
; CHECK-LABEL: f6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmulps %zmm1, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <16 x float> @llvm.experimental.constrained.fmul.v16f32(<16 x float> %a, <16 x float> %b,
                                                                      metadata !"round.dynamic",
                                                                      metadata !"fpexcept.strict") #0
  ret <16 x float> %ret
}

define <8 x double> @f7(<8 x double> %a, <8 x double> %b) #0 {
; CHECK-LABEL: f7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vdivpd %zmm1, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <8 x double> @llvm.experimental.constrained.fdiv.v8f64(<8 x double> %a, <8 x double> %b,
                                                                     metadata !"round.dynamic",
                                                                     metadata !"fpexcept.strict") #0
  ret <8 x double> %ret
}

define <16 x float> @f8(<16 x float> %a, <16 x float> %b) #0 {
; CHECK-LABEL: f8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vdivps %zmm1, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <16 x float> @llvm.experimental.constrained.fdiv.v16f32(<16 x float> %a, <16 x float> %b,
                                                                      metadata !"round.dynamic",
                                                                      metadata !"fpexcept.strict") #0
  ret <16 x float> %ret
}

define <8 x double> @f9(<8 x double> %a) #0 {
; CHECK-LABEL: f9:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsqrtpd %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <8 x double> @llvm.experimental.constrained.sqrt.v8f64(
                              <8 x double> %a,
                              metadata !"round.dynamic",
                              metadata !"fpexcept.strict") #0
  ret <8 x double> %ret
}


define <16 x float> @f10(<16 x float> %a) #0 {
; CHECK-LABEL: f10:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsqrtps %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <16 x float> @llvm.experimental.constrained.sqrt.v16f32(
                              <16 x float> %a,
                              metadata !"round.dynamic",
                              metadata !"fpexcept.strict") #0
  ret <16 x float > %ret
}

define <8 x double> @f11(<8 x float> %a) #0 {
; CHECK-LABEL: f11:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vcvtps2pd %ymm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <8 x double> @llvm.experimental.constrained.fpext.v8f64.v8f32(
                                <8 x float> %a,
                                metadata !"fpexcept.strict") #0
  ret <8 x double> %ret
}

define <8 x float> @f12(<8 x double> %a) #0 {
; CHECK-LABEL: f12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vcvtpd2ps %zmm0, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
  %ret = call <8 x float> @llvm.experimental.constrained.fptrunc.v8f32.v8f64(
                                <8 x double> %a,
                                metadata !"round.dynamic",
                                metadata !"fpexcept.strict") #0
  ret <8 x float> %ret
}

define <16 x float> @f13(<16 x float> %a, <16 x float> %b, <16 x float> %c) #0 {
; CHECK-LABEL: f13:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vfmadd213ps {{.*#+}} zmm0 = (zmm1 * zmm0) + zmm2
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <16 x float> @llvm.experimental.constrained.fma.v16f32(<16 x float> %a, <16 x float> %b, <16 x float> %c,
                                                                     metadata !"round.dynamic",
                                                                     metadata !"fpexcept.strict") #0
  ret <16 x float> %res
}

define <8 x double> @f14(<8 x double> %a, <8 x double> %b, <8 x double> %c) #0 {
; CHECK-LABEL: f14:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vfmadd213pd {{.*#+}} zmm0 = (zmm1 * zmm0) + zmm2
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <8 x double> @llvm.experimental.constrained.fma.v8f64(<8 x double> %a, <8 x double> %b, <8 x double> %c,
                                                                    metadata !"round.dynamic",
                                                                    metadata !"fpexcept.strict") #0
  ret <8 x double> %res
}

define <16 x float> @strict_vector_fceil_v16f32(<16 x float> %f) #0 {
; CHECK-LABEL: strict_vector_fceil_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vrndscaleps $10, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <16 x float> @llvm.experimental.constrained.ceil.v16f32(<16 x float> %f, metadata !"fpexcept.strict") #0
  ret <16 x float> %res
}

define <8 x double> @strict_vector_fceil_v8f64(<8 x double> %f) #0 {
; CHECK-LABEL: strict_vector_fceil_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vrndscalepd $10, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <8 x double> @llvm.experimental.constrained.ceil.v8f64(<8 x double> %f, metadata !"fpexcept.strict") #0
  ret <8 x double> %res
}

define <16 x float> @strict_vector_ffloor_v16f32(<16 x float> %f) #0 {
; CHECK-LABEL: strict_vector_ffloor_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vrndscaleps $9, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <16 x float> @llvm.experimental.constrained.floor.v16f32(<16 x float> %f, metadata !"fpexcept.strict") #0
  ret <16 x float> %res
}

define <8 x double> @strict_vector_ffloor_v8f64(<8 x double> %f) #0 {
; CHECK-LABEL: strict_vector_ffloor_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vrndscalepd $9, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <8 x double> @llvm.experimental.constrained.floor.v8f64(<8 x double> %f, metadata !"fpexcept.strict") #0
  ret <8 x double> %res
}

define <16 x float> @strict_vector_ftrunc_v16f32(<16 x float> %f) #0 {
; CHECK-LABEL: strict_vector_ftrunc_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vrndscaleps $11, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <16 x float> @llvm.experimental.constrained.trunc.v16f32(<16 x float> %f, metadata !"fpexcept.strict") #0
  ret <16 x float> %res
}

define <8 x double> @strict_vector_ftrunc_v8f64(<8 x double> %f) #0 {
; CHECK-LABEL: strict_vector_ftrunc_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vrndscalepd $11, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <8 x double> @llvm.experimental.constrained.trunc.v8f64(<8 x double> %f, metadata !"fpexcept.strict") #0
  ret <8 x double> %res
}

define <16 x float> @strict_vector_frint_v16f32(<16 x float> %f) #0 {
; CHECK-LABEL: strict_vector_frint_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vrndscaleps $4, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <16 x float> @llvm.experimental.constrained.rint.v16f32(<16 x float> %f,
                             metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret <16 x float> %res
}

define <8 x double> @strict_vector_frint_v8f64(<8 x double> %f) #0 {
; CHECK-LABEL: strict_vector_frint_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vrndscalepd $4, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <8 x double> @llvm.experimental.constrained.rint.v8f64(<8 x double> %f,
                            metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret <8 x double> %res
}

define <16 x float> @strict_vector_fnearbyint_v16f32(<16 x float> %f) #0 {
; CHECK-LABEL: strict_vector_fnearbyint_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vrndscaleps $12, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <16 x float> @llvm.experimental.constrained.nearbyint.v16f32(<16 x float> %f,
                             metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret <16 x float> %res
}

define <8 x double> @strict_vector_fnearbyint_v8f64(<8 x double> %f) #0 {
; CHECK-LABEL: strict_vector_fnearbyint_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vrndscalepd $12, %zmm0, %zmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %res = call <8 x double> @llvm.experimental.constrained.nearbyint.v8f64(<8 x double> %f,
                             metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret <8 x double> %res
}

attributes #0 = { strictfp }
