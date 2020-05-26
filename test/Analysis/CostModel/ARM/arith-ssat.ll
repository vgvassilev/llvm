; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -cost-model -analyze -mtriple=thumbv8m.main < %s | FileCheck %s --check-prefix=V8M-RECIP
; RUN: opt -cost-model -analyze -mtriple=armv8a-linux-gnueabihf < %s | FileCheck %s --check-prefix=NEON-RECIP
; RUN: opt -cost-model -analyze -mtriple=armv8.1m.main -mattr=+mve < %s | FileCheck %s --check-prefix=MVE-RECIP
; RUN: opt -cost-model -analyze -cost-kind=code-size -mtriple=thumbv8m.main < %s | FileCheck %s --check-prefix=V8M-SIZE
; RUN: opt -cost-model -analyze -cost-kind=code-size -mtriple=armv8a-linux-gnueabihf < %s | FileCheck %s --check-prefix=NEON-SIZE
; RUN: opt -cost-model -analyze -cost-kind=code-size -mtriple=armv8.1m.main -mattr=+mve < %s | FileCheck %s --check-prefix=MVE-SIZE

declare i64        @llvm.sadd.sat.i64(i64, i64)
declare <2 x i64>  @llvm.sadd.sat.v2i64(<2 x i64>, <2 x i64>)
declare <4 x i64>  @llvm.sadd.sat.v4i64(<4 x i64>, <4 x i64>)
declare <8 x i64>  @llvm.sadd.sat.v8i64(<8 x i64>, <8 x i64>)

declare i32        @llvm.sadd.sat.i32(i32, i32)
declare <4 x i32>  @llvm.sadd.sat.v4i32(<4 x i32>, <4 x i32>)
declare <8 x i32>  @llvm.sadd.sat.v8i32(<8 x i32>, <8 x i32>)
declare <16 x i32> @llvm.sadd.sat.v16i32(<16 x i32>, <16 x i32>)

declare i16        @llvm.sadd.sat.i16(i16, i16)
declare <8 x i16>  @llvm.sadd.sat.v8i16(<8 x i16>, <8 x i16>)
declare <16 x i16> @llvm.sadd.sat.v16i16(<16 x i16>, <16 x i16>)
declare <32 x i16> @llvm.sadd.sat.v32i16(<32 x i16>, <32 x i16>)

declare i8         @llvm.sadd.sat.i8(i8,  i8)
declare <16 x i8>  @llvm.sadd.sat.v16i8(<16 x i8>, <16 x i8>)
declare <32 x i8>  @llvm.sadd.sat.v32i8(<32 x i8>, <32 x i8>)
declare <64 x i8>  @llvm.sadd.sat.v64i8(<64 x i8>, <64 x i8>)

define i32 @add(i32 %arg) {
; V8M-RECIP-LABEL: 'add'
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 13 for instruction: %I64 = call i64 @llvm.sadd.sat.i64(i64 undef, i64 undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 54 for instruction: %V2I64 = call <2 x i64> @llvm.sadd.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 108 for instruction: %V4I64 = call <4 x i64> @llvm.sadd.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 216 for instruction: %V8I64 = call <8 x i64> @llvm.sadd.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I32 = call i32 @llvm.sadd.sat.i32(i32 undef, i32 undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 72 for instruction: %V4I32 = call <4 x i32> @llvm.sadd.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 144 for instruction: %V8I32 = call <8 x i32> @llvm.sadd.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 288 for instruction: %V16I32 = call <16 x i32> @llvm.sadd.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I16 = call i16 @llvm.sadd.sat.i16(i16 undef, i16 undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 144 for instruction: %V8I16 = call <8 x i16> @llvm.sadd.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 288 for instruction: %V16I16 = call <16 x i16> @llvm.sadd.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 576 for instruction: %V32I16 = call <32 x i16> @llvm.sadd.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I8 = call i8 @llvm.sadd.sat.i8(i8 undef, i8 undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 288 for instruction: %V16I8 = call <16 x i8> @llvm.sadd.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 576 for instruction: %V32I8 = call <32 x i8> @llvm.sadd.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 1152 for instruction: %V64I8 = call <64 x i8> @llvm.sadd.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; NEON-RECIP-LABEL: 'add'
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 13 for instruction: %I64 = call i64 @llvm.sadd.sat.i64(i64 undef, i64 undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V2I64 = call <2 x i64> @llvm.sadd.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 51 for instruction: %V4I64 = call <4 x i64> @llvm.sadd.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 123 for instruction: %V8I64 = call <8 x i64> @llvm.sadd.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I32 = call i32 @llvm.sadd.sat.i32(i32 undef, i32 undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I32 = call <4 x i32> @llvm.sadd.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %V8I32 = call <8 x i32> @llvm.sadd.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 31 for instruction: %V16I32 = call <16 x i32> @llvm.sadd.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I16 = call i16 @llvm.sadd.sat.i16(i16 undef, i16 undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V8I16 = call <8 x i16> @llvm.sadd.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %V16I16 = call <16 x i16> @llvm.sadd.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %V32I16 = call <32 x i16> @llvm.sadd.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I8 = call i8 @llvm.sadd.sat.i8(i8 undef, i8 undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V16I8 = call <16 x i8> @llvm.sadd.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V32I8 = call <32 x i8> @llvm.sadd.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 40 for instruction: %V64I8 = call <64 x i8> @llvm.sadd.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; MVE-RECIP-LABEL: 'add'
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 13 for instruction: %I64 = call i64 @llvm.sadd.sat.i64(i64 undef, i64 undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 118 for instruction: %V2I64 = call <2 x i64> @llvm.sadd.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 302 for instruction: %V4I64 = call <4 x i64> @llvm.sadd.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1046 for instruction: %V8I64 = call <8 x i64> @llvm.sadd.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I32 = call i32 @llvm.sadd.sat.i32(i32 undef, i32 undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V4I32 = call <4 x i32> @llvm.sadd.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %V8I32 = call <8 x i32> @llvm.sadd.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 62 for instruction: %V16I32 = call <16 x i32> @llvm.sadd.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I16 = call i16 @llvm.sadd.sat.i16(i16 undef, i16 undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I16 = call <8 x i16> @llvm.sadd.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %V16I16 = call <16 x i16> @llvm.sadd.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 68 for instruction: %V32I16 = call <32 x i16> @llvm.sadd.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I8 = call i8 @llvm.sadd.sat.i8(i8 undef, i8 undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V16I8 = call <16 x i8> @llvm.sadd.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 40 for instruction: %V32I8 = call <32 x i8> @llvm.sadd.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 80 for instruction: %V64I8 = call <64 x i8> @llvm.sadd.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; V8M-SIZE-LABEL: 'add'
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.sadd.sat.i64(i64 undef, i64 undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2I64 = call <2 x i64> @llvm.sadd.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I64 = call <4 x i64> @llvm.sadd.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I64 = call <8 x i64> @llvm.sadd.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.sadd.sat.i32(i32 undef, i32 undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I32 = call <4 x i32> @llvm.sadd.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I32 = call <8 x i32> @llvm.sadd.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I32 = call <16 x i32> @llvm.sadd.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.sadd.sat.i16(i16 undef, i16 undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I16 = call <8 x i16> @llvm.sadd.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I16 = call <16 x i16> @llvm.sadd.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I16 = call <32 x i16> @llvm.sadd.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.sadd.sat.i8(i8 undef, i8 undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I8 = call <16 x i8> @llvm.sadd.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I8 = call <32 x i8> @llvm.sadd.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V64I8 = call <64 x i8> @llvm.sadd.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
; NEON-SIZE-LABEL: 'add'
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.sadd.sat.i64(i64 undef, i64 undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2I64 = call <2 x i64> @llvm.sadd.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I64 = call <4 x i64> @llvm.sadd.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I64 = call <8 x i64> @llvm.sadd.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.sadd.sat.i32(i32 undef, i32 undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I32 = call <4 x i32> @llvm.sadd.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I32 = call <8 x i32> @llvm.sadd.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I32 = call <16 x i32> @llvm.sadd.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.sadd.sat.i16(i16 undef, i16 undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I16 = call <8 x i16> @llvm.sadd.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I16 = call <16 x i16> @llvm.sadd.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I16 = call <32 x i16> @llvm.sadd.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.sadd.sat.i8(i8 undef, i8 undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I8 = call <16 x i8> @llvm.sadd.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I8 = call <32 x i8> @llvm.sadd.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V64I8 = call <64 x i8> @llvm.sadd.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
; MVE-SIZE-LABEL: 'add'
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.sadd.sat.i64(i64 undef, i64 undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2I64 = call <2 x i64> @llvm.sadd.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I64 = call <4 x i64> @llvm.sadd.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I64 = call <8 x i64> @llvm.sadd.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.sadd.sat.i32(i32 undef, i32 undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I32 = call <4 x i32> @llvm.sadd.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I32 = call <8 x i32> @llvm.sadd.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I32 = call <16 x i32> @llvm.sadd.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.sadd.sat.i16(i16 undef, i16 undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I16 = call <8 x i16> @llvm.sadd.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I16 = call <16 x i16> @llvm.sadd.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I16 = call <32 x i16> @llvm.sadd.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.sadd.sat.i8(i8 undef, i8 undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I8 = call <16 x i8> @llvm.sadd.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I8 = call <32 x i8> @llvm.sadd.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V64I8 = call <64 x i8> @llvm.sadd.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
  %I64 = call i64 @llvm.sadd.sat.i64(i64 undef, i64 undef)
  %V2I64 = call <2 x i64> @llvm.sadd.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
  %V4I64 = call <4 x i64> @llvm.sadd.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
  %V8I64 = call <8 x i64> @llvm.sadd.sat.v8i64(<8 x i64> undef, <8 x i64> undef)

  %I32 = call i32 @llvm.sadd.sat.i32(i32 undef, i32 undef)
  %V4I32  = call <4 x i32>  @llvm.sadd.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
  %V8I32  = call <8 x i32>  @llvm.sadd.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
  %V16I32 = call <16 x i32> @llvm.sadd.sat.v16i32(<16 x i32> undef, <16 x i32> undef)

  %I16 = call i16 @llvm.sadd.sat.i16(i16 undef, i16 undef)
  %V8I16  = call <8 x i16>  @llvm.sadd.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
  %V16I16 = call <16 x i16> @llvm.sadd.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
  %V32I16 = call <32 x i16> @llvm.sadd.sat.v32i16(<32 x i16> undef, <32 x i16> undef)

  %I8 = call i8 @llvm.sadd.sat.i8(i8 undef, i8 undef)
  %V16I8 = call <16 x i8> @llvm.sadd.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
  %V32I8 = call <32 x i8> @llvm.sadd.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
  %V64I8 = call <64 x i8> @llvm.sadd.sat.v64i8(<64 x i8> undef, <64 x i8> undef)

  ret i32 undef
}

declare i64        @llvm.ssub.sat.i64(i64, i64)
declare <2 x i64>  @llvm.ssub.sat.v2i64(<2 x i64>, <2 x i64>)
declare <4 x i64>  @llvm.ssub.sat.v4i64(<4 x i64>, <4 x i64>)
declare <8 x i64>  @llvm.ssub.sat.v8i64(<8 x i64>, <8 x i64>)

declare i32        @llvm.ssub.sat.i32(i32, i32)
declare <4 x i32>  @llvm.ssub.sat.v4i32(<4 x i32>, <4 x i32>)
declare <8 x i32>  @llvm.ssub.sat.v8i32(<8 x i32>, <8 x i32>)
declare <16 x i32> @llvm.ssub.sat.v16i32(<16 x i32>, <16 x i32>)

declare i16        @llvm.ssub.sat.i16(i16, i16)
declare <8 x i16>  @llvm.ssub.sat.v8i16(<8 x i16>, <8 x i16>)
declare <16 x i16> @llvm.ssub.sat.v16i16(<16 x i16>, <16 x i16>)
declare <32 x i16> @llvm.ssub.sat.v32i16(<32 x i16>, <32 x i16>)

declare i8         @llvm.ssub.sat.i8(i8,  i8)
declare <16 x i8>  @llvm.ssub.sat.v16i8(<16 x i8>, <16 x i8>)
declare <32 x i8>  @llvm.ssub.sat.v32i8(<32 x i8>, <32 x i8>)
declare <64 x i8>  @llvm.ssub.sat.v64i8(<64 x i8>, <64 x i8>)

define i32 @sub(i32 %arg) {
; V8M-RECIP-LABEL: 'sub'
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 13 for instruction: %I64 = call i64 @llvm.ssub.sat.i64(i64 undef, i64 undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 54 for instruction: %V2I64 = call <2 x i64> @llvm.ssub.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 108 for instruction: %V4I64 = call <4 x i64> @llvm.ssub.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 216 for instruction: %V8I64 = call <8 x i64> @llvm.ssub.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I32 = call i32 @llvm.ssub.sat.i32(i32 undef, i32 undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 72 for instruction: %V4I32 = call <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 144 for instruction: %V8I32 = call <8 x i32> @llvm.ssub.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 288 for instruction: %V16I32 = call <16 x i32> @llvm.ssub.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I16 = call i16 @llvm.ssub.sat.i16(i16 undef, i16 undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 144 for instruction: %V8I16 = call <8 x i16> @llvm.ssub.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 288 for instruction: %V16I16 = call <16 x i16> @llvm.ssub.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 576 for instruction: %V32I16 = call <32 x i16> @llvm.ssub.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I8 = call i8 @llvm.ssub.sat.i8(i8 undef, i8 undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 288 for instruction: %V16I8 = call <16 x i8> @llvm.ssub.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 576 for instruction: %V32I8 = call <32 x i8> @llvm.ssub.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 1152 for instruction: %V64I8 = call <64 x i8> @llvm.ssub.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; V8M-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; NEON-RECIP-LABEL: 'sub'
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 13 for instruction: %I64 = call i64 @llvm.ssub.sat.i64(i64 undef, i64 undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V2I64 = call <2 x i64> @llvm.ssub.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 51 for instruction: %V4I64 = call <4 x i64> @llvm.ssub.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 123 for instruction: %V8I64 = call <8 x i64> @llvm.ssub.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I32 = call i32 @llvm.ssub.sat.i32(i32 undef, i32 undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V4I32 = call <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %V8I32 = call <8 x i32> @llvm.ssub.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 31 for instruction: %V16I32 = call <16 x i32> @llvm.ssub.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I16 = call i16 @llvm.ssub.sat.i16(i16 undef, i16 undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V8I16 = call <8 x i16> @llvm.ssub.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 17 for instruction: %V16I16 = call <16 x i16> @llvm.ssub.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %V32I16 = call <32 x i16> @llvm.ssub.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I8 = call i8 @llvm.ssub.sat.i8(i8 undef, i8 undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %V16I8 = call <16 x i8> @llvm.ssub.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V32I8 = call <32 x i8> @llvm.ssub.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 40 for instruction: %V64I8 = call <64 x i8> @llvm.ssub.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; NEON-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; MVE-RECIP-LABEL: 'sub'
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 13 for instruction: %I64 = call i64 @llvm.ssub.sat.i64(i64 undef, i64 undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 118 for instruction: %V2I64 = call <2 x i64> @llvm.ssub.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 302 for instruction: %V4I64 = call <4 x i64> @llvm.ssub.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 1046 for instruction: %V8I64 = call <8 x i64> @llvm.ssub.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I32 = call i32 @llvm.ssub.sat.i32(i32 undef, i32 undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V4I32 = call <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %V8I32 = call <8 x i32> @llvm.ssub.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 62 for instruction: %V16I32 = call <16 x i32> @llvm.ssub.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I16 = call i16 @llvm.ssub.sat.i16(i16 undef, i16 undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V8I16 = call <8 x i16> @llvm.ssub.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 34 for instruction: %V16I16 = call <16 x i16> @llvm.ssub.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 68 for instruction: %V32I16 = call <32 x i16> @llvm.ssub.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 10 for instruction: %I8 = call i8 @llvm.ssub.sat.i8(i8 undef, i8 undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 20 for instruction: %V16I8 = call <16 x i8> @llvm.ssub.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 40 for instruction: %V32I8 = call <32 x i8> @llvm.ssub.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 80 for instruction: %V64I8 = call <64 x i8> @llvm.ssub.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; MVE-RECIP-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret i32 undef
;
; V8M-SIZE-LABEL: 'sub'
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.ssub.sat.i64(i64 undef, i64 undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2I64 = call <2 x i64> @llvm.ssub.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I64 = call <4 x i64> @llvm.ssub.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I64 = call <8 x i64> @llvm.ssub.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.ssub.sat.i32(i32 undef, i32 undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I32 = call <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I32 = call <8 x i32> @llvm.ssub.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I32 = call <16 x i32> @llvm.ssub.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.ssub.sat.i16(i16 undef, i16 undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I16 = call <8 x i16> @llvm.ssub.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I16 = call <16 x i16> @llvm.ssub.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I16 = call <32 x i16> @llvm.ssub.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.ssub.sat.i8(i8 undef, i8 undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I8 = call <16 x i8> @llvm.ssub.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I8 = call <32 x i8> @llvm.ssub.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V64I8 = call <64 x i8> @llvm.ssub.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; V8M-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
; NEON-SIZE-LABEL: 'sub'
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.ssub.sat.i64(i64 undef, i64 undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2I64 = call <2 x i64> @llvm.ssub.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I64 = call <4 x i64> @llvm.ssub.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I64 = call <8 x i64> @llvm.ssub.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.ssub.sat.i32(i32 undef, i32 undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I32 = call <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I32 = call <8 x i32> @llvm.ssub.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I32 = call <16 x i32> @llvm.ssub.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.ssub.sat.i16(i16 undef, i16 undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I16 = call <8 x i16> @llvm.ssub.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I16 = call <16 x i16> @llvm.ssub.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I16 = call <32 x i16> @llvm.ssub.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.ssub.sat.i8(i8 undef, i8 undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I8 = call <16 x i8> @llvm.ssub.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I8 = call <32 x i8> @llvm.ssub.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V64I8 = call <64 x i8> @llvm.ssub.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; NEON-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
; MVE-SIZE-LABEL: 'sub'
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I64 = call i64 @llvm.ssub.sat.i64(i64 undef, i64 undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V2I64 = call <2 x i64> @llvm.ssub.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I64 = call <4 x i64> @llvm.ssub.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I64 = call <8 x i64> @llvm.ssub.sat.v8i64(<8 x i64> undef, <8 x i64> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I32 = call i32 @llvm.ssub.sat.i32(i32 undef, i32 undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V4I32 = call <4 x i32> @llvm.ssub.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I32 = call <8 x i32> @llvm.ssub.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I32 = call <16 x i32> @llvm.ssub.sat.v16i32(<16 x i32> undef, <16 x i32> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I16 = call i16 @llvm.ssub.sat.i16(i16 undef, i16 undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V8I16 = call <8 x i16> @llvm.ssub.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I16 = call <16 x i16> @llvm.ssub.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I16 = call <32 x i16> @llvm.ssub.sat.v32i16(<32 x i16> undef, <32 x i16> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %I8 = call i8 @llvm.ssub.sat.i8(i8 undef, i8 undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V16I8 = call <16 x i8> @llvm.ssub.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V32I8 = call <32 x i8> @llvm.ssub.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %V64I8 = call <64 x i8> @llvm.ssub.sat.v64i8(<64 x i8> undef, <64 x i8> undef)
; MVE-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret i32 undef
;
  %I64 = call i64 @llvm.ssub.sat.i64(i64 undef, i64 undef)
  %V2I64 = call <2 x i64> @llvm.ssub.sat.v2i64(<2 x i64> undef, <2 x i64> undef)
  %V4I64 = call <4 x i64> @llvm.ssub.sat.v4i64(<4 x i64> undef, <4 x i64> undef)
  %V8I64 = call <8 x i64> @llvm.ssub.sat.v8i64(<8 x i64> undef, <8 x i64> undef)

  %I32 = call i32 @llvm.ssub.sat.i32(i32 undef, i32 undef)
  %V4I32  = call <4 x i32>  @llvm.ssub.sat.v4i32(<4 x i32> undef, <4 x i32> undef)
  %V8I32  = call <8 x i32>  @llvm.ssub.sat.v8i32(<8 x i32> undef, <8 x i32> undef)
  %V16I32 = call <16 x i32> @llvm.ssub.sat.v16i32(<16 x i32> undef, <16 x i32> undef)

  %I16 = call i16 @llvm.ssub.sat.i16(i16 undef, i16 undef)
  %V8I16  = call <8 x i16>  @llvm.ssub.sat.v8i16(<8 x i16> undef, <8 x i16> undef)
  %V16I16 = call <16 x i16> @llvm.ssub.sat.v16i16(<16 x i16> undef, <16 x i16> undef)
  %V32I16 = call <32 x i16> @llvm.ssub.sat.v32i16(<32 x i16> undef, <32 x i16> undef)

  %I8 = call i8 @llvm.ssub.sat.i8(i8 undef, i8 undef)
  %V16I8 = call <16 x i8> @llvm.ssub.sat.v16i8(<16 x i8> undef, <16 x i8> undef)
  %V32I8 = call <32 x i8> @llvm.ssub.sat.v32i8(<32 x i8> undef, <32 x i8> undef)
  %V64I8 = call <64 x i8> @llvm.ssub.sat.v64i8(<64 x i8> undef, <64 x i8> undef)

  ret i32 undef
}
