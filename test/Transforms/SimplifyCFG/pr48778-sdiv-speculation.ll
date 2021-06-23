; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -simplifycfg -S < %s | FileCheck %s

; sdiv INT_MIN / -1 should not be speculated.
define i32 @test(i1 %cmp) {
; CHECK-LABEL: @test(
; CHECK-NEXT:    br i1 [[CMP:%.*]], label [[IF:%.*]], label [[COMMON_RET:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[DIV:%.*]] = sdiv i32 -2147483648, -1
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ne i32 [[DIV]], 0
; CHECK-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[CMP2]], i32 1, i32 0
; CHECK-NEXT:    br label [[COMMON_RET]]
; CHECK:       common.ret:
; CHECK-NEXT:    [[COMMON_RET_OP:%.*]] = phi i32 [ 0, [[TMP0:%.*]] ], [ [[SPEC_SELECT]], [[IF]] ]
; CHECK-NEXT:    ret i32 [[COMMON_RET_OP]]
;
  br i1 %cmp, label %if, label %else

if:
  %div = sdiv i32 -2147483648, -1
  %cmp2 = icmp ne i32 %div, 0
  br i1 %cmp2, label %end, label %else

else:
  ret i32 0

end:
  ret i32 1
}
