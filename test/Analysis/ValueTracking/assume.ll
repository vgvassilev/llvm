; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

define i32 @assume_add(i32 %a, i32 %b) {
; CHECK-LABEL: @assume_add(
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[LAST_TWO_DIGITS:%.*]] = and i32 [[T1]], 3
; CHECK-NEXT:    [[T2:%.*]] = icmp eq i32 [[LAST_TWO_DIGITS]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[T2]])
; CHECK-NEXT:    [[T3:%.*]] = or i32 [[T1]], 3
; CHECK-NEXT:    ret i32 [[T3]]
;
  %t1 = add i32 %a, %b
  %last_two_digits = and i32 %t1, 3
  %t2 = icmp eq i32 %last_two_digits, 0
  call void @llvm.assume(i1 %t2)
  %t3 = add i32 %t1, 3
  ret i32 %t3
}


define void @assume_not() {
; CHECK-LABEL: @assume_not(
; CHECK-NEXT:  entry-block:
; CHECK-NEXT:    [[TMP0:%.*]] = call i1 @get_val()
; CHECK-NEXT:    [[TMP1:%.*]] = xor i1 [[TMP0]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP1]])
; CHECK-NEXT:    ret void
;
entry-block:
  %0 = call i1 @get_val()
  %1 = xor i1 %0, true
  call void @llvm.assume(i1 %1)
  ret void
}

declare i1 @get_val()
declare void @llvm.assume(i1)

define dso_local i1 @test1(i32* readonly %0) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    call void @llvm.assume(i1 true) [ "nonnull"(i32* [[TMP0:%.*]]) ]
; CHECK-NEXT:    ret i1 false
;
  call void @llvm.assume(i1 true) ["nonnull"(i32* %0)]
  %2 = icmp eq i32* %0, null
  ret i1 %2
}

define dso_local i1 @test2(i32* readonly %0) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    call void @llvm.assume(i1 true) [ "nonnull"(i32* [[TMP0:%.*]]) ]
; CHECK-NEXT:    ret i1 false
;
  %2 = icmp eq i32* %0, null
  call void @llvm.assume(i1 true) ["nonnull"(i32* %0)]
  ret i1 %2
}

define dso_local i32 @test4(i32* readonly %0, i1 %cond) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    call void @llvm.assume(i1 true) [ "dereferenceable"(i32* [[TMP0:%.*]], i32 4) ]
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       B:
; CHECK-NEXT:    br label [[A]]
; CHECK:       A:
; CHECK-NEXT:    br i1 false, label [[TMP4:%.*]], label [[TMP2:%.*]]
; CHECK:       2:
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, i32* [[TMP0]], align 4
; CHECK-NEXT:    br label [[TMP4]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = phi i32 [ [[TMP3]], [[TMP2]] ], [ 0, [[A]] ]
; CHECK-NEXT:    ret i32 [[TMP5]]
;
  call void @llvm.assume(i1 true) ["dereferenceable"(i32* %0, i32 4)]
  br i1 %cond, label %A, label %B

B:
  br label %A

A:
  %2 = icmp eq i32* %0, null
  br i1 %2, label %5, label %3

3:                                                ; preds = %1
  %4 = load i32, i32* %0, align 4
  br label %5

5:                                                ; preds = %1, %3
  %6 = phi i32 [ %4, %3 ], [ 0, %A ]
  ret i32 %6
}

define dso_local i32 @test4b(i32* readonly %0, i1 %cond) null_pointer_is_valid {
; CHECK-LABEL: @test4b(
; CHECK-NEXT:    call void @llvm.assume(i1 true) [ "dereferenceable"(i32* [[TMP0:%.*]], i32 4) ]
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[A:%.*]], label [[B:%.*]]
; CHECK:       B:
; CHECK-NEXT:    br label [[A]]
; CHECK:       A:
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32* [[TMP0]], null
; CHECK-NEXT:    br i1 [[TMP2]], label [[TMP5:%.*]], label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, i32* [[TMP0]], align 4
; CHECK-NEXT:    br label [[TMP5]]
; CHECK:       5:
; CHECK-NEXT:    [[TMP6:%.*]] = phi i32 [ [[TMP4]], [[TMP3]] ], [ 0, [[A]] ]
; CHECK-NEXT:    ret i32 [[TMP6]]
;
  call void @llvm.assume(i1 true) ["dereferenceable"(i32* %0, i32 4)]
  br i1 %cond, label %A, label %B

B:
  br label %A

A:
  %2 = icmp eq i32* %0, null
  br i1 %2, label %5, label %3

3:                                                ; preds = %1
  %4 = load i32, i32* %0, align 4
  br label %5

5:                                                ; preds = %1, %3
  %6 = phi i32 [ %4, %3 ], [ 0, %A ]
  ret i32 %6
}
