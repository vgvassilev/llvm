; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128-n32:64"

define i32 @test12(i32 %A) {
        ; Should be eliminated
; CHECK-LABEL: @test12(
; CHECK-NEXT:    [[C:%.*]] = and i32 [[A:%.*]], 8
; CHECK-NEXT:    ret i32 [[C]]
;
  %B = or i32 %A, 4
  %C = and i32 %B, 8
  ret i32 %C
}

define i32 @test13(i32 %A) {
; CHECK-LABEL: @test13(
; CHECK-NEXT:    ret i32 8
;
  %B = or i32 %A, 12
  ; Always equal to 8
  %C = and i32 %B, 8
  ret i32 %C
}

define i1 @test14(i32 %A, i32 %B) {
; CHECK-LABEL: @test14(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ne i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %C1 = icmp ult i32 %A, %B
  %C2 = icmp ugt i32 %A, %B
  ; (A < B) | (A > B) === A != B
  %D = or i1 %C1, %C2
  ret i1 %D
}

define i1 @test15(i32 %A, i32 %B) {
; CHECK-LABEL: @test15(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ule i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %C1 = icmp ult i32 %A, %B
  %C2 = icmp eq i32 %A, %B
  ; (A < B) | (A == B) === A <= B
  %D = or i1 %C1, %C2
  ret i1 %D
}

define i32 @test16(i32 %A) {
; CHECK-LABEL: @test16(
; CHECK-NEXT:    ret i32 [[A:%.*]]
;
  %B = and i32 %A, 1
  ; -2 = ~1
  %C = and i32 %A, -2
  ; %D = and int %B, -1 == %B
  %D = or i32 %B, %C
  ret i32 %D
}

define i32 @test17(i32 %A) {
; CHECK-LABEL: @test17(
; CHECK-NEXT:    [[D:%.*]] = and i32 [[A:%.*]], 5
; CHECK-NEXT:    ret i32 [[D]]
;
  %B = and i32 %A, 1
  %C = and i32 %A, 4
  ; %D = and int %B, 5
  %D = or i32 %B, %C
  ret i32 %D
}

define i1 @test18(i32 %A) {
; CHECK-LABEL: @test18(
; CHECK-NEXT:    [[A_OFF:%.*]] = add i32 [[A:%.*]], -50
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ugt i32 [[A_OFF]], 49
; CHECK-NEXT:    ret i1 [[TMP1]]
;
  %B = icmp sge i32 %A, 100
  %C = icmp slt i32 %A, 50
  %D = or i1 %B, %C
  ret i1 %D
}

; FIXME: Vectors should fold too.
define <2 x i1> @test18vec(<2 x i32> %A) {
; CHECK-LABEL: @test18vec(
; CHECK-NEXT:    [[B:%.*]] = icmp sgt <2 x i32> [[A:%.*]], <i32 99, i32 99>
; CHECK-NEXT:    [[C:%.*]] = icmp slt <2 x i32> [[A]], <i32 50, i32 50>
; CHECK-NEXT:    [[D:%.*]] = or <2 x i1> [[B]], [[C]]
; CHECK-NEXT:    ret <2 x i1> [[D]]
;
  %B = icmp sge <2 x i32> %A, <i32 100, i32 100>
  %C = icmp slt <2 x i32> %A, <i32 50, i32 50>
  %D = or <2 x i1> %B, %C
  ret <2 x i1> %D
}

define i32 @test20(i32 %x) {
; CHECK-LABEL: @test20(
; CHECK-NEXT:    ret i32 [[X:%.*]]
;
  %y = and i32 %x, 123
  %z = or i32 %y, %x
  ret i32 %z
}

define i32 @test21(i32 %t1) {
; CHECK-LABEL: @test21(
; CHECK-NEXT:    [[T1_MASK1:%.*]] = add i32 [[T1:%.*]], 2
; CHECK-NEXT:    ret i32 [[T1_MASK1]]
;
  %t1.mask1 = add i32 %t1, 2
  %t3 = and i32 %t1.mask1, -2
  %t5 = and i32 %t1, 1
  ;; add tmp.1, 2
  %t6 = or i32 %t5, %t3
  ret i32 %t6
}

define i32 @test22(i32 %B) {
; CHECK-LABEL: @test22(
; CHECK-NEXT:    ret i32 [[B:%.*]]
;
  %ELIM41 = and i32 %B, 1
  %ELIM7 = and i32 %B, -2
  %ELIM5 = or i32 %ELIM41, %ELIM7
  ret i32 %ELIM5
}

define i16 @test23(i16 %A) {
; CHECK-LABEL: @test23(
; CHECK-NEXT:    [[B:%.*]] = lshr i16 [[A:%.*]], 1
; CHECK-NEXT:    [[D:%.*]] = xor i16 [[B]], -24575
; CHECK-NEXT:    ret i16 [[D]]
;
  %B = lshr i16 %A, 1
  ;; fold or into xor
  %C = or i16 %B, -32768
  %D = xor i16 %C, 8193
  ret i16 %D
}

define <2 x i16> @test23vec(<2 x i16> %A) {
; CHECK-LABEL: @test23vec(
; CHECK-NEXT:    [[B:%.*]] = lshr <2 x i16> [[A:%.*]], <i16 1, i16 1>
; CHECK-NEXT:    [[D:%.*]] = xor <2 x i16> [[B]], <i16 -24575, i16 -24575>
; CHECK-NEXT:    ret <2 x i16> [[D]]
;
  %B = lshr <2 x i16> %A, <i16 1, i16 1>
  ;; fold or into xor
  %C = or <2 x i16> %B, <i16 -32768, i16 -32768>
  %D = xor <2 x i16> %C, <i16 8193, i16 8193>
  ret <2 x i16> %D
}

; PR3266 & PR5276
define i1 @test25(i32 %A, i32 %B) {
; CHECK-LABEL: @test25(
; CHECK-NEXT:    [[C:%.*]] = icmp ne i32 [[A:%.*]], 0
; CHECK-NEXT:    [[D:%.*]] = icmp ne i32 [[B:%.*]], 57
; CHECK-NEXT:    [[F:%.*]] = and i1 [[C]], [[D]]
; CHECK-NEXT:    ret i1 [[F]]
;
  %C = icmp eq i32 %A, 0
  %D = icmp eq i32 %B, 57
  %E = or i1 %C, %D
  %F = xor i1 %E, -1
  ret i1 %F
}

; PR5634
define i1 @test26(i32 %A, i32 %B) {
; CHECK-LABEL: @test26(
; CHECK-NEXT:    [[TMP1:%.*]] = or i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %C1 = icmp eq i32 %A, 0
  %C2 = icmp eq i32 %B, 0
  ; (A == 0) & (A == 0)   -->   (A|B) == 0
  %D = and i1 %C1, %C2
  ret i1 %D
}

define i1 @test27(i32* %A, i32* %B) {
; CHECK-LABEL: @test27(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i32* [[A:%.*]], null
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32* [[B:%.*]], null
; CHECK-NEXT:    [[E:%.*]] = and i1 [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret i1 [[E]]
;
  %C1 = ptrtoint i32* %A to i32
  %C2 = ptrtoint i32* %B to i32
  %D = or i32 %C1, %C2
  %E = icmp eq i32 %D, 0
  ret i1 %E
}

define <2 x i1> @test27vec(<2 x i32*> %A, <2 x i32*> %B) {
; CHECK-LABEL: @test27vec(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq <2 x i32*> [[A:%.*]], zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq <2 x i32*> [[B:%.*]], zeroinitializer
; CHECK-NEXT:    [[E:%.*]] = and <2 x i1> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret <2 x i1> [[E]]
;
  %C1 = ptrtoint <2 x i32*> %A to <2 x i32>
  %C2 = ptrtoint <2 x i32*> %B to <2 x i32>
  %D = or <2 x i32> %C1, %C2
  %E = icmp eq <2 x i32> %D, zeroinitializer
  ret <2 x i1> %E
}

; PR5634
define i1 @test28(i32 %A, i32 %B) {
; CHECK-LABEL: @test28(
; CHECK-NEXT:    [[TMP1:%.*]] = or i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne i32 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %C1 = icmp ne i32 %A, 0
  %C2 = icmp ne i32 %B, 0
  ; (A != 0) | (A != 0)   -->   (A|B) != 0
  %D = or i1 %C1, %C2
  ret i1 %D
}

define i1 @test29(i32* %A, i32* %B) {
; CHECK-LABEL: @test29(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ne i32* [[A:%.*]], null
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne i32* [[B:%.*]], null
; CHECK-NEXT:    [[E:%.*]] = or i1 [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret i1 [[E]]
;
  %C1 = ptrtoint i32* %A to i32
  %C2 = ptrtoint i32* %B to i32
  %D = or i32 %C1, %C2
  %E = icmp ne i32 %D, 0
  ret i1 %E
}

define <2 x i1> @test29vec(<2 x i32*> %A, <2 x i32*> %B) {
; CHECK-LABEL: @test29vec(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ne <2 x i32*> [[A:%.*]], zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne <2 x i32*> [[B:%.*]], zeroinitializer
; CHECK-NEXT:    [[E:%.*]] = or <2 x i1> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    ret <2 x i1> [[E]]
;
  %C1 = ptrtoint <2 x i32*> %A to <2 x i32>
  %C2 = ptrtoint <2 x i32*> %B to <2 x i32>
  %D = or <2 x i32> %C1, %C2
  %E = icmp ne <2 x i32> %D, zeroinitializer
  ret <2 x i1> %E
}

; PR4216
define i32 @test30(i32 %A) {
; CHECK-LABEL: @test30(
; CHECK-NEXT:    [[D:%.*]] = and i32 [[A:%.*]], -58312
; CHECK-NEXT:    [[E:%.*]] = or i32 [[D]], 32962
; CHECK-NEXT:    ret i32 [[E]]
;
  %B = or i32 %A, 32962
  %C = and i32 %A, -65536
  %D = and i32 %B, 40186
  %E = or i32 %D, %C
  ret i32 %E
}

define <2 x i32> @test30vec(<2 x i32> %A) {
; CHECK-LABEL: @test30vec(
; CHECK-NEXT:    [[C:%.*]] = and <2 x i32> [[A:%.*]], <i32 -65536, i32 -65536>
; CHECK-NEXT:    [[B:%.*]] = and <2 x i32> [[A]], <i32 7224, i32 7224>
; CHECK-NEXT:    [[D:%.*]] = or <2 x i32> [[B]], <i32 32962, i32 32962>
; CHECK-NEXT:    [[E:%.*]] = or <2 x i32> [[D]], [[C]]
; CHECK-NEXT:    ret <2 x i32> [[E]]
;
  %B = or <2 x i32> %A, <i32 32962, i32 32962>
  %C = and <2 x i32> %A, <i32 -65536, i32 -65536>
  %D = and <2 x i32> %B, <i32 40186, i32 40186>
  %E = or <2 x i32> %D, %C
  ret <2 x i32> %E
}

; PR4216
define i64 @test31(i64 %A) {
; CHECK-LABEL: @test31(
; CHECK-NEXT:    [[E:%.*]] = and i64 [[A:%.*]], 4294908984
; CHECK-NEXT:    [[F:%.*]] = or i64 [[E]], 32962
; CHECK-NEXT:    ret i64 [[F]]
;
  %B = or i64 %A, 194
  %D = and i64 %B, 250

  %C = or i64 %A, 32768
  %E = and i64 %C, 4294941696

  %F = or i64 %D, %E
  ret i64 %F
}

define <2 x i64> @test31vec(<2 x i64> %A) {
; CHECK-LABEL: @test31vec(
; CHECK-NEXT:    [[E:%.*]] = and <2 x i64> [[A:%.*]], <i64 4294908984, i64 4294908984>
; CHECK-NEXT:    [[F:%.*]] = or <2 x i64> [[E]], <i64 32962, i64 32962>
; CHECK-NEXT:    ret <2 x i64> [[F]]
;
  %B = or <2 x i64> %A, <i64 194, i64 194>
  %D = and <2 x i64> %B, <i64 250, i64 250>

  %C = or <2 x i64> %A, <i64 32768, i64 32768>
  %E = and <2 x i64> %C, <i64 4294941696, i64 4294941696>

  %F = or <2 x i64> %D, %E
  ret <2 x i64> %F
}

; codegen is mature enough to handle vector selects.
define <4 x i32> @test32(<4 x i1> %and.i1352, <4 x i32> %vecinit6.i176, <4 x i32> %vecinit6.i191) {
; CHECK-LABEL: @test32(
; CHECK-NEXT:    [[TMP1:%.*]] = select <4 x i1> [[AND_I1352:%.*]], <4 x i32> [[VECINIT6_I176:%.*]], <4 x i32> [[VECINIT6_I191:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[TMP1]]
;
  %and.i135 = sext <4 x i1> %and.i1352 to <4 x i32>
  %and.i129 = and <4 x i32> %vecinit6.i176, %and.i135
  %neg.i = xor <4 x i32> %and.i135, <i32 -1, i32 -1, i32 -1, i32 -1>
  %and.i = and <4 x i32> %vecinit6.i191, %neg.i
  %or.i = or <4 x i32> %and.i, %and.i129
  ret <4 x i32> %or.i
}

define i1 @test33(i1 %X, i1 %Y) {
; CHECK-LABEL: @test33(
; CHECK-NEXT:    [[A:%.*]] = or i1 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i1 [[A]]
;
  %a = or i1 %X, %Y
  %b = or i1 %a, %X
  ret i1 %b
}

define i32 @test34(i32 %X, i32 %Y) {
; CHECK-LABEL: @test34(
; CHECK-NEXT:    [[A:%.*]] = or i32 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[A]]
;
  %a = or i32 %X, %Y
  %b = or i32 %Y, %a
  ret i32 %b
}

define i32 @test35(i32 %a, i32 %b) {
; CHECK-LABEL: @test35(
; CHECK-NEXT:    [[TMP1:%.*]] = or i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = or i32 [[TMP1]], 1135
; CHECK-NEXT:    ret i32 [[TMP2]]
;
  %1 = or i32 %a, 1135
  %2 = or i32 %1, %b
  ret i32 %2
}

define i1 @test36(i32 %x) {
; CHECK-LABEL: @test36(
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[X:%.*]], -23
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ult i32 [[TMP1]], 3
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %cmp1 = icmp eq i32 %x, 23
  %cmp2 = icmp eq i32 %x, 24
  %ret1 = or i1 %cmp1, %cmp2
  %cmp3 = icmp eq i32 %x, 25
  %ret2 = or i1 %ret1, %cmp3
  ret i1 %ret2
}

define i32 @orsext_to_sel(i32 %x, i1 %y) {
; CHECK-LABEL: @orsext_to_sel(
; CHECK-NEXT:    [[OR:%.*]] = select i1 [[Y:%.*]], i32 -1, i32 [[X:%.*]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %sext = sext i1 %y to i32
  %or = or i32 %sext, %x
  ret i32 %or
}

define i32 @orsext_to_sel_swap(i32 %x, i1 %y) {
; CHECK-LABEL: @orsext_to_sel_swap(
; CHECK-NEXT:    [[OR:%.*]] = select i1 [[Y:%.*]], i32 -1, i32 [[X:%.*]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %sext = sext i1 %y to i32
  %or = or i32 %x, %sext
  ret i32 %or
}

define i32 @orsext_to_sel_multi_use(i32 %x, i1 %y) {
; CHECK-LABEL: @orsext_to_sel_multi_use(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i1 [[Y:%.*]] to i32
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[SEXT]], [[X:%.*]]
; CHECK-NEXT:    [[ADD:%.*]] = add i32 [[OR]], [[SEXT]]
; CHECK-NEXT:    ret i32 [[ADD]]
;
  %sext = sext i1 %y to i32
  %or = or i32 %sext, %x
  %add = add i32 %sext, %or
  ret i32 %add
}

define <2 x i32> @orsext_to_sel_vec(<2 x i32> %x, <2 x i1> %y) {
; CHECK-LABEL: @orsext_to_sel_vec(
; CHECK-NEXT:    [[OR:%.*]] = select <2 x i1> [[Y:%.*]], <2 x i32> <i32 -1, i32 -1>, <2 x i32> [[X:%.*]]
; CHECK-NEXT:    ret <2 x i32> [[OR]]
;
  %sext = sext <2 x i1> %y to <2 x i32>
  %or = or <2 x i32> %sext, %x
  ret <2 x i32> %or
}

define <2 x i132> @orsext_to_sel_vec_swap(<2 x i132> %x, <2 x i1> %y) {
; CHECK-LABEL: @orsext_to_sel_vec_swap(
; CHECK-NEXT:    [[OR:%.*]] = select <2 x i1> [[Y:%.*]], <2 x i132> <i132 -1, i132 -1>, <2 x i132> [[X:%.*]]
; CHECK-NEXT:    ret <2 x i132> [[OR]]
;
  %sext = sext <2 x i1> %y to <2 x i132>
  %or = or <2 x i132> %x, %sext
  ret <2 x i132> %or
}

; (~A & B) | A --> A | B

define i32 @test39a(i32 %a, float %b) {
; CHECK-LABEL: @test39a(
; CHECK-NEXT:    [[A1:%.*]] = mul i32 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = bitcast float [[B:%.*]] to i32
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[A1]], [[B1]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %a1 = mul i32 %a, 42          ; thwart complexity-based ordering
  %b1 = bitcast float %b to i32 ; thwart complexity-based ordering
  %nota = xor i32 %a1, -1
  %and = and i32 %nota, %b1
  %or = or i32 %and, %a1
  ret i32 %or
}

; Commute 'and' operands:
; (B & ~A) | A --> A | B

define i32 @test39b(i32 %a, float %b) {
; CHECK-LABEL: @test39b(
; CHECK-NEXT:    [[A1:%.*]] = mul i32 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = bitcast float [[B:%.*]] to i32
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[A1]], [[B1]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %a1 = mul i32 %a, 42          ; thwart complexity-based ordering
  %b1 = bitcast float %b to i32 ; thwart complexity-based ordering
  %nota = xor i32 %a1, -1
  %and = and i32 %b1, %nota
  %or = or i32 %and, %a1
  ret i32 %or
}

; Commute 'or' operands:
; A | (~A & B) --> A | B

define i32 @test39c(i32 %a, float %b) {
; CHECK-LABEL: @test39c(
; CHECK-NEXT:    [[A1:%.*]] = mul i32 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = bitcast float [[B:%.*]] to i32
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[A1]], [[B1]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %a1 = mul i32 %a, 42          ; thwart complexity-based ordering
  %b1 = bitcast float %b to i32 ; thwart complexity-based ordering
  %nota = xor i32 %a1, -1
  %and = and i32 %nota, %b1
  %or = or i32 %a1, %and
  ret i32 %or
}

; Commute 'and' operands:
; A | (B & ~A) --> A | B

define i32 @test39d(i32 %a, float %b) {
; CHECK-LABEL: @test39d(
; CHECK-NEXT:    [[A1:%.*]] = mul i32 [[A:%.*]], 42
; CHECK-NEXT:    [[B1:%.*]] = bitcast float [[B:%.*]] to i32
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[A1]], [[B1]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %a1 = mul i32 %a, 42          ; thwart complexity-based ordering
  %b1 = bitcast float %b to i32 ; thwart complexity-based ordering
  %nota = xor i32 %a1, -1
  %and = and i32 %b1, %nota
  %or = or i32 %a1, %and
  ret i32 %or
}

define i32 @test40(i32 %a, i32 %b) {
; CHECK-LABEL: @test40(
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[A:%.*]], -1
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[XOR]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %and = and i32 %a, %b
  %xor = xor i32 %a, -1
  %or = or i32 %and, %xor
  ret i32 %or
}

define i32 @test40b(i32 %a, i32 %b) {
; CHECK-LABEL: @test40b(
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[A:%.*]], -1
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[XOR]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %and = and i32 %b, %a
  %xor = xor i32 %a, -1
  %or = or i32 %and, %xor
  ret i32 %or
}

define i32 @test40c(i32 %a, i32 %b) {
; CHECK-LABEL: @test40c(
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[A:%.*]], -1
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[XOR]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %and = and i32 %b, %a
  %xor = xor i32 %a, -1
  %or = or i32 %xor, %and
  ret i32 %or
}

define i32 @test40d(i32 %a, i32 %b) {
; CHECK-LABEL: @test40d(
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[A:%.*]], -1
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[XOR]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[OR]]
;
  %and = and i32 %a, %b
  %xor = xor i32 %a, -1
  %or = or i32 %xor, %and
  ret i32 %or
}

define i32 @test45(i32 %x, i32 %y, i32 %z) {
; CHECK-LABEL: @test45(
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[X:%.*]], [[Z:%.*]]
; CHECK-NEXT:    [[OR1:%.*]] = or i32 [[TMP1]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[OR1]]
;
  %or = or i32 %y, %z
  %and = and i32 %x, %or
  %or1 = or i32 %and, %y
  ret i32 %or1
}

define i1 @test46(i8 signext %c)  {
; CHECK-LABEL: @test46(
; CHECK-NEXT:    [[TMP1:%.*]] = and i8 [[C:%.*]], -33
; CHECK-NEXT:    [[TMP2:%.*]] = add i8 [[TMP1]], -65
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult i8 [[TMP2]], 26
; CHECK-NEXT:    ret i1 [[TMP3]]
;
  %c.off = add i8 %c, -97
  %cmp1 = icmp ult i8 %c.off, 26
  %c.off17 = add i8 %c, -65
  %cmp2 = icmp ult i8 %c.off17, 26
  %or = or i1 %cmp1, %cmp2
  ret i1 %or
}

define i1 @test47(i8 signext %c)  {
; CHECK-LABEL: @test47(
; CHECK-NEXT:    [[TMP1:%.*]] = and i8 [[C:%.*]], -33
; CHECK-NEXT:    [[TMP2:%.*]] = add i8 [[TMP1]], -65
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult i8 [[TMP2]], 27
; CHECK-NEXT:    ret i1 [[TMP3]]
;
  %c.off = add i8 %c, -65
  %cmp1 = icmp ule i8 %c.off, 26
  %c.off17 = add i8 %c, -97
  %cmp2 = icmp ule i8 %c.off17, 26
  %or = or i1 %cmp1, %cmp2
  ret i1 %or
}

define i32 @test49(i1 %C) {
; CHECK-LABEL: @test49(
; CHECK-NEXT:    [[V:%.*]] = select i1 [[C:%.*]], i32 1019, i32 123
; CHECK-NEXT:    ret i32 [[V]]
;
  %A = select i1 %C, i32 1000, i32 10
  %V = or i32 %A, 123
  ret i32 %V
}

define <2 x i32> @test49vec(i1 %C) {
; CHECK-LABEL: @test49vec(
; CHECK-NEXT:    [[V:%.*]] = select i1 [[C:%.*]], <2 x i32> <i32 1019, i32 1019>, <2 x i32> <i32 123, i32 123>
; CHECK-NEXT:    ret <2 x i32> [[V]]
;
  %A = select i1 %C, <2 x i32> <i32 1000, i32 1000>, <2 x i32> <i32 10, i32 10>
  %V = or <2 x i32> %A, <i32 123, i32 123>
  ret <2 x i32> %V
}

define <2 x i32> @test49vec2(i1 %C) {
; CHECK-LABEL: @test49vec2(
; CHECK-NEXT:    [[V:%.*]] = select i1 [[C:%.*]], <2 x i32> <i32 1019, i32 2509>, <2 x i32> <i32 123, i32 351>
; CHECK-NEXT:    ret <2 x i32> [[V]]
;
  %A = select i1 %C, <2 x i32> <i32 1000, i32 2500>, <2 x i32> <i32 10, i32 30>
  %V = or <2 x i32> %A, <i32 123, i32 333>
  ret <2 x i32> %V
}

define i32 @test50(i1 %which) {
; CHECK-LABEL: @test50(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[WHICH:%.*]], label [[FINAL:%.*]], label [[DELAY:%.*]]
; CHECK:       delay:
; CHECK-NEXT:    br label [[FINAL]]
; CHECK:       final:
; CHECK-NEXT:    [[A:%.*]] = phi i32 [ 1019, [[ENTRY:%.*]] ], [ 123, [[DELAY]] ]
; CHECK-NEXT:    ret i32 [[A]]
;
entry:
  br i1 %which, label %final, label %delay

delay:
  br label %final

final:
  %A = phi i32 [ 1000, %entry ], [ 10, %delay ]
  %value = or i32 %A, 123
  ret i32 %value
}

define <2 x i32> @test50vec(i1 %which) {
; CHECK-LABEL: @test50vec(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[WHICH:%.*]], label [[FINAL:%.*]], label [[DELAY:%.*]]
; CHECK:       delay:
; CHECK-NEXT:    br label [[FINAL]]
; CHECK:       final:
; CHECK-NEXT:    [[A:%.*]] = phi <2 x i32> [ <i32 1019, i32 1019>, [[ENTRY:%.*]] ], [ <i32 123, i32 123>, [[DELAY]] ]
; CHECK-NEXT:    ret <2 x i32> [[A]]
;
entry:
  br i1 %which, label %final, label %delay

delay:
  br label %final

final:
  %A = phi <2 x i32> [ <i32 1000, i32 1000>, %entry ], [ <i32 10, i32 10>, %delay ]
  %value = or <2 x i32> %A, <i32 123, i32 123>
  ret <2 x i32> %value
}

define <2 x i32> @test50vec2(i1 %which) {
; CHECK-LABEL: @test50vec2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[WHICH:%.*]], label [[FINAL:%.*]], label [[DELAY:%.*]]
; CHECK:       delay:
; CHECK-NEXT:    br label [[FINAL]]
; CHECK:       final:
; CHECK-NEXT:    [[A:%.*]] = phi <2 x i32> [ <i32 1019, i32 2509>, [[ENTRY:%.*]] ], [ <i32 123, i32 351>, [[DELAY]] ]
; CHECK-NEXT:    ret <2 x i32> [[A]]
;
entry:
  br i1 %which, label %final, label %delay

delay:
  br label %final

final:
  %A = phi <2 x i32> [ <i32 1000, i32 2500>, %entry ], [ <i32 10, i32 30>, %delay ]
  %value = or <2 x i32> %A, <i32 123, i32 333>
  ret <2 x i32> %value
}

; In the next 4 tests, vary the types and predicates for extra coverage.
; (X | (Y & ~X)) -> (X | Y), where 'not' is an inverted cmp

define i1 @or_andn_cmp_1(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @or_andn_cmp_1(
; CHECK-NEXT:    [[X:%.*]] = icmp sgt i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = icmp ugt i32 [[C:%.*]], 42
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[OR]]
;
  %x = icmp sgt i32 %a, %b
  %x_inv = icmp sle i32 %a, %b
  %y = icmp ugt i32 %c, 42      ; thwart complexity-based ordering
  %and = and i1 %y, %x_inv
  %or = or i1 %x, %and
  ret i1 %or
}

; Commute the 'or':
; ((Y & ~X) | X) -> (X | Y), where 'not' is an inverted cmp

define <2 x i1> @or_andn_cmp_2(<2 x i32> %a, <2 x i32> %b, <2 x i32> %c) {
; CHECK-LABEL: @or_andn_cmp_2(
; CHECK-NEXT:    [[X:%.*]] = icmp sge <2 x i32> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = icmp ugt <2 x i32> [[C:%.*]], <i32 42, i32 47>
; CHECK-NEXT:    [[OR:%.*]] = or <2 x i1> [[Y]], [[X]]
; CHECK-NEXT:    ret <2 x i1> [[OR]]
;
  %x = icmp sge <2 x i32> %a, %b
  %x_inv = icmp slt <2 x i32> %a, %b
  %y = icmp ugt <2 x i32> %c, <i32 42, i32 47>      ; thwart complexity-based ordering
  %and = and <2 x i1> %y, %x_inv
  %or = or <2 x i1> %and, %x
  ret <2 x i1> %or
}

; Commute the 'and':
; (X | (~X & Y)) -> (X | Y), where 'not' is an inverted cmp

define i1 @or_andn_cmp_3(i72 %a, i72 %b, i72 %c) {
; CHECK-LABEL: @or_andn_cmp_3(
; CHECK-NEXT:    [[X:%.*]] = icmp ugt i72 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = icmp ugt i72 [[C:%.*]], 42
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[X]], [[Y]]
; CHECK-NEXT:    ret i1 [[OR]]
;
  %x = icmp ugt i72 %a, %b
  %x_inv = icmp ule i72 %a, %b
  %y = icmp ugt i72 %c, 42      ; thwart complexity-based ordering
  %and = and i1 %x_inv, %y
  %or = or i1 %x, %and
  ret i1 %or
}

; Commute the 'or':
; ((~X & Y) | X) -> (X | Y), where 'not' is an inverted cmp

define <3 x i1> @or_andn_cmp_4(<3 x i32> %a, <3 x i32> %b, <3 x i32> %c) {
; CHECK-LABEL: @or_andn_cmp_4(
; CHECK-NEXT:    [[X:%.*]] = icmp eq <3 x i32> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = icmp ugt <3 x i32> [[C:%.*]], <i32 42, i32 43, i32 -1>
; CHECK-NEXT:    [[OR:%.*]] = or <3 x i1> [[Y]], [[X]]
; CHECK-NEXT:    ret <3 x i1> [[OR]]
;
  %x = icmp eq <3 x i32> %a, %b
  %x_inv = icmp ne <3 x i32> %a, %b
  %y = icmp ugt <3 x i32> %c, <i32 42, i32 43, i32 -1>      ; thwart complexity-based ordering
  %and = and <3 x i1> %x_inv, %y
  %or = or <3 x i1> %and, %x
  ret <3 x i1> %or
}

; In the next 4 tests, vary the types and predicates for extra coverage.
; (~X | (Y & X)) -> (~X | Y), where 'not' is an inverted cmp

define i1 @orn_and_cmp_1(i37 %a, i37 %b, i37 %c) {
; CHECK-LABEL: @orn_and_cmp_1(
; CHECK-NEXT:    [[X_INV:%.*]] = icmp sle i37 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = icmp ugt i37 [[C:%.*]], 42
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[X_INV]], [[Y]]
; CHECK-NEXT:    ret i1 [[OR]]
;
  %x = icmp sgt i37 %a, %b
  %x_inv = icmp sle i37 %a, %b
  %y = icmp ugt i37 %c, 42      ; thwart complexity-based ordering
  %and = and i1 %y, %x
  %or = or i1 %x_inv, %and
  ret i1 %or
}

; Commute the 'or':
; ((Y & X) | ~X) -> (~X | Y), where 'not' is an inverted cmp

define i1 @orn_and_cmp_2(i16 %a, i16 %b, i16 %c) {
; CHECK-LABEL: @orn_and_cmp_2(
; CHECK-NEXT:    [[X_INV:%.*]] = icmp slt i16 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = icmp ugt i16 [[C:%.*]], 42
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[Y]], [[X_INV]]
; CHECK-NEXT:    ret i1 [[OR]]
;
  %x = icmp sge i16 %a, %b
  %x_inv = icmp slt i16 %a, %b
  %y = icmp ugt i16 %c, 42      ; thwart complexity-based ordering
  %and = and i1 %y, %x
  %or = or i1 %and, %x_inv
  ret i1 %or
}

; Commute the 'and':
; (~X | (X & Y)) -> (~X | Y), where 'not' is an inverted cmp

define <4 x i1> @orn_and_cmp_3(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) {
; CHECK-LABEL: @orn_and_cmp_3(
; CHECK-NEXT:    [[X_INV:%.*]] = icmp ule <4 x i32> [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = icmp ugt <4 x i32> [[C:%.*]], <i32 42, i32 0, i32 1, i32 -1>
; CHECK-NEXT:    [[OR:%.*]] = or <4 x i1> [[X_INV]], [[Y]]
; CHECK-NEXT:    ret <4 x i1> [[OR]]
;
  %x = icmp ugt <4 x i32> %a, %b
  %x_inv = icmp ule <4 x i32> %a, %b
  %y = icmp ugt <4 x i32> %c, <i32 42, i32 0, i32 1, i32 -1>      ; thwart complexity-based ordering
  %and = and <4 x i1> %x, %y
  %or = or <4 x i1> %x_inv, %and
  ret <4 x i1> %or
}

; Commute the 'or':
; ((X & Y) | ~X) -> (~X | Y), where 'not' is an inverted cmp

define i1 @orn_and_cmp_4(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @orn_and_cmp_4(
; CHECK-NEXT:    [[X_INV:%.*]] = icmp ne i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = icmp ugt i32 [[C:%.*]], 42
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[Y]], [[X_INV]]
; CHECK-NEXT:    ret i1 [[OR]]
;
  %x = icmp eq i32 %a, %b
  %x_inv = icmp ne i32 %a, %b
  %y = icmp ugt i32 %c, 42      ; thwart complexity-based ordering
  %and = and i1 %x, %y
  %or = or i1 %and, %x_inv
  ret i1 %or
}

; The constant vectors are inverses. Make sure we can turn this into a select without crashing trying to truncate the constant to 16xi1.
define <16 x i1> @test51(<16 x i1> %arg, <16 x i1> %arg1) {
; CHECK-LABEL: @test51(
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <16 x i1> [[ARG:%.*]], <16 x i1> [[ARG1:%.*]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 20, i32 5, i32 6, i32 23, i32 24, i32 9, i32 10, i32 27, i32 28, i32 29, i32 30, i32 31>
; CHECK-NEXT:    ret <16 x i1> [[TMP1]]
;
  %tmp = and <16 x i1> %arg, <i1 true, i1 true, i1 true, i1 true, i1 false, i1 true, i1 true, i1 false, i1 false, i1 true, i1 true, i1 false, i1 false, i1 false, i1 false, i1 false>
  %tmp2 = and <16 x i1> %arg1, <i1 false, i1 false, i1 false, i1 false, i1 true, i1 false, i1 false, i1 true, i1 true, i1 false, i1 false, i1 true, i1 true, i1 true, i1 true, i1 true>
  %tmp3 = or <16 x i1> %tmp, %tmp2
  ret <16 x i1> %tmp3
}
