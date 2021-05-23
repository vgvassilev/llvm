; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

declare void @v4float_user(<4 x float>) #0

define float @extract_one_select(<4 x float> %a, <4 x float> %b, i32 %c) #0 {
; CHECK-LABEL: @extract_one_select(
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_NOT]], <4 x float> [[B:%.*]], <4 x float> [[A:%.*]]
; CHECK-NEXT:    [[EXTRACT:%.*]] = extractelement <4 x float> [[SEL]], i32 2
; CHECK-NEXT:    ret float [[EXTRACT]]
;
  %cmp = icmp ne i32 %c, 0
  %sel = select i1 %cmp, <4 x float> %a, <4 x float> %b
  %extract = extractelement <4 x float> %sel, i32 2
  ret float %extract
}

; Multiple extractelements
define <2 x float> @extract_two_select(<4 x float> %a, <4 x float> %b, i32 %c) #0 {
; CHECK-LABEL: @extract_two_select(
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_NOT]], <4 x float> [[B:%.*]], <4 x float> [[A:%.*]]
; CHECK-NEXT:    [[BUILD2:%.*]] = shufflevector <4 x float> [[SEL]], <4 x float> undef, <2 x i32> <i32 1, i32 2>
; CHECK-NEXT:    ret <2 x float> [[BUILD2]]
;
  %cmp = icmp ne i32 %c, 0
  %sel = select i1 %cmp, <4 x float> %a, <4 x float> %b
  %extract1 = extractelement <4 x float> %sel, i32 1
  %extract2 = extractelement <4 x float> %sel, i32 2
  %build1 = insertelement <2 x float> poison, float %extract1, i32 0
  %build2 = insertelement <2 x float> %build1, float %extract2, i32 1
  ret <2 x float> %build2
}

; Select has an extra non-extractelement user, don't change it
define float @extract_one_select_user(<4 x float> %a, <4 x float> %b, i32 %c) #0 {
; CHECK-LABEL: @extract_one_select_user(
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CMP_NOT]], <4 x float> [[B:%.*]], <4 x float> [[A:%.*]]
; CHECK-NEXT:    [[EXTRACT:%.*]] = extractelement <4 x float> [[SEL]], i32 2
; CHECK-NEXT:    call void @v4float_user(<4 x float> [[SEL]])
; CHECK-NEXT:    ret float [[EXTRACT]]
;
  %cmp = icmp ne i32 %c, 0
  %sel = select i1 %cmp, <4 x float> %a, <4 x float> %b
  %extract = extractelement <4 x float> %sel, i32 2
  call void @v4float_user(<4 x float> %sel)
  ret float %extract
}

define float @extract_one_vselect_user(<4 x float> %a, <4 x float> %b, <4 x i32> %c) #0 {
; CHECK-LABEL: @extract_one_vselect_user(
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq <4 x i32> [[C:%.*]], zeroinitializer
; CHECK-NEXT:    [[SEL:%.*]] = select <4 x i1> [[CMP_NOT]], <4 x float> [[B:%.*]], <4 x float> [[A:%.*]]
; CHECK-NEXT:    [[EXTRACT:%.*]] = extractelement <4 x float> [[SEL]], i32 2
; CHECK-NEXT:    call void @v4float_user(<4 x float> [[SEL]])
; CHECK-NEXT:    ret float [[EXTRACT]]
;
  %cmp = icmp ne <4 x i32> %c, zeroinitializer
  %sel = select <4 x i1> %cmp, <4 x float> %a, <4 x float> %b
  %extract = extractelement <4 x float> %sel, i32 2
  call void @v4float_user(<4 x float> %sel)
  ret float %extract
}

; Do not convert the vector select into a scalar select. That would increase
; the instruction count and potentially obfuscate a vector min/max idiom.

define float @extract_one_vselect(<4 x float> %a, <4 x float> %b, <4 x i32> %c) #0 {
; CHECK-LABEL: @extract_one_vselect(
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq <4 x i32> [[C:%.*]], zeroinitializer
; CHECK-NEXT:    [[SELECT:%.*]] = select <4 x i1> [[CMP_NOT]], <4 x float> [[B:%.*]], <4 x float> [[A:%.*]]
; CHECK-NEXT:    [[EXTRACT:%.*]] = extractelement <4 x float> [[SELECT]], i32 0
; CHECK-NEXT:    ret float [[EXTRACT]]
;
  %cmp = icmp ne <4 x i32> %c, zeroinitializer
  %select = select <4 x i1> %cmp, <4 x float> %a, <4 x float> %b
  %extract = extractelement <4 x float> %select, i32 0
  ret float %extract
}

; Multiple extractelements from a vector select
define <2 x float> @extract_two_vselect(<4 x float> %a, <4 x float> %b, <4 x i32> %c) #0 {
; CHECK-LABEL: @extract_two_vselect(
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq <4 x i32> [[C:%.*]], zeroinitializer
; CHECK-NEXT:    [[SEL:%.*]] = select <4 x i1> [[CMP_NOT]], <4 x float> [[B:%.*]], <4 x float> [[A:%.*]]
; CHECK-NEXT:    [[BUILD2:%.*]] = shufflevector <4 x float> [[SEL]], <4 x float> undef, <2 x i32> <i32 1, i32 2>
; CHECK-NEXT:    ret <2 x float> [[BUILD2]]
;
  %cmp = icmp ne <4 x i32> %c, zeroinitializer
  %sel = select <4 x i1> %cmp, <4 x float> %a, <4 x float> %b
  %extract1 = extractelement <4 x float> %sel, i32 1
  %extract2 = extractelement <4 x float> %sel, i32 2
  %build1 = insertelement <2 x float> poison, float %extract1, i32 0
  %build2 = insertelement <2 x float> %build1, float %extract2, i32 1
  ret <2 x float> %build2
}

; The vector selects are not decomposed into scalar selects because that would increase
; the instruction count. Extract+insert is converted to non-lane-crossing shuffles.
; Test multiple extractelements
define <4 x float> @simple_vector_select(<4 x float> %a, <4 x float> %b, <4 x i32> %c) #0 {
; CHECK-LABEL: @simple_vector_select(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <4 x i32> [[C:%.*]], i32 0
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i32 [[TMP0]], 0
; CHECK-NEXT:    [[A_SINK:%.*]] = select i1 [[TOBOOL_NOT]], <4 x float> [[B:%.*]], <4 x float> [[A:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <4 x i32> [[C]], i32 1
; CHECK-NEXT:    [[TOBOOL1_NOT:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    [[A_SINK1:%.*]] = select i1 [[TOBOOL1_NOT]], <4 x float> [[B]], <4 x float> [[A]]
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x float> [[A_SINK]], <4 x float> [[A_SINK1]], <4 x i32> <i32 0, i32 5, i32 undef, i32 undef>
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x i32> [[C]], i32 2
; CHECK-NEXT:    [[TOBOOL6_NOT:%.*]] = icmp eq i32 [[TMP3]], 0
; CHECK-NEXT:    [[A_SINK2:%.*]] = select i1 [[TOBOOL6_NOT]], <4 x float> [[B]], <4 x float> [[A]]
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <4 x float> [[TMP2]], <4 x float> [[A_SINK2]], <4 x i32> <i32 0, i32 1, i32 6, i32 undef>
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <4 x i32> [[C]], i32 3
; CHECK-NEXT:    [[TOBOOL11_NOT:%.*]] = icmp eq i32 [[TMP5]], 0
; CHECK-NEXT:    [[A_SINK3:%.*]] = select i1 [[TOBOOL11_NOT]], <4 x float> [[B]], <4 x float> [[A]]
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <4 x float> [[TMP4]], <4 x float> [[A_SINK3]], <4 x i32> <i32 0, i32 1, i32 2, i32 7>
; CHECK-NEXT:    ret <4 x float> [[TMP6]]
;
entry:
  %0 = extractelement <4 x i32> %c, i32 0
  %tobool = icmp ne i32 %0, 0
  %a.sink = select i1 %tobool, <4 x float> %a, <4 x float> %b
  %1 = extractelement <4 x float> %a.sink, i32 0
  %2 = insertelement <4 x float> poison, float %1, i32 0
  %3 = extractelement <4 x i32> %c, i32 1
  %tobool1 = icmp ne i32 %3, 0
  %a.sink1 = select i1 %tobool1, <4 x float> %a, <4 x float> %b
  %4 = extractelement <4 x float> %a.sink1, i32 1
  %5 = insertelement <4 x float> %2, float %4, i32 1
  %6 = extractelement <4 x i32> %c, i32 2
  %tobool6 = icmp ne i32 %6, 0
  %a.sink2 = select i1 %tobool6, <4 x float> %a, <4 x float> %b
  %7 = extractelement <4 x float> %a.sink2, i32 2
  %8 = insertelement <4 x float> %5, float %7, i32 2
  %9 = extractelement <4 x i32> %c, i32 3
  %tobool11 = icmp ne i32 %9, 0
  %a.sink3 = select i1 %tobool11, <4 x float> %a, <4 x float> %b
  %10 = extractelement <4 x float> %a.sink3, i32 3
  %11 = insertelement <4 x float> %8, float %10, i32 3
  ret <4 x float> %11
}

define <4 x i32> @extract_cond(<4 x i32> %x, <4 x i32> %y, <4 x i1> %condv) {
; CHECK-LABEL: @extract_cond(
; CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <4 x i1> [[CONDV:%.*]], <4 x i1> undef, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
; CHECK-NEXT:    [[R:%.*]] = select <4 x i1> [[DOTSPLAT]], <4 x i32> [[X:%.*]], <4 x i32> [[Y:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %cond = extractelement <4 x i1> %condv, i32 3
  %r = select i1 %cond, <4 x i32> %x, <4 x i32> %y
  ret <4 x i32> %r
}

define <4 x i32> @splat_cond(<4 x i32> %x, <4 x i32> %y, <4 x i1> %condv) {
; CHECK-LABEL: @splat_cond(
; CHECK-NEXT:    [[SPLATCOND:%.*]] = shufflevector <4 x i1> [[CONDV:%.*]], <4 x i1> poison, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
; CHECK-NEXT:    [[R:%.*]] = select <4 x i1> [[SPLATCOND]], <4 x i32> [[X:%.*]], <4 x i32> [[Y:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %splatcond = shufflevector <4 x i1> %condv, <4 x i1> poison, <4 x i32> <i32 3, i32 3, i32 3, i32 3>
  %r = select <4 x i1> %splatcond, <4 x i32> %x, <4 x i32> %y
  ret <4 x i32> %r
}

declare void @extra_use(i1)

; Negative test

define <4 x i32> @extract_cond_extra_use(<4 x i32> %x, <4 x i32> %y, <4 x i1> %condv) {
; CHECK-LABEL: @extract_cond_extra_use(
; CHECK-NEXT:    [[COND:%.*]] = extractelement <4 x i1> [[CONDV:%.*]], i32 3
; CHECK-NEXT:    call void @extra_use(i1 [[COND]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[COND]], <4 x i32> [[X:%.*]], <4 x i32> [[Y:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %cond = extractelement <4 x i1> %condv, i32 3
  call void @extra_use(i1 %cond)
  %r = select i1 %cond, <4 x i32> %x, <4 x i32> %y
  ret <4 x i32> %r
}

; Negative test

define <4 x i32> @extract_cond_variable_index(<4 x i32> %x, <4 x i32> %y, <4 x i1> %condv, i32 %index) {
; CHECK-LABEL: @extract_cond_variable_index(
; CHECK-NEXT:    [[COND:%.*]] = extractelement <4 x i1> [[CONDV:%.*]], i32 [[INDEX:%.*]]
; CHECK-NEXT:    [[R:%.*]] = select i1 [[COND]], <4 x i32> [[X:%.*]], <4 x i32> [[Y:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %cond = extractelement <4 x i1> %condv, i32 %index
  %r = select i1 %cond, <4 x i32> %x, <4 x i32> %y
  ret <4 x i32> %r
}

; IR shuffle can alter the number of elements in the vector, so this is ok.

define <4 x i32> @extract_cond_type_mismatch(<4 x i32> %x, <4 x i32> %y, <5 x i1> %condv) {
; CHECK-LABEL: @extract_cond_type_mismatch(
; CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <5 x i1> [[CONDV:%.*]], <5 x i1> undef, <4 x i32> <i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    [[R:%.*]] = select <4 x i1> [[DOTSPLAT]], <4 x i32> [[X:%.*]], <4 x i32> [[Y:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[R]]
;
  %cond = extractelement <5 x i1> %condv, i32 1
  %r = select i1 %cond, <4 x i32> %x, <4 x i32> %y
  ret <4 x i32> %r
}


attributes #0 = { nounwind ssp uwtable "frame-pointer"="all" "stack-protector-buffer-size"="8" "use-soft-float"="false" }
