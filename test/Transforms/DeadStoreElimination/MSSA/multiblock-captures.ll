; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -basic-aa -dse -enable-dse-memoryssa -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"

declare noalias i8* @malloc(i64)

declare void @foo()
declare void @capture(i8*)

; Check that we do not remove the second store, as %m is returned.
define i8* @test_return_captures_1() {
; CHECK-LABEL: @test_return_captures_1(
; CHECK-NEXT:    [[M:%.*]] = call i8* @malloc(i64 24)
; CHECK-NEXT:    store i8 1, i8* [[M]], align 1
; CHECK-NEXT:    ret i8* [[M]]
;
  %m = call i8* @malloc(i64 24)
  store i8 0, i8* %m
  store i8 1, i8* %m
  ret i8* %m
}

; Same as @test_return_captures_1, but across BBs.
define i8* @test_return_captures_2() {
; CHECK-LABEL: @test_return_captures_2(
; CHECK-NEXT:    [[M:%.*]] = call i8* @malloc(i64 24)
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    store i8 1, i8* [[M]], align 1
; CHECK-NEXT:    ret i8* [[M]]
;
  %m = call i8* @malloc(i64 24)
  store i8 0, i8* %m
  br label %exit

exit:
  store i8 1, i8* %m
  ret i8* %m
}


%S1 = type { i8 * }

; We cannot remove the last store to %m, because it escapes by storing it to %E.
define void @test_malloc_capture_1(%S1* %E) {
; CHECK-LABEL: @test_malloc_capture_1(
; CHECK-NEXT:    [[M:%.*]] = call i8* @malloc(i64 24)
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[F_PTR:%.*]] = getelementptr [[S1:%.*]], %S1* [[E:%.*]], i32 0, i32 0
; CHECK-NEXT:    store i8* [[M]], i8** [[F_PTR]], align 4
; CHECK-NEXT:    store i8 1, i8* [[M]], align 1
; CHECK-NEXT:    ret void
;
  %m = call i8* @malloc(i64 24)
  br label %exit

exit:
  %f.ptr = getelementptr %S1, %S1* %E, i32 0, i32 0
  store i8* %m, i8** %f.ptr
  store i8 1, i8* %m
  ret void
}

; Check we do not eliminate either store. The first one cannot be eliminated,
; due to the call of @capture. The second one because %m escapes.
define i8* @test_malloc_capture_2() {
; CHECK-LABEL: @test_malloc_capture_2(
; CHECK-NEXT:    [[M:%.*]] = call i8* @malloc(i64 24)
; CHECK-NEXT:    store i8 0, i8* [[M]], align 1
; CHECK-NEXT:    call void @capture(i8* [[M]])
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    store i8 1, i8* [[M]], align 1
; CHECK-NEXT:    ret i8* [[M]]
;
  %m = call i8* @malloc(i64 24)
  store i8 0, i8* %m
  call void @capture(i8* %m)
  br label %exit

exit:
  store i8 1, i8* %m
  ret i8* %m
}

; We can remove the first store store i8 0, i8* %m because there are no throwing
; instructions between the 2 stores and also %m escapes after the killing store.
define i8* @test_malloc_capture_3() {
; CHECK-LABEL: @test_malloc_capture_3(
; CHECK-NEXT:    [[M:%.*]] = call i8* @malloc(i64 24)
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    store i8 1, i8* [[M]], align 1
; CHECK-NEXT:    call void @capture(i8* [[M]])
; CHECK-NEXT:    ret i8* [[M]]
;
  %m = call i8* @malloc(i64 24)
  store i8 0, i8* %m
  br label %exit

exit:
  store i8 1, i8* %m
  call void @capture(i8* %m)
  ret i8* %m
}

; TODO: We could remove the first store store i8 0, i8* %m because %m escapes
; after the killing store.
define i8* @test_malloc_capture_4() {
; CHECK-LABEL: @test_malloc_capture_4(
; CHECK-NEXT:    [[M:%.*]] = call i8* @malloc(i64 24)
; CHECK-NEXT:    store i8 0, i8* [[M]], align 1
; CHECK-NEXT:    call void @may_throw_readnone()
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    store i8 1, i8* [[M]], align 1
; CHECK-NEXT:    call void @capture(i8* [[M]])
; CHECK-NEXT:    ret i8* [[M]]
;

  %m = call i8* @malloc(i64 24)
  store i8 0, i8* %m
  call void @may_throw_readnone()
  br label %exit

exit:
  store i8 1, i8* %m
  call void @capture(i8* %m)
  ret i8* %m
}


; We cannot remove the first store store i8 0, i8* %m because %m escapes
; before the killing store and we may throw in between.
define i8* @test_malloc_capture_5() {
; CHECK-LABEL: @test_malloc_capture_5(
; CHECK-NEXT:    [[M:%.*]] = call i8* @malloc(i64 24)
; CHECK-NEXT:    call void @capture(i8* [[M]])
; CHECK-NEXT:    store i8 0, i8* [[M]], align 1
; CHECK-NEXT:    call void @may_throw_readnone()
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    store i8 1, i8* [[M]], align 1
; CHECK-NEXT:    ret i8* [[M]]
;

  %m = call i8* @malloc(i64 24)
  call void @capture(i8* %m)
  store i8 0, i8* %m
  call void @may_throw_readnone()
  br label %exit

exit:
  store i8 1, i8* %m
  ret i8* %m
}


; TODO: We could remove the first store 'store i8 0, i8* %m' even though there
; is a throwing instruction between them, because %m escapes after the killing
; store.
define i8* @test_malloc_capture_6() {
; CHECK-LABEL: @test_malloc_capture_6(
; CHECK-NEXT:    [[M:%.*]] = call i8* @malloc(i64 24)
; CHECK-NEXT:    store i8 0, i8* [[M]], align 1
; CHECK-NEXT:    call void @may_throw_readnone()
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    store i8 1, i8* [[M]], align 1
; CHECK-NEXT:    call void @capture(i8* [[M]])
; CHECK-NEXT:    ret i8* [[M]]
;

  %m = call i8* @malloc(i64 24)
  store i8 0, i8* %m
  call void @may_throw_readnone()
  br label %exit

exit:
  store i8 1, i8* %m
  call void @capture(i8* %m)
  ret i8* %m
}

; We can remove the first store 'store i8 0, i8* %m' even though there is a
; throwing instruction between them, because %m escapes after the killing store.
define i8* @test_malloc_capture_7() {
; CHECK-LABEL: @test_malloc_capture_7(
; CHECK-NEXT:    [[M:%.*]] = call i8* @malloc(i64 24)
; CHECK-NEXT:    call void @may_throw()
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    store i8 1, i8* [[M]], align 1
; CHECK-NEXT:    call void @capture(i8* [[M]])
; CHECK-NEXT:    ret i8* [[M]]
;

  %m = call i8* @malloc(i64 24)
  store i8 0, i8* %m
  call void @may_throw()
  br label %exit

exit:
  store i8 1, i8* %m
  call void @capture(i8* %m)
  ret i8* %m
}

; Stores to stack objects can be eliminated if they are not captured inside the function.
define void @test_alloca_nocapture_1() {
; CHECK-LABEL: @test_alloca_nocapture_1(
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
  %m = alloca i8
  store i8 0, i8* %m
  call void @foo()
  br label %exit

exit:
  store i8 1, i8* %m
  ret void
}

; Cannot remove first store i8 0, i8* %m, as the call to @capture captures the object.
define void @test_alloca_capture_1() {
; CHECK-LABEL: @test_alloca_capture_1(
; CHECK-NEXT:    [[M:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 0, i8* [[M]], align 1
; CHECK-NEXT:    call void @capture(i8* [[M]])
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
  %m = alloca i8
  store i8 0, i8* %m
  call void @capture(i8* %m)
  br label %exit

exit:
  store i8 1, i8* %m
  ret void
}

; We can remove the last store to %m, even though it escapes because the alloca
; becomes invalid after the function returns.
define void @test_alloca_capture_2(%S1* %E) {
; CHECK-LABEL: @test_alloca_capture_2(
; CHECK-NEXT:    [[M:%.*]] = alloca i8, align 1
; CHECK-NEXT:    br label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[F_PTR:%.*]] = getelementptr [[S1:%.*]], %S1* [[E:%.*]], i32 0, i32 0
; CHECK-NEXT:    store i8* [[M]], i8** [[F_PTR]], align 4
; CHECK-NEXT:    ret void
;
  %m = alloca i8
  br label %exit

exit:
  %f.ptr = getelementptr %S1, %S1* %E, i32 0, i32 0
  store i8* %m, i8** %f.ptr
  store i8 1, i8* %m
  ret void
}

; Readnone functions are not modeled in MemorySSA, but could throw.
; Make sure we do not eliminate the first store 'store i8 2, i8* %call'
define void @malloc_capture_throw_1() {
; CHECK-LABEL: @malloc_capture_throw_1(
; CHECK-NEXT:    [[CALL:%.*]] = call i8* @malloc(i64 1)
; CHECK-NEXT:    call void @may_capture(i8* [[CALL]])
; CHECK-NEXT:    store i8 2, i8* [[CALL]], align 1
; CHECK-NEXT:    call void @may_throw_readnone()
; CHECK-NEXT:    store i8 3, i8* [[CALL]], align 1
; CHECK-NEXT:    ret void
;
  %call = call i8* @malloc(i64 1)
  call void @may_capture(i8* %call)
  store i8 2, i8* %call, align 1
  call void @may_throw_readnone()
  store i8 3, i8* %call, align 1
  ret void
}

; Readnone functions are not modeled in MemorySSA, but could throw.
; Make sure we do not eliminate the first store 'store i8 2, i8* %call'
define void @malloc_capture_throw_2() {
; CHECK-LABEL: @malloc_capture_throw_2(
; CHECK-NEXT:    [[CALL:%.*]] = call i8* @malloc(i64 1)
; CHECK-NEXT:    call void @may_capture(i8* [[CALL]])
; CHECK-NEXT:    store i8 2, i8* [[CALL]], align 1
; CHECK-NEXT:    br label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    call void @may_throw_readnone()
; CHECK-NEXT:    store i8 3, i8* [[CALL]], align 1
; CHECK-NEXT:    ret void
;
  %call = call i8* @malloc(i64 1)
  call void @may_capture(i8* %call)
  store i8 2, i8* %call, align 1
  br label %bb

bb:
  call void @may_throw_readnone()
  store i8 3, i8* %call, align 1
  ret void
}


declare void @may_capture(i8*)
declare void @may_throw_readnone() readnone
declare void @may_throw()
