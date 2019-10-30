; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

define <vscale x 16 x i8> @add_i8(<vscale x 16 x i1> %pg, <vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: add_i8:
; CHECK: add z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <vscale x 16 x i8> @llvm.aarch64.sve.add.nxv16i8(<vscale x 16 x i1> %pg,
                                                               <vscale x 16 x i8> %a,
                                                               <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %out
}

define <vscale x 8 x i16> @add_i16(<vscale x 8 x i1> %pg, <vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: add_i16:
; CHECK: add z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.add.nxv8i16(<vscale x 8 x i1> %pg,
                                                               <vscale x 8 x i16> %a,
                                                               <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %out
}

define <vscale x 4 x i32> @add_i32(<vscale x 4 x i1> %pg, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: add_i32:
; CHECK: add z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.add.nxv4i32(<vscale x 4 x i1> %pg,
                                                               <vscale x 4 x i32> %a,
                                                               <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %out
}

define <vscale x 2 x i64> @add_i64(<vscale x 2 x i1> %pg, <vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: add_i64:
; CHECK: add z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.add.nxv2i64(<vscale x 2 x i1> %pg,
                                                               <vscale x 2 x i64> %a,
                                                               <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %out
}




define <vscale x 16 x i8> @sub_i8(<vscale x 16 x i1> %pg, <vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: sub_i8:
; CHECK: sub z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <vscale x 16 x i8> @llvm.aarch64.sve.sub.nxv16i8(<vscale x 16 x i1> %pg,
                                                               <vscale x 16 x i8> %a,
                                                               <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %out
}

define <vscale x 8 x i16> @sub_i16(<vscale x 8 x i1> %pg, <vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: sub_i16:
; CHECK: sub z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.sub.nxv8i16(<vscale x 8 x i1> %pg,
                                                               <vscale x 8 x i16> %a,
                                                               <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %out
}

define <vscale x 4 x i32> @sub_i32(<vscale x 4 x i1> %pg, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: sub_i32:
; CHECK: sub z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.sub.nxv4i32(<vscale x 4 x i1> %pg,
                                                               <vscale x 4 x i32> %a,
                                                               <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %out
}

define <vscale x 2 x i64> @sub_i64(<vscale x 2 x i1> %pg, <vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: sub_i64:
; CHECK: sub z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.sub.nxv2i64(<vscale x 2 x i1> %pg,
                                                               <vscale x 2 x i64> %a,
                                                               <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %out
}



define <vscale x 16 x i8> @subr_i8(<vscale x 16 x i1> %pg, <vscale x 16 x i8> %a, <vscale x 16 x i8> %b) {
; CHECK-LABEL: subr_i8:
; CHECK: subr z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %out = call <vscale x 16 x i8> @llvm.aarch64.sve.subr.nxv16i8(<vscale x 16 x i1> %pg,
                                                               <vscale x 16 x i8> %a,
                                                               <vscale x 16 x i8> %b)
  ret <vscale x 16 x i8> %out
}

define <vscale x 8 x i16> @subr_i16(<vscale x 8 x i1> %pg, <vscale x 8 x i16> %a, <vscale x 8 x i16> %b) {
; CHECK-LABEL: subr_i16:
; CHECK: subr z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %out = call <vscale x 8 x i16> @llvm.aarch64.sve.subr.nxv8i16(<vscale x 8 x i1> %pg,
                                                               <vscale x 8 x i16> %a,
                                                               <vscale x 8 x i16> %b)
  ret <vscale x 8 x i16> %out
}

define <vscale x 4 x i32> @subr_i32(<vscale x 4 x i1> %pg, <vscale x 4 x i32> %a, <vscale x 4 x i32> %b) {
; CHECK-LABEL: subr_i32:
; CHECK: subr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %out = call <vscale x 4 x i32> @llvm.aarch64.sve.subr.nxv4i32(<vscale x 4 x i1> %pg,
                                                               <vscale x 4 x i32> %a,
                                                               <vscale x 4 x i32> %b)
  ret <vscale x 4 x i32> %out
}

define <vscale x 2 x i64> @subr_i64(<vscale x 2 x i1> %pg, <vscale x 2 x i64> %a, <vscale x 2 x i64> %b) {
; CHECK-LABEL: subr_i64:
; CHECK: subr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %out = call <vscale x 2 x i64> @llvm.aarch64.sve.subr.nxv2i64(<vscale x 2 x i1> %pg,
                                                               <vscale x 2 x i64> %a,
                                                               <vscale x 2 x i64> %b)
  ret <vscale x 2 x i64> %out
}



declare <vscale x 16 x  i8> @llvm.aarch64.sve.add.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x  i8>, <vscale x 16 x  i8>)
declare <vscale x  8 x i16> @llvm.aarch64.sve.add.nxv8i16(<vscale x  8 x i1>, <vscale x  8 x i16>, <vscale x  8 x i16>)
declare <vscale x  4 x i32> @llvm.aarch64.sve.add.nxv4i32(<vscale x  4 x i1>, <vscale x  4 x i32>, <vscale x  4 x i32>)
declare <vscale x  2 x i64> @llvm.aarch64.sve.add.nxv2i64(<vscale x  2 x i1>, <vscale x  2 x i64>, <vscale x  2 x i64>)

declare <vscale x 16 x  i8> @llvm.aarch64.sve.sub.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x  i8>, <vscale x 16 x  i8>)
declare <vscale x  8 x i16> @llvm.aarch64.sve.sub.nxv8i16(<vscale x  8 x i1>, <vscale x  8 x i16>, <vscale x  8 x i16>)
declare <vscale x  4 x i32> @llvm.aarch64.sve.sub.nxv4i32(<vscale x  4 x i1>, <vscale x  4 x i32>, <vscale x  4 x i32>)
declare <vscale x  2 x i64> @llvm.aarch64.sve.sub.nxv2i64(<vscale x  2 x i1>, <vscale x  2 x i64>, <vscale x  2 x i64>)

declare <vscale x 16 x  i8> @llvm.aarch64.sve.subr.nxv16i8(<vscale x 16 x i1>, <vscale x 16 x  i8>, <vscale x 16 x  i8>)
declare <vscale x  8 x i16> @llvm.aarch64.sve.subr.nxv8i16(<vscale x  8 x i1>, <vscale x  8 x i16>, <vscale x  8 x i16>)
declare <vscale x  4 x i32> @llvm.aarch64.sve.subr.nxv4i32(<vscale x  4 x i1>, <vscale x  4 x i32>, <vscale x  4 x i32>)
declare <vscale x  2 x i64> @llvm.aarch64.sve.subr.nxv2i64(<vscale x  2 x i1>, <vscale x  2 x i64>, <vscale x  2 x i64>)
