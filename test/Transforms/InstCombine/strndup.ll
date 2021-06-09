; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

@hello = constant [6 x i8] c"hello\00"
@null = constant [1 x i8] zeroinitializer

declare i8* @strndup(i8*, i32)

define i8* @test1() {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[STRDUP:%.*]] = call noalias dereferenceable_or_null(1) i8* @strdup(i8* nocapture readonly getelementptr inbounds ([1 x i8], [1 x i8]* @null, i64 0, i64 0)) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    ret i8* [[STRDUP]]
;
  %src = getelementptr [1 x i8], [1 x i8]* @null, i32 0, i32 0
  %ret = call i8* @strndup(i8* %src, i32 0)
  ret i8* %ret
}

define i8* @test2() {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[RET:%.*]] = call dereferenceable_or_null(5) i8* @strndup(i8* dereferenceable(6) getelementptr inbounds ([6 x i8], [6 x i8]* @hello, i64 0, i64 0), i32 4)
; CHECK-NEXT:    ret i8* [[RET]]
;
  %src = getelementptr [6 x i8], [6 x i8]* @hello, i32 0, i32 0
  %ret = call i8* @strndup(i8* %src, i32 4)
  ret i8* %ret
}

define i8* @test3() {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[STRDUP:%.*]] = call noalias dereferenceable_or_null(6) i8* @strdup(i8* nocapture readonly getelementptr inbounds ([6 x i8], [6 x i8]* @hello, i64 0, i64 0)) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[STRDUP]]
;
  %src = getelementptr [6 x i8], [6 x i8]* @hello, i32 0, i32 0
  %ret = call i8* @strndup(i8* %src, i32 5)
  ret i8* %ret
}

define i8* @test4() {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[STRDUP:%.*]] = call noalias dereferenceable_or_null(6) i8* @strdup(i8* nocapture readonly getelementptr inbounds ([6 x i8], [6 x i8]* @hello, i64 0, i64 0)) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[STRDUP]]
;
  %src = getelementptr [6 x i8], [6 x i8]* @hello, i32 0, i32 0
  %ret = call i8* @strndup(i8* %src, i32 6)
  ret i8* %ret
}

define i8* @test5() {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[STRDUP:%.*]] = call noalias dereferenceable_or_null(6) i8* @strdup(i8* nocapture readonly getelementptr inbounds ([6 x i8], [6 x i8]* @hello, i64 0, i64 0)) #[[ATTR0]]
; CHECK-NEXT:    ret i8* [[STRDUP]]
;
  %src = getelementptr [6 x i8], [6 x i8]* @hello, i32 0, i32 0
  %ret = call i8* @strndup(i8* %src, i32 7)
  ret i8* %ret
}

define i8* @test6(i32 %n) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    [[RET:%.*]] = call i8* @strndup(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @hello, i64 0, i64 0), i32 [[N:%.*]])
; CHECK-NEXT:    ret i8* [[RET]]
;
  %src = getelementptr [6 x i8], [6 x i8]* @hello, i32 0, i32 0
  %ret = call i8* @strndup(i8* %src, i32 %n)
  ret i8* %ret
}
