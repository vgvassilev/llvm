; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128-n8:16:32"

define i32 @test1(i32 %i) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[T12:%.*]] = call i32 @llvm.bswap.i32(i32 [[I:%.*]])
; CHECK-NEXT:    ret i32 [[T12]]
;
  %t1 = lshr i32 %i, 24
  %t3 = lshr i32 %i, 8
  %t4 = and i32 %t3, 65280
  %t5 = or i32 %t1, %t4
  %t7 = shl i32 %i, 8
  %t8 = and i32 %t7, 16711680
  %t9 = or i32 %t5, %t8
  %t11 = shl i32 %i, 24
  %t12 = or i32 %t9, %t11
  ret i32 %t12
}

define i32 @test2(i32 %arg) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[T14:%.*]] = call i32 @llvm.bswap.i32(i32 [[ARG:%.*]])
; CHECK-NEXT:    ret i32 [[T14]]
;
  %t2 = shl i32 %arg, 24
  %t4 = shl i32 %arg, 8
  %t5 = and i32 %t4, 16711680
  %t6 = or i32 %t2, %t5
  %t8 = lshr i32 %arg, 8
  %t9 = and i32 %t8, 65280
  %t10 = or i32 %t6, %t9
  %t12 = lshr i32 %arg, 24
  %t14 = or i32 %t10, %t12
  ret i32 %t14
}

define i16 @test3(i16 %s) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[T5:%.*]] = call i16 @llvm.bswap.i16(i16 [[S:%.*]])
; CHECK-NEXT:    ret i16 [[T5]]
;
  %t2 = lshr i16 %s, 8
  %t4 = shl i16 %s, 8
  %t5 = or i16 %t2, %t4
  ret i16 %t5
}

define i16 @test4(i16 %s) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[T5:%.*]] = call i16 @llvm.bswap.i16(i16 [[S:%.*]])
; CHECK-NEXT:    ret i16 [[T5]]
;
  %t2 = lshr i16 %s, 8
  %t4 = shl i16 %s, 8
  %t5 = or i16 %t4, %t2
  ret i16 %t5
}

define i16 @test5(i16 %a) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[T_UPGRD_3:%.*]] = call i16 @llvm.bswap.i16(i16 [[A:%.*]])
; CHECK-NEXT:    ret i16 [[T_UPGRD_3]]
;
  %t = zext i16 %a to i32
  %t1 = and i32 %t, 65280
  %t2 = ashr i32 %t1, 8
  %t2.upgrd.1 = trunc i32 %t2 to i16
  %t4 = and i32 %t, 255
  %t5 = shl i32 %t4, 8
  %t5.upgrd.2 = trunc i32 %t5 to i16
  %t.upgrd.3 = or i16 %t2.upgrd.1, %t5.upgrd.2
  %t6 = bitcast i16 %t.upgrd.3 to i16
  %t6.upgrd.4 = zext i16 %t6 to i32
  %retval = trunc i32 %t6.upgrd.4 to i16
  ret i16 %retval
}

; PR2842
define i32 @test6(i32 %x) nounwind readnone {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    [[T7:%.*]] = call i32 @llvm.bswap.i32(i32 [[X:%.*]])
; CHECK-NEXT:    ret i32 [[T7]]
;
  %t = shl i32 %x, 16
  %x.mask = and i32 %x, 65280
  %t1 = lshr i32 %x, 16
  %t2 = and i32 %t1, 255
  %t3 = or i32 %x.mask, %t
  %t4 = or i32 %t3, %t2
  %t5 = shl i32 %t4, 8
  %t6 = lshr i32 %x, 24
  %t7 = or i32 %t5, %t6
  ret i32 %t7
}

declare void @extra_use(i32)

; swaphalf = (x << 16 | x >> 16)
; ((swaphalf & 0x00ff00ff) << 8) | ((swaphalf >> 8) & 0x00ff00ff)

define i32 @bswap32_and_first(i32 %x) {
; CHECK-LABEL: @bswap32_and_first(
; CHECK-NEXT:    [[BSWAP:%.*]] = call i32 @llvm.bswap.i32(i32 [[X:%.*]])
; CHECK-NEXT:    ret i32 [[BSWAP]]
;
  %shl = shl i32 %x, 16
  %shr = lshr i32 %x, 16
  %swaphalf = or i32 %shl, %shr
  %t = and i32 %swaphalf, 16711935
  %tshl = shl nuw i32 %t, 8
  %b = lshr i32 %swaphalf, 8
  %band = and i32 %b, 16711935
  %bswap = or i32 %tshl, %band
  ret i32 %bswap
}

; Extra use should not prevent matching to bswap.
; swaphalf = (x << 16 | x >> 16)
; ((swaphalf & 0x00ff00ff) << 8) | ((swaphalf >> 8) & 0x00ff00ff)

define i32 @bswap32_and_first_extra_use(i32 %x) {
; CHECK-LABEL: @bswap32_and_first_extra_use(
; CHECK-NEXT:    [[SWAPHALF:%.*]] = call i32 @llvm.fshl.i32(i32 [[X:%.*]], i32 [[X]], i32 16)
; CHECK-NEXT:    [[T:%.*]] = and i32 [[SWAPHALF]], 16711935
; CHECK-NEXT:    [[BSWAP:%.*]] = call i32 @llvm.bswap.i32(i32 [[X]])
; CHECK-NEXT:    call void @extra_use(i32 [[T]])
; CHECK-NEXT:    ret i32 [[BSWAP]]
;
  %shl = shl i32 %x, 16
  %shr = lshr i32 %x, 16
  %swaphalf = or i32 %shl, %shr
  %t = and i32 %swaphalf, 16711935
  %tshl = shl nuw i32 %t, 8
  %b = lshr i32 %swaphalf, 8
  %band = and i32 %b, 16711935
  %bswap = or i32 %tshl, %band
  call void @extra_use(i32 %t)
  ret i32 %bswap
}

; swaphalf = (x << 16 | x >> 16)
; ((swaphalf << 8) & 0xff00ff00) | ((swaphalf >> 8) & 0x00ff00ff)

; PR23863
define i32 @bswap32_shl_first(i32 %x) {
; CHECK-LABEL: @bswap32_shl_first(
; CHECK-NEXT:    [[BSWAP:%.*]] = call i32 @llvm.bswap.i32(i32 [[X:%.*]])
; CHECK-NEXT:    ret i32 [[BSWAP]]
;
  %shl = shl i32 %x, 16
  %shr = lshr i32 %x, 16
  %swaphalf = or i32 %shl, %shr
  %t = shl i32 %swaphalf, 8
  %tand = and i32 %t, -16711936
  %b = lshr i32 %swaphalf, 8
  %band = and i32 %b, 16711935
  %bswap = or i32 %tand, %band
  ret i32 %bswap
}

; Extra use should not prevent matching to bswap.
; swaphalf = (x << 16 | x >> 16)
; ((swaphalf << 8) & 0xff00ff00) | ((swaphalf >> 8) & 0x00ff00ff)

define i32 @bswap32_shl_first_extra_use(i32 %x) {
; CHECK-LABEL: @bswap32_shl_first_extra_use(
; CHECK-NEXT:    [[SWAPHALF:%.*]] = call i32 @llvm.fshl.i32(i32 [[X:%.*]], i32 [[X]], i32 16)
; CHECK-NEXT:    [[T:%.*]] = shl i32 [[SWAPHALF]], 8
; CHECK-NEXT:    [[BSWAP:%.*]] = call i32 @llvm.bswap.i32(i32 [[X]])
; CHECK-NEXT:    call void @extra_use(i32 [[T]])
; CHECK-NEXT:    ret i32 [[BSWAP]]
;
  %shl = shl i32 %x, 16
  %shr = lshr i32 %x, 16
  %swaphalf = or i32 %shl, %shr
  %t = shl i32 %swaphalf, 8
  %tand = and i32 %t, -16711936
  %b = lshr i32 %swaphalf, 8
  %band = and i32 %b, 16711935
  %bswap = or i32 %tand, %band
  call void @extra_use(i32 %t)
  ret i32 %bswap
}

define i16 @test8(i16 %a) {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[OR:%.*]] = call i16 @llvm.bswap.i16(i16 [[A:%.*]])
; CHECK-NEXT:    ret i16 [[OR]]
;
  %conv = zext i16 %a to i32
  %shr = lshr i16 %a, 8
  %shl = shl i32 %conv, 8
  %conv1 = zext i16 %shr to i32
  %or = or i32 %conv1, %shl
  %conv2 = trunc i32 %or to i16
  ret i16 %conv2
}

define i16 @test9(i16 %a) {
; CHECK-LABEL: @test9(
; CHECK-NEXT:    [[OR:%.*]] = call i16 @llvm.bswap.i16(i16 [[A:%.*]])
; CHECK-NEXT:    ret i16 [[OR]]
;
  %conv = zext i16 %a to i32
  %shr = lshr i32 %conv, 8
  %shl = shl i32 %conv, 8
  %or = or i32 %shr, %shl
  %conv2 = trunc i32 %or to i16
  ret i16 %conv2
}

define i16 @test10(i32 %a) {
; CHECK-LABEL: @test10(
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i32 [[A:%.*]] to i16
; CHECK-NEXT:    [[REV:%.*]] = call i16 @llvm.bswap.i16(i16 [[TRUNC]])
; CHECK-NEXT:    ret i16 [[REV]]
;
  %shr1 = lshr i32 %a, 8
  %and1 = and i32 %shr1, 255
  %and2 = shl i32 %a, 8
  %shl1 = and i32 %and2, 65280
  %or = or i32 %and1, %shl1
  %conv = trunc i32 %or to i16
  ret i16 %conv
}

define i64 @PR39793_bswap_u64_as_u32(i64 %0) {
; CHECK-LABEL: @PR39793_bswap_u64_as_u32(
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i64 [[TMP0:%.*]] to i32
; CHECK-NEXT:    [[REV:%.*]] = call i32 @llvm.bswap.i32(i32 [[TRUNC]])
; CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[REV]] to i64
; CHECK-NEXT:    ret i64 [[TMP2]]
;
  %2 = lshr i64 %0, 24
  %3 = and i64 %2, 255
  %4 = lshr i64 %0, 8
  %5 = and i64 %4, 65280
  %6 = or i64 %3, %5
  %7 = shl i64 %0, 8
  %8 = and i64 %7, 16711680
  %9 = or i64 %6, %8
  %10 = shl i64 %0, 24
  %11 = and i64 %10, 4278190080
  %12 = or i64 %9, %11
  ret i64 %12
}

define i16 @PR39793_bswap_u64_as_u32_trunc(i64 %0) {
; CHECK-LABEL: @PR39793_bswap_u64_as_u32_trunc(
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i64 [[TMP0:%.*]] to i32
; CHECK-NEXT:    [[REV:%.*]] = call i32 @llvm.bswap.i32(i32 [[TRUNC]])
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i32 [[REV]] to i16
; CHECK-NEXT:    ret i16 [[TMP2]]
;
  %2 = lshr i64 %0, 24
  %3 = and i64 %2, 255
  %4 = lshr i64 %0, 8
  %5 = and i64 %4, 65280
  %6 = or i64 %3, %5
  %7 = shl i64 %0, 8
  %8 = and i64 %7, 16711680
  %9 = or i64 %6, %8
  %10 = shl i64 %0, 24
  %11 = and i64 %10, 4278190080
  %12 = or i64 %9, %11
  %13 = trunc i64 %12 to i16
  ret i16 %13
}

define i64 @PR39793_bswap_u64_as_u16(i64 %0) {
; CHECK-LABEL: @PR39793_bswap_u64_as_u16(
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i64 [[TMP0:%.*]] to i16
; CHECK-NEXT:    [[REV:%.*]] = call i16 @llvm.bswap.i16(i16 [[TRUNC]])
; CHECK-NEXT:    [[TMP2:%.*]] = zext i16 [[REV]] to i64
; CHECK-NEXT:    ret i64 [[TMP2]]
;
  %2 = lshr i64 %0, 8
  %3 = and i64 %2, 255
  %4 = shl i64 %0, 8
  %5 = and i64 %4, 65280
  %6 = or i64 %3, %5
  ret i64 %6
}

define i8 @PR39793_bswap_u64_as_u16_trunc(i64 %0) {
; CHECK-LABEL: @PR39793_bswap_u64_as_u16_trunc(
; CHECK-NEXT:    [[REV1:%.*]] = lshr i64 [[TMP0:%.*]], 8
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i64 [[REV1]] to i8
; CHECK-NEXT:    ret i8 [[TMP2]]
;
  %2 = lshr i64 %0, 8
  %3 = and i64 %2, 255
  %4 = shl i64 %0, 8
  %5 = and i64 %4, 65280
  %6 = or i64 %3, %5
  %7 = trunc i64 %6 to i8
  ret i8 %7
}

define i50 @PR39793_bswap_u50_as_u16(i50 %0) {
; CHECK-LABEL: @PR39793_bswap_u50_as_u16(
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i50 [[TMP0:%.*]] to i16
; CHECK-NEXT:    [[REV:%.*]] = call i16 @llvm.bswap.i16(i16 [[TRUNC]])
; CHECK-NEXT:    [[TMP2:%.*]] = zext i16 [[REV]] to i50
; CHECK-NEXT:    ret i50 [[TMP2]]
;
  %2 = lshr i50 %0, 8
  %3 = and i50 %2, 255
  %4 = shl i50 %0, 8
  %5 = and i50 %4, 65280
  %6 = or i50 %3, %5
  ret i50 %6
}

define i32 @PR39793_bswap_u32_as_u16(i32 %0) {
; CHECK-LABEL: @PR39793_bswap_u32_as_u16(
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i32 [[TMP0:%.*]] to i16
; CHECK-NEXT:    [[REV:%.*]] = call i16 @llvm.bswap.i16(i16 [[TRUNC]])
; CHECK-NEXT:    [[TMP2:%.*]] = zext i16 [[REV]] to i32
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %2 = lshr i32 %0, 8
  %3 = and i32 %2, 255
  %4 = shl i32 %0, 8
  %5 = and i32 %4, 65280
  %6 = or i32 %3, %5
  ret i32 %6
}

define i8 @PR39793_bswap_u32_as_u16_trunc(i32 %0) {
; CHECK-LABEL: @PR39793_bswap_u32_as_u16_trunc(
; CHECK-NEXT:    [[REV1:%.*]] = lshr i32 [[TMP0:%.*]], 8
; CHECK-NEXT:    [[TMP2:%.*]] = trunc i32 [[REV1]] to i8
; CHECK-NEXT:    ret i8 [[TMP2]]
;
  %2 = lshr i32 %0, 8
  %3 = and i32 %2, 255
  %4 = shl i32 %0, 8
  %5 = and i32 %4, 65280
  %6 = or i32 %3, %5
  %7 = trunc i32 %6 to i8
  ret i8 %7
}

define i32 @partial_bswap(i32 %x) {
; CHECK-LABEL: @partial_bswap(
; CHECK-NEXT:    [[X3:%.*]] = shl i32 [[X:%.*]], 24
; CHECK-NEXT:    [[A2:%.*]] = shl i32 [[X]], 8
; CHECK-NEXT:    [[X2:%.*]] = and i32 [[A2]], 16711680
; CHECK-NEXT:    [[X32:%.*]] = or i32 [[X3]], [[X2]]
; CHECK-NEXT:    [[T1:%.*]] = and i32 [[X]], -65536
; CHECK-NEXT:    [[T2:%.*]] = call i32 @llvm.bswap.i32(i32 [[T1]])
; CHECK-NEXT:    [[R:%.*]] = or i32 [[X32]], [[T2]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %x3 = shl i32 %x, 24
  %a2 = shl i32 %x, 8
  %x2 = and i32 %a2, 16711680
  %x32 = or i32 %x3, %x2
  %t1 = and i32 %x, -65536
  %t2 = call i32 @llvm.bswap.i32(i32 %t1)
  %r = or i32 %x32, %t2
  ret i32 %r
}
declare i32 @llvm.bswap.i32(i32)

define i64 @bswap_and_mask_0(i64 %0) {
; CHECK-LABEL: @bswap_and_mask_0(
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0:%.*]], 56
; CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[TMP0]], 56
; CHECK-NEXT:    [[TMP4:%.*]] = or i64 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    ret i64 [[TMP4]]
;
  %2 = lshr i64 %0, 56
  %3 = shl i64 %0, 56
  %4 = or i64 %2, %3
  ret i64 %4
}

define i64 @bswap_and_mask_1(i64 %0) {
; CHECK-LABEL: @bswap_and_mask_1(
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0:%.*]], 56
; CHECK-NEXT:    [[TMP3:%.*]] = lshr i64 [[TMP0]], 40
; CHECK-NEXT:    [[TMP4:%.*]] = and i64 [[TMP3]], 65280
; CHECK-NEXT:    [[TMP5:%.*]] = or i64 [[TMP4]], [[TMP2]]
; CHECK-NEXT:    ret i64 [[TMP5]]
;
  %2 = lshr i64 %0, 56
  %3 = lshr i64 %0, 40
  %4 = and i64 %3, 65280
  %5 = or i64 %4, %2
  ret i64 %5
}

define i64 @bswap_and_mask_2(i64 %0) {
; CHECK-LABEL: @bswap_and_mask_2(
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0:%.*]], 56
; CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[TMP0]], 56
; CHECK-NEXT:    [[TMP4:%.*]] = or i64 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = shl i64 [[TMP0]], 40
; CHECK-NEXT:    [[TMP6:%.*]] = and i64 [[TMP5]], 71776119061217280
; CHECK-NEXT:    [[TMP7:%.*]] = or i64 [[TMP4]], [[TMP6]]
; CHECK-NEXT:    ret i64 [[TMP7]]
;
  %2 = lshr i64 %0, 56
  %3 = shl i64 %0, 56
  %4 = or i64 %2, %3
  %5 = shl i64 %0, 40
  %6 = and i64 %5, 71776119061217280
  %7 = or i64 %4, %6
  ret i64 %7
}

define i32 @shuf_4bytes(<4 x i8> %x) {
; CHECK-LABEL: @shuf_4bytes(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x i8> [[X:%.*]] to i32
; CHECK-NEXT:    [[CAST:%.*]] = call i32 @llvm.bswap.i32(i32 [[TMP1]])
; CHECK-NEXT:    ret i32 [[CAST]]
;
  %bswap = shufflevector <4 x i8> %x, <4 x i8> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %cast = bitcast <4 x i8> %bswap to i32
  ret i32 %cast
}

define i32 @shuf_load_4bytes(<4 x i8>* %p) {
; CHECK-LABEL: @shuf_load_4bytes(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x i8>* [[P:%.*]] to i32*
; CHECK-NEXT:    [[X1:%.*]] = load i32, i32* [[TMP1]], align 4
; CHECK-NEXT:    [[CAST:%.*]] = call i32 @llvm.bswap.i32(i32 [[X1]])
; CHECK-NEXT:    ret i32 [[CAST]]
;
  %x = load <4 x i8>, <4 x i8>* %p
  %bswap = shufflevector <4 x i8> %x, <4 x i8> undef, <4 x i32> <i32 3, i32 2, i32 undef, i32 0>
  %cast = bitcast <4 x i8> %bswap to i32
  ret i32 %cast
}

define i32 @shuf_bitcast_twice_4bytes(i32 %x) {
; CHECK-LABEL: @shuf_bitcast_twice_4bytes(
; CHECK-NEXT:    [[CAST2:%.*]] = call i32 @llvm.bswap.i32(i32 [[X:%.*]])
; CHECK-NEXT:    ret i32 [[CAST2]]
;
  %cast1 = bitcast i32 %x to <4 x i8>
  %bswap = shufflevector <4 x i8> %cast1, <4 x i8> undef, <4 x i32> <i32 undef, i32 2, i32 1, i32 0>
  %cast2 = bitcast <4 x i8> %bswap to i32
  ret i32 %cast2
}

; Negative test - extra use
declare void @use(<4 x i8>)

define i32 @shuf_4bytes_extra_use(<4 x i8> %x) {
; CHECK-LABEL: @shuf_4bytes_extra_use(
; CHECK-NEXT:    [[BSWAP:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    call void @use(<4 x i8> [[BSWAP]])
; CHECK-NEXT:    [[CAST:%.*]] = bitcast <4 x i8> [[BSWAP]] to i32
; CHECK-NEXT:    ret i32 [[CAST]]
;
  %bswap = shufflevector <4 x i8> %x, <4 x i8> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  call void @use(<4 x i8> %bswap)
  %cast = bitcast <4 x i8> %bswap to i32
  ret i32 %cast
}

; Negative test - scalar type is not in the data layout

define i128 @shuf_16bytes(<16 x i8> %x) {
; CHECK-LABEL: @shuf_16bytes(
; CHECK-NEXT:    [[BSWAP:%.*]] = shufflevector <16 x i8> [[X:%.*]], <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:    [[CAST:%.*]] = bitcast <16 x i8> [[BSWAP]] to i128
; CHECK-NEXT:    ret i128 [[CAST]]
;
  %bswap = shufflevector <16 x i8> %x, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  %cast = bitcast <16 x i8> %bswap to i128
  ret i128 %cast
}

; Negative test - don't touch widening shuffles (for now)

define i32 @shuf_2bytes_widening(<2 x i8> %x) {
; CHECK-LABEL: @shuf_2bytes_widening(
; CHECK-NEXT:    [[BSWAP:%.*]] = shufflevector <2 x i8> [[X:%.*]], <2 x i8> undef, <4 x i32> <i32 1, i32 0, i32 undef, i32 undef>
; CHECK-NEXT:    [[CAST:%.*]] = bitcast <4 x i8> [[BSWAP]] to i32
; CHECK-NEXT:    ret i32 [[CAST]]
;
  %bswap = shufflevector <2 x i8> %x, <2 x i8> undef, <4 x i32> <i32 1, i32 0, i32 undef, i32 undef>
  %cast = bitcast <4 x i8> %bswap to i32
  ret i32 %cast
}

declare i32 @llvm.fshl.i32(i32, i32, i32)
declare i32 @llvm.fshr.i32(i32, i32, i32)

define i32 @funnel_unary(i32 %abcd) {
; CHECK-LABEL: @funnel_unary(
; CHECK-NEXT:    [[DCBA:%.*]] = call i32 @llvm.bswap.i32(i32 [[ABCD:%.*]])
; CHECK-NEXT:    ret i32 [[DCBA]]
;
  %dabc = call i32 @llvm.fshl.i32(i32 %abcd, i32 %abcd, i32 24)
  %bcda = call i32 @llvm.fshr.i32(i32 %abcd, i32 %abcd, i32 24)
  %dzbz = and i32 %dabc, -16711936
  %zcza = and i32 %bcda,  16711935
  %dcba = or i32 %dzbz, %zcza
  ret i32 %dcba
}

define i32 @funnel_binary(i32 %abcd) {
; CHECK-LABEL: @funnel_binary(
; CHECK-NEXT:    [[DCBA:%.*]] = call i32 @llvm.bswap.i32(i32 [[ABCD:%.*]])
; CHECK-NEXT:    ret i32 [[DCBA]]
;
  %cdzz = shl i32 %abcd, 16
  %dcdz = call i32 @llvm.fshl.i32(i32 %abcd, i32 %cdzz, i32 24)
  %zzab = lshr i32 %abcd, 16
  %zaba = call i32 @llvm.fshr.i32(i32 %zzab, i32 %abcd, i32 24)
  %dczz = and i32 %dcdz, -65536
  %zzba = and i32 %zaba,  65535
  %dcba = or i32 %dczz, %zzba
  ret i32 %dcba
}

; PR47191 - deep IR trees prevent ADD/XOR instructions being simplified to OR.

define i64 @PR47191_problem1(i64 %0) {
; CHECK-LABEL: @PR47191_problem1(
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0:%.*]], 56
; CHECK-NEXT:    [[TMP3:%.*]] = lshr i64 [[TMP0]], 40
; CHECK-NEXT:    [[TMP4:%.*]] = and i64 [[TMP3]], 65280
; CHECK-NEXT:    [[TMP5:%.*]] = lshr i64 [[TMP0]], 24
; CHECK-NEXT:    [[TMP6:%.*]] = and i64 [[TMP5]], 16711680
; CHECK-NEXT:    [[TMP7:%.*]] = lshr i64 [[TMP0]], 8
; CHECK-NEXT:    [[TMP8:%.*]] = and i64 [[TMP7]], 4278190080
; CHECK-NEXT:    [[TMP9:%.*]] = shl i64 [[TMP0]], 56
; CHECK-NEXT:    [[TMP10:%.*]] = shl i64 [[TMP0]], 40
; CHECK-NEXT:    [[TMP11:%.*]] = and i64 [[TMP10]], 71776119061217280
; CHECK-NEXT:    [[TMP12:%.*]] = shl i64 [[TMP0]], 24
; CHECK-NEXT:    [[TMP13:%.*]] = and i64 [[TMP12]], 280375465082880
; CHECK-NEXT:    [[TMP14:%.*]] = or i64 [[TMP9]], [[TMP2]]
; CHECK-NEXT:    [[TMP15:%.*]] = or i64 [[TMP14]], [[TMP4]]
; CHECK-NEXT:    [[TMP16:%.*]] = or i64 [[TMP15]], [[TMP6]]
; CHECK-NEXT:    [[TMP17:%.*]] = or i64 [[TMP16]], [[TMP8]]
; CHECK-NEXT:    [[TMP18:%.*]] = or i64 [[TMP17]], [[TMP11]]
; CHECK-NEXT:    [[TMP19:%.*]] = or i64 [[TMP18]], [[TMP13]]
; CHECK-NEXT:    [[TMP20:%.*]] = shl i64 [[TMP0]], 8
; CHECK-NEXT:    [[TMP21:%.*]] = and i64 [[TMP20]], 1095216660480
; CHECK-NEXT:    [[TMP22:%.*]] = add i64 [[TMP19]], [[TMP21]]
; CHECK-NEXT:    ret i64 [[TMP22]]
;
  %2 = lshr i64 %0, 56
  %3 = lshr i64 %0, 40
  %4 = and i64 %3, 65280
  %5 = lshr i64 %0, 24
  %6 = and i64 %5, 16711680
  %7 = lshr i64 %0, 8
  %8 = and i64 %7, 4278190080
  %9 = shl i64 %0, 56
  %10 = shl i64 %0, 40
  %11 = and i64 %10, 71776119061217280
  %12 = shl i64 %0, 24
  %13 = and i64 %12, 280375465082880
  %14 = or i64 %9, %2
  %15 = or i64 %14, %4
  %16 = or i64 %15, %6
  %17 = or i64 %16, %8
  %18 = or i64 %17, %11
  %19 = or i64 %18, %13
  %20 = shl i64 %0, 8
  %21 = and i64 %20, 1095216660480
  %22 = add i64 %19, %21
  ret i64 %22
}

define i64 @PR47191_problem2(i64 %0) {
; CHECK-LABEL: @PR47191_problem2(
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0:%.*]], 56
; CHECK-NEXT:    [[TMP3:%.*]] = lshr i64 [[TMP0]], 40
; CHECK-NEXT:    [[TMP4:%.*]] = and i64 [[TMP3]], 65280
; CHECK-NEXT:    [[TMP5:%.*]] = lshr i64 [[TMP0]], 24
; CHECK-NEXT:    [[TMP6:%.*]] = and i64 [[TMP5]], 16711680
; CHECK-NEXT:    [[TMP7:%.*]] = lshr i64 [[TMP0]], 8
; CHECK-NEXT:    [[TMP8:%.*]] = and i64 [[TMP7]], 4278190080
; CHECK-NEXT:    [[TMP9:%.*]] = shl i64 [[TMP0]], 56
; CHECK-NEXT:    [[TMP10:%.*]] = shl i64 [[TMP0]], 40
; CHECK-NEXT:    [[TMP11:%.*]] = and i64 [[TMP10]], 71776119061217280
; CHECK-NEXT:    [[TMP12:%.*]] = or i64 [[TMP9]], [[TMP2]]
; CHECK-NEXT:    [[TMP13:%.*]] = or i64 [[TMP12]], [[TMP4]]
; CHECK-NEXT:    [[TMP14:%.*]] = or i64 [[TMP13]], [[TMP6]]
; CHECK-NEXT:    [[TMP15:%.*]] = or i64 [[TMP14]], [[TMP8]]
; CHECK-NEXT:    [[TMP16:%.*]] = or i64 [[TMP15]], [[TMP11]]
; CHECK-NEXT:    [[TMP17:%.*]] = shl i64 [[TMP0]], 24
; CHECK-NEXT:    [[TMP18:%.*]] = and i64 [[TMP17]], 280375465082880
; CHECK-NEXT:    [[TMP19:%.*]] = shl i64 [[TMP0]], 8
; CHECK-NEXT:    [[TMP20:%.*]] = and i64 [[TMP19]], 1095216660480
; CHECK-NEXT:    [[TMP21:%.*]] = or i64 [[TMP20]], [[TMP18]]
; CHECK-NEXT:    [[TMP22:%.*]] = xor i64 [[TMP21]], [[TMP16]]
; CHECK-NEXT:    ret i64 [[TMP22]]
;
  %2 = lshr i64 %0, 56
  %3 = lshr i64 %0, 40
  %4 = and i64 %3, 65280
  %5 = lshr i64 %0, 24
  %6 = and i64 %5, 16711680
  %7 = lshr i64 %0, 8
  %8 = and i64 %7, 4278190080
  %9 = shl i64 %0, 56
  %10 = shl i64 %0, 40
  %11 = and i64 %10, 71776119061217280
  %12 = or i64 %9, %2
  %13 = or i64 %12, %4
  %14 = or i64 %13, %6
  %15 = or i64 %14, %8
  %16 = or i64 %15, %11
  %17 = shl i64 %0, 24
  %18 = and i64 %17, 280375465082880
  %19 = shl i64 %0, 8
  %20 = and i64 %19, 1095216660480
  %21 = or i64 %20, %18
  %22 = xor i64 %21, %16
  ret i64 %22
}

define i64 @PR47191_problem3(i64 %0) {
; CHECK-LABEL: @PR47191_problem3(
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0:%.*]], 56
; CHECK-NEXT:    [[TMP3:%.*]] = lshr i64 [[TMP0]], 40
; CHECK-NEXT:    [[TMP4:%.*]] = and i64 [[TMP3]], 65280
; CHECK-NEXT:    [[TMP5:%.*]] = lshr i64 [[TMP0]], 24
; CHECK-NEXT:    [[TMP6:%.*]] = and i64 [[TMP5]], 16711680
; CHECK-NEXT:    [[TMP7:%.*]] = lshr i64 [[TMP0]], 8
; CHECK-NEXT:    [[TMP8:%.*]] = and i64 [[TMP7]], 4278190080
; CHECK-NEXT:    [[TMP9:%.*]] = shl i64 [[TMP0]], 56
; CHECK-NEXT:    [[TMP10:%.*]] = shl i64 [[TMP0]], 40
; CHECK-NEXT:    [[TMP11:%.*]] = and i64 [[TMP10]], 71776119061217280
; CHECK-NEXT:    [[TMP12:%.*]] = or i64 [[TMP9]], [[TMP2]]
; CHECK-NEXT:    [[TMP13:%.*]] = or i64 [[TMP12]], [[TMP4]]
; CHECK-NEXT:    [[TMP14:%.*]] = or i64 [[TMP13]], [[TMP6]]
; CHECK-NEXT:    [[TMP15:%.*]] = or i64 [[TMP14]], [[TMP8]]
; CHECK-NEXT:    [[TMP16:%.*]] = or i64 [[TMP15]], [[TMP11]]
; CHECK-NEXT:    [[TMP17:%.*]] = shl i64 [[TMP0]], 24
; CHECK-NEXT:    [[TMP18:%.*]] = and i64 [[TMP17]], 280375465082880
; CHECK-NEXT:    [[TMP19:%.*]] = shl i64 [[TMP0]], 8
; CHECK-NEXT:    [[TMP20:%.*]] = and i64 [[TMP19]], 1095216660480
; CHECK-NEXT:    [[TMP21:%.*]] = or i64 [[TMP20]], [[TMP18]]
; CHECK-NEXT:    [[TMP22:%.*]] = xor i64 [[TMP21]], [[TMP16]]
; CHECK-NEXT:    ret i64 [[TMP22]]
;
  %2 = lshr i64 %0, 56
  %3 = lshr i64 %0, 40
  %4 = and i64 %3, 65280
  %5 = lshr i64 %0, 24
  %6 = and i64 %5, 16711680
  %7 = lshr i64 %0, 8
  %8 = and i64 %7, 4278190080
  %9 = shl i64 %0, 56
  %10 = shl i64 %0, 40
  %11 = and i64 %10, 71776119061217280
  %12 = or i64 %9, %2
  %13 = or i64 %12, %4
  %14 = or i64 %13, %6
  %15 = or i64 %14, %8
  %16 = or i64 %15, %11
  %17 = shl i64 %0, 24
  %18 = and i64 %17, 280375465082880
  %19 = shl i64 %0, 8
  %20 = and i64 %19, 1095216660480
  %21 = or i64 %20, %18
  %22 = xor i64 %21, %16
  ret i64 %22
}

define i64 @PR47191_problem4(i64 %0) {
; CHECK-LABEL: @PR47191_problem4(
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i64 [[TMP0:%.*]], 56
; CHECK-NEXT:    [[TMP3:%.*]] = shl i64 [[TMP0]], 56
; CHECK-NEXT:    [[TMP4:%.*]] = or i64 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = lshr i64 [[TMP0]], 40
; CHECK-NEXT:    [[TMP6:%.*]] = and i64 [[TMP5]], 65280
; CHECK-NEXT:    [[TMP7:%.*]] = or i64 [[TMP4]], [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = shl i64 [[TMP0]], 40
; CHECK-NEXT:    [[TMP9:%.*]] = and i64 [[TMP8]], 71776119061217280
; CHECK-NEXT:    [[TMP10:%.*]] = or i64 [[TMP7]], [[TMP9]]
; CHECK-NEXT:    [[TMP11:%.*]] = lshr i64 [[TMP0]], 24
; CHECK-NEXT:    [[TMP12:%.*]] = and i64 [[TMP11]], 16711680
; CHECK-NEXT:    [[TMP13:%.*]] = or i64 [[TMP10]], [[TMP12]]
; CHECK-NEXT:    [[TMP14:%.*]] = shl i64 [[TMP0]], 24
; CHECK-NEXT:    [[TMP15:%.*]] = and i64 [[TMP14]], 280375465082880
; CHECK-NEXT:    [[TMP16:%.*]] = or i64 [[TMP13]], [[TMP15]]
; CHECK-NEXT:    [[TMP17:%.*]] = lshr i64 [[TMP0]], 8
; CHECK-NEXT:    [[TMP18:%.*]] = and i64 [[TMP17]], 4278190080
; CHECK-NEXT:    [[TMP19:%.*]] = or i64 [[TMP16]], [[TMP18]]
; CHECK-NEXT:    [[TMP20:%.*]] = shl i64 [[TMP0]], 8
; CHECK-NEXT:    [[TMP21:%.*]] = and i64 [[TMP20]], 1095216660480
; CHECK-NEXT:    [[TMP22:%.*]] = add i64 [[TMP19]], [[TMP21]]
; CHECK-NEXT:    ret i64 [[TMP22]]
;
  %2 = lshr i64 %0, 56
  %3 = shl i64 %0, 56
  %4 = or i64 %2, %3
  %5 = lshr i64 %0, 40
  %6 = and i64 %5, 65280
  %7 = or i64 %4, %6
  %8 = shl i64 %0, 40
  %9 = and i64 %8, 71776119061217280
  %10 = or i64 %7, %9
  %11 = lshr i64 %0, 24
  %12 = and i64 %11, 16711680
  %13 = or i64 %10, %12
  %14 = shl i64 %0, 24
  %15 = and i64 %14, 280375465082880
  %16 = or i64 %13, %15
  %17 = lshr i64 %0, 8
  %18 = and i64 %17, 4278190080
  %19 = or i64 %16, %18
  %20 = shl i64 %0, 8
  %21 = and i64 %20, 1095216660480
  %22 = add i64 %19, %21
  ret i64 %22
}
