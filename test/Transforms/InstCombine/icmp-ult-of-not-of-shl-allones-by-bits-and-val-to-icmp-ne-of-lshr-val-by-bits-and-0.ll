; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; https://bugs.llvm.org/show_bug.cgi?id=38708

; Pattern:
;   ~(-1 << bits) u< val
; Should be transformed into:
;   (val l>> bits) != 0

; ============================================================================ ;
; Basic positive tests
; ============================================================================ ;

define i1 @p0(i8 %val, i8 %bits) {
; CHECK-LABEL: @p0(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 -1, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor i8 [[T0]], -1
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 -1, %bits
  %t1 = xor i8 %t0, -1
  %r = icmp ult i8 %t1, %val
  ret i1 %r
}

; ============================================================================ ;
; Vector tests
; ============================================================================ ;

define <2 x i1> @p1_vec(<2 x i8> %val, <2 x i8> %bits) {
; CHECK-LABEL: @p1_vec(
; CHECK-NEXT:    [[T0:%.*]] = shl <2 x i8> <i8 -1, i8 -1>, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor <2 x i8> [[T0]], <i8 -1, i8 -1>
; CHECK-NEXT:    [[R:%.*]] = icmp ult <2 x i8> [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %t0 = shl <2 x i8> <i8 -1, i8 -1>, %bits
  %t1 = xor <2 x i8> %t0, <i8 -1, i8 -1>
  %r = icmp ult <2 x i8> %t1, %val
  ret <2 x i1> %r
}

define <3 x i1> @p2_vec_undef0(<3 x i8> %val, <3 x i8> %bits) {
; CHECK-LABEL: @p2_vec_undef0(
; CHECK-NEXT:    [[T0:%.*]] = shl <3 x i8> <i8 -1, i8 undef, i8 -1>, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor <3 x i8> [[T0]], <i8 -1, i8 -1, i8 -1>
; CHECK-NEXT:    [[R:%.*]] = icmp ult <3 x i8> [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret <3 x i1> [[R]]
;
  %t0 = shl <3 x i8> <i8 -1, i8 undef, i8 -1>, %bits
  %t1 = xor <3 x i8> %t0, <i8 -1, i8 -1, i8 -1>
  %r = icmp ult <3 x i8> %t1, %val
  ret <3 x i1> %r
}

define <3 x i1> @p2_vec_undef1(<3 x i8> %val, <3 x i8> %bits) {
; CHECK-LABEL: @p2_vec_undef1(
; CHECK-NEXT:    [[T0:%.*]] = shl <3 x i8> <i8 -1, i8 -1, i8 -1>, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor <3 x i8> [[T0]], <i8 -1, i8 undef, i8 -1>
; CHECK-NEXT:    [[R:%.*]] = icmp ult <3 x i8> [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret <3 x i1> [[R]]
;
  %t0 = shl <3 x i8> <i8 -1, i8 -1, i8 -1>, %bits
  %t1 = xor <3 x i8> %t0, <i8 -1, i8 undef, i8 -1>
  %r = icmp ult <3 x i8> %t1, %val
  ret <3 x i1> %r
}

define <3 x i1> @p2_vec_undef2(<3 x i8> %val, <3 x i8> %bits) {
; CHECK-LABEL: @p2_vec_undef2(
; CHECK-NEXT:    [[T0:%.*]] = shl <3 x i8> <i8 -1, i8 undef, i8 -1>, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor <3 x i8> [[T0]], <i8 -1, i8 undef, i8 -1>
; CHECK-NEXT:    [[R:%.*]] = icmp ult <3 x i8> [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret <3 x i1> [[R]]
;
  %t0 = shl <3 x i8> <i8 -1, i8 undef, i8 -1>, %bits
  %t1 = xor <3 x i8> %t0, <i8 -1, i8 undef, i8 -1>
  %r = icmp ult <3 x i8> %t1, %val
  ret <3 x i1> %r
}

; ============================================================================ ;
; Commutativity tests.
; ============================================================================ ;

declare i8 @gen8()

define i1 @c0(i8 %bits) {
; CHECK-LABEL: @c0(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 -1, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor i8 [[T0]], -1
; CHECK-NEXT:    [[VAL:%.*]] = call i8 @gen8()
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[VAL]], [[T1]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 -1, %bits
  %t1 = xor i8 %t0, -1
  %val = call i8 @gen8()
  %r = icmp ugt i8 %val, %t1 ; swapped order and predicate
  ret i1 %r
}

; ============================================================================ ;
; One-use tests.
; ============================================================================ ;

declare void @use8(i8)

define i1 @oneuse0(i8 %val, i8 %bits) {
; CHECK-LABEL: @oneuse0(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 -1, [[BITS:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = xor i8 [[T0]], -1
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 -1, %bits
  call void @use8(i8 %t0)
  %t1 = xor i8 %t0, -1
  %r = icmp ult i8 %t1, %val
  ret i1 %r
}

define i1 @oneuse1(i8 %val, i8 %bits) {
; CHECK-LABEL: @oneuse1(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 -1, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor i8 [[T0]], -1
; CHECK-NEXT:    call void @use8(i8 [[T1]])
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 -1, %bits
  %t1 = xor i8 %t0, -1
  call void @use8(i8 %t1)
  %r = icmp ult i8 %t1, %val
  ret i1 %r
}

define i1 @oneuse2(i8 %val, i8 %bits) {
; CHECK-LABEL: @oneuse2(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 -1, [[BITS:%.*]]
; CHECK-NEXT:    call void @use8(i8 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = xor i8 [[T0]], -1
; CHECK-NEXT:    call void @use8(i8 [[T1]])
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 -1, %bits
  call void @use8(i8 %t0)
  %t1 = xor i8 %t0, -1
  call void @use8(i8 %t1)
  %r = icmp ult i8 %t1, %val
  ret i1 %r
}

; ============================================================================ ;
; Negative tests
; ============================================================================ ;

define i1 @n0(i8 %val, i8 %bits) {
; CHECK-LABEL: @n0(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 1, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor i8 [[T0]], -1
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 1, %bits ; constant is not -1
  %t1 = xor i8 %t0, -1
  %r = icmp ult i8 %t1, %val
  ret i1 %r
}

define i1 @n1(i8 %val, i8 %bits) {
; CHECK-LABEL: @n1(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 -1, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor i8 [[T0]], 1
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 -1, %bits
  %t1 = xor i8 %t0, 1 ; not 'not'
  %r = icmp ult i8 %t1, %val
  ret i1 %r
}

define <2 x i1> @n2_vec_nonsplat(<2 x i8> %val, <2 x i8> %bits) {
; CHECK-LABEL: @n2_vec_nonsplat(
; CHECK-NEXT:    [[T0:%.*]] = shl <2 x i8> <i8 -1, i8 1>, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor <2 x i8> [[T0]], <i8 -1, i8 -1>
; CHECK-NEXT:    [[R:%.*]] = icmp ult <2 x i8> [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %t0 = shl <2 x i8> <i8 -1, i8 1>, %bits ; again, wrong constant
  %t1 = xor <2 x i8> %t0, <i8 -1, i8 -1>
  %r = icmp ult <2 x i8> %t1, %val
  ret <2 x i1> %r
}

define <2 x i1> @n3_vec_nonsplat(<2 x i8> %val, <2 x i8> %bits) {
; CHECK-LABEL: @n3_vec_nonsplat(
; CHECK-NEXT:    [[T0:%.*]] = shl <2 x i8> <i8 -1, i8 -1>, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor <2 x i8> [[T0]], <i8 -1, i8 1>
; CHECK-NEXT:    [[R:%.*]] = icmp ult <2 x i8> [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %t0 = shl <2 x i8> <i8 -1, i8 -1>, %bits
  %t1 = xor <2 x i8> %t0, <i8 -1, i8 1> ; again, wrong constant
  %r = icmp ult <2 x i8> %t1, %val
  ret <2 x i1> %r
}

define i1 @n3(i8 %val, i8 %bits) {
; CHECK-LABEL: @n3(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 -1, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor i8 [[T0]], -1
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[T1]], [[VAL:%.*]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 -1, %bits
  %t1 = xor i8 %t0, -1
  %r = icmp ule i8 %t1, %val ; wrong predicate
  ret i1 %r
}

define i1 @n4(i8 %bits) {
; CHECK-LABEL: @n4(
; CHECK-NEXT:    [[T0:%.*]] = shl i8 -1, [[BITS:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = xor i8 [[T0]], -1
; CHECK-NEXT:    [[VAL:%.*]] = call i8 @gen8()
; CHECK-NEXT:    [[R:%.*]] = icmp uge i8 [[VAL]], [[T1]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %t0 = shl i8 -1, %bits
  %t1 = xor i8 %t0, -1
  %val = call i8 @gen8()
  %r = icmp uge i8 %val, %t1 ; swapped order and [wrong] predicate
  ret i1 %r
}
