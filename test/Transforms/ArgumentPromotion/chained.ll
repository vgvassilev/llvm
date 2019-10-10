; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; RUN: opt < %s -argpromotion -S | FileCheck %s
; RUN: opt < %s -passes=argpromotion -S | FileCheck %s

@G1 = constant i32 0
@G2 = constant i32* @G1

define internal i32 @test(i32** %x) {
; CHECK-LABEL: define {{[^@]+}}@test
; CHECK-SAME: (i32 [[X_VAL_VAL:%.*]])
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret i32 [[X_VAL_VAL]]
;
entry:
  %y = load i32*, i32** %x
  %z = load i32, i32* %y
  ret i32 %z
}

define i32 @caller() {
; CHECK-LABEL: define {{[^@]+}}@caller()
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[G2_VAL:%.*]] = load i32*, i32** @G2
; CHECK-NEXT:    [[G2_VAL_VAL:%.*]] = load i32, i32* [[G2_VAL]]
; CHECK-NEXT:    [[X:%.*]] = call i32 @test(i32 [[G2_VAL_VAL]])
; CHECK-NEXT:    ret i32 [[X]]
;
entry:
  %x = call i32 @test(i32** @G2)
  ret i32 %x
}

