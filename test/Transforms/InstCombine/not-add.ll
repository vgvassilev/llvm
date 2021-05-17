; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -instcombine -S < %s | FileCheck %s

declare void @use(i8)

define i8 @basic(i8 %x, i8 %y) {
; CHECK-LABEL: @basic(
; CHECK-NEXT:    [[NOTA:%.*]] = sub i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i8 [[NOTA]]
;
  %notx = xor i8 %x, -1
  %a = add i8 %notx, %y
  %nota = xor i8 %a, -1
  ret i8 %nota
}

define i8 @basic_com_add(i8 %x, i8 %y) {
; CHECK-LABEL: @basic_com_add(
; CHECK-NEXT:    [[NOTA:%.*]] = sub i8 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    ret i8 [[NOTA]]
;
  %noty = xor i8 %y, -1
  %a = add i8 %x, %noty
  %nota = xor i8 %a, -1
  ret i8 %nota
}

define i8 @basic_use_xor(i8 %x, i8 %y) {
; CHECK-LABEL: @basic_use_xor(
; CHECK-NEXT:    [[NOTX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use(i8 [[NOTX]])
; CHECK-NEXT:    [[NOTA:%.*]] = sub i8 [[X]], [[Y:%.*]]
; CHECK-NEXT:    ret i8 [[NOTA]]
;
  %notx = xor i8 %x, -1
  call void @use(i8 %notx)
  %a = add i8 %notx, %y
  %nota = xor i8 %a, -1
  ret i8 %nota
}

define i8 @basic_use_add(i8 %x, i8 %y) {
; CHECK-LABEL: @basic_use_add(
; CHECK-NEXT:    [[NOTX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[A:%.*]] = add i8 [[NOTX]], [[Y:%.*]]
; CHECK-NEXT:    call void @use(i8 [[A]])
; CHECK-NEXT:    [[NOTA:%.*]] = sub i8 [[X]], [[Y]]
; CHECK-NEXT:    ret i8 [[NOTA]]
;
  %notx = xor i8 %x, -1
  %a = add i8 %notx, %y
  call void @use(i8 %a)
  %nota = xor i8 %a, -1
  ret i8 %nota
}

define i8 @basic_use_both(i8 %x, i8 %y) {
; CHECK-LABEL: @basic_use_both(
; CHECK-NEXT:    [[NOTX:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    call void @use(i8 [[NOTX]])
; CHECK-NEXT:    [[A:%.*]] = add i8 [[NOTX]], [[Y:%.*]]
; CHECK-NEXT:    call void @use(i8 [[A]])
; CHECK-NEXT:    [[NOTA:%.*]] = sub i8 [[X]], [[Y]]
; CHECK-NEXT:    ret i8 [[NOTA]]
;
  %notx = xor i8 %x, -1
  call void @use(i8 %notx)
  %a = add i8 %notx, %y
  call void @use(i8 %a)
  %nota = xor i8 %a, -1
  ret i8 %nota
}

define i8 @basic_preserve_nsw(i8 %x, i8 %y) {
; CHECK-LABEL: @basic_preserve_nsw(
; CHECK-NEXT:    [[NOTA:%.*]] = sub nsw i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i8 [[NOTA]]
;
  %notx = xor i8 %x, -1
  %a = add nsw i8 %notx, %y
  %nota = xor i8 %a, -1
  ret i8 %nota
}

define i8 @basic_preserve_nuw(i8 %x, i8 %y) {
; CHECK-LABEL: @basic_preserve_nuw(
; CHECK-NEXT:    [[NOTA:%.*]] = sub nuw i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i8 [[NOTA]]
;
  %notx = xor i8 %x, -1
  %a = add nuw i8 %notx, %y
  %nota = xor i8 %a, -1
  ret i8 %nota
}

define i8 @basic_preserve_nuw_nsw(i8 %x, i8 %y) {
; CHECK-LABEL: @basic_preserve_nuw_nsw(
; CHECK-NEXT:    [[NOTA:%.*]] = sub nuw nsw i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i8 [[NOTA]]
;
  %notx = xor i8 %x, -1
  %a = add nuw nsw i8 %notx, %y
  %nota = xor i8 %a, -1
  ret i8 %nota
}

define <4 x i32> @vector_test(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @vector_test(
; CHECK-NEXT:    [[NOTA:%.*]] = sub <4 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[NOTA]]
;
  %notx = xor <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  %a = add <4 x i32> %notx, %y
  %nota = xor <4 x i32> %a, <i32 -1, i32 -1, i32 -1, i32 -1>
  ret <4 x i32> %nota
}

define <4 x i32> @vector_test_undef(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @vector_test_undef(
; CHECK-NEXT:    [[NOTA:%.*]] = sub <4 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[NOTA]]
;
  %notx = xor <4 x i32> %x, <i32 -1, i32 undef, i32 undef, i32 -1>
  %a = add <4 x i32> %notx, %y
  %nota = xor <4 x i32> %a, <i32 -1, i32 -1, i32 undef, i32 undef>
  ret <4 x i32> %nota
}


define <4 x i32> @vector_test_undef_nsw_nuw(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @vector_test_undef_nsw_nuw(
; CHECK-NEXT:    [[NOTA:%.*]] = sub nuw nsw <4 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[NOTA]]
;
  %notx = xor <4 x i32> %x, <i32 -1, i32 undef, i32 undef, i32 -1>
  %a = add nsw nuw <4 x i32> %notx, %y
  %nota = xor <4 x i32> %a, <i32 -1, i32 -1, i32 undef, i32 undef>
  ret <4 x i32> %nota
}

define i32 @pr50308(i1 %c1, i32 %v1, i32 %v2, i32 %v3) {
; CHECK-LABEL: @pr50308(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[COND_TRUE:%.*]], label [[COND_END:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[ADD_NOT:%.*]] = sub i32 -2, [[V1:%.*]]
; CHECK-NEXT:    [[ADD1_NEG:%.*]] = xor i32 [[ADD_NOT]], [[V2:%.*]]
; CHECK-NEXT:    br label [[COND_END]]
; CHECK:       cond.end:
; CHECK-NEXT:    [[COND_NEG:%.*]] = phi i32 [ [[ADD1_NEG]], [[COND_TRUE]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[SUB:%.*]] = add i32 [[COND_NEG]], [[V3:%.*]]
; CHECK-NEXT:    ret i32 [[SUB]]
;
entry:
  br i1 %c1, label %cond.true, label %cond.end

cond.true:
  %add = add nsw i32 1, %v1
  %xor = xor i32 %add, %v2
  %add1 = add nsw i32 1, %xor
  br label %cond.end

cond.end:
  %cond = phi i32 [ %add1, %cond.true ], [ 0, %entry ]
  %sub = sub nsw i32 %v3, %cond
  ret i32 %sub
}

@g = extern_weak global i32
define void @pr50370(i32 %x) {
; CHECK-LABEL: @pr50370(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[X:%.*]], 1
; CHECK-NEXT:    [[B15:%.*]] = srem i32 ashr (i32 65536, i32 or (i32 zext (i1 icmp eq (i32* @g, i32* null) to i32), i32 65537)), [[XOR]]
; CHECK-NEXT:    [[B22:%.*]] = add nsw i32 [[B15]], sdiv (i32 or (i32 zext (i1 icmp eq (i32* @g, i32* null) to i32), i32 65537), i32 2147483647)
; CHECK-NEXT:    [[B14:%.*]] = srem i32 ashr (i32 65536, i32 or (i32 zext (i1 icmp eq (i32* @g, i32* null) to i32), i32 65537)), [[B22]]
; CHECK-NEXT:    [[B12:%.*]] = add nuw nsw i32 [[B15]], ashr (i32 65536, i32 or (i32 zext (i1 icmp eq (i32* @g, i32* null) to i32), i32 65537))
; CHECK-NEXT:    [[B8:%.*]] = shl i32 sdiv (i32 or (i32 zext (i1 icmp eq (i32* @g, i32* null) to i32), i32 65537), i32 2147483647), [[B14]]
; CHECK-NEXT:    [[B2:%.*]] = xor i32 [[B12]], [[B8]]
; CHECK-NEXT:    [[B:%.*]] = xor i32 [[B2]], -1
; CHECK-NEXT:    store i32 [[B]], i32* undef, align 4
; CHECK-NEXT:    ret void
;
entry:
  %xor = xor i32 %x, 1
  %or4 = or i32 or (i32 zext (i1 icmp eq (i32* @g, i32* null) to i32), i32 1), 65536
  %B6 = ashr i32 65536, %or4
  %B15 = srem i32 %B6, %xor
  %B20 = sdiv i32 %or4, 2147483647
  %B22 = add i32 %B15, %B20
  %B14 = srem i32 %B6, %B22
  %B12 = add i32 %B15, %B6
  %B8 = shl i32 %B20, %B14
  %B2 = xor i32 %B12, %B8
  %B3 = or i32 %B12, undef
  %B = xor i32 %B2, %B3
  store i32 %B, i32* undef, align 4
  ret void
}
