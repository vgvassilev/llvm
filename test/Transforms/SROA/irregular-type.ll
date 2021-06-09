; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -sroa -S | FileCheck %s

%S = type { [4 x i8] }

; Ensure the load/store of integer types whose size is not equal to the store
; size are not split.

define i8 @foo(i23 %0) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  Entry:
; CHECK-NEXT:    [[DOTSROA_0:%.*]] = alloca [3 x i8], align 8
; CHECK-NEXT:    [[DOTSROA_0_0__SROA_CAST1:%.*]] = bitcast [3 x i8]* [[DOTSROA_0]] to i23*
; CHECK-NEXT:    store i23 [[TMP0:%.*]], i23* [[DOTSROA_0_0__SROA_CAST1]], align 8
; CHECK-NEXT:    [[DOTSROA_0_1__SROA_IDX2:%.*]] = getelementptr inbounds [3 x i8], [3 x i8]* [[DOTSROA_0]], i64 0, i64 1
; CHECK-NEXT:    [[DOTSROA_0_1__SROA_0_1_:%.*]] = load i8, i8* [[DOTSROA_0_1__SROA_IDX2]], align 1
; CHECK-NEXT:    ret i8 [[DOTSROA_0_1__SROA_0_1_]]
;
Entry:
  %1 = alloca %S
  %2 = bitcast %S* %1 to i23*
  store i23 %0, i23* %2
  %3 = getelementptr inbounds %S, %S* %1, i64 0, i32 0, i32 1
  %4 = load i8, i8* %3
  ret i8 %4
}

define i32 @bar(i16 %0) {
; CHECK-LABEL: @bar(
; CHECK-NEXT:  Entry:
; CHECK-NEXT:    [[DOTSROA_0:%.*]] = alloca [3 x i8], align 8
; CHECK-NEXT:    [[DOTSROA_0_0__SROA_CAST2:%.*]] = bitcast [3 x i8]* [[DOTSROA_0]] to i16*
; CHECK-NEXT:    store i16 [[TMP0:%.*]], i16* [[DOTSROA_0_0__SROA_CAST2]], align 8
; CHECK-NEXT:    [[DOTSROA_0_0_Q_SROA_CAST1:%.*]] = bitcast [3 x i8]* [[DOTSROA_0]] to i17*
; CHECK-NEXT:    [[DOTSROA_0_0__SROA_0_0_:%.*]] = load i17, i17* [[DOTSROA_0_0_Q_SROA_CAST1]], align 8
; CHECK-NEXT:    [[TMP1:%.*]] = zext i17 [[DOTSROA_0_0__SROA_0_0_]] to i32
; CHECK-NEXT:    ret i32 [[TMP1]]
;
Entry:
  %1 = alloca %S
  %2 = bitcast %S* %1 to i16*
  store i16 %0, i16* %2
  %3 = getelementptr inbounds %S, %S* %1, i64 0, i32 0
  %q = bitcast [4 x i8]* %3 to i17*
  %4 = load i17, i17* %q
  %5 = zext i17 %4 to i32
  ret i32 %5
}
