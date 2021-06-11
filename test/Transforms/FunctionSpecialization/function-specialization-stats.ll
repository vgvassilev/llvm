; REQUIRES: asserts

; RUN: opt -stats -function-specialization -deadargelim -inline -S < %s 2>&1 | FileCheck %s

; CHECK: 2 deadargelim             - Number of unread args removed
; CHECK: 1 deadargelim             - Number of unused return values removed
; CHECK: 2 function-specialization - Number of functions specialized
; CHECK: 4 inline                  - Number of functions deleted because all callers found
; CHECK: 4 inline                  - Number of functions inlined
; CHECK: 6 inline-cost             - Number of call sites analyzed

define i64 @main(i64 %x, i1 %flag) {
entry:
  br i1 %flag, label %plus, label %minus

plus:
  %tmp0 = call i64 @compute(i64 %x, i64 (i64)* @plus)
  br label %merge

minus:
  %tmp1 = call i64 @compute(i64 %x, i64 (i64)* @minus)
  br label %merge

merge:
  %tmp2 = phi i64 [ %tmp0, %plus ], [ %tmp1, %minus]
  ret i64 %tmp2
}

define internal i64 @compute(i64 %x, i64 (i64)* %binop) {
entry:
  %tmp0 = call i64 %binop(i64 %x)
  ret i64 %tmp0
}

define internal i64 @plus(i64 %x) {
entry:
  %tmp0 = add i64 %x, 1
  ret i64 %tmp0
}

define internal i64 @minus(i64 %x) {
entry:
  %tmp0 = sub i64 %x, 1
  ret i64 %tmp0
}
