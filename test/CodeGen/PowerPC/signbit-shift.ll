; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=powerpc64le-- | FileCheck %s

; If positive...

define i32 @zext_ifpos(i32 %x) {
; CHECK-LABEL: zext_ifpos:
; CHECK:       # %bb.0:
; CHECK-NEXT:    nor 3, 3, 3
; CHECK-NEXT:    srwi 3, 3, 31
; CHECK-NEXT:    blr
  %c = icmp sgt i32 %x, -1
  %e = zext i1 %c to i32
  ret i32 %e
}

define i32 @add_zext_ifpos(i32 %x) {
; CHECK-LABEL: add_zext_ifpos:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srawi 3, 3, 31
; CHECK-NEXT:    addi 3, 3, 42
; CHECK-NEXT:    blr
  %c = icmp sgt i32 %x, -1
  %e = zext i1 %c to i32
  %r = add i32 %e, 41
  ret i32 %r
}

define <4 x i32> @add_zext_ifpos_vec_splat(<4 x i32> %x) {
; CHECK-LABEL: add_zext_ifpos_vec_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vspltisb 3, -1
; CHECK-NEXT:    addis 3, 2, .LCPI2_0@toc@ha
; CHECK-NEXT:    addi 3, 3, .LCPI2_0@toc@l
; CHECK-NEXT:    vcmpgtsw 2, 2, 3
; CHECK-NEXT:    lvx 3, 0, 3
; CHECK-NEXT:    vsubuwm 2, 3, 2
; CHECK-NEXT:    blr
  %c = icmp sgt <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  %e = zext <4 x i1> %c to <4 x i32>
  %r = add <4 x i32> %e, <i32 41, i32 41, i32 41, i32 41>
  ret <4 x i32> %r
}

define i32 @sel_ifpos_tval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifpos_tval_bigger:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li 4, 41
; CHECK-NEXT:    cmpwi 0, 3, -1
; CHECK-NEXT:    li 3, 42
; CHECK-NEXT:    isel 3, 3, 4, 1
; CHECK-NEXT:    blr
  %c = icmp sgt i32 %x, -1
  %r = select i1 %c, i32 42, i32 41
  ret i32 %r
}

define i32 @sext_ifpos(i32 %x) {
; CHECK-LABEL: sext_ifpos:
; CHECK:       # %bb.0:
; CHECK-NEXT:    nor 3, 3, 3
; CHECK-NEXT:    srawi 3, 3, 31
; CHECK-NEXT:    blr
  %c = icmp sgt i32 %x, -1
  %e = sext i1 %c to i32
  ret i32 %e
}

define i32 @add_sext_ifpos(i32 %x) {
; CHECK-LABEL: add_sext_ifpos:
; CHECK:       # %bb.0:
; CHECK-NEXT:    nor 3, 3, 3
; CHECK-NEXT:    srawi 3, 3, 31
; CHECK-NEXT:    addi 3, 3, 42
; CHECK-NEXT:    blr
  %c = icmp sgt i32 %x, -1
  %e = sext i1 %c to i32
  %r = add i32 %e, 42
  ret i32 %r
}

define <4 x i32> @add_sext_ifpos_vec_splat(<4 x i32> %x) {
; CHECK-LABEL: add_sext_ifpos_vec_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vspltisb 3, -1
; CHECK-NEXT:    addis 3, 2, .LCPI6_0@toc@ha
; CHECK-NEXT:    addi 3, 3, .LCPI6_0@toc@l
; CHECK-NEXT:    vcmpgtsw 2, 2, 3
; CHECK-NEXT:    lvx 3, 0, 3
; CHECK-NEXT:    vadduwm 2, 2, 3
; CHECK-NEXT:    blr
  %c = icmp sgt <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  %e = sext <4 x i1> %c to <4 x i32>
  %r = add <4 x i32> %e, <i32 42, i32 42, i32 42, i32 42>
  ret <4 x i32> %r
}

define i32 @sel_ifpos_fval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifpos_fval_bigger:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li 4, 42
; CHECK-NEXT:    cmpwi 0, 3, -1
; CHECK-NEXT:    li 3, 41
; CHECK-NEXT:    isel 3, 3, 4, 1
; CHECK-NEXT:    blr
  %c = icmp sgt i32 %x, -1
  %r = select i1 %c, i32 41, i32 42
  ret i32 %r
}

; If negative...

define i32 @zext_ifneg(i32 %x) {
; CHECK-LABEL: zext_ifneg:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srwi 3, 3, 31
; CHECK-NEXT:    blr
  %c = icmp slt i32 %x, 0
  %r = zext i1 %c to i32
  ret i32 %r
}

define i32 @add_zext_ifneg(i32 %x) {
; CHECK-LABEL: add_zext_ifneg:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srwi 3, 3, 31
; CHECK-NEXT:    addi 3, 3, 41
; CHECK-NEXT:    blr
  %c = icmp slt i32 %x, 0
  %e = zext i1 %c to i32
  %r = add i32 %e, 41
  ret i32 %r
}

define i32 @sel_ifneg_tval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifneg_tval_bigger:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li 4, 41
; CHECK-NEXT:    cmpwi 0, 3, 0
; CHECK-NEXT:    li 3, 42
; CHECK-NEXT:    isel 3, 3, 4, 0
; CHECK-NEXT:    blr
  %c = icmp slt i32 %x, 0
  %r = select i1 %c, i32 42, i32 41
  ret i32 %r
}

define i32 @sext_ifneg(i32 %x) {
; CHECK-LABEL: sext_ifneg:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srawi 3, 3, 31
; CHECK-NEXT:    blr
  %c = icmp slt i32 %x, 0
  %r = sext i1 %c to i32
  ret i32 %r
}

define i32 @add_sext_ifneg(i32 %x) {
; CHECK-LABEL: add_sext_ifneg:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srawi 3, 3, 31
; CHECK-NEXT:    addi 3, 3, 42
; CHECK-NEXT:    blr
  %c = icmp slt i32 %x, 0
  %e = sext i1 %c to i32
  %r = add i32 %e, 42
  ret i32 %r
}

define i32 @sel_ifneg_fval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifneg_fval_bigger:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li 4, 42
; CHECK-NEXT:    cmpwi 0, 3, 0
; CHECK-NEXT:    li 3, 41
; CHECK-NEXT:    isel 3, 3, 4, 0
; CHECK-NEXT:    blr
  %c = icmp slt i32 %x, 0
  %r = select i1 %c, i32 41, i32 42
  ret i32 %r
}

define i32 @add_lshr_not(i32 %x) {
; CHECK-LABEL: add_lshr_not:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srawi 3, 3, 31
; CHECK-NEXT:    addi 3, 3, 42
; CHECK-NEXT:    blr
  %not = xor i32 %x, -1
  %sh = lshr i32 %not, 31
  %r = add i32 %sh, 41
  ret i32 %r
}

define <4 x i32> @add_lshr_not_vec_splat(<4 x i32> %x) {
; CHECK-LABEL: add_lshr_not_vec_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vspltisw 3, -16
; CHECK-NEXT:    vspltisw 4, 15
; CHECK-NEXT:    addis 3, 2, .LCPI15_0@toc@ha
; CHECK-NEXT:    addi 3, 3, .LCPI15_0@toc@l
; CHECK-NEXT:    vsubuwm 3, 4, 3
; CHECK-NEXT:    vsraw 2, 2, 3
; CHECK-NEXT:    lvx 3, 0, 3
; CHECK-NEXT:    vadduwm 2, 2, 3
; CHECK-NEXT:    blr
  %c = xor <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  %e = lshr <4 x i32> %c, <i32 31, i32 31, i32 31, i32 31>
  %r = add <4 x i32> %e, <i32 42, i32 42, i32 42, i32 42>
  ret <4 x i32> %r
}

define i32 @sub_lshr_not(i32 %x) {
; CHECK-LABEL: sub_lshr_not:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srwi 3, 3, 31
; CHECK-NEXT:    ori 3, 3, 42
; CHECK-NEXT:    blr
  %not = xor i32 %x, -1
  %sh = lshr i32 %not, 31
  %r = sub i32 43, %sh
  ret i32 %r
}

define <4 x i32> @sub_lshr_not_vec_splat(<4 x i32> %x) {
; CHECK-LABEL: sub_lshr_not_vec_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vspltisw 3, -16
; CHECK-NEXT:    vspltisw 4, 15
; CHECK-NEXT:    addis 3, 2, .LCPI17_0@toc@ha
; CHECK-NEXT:    addi 3, 3, .LCPI17_0@toc@l
; CHECK-NEXT:    vsubuwm 3, 4, 3
; CHECK-NEXT:    vsrw 2, 2, 3
; CHECK-NEXT:    lvx 3, 0, 3
; CHECK-NEXT:    vadduwm 2, 2, 3
; CHECK-NEXT:    blr
  %c = xor <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  %e = lshr <4 x i32> %c, <i32 31, i32 31, i32 31, i32 31>
  %r = sub <4 x i32> <i32 42, i32 42, i32 42, i32 42>, %e
  ret <4 x i32> %r
}

define i32 @sub_lshr(i32 %x) {
; CHECK-LABEL: sub_lshr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    srwi 3, 3, 31
; CHECK-NEXT:    subfic 3, 3, 43
; CHECK-NEXT:    blr
  %sh = lshr i32 %x, 31
  %r = sub i32 43, %sh
  ret i32 %r
}

define <4 x i32> @sub_lshr_vec_splat(<4 x i32> %x) {
; CHECK-LABEL: sub_lshr_vec_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vspltisw 3, -16
; CHECK-NEXT:    vspltisw 4, 15
; CHECK-NEXT:    addis 3, 2, .LCPI19_0@toc@ha
; CHECK-NEXT:    addi 3, 3, .LCPI19_0@toc@l
; CHECK-NEXT:    vsubuwm 3, 4, 3
; CHECK-NEXT:    vsrw 2, 2, 3
; CHECK-NEXT:    lvx 3, 0, 3
; CHECK-NEXT:    vsubuwm 2, 3, 2
; CHECK-NEXT:    blr
  %e = lshr <4 x i32> %x, <i32 31, i32 31, i32 31, i32 31>
  %r = sub <4 x i32> <i32 42, i32 42, i32 42, i32 42>, %e
  ret <4 x i32> %r
}

