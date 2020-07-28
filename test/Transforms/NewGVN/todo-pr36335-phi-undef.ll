; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -newgvn -S %s | FileCheck %s

; TODO: NewGVN currently miscomiles the function below. PR36335.

declare void @foo(i32)

define void @main(i1 %c1, i1 %c2, i32 %x) {
; CHECK-LABEL: @main(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[L:%.*]], label [[END:%.*]]
; CHECK:       L:
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[X:%.*]], -1
; CHECK-NEXT:    call void @foo(i32 [[XOR]])
; CHECK-NEXT:    br label [[L]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c1, label %L, label %end

L:
  %d.1 = phi i8 [ undef, %entry ], [ -1, %L ]
  %conv = sext i8 %d.1 to i32
  %xor = xor i32 %x, %conv
  %neg = xor i32 %xor, -1
  call void @foo(i32 %neg)
  br label %L

end:
  ret void
}
