; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -instcombine -S < %s | FileCheck %s

declare void @use(i32)

declare i32 @llvm.ctlz.i32(i32, i1)
declare <3 x i17> @llvm.ctlz.v3i17(<3 x i17>, i1)

declare i32 @llvm.cttz.i32(i32, i1)
declare <3 x i5> @llvm.cttz.v3i5(<3 x i5>, i1)

declare i32 @llvm.ctpop.i32(i32)
declare <3 x i7> @llvm.ctpop.v3i7(<3 x i7>)

define i32 @ctlz_sel_const_true_false(i1 %b) {
; CHECK-LABEL: @ctlz_sel_const_true_false(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 5, i32 -7
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.ctlz.i32(i32 [[S]], i1 true), !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 -7
  %c = call i32 @llvm.ctlz.i32(i32 %s, i1 true)
  ret i32 %c
}

define i32 @ctlz_sel_const_true(i1 %b, i32 %x) {
; CHECK-LABEL: @ctlz_sel_const_true(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 5, i32 [[X:%.*]]
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.ctlz.i32(i32 [[S]], i1 false), !range [[RNG1:![0-9]+]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 %x
  %c = call i32 @llvm.ctlz.i32(i32 %s, i1 false)
  ret i32 %c
}

define <3 x i17> @ctlz_sel_const_false(<3 x i1> %b, <3 x i17> %x) {
; CHECK-LABEL: @ctlz_sel_const_false(
; CHECK-NEXT:    [[S:%.*]] = select <3 x i1> [[B:%.*]], <3 x i17> [[X:%.*]], <3 x i17> <i17 7, i17 -1, i17 0>
; CHECK-NEXT:    [[C:%.*]] = call <3 x i17> @llvm.ctlz.v3i17(<3 x i17> [[S]], i1 true)
; CHECK-NEXT:    ret <3 x i17> [[C]]
;
  %s = select <3 x i1> %b, <3 x i17> %x, <3 x i17> <i17 7, i17 -1, i17 0>
  %c = call <3 x i17> @llvm.ctlz.v3i17(<3 x i17> %s, i1 true)
  ret <3 x i17> %c
}

define i32 @ctlz_sel_const_true_false_extra_use(i1 %b) {
; CHECK-LABEL: @ctlz_sel_const_true_false_extra_use(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 -1, i32 7
; CHECK-NEXT:    call void @use(i32 [[S]])
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.ctlz.i32(i32 [[S]], i1 true), !range [[RNG2:![0-9]+]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 -1, i32 7
  call void @use(i32 %s)
  %c = call i32 @llvm.ctlz.i32(i32 %s, i1 false)
  ret i32 %c
}

define i32 @cttz_sel_const_true_false(i1 %b) {
; CHECK-LABEL: @cttz_sel_const_true_false(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 4, i32 -7
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.cttz.i32(i32 [[S]], i1 true), !range [[RNG1]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 4, i32 -7
  %c = call i32 @llvm.cttz.i32(i32 %s, i1 false)
  ret i32 %c
}

define i32 @cttz_sel_const_true(i1 %b, i32 %x) {
; CHECK-LABEL: @cttz_sel_const_true(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 5, i32 [[X:%.*]]
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.cttz.i32(i32 [[S]], i1 true), !range [[RNG1]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 %x
  %c = call i32 @llvm.cttz.i32(i32 %s, i1 true)
  ret i32 %c
}

define <3 x i5> @cttz_sel_const_false(<3 x i1> %b, <3 x i5> %x) {
; CHECK-LABEL: @cttz_sel_const_false(
; CHECK-NEXT:    [[S:%.*]] = select <3 x i1> [[B:%.*]], <3 x i5> [[X:%.*]], <3 x i5> <i5 7, i5 -1, i5 0>
; CHECK-NEXT:    [[C:%.*]] = call <3 x i5> @llvm.cttz.v3i5(<3 x i5> [[S]], i1 false)
; CHECK-NEXT:    ret <3 x i5> [[C]]
;
  %s = select <3 x i1> %b, <3 x i5> %x, <3 x i5> <i5 7, i5 -1, i5 0>
  %c = call <3 x i5> @llvm.cttz.v3i5(<3 x i5> %s, i1 false)
  ret <3 x i5> %c
}

define i32 @cttz_sel_const_true_false_extra_use(i1 %b) {
; CHECK-LABEL: @cttz_sel_const_true_false_extra_use(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 5, i32 -8
; CHECK-NEXT:    call void @use(i32 [[S]])
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.cttz.i32(i32 [[S]], i1 true), !range [[RNG1]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 -8
  call void @use(i32 %s)
  %c = call i32 @llvm.cttz.i32(i32 %s, i1 true)
  ret i32 %c
}

define i32 @ctpop_sel_const_true_false(i1 %b) {
; CHECK-LABEL: @ctpop_sel_const_true_false(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 5, i32 -7
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.ctpop.i32(i32 [[S]]), !range [[RNG3:![0-9]+]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 -7
  %c = call i32 @llvm.ctpop.i32(i32 %s)
  ret i32 %c
}

define i32 @ctpop_sel_const_true(i1 %b, i32 %x) {
; CHECK-LABEL: @ctpop_sel_const_true(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 5, i32 [[X:%.*]]
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.ctpop.i32(i32 [[S]]), !range [[RNG1]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 %x
  %c = call i32 @llvm.ctpop.i32(i32 %s)
  ret i32 %c
}

define <3 x i7> @ctpop_sel_const_false(<3 x i1> %b, <3 x i7> %x) {
; CHECK-LABEL: @ctpop_sel_const_false(
; CHECK-NEXT:    [[S:%.*]] = select <3 x i1> [[B:%.*]], <3 x i7> [[X:%.*]], <3 x i7> <i7 7, i7 -1, i7 0>
; CHECK-NEXT:    [[C:%.*]] = call <3 x i7> @llvm.ctpop.v3i7(<3 x i7> [[S]])
; CHECK-NEXT:    ret <3 x i7> [[C]]
;
  %s = select <3 x i1> %b, <3 x i7> %x, <3 x i7> <i7 7, i7 -1, i7 0>
  %c = call <3 x i7> @llvm.ctpop.v3i7(<3 x i7> %s)
  ret <3 x i7> %c
}

define i32 @ctpop_sel_const_true_false_extra_use(i1 %b) {
; CHECK-LABEL: @ctpop_sel_const_true_false_extra_use(
; CHECK-NEXT:    [[S:%.*]] = select i1 [[B:%.*]], i32 5, i32 7
; CHECK-NEXT:    call void @use(i32 [[S]])
; CHECK-NEXT:    [[C:%.*]] = call i32 @llvm.ctpop.i32(i32 [[S]]), !range [[RNG4:![0-9]+]]
; CHECK-NEXT:    ret i32 [[C]]
;
  %s = select i1 %b, i32 5, i32 7
  call void @use(i32 %s)
  %c = call i32 @llvm.ctpop.i32(i32 %s)
  ret i32 %c
}
