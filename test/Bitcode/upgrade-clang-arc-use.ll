; Test upgrade of clang.arc.use by removing it.
; Bitcode input generated from llvm 6.0

; RUN: llvm-dis %s.bc -o - | FileCheck %s

%0 = type opaque
define void @foo() {
  %1 = tail call %0* @foo0()
; CHECK-NOT: clang.arc.use
  call void (...) @clang.arc.use(%0* %1)
  ret void
}
declare %0* @foo0()
declare void @clang.arc.use(...)
