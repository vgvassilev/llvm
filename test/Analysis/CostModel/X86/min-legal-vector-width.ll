; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s  -cost-model -analyze -mtriple=x86_64-apple-macosx10.8.0 -mattr=+avx2 | FileCheck %s --check-prefixes=CHECK,VEC256,AVX
; RUN: opt < %s  -cost-model -analyze -mtriple=x86_64-apple-macosx10.8.0 -mattr=+avx512vl,+avx512bw,+avx512dq,+prefer-256-bit | FileCheck %s --check-prefixes=CHECK,VEC256,SKX256
; RUN: opt < %s  -cost-model -analyze -mtriple=x86_64-apple-macosx10.8.0 -mattr=+avx512vl,+avx512bw,+avx512dq,-prefer-256-bit | FileCheck %s --check-prefixes=CHECK,VEC512

define void @zext256() "min-legal-vector-width"="256" {
; VEC256-LABEL: 'zext256'
; VEC256-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %A = zext <8 x i16> undef to <8 x i64>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %B = zext <8 x i32> undef to <8 x i64>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %C = zext <16 x i8> undef to <16 x i32>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %D = zext <16 x i16> undef to <16 x i32>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %E = zext <32 x i8> undef to <32 x i16>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; VEC512-LABEL: 'zext256'
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %A = zext <8 x i16> undef to <8 x i64>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %B = zext <8 x i32> undef to <8 x i64>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %C = zext <16 x i8> undef to <16 x i32>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %D = zext <16 x i16> undef to <16 x i32>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %E = zext <32 x i8> undef to <32 x i16>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %A = zext <8 x i16> undef to <8 x i64>
  %B = zext <8 x i32> undef to <8 x i64>
  %C = zext <16 x i8> undef to <16 x i32>
  %D = zext <16 x i16> undef to <16 x i32>
  %E = zext <32 x i8> undef to <32 x i16>
  ret void
}

define void @zext512() "min-legal-vector-width"="512" {
; AVX-LABEL: 'zext512'
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %A = zext <8 x i16> undef to <8 x i64>
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %B = zext <8 x i32> undef to <8 x i64>
; AVX-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %C = zext <16 x i8> undef to <16 x i32>
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %D = zext <16 x i16> undef to <16 x i32>
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %E = zext <32 x i8> undef to <32 x i16>
; AVX-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; SKX256-LABEL: 'zext512'
; SKX256-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %A = zext <8 x i16> undef to <8 x i64>
; SKX256-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %B = zext <8 x i32> undef to <8 x i64>
; SKX256-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %C = zext <16 x i8> undef to <16 x i32>
; SKX256-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %D = zext <16 x i16> undef to <16 x i32>
; SKX256-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %E = zext <32 x i8> undef to <32 x i16>
; SKX256-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; VEC512-LABEL: 'zext512'
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %A = zext <8 x i16> undef to <8 x i64>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %B = zext <8 x i32> undef to <8 x i64>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %C = zext <16 x i8> undef to <16 x i32>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %D = zext <16 x i16> undef to <16 x i32>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %E = zext <32 x i8> undef to <32 x i16>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %A = zext <8 x i16> undef to <8 x i64>
  %B = zext <8 x i32> undef to <8 x i64>
  %C = zext <16 x i8> undef to <16 x i32>
  %D = zext <16 x i16> undef to <16 x i32>
  %E = zext <32 x i8> undef to <32 x i16>
  ret void
}

define void @sext256() "min-legal-vector-width"="256" {
; VEC256-LABEL: 'sext256'
; VEC256-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %A = sext <8 x i8> undef to <8 x i64>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %B = sext <8 x i16> undef to <8 x i64>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %C = sext <8 x i32> undef to <8 x i64>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %D = sext <16 x i8> undef to <16 x i32>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %E = sext <16 x i16> undef to <16 x i32>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %F = sext <32 x i8> undef to <32 x i16>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; VEC512-LABEL: 'sext256'
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %A = sext <8 x i8> undef to <8 x i64>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %B = sext <8 x i16> undef to <8 x i64>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %C = sext <8 x i32> undef to <8 x i64>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %D = sext <16 x i8> undef to <16 x i32>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %E = sext <16 x i16> undef to <16 x i32>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %F = sext <32 x i8> undef to <32 x i16>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %A = sext <8 x i8> undef to <8 x i64>
  %B = sext <8 x i16> undef to <8 x i64>
  %C = sext <8 x i32> undef to <8 x i64>
  %D = sext <16 x i8> undef to <16 x i32>
  %E = sext <16 x i16> undef to <16 x i32>
  %F = sext <32 x i8> undef to <32 x i16>
  ret void
}

define void @sext512() "min-legal-vector-width"="512" {
; AVX-LABEL: 'sext512'
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %A = sext <8 x i8> undef to <8 x i64>
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %B = sext <8 x i16> undef to <8 x i64>
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %C = sext <8 x i32> undef to <8 x i64>
; AVX-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %D = sext <16 x i8> undef to <16 x i32>
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %E = sext <16 x i16> undef to <16 x i32>
; AVX-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %F = sext <32 x i8> undef to <32 x i16>
; AVX-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; SKX256-LABEL: 'sext512'
; SKX256-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %A = sext <8 x i8> undef to <8 x i64>
; SKX256-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %B = sext <8 x i16> undef to <8 x i64>
; SKX256-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %C = sext <8 x i32> undef to <8 x i64>
; SKX256-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %D = sext <16 x i8> undef to <16 x i32>
; SKX256-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %E = sext <16 x i16> undef to <16 x i32>
; SKX256-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %F = sext <32 x i8> undef to <32 x i16>
; SKX256-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; VEC512-LABEL: 'sext512'
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %A = sext <8 x i8> undef to <8 x i64>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %B = sext <8 x i16> undef to <8 x i64>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %C = sext <8 x i32> undef to <8 x i64>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %D = sext <16 x i8> undef to <16 x i32>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %E = sext <16 x i16> undef to <16 x i32>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %F = sext <32 x i8> undef to <32 x i16>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %A = sext <8 x i8> undef to <8 x i64>
  %B = sext <8 x i16> undef to <8 x i64>
  %C = sext <8 x i32> undef to <8 x i64>
  %D = sext <16 x i8> undef to <16 x i32>
  %E = sext <16 x i16> undef to <16 x i32>
  %F = sext <32 x i8> undef to <32 x i16>
  ret void
}

define void @trunc256() "min-legal-vector-width"="256" {
; VEC256-LABEL: 'trunc256'
; VEC256-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %A = trunc <8 x i64> undef to <8 x i32>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %B = trunc <8 x i64> undef to <8 x i16>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: %C = trunc <8 x i64> undef to <8 x i8>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %D = trunc <16 x i32> undef to <16 x i16>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 7 for instruction: %E = trunc <16 x i32> undef to <16 x i8>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 9 for instruction: %F = trunc <32 x i16> undef to <32 x i8>
; VEC256-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; VEC512-LABEL: 'trunc256'
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %A = trunc <8 x i64> undef to <8 x i32>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %B = trunc <8 x i64> undef to <8 x i16>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 11 for instruction: %C = trunc <8 x i64> undef to <8 x i8>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %D = trunc <16 x i32> undef to <16 x i16>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %E = trunc <16 x i32> undef to <16 x i8>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %F = trunc <32 x i16> undef to <32 x i8>
; VEC512-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  %A = trunc <8 x i64> undef to <8 x i32>
  %B = trunc <8 x i64> undef to <8 x i16>
  %C = trunc <8 x i64> undef to <8 x i8>
  %D = trunc <16 x i32> undef to <16 x i16>
  %E = trunc <16 x i32> undef to <16 x i8>
  %F = trunc <32 x i16> undef to <32 x i8>
  ret void
}
