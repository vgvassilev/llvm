; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -cost-model -analyze -mtriple=thumbv8.1m.main-none-eabi -mattr=+mve < %s | FileCheck %s --check-prefix=MVE-RECIP
; RUN: opt -cost-model -analyze -cost-kind=code-size -mtriple=thumbv8.1m.main-none-eabi -mattr=+mve < %s | FileCheck %s --check-prefix=MVE-SIZE

declare i64        @llvm.abs.i64(i64, i1)
declare <2 x i64>  @llvm.abs.v2i64(<2 x i64>, i1)
declare <4 x i64>  @llvm.abs.v4i64(<4 x i64>, i1)
declare <8 x i64>  @llvm.abs.v8i64(<8 x i64>, i1)

declare i32        @llvm.abs.i32(i32, i1)
declare <2 x i32>  @llvm.abs.v2i32(<2 x i32>, i1)
declare <4 x i32>  @llvm.abs.v4i32(<4 x i32>, i1)
declare <8 x i32>  @llvm.abs.v8i32(<8 x i32>, i1)
declare <16 x i32> @llvm.abs.v16i32(<16 x i32>, i1)

declare i16        @llvm.abs.i16(i16, i1)
declare <2 x i16>  @llvm.abs.v2i16(<2 x i16>, i1)
declare <4 x i16>  @llvm.abs.v4i16(<4 x i16>, i1)
declare <8 x i16>  @llvm.abs.v8i16(<8 x i16>, i1)
declare <16 x i16> @llvm.abs.v16i16(<16 x i16>, i1)
declare <32 x i16> @llvm.abs.v32i16(<32 x i16>, i1)

declare i8         @llvm.abs.i8(i8, i1)
declare <2 x i8>   @llvm.abs.v2i8(<2 x i8>, i1)
declare <4 x i8>   @llvm.abs.v4i8(<4 x i8>, i1)
declare <8 x i8>   @llvm.abs.v8i8(<8 x i8>, i1)
declare <16 x i8>  @llvm.abs.v16i8(<16 x i8>, i1)
declare <32 x i8>  @llvm.abs.v32i8(<32 x i8>, i1)
declare <64 x i8>  @llvm.abs.v64i8(<64 x i8>, i1)

define i32 @abs(i32 %arg) {
; MVE-RECIP-LABEL: 'abs'
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 5 for instruction: %I64 = call i64 @llvm.abs.i64(i64 undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 40 for instruction: %V2I64 = call <2 x i64> @llvm.abs.v2i64(<2 x i64> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 128 for instruction: %V4I64 = call <4 x i64> @llvm.abs.v4i64(<4 x i64> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 448 for instruction: %V8I64 = call <8 x i64> @llvm.abs.v8i64(<8 x i64> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %I32 = call i32 @llvm.abs.i32(i32 undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %V2I32 = call <2 x i32> @llvm.abs.v2i32(<2 x i32> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4I32 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V8I32 = call <8 x i32> @llvm.abs.v8i32(<8 x i32> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V16I32 = call <16 x i32> @llvm.abs.v16i32(<16 x i32> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %I16 = call i16 @llvm.abs.i16(i16 undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %V2I16 = call <2 x i16> @llvm.abs.v2i16(<2 x i16> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4I16 = call <4 x i16> @llvm.abs.v4i16(<4 x i16> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8I16 = call <8 x i16> @llvm.abs.v8i16(<8 x i16> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V16I16 = call <16 x i16> @llvm.abs.v16i16(<16 x i16> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V32I16 = call <32 x i16> @llvm.abs.v32i16(<32 x i16> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 3 for instruction: %I8 = call i8 @llvm.abs.i8(i8 undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %V2I8 = call <2 x i8> @llvm.abs.v2i8(<2 x i8> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V4I8 = call <4 x i8> @llvm.abs.v4i8(<4 x i8> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8I8 = call <8 x i8> @llvm.abs.v8i8(<8 x i8> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V16I8 = call <16 x i8> @llvm.abs.v16i8(<16 x i8> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V32I8 = call <32 x i8> @llvm.abs.v32i8(<32 x i8> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 8 for instruction: %V64I8 = call <64 x i8> @llvm.abs.v64i8(<64 x i8> undef, i1 false)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; MVE-SIZE-LABEL: 'abs'
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 6 for instruction: %I64 = call i64 @llvm.abs.i64(i64 undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 14 for instruction: %V2I64 = call <2 x i64> @llvm.abs.v2i64(<2 x i64> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 42 for instruction: %V4I64 = call <4 x i64> @llvm.abs.v4i64(<4 x i64> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 146 for instruction: %V8I64 = call <8 x i64> @llvm.abs.v8i64(<8 x i64> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %I32 = call i32 @llvm.abs.i32(i32 undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %V2I32 = call <2 x i32> @llvm.abs.v2i32(<2 x i32> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I32 = call <4 x i32> @llvm.abs.v4i32(<4 x i32> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V8I32 = call <8 x i32> @llvm.abs.v8i32(<8 x i32> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V16I32 = call <16 x i32> @llvm.abs.v16i32(<16 x i32> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %I16 = call i16 @llvm.abs.i16(i16 undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %V2I16 = call <2 x i16> @llvm.abs.v2i16(<2 x i16> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I16 = call <4 x i16> @llvm.abs.v4i16(<4 x i16> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I16 = call <8 x i16> @llvm.abs.v8i16(<8 x i16> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V16I16 = call <16 x i16> @llvm.abs.v16i16(<16 x i16> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V32I16 = call <32 x i16> @llvm.abs.v32i16(<32 x i16> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %I8 = call i8 @llvm.abs.i8(i8 undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: %V2I8 = call <2 x i8> @llvm.abs.v2i8(<2 x i8> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I8 = call <4 x i8> @llvm.abs.v4i8(<4 x i8> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I8 = call <8 x i8> @llvm.abs.v8i8(<8 x i8> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I8 = call <16 x i8> @llvm.abs.v16i8(<16 x i8> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: %V32I8 = call <32 x i8> @llvm.abs.v32i8(<32 x i8> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %V64I8 = call <64 x i8> @llvm.abs.v64i8(<64 x i8> undef, i1 false)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
  %I64 = call i64 @llvm.abs.i64(i64 undef, i1 false)
  %V2I64 = call <2 x i64> @llvm.abs.v2i64(<2 x i64> undef, i1 false)
  %V4I64 = call <4 x i64> @llvm.abs.v4i64(<4 x i64> undef, i1 false)
  %V8I64 = call <8 x i64> @llvm.abs.v8i64(<8 x i64> undef, i1 false)

  %I32 = call i32 @llvm.abs.i32(i32 undef, i1 false)
  %V2I32  = call <2 x i32>  @llvm.abs.v2i32(<2 x i32> undef, i1 false)
  %V4I32  = call <4 x i32>  @llvm.abs.v4i32(<4 x i32> undef, i1 false)
  %V8I32  = call <8 x i32>  @llvm.abs.v8i32(<8 x i32> undef, i1 false)
  %V16I32 = call <16 x i32> @llvm.abs.v16i32(<16 x i32> undef, i1 false)

  %I16 = call i16 @llvm.abs.i16(i16 undef, i1 false)
  %V2I16  = call <2 x i16>  @llvm.abs.v2i16(<2 x i16> undef, i1 false)
  %V4I16  = call <4 x i16>  @llvm.abs.v4i16(<4 x i16> undef, i1 false)
  %V8I16  = call <8 x i16>  @llvm.abs.v8i16(<8 x i16> undef, i1 false)
  %V16I16 = call <16 x i16> @llvm.abs.v16i16(<16 x i16> undef, i1 false)
  %V32I16 = call <32 x i16> @llvm.abs.v32i16(<32 x i16> undef, i1 false)

  %I8 = call i8 @llvm.abs.i8(i8 undef, i1 false)
  %V2I8  = call <2 x i8>  @llvm.abs.v2i8(<2 x i8> undef, i1 false)
  %V4I8  = call <4 x i8>  @llvm.abs.v4i8(<4 x i8> undef, i1 false)
  %V8I8  = call <8 x i8>  @llvm.abs.v8i8(<8 x i8> undef, i1 false)
  %V16I8 = call <16 x i8> @llvm.abs.v16i8(<16 x i8> undef, i1 false)
  %V32I8 = call <32 x i8> @llvm.abs.v32i8(<32 x i8> undef, i1 false)
  %V64I8 = call <64 x i8> @llvm.abs.v64i8(<64 x i8> undef, i1 false)

  ret i32 undef
}

