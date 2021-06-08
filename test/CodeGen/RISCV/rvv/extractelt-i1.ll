; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -verify-machineinstrs < %s | FileCheck %s

define i1 @extractelt_nxv1i1(<vscale x 1 x i8>* %x, i64 %idx) nounwind {
; CHECK-LABEL: extractelt_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e8, mf8, ta, mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmseq.vi v0, v25, 0
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, mu
; CHECK-NEXT:    vslidedown.vx v25, v25, a1
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    ret
  %a = load <vscale x 1 x i8>, <vscale x 1 x i8>* %x
  %b = icmp eq <vscale x 1 x i8> %a, zeroinitializer
  %c = extractelement <vscale x 1 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_nxv2i1(<vscale x 2 x i8>* %x, i64 %idx) nounwind {
; CHECK-LABEL: extractelt_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e8, mf4, ta, mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmseq.vi v0, v25, 0
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    vsetivli zero, 1, e8, mf4, ta, mu
; CHECK-NEXT:    vslidedown.vx v25, v25, a1
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    ret
  %a = load <vscale x 2 x i8>, <vscale x 2 x i8>* %x
  %b = icmp eq <vscale x 2 x i8> %a, zeroinitializer
  %c = extractelement <vscale x 2 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_nxv4i1(<vscale x 4 x i8>* %x, i64 %idx) nounwind {
; CHECK-LABEL: extractelt_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a2, zero, e8, mf2, ta, mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmseq.vi v0, v25, 0
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    vsetivli zero, 1, e8, mf2, ta, mu
; CHECK-NEXT:    vslidedown.vx v25, v25, a1
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    ret
  %a = load <vscale x 4 x i8>, <vscale x 4 x i8>* %x
  %b = icmp eq <vscale x 4 x i8> %a, zeroinitializer
  %c = extractelement <vscale x 4 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_nxv8i1(<vscale x 8 x i8>* %x, i64 %idx) nounwind {
; CHECK-LABEL: extractelt_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl1r.v v25, (a0)
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, mu
; CHECK-NEXT:    vmseq.vi v0, v25, 0
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, mu
; CHECK-NEXT:    vslidedown.vx v25, v25, a1
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    ret
  %a = load <vscale x 8 x i8>, <vscale x 8 x i8>* %x
  %b = icmp eq <vscale x 8 x i8> %a, zeroinitializer
  %c = extractelement <vscale x 8 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_nxv16i1(<vscale x 16 x i8>* %x, i64 %idx) nounwind {
; CHECK-LABEL: extractelt_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl2r.v v26, (a0)
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, mu
; CHECK-NEXT:    vmseq.vi v0, v26, 0
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v26, v26, 1, v0
; CHECK-NEXT:    vsetivli zero, 1, e8, m2, ta, mu
; CHECK-NEXT:    vslidedown.vx v26, v26, a1
; CHECK-NEXT:    vmv.x.s a0, v26
; CHECK-NEXT:    ret
  %a = load <vscale x 16 x i8>, <vscale x 16 x i8>* %x
  %b = icmp eq <vscale x 16 x i8> %a, zeroinitializer
  %c = extractelement <vscale x 16 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_nxv32i1(<vscale x 32 x i8>* %x, i64 %idx) nounwind {
; CHECK-LABEL: extractelt_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl4r.v v28, (a0)
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, mu
; CHECK-NEXT:    vmseq.vi v0, v28, 0
; CHECK-NEXT:    vmv.v.i v28, 0
; CHECK-NEXT:    vmerge.vim v28, v28, 1, v0
; CHECK-NEXT:    vsetivli zero, 1, e8, m4, ta, mu
; CHECK-NEXT:    vslidedown.vx v28, v28, a1
; CHECK-NEXT:    vmv.x.s a0, v28
; CHECK-NEXT:    ret
  %a = load <vscale x 32 x i8>, <vscale x 32 x i8>* %x
  %b = icmp eq <vscale x 32 x i8> %a, zeroinitializer
  %c = extractelement <vscale x 32 x i1> %b, i64 %idx
  ret i1 %c
}

define i1 @extractelt_nxv64i1(<vscale x 64 x i8>* %x, i64 %idx) nounwind {
; CHECK-LABEL: extractelt_nxv64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl8r.v v8, (a0)
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, mu
; CHECK-NEXT:    vmseq.vi v0, v8, 0
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vsetivli zero, 1, e8, m8, ta, mu
; CHECK-NEXT:    vslidedown.vx v8, v8, a1
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %a = load <vscale x 64 x i8>, <vscale x 64 x i8>* %x
  %b = icmp eq <vscale x 64 x i8> %a, zeroinitializer
  %c = extractelement <vscale x 64 x i1> %b, i64 %idx
  ret i1 %c
}
