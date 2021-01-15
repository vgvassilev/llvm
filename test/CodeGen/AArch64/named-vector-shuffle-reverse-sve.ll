; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs  < %s 2>%t | FileCheck --check-prefix=CHECK --check-prefix=CHECK-SELDAG  %s
; RUN: llc -verify-machineinstrs -O0 < %s 2>%t | FileCheck --check-prefix=CHECK --check-prefix=CHECK-FASTISEL %s

; RUN: FileCheck --check-prefix=WARN --allow-empty %s <%t

; If this check fails please read test/CodeGen/AArch64/README for instructions on how to resolve it.
; WARN-NOT: warning

target triple = "aarch64-unknown-linux-gnu"

;
; VECTOR_REVERSE - PPR
;

define <vscale x 2 x i1> @reverse_nxv2i1(<vscale x 2 x i1> %a) #0 {
; CHECK-LABEL: reverse_nxv2i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev p0.d, p0.d
; CHECK-NEXT:    ret

  %res = call <vscale x 2 x i1> @llvm.experimental.vector.reverse.nxv2i1(<vscale x 2 x i1> %a)
  ret <vscale x 2 x i1> %res
}

define <vscale x 4 x i1> @reverse_nxv4i1(<vscale x 4 x i1> %a) #0 {
; CHECK-LABEL: reverse_nxv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev p0.s, p0.s
; CHECK-NEXT:    ret

  %res = call <vscale x 4 x i1> @llvm.experimental.vector.reverse.nxv4i1(<vscale x 4 x i1> %a)
  ret <vscale x 4 x i1> %res
}

define <vscale x 8 x i1> @reverse_nxv8i1(<vscale x 8 x i1> %a) #0 {
; CHECK-LABEL: reverse_nxv8i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev p0.h, p0.h
; CHECK-NEXT:    ret

  %res = call <vscale x 8 x i1> @llvm.experimental.vector.reverse.nxv8i1(<vscale x 8 x i1> %a)
  ret <vscale x 8 x i1> %res
}

define <vscale x 16 x i1> @reverse_nxv16i1(<vscale x 16 x i1> %a) #0 {
; CHECK-LABEL: reverse_nxv16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev p0.b, p0.b
; CHECK-NEXT:    ret

  %res = call <vscale x 16 x i1> @llvm.experimental.vector.reverse.nxv16i1(<vscale x 16 x i1> %a)
  ret <vscale x 16 x i1> %res
}

; Verify splitvec type legalisation works as expected.
define <vscale x 32 x i1> @reverse_nxv32i1(<vscale x 32 x i1> %a) #0 {
; CHECK-LABEL: reverse_nxv32i1:
; CHECK-SELDAG:       // %bb.0:
; CHECK-SELDAG-NEXT:    rev p2.b, p1.b
; CHECK-SELDAG-NEXT:    rev p1.b, p0.b
; CHECK-SELDAG-NEXT:    mov p0.b, p2.b
; CHECK-SELDAG-NEXT:    ret
; CHECK-FASTISEL:       // %bb.0:
; CHECK-FASTISEL-NEXT:    str    x29, [sp, #-16]
; CHECK-FASTISEL-NEXT:    addvl    sp, sp, #-1
; CHECK-FASTISEL-NEXT:    str    p1, [sp, #7, mul vl]
; CHECK-FASTISEL-NEXT:    mov    p1.b, p0.b
; CHECK-FASTISEL-NEXT:    ldr    p0, [sp, #7, mul vl]
; CHECK-FASTISEL-NEXT:    rev    p0.b, p0.b
; CHECK-FASTISEL-NEXT:    rev    p1.b, p1.b
; CHECK-FASTISEL-NEXT:    addvl    sp, sp, #1
; CHECK-FASTISEL-NEXT:    ldr    x29, [sp], #16
; CHECK-FASTISEL-NEXT:    ret

  %res = call <vscale x 32 x i1> @llvm.experimental.vector.reverse.nxv32i1(<vscale x 32 x i1> %a)
  ret <vscale x 32 x i1> %res
}

;
; VECTOR_REVERSE - ZPR
;

define <vscale x 16 x i8> @reverse_nxv16i8(<vscale x 16 x i8> %a) #0 {
; CHECK-LABEL: reverse_nxv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev z0.b, z0.b
; CHECK-NEXT:    ret

  %res = call <vscale x 16 x i8> @llvm.experimental.vector.reverse.nxv16i8(<vscale x 16 x i8> %a)
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @reverse_nxv8i16(<vscale x 8 x i16> %a) #0 {
; CHECK-LABEL: reverse_nxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev z0.h, z0.h
; CHECK-NEXT:    ret

  %res = call <vscale x 8 x i16> @llvm.experimental.vector.reverse.nxv8i16(<vscale x 8 x i16> %a)
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @reverse_nxv4i32(<vscale x 4 x i32> %a) #0 {
; CHECK-LABEL: reverse_nxv4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev z0.s, z0.s
; CHECK-NEXT:    ret

  %res = call <vscale x 4 x i32> @llvm.experimental.vector.reverse.nxv4i32(<vscale x 4 x i32> %a)
  ret <vscale x 4 x i32> %res
}

define <vscale x 2 x i64> @reverse_nxv2i64(<vscale x 2 x i64> %a) #0 {
; CHECK-LABEL: reverse_nxv2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev z0.d, z0.d
; CHECK-NEXT:    ret

  %res = call <vscale x 2 x i64> @llvm.experimental.vector.reverse.nxv2i64(<vscale x 2 x i64> %a)
  ret <vscale x 2 x i64> %res
}

define <vscale x 8 x half> @reverse_nxv8f16(<vscale x 8 x half> %a) #0 {
; CHECK-LABEL: reverse_nxv8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev z0.h, z0.h
; CHECK-NEXT:    ret

  %res = call <vscale x 8 x half> @llvm.experimental.vector.reverse.nxv8f16(<vscale x 8 x half> %a)
  ret <vscale x 8 x half> %res
}

define <vscale x 4 x float> @reverse_nxv4f32(<vscale x 4 x float> %a) #0 {
; CHECK-LABEL: reverse_nxv4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev z0.s, z0.s
; CHECK-NEXT:    ret

  %res = call <vscale x 4 x float> @llvm.experimental.vector.reverse.nxv4f32(<vscale x 4 x float> %a)  ret <vscale x 4 x float> %res
}

define <vscale x 2 x double> @reverse_nxv2f64(<vscale x 2 x double> %a) #0 {
; CHECK-LABEL: reverse_nxv2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev z0.d, z0.d
; CHECK-NEXT:    ret

  %res = call <vscale x 2 x double> @llvm.experimental.vector.reverse.nxv2f64(<vscale x 2 x double> %a)
  ret <vscale x 2 x double> %res
}

; Verify promote type legalisation works as expected.
define <vscale x 2 x i8> @reverse_nxv2i8(<vscale x 2 x i8> %a) #0 {
; CHECK-LABEL: reverse_nxv2i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    rev z0.d, z0.d
; CHECK-NEXT:    ret

  %res = call <vscale x 2 x i8> @llvm.experimental.vector.reverse.nxv2i8(<vscale x 2 x i8> %a)
  ret <vscale x 2 x i8> %res
}

; Verify splitvec type legalisation works as expected.
define <vscale x 8 x i32> @reverse_nxv8i32(<vscale x 8 x i32> %a) #0 {
; CHECK-LABEL: reverse_nxv8i32:
; CHECK-SELDAG:       // %bb.0:
; CHECK-SELDAG-NEXT:    rev z2.s, z1.s
; CHECK-SELDAG-NEXT:    rev z1.s, z0.s
; CHECK-SELDAG-NEXT:    mov z0.d, z2.d
; CHECK-SELDAG-NEXT:    ret
; CHECK-FASTISEL:       // %bb.0:
; CHECK-FASTISEL-NEXT:    str    x29, [sp, #-16]
; CHECK-FASTISEL-NEXT:    addvl    sp, sp, #-1
; CHECK-FASTISEL-NEXT:    str    z1, [sp]
; CHECK-FASTISEL-NEXT:    mov    z1.d, z0.d
; CHECK-FASTISEL-NEXT:    ldr    z0, [sp]
; CHECK-FASTISEL-NEXT:    rev    z0.s, z0.s
; CHECK-FASTISEL-NEXT:    rev    z1.s, z1.s
; CHECK-FASTISEL-NEXT:    addvl    sp, sp, #1
; CHECK-FASTISEL-NEXT:    ldr    x29, [sp], #16
; CHECK-FASTISEL-NEXT:    ret

  %res = call <vscale x 8 x i32> @llvm.experimental.vector.reverse.nxv8i32(<vscale x 8 x i32> %a)
  ret <vscale x 8 x i32> %res
}

; Verify splitvec type legalisation works as expected.
define <vscale x 16 x float> @reverse_nxv16f32(<vscale x 16 x float> %a) #0 {
; CHECK-LABEL: reverse_nxv16f32:
; CHECK-SELDAG:       // %bb.0:
; CHECK-SELDAG-NEXT:    rev z5.s, z3.s
; CHECK-SELDAG-NEXT:    rev z4.s, z2.s
; CHECK-SELDAG-NEXT:    rev z2.s, z1.s
; CHECK-SELDAG-NEXT:    rev z3.s, z0.s
; CHECK-SELDAG-NEXT:    mov z0.d, z5.d
; CHECK-SELDAG-NEXT:    mov z1.d, z4.d
; CHECK-SELDAG-NEXT:    ret
; CHECK-FASTISEL:       // %bb.0:
; CHECK-FASTISEL-NEXT:    str    x29, [sp, #-16]
; CHECK-FASTISEL-NEXT:    addvl    sp, sp, #-2
; CHECK-FASTISEL-NEXT:    str    z3, [sp, #1, mul vl]
; CHECK-FASTISEL-NEXT:    str    z2, [sp]
; CHECK-FASTISEL-NEXT:    mov    z2.d, z1.d
; CHECK-FASTISEL-NEXT:    ldr    z1, [sp]
; CHECK-FASTISEL-NEXT:    mov    z3.d, z0.d
; CHECK-FASTISEL-NEXT:    ldr    z0, [sp, #1, mul vl]
; CHECK-FASTISEL-NEXT:    rev    z0.s, z0.s
; CHECK-FASTISEL-NEXT:    rev    z1.s, z1.s
; CHECK-FASTISEL-NEXT:    rev    z2.s, z2.s
; CHECK-FASTISEL-NEXT:    rev    z3.s, z3.s
; CHECK-FASTISEL-NEXT:    addvl    sp, sp, #2
; CHECK-FASTISEL-NEXT:    ldr    x29, [sp], #16
; CHECK-FASTISEL-NEXT:    ret

  %res = call <vscale x 16 x float> @llvm.experimental.vector.reverse.nxv16f32(<vscale x 16 x float> %a)
  ret <vscale x 16 x float> %res
}


declare <vscale x 2 x i1> @llvm.experimental.vector.reverse.nxv2i1(<vscale x 2 x i1>)
declare <vscale x 4 x i1> @llvm.experimental.vector.reverse.nxv4i1(<vscale x 4 x i1>)
declare <vscale x 8 x i1> @llvm.experimental.vector.reverse.nxv8i1(<vscale x 8 x i1>)
declare <vscale x 16 x i1> @llvm.experimental.vector.reverse.nxv16i1(<vscale x 16 x i1>)
declare <vscale x 32 x i1> @llvm.experimental.vector.reverse.nxv32i1(<vscale x 32 x i1>)
declare <vscale x 2 x i8> @llvm.experimental.vector.reverse.nxv2i8(<vscale x 2 x i8>)
declare <vscale x 16 x i8> @llvm.experimental.vector.reverse.nxv16i8(<vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.experimental.vector.reverse.nxv8i16(<vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.experimental.vector.reverse.nxv4i32(<vscale x 4 x i32>)
declare <vscale x 8 x i32> @llvm.experimental.vector.reverse.nxv8i32(<vscale x 8 x i32>)
declare <vscale x 2 x i64> @llvm.experimental.vector.reverse.nxv2i64(<vscale x 2 x i64>)
declare <vscale x 8 x half> @llvm.experimental.vector.reverse.nxv8f16(<vscale x 8 x half>)
declare <vscale x 4 x float> @llvm.experimental.vector.reverse.nxv4f32(<vscale x 4 x float>)
declare <vscale x 16 x float> @llvm.experimental.vector.reverse.nxv16f32(<vscale x 16 x float>)
declare <vscale x 2 x double> @llvm.experimental.vector.reverse.nxv2f64(<vscale x 2 x double>)


attributes #0 = { nounwind "target-features"="+sve" }
