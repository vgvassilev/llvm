; RUN: opt -S -inline %s -debug-only=inline-cost 2>&1 | FileCheck %s
; Only the load and ret should be included in the instruction count, not
; the instructions feeding the assume.
; CHECK: NumInstructions: 2

@a = global i32 4

define i32 @inner(i8* %y) {
  %a1 = load volatile i32, i32* @a

  ; Because these instructions are used only by the @llvm.assume intrinsic,
  ; they're free and should not be included in the instruction count when
  ; computing the inline cost.
  %a2 = mul i32 %a1, %a1
  %a3 = sub i32 %a1, %a2
  %a4 = udiv i32 %a3, -13
  %a5 = mul i32 %a4, %a4
  %a6 = add i32 %a5, %a5
  %ca = icmp sgt i32 %a6, -7
  %r = call i1 @llvm.type.test(i8* %y, metadata !0)
  %ca2 = icmp eq i1 %ca, %r
  tail call void @llvm.assume(i1 %ca2)

  ret i32 %a1
}

define i32 @outer(i8* %y) optsize {
   %r = call i32 @inner(i8* %y)
   ret i32 %r
}

declare void @llvm.assume(i1) nounwind
declare i1 @llvm.type.test(i8*, metadata) nounwind readnone

!0 = !{i32 0, !"typeid1"}
