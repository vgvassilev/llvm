; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S -data-layout="e" | FileCheck %s --check-prefixes=ANY,LE
; RUN: opt < %s -instcombine -S -data-layout="E" | FileCheck %s --check-prefixes=ANY,BE

define <4 x i16> @trunc_little_endian(<4 x i32> %x) {
; ANY-LABEL: @trunc_little_endian(
; ANY-NEXT:    [[B:%.*]] = bitcast <4 x i32> [[X:%.*]] to <8 x i16>
; ANY-NEXT:    [[R:%.*]] = shufflevector <8 x i16> [[B]], <8 x i16> undef, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
; ANY-NEXT:    ret <4 x i16> [[R]]
;
  %b = bitcast <4 x i32> %x to <8 x i16>
  %r = shufflevector <8 x i16> %b, <8 x i16> undef, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  ret <4 x i16> %r
}

define <4 x i16> @trunc_big_endian(<4 x i32> %x) {
; ANY-LABEL: @trunc_big_endian(
; ANY-NEXT:    [[B:%.*]] = bitcast <4 x i32> [[X:%.*]] to <8 x i16>
; ANY-NEXT:    [[R:%.*]] = shufflevector <8 x i16> [[B]], <8 x i16> undef, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
; ANY-NEXT:    ret <4 x i16> [[R]]
;
  %b = bitcast <4 x i32> %x to <8 x i16>
  %r = shufflevector <8 x i16> %b, <8 x i16> undef, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  ret <4 x i16> %r
}

declare void @use_v8i16(<8 x i16>)

define <2 x i16> @trunc_little_endian_extra_use(<2 x i64> %x) {
; ANY-LABEL: @trunc_little_endian_extra_use(
; ANY-NEXT:    [[B:%.*]] = bitcast <2 x i64> [[X:%.*]] to <8 x i16>
; ANY-NEXT:    call void @use_v8i16(<8 x i16> [[B]])
; ANY-NEXT:    [[R:%.*]] = shufflevector <8 x i16> [[B]], <8 x i16> undef, <2 x i32> <i32 0, i32 4>
; ANY-NEXT:    ret <2 x i16> [[R]]
;
  %b = bitcast <2 x i64> %x to <8 x i16>
  call void @use_v8i16(<8 x i16> %b)
  %r = shufflevector <8 x i16> %b, <8 x i16> undef, <2 x i32> <i32 0, i32 4>
  ret <2 x i16> %r
}

declare void @use_v12i11(<12 x i11>)

define <4 x i11> @trunc_big_endian_extra_use(<4 x i33> %x) {
; ANY-LABEL: @trunc_big_endian_extra_use(
; ANY-NEXT:    [[B:%.*]] = bitcast <4 x i33> [[X:%.*]] to <12 x i11>
; ANY-NEXT:    call void @use_v12i11(<12 x i11> [[B]])
; ANY-NEXT:    [[R:%.*]] = shufflevector <12 x i11> [[B]], <12 x i11> undef, <4 x i32> <i32 2, i32 5, i32 8, i32 11>
; ANY-NEXT:    ret <4 x i11> [[R]]
;
  %b = bitcast <4 x i33> %x to <12 x i11>
  call void @use_v12i11(<12 x i11> %b)
  %r = shufflevector <12 x i11> %b, <12 x i11> undef, <4 x i32> <i32 2, i32 5, i32 8, i32 11>
  ret <4 x i11> %r
}

