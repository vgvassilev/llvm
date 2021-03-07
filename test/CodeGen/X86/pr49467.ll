; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 -fast-isel -verify-machineinstrs -mtriple=x86_64 < %s | FileCheck %s

declare { i8*, i64 } @get()

declare void @use(i8*, i64)

define void @test(i64* %p) nounwind {
; CHECK-LABEL: test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    movq %rdi, (%rsp) # 8-byte Spill
; CHECK-NEXT:    callq get@PLT
; CHECK-NEXT:    movq (%rsp), %rdi # 8-byte Reload
; CHECK-NEXT:    movq %rdx, %rsi
; CHECK-NEXT:    movq %rsi, (%rdi)
; CHECK-NEXT:    # implicit-def: $rdi
; CHECK-NEXT:    callq use@PLT
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    retq
  %struct = call { i8*, i64 } @get()
  %struct.1 = extractvalue { i8*, i64 } %struct, 1
  store i64 %struct.1, i64* %p, align 8
  %struct.2 = extractvalue { i8*, i64 } %struct, 1
  call void @use(i8* undef, i64 %struct.2)
  ret void
}
