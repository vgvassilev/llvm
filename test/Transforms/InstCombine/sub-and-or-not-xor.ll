; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -instcombine -S < %s | FileCheck %s

declare void @use(i32)

define i32 @sub_to_xor(i32 %x, i32 %y) {
; CHECK-LABEL: @sub_to_xor(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 0, [[TMP1]]
; CHECK-NEXT:    ret i32 [[SUB]]
;
  %or = or i32 %x, %y
  %and = and i32 %x, %y
  %sub = sub i32 %and, %or
  ret i32 %sub
}

define i32 @sub_to_xor_extra_use_sub(i32 %x, i32 %y) {
; CHECK-LABEL: @sub_to_xor_extra_use_sub(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 0, [[TMP1]]
; CHECK-NEXT:    call void @use(i32 [[SUB]])
; CHECK-NEXT:    ret i32 [[SUB]]
;
  %or = or i32 %x, %y
  %and = and i32 %x, %y
  %sub = sub i32 %and, %or
  call void @use(i32 %sub)
  ret i32 %sub
}

define i32 @sub_to_xor_extra_use_and(i32 %x, i32 %y) {
; CHECK-LABEL: @sub_to_xor_extra_use_and(
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    call void @use(i32 [[AND]])
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[X]], [[Y]]
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 0, [[TMP1]]
; CHECK-NEXT:    ret i32 [[SUB]]
;
  %or = or i32 %x, %y
  %and = and i32 %x, %y
  call void @use(i32 %and)
  %sub = sub i32 %and, %or
  ret i32 %sub
}

define i32 @sub_to_xor_extra_use_or(i32 %x, i32 %y) {
; CHECK-LABEL: @sub_to_xor_extra_use_or(
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    call void @use(i32 [[OR]])
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[X]], [[Y]]
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 0, [[TMP1]]
; CHECK-NEXT:    ret i32 [[SUB]]
;
  %or = or i32 %x, %y
  call void @use(i32 %or)
  %and = and i32 %x, %y
  %sub = sub i32 %and, %or
  ret i32 %sub
}

define i32 @sub_to_xor_or_commuted(i32 %x, i32 %y) {
; CHECK-LABEL: @sub_to_xor_or_commuted(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 0, [[TMP1]]
; CHECK-NEXT:    ret i32 [[SUB]]
;
  %or = or i32 %y, %x
  %and = and i32 %x, %y
  %sub = sub i32 %and, %or
  ret i32 %sub
}

define i32 @sub_to_xor_and_commuted(i32 %x, i32 %y) {
; CHECK-LABEL: @sub_to_xor_and_commuted(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i32 [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 0, [[TMP1]]
; CHECK-NEXT:    ret i32 [[SUB]]
;
  %or = or i32 %x, %y
  %and = and i32 %y, %x
  %sub = sub i32 %and, %or
  ret i32 %sub
}

define <2 x i32> @sub_to_xor_vec(<2 x i32> %x, <2 x i32> %y) {
; CHECK-LABEL: @sub_to_xor_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = xor <2 x i32> [[Y:%.*]], [[X:%.*]]
; CHECK-NEXT:    [[SUB:%.*]] = sub <2 x i32> zeroinitializer, [[TMP1]]
; CHECK-NEXT:    ret <2 x i32> [[SUB]]
;
  %or = or <2 x i32> %x, %y
  %and = and <2 x i32> %y, %x
  %sub = sub <2 x i32> %and, %or
  ret <2 x i32> %sub
}

; Negative tests

define i32 @sub_to_xor_extra_use_and_or(i32 %x, i32 %y) {
; CHECK-LABEL: @sub_to_xor_extra_use_and_or(
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    call void @use(i32 [[OR]])
; CHECK-NEXT:    [[AND:%.*]] = and i32 [[X]], [[Y]]
; CHECK-NEXT:    call void @use(i32 [[AND]])
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 [[AND]], [[OR]]
; CHECK-NEXT:    ret i32 [[SUB]]
;
  %or = or i32 %x, %y
  call void @use(i32 %or)
  %and = and i32 %x, %y
  call void @use(i32 %and)
  %sub = sub i32 %and, %or
  ret i32 %sub
}
