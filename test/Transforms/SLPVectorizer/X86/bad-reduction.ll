; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -S -mtriple=x86_64-- -mattr=avx2 | FileCheck %s

%v8i8 = type { i8, i8, i8, i8, i8, i8, i8, i8 }

; https://bugs.llvm.org/show_bug.cgi?id=43146

define i64 @load_bswap(%v8i8* %p) {
; CHECK-LABEL: @load_bswap(
; CHECK-NEXT:    [[G0:%.*]] = getelementptr inbounds [[V8I8:%.*]], %v8i8* [[P:%.*]], i64 0, i32 0
; CHECK-NEXT:    [[G1:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 1
; CHECK-NEXT:    [[G2:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 2
; CHECK-NEXT:    [[G3:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 3
; CHECK-NEXT:    [[G4:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 4
; CHECK-NEXT:    [[G5:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 5
; CHECK-NEXT:    [[G6:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 6
; CHECK-NEXT:    [[G7:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 7
; CHECK-NEXT:    [[T0:%.*]] = load i8, i8* [[G0]]
; CHECK-NEXT:    [[T1:%.*]] = load i8, i8* [[G1]]
; CHECK-NEXT:    [[T2:%.*]] = load i8, i8* [[G2]]
; CHECK-NEXT:    [[T3:%.*]] = load i8, i8* [[G3]]
; CHECK-NEXT:    [[T4:%.*]] = load i8, i8* [[G4]]
; CHECK-NEXT:    [[T5:%.*]] = load i8, i8* [[G5]]
; CHECK-NEXT:    [[T6:%.*]] = load i8, i8* [[G6]]
; CHECK-NEXT:    [[T7:%.*]] = load i8, i8* [[G7]]
; CHECK-NEXT:    [[Z0:%.*]] = zext i8 [[T0]] to i64
; CHECK-NEXT:    [[Z1:%.*]] = zext i8 [[T1]] to i64
; CHECK-NEXT:    [[Z2:%.*]] = zext i8 [[T2]] to i64
; CHECK-NEXT:    [[Z3:%.*]] = zext i8 [[T3]] to i64
; CHECK-NEXT:    [[Z4:%.*]] = zext i8 [[T4]] to i64
; CHECK-NEXT:    [[Z5:%.*]] = zext i8 [[T5]] to i64
; CHECK-NEXT:    [[Z6:%.*]] = zext i8 [[T6]] to i64
; CHECK-NEXT:    [[Z7:%.*]] = zext i8 [[T7]] to i64
; CHECK-NEXT:    [[SH0:%.*]] = shl nuw i64 [[Z0]], 56
; CHECK-NEXT:    [[SH1:%.*]] = shl nuw nsw i64 [[Z1]], 48
; CHECK-NEXT:    [[SH2:%.*]] = shl nuw nsw i64 [[Z2]], 40
; CHECK-NEXT:    [[SH3:%.*]] = shl nuw nsw i64 [[Z3]], 32
; CHECK-NEXT:    [[SH4:%.*]] = shl nuw nsw i64 [[Z4]], 24
; CHECK-NEXT:    [[SH5:%.*]] = shl nuw nsw i64 [[Z5]], 16
; CHECK-NEXT:    [[SH6:%.*]] = shl nuw nsw i64 [[Z6]], 8
; CHECK-NEXT:    [[OR01:%.*]] = or i64 [[SH0]], [[SH1]]
; CHECK-NEXT:    [[OR012:%.*]] = or i64 [[OR01]], [[SH2]]
; CHECK-NEXT:    [[OR0123:%.*]] = or i64 [[OR012]], [[SH3]]
; CHECK-NEXT:    [[OR01234:%.*]] = or i64 [[OR0123]], [[SH4]]
; CHECK-NEXT:    [[OR012345:%.*]] = or i64 [[OR01234]], [[SH5]]
; CHECK-NEXT:    [[OR0123456:%.*]] = or i64 [[OR012345]], [[SH6]]
; CHECK-NEXT:    [[OR01234567:%.*]] = or i64 [[OR0123456]], [[Z7]]
; CHECK-NEXT:    ret i64 [[OR01234567]]
;
  %g0 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 0
  %g1 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 1
  %g2 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 2
  %g3 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 3
  %g4 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 4
  %g5 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 5
  %g6 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 6
  %g7 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 7

  %t0 = load i8, i8* %g0
  %t1 = load i8, i8* %g1
  %t2 = load i8, i8* %g2
  %t3 = load i8, i8* %g3
  %t4 = load i8, i8* %g4
  %t5 = load i8, i8* %g5
  %t6 = load i8, i8* %g6
  %t7 = load i8, i8* %g7

  %z0 = zext i8 %t0 to i64
  %z1 = zext i8 %t1 to i64
  %z2 = zext i8 %t2 to i64
  %z3 = zext i8 %t3 to i64
  %z4 = zext i8 %t4 to i64
  %z5 = zext i8 %t5 to i64
  %z6 = zext i8 %t6 to i64
  %z7 = zext i8 %t7 to i64

  %sh0 = shl nuw i64 %z0, 56
  %sh1 = shl nuw nsw i64 %z1, 48
  %sh2 = shl nuw nsw i64 %z2, 40
  %sh3 = shl nuw nsw i64 %z3, 32
  %sh4 = shl nuw nsw i64 %z4, 24
  %sh5 = shl nuw nsw i64 %z5, 16
  %sh6 = shl nuw nsw i64 %z6, 8
;  %sh7 = shl nuw nsw i64 %z7, 0 <-- missing phantom shift

  %or01 = or i64 %sh0, %sh1
  %or012 = or i64 %or01, %sh2
  %or0123 = or i64 %or012, %sh3
  %or01234 = or i64 %or0123, %sh4
  %or012345 = or i64 %or01234, %sh5
  %or0123456 = or i64 %or012345, %sh6
  %or01234567 = or i64 %or0123456, %z7
  ret i64 %or01234567
}

define i64 @load_bswap_nop_shift(%v8i8* %p) {
; CHECK-LABEL: @load_bswap_nop_shift(
; CHECK-NEXT:    [[G0:%.*]] = getelementptr inbounds [[V8I8:%.*]], %v8i8* [[P:%.*]], i64 0, i32 0
; CHECK-NEXT:    [[G1:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 1
; CHECK-NEXT:    [[G2:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 2
; CHECK-NEXT:    [[G3:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 3
; CHECK-NEXT:    [[G4:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 4
; CHECK-NEXT:    [[G5:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 5
; CHECK-NEXT:    [[G6:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 6
; CHECK-NEXT:    [[G7:%.*]] = getelementptr inbounds [[V8I8]], %v8i8* [[P]], i64 0, i32 7
; CHECK-NEXT:    [[T0:%.*]] = load i8, i8* [[G0]]
; CHECK-NEXT:    [[T1:%.*]] = load i8, i8* [[G1]]
; CHECK-NEXT:    [[T2:%.*]] = load i8, i8* [[G2]]
; CHECK-NEXT:    [[T3:%.*]] = load i8, i8* [[G3]]
; CHECK-NEXT:    [[T4:%.*]] = load i8, i8* [[G4]]
; CHECK-NEXT:    [[T5:%.*]] = load i8, i8* [[G5]]
; CHECK-NEXT:    [[T6:%.*]] = load i8, i8* [[G6]]
; CHECK-NEXT:    [[T7:%.*]] = load i8, i8* [[G7]]
; CHECK-NEXT:    [[Z0:%.*]] = zext i8 [[T0]] to i64
; CHECK-NEXT:    [[Z1:%.*]] = zext i8 [[T1]] to i64
; CHECK-NEXT:    [[Z2:%.*]] = zext i8 [[T2]] to i64
; CHECK-NEXT:    [[Z3:%.*]] = zext i8 [[T3]] to i64
; CHECK-NEXT:    [[Z4:%.*]] = zext i8 [[T4]] to i64
; CHECK-NEXT:    [[Z5:%.*]] = zext i8 [[T5]] to i64
; CHECK-NEXT:    [[Z6:%.*]] = zext i8 [[T6]] to i64
; CHECK-NEXT:    [[Z7:%.*]] = zext i8 [[T7]] to i64
; CHECK-NEXT:    [[SH0:%.*]] = shl nuw i64 [[Z0]], 56
; CHECK-NEXT:    [[SH1:%.*]] = shl nuw nsw i64 [[Z1]], 48
; CHECK-NEXT:    [[SH2:%.*]] = shl nuw nsw i64 [[Z2]], 40
; CHECK-NEXT:    [[SH3:%.*]] = shl nuw nsw i64 [[Z3]], 32
; CHECK-NEXT:    [[SH4:%.*]] = shl nuw nsw i64 [[Z4]], 24
; CHECK-NEXT:    [[SH5:%.*]] = shl nuw nsw i64 [[Z5]], 16
; CHECK-NEXT:    [[SH6:%.*]] = shl nuw nsw i64 [[Z6]], 8
; CHECK-NEXT:    [[SH7:%.*]] = shl nuw nsw i64 [[Z7]], 0
; CHECK-NEXT:    [[OR01:%.*]] = or i64 [[SH0]], [[SH1]]
; CHECK-NEXT:    [[OR012:%.*]] = or i64 [[OR01]], [[SH2]]
; CHECK-NEXT:    [[OR0123:%.*]] = or i64 [[OR012]], [[SH3]]
; CHECK-NEXT:    [[OR01234:%.*]] = or i64 [[OR0123]], [[SH4]]
; CHECK-NEXT:    [[OR012345:%.*]] = or i64 [[OR01234]], [[SH5]]
; CHECK-NEXT:    [[OR0123456:%.*]] = or i64 [[OR012345]], [[SH6]]
; CHECK-NEXT:    [[OR01234567:%.*]] = or i64 [[OR0123456]], [[SH7]]
; CHECK-NEXT:    ret i64 [[OR01234567]]
;
  %g0 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 0
  %g1 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 1
  %g2 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 2
  %g3 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 3
  %g4 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 4
  %g5 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 5
  %g6 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 6
  %g7 = getelementptr inbounds %v8i8, %v8i8* %p, i64 0, i32 7

  %t0 = load i8, i8* %g0
  %t1 = load i8, i8* %g1
  %t2 = load i8, i8* %g2
  %t3 = load i8, i8* %g3
  %t4 = load i8, i8* %g4
  %t5 = load i8, i8* %g5
  %t6 = load i8, i8* %g6
  %t7 = load i8, i8* %g7

  %z0 = zext i8 %t0 to i64
  %z1 = zext i8 %t1 to i64
  %z2 = zext i8 %t2 to i64
  %z3 = zext i8 %t3 to i64
  %z4 = zext i8 %t4 to i64
  %z5 = zext i8 %t5 to i64
  %z6 = zext i8 %t6 to i64
  %z7 = zext i8 %t7 to i64

  %sh0 = shl nuw i64 %z0, 56
  %sh1 = shl nuw nsw i64 %z1, 48
  %sh2 = shl nuw nsw i64 %z2, 40
  %sh3 = shl nuw nsw i64 %z3, 32
  %sh4 = shl nuw nsw i64 %z4, 24
  %sh5 = shl nuw nsw i64 %z5, 16
  %sh6 = shl nuw nsw i64 %z6, 8
  %sh7 = shl nuw nsw i64 %z7, 0

  %or01 = or i64 %sh0, %sh1
  %or012 = or i64 %or01, %sh2
  %or0123 = or i64 %or012, %sh3
  %or01234 = or i64 %or0123, %sh4
  %or012345 = or i64 %or01234, %sh5
  %or0123456 = or i64 %or012345, %sh6
  %or01234567 = or i64 %or0123456, %sh7
  ret i64 %or01234567
}

; https://bugs.llvm.org/show_bug.cgi?id=42708

define i64 @load64le(i8* %arg) {
; CHECK-LABEL: @load64le(
; CHECK-NEXT:    [[G1:%.*]] = getelementptr inbounds i8, i8* [[ARG:%.*]], i64 1
; CHECK-NEXT:    [[G2:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 2
; CHECK-NEXT:    [[G3:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 3
; CHECK-NEXT:    [[G4:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 4
; CHECK-NEXT:    [[G5:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 5
; CHECK-NEXT:    [[G6:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 6
; CHECK-NEXT:    [[G7:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 7
; CHECK-NEXT:    [[LD0:%.*]] = load i8, i8* [[ARG]], align 1
; CHECK-NEXT:    [[LD1:%.*]] = load i8, i8* [[G1]], align 1
; CHECK-NEXT:    [[LD2:%.*]] = load i8, i8* [[G2]], align 1
; CHECK-NEXT:    [[LD3:%.*]] = load i8, i8* [[G3]], align 1
; CHECK-NEXT:    [[LD4:%.*]] = load i8, i8* [[G4]], align 1
; CHECK-NEXT:    [[LD5:%.*]] = load i8, i8* [[G5]], align 1
; CHECK-NEXT:    [[LD6:%.*]] = load i8, i8* [[G6]], align 1
; CHECK-NEXT:    [[LD7:%.*]] = load i8, i8* [[G7]], align 1
; CHECK-NEXT:    [[Z0:%.*]] = zext i8 [[LD0]] to i64
; CHECK-NEXT:    [[Z1:%.*]] = zext i8 [[LD1]] to i64
; CHECK-NEXT:    [[Z2:%.*]] = zext i8 [[LD2]] to i64
; CHECK-NEXT:    [[Z3:%.*]] = zext i8 [[LD3]] to i64
; CHECK-NEXT:    [[Z4:%.*]] = zext i8 [[LD4]] to i64
; CHECK-NEXT:    [[Z5:%.*]] = zext i8 [[LD5]] to i64
; CHECK-NEXT:    [[Z6:%.*]] = zext i8 [[LD6]] to i64
; CHECK-NEXT:    [[Z7:%.*]] = zext i8 [[LD7]] to i64
; CHECK-NEXT:    [[S1:%.*]] = shl nuw nsw i64 [[Z1]], 8
; CHECK-NEXT:    [[S2:%.*]] = shl nuw nsw i64 [[Z2]], 16
; CHECK-NEXT:    [[S3:%.*]] = shl nuw nsw i64 [[Z3]], 24
; CHECK-NEXT:    [[S4:%.*]] = shl nuw nsw i64 [[Z4]], 32
; CHECK-NEXT:    [[S5:%.*]] = shl nuw nsw i64 [[Z5]], 40
; CHECK-NEXT:    [[S6:%.*]] = shl nuw nsw i64 [[Z6]], 48
; CHECK-NEXT:    [[S7:%.*]] = shl nuw i64 [[Z7]], 56
; CHECK-NEXT:    [[O1:%.*]] = or i64 [[S1]], [[Z0]]
; CHECK-NEXT:    [[O2:%.*]] = or i64 [[O1]], [[S2]]
; CHECK-NEXT:    [[O3:%.*]] = or i64 [[O2]], [[S3]]
; CHECK-NEXT:    [[O4:%.*]] = or i64 [[O3]], [[S4]]
; CHECK-NEXT:    [[O5:%.*]] = or i64 [[O4]], [[S5]]
; CHECK-NEXT:    [[O6:%.*]] = or i64 [[O5]], [[S6]]
; CHECK-NEXT:    [[O7:%.*]] = or i64 [[O6]], [[S7]]
; CHECK-NEXT:    ret i64 [[O7]]
;
  %g1 = getelementptr inbounds i8, i8* %arg, i64 1
  %g2 = getelementptr inbounds i8, i8* %arg, i64 2
  %g3 = getelementptr inbounds i8, i8* %arg, i64 3
  %g4 = getelementptr inbounds i8, i8* %arg, i64 4
  %g5 = getelementptr inbounds i8, i8* %arg, i64 5
  %g6 = getelementptr inbounds i8, i8* %arg, i64 6
  %g7 = getelementptr inbounds i8, i8* %arg, i64 7

  %ld0 = load i8, i8* %arg, align 1
  %ld1 = load i8, i8* %g1, align 1
  %ld2 = load i8, i8* %g2, align 1
  %ld3 = load i8, i8* %g3, align 1
  %ld4 = load i8, i8* %g4, align 1
  %ld5 = load i8, i8* %g5, align 1
  %ld6 = load i8, i8* %g6, align 1
  %ld7 = load i8, i8* %g7, align 1

  %z0 = zext i8 %ld0 to i64
  %z1 = zext i8 %ld1 to i64
  %z2 = zext i8 %ld2 to i64
  %z3 = zext i8 %ld3 to i64
  %z4 = zext i8 %ld4 to i64
  %z5 = zext i8 %ld5 to i64
  %z6 = zext i8 %ld6 to i64
  %z7 = zext i8 %ld7 to i64

;  %s0 = shl nuw nsw i64 %z0, 0 <-- missing phantom shift
  %s1 = shl nuw nsw i64 %z1, 8
  %s2 = shl nuw nsw i64 %z2, 16
  %s3 = shl nuw nsw i64 %z3, 24
  %s4 = shl nuw nsw i64 %z4, 32
  %s5 = shl nuw nsw i64 %z5, 40
  %s6 = shl nuw nsw i64 %z6, 48
  %s7 = shl nuw i64 %z7, 56

  %o1 = or i64 %s1, %z0
  %o2 = or i64 %o1, %s2
  %o3 = or i64 %o2, %s3
  %o4 = or i64 %o3, %s4
  %o5 = or i64 %o4, %s5
  %o6 = or i64 %o5, %s6
  %o7 = or i64 %o6, %s7
  ret i64 %o7
}

define i64 @load64le_nop_shift(i8* %arg) {
; CHECK-LABEL: @load64le_nop_shift(
; CHECK-NEXT:    [[G1:%.*]] = getelementptr inbounds i8, i8* [[ARG:%.*]], i64 1
; CHECK-NEXT:    [[G2:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 2
; CHECK-NEXT:    [[G3:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 3
; CHECK-NEXT:    [[G4:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 4
; CHECK-NEXT:    [[G5:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 5
; CHECK-NEXT:    [[G6:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 6
; CHECK-NEXT:    [[G7:%.*]] = getelementptr inbounds i8, i8* [[ARG]], i64 7
; CHECK-NEXT:    [[LD0:%.*]] = load i8, i8* [[ARG]], align 1
; CHECK-NEXT:    [[LD1:%.*]] = load i8, i8* [[G1]], align 1
; CHECK-NEXT:    [[LD2:%.*]] = load i8, i8* [[G2]], align 1
; CHECK-NEXT:    [[LD3:%.*]] = load i8, i8* [[G3]], align 1
; CHECK-NEXT:    [[LD4:%.*]] = load i8, i8* [[G4]], align 1
; CHECK-NEXT:    [[LD5:%.*]] = load i8, i8* [[G5]], align 1
; CHECK-NEXT:    [[LD6:%.*]] = load i8, i8* [[G6]], align 1
; CHECK-NEXT:    [[LD7:%.*]] = load i8, i8* [[G7]], align 1
; CHECK-NEXT:    [[Z0:%.*]] = zext i8 [[LD0]] to i64
; CHECK-NEXT:    [[Z1:%.*]] = zext i8 [[LD1]] to i64
; CHECK-NEXT:    [[Z2:%.*]] = zext i8 [[LD2]] to i64
; CHECK-NEXT:    [[Z3:%.*]] = zext i8 [[LD3]] to i64
; CHECK-NEXT:    [[Z4:%.*]] = zext i8 [[LD4]] to i64
; CHECK-NEXT:    [[Z5:%.*]] = zext i8 [[LD5]] to i64
; CHECK-NEXT:    [[Z6:%.*]] = zext i8 [[LD6]] to i64
; CHECK-NEXT:    [[Z7:%.*]] = zext i8 [[LD7]] to i64
; CHECK-NEXT:    [[S0:%.*]] = shl nuw nsw i64 [[Z0]], 0
; CHECK-NEXT:    [[S1:%.*]] = shl nuw nsw i64 [[Z1]], 8
; CHECK-NEXT:    [[S2:%.*]] = shl nuw nsw i64 [[Z2]], 16
; CHECK-NEXT:    [[S3:%.*]] = shl nuw nsw i64 [[Z3]], 24
; CHECK-NEXT:    [[S4:%.*]] = shl nuw nsw i64 [[Z4]], 32
; CHECK-NEXT:    [[S5:%.*]] = shl nuw nsw i64 [[Z5]], 40
; CHECK-NEXT:    [[S6:%.*]] = shl nuw nsw i64 [[Z6]], 48
; CHECK-NEXT:    [[S7:%.*]] = shl nuw i64 [[Z7]], 56
; CHECK-NEXT:    [[O1:%.*]] = or i64 [[S1]], [[S0]]
; CHECK-NEXT:    [[O2:%.*]] = or i64 [[O1]], [[S2]]
; CHECK-NEXT:    [[O3:%.*]] = or i64 [[O2]], [[S3]]
; CHECK-NEXT:    [[O4:%.*]] = or i64 [[O3]], [[S4]]
; CHECK-NEXT:    [[O5:%.*]] = or i64 [[O4]], [[S5]]
; CHECK-NEXT:    [[O6:%.*]] = or i64 [[O5]], [[S6]]
; CHECK-NEXT:    [[O7:%.*]] = or i64 [[O6]], [[S7]]
; CHECK-NEXT:    ret i64 [[O7]]
;
  %g1 = getelementptr inbounds i8, i8* %arg, i64 1
  %g2 = getelementptr inbounds i8, i8* %arg, i64 2
  %g3 = getelementptr inbounds i8, i8* %arg, i64 3
  %g4 = getelementptr inbounds i8, i8* %arg, i64 4
  %g5 = getelementptr inbounds i8, i8* %arg, i64 5
  %g6 = getelementptr inbounds i8, i8* %arg, i64 6
  %g7 = getelementptr inbounds i8, i8* %arg, i64 7

  %ld0 = load i8, i8* %arg, align 1
  %ld1 = load i8, i8* %g1, align 1
  %ld2 = load i8, i8* %g2, align 1
  %ld3 = load i8, i8* %g3, align 1
  %ld4 = load i8, i8* %g4, align 1
  %ld5 = load i8, i8* %g5, align 1
  %ld6 = load i8, i8* %g6, align 1
  %ld7 = load i8, i8* %g7, align 1

  %z0 = zext i8 %ld0 to i64
  %z1 = zext i8 %ld1 to i64
  %z2 = zext i8 %ld2 to i64
  %z3 = zext i8 %ld3 to i64
  %z4 = zext i8 %ld4 to i64
  %z5 = zext i8 %ld5 to i64
  %z6 = zext i8 %ld6 to i64
  %z7 = zext i8 %ld7 to i64

  %s0 = shl nuw nsw i64 %z0, 0
  %s1 = shl nuw nsw i64 %z1, 8
  %s2 = shl nuw nsw i64 %z2, 16
  %s3 = shl nuw nsw i64 %z3, 24
  %s4 = shl nuw nsw i64 %z4, 32
  %s5 = shl nuw nsw i64 %z5, 40
  %s6 = shl nuw nsw i64 %z6, 48
  %s7 = shl nuw i64 %z7, 56

  %o1 = or i64 %s1, %s0
  %o2 = or i64 %o1, %s2
  %o3 = or i64 %o2, %s3
  %o4 = or i64 %o3, %s4
  %o5 = or i64 %o4, %s5
  %o6 = or i64 %o5, %s6
  %o7 = or i64 %o6, %s7
  ret i64 %o7
}
