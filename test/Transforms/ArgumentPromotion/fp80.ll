; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; RUN: opt < %s -argpromotion -S | FileCheck %s
; RUN: opt < %s -passes=argpromotion -S | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.u = type { x86_fp80 }
%struct.s = type { double, i16, i8, [5 x i8] }

@b = internal global %struct.s { double 3.14, i16 9439, i8 25, [5 x i8] undef }, align 16

%struct.Foo = type { i32, i64 }
@a = internal global %struct.Foo { i32 1, i64 2 }, align 8

define void @run() {
; CHECK-LABEL: define {{[^@]+}}@run()
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = tail call i8 @UseLongDoubleUnsafely(%union.u* byval(%union.u) align 16 bitcast (%struct.s* @b to %union.u*))
; CHECK-NEXT:    [[DOT0:%.*]] = getelementptr [[UNION_U:%.*]], %union.u* bitcast (%struct.s* @b to %union.u*), i32 0, i32 0
; CHECK-NEXT:    [[DOT0_VAL:%.*]] = load x86_fp80, x86_fp80* [[DOT0]]
; CHECK-NEXT:    [[TMP1:%.*]] = tail call x86_fp80 @UseLongDoubleSafely(x86_fp80 [[DOT0_VAL]])
; CHECK-NEXT:    [[TMP2:%.*]] = call i64 @AccessPaddingOfStruct(%struct.Foo* byval(%struct.Foo) @a)
; CHECK-NEXT:    [[TMP3:%.*]] = call i64 @CaptureAStruct(%struct.Foo* byval(%struct.Foo) @a)
; CHECK-NEXT:    ret void
;
entry:
  tail call i8 @UseLongDoubleUnsafely(%union.u* byval(%union.u) align 16 bitcast (%struct.s* @b to %union.u*))
  tail call x86_fp80 @UseLongDoubleSafely(%union.u* byval(%union.u) align 16 bitcast (%struct.s* @b to %union.u*))
  call i64 @AccessPaddingOfStruct(%struct.Foo* byval(%struct.Foo) @a)
  call i64 @CaptureAStruct(%struct.Foo* byval(%struct.Foo) @a)
  ret void
}

define internal i8 @UseLongDoubleUnsafely(%union.u* byval(%union.u) align 16 %arg) {
; CHECK-LABEL: define {{[^@]+}}@UseLongDoubleUnsafely
; CHECK-SAME: (%union.u* byval(%union.u) align 16 [[ARG:%.*]])
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BITCAST:%.*]] = bitcast %union.u* [[ARG]] to %struct.s*
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds [[STRUCT_S:%.*]], %struct.s* [[BITCAST]], i64 0, i32 2
; CHECK-NEXT:    [[RESULT:%.*]] = load i8, i8* [[GEP]]
; CHECK-NEXT:    ret i8 [[RESULT]]
;
entry:
  %bitcast = bitcast %union.u* %arg to %struct.s*
  %gep = getelementptr inbounds %struct.s, %struct.s* %bitcast, i64 0, i32 2
  %result = load i8, i8* %gep
  ret i8 %result
}

define internal x86_fp80 @UseLongDoubleSafely(%union.u* byval(%union.u) align 16 %arg) {
; CHECK-LABEL: define {{[^@]+}}@UseLongDoubleSafely
; CHECK-SAME: (x86_fp80 [[ARG_0:%.*]])
; CHECK-NEXT:    [[ARG:%.*]] = alloca [[UNION_U:%.*]], align 16
; CHECK-NEXT:    [[DOT0:%.*]] = getelementptr [[UNION_U]], %union.u* [[ARG]], i32 0, i32 0
; CHECK-NEXT:    store x86_fp80 [[ARG_0]], x86_fp80* [[DOT0]]
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds [[UNION_U]], %union.u* [[ARG]], i64 0, i32 0
; CHECK-NEXT:    [[FP80:%.*]] = load x86_fp80, x86_fp80* [[GEP]]
; CHECK-NEXT:    ret x86_fp80 [[FP80]]
;
  %gep = getelementptr inbounds %union.u, %union.u* %arg, i64 0, i32 0
  %fp80 = load x86_fp80, x86_fp80* %gep
  ret x86_fp80 %fp80
}

define internal i64 @AccessPaddingOfStruct(%struct.Foo* byval(%struct.Foo) %a) {
; CHECK-LABEL: define {{[^@]+}}@AccessPaddingOfStruct
; CHECK-SAME: (%struct.Foo* byval(%struct.Foo) [[A:%.*]])
; CHECK-NEXT:    [[P:%.*]] = bitcast %struct.Foo* [[A]] to i64*
; CHECK-NEXT:    [[V:%.*]] = load i64, i64* [[P]]
; CHECK-NEXT:    ret i64 [[V]]
;
  %p = bitcast %struct.Foo* %a to i64*
  %v = load i64, i64* %p
  ret i64 %v
}

define internal i64 @CaptureAStruct(%struct.Foo* byval(%struct.Foo) %a) {
; CHECK-LABEL: define {{[^@]+}}@CaptureAStruct
; CHECK-SAME: (%struct.Foo* byval(%struct.Foo) [[A:%.*]])
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_PTR:%.*]] = alloca %struct.Foo*
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[PHI:%.*]] = phi %struct.Foo* [ null, [[ENTRY:%.*]] ], [ [[GEP:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = phi %struct.Foo* [ [[A]], [[ENTRY]] ], [ [[TMP0]], [[LOOP]] ]
; CHECK-NEXT:    store %struct.Foo* [[PHI]], %struct.Foo** [[A_PTR]]
; CHECK-NEXT:    [[GEP]] = getelementptr [[STRUCT_FOO:%.*]], %struct.Foo* [[A]], i64 0
; CHECK-NEXT:    br label [[LOOP]]
;
entry:
  %a_ptr = alloca %struct.Foo*
  br label %loop

loop:
  %phi = phi %struct.Foo* [ null, %entry ], [ %gep, %loop ]
  %0   = phi %struct.Foo* [ %a, %entry ],   [ %0, %loop ]
  store %struct.Foo* %phi, %struct.Foo** %a_ptr
  %gep = getelementptr %struct.Foo, %struct.Foo* %a, i64 0
  br label %loop
}
