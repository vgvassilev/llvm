; RUN: llc < %s -asm-verbose=false -disable-wasm-fallthrough-return-opt -wasm-disable-explicit-locals -wasm-keep-registers | FileCheck %s

; Test that the frem instruction works.

target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32-unknown-unknown"

; CHECK-LABEL: frem32:
; CHECK-NEXT: .functype frem32 (f32, f32) -> (f32){{$}}
; CHECK-NEXT: {{^}} f32.call $push0=, fmodf, $0, $1{{$}}
; CHECK-NEXT: return $pop0{{$}}
define float @frem32(float %x, float %y) {
  %a = frem float %x, %y
  ret float %a
}

; CHECK-LABEL: frem64:
; CHECK-NEXT: .functype frem64 (f64, f64) -> (f64){{$}}
; CHECK-NEXT: {{^}} f64.call $push0=, fmod, $0, $1{{$}}
; CHECK-NEXT: return $pop0{{$}}
define double @frem64(double %x, double %y) {
  %a = frem double %x, %y
  ret double %a
}
