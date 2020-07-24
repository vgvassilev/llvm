; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-attributes
; RUN: opt -ipsccp -S %s | FileCheck %s

; Test cases to ensure argmemonly/inaccessiblemem_or_argmemonly attributes are
; dropped, if a function argument is replaced by a constant.
;
; PR46717

@g = internal global i32 0

; Here the pointer argument %arg will be replaced by a constant. We need to
; drop argmemonly.
define internal void @ptrarg.1(i32* %arg, i32 %val) argmemonly nounwind {
; CHECK: Function Attrs: argmemonly nounwind
; CHECK-LABEL: @ptrarg.1(
; CHECK-NEXT:    store i32 10, i32* @g, align 4
; CHECK-NEXT:    ret void
;
  store i32 %val, i32* %arg
  ret void
}

define i32 @caller.1(i32 %n) {
; CHECK-LABEL: @caller.1(
; CHECK-NEXT:    store i32 1, i32* @g, align 4
; CHECK-NEXT:    tail call void @ptrarg.1(i32* @g, i32 10)
; CHECK-NEXT:    [[G_VAL:%.*]] = load i32, i32* @g, align 4
; CHECK-NEXT:    ret i32 [[G_VAL]]
;
  store i32 1, i32* @g
  tail call void @ptrarg.1(i32* @g, i32 10)
  %g.val = load i32, i32* @g
  ret i32 %g.val
}


; Here only the non-pointer argument %val is replaced, no need
; to drop the argmemonly attribute.
define internal void @ptrarg.2(i32* %arg, i32 %val) argmemonly nounwind {
; CHECK: Function Attrs: argmemonly nounwind
; CHECK-LABEL: @ptrarg.2(
; CHECK-NEXT:    store i32 10, i32* [[ARG:%.*]], align 4
; CHECK-NEXT:    ret void
;
  store i32 %val, i32* %arg
  ret void
}

define void @caller.2(i32* %ptr) {
; CHECK-LABEL: @caller.2(
; CHECK-NEXT:    tail call void @ptrarg.2(i32* [[PTR:%.*]], i32 10)
; CHECK-NEXT:    ret void
;
  tail call void @ptrarg.2(i32* %ptr, i32 10)
  ret void
}


; Here the pointer argument %arg will be replaced by a constant. We need to
; drop inaccessiblemem_or_argmemonly.
define internal void @ptrarg.3(i32* %arg, i32 %val) inaccessiblemem_or_argmemonly nounwind {
; CHECK: Function Attrs: inaccessiblemem_or_argmemonly nounwind
; CHECK-LABEL: @ptrarg.3(
; CHECK-NEXT:    store i32 10, i32* @g, align 4
; CHECK-NEXT:    ret void
;
  store i32 %val, i32* %arg
  ret void
}

define i32 @caller.3(i32 %n) {
; CHECK-LABEL: @caller.3(
; CHECK-NEXT:    store i32 1, i32* @g, align 4
; CHECK-NEXT:    tail call void @ptrarg.3(i32* @g, i32 10)
; CHECK-NEXT:    [[G_VAL:%.*]] = load i32, i32* @g, align 4
; CHECK-NEXT:    ret i32 [[G_VAL]]
;
  store i32 1, i32* @g
  tail call void @ptrarg.3(i32* @g, i32 10)
  %g.val = load i32, i32* @g
  ret i32 %g.val
}


; Here only the non-pointer argument %val is replaced, no need
; to drop the inaccessiblemem_or_argmemonly attribute.
define internal void @ptrarg.4(i32* %arg, i32 %val) inaccessiblemem_or_argmemonly nounwind {
; CHECK: Function Attrs: inaccessiblemem_or_argmemonly nounwind
; CHECK-LABEL: @ptrarg.4(
; CHECK-NEXT:    store i32 10, i32* [[ARG:%.*]], align 4
; CHECK-NEXT:    ret void
;
  store i32 %val, i32* %arg
  ret void
}

define void @caller.4(i32* %ptr) {
; CHECK-LABEL: @caller.4(
; CHECK-NEXT:    tail call void @ptrarg.4(i32* [[PTR:%.*]], i32 10)
; CHECK-NEXT:    ret void
;
  tail call void @ptrarg.4(i32* %ptr, i32 10)
  ret void
}


; Here the pointer argument %arg will be replaced by a constant. We need to
; drop inaccessiblemem_or_argmemonly.
define internal void @ptrarg.5(i32* %arg, i32 %val) argmemonly inaccessiblemem_or_argmemonly nounwind {
; CHECK: Function Attrs: argmemonly inaccessiblemem_or_argmemonly nounwind
; CHECK-LABEL: @ptrarg.5(
; CHECK-NEXT:    store i32 10, i32* @g, align 4
; CHECK-NEXT:    ret void
;
  store i32 %val, i32* %arg
  ret void
}

define i32 @caller.5(i32 %n) {
; CHECK-LABEL: @caller.5(
; CHECK-NEXT:    store i32 1, i32* @g, align 4
; CHECK-NEXT:    tail call void @ptrarg.5(i32* @g, i32 10)
; CHECK-NEXT:    [[G_VAL:%.*]] = load i32, i32* @g, align 4
; CHECK-NEXT:    ret i32 [[G_VAL]]
;
  store i32 1, i32* @g
  tail call void @ptrarg.5(i32* @g, i32 10)
  %g.val = load i32, i32* @g
  ret i32 %g.val
}


; Make sure callsite attributes are also dropped when a pointer argument is
; replaced.
define internal void @ptrarg.6.cs.attributes(i32* %arg, i32 %val) {
; CHECK-LABEL: @ptrarg.6.cs.attributes(
; CHECK-NEXT:    unreachable
;
  store i32 %val, i32* %arg
  ret void
}

define i32 @caller.6.cs.attributes(i32 %n) {
; CHECK-LABEL: @caller.6.cs.attributes(
; CHECK-NEXT:    store i32 1, i32* @g, align 4
; CHECK-NEXT:    tail call void @ptrarg.5(i32* @g, i32 10) [[ARGMEMONLY_INACCESSIBLEMEM_OR_ARGMEMONLY_NOUNWIND:#[0-9]+]]
; CHECK-NEXT:    tail call void @ptrarg.5(i32* @g, i32 10) [[INACCESSIBLEMEM_OR_ARGMEMONLY_NOUNWIND:#[0-9]+]]
; CHECK-NEXT:    tail call void @ptrarg.5(i32* @g, i32 10) [[ARGMEMONLY_NOUNWIND:#[0-9]+]]
; CHECK-NEXT:    tail call void @ptrarg.5(i32* @g, i32 10) [[NOUNWIND:#[0-9]+]]
; CHECK-NEXT:    [[G_VAL:%.*]] = load i32, i32* @g, align 4
; CHECK-NEXT:    ret i32 [[G_VAL]]
;
  store i32 1, i32* @g
  tail call void @ptrarg.5(i32* @g, i32 10) argmemonly inaccessiblemem_or_argmemonly nounwind
  tail call void @ptrarg.5(i32* @g, i32 10) inaccessiblemem_or_argmemonly nounwind
  tail call void @ptrarg.5(i32* @g, i32 10) argmemonly nounwind
  tail call void @ptrarg.5(i32* @g, i32 10) nounwind
  %g.val = load i32, i32* @g
  ret i32 %g.val
}

; CHECK-DAG: [[ARGMEMONLY_INACCESSIBLEMEM_OR_ARGMEMONLY_NOUNWIND]] = { argmemonly inaccessiblemem_or_argmemonly nounwind }
; CHECK-DAG: [[INACCESSIBLEMEM_OR_ARGMEMONLY_NOUNWIND]] = { inaccessiblemem_or_argmemonly nounwind }
; CHECK-DAG: [[ARGMEMONLY_NOUNWIND]] = { argmemonly nounwind }
; CHECK-DAG: [[NOUNWIND]] = { nounwind }
