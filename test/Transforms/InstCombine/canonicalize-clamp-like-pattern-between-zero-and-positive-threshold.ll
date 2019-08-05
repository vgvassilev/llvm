; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; Given a pattern like:
;   %old_cmp1 = icmp slt i32 %x, C2
;   %old_replacement = select i1 %old_cmp1, i32 %target_low, i32 %target_high
;   %old_x_offseted = add i32 %x, C1
;   %old_cmp0 = icmp ult i32 %old_x_offseted, C0
;   %r = select i1 %old_cmp0, i32 %x, i32 %old_replacement
; it can be rewriten as more canonical pattern:
;   %new_cmp1 = icmp slt i32 %x, -C1
;   %new_cmp2 = icmp sge i32 %x, C0-C1
;   %new_clamped_low = select i1 %new_cmp1, i32 %target_low, i32 %x
;   %r = select i1 %new_cmp2, i32 %target_high, i32 %new_clamped_low
; Iff -C1 s<= C2 s<= C0-C1
; Also, ULT predicate can also be UGE; or UGT iff C0 != -1 (+invert result)
; Also, SLT predicate can also be SGE; or SGT iff C2 != INT_MAX (+invert res.)

;-------------------------------------------------------------------------------

; Basic pattern. There is no 'and', so lower threshold is 0 (inclusive).
; The upper threshold is 65535 (inclusive).
; There are 2 icmp's so for scalars there are 4 possible combinations.
; The constant in %t0 has to be between the thresholds, i.e 65536 <= Ct0 <= 0.

define i32 @t0_ult_slt_65536(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @t0_ult_slt_65536(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 65536
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 65536
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  %t2 = icmp ult i32 %x, 65536
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}
define i32 @t1_ult_slt_0(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @t1_ult_slt_0(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 0
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 0
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  %t2 = icmp ult i32 %x, 65536
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}

define i32 @t2_ult_sgt_65536(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @t2_ult_sgt_65536(
; CHECK-NEXT:    [[T0:%.*]] = icmp sgt i32 [[X:%.*]], 65535
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_HIGH:%.*]], i32 [[REPLACEMENT_LOW:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp sgt i32 %x, 65535
  %t1 = select i1 %t0, i32 %replacement_high, i32 %replacement_low
  %t2 = icmp ult i32 %x, 65536
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}
define i32 @t3_ult_sgt_neg1(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @t3_ult_sgt_neg1(
; CHECK-NEXT:    [[T0:%.*]] = icmp sgt i32 [[X:%.*]], -1
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_HIGH:%.*]], i32 [[REPLACEMENT_LOW:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp sgt i32 %x, -1
  %t1 = select i1 %t0, i32 %replacement_high, i32 %replacement_low
  %t2 = icmp ult i32 %x, 65536
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}

define i32 @t4_ugt_slt_65536(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @t4_ugt_slt_65536(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 65536
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ugt i32 [[X]], 65535
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[T1]], i32 [[X]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 65536
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  %t2 = icmp ugt i32 %x, 65535
  %r = select i1 %t2, i32 %t1, i32 %x
  ret i32 %r
}
define i32 @t5_ugt_slt_0(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @t5_ugt_slt_0(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 0
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ugt i32 [[X]], 65535
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[T1]], i32 [[X]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 0
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  %t2 = icmp ugt i32 %x, 65535
  %r = select i1 %t2, i32 %t1, i32 %x
  ret i32 %r
}

define i32 @t6_ugt_sgt_65536(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @t6_ugt_sgt_65536(
; CHECK-NEXT:    [[T0:%.*]] = icmp sgt i32 [[X:%.*]], 65535
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_HIGH:%.*]], i32 [[REPLACEMENT_LOW:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ugt i32 [[X]], 65535
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[T1]], i32 [[X]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp sgt i32 %x, 65535
  %t1 = select i1 %t0, i32 %replacement_high, i32 %replacement_low
  %t2 = icmp ugt i32 %x, 65535
  %r = select i1 %t2, i32 %t1, i32 %x
  ret i32 %r
}
define i32 @t7_ugt_sgt_neg1(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @t7_ugt_sgt_neg1(
; CHECK-NEXT:    [[T0:%.*]] = icmp sgt i32 [[X:%.*]], -1
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_HIGH:%.*]], i32 [[REPLACEMENT_LOW:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ugt i32 [[X]], 65535
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[T1]], i32 [[X]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp sgt i32 %x, -1
  %t1 = select i1 %t0, i32 %replacement_high, i32 %replacement_low
  %t2 = icmp ugt i32 %x, 65535
  %r = select i1 %t2, i32 %t1, i32 %x
  ret i32 %r
}

;-------------------------------------------------------------------------------

; So Ct0 can not be s> 65536, or s< 0

define i32 @n8_ult_slt_65537(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @n8_ult_slt_65537(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 65537
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 65537
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  %t2 = icmp ult i32 %x, 65536
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}
define i32 @n9_ult_slt_neg1(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @n9_ult_slt_neg1(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], -1
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, -1
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  %t2 = icmp ult i32 %x, 65536
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}

;-------------------------------------------------------------------------------

declare void @use32(i32)
declare void @use1(i1)

; One-use restrictions: here the entire pattern needs to be one-use.
; FIXME: if %t0 could be reused then it's less restrictive.

define i32 @n10_oneuse0(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @n10_oneuse0(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 32768
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    call void @use1(i1 [[T2]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 32768
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  %t2 = icmp ult i32 %x, 65536
  call void @use1(i1 %t2)
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}
define i32 @n11_oneuse1(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @n11_oneuse1(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 32768
; CHECK-NEXT:    call void @use1(i1 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 32768
  call void @use1(i1 %t0)
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  %t2 = icmp ult i32 %x, 65536
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}
define i32 @n12_oneuse2(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @n12_oneuse2(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 32768
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    call void @use32(i32 [[T1]])
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 32768
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  call void @use32(i32 %t1)
  %t2 = icmp ult i32 %x, 65536
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}

define i32 @n13_oneuse3(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @n13_oneuse3(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 32768
; CHECK-NEXT:    call void @use1(i1 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    call void @use1(i1 [[T2]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 32768
  call void @use1(i1 %t0)
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  %t2 = icmp ult i32 %x, 65536
  call void @use1(i1 %t2)
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}
define i32 @n14_oneuse4(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @n14_oneuse4(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 32768
; CHECK-NEXT:    call void @use1(i1 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    call void @use32(i32 [[T1]])
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 32768
  call void @use1(i1 %t0)
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  call void @use32(i32 %t1)
  %t2 = icmp ult i32 %x, 65536
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}
define i32 @n15_oneuse5(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @n15_oneuse5(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 32768
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    call void @use32(i32 [[T1]])
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    call void @use1(i1 [[T2]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 32768
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  call void @use32(i32 %t1)
  %t2 = icmp ult i32 %x, 65536
  call void @use1(i1 %t2)
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}

define i32 @n16_oneuse6(i32 %x, i32 %replacement_low, i32 %replacement_high) {
; CHECK-LABEL: @n16_oneuse6(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt i32 [[X:%.*]], 32768
; CHECK-NEXT:    call void @use1(i1 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = select i1 [[T0]], i32 [[REPLACEMENT_LOW:%.*]], i32 [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    call void @use32(i32 [[T1]])
; CHECK-NEXT:    [[T2:%.*]] = icmp ult i32 [[X]], 65536
; CHECK-NEXT:    call void @use1(i1 [[T2]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[T2]], i32 [[X]], i32 [[T1]]
; CHECK-NEXT:    ret i32 [[R]]
;
  %t0 = icmp slt i32 %x, 32768
  call void @use1(i1 %t0)
  %t1 = select i1 %t0, i32 %replacement_low, i32 %replacement_high
  call void @use32(i32 %t1)
  %t2 = icmp ult i32 %x, 65536
  call void @use1(i1 %t2)
  %r = select i1 %t2, i32 %x, i32 %t1
  ret i32 %r
}

;-------------------------------------------------------------------------------

; Vectors

define <2 x i32> @t17_ult_slt_vec_splat(<2 x i32> %x, <2 x i32> %replacement_low, <2 x i32> %replacement_high) {
; CHECK-LABEL: @t17_ult_slt_vec_splat(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt <2 x i32> [[X:%.*]], <i32 65536, i32 65536>
; CHECK-NEXT:    [[T1:%.*]] = select <2 x i1> [[T0]], <2 x i32> [[REPLACEMENT_LOW:%.*]], <2 x i32> [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult <2 x i32> [[X]], <i32 65536, i32 65536>
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[T2]], <2 x i32> [[X]], <2 x i32> [[T1]]
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %t0 = icmp slt <2 x i32> %x, <i32 65536, i32 65536>
  %t1 = select <2 x i1> %t0, <2 x i32> %replacement_low, <2 x i32> %replacement_high
  %t2 = icmp ult <2 x i32> %x, <i32 65536, i32 65536>
  %r = select <2 x i1> %t2, <2 x i32> %x, <2 x i32> %t1
  ret <2 x i32> %r
}
define <2 x i32> @t18_ult_slt_vec_nonsplat(<2 x i32> %x, <2 x i32> %replacement_low, <2 x i32> %replacement_high) {
; CHECK-LABEL: @t18_ult_slt_vec_nonsplat(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt <2 x i32> [[X:%.*]], <i32 65536, i32 32768>
; CHECK-NEXT:    [[T1:%.*]] = select <2 x i1> [[T0]], <2 x i32> [[REPLACEMENT_LOW:%.*]], <2 x i32> [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult <2 x i32> [[X]], <i32 65536, i32 32768>
; CHECK-NEXT:    [[R:%.*]] = select <2 x i1> [[T2]], <2 x i32> [[X]], <2 x i32> [[T1]]
; CHECK-NEXT:    ret <2 x i32> [[R]]
;
  %t0 = icmp slt <2 x i32> %x, <i32 65536, i32 32768>
  %t1 = select <2 x i1> %t0, <2 x i32> %replacement_low, <2 x i32> %replacement_high
  %t2 = icmp ult <2 x i32> %x, <i32 65536, i32 32768>
  %r = select <2 x i1> %t2, <2 x i32> %x, <2 x i32> %t1
  ret <2 x i32> %r
}

define <3 x i32> @t19_ult_slt_vec_undef0(<3 x i32> %x, <3 x i32> %replacement_low, <3 x i32> %replacement_high) {
; CHECK-LABEL: @t19_ult_slt_vec_undef0(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt <3 x i32> [[X:%.*]], <i32 65536, i32 undef, i32 65536>
; CHECK-NEXT:    [[T1:%.*]] = select <3 x i1> [[T0]], <3 x i32> [[REPLACEMENT_LOW:%.*]], <3 x i32> [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult <3 x i32> [[X]], <i32 65536, i32 65536, i32 65536>
; CHECK-NEXT:    [[R:%.*]] = select <3 x i1> [[T2]], <3 x i32> [[X]], <3 x i32> [[T1]]
; CHECK-NEXT:    ret <3 x i32> [[R]]
;
  %t0 = icmp slt <3 x i32> %x, <i32 65536, i32 undef, i32 65536>
  %t1 = select <3 x i1> %t0, <3 x i32> %replacement_low, <3 x i32> %replacement_high
  %t2 = icmp ult <3 x i32> %x, <i32 65536, i32 65536, i32 65536>
  %r = select <3 x i1> %t2, <3 x i32> %x, <3 x i32> %t1
  ret <3 x i32> %r
}
define <3 x i32> @t20_ult_slt_vec_undef1(<3 x i32> %x, <3 x i32> %replacement_low, <3 x i32> %replacement_high) {
; CHECK-LABEL: @t20_ult_slt_vec_undef1(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt <3 x i32> [[X:%.*]], <i32 65536, i32 65537, i32 65536>
; CHECK-NEXT:    [[T1:%.*]] = select <3 x i1> [[T0]], <3 x i32> [[REPLACEMENT_LOW:%.*]], <3 x i32> [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult <3 x i32> [[X]], <i32 65536, i32 undef, i32 65536>
; CHECK-NEXT:    [[R:%.*]] = select <3 x i1> [[T2]], <3 x i32> [[X]], <3 x i32> [[T1]]
; CHECK-NEXT:    ret <3 x i32> [[R]]
;
  %t0 = icmp slt <3 x i32> %x, <i32 65536, i32 65537, i32 65536>
  %t1 = select <3 x i1> %t0, <3 x i32> %replacement_low, <3 x i32> %replacement_high
  %t2 = icmp ult <3 x i32> %x, <i32 65536, i32 undef, i32 65536>
  %r = select <3 x i1> %t2, <3 x i32> %x, <3 x i32> %t1
  ret <3 x i32> %r
}
define <3 x i32> @t21_ult_slt_vec_undef2(<3 x i32> %x, <3 x i32> %replacement_low, <3 x i32> %replacement_high) {
; CHECK-LABEL: @t21_ult_slt_vec_undef2(
; CHECK-NEXT:    [[T0:%.*]] = icmp slt <3 x i32> [[X:%.*]], <i32 65536, i32 undef, i32 65536>
; CHECK-NEXT:    [[T1:%.*]] = select <3 x i1> [[T0]], <3 x i32> [[REPLACEMENT_LOW:%.*]], <3 x i32> [[REPLACEMENT_HIGH:%.*]]
; CHECK-NEXT:    [[T2:%.*]] = icmp ult <3 x i32> [[X]], <i32 65536, i32 undef, i32 65536>
; CHECK-NEXT:    [[R:%.*]] = select <3 x i1> [[T2]], <3 x i32> [[X]], <3 x i32> [[T1]]
; CHECK-NEXT:    ret <3 x i32> [[R]]
;
  %t0 = icmp slt <3 x i32> %x, <i32 65536, i32 undef, i32 65536>
  %t1 = select <3 x i1> %t0, <3 x i32> %replacement_low, <3 x i32> %replacement_high
  %t2 = icmp ult <3 x i32> %x, <i32 65536, i32 undef, i32 65536>
  %r = select <3 x i1> %t2, <3 x i32> %x, <3 x i32> %t1
  ret <3 x i32> %r
}
