; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -instcombine | FileCheck %s

declare i32 @llvm.ctpop.i32(i32)
declare i64 @llvm.ctpop.i64(i64)
declare i8 @llvm.ctpop.i8(i8)
declare i7 @llvm.ctpop.i7(i7)
declare i1 @llvm.ctpop.i1(i1)
declare <2 x i32> @llvm.ctpop.v2i32(<2 x i32>)
declare void @llvm.assume(i1)
declare void @use(i32)

define i1 @test1(i32 %arg) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    ret i1 false
;
  %and = and i32 %arg, 15
  %cnt = call i32 @llvm.ctpop.i32(i32 %and)
  %res = icmp eq i32 %cnt, 9
  ret i1 %res
}

define i1 @test2(i32 %arg) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    ret i1 false
;
  %and = and i32 %arg, 1
  %cnt = call i32 @llvm.ctpop.i32(i32 %and)
  %res = icmp eq i32 %cnt, 2
  ret i1 %res
}

define i1 @test3(i32 %arg) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[ASSUME:%.*]] = icmp eq i32 [[ARG:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[ASSUME]])
; CHECK-NEXT:    ret i1 false
;
  ;; Use an assume to make all the bits known without triggering constant
  ;; folding.  This is trying to hit a corner case where we have to avoid
  ;; taking the log of 0.
  %assume = icmp eq i32 %arg, 0
  call void @llvm.assume(i1 %assume)
  %cnt = call i32 @llvm.ctpop.i32(i32 %arg)
  %res = icmp eq i32 %cnt, 2
  ret i1 %res
}

; Negative test for when we know nothing
define i1 @test4(i8 %arg) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[CNT:%.*]] = call i8 @llvm.ctpop.i8(i8 [[ARG:%.*]]), !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    [[RES:%.*]] = icmp eq i8 [[CNT]], 2
; CHECK-NEXT:    ret i1 [[RES]]
;
  %cnt = call i8 @llvm.ctpop.i8(i8 %arg)
  %res = icmp eq i8 %cnt, 2
  ret i1 %res
}

; Test when the number of possible known bits isn't one less than a power of 2
; and the compare value is greater but less than the next power of 2.
define i1 @test5(i32 %arg) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    ret i1 false
;
  %and = and i32 %arg, 3
  %cnt = call i32 @llvm.ctpop.i32(i32 %and)
  %res = icmp eq i32 %cnt, 3
  ret i1 %res
}

; Test when the number of possible known bits isn't one less than a power of 2
; and the compare value is greater but less than the next power of 2.
; TODO: The icmp is unnecessary given the known bits of the input, but range
; metadata doesn't support vectors
define <2 x i1> @test5vec(<2 x i32> %arg) {
; CHECK-LABEL: @test5vec(
; CHECK-NEXT:    [[AND:%.*]] = and <2 x i32> [[ARG:%.*]], <i32 3, i32 3>
; CHECK-NEXT:    [[CNT:%.*]] = call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[AND]])
; CHECK-NEXT:    [[RES:%.*]] = icmp eq <2 x i32> [[CNT]], <i32 3, i32 3>
; CHECK-NEXT:    ret <2 x i1> [[RES]]
;
  %and = and <2 x i32> %arg, <i32 3, i32 3>
  %cnt = call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %and)
  %res = icmp eq <2 x i32> %cnt, <i32 3, i32 3>
  ret <2 x i1> %res
}

; No intrinsic or range needed - ctpop of bool bit is the bit itself.

define i1 @test6(i1 %arg) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    ret i1 [[ARG:%.*]]
;
  %cnt = call i1 @llvm.ctpop.i1(i1 %arg)
  ret i1 %cnt
}

define i8 @mask_one_bit(i8 %x) {
; CHECK-LABEL: @mask_one_bit(
; CHECK-NEXT:    [[A:%.*]] = lshr i8 [[X:%.*]], 4
; CHECK-NEXT:    [[R:%.*]] = and i8 [[A]], 1
; CHECK-NEXT:    ret i8 [[R]]
;
  %a = and i8 %x, 16
  %r = call i8 @llvm.ctpop.i8(i8 %a)
  ret i8 %r
}

define <2 x i32> @mask_one_bit_splat(<2 x i32> %x, <2 x i32>* %p) {
; CHECK-LABEL: @mask_one_bit_splat(
; CHECK-NEXT:    [[A:%.*]] = and <2 x i32> [[X:%.*]], <i32 2048, i32 2048>
; CHECK-NEXT:    store <2 x i32> [[A]], <2 x i32>* [[P:%.*]], align 8
; CHECK-NEXT:    [[R:%.*]] = lshr exact <2 x i32> [[A]], <i32 11, i32 11>
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %a = and <2 x i32> %x, <i32 2048, i32 2048>
  store <2 x i32> %a, <2 x i32>* %p
  %r = call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %a)
  ret <2 x i32> %r
}

define i32 @_parity_of_not(i32 %x) {
; CHECK-LABEL: @_parity_of_not(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.ctpop.i32(i32 [[X:%.*]]), !range [[RNG1:![0-9]+]]
; CHECK-NEXT:    [[R:%.*]] = and i32 [[TMP1]], 1
; CHECK-NEXT:    ret i32 [[R]]
;
  %neg = xor i32 %x, -1
  %cnt = tail call i32 @llvm.ctpop.i32(i32 %neg)
  %r = and i32 %cnt, 1
  ret i32 %r
}

; Negative test - need even # of bits in type.

define i7 @_parity_of_not_odd_type(i7 %x) {
; CHECK-LABEL: @_parity_of_not_odd_type(
; CHECK-NEXT:    [[NEG:%.*]] = xor i7 [[X:%.*]], -1
; CHECK-NEXT:    [[CNT:%.*]] = tail call i7 @llvm.ctpop.i7(i7 [[NEG]]), !range [[RNG2:![0-9]+]]
; CHECK-NEXT:    [[R:%.*]] = and i7 [[CNT]], 1
; CHECK-NEXT:    ret i7 [[R]]
;
  %neg = xor i7 %x, -1
  %cnt = tail call i7 @llvm.ctpop.i7(i7 %neg)
  %r = and i7 %cnt, 1
  ret i7 %r
}

define <2 x i32> @_parity_of_not_vec(<2 x i32> %x) {
; CHECK-LABEL: @_parity_of_not_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[X:%.*]])
; CHECK-NEXT:    [[R:%.*]] = and <2 x i32> [[TMP1]], <i32 1, i32 1>
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %neg = xor <2 x i32> %x, <i32 -1 ,i32 -1>
  %cnt = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %neg)
  %r = and <2 x i32> %cnt, <i32 1 ,i32 1>
  ret <2 x i32> %r
}

define <2 x i32> @_parity_of_not_undef(<2 x i32> %x) {
; CHECK-LABEL: @_parity_of_not_undef(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[X:%.*]])
; CHECK-NEXT:    [[R:%.*]] = and <2 x i32> [[TMP1]], <i32 1, i32 1>
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %neg = xor <2 x i32> %x, <i32 undef ,i32 -1>
  %cnt = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %neg)
  %r = and <2 x i32> %cnt, <i32 1 ,i32 1>
  ret <2 x i32> %r
}

define <2 x i32> @_parity_of_not_undef2(<2 x i32> %x) {
; CHECK-LABEL: @_parity_of_not_undef2(
; CHECK-NEXT:    [[NEG:%.*]] = xor <2 x i32> [[X:%.*]], <i32 -1, i32 -1>
; CHECK-NEXT:    [[CNT:%.*]] = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[NEG]])
; CHECK-NEXT:    [[R:%.*]] = and <2 x i32> [[CNT]], <i32 1, i32 undef>
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %neg = xor <2 x i32> %x, <i32 -1 ,i32 -1>
  %cnt = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %neg)
  %r = and <2 x i32> %cnt, <i32 1 ,i32 undef>
  ret <2 x i32> %r
}

; PR48999
define i32 @ctpop_add(i32 %a, i32 %b) {
; CHECK-LABEL: @ctpop_add(
; CHECK-NEXT:    [[AND8:%.*]] = lshr i32 [[A:%.*]], 3
; CHECK-NEXT:    [[CTPOP1:%.*]] = and i32 [[AND8]], 1
; CHECK-NEXT:    [[AND2:%.*]] = lshr i32 [[B:%.*]], 1
; CHECK-NEXT:    [[CTPOP2:%.*]] = and i32 [[AND2]], 1
; CHECK-NEXT:    [[RES:%.*]] = add nuw nsw i32 [[CTPOP1]], [[CTPOP2]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %and8 = and i32 %a, 8
  %ctpop1 = tail call i32 @llvm.ctpop.i32(i32 %and8)
  %and2 = and i32 %b, 2
  %ctpop2 = tail call i32 @llvm.ctpop.i32(i32 %and2)
  %res = add i32 %ctpop1, %ctpop2
  ret i32 %res
}

define i32 @ctpop_add_no_common_bits(i32 %a, i32 %b) {
; CHECK-LABEL: @ctpop_add_no_common_bits(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.fshl.i32(i32 [[A:%.*]], i32 [[B:%.*]], i32 16)
; CHECK-NEXT:    [[TMP2:%.*]] = call i32 @llvm.ctpop.i32(i32 [[TMP1]]), !range [[RNG1]]
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %shl16 = shl i32 %a, 16
  %ctpop1 = tail call i32 @llvm.ctpop.i32(i32 %shl16)
  %lshl16 = lshr i32 %b, 16
  %ctpop2 = tail call i32 @llvm.ctpop.i32(i32 %lshl16)
  %res = add i32 %ctpop1, %ctpop2
  ret i32 %res
}

define <2 x i32> @ctpop_add_no_common_bits_vec(<2 x i32> %a, <2 x i32> %b) {
; CHECK-LABEL: @ctpop_add_no_common_bits_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i32> @llvm.fshl.v2i32(<2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]], <2 x i32> <i32 16, i32 16>)
; CHECK-NEXT:    [[TMP2:%.*]] = call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[TMP1]])
; CHECK-NEXT:    ret <2 x i32> [[TMP2]]
;
  %shl16 = shl <2 x i32> %a, <i32 16, i32 16>
  %ctpop1 = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %shl16)
  %lshl16 = lshr <2 x i32> %b, <i32 16, i32 16>
  %ctpop2 = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %lshl16)
  %res = add <2 x i32> %ctpop1, %ctpop2
  ret <2 x i32> %res
}

define <2 x i32> @ctpop_add_no_common_bits_vec_use(<2 x i32> %a, <2 x i32> %b, <2 x i32>* %p) {
; CHECK-LABEL: @ctpop_add_no_common_bits_vec_use(
; CHECK-NEXT:    [[SHL16:%.*]] = shl <2 x i32> [[A:%.*]], <i32 16, i32 16>
; CHECK-NEXT:    [[CTPOP1:%.*]] = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[SHL16]])
; CHECK-NEXT:    [[LSHL16:%.*]] = lshr <2 x i32> [[B:%.*]], <i32 16, i32 16>
; CHECK-NEXT:    [[CTPOP2:%.*]] = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[LSHL16]])
; CHECK-NEXT:    store <2 x i32> [[CTPOP2]], <2 x i32>* [[P:%.*]], align 8
; CHECK-NEXT:    [[RES:%.*]] = add nuw nsw <2 x i32> [[CTPOP1]], [[CTPOP2]]
; CHECK-NEXT:    ret <2 x i32> [[RES]]
;
  %shl16 = shl <2 x i32> %a, <i32 16, i32 16>
  %ctpop1 = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %shl16)
  %lshl16 = lshr <2 x i32> %b, <i32 16, i32 16>
  %ctpop2 = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %lshl16)
  store <2 x i32> %ctpop2, <2 x i32>* %p
  %res = add <2 x i32> %ctpop1, %ctpop2
  ret <2 x i32> %res
}

define <2 x i32> @ctpop_add_no_common_bits_vec_use2(<2 x i32> %a, <2 x i32> %b, <2 x i32>* %p) {
; CHECK-LABEL: @ctpop_add_no_common_bits_vec_use2(
; CHECK-NEXT:    [[SHL16:%.*]] = shl <2 x i32> [[A:%.*]], <i32 16, i32 16>
; CHECK-NEXT:    [[CTPOP1:%.*]] = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[SHL16]])
; CHECK-NEXT:    store <2 x i32> [[CTPOP1]], <2 x i32>* [[P:%.*]], align 8
; CHECK-NEXT:    [[LSHL16:%.*]] = lshr <2 x i32> [[B:%.*]], <i32 16, i32 16>
; CHECK-NEXT:    [[CTPOP2:%.*]] = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[LSHL16]])
; CHECK-NEXT:    [[RES:%.*]] = add nuw nsw <2 x i32> [[CTPOP1]], [[CTPOP2]]
; CHECK-NEXT:    ret <2 x i32> [[RES]]
;
  %shl16 = shl <2 x i32> %a, <i32 16, i32 16>
  %ctpop1 = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %shl16)
  store <2 x i32> %ctpop1, <2 x i32>* %p
  %lshl16 = lshr <2 x i32> %b, <i32 16, i32 16>
  %ctpop2 = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %lshl16)
  %res = add <2 x i32> %ctpop1, %ctpop2
  ret <2 x i32> %res
}

define i8 @ctpop_rotate_left(i8 %a, i8 %amt)  {
; CHECK-LABEL: @ctpop_rotate_left(
; CHECK-NEXT:    [[RES:%.*]] = tail call i8 @llvm.ctpop.i8(i8 [[A:%.*]]), !range [[RNG0]]
; CHECK-NEXT:    ret i8 [[RES]]
;
  %rotl = tail call i8 @llvm.fshl.i8(i8 %a, i8 %a, i8 %amt)
  %res = tail call i8 @llvm.ctpop.i8(i8 %rotl)
  ret i8 %res
}

define i8 @ctpop_rotate_right(i8 %a, i8 %amt)  {
; CHECK-LABEL: @ctpop_rotate_right(
; CHECK-NEXT:    [[RES:%.*]] = tail call i8 @llvm.ctpop.i8(i8 [[A:%.*]]), !range [[RNG0]]
; CHECK-NEXT:    ret i8 [[RES]]
;
  %rotr = tail call i8 @llvm.fshr.i8(i8 %a, i8 %a, i8 %amt)
  %res = tail call i8 @llvm.ctpop.i8(i8 %rotr)
  ret i8 %res
}

declare i8 @llvm.fshl.i8(i8, i8, i8)
declare i8 @llvm.fshr.i8(i8, i8, i8)

define i8 @sub_ctpop(i8 %a)  {
; CHECK-LABEL: @sub_ctpop(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[A:%.*]], -1
; CHECK-NEXT:    [[TMP2:%.*]] = call i8 @llvm.ctpop.i8(i8 [[TMP1]]), !range [[RNG0]]
; CHECK-NEXT:    ret i8 [[TMP2]]
;
  %cnt = tail call i8 @llvm.ctpop.i8(i8 %a)
  %res = sub i8 8, %cnt
  ret i8 %res
}

define i8 @sub_ctpop_wrong_cst(i8 %a)  {
; CHECK-LABEL: @sub_ctpop_wrong_cst(
; CHECK-NEXT:    [[CNT:%.*]] = tail call i8 @llvm.ctpop.i8(i8 [[A:%.*]]), !range [[RNG0]]
; CHECK-NEXT:    [[RES:%.*]] = sub nsw i8 5, [[CNT]]
; CHECK-NEXT:    ret i8 [[RES]]
;
  %cnt = tail call i8 @llvm.ctpop.i8(i8 %a)
  %res = sub i8 5, %cnt
  ret i8 %res
}

define i8 @sub_ctpop_unknown(i8 %a, i8 %b)  {
; CHECK-LABEL: @sub_ctpop_unknown(
; CHECK-NEXT:    [[CNT:%.*]] = tail call i8 @llvm.ctpop.i8(i8 [[A:%.*]]), !range [[RNG0]]
; CHECK-NEXT:    [[RES:%.*]] = sub i8 [[B:%.*]], [[CNT]]
; CHECK-NEXT:    ret i8 [[RES]]
;
  %cnt = tail call i8 @llvm.ctpop.i8(i8 %a)
  %res = sub i8 %b, %cnt
  ret i8 %res
}

define <2 x i32> @sub_ctpop_vec(<2 x i32> %a) {
; CHECK-LABEL: @sub_ctpop_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = xor <2 x i32> [[A:%.*]], <i32 -1, i32 -1>
; CHECK-NEXT:    [[TMP2:%.*]] = call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[TMP1]])
; CHECK-NEXT:    ret <2 x i32> [[TMP2]]
;
  %cnt = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %a)
  %res = sub <2 x i32> <i32 32, i32 32>, %cnt
  ret <2 x i32> %res
}

define <2 x i32> @sub_ctpop_vec_extra_use(<2 x i32> %a, <2 x i32>* %p) {
; CHECK-LABEL: @sub_ctpop_vec_extra_use(
; CHECK-NEXT:    [[CNT:%.*]] = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[A:%.*]])
; CHECK-NEXT:    store <2 x i32> [[CNT]], <2 x i32>* [[P:%.*]], align 8
; CHECK-NEXT:    [[RES:%.*]] = sub nuw nsw <2 x i32> <i32 32, i32 32>, [[CNT]]
; CHECK-NEXT:    ret <2 x i32> [[RES]]
;
  %cnt = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %a)
  store <2 x i32> %cnt, <2 x i32>* %p
  %res = sub <2 x i32> <i32 32, i32 32>, %cnt
  ret <2 x i32> %res
}

define i32 @zext_ctpop(i16 %x) {
; CHECK-LABEL: @zext_ctpop(
; CHECK-NEXT:    [[TMP1:%.*]] = call i16 @llvm.ctpop.i16(i16 [[X:%.*]]), !range [[RNG3:![0-9]+]]
; CHECK-NEXT:    [[P:%.*]] = zext i16 [[TMP1]] to i32
; CHECK-NEXT:    ret i32 [[P]]
;
  %z = zext i16 %x to i32
  %p = call i32 @llvm.ctpop.i32(i32 %z)
  ret i32 %p
}

define <2 x i32> @zext_ctpop_vec(<2 x i7> %x) {
; CHECK-LABEL: @zext_ctpop_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = call <2 x i7> @llvm.ctpop.v2i7(<2 x i7> [[X:%.*]])
; CHECK-NEXT:    [[P:%.*]] = zext <2 x i7> [[TMP1]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[P]]
;
  %z = zext <2 x i7> %x to <2 x i32>
  %p = call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %z)
  ret <2 x i32> %p
}

define i32 @zext_ctpop_extra_use(i16 %x, i32* %q) {
; CHECK-LABEL: @zext_ctpop_extra_use(
; CHECK-NEXT:    [[Z:%.*]] = zext i16 [[X:%.*]] to i32
; CHECK-NEXT:    store i32 [[Z]], i32* [[Q:%.*]], align 4
; CHECK-NEXT:    [[P:%.*]] = call i32 @llvm.ctpop.i32(i32 [[Z]]), !range [[RNG4:![0-9]+]]
; CHECK-NEXT:    ret i32 [[P]]
;
  %z = zext i16 %x to i32
  store i32 %z, i32* %q
  %p = call i32 @llvm.ctpop.i32(i32 %z)
  ret i32 %p
}

define i32 @parity_xor(i32 %arg, i32 %arg1) {
; CHECK-LABEL: @parity_xor(
; CHECK-NEXT:    [[I:%.*]] = tail call i32 @llvm.ctpop.i32(i32 [[ARG:%.*]]), !range [[RNG1]]
; CHECK-NEXT:    [[I2:%.*]] = tail call i32 @llvm.ctpop.i32(i32 [[ARG1:%.*]]), !range [[RNG1]]
; CHECK-NEXT:    [[I3:%.*]] = xor i32 [[I2]], [[I]]
; CHECK-NEXT:    [[I4:%.*]] = and i32 [[I3]], 1
; CHECK-NEXT:    ret i32 [[I4]]
;
  %i = tail call i32 @llvm.ctpop.i32(i32 %arg)
  %i2 = tail call i32 @llvm.ctpop.i32(i32 %arg1)
  %i3 = xor i32 %i2, %i
  %i4 = and i32 %i3, 1
  ret i32 %i4
}

define i32 @parity_xor_trunc(i64 %arg, i64 %arg1) {
; CHECK-LABEL: @parity_xor_trunc(
; CHECK-NEXT:    [[I:%.*]] = tail call i64 @llvm.ctpop.i64(i64 [[ARG:%.*]]), !range [[RNG5:![0-9]+]]
; CHECK-NEXT:    [[I2:%.*]] = tail call i64 @llvm.ctpop.i64(i64 [[ARG1:%.*]]), !range [[RNG5]]
; CHECK-NEXT:    [[I3:%.*]] = xor i64 [[I2]], [[I]]
; CHECK-NEXT:    [[I4:%.*]] = trunc i64 [[I3]] to i32
; CHECK-NEXT:    [[I5:%.*]] = and i32 [[I4]], 1
; CHECK-NEXT:    ret i32 [[I5]]
;
  %i = tail call i64 @llvm.ctpop.i64(i64 %arg)
  %i2 = tail call i64 @llvm.ctpop.i64(i64 %arg1)
  %i3 = xor i64 %i2, %i
  %i4 = trunc i64 %i3 to i32
  %i5 = and i32 %i4, 1
  ret i32 %i5
}

define <2 x i32> @parity_xor_vec(<2 x i32> %arg, <2 x i32> %arg1) {
; CHECK-LABEL: @parity_xor_vec(
; CHECK-NEXT:    [[I:%.*]] = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[ARG:%.*]])
; CHECK-NEXT:    [[I2:%.*]] = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> [[ARG1:%.*]])
; CHECK-NEXT:    [[I3:%.*]] = xor <2 x i32> [[I2]], [[I]]
; CHECK-NEXT:    [[I4:%.*]] = and <2 x i32> [[I3]], <i32 1, i32 1>
; CHECK-NEXT:    ret <2 x i32> [[I4]]
;
  %i = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %arg)
  %i2 = tail call <2 x i32> @llvm.ctpop.v2i32(<2 x i32> %arg1)
  %i3 = xor <2 x i32> %i2, %i
  %i4 = and <2 x i32> %i3, <i32 1, i32 1>
  ret <2 x i32> %i4
}

define i32 @parity_xor_wrong_cst(i32 %arg, i32 %arg1) {
; CHECK-LABEL: @parity_xor_wrong_cst(
; CHECK-NEXT:    [[I:%.*]] = tail call i32 @llvm.ctpop.i32(i32 [[ARG:%.*]]), !range [[RNG1]]
; CHECK-NEXT:    [[I2:%.*]] = tail call i32 @llvm.ctpop.i32(i32 [[ARG1:%.*]]), !range [[RNG1]]
; CHECK-NEXT:    [[I3:%.*]] = xor i32 [[I2]], [[I]]
; CHECK-NEXT:    [[I4:%.*]] = and i32 [[I3]], 3
; CHECK-NEXT:    ret i32 [[I4]]
;
  %i = tail call i32 @llvm.ctpop.i32(i32 %arg)
  %i2 = tail call i32 @llvm.ctpop.i32(i32 %arg1)
  %i3 = xor i32 %i2, %i
  %i4 = and i32 %i3, 3
  ret i32 %i4
}

define i32 @parity_xor_extra_use(i32 %arg, i32 %arg1) {
; CHECK-LABEL: @parity_xor_extra_use(
; CHECK-NEXT:    [[I:%.*]] = tail call i32 @llvm.ctpop.i32(i32 [[ARG:%.*]]), !range [[RNG1]]
; CHECK-NEXT:    [[I2:%.*]] = and i32 [[I]], 1
; CHECK-NEXT:    tail call void @use(i32 [[I2]])
; CHECK-NEXT:    [[I3:%.*]] = tail call i32 @llvm.ctpop.i32(i32 [[ARG1:%.*]]), !range [[RNG1]]
; CHECK-NEXT:    [[I4:%.*]] = and i32 [[I3]], 1
; CHECK-NEXT:    [[I5:%.*]] = xor i32 [[I4]], [[I2]]
; CHECK-NEXT:    ret i32 [[I5]]
;
  %i = tail call i32 @llvm.ctpop.i32(i32 %arg)
  %i2 = and i32 %i, 1
  tail call void @use(i32 %i2)
  %i3 = tail call i32 @llvm.ctpop.i32(i32 %arg1)
  %i4 = and i32 %i3, 1
  %i5 = xor i32 %i4, %i2
  ret i32 %i5
}

define i32 @parity_xor_extra_use2(i32 %arg, i32 %arg1) {
; CHECK-LABEL: @parity_xor_extra_use2(
; CHECK-NEXT:    [[I:%.*]] = tail call i32 @llvm.ctpop.i32(i32 [[ARG1:%.*]]), !range [[RNG1]]
; CHECK-NEXT:    [[I2:%.*]] = and i32 [[I]], 1
; CHECK-NEXT:    tail call void @use(i32 [[I2]])
; CHECK-NEXT:    [[I3:%.*]] = tail call i32 @llvm.ctpop.i32(i32 [[ARG:%.*]]), !range [[RNG1]]
; CHECK-NEXT:    [[I4:%.*]] = and i32 [[I3]], 1
; CHECK-NEXT:    [[I5:%.*]] = xor i32 [[I2]], [[I4]]
; CHECK-NEXT:    ret i32 [[I5]]
;
  %i = tail call i32 @llvm.ctpop.i32(i32 %arg1)
  %i2 = and i32 %i, 1
  tail call void @use(i32 %i2)
  %i3 = tail call i32 @llvm.ctpop.i32(i32 %arg)
  %i4 = and i32 %i3, 1
  %i5 = xor i32 %i2, %i4
  ret i32 %i5
}
