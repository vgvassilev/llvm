; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mergefunc %s | FileCheck %s

%struct.c = type { i32 }
%struct.a = type { i32 }

@d = external dso_local global %struct.c

define void @e(%struct.a* byval(%struct.a) %f) {
; CHECK-LABEL: @e(
; CHECK-NEXT:    ret void
;
  ret void
}

define void @g(%struct.c* byval(%struct.c) %f) {
; CHECK-LABEL: @g(
; CHECK-NEXT:    ret void
;
  ret void
}

define void @h() {
; CHECK-LABEL: @h(
; CHECK-NEXT:    call void bitcast (void (%struct.a*)* @e to void (%struct.c*)*)(%struct.c* byval(%struct.c) @d)
; CHECK-NEXT:    ret void
;
  call void @g(%struct.c* byval(%struct.c) @d)
  ret void
}
