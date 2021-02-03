; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; If we have some pattern that leaves only some low bits set, and then performs
; left-shift of those bits, we can combine those two shifts into a shift+mask.

; There are many variants to this pattern:
;   b)  (trunc ((x & (~(-1 << maskNbits))))) << shiftNbits
; simplify to:
;   ((trunc(x)) << shiftNbits) & (~(-1 << (maskNbits+shiftNbits)))

; Simple tests.

declare void @use32(i32)
declare void @use64(i64)

define i32 @t0_basic(i64 %x, i32 %nbits) {
; CHECK-LABEL: @t0_basic(
; CHECK-NEXT:    [[T0:%.*]] = add i32 [[NBITS:%.*]], -1
; CHECK-NEXT:    [[T1:%.*]] = zext i32 [[T0]] to i64
; CHECK-NEXT:    [[T2:%.*]] = shl i64 -1, [[T1]]
; CHECK-NEXT:    [[T3:%.*]] = xor i64 [[T2]], -1
; CHECK-NEXT:    [[T4:%.*]] = sub i32 32, [[NBITS]]
; CHECK-NEXT:    call void @use32(i32 [[T0]])
; CHECK-NEXT:    call void @use64(i64 [[T1]])
; CHECK-NEXT:    call void @use64(i64 [[T2]])
; CHECK-NEXT:    call void @use64(i64 [[T3]])
; CHECK-NEXT:    call void @use32(i32 [[T4]])
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[X:%.*]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = shl i32 [[TMP1]], [[T4]]
; CHECK-NEXT:    [[T7:%.*]] = and i32 [[TMP2]], 2147483647
; CHECK-NEXT:    ret i32 [[T7]]
;
  %t0 = add i32 %nbits, -1
  %t1 = zext i32 %t0 to i64
  %t2 = shl i64 -1, %t1 ; shifting by nbits-1
  %t3 = xor i64 %t2, -1
  %t4 = sub i32 32, %nbits

  call void @use32(i32 %t0)
  call void @use64(i64 %t1)
  call void @use64(i64 %t2)
  call void @use64(i64 %t3)
  call void @use32(i32 %t4)

  %t5 = and i64 %t3, %x
  %t6 = trunc i64 %t5 to i32
  %t7 = shl i32 %t6, %t4
  ret i32 %t7
}

; Vectors

declare void @use8xi32(<8 x i32>)
declare void @use8xi64(<8 x i64>)

define <8 x i32> @t1_vec_splat(<8 x i64> %x, <8 x i32> %nbits) {
; CHECK-LABEL: @t1_vec_splat(
; CHECK-NEXT:    [[T0:%.*]] = add <8 x i32> [[NBITS:%.*]], <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[T1:%.*]] = zext <8 x i32> [[T0]] to <8 x i64>
; CHECK-NEXT:    [[T2:%.*]] = shl <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>, [[T1]]
; CHECK-NEXT:    [[T3:%.*]] = xor <8 x i64> [[T2]], <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>
; CHECK-NEXT:    [[T4:%.*]] = sub <8 x i32> <i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32>, [[NBITS]]
; CHECK-NEXT:    call void @use8xi32(<8 x i32> [[T0]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T1]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T2]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T3]])
; CHECK-NEXT:    call void @use8xi32(<8 x i32> [[T4]])
; CHECK-NEXT:    [[TMP1:%.*]] = trunc <8 x i64> [[X:%.*]] to <8 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = shl <8 x i32> [[TMP1]], [[T4]]
; CHECK-NEXT:    [[T7:%.*]] = and <8 x i32> [[TMP2]], <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
; CHECK-NEXT:    ret <8 x i32> [[T7]]
;
  %t0 = add <8 x i32> %nbits, <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1>
  %t1 = zext <8 x i32> %t0 to <8 x i64>
  %t2 = shl <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>, %t1 ; shifting by nbits-1
  %t3 = xor <8 x i64> %t2, <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>
  %t4 = sub <8 x i32> <i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32>, %nbits

  call void @use8xi32(<8 x i32> %t0)
  call void @use8xi64(<8 x i64> %t1)
  call void @use8xi64(<8 x i64> %t2)
  call void @use8xi64(<8 x i64> %t3)
  call void @use8xi32(<8 x i32> %t4)

  %t5 = and <8 x i64> %t3, %x
  %t6 = trunc <8 x i64> %t5 to <8 x i32>
  %t7 = shl <8 x i32> %t6, %t4
  ret <8 x i32> %t7
}

define <8 x i32> @t2_vec_splat_undef(<8 x i64> %x, <8 x i32> %nbits) {
; CHECK-LABEL: @t2_vec_splat_undef(
; CHECK-NEXT:    [[T0:%.*]] = add <8 x i32> [[NBITS:%.*]], <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 undef, i32 -1>
; CHECK-NEXT:    [[T1:%.*]] = zext <8 x i32> [[T0]] to <8 x i64>
; CHECK-NEXT:    [[T2:%.*]] = shl <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 undef, i64 -1>, [[T1]]
; CHECK-NEXT:    [[T3:%.*]] = xor <8 x i64> [[T2]], <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 undef, i64 -1>
; CHECK-NEXT:    [[T4:%.*]] = sub <8 x i32> <i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 undef, i32 32>, [[NBITS]]
; CHECK-NEXT:    call void @use8xi32(<8 x i32> [[T0]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T1]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T2]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T3]])
; CHECK-NEXT:    call void @use8xi32(<8 x i32> [[T4]])
; CHECK-NEXT:    [[TMP1:%.*]] = trunc <8 x i64> [[X:%.*]] to <8 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = shl <8 x i32> [[TMP1]], [[T4]]
; CHECK-NEXT:    [[T7:%.*]] = and <8 x i32> [[TMP2]], <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 undef, i32 2147483647>
; CHECK-NEXT:    ret <8 x i32> [[T7]]
;
  %t0 = add <8 x i32> %nbits, <i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 undef, i32 -1>
  %t1 = zext <8 x i32> %t0 to <8 x i64>
  %t2 = shl <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 undef, i64 -1>, %t1 ; shifting by nbits-1
  %t3 = xor <8 x i64> %t2, <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 undef, i64 -1>
  %t4 = sub <8 x i32> <i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 undef, i32 32>, %nbits

  call void @use8xi32(<8 x i32> %t0)
  call void @use8xi64(<8 x i64> %t1)
  call void @use8xi64(<8 x i64> %t2)
  call void @use8xi64(<8 x i64> %t3)
  call void @use8xi32(<8 x i32> %t4)

  %t5 = and <8 x i64> %t3, %x
  %t6 = trunc <8 x i64> %t5 to <8 x i32>
  %t7 = shl <8 x i32> %t6, %t4
  ret <8 x i32> %t7
}

define <8 x i32> @t3_vec_nonsplat(<8 x i64> %x, <8 x i32> %nbits) {
; CHECK-LABEL: @t3_vec_nonsplat(
; CHECK-NEXT:    [[T0:%.*]] = add <8 x i32> [[NBITS:%.*]], <i32 -33, i32 -32, i32 -31, i32 -1, i32 0, i32 1, i32 31, i32 32>
; CHECK-NEXT:    [[T1:%.*]] = zext <8 x i32> [[T0]] to <8 x i64>
; CHECK-NEXT:    [[T2:%.*]] = shl <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>, [[T1]]
; CHECK-NEXT:    [[T3:%.*]] = xor <8 x i64> [[T2]], <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>
; CHECK-NEXT:    [[T4:%.*]] = sub <8 x i32> <i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32>, [[NBITS]]
; CHECK-NEXT:    call void @use8xi32(<8 x i32> [[T0]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T1]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T2]])
; CHECK-NEXT:    call void @use8xi64(<8 x i64> [[T3]])
; CHECK-NEXT:    call void @use8xi32(<8 x i32> [[T4]])
; CHECK-NEXT:    [[TMP1:%.*]] = trunc <8 x i64> [[X:%.*]] to <8 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = shl <8 x i32> [[TMP1]], [[T4]]
; CHECK-NEXT:    [[T7:%.*]] = and <8 x i32> [[TMP2]], <i32 undef, i32 0, i32 1, i32 2147483647, i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    ret <8 x i32> [[T7]]
;
  %t0 = add <8 x i32> %nbits, <i32 -33, i32 -32, i32 -31, i32 -1, i32 0, i32 1, i32 31, i32 32>
  %t1 = zext <8 x i32> %t0 to <8 x i64>
  %t2 = shl <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>, %t1 ; shifting by nbits-1
  %t3 = xor <8 x i64> %t2, <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>
  %t4 = sub <8 x i32> <i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32>, %nbits

  call void @use8xi32(<8 x i32> %t0)
  call void @use8xi64(<8 x i64> %t1)
  call void @use8xi64(<8 x i64> %t2)
  call void @use8xi64(<8 x i64> %t3)
  call void @use8xi32(<8 x i32> %t4)

  %t5 = and <8 x i64> %t3, %x
  %t6 = trunc <8 x i64> %t5 to <8 x i32>
  %t7 = shl <8 x i32> %t6, %t4
  ret <8 x i32> %t7
}

; -1 can be truncated.

define i32 @t4_allones_trunc(i64 %x, i32 %nbits) {
; CHECK-LABEL: @t4_allones_trunc(
; CHECK-NEXT:    [[T0:%.*]] = add i32 [[NBITS:%.*]], -1
; CHECK-NEXT:    [[T1:%.*]] = zext i32 [[T0]] to i64
; CHECK-NEXT:    [[T2:%.*]] = shl i64 -1, [[T1]]
; CHECK-NEXT:    [[T3:%.*]] = xor i64 [[T2]], 4294967295
; CHECK-NEXT:    [[T4:%.*]] = sub i32 32, [[NBITS]]
; CHECK-NEXT:    call void @use32(i32 [[T0]])
; CHECK-NEXT:    call void @use64(i64 [[T1]])
; CHECK-NEXT:    call void @use64(i64 [[T2]])
; CHECK-NEXT:    call void @use64(i64 [[T3]])
; CHECK-NEXT:    call void @use32(i32 [[T4]])
; CHECK-NEXT:    [[T5:%.*]] = and i64 [[T3]], [[X:%.*]]
; CHECK-NEXT:    [[T6:%.*]] = trunc i64 [[T5]] to i32
; CHECK-NEXT:    [[T7:%.*]] = shl i32 [[T6]], [[T4]]
; CHECK-NEXT:    ret i32 [[T7]]
;
  %t0 = add i32 %nbits, -1
  %t1 = zext i32 %t0 to i64
  %t2 = shl i64 -1, %t1 ; shifting by nbits-1
  %t3 = xor i64 %t2, 4294967295 ; we only care about low 32 bits
  %t4 = sub i32 32, %nbits

  call void @use32(i32 %t0)
  call void @use64(i64 %t1)
  call void @use64(i64 %t2)
  call void @use64(i64 %t3)
  call void @use32(i32 %t4)

  %t5 = and i64 %t3, %x
  %t6 = trunc i64 %t5 to i32
  %t7 = shl i32 %t6, %t4
  ret i32 %t7
}

; Extra uses

define i32 @n5_extrause0(i64 %x, i32 %nbits) {
; CHECK-LABEL: @n5_extrause0(
; CHECK-NEXT:    [[T0:%.*]] = add i32 [[NBITS:%.*]], -1
; CHECK-NEXT:    [[T1:%.*]] = zext i32 [[T0]] to i64
; CHECK-NEXT:    [[T2:%.*]] = shl i64 -1, [[T1]]
; CHECK-NEXT:    [[T3:%.*]] = xor i64 [[T2]], -1
; CHECK-NEXT:    [[T4:%.*]] = sub i32 32, [[NBITS]]
; CHECK-NEXT:    call void @use32(i32 [[T0]])
; CHECK-NEXT:    call void @use64(i64 [[T1]])
; CHECK-NEXT:    call void @use64(i64 [[T2]])
; CHECK-NEXT:    call void @use64(i64 [[T3]])
; CHECK-NEXT:    call void @use32(i32 [[T4]])
; CHECK-NEXT:    [[T5:%.*]] = and i64 [[T3]], [[X:%.*]]
; CHECK-NEXT:    call void @use64(i64 [[T5]])
; CHECK-NEXT:    [[T6:%.*]] = trunc i64 [[T5]] to i32
; CHECK-NEXT:    [[T7:%.*]] = shl i32 [[T6]], [[T4]]
; CHECK-NEXT:    ret i32 [[T7]]
;
  %t0 = add i32 %nbits, -1
  %t1 = zext i32 %t0 to i64
  %t2 = shl i64 -1, %t1 ; shifting by nbits-1
  %t3 = xor i64 %t2, -1
  %t4 = sub i32 32, %nbits

  call void @use32(i32 %t0)
  call void @use64(i64 %t1)
  call void @use64(i64 %t2)
  call void @use64(i64 %t3)
  call void @use32(i32 %t4)

  %t5 = and i64 %t3, %x
  call void @use64(i64 %t5)
  %t6 = trunc i64 %t5 to i32
  %t7 = shl i32 %t6, %t4
  ret i32 %t7
}
define i32 @n6_extrause1(i64 %x, i32 %nbits) {
; CHECK-LABEL: @n6_extrause1(
; CHECK-NEXT:    [[T0:%.*]] = add i32 [[NBITS:%.*]], -1
; CHECK-NEXT:    [[T1:%.*]] = zext i32 [[T0]] to i64
; CHECK-NEXT:    [[T2:%.*]] = shl i64 -1, [[T1]]
; CHECK-NEXT:    [[T3:%.*]] = xor i64 [[T2]], -1
; CHECK-NEXT:    [[T4:%.*]] = sub i32 32, [[NBITS]]
; CHECK-NEXT:    call void @use32(i32 [[T0]])
; CHECK-NEXT:    call void @use64(i64 [[T1]])
; CHECK-NEXT:    call void @use64(i64 [[T2]])
; CHECK-NEXT:    call void @use64(i64 [[T3]])
; CHECK-NEXT:    call void @use32(i32 [[T4]])
; CHECK-NEXT:    [[T5:%.*]] = and i64 [[T3]], [[X:%.*]]
; CHECK-NEXT:    [[T6:%.*]] = trunc i64 [[T5]] to i32
; CHECK-NEXT:    call void @use32(i32 [[T6]])
; CHECK-NEXT:    [[T7:%.*]] = shl i32 [[T6]], [[T4]]
; CHECK-NEXT:    ret i32 [[T7]]
;
  %t0 = add i32 %nbits, -1
  %t1 = zext i32 %t0 to i64
  %t2 = shl i64 -1, %t1 ; shifting by nbits-1
  %t3 = xor i64 %t2, -1
  %t4 = sub i32 32, %nbits

  call void @use32(i32 %t0)
  call void @use64(i64 %t1)
  call void @use64(i64 %t2)
  call void @use64(i64 %t3)
  call void @use32(i32 %t4)

  %t5 = and i64 %t3, %x
  %t6 = trunc i64 %t5 to i32
  call void @use32(i32 %t6)
  %t7 = shl i32 %t6, %t4
  ret i32 %t7
}
define i32 @n7_extrause2(i64 %x, i32 %nbits) {
; CHECK-LABEL: @n7_extrause2(
; CHECK-NEXT:    [[T0:%.*]] = add i32 [[NBITS:%.*]], -1
; CHECK-NEXT:    [[T1:%.*]] = zext i32 [[T0]] to i64
; CHECK-NEXT:    [[T2:%.*]] = shl i64 -1, [[T1]]
; CHECK-NEXT:    [[T3:%.*]] = xor i64 [[T2]], -1
; CHECK-NEXT:    [[T4:%.*]] = sub i32 32, [[NBITS]]
; CHECK-NEXT:    call void @use32(i32 [[T0]])
; CHECK-NEXT:    call void @use64(i64 [[T1]])
; CHECK-NEXT:    call void @use64(i64 [[T2]])
; CHECK-NEXT:    call void @use64(i64 [[T3]])
; CHECK-NEXT:    call void @use32(i32 [[T4]])
; CHECK-NEXT:    [[T5:%.*]] = and i64 [[T3]], [[X:%.*]]
; CHECK-NEXT:    call void @use64(i64 [[T5]])
; CHECK-NEXT:    [[T6:%.*]] = trunc i64 [[T5]] to i32
; CHECK-NEXT:    call void @use32(i32 [[T6]])
; CHECK-NEXT:    [[T7:%.*]] = shl i32 [[T6]], [[T4]]
; CHECK-NEXT:    ret i32 [[T7]]
;
  %t0 = add i32 %nbits, -1
  %t1 = zext i32 %t0 to i64
  %t2 = shl i64 -1, %t1 ; shifting by nbits-1
  %t3 = xor i64 %t2, -1
  %t4 = sub i32 32, %nbits

  call void @use32(i32 %t0)
  call void @use64(i64 %t1)
  call void @use64(i64 %t2)
  call void @use64(i64 %t3)
  call void @use32(i32 %t4)

  %t5 = and i64 %t3, %x
  call void @use64(i64 %t5)
  %t6 = trunc i64 %t5 to i32
  call void @use32(i32 %t6)
  %t7 = shl i32 %t6, %t4
  ret i32 %t7
}
