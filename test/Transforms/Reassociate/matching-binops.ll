; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -reassociate -S | FileCheck %s

; PR37098 - https://bugs.llvm.org/show_bug.cgi?id=37098
; In all positive tests, we should reassociate binops
; to allow more factoring folds.

; There are 5 associative integer binops *
;           13 integer binops *
;           4 operand commutes =
;           260 potential variations of this fold
; for integer binops. There are another 40 for FP.
; Mix the commutation options to provide coverage using less tests.

define i8 @and_shl(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @and_shl(
; CHECK-NEXT:    [[SX:%.*]] = shl i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = shl i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = and i8 [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = and i8 [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = shl i8 %x, %shamt
  %sy = shl i8 %y, %shamt
  %a = and i8 %sx, %z
  %r = and i8 %sy, %a
  ret i8 %r
}

define i8 @or_shl(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @or_shl(
; CHECK-NEXT:    [[SX:%.*]] = shl i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = shl i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = or i8 [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = or i8 [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = shl i8 %x, %shamt
  %sy = shl i8 %y, %shamt
  %a = or i8 %sx, %z
  %r = or i8 %a, %sy
  ret i8 %r
}

define i8 @xor_shl(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @xor_shl(
; CHECK-NEXT:    [[SX:%.*]] = shl i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = shl i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = xor i8 [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = xor i8 [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = shl i8 %x, %shamt
  %sy = shl i8 %y, %shamt
  %a = xor i8 %z, %sx
  %r = xor i8 %a, %sy
  ret i8 %r
}

define i8 @and_lshr(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @and_lshr(
; CHECK-NEXT:    [[SX:%.*]] = lshr i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = lshr i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = and i8 [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = and i8 [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = lshr i8 %x, %shamt
  %sy = lshr i8 %y, %shamt
  %a = and i8 %z, %sx
  %r = and i8 %sy, %a
  ret i8 %r
}

define i8 @or_lshr(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @or_lshr(
; CHECK-NEXT:    [[SX:%.*]] = lshr i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = lshr i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = or i8 [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = or i8 [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = lshr i8 %x, %shamt
  %sy = lshr i8 %y, %shamt
  %a = or i8 %sx, %z
  %r = or i8 %sy, %a
  ret i8 %r
}

define i8 @xor_lshr(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @xor_lshr(
; CHECK-NEXT:    [[SX:%.*]] = lshr i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = lshr i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = xor i8 [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = xor i8 [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = lshr i8 %x, %shamt
  %sy = lshr i8 %y, %shamt
  %a = xor i8 %sx, %z
  %r = xor i8 %a, %sy
  ret i8 %r
}

define i8 @and_ashr(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @and_ashr(
; CHECK-NEXT:    [[SX:%.*]] = ashr i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = ashr i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = and i8 [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = and i8 [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = ashr i8 %x, %shamt
  %sy = ashr i8 %y, %shamt
  %a = and i8 %z, %sx
  %r = and i8 %a, %sy
  ret i8 %r
}

define i8 @or_ashr(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @or_ashr(
; CHECK-NEXT:    [[SX:%.*]] = ashr i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = ashr i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = or i8 [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = or i8 [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = ashr i8 %x, %shamt
  %sy = ashr i8 %y, %shamt
  %a = or i8 %z, %sx
  %r = or i8 %sy, %a
  ret i8 %r
}

; Vectors work too.

define <2 x i8> @xor_ashr(<2 x i8> %x, <2 x i8> %y, <2 x i8> %z, <2 x i8> %shamt) {
; CHECK-LABEL: @xor_ashr(
; CHECK-NEXT:    [[SX:%.*]] = ashr <2 x i8> [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = ashr <2 x i8> [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = xor <2 x i8> [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = xor <2 x i8> [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %sx = ashr <2 x i8> %x, %shamt
  %sy = ashr <2 x i8> %y, %shamt
  %a = xor <2 x i8> %sx, %z
  %r = xor <2 x i8> %a, %sy
  ret <2 x i8> %r
}

; Negative test - different logic ops

define i8 @or_and_shl(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @or_and_shl(
; CHECK-NEXT:    [[SX:%.*]] = shl i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = shl i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = or i8 [[SX]], [[Z:%.*]]
; CHECK-NEXT:    [[R:%.*]] = and i8 [[A]], [[SY]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = shl i8 %x, %shamt
  %sy = shl i8 %y, %shamt
  %a = or i8 %sx, %z
  %r = and i8 %sy, %a
  ret i8 %r
}

; Negative test - different shift ops

define i8 @or_lshr_shl(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @or_lshr_shl(
; CHECK-NEXT:    [[SX:%.*]] = lshr i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = shl i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = or i8 [[SX]], [[Z:%.*]]
; CHECK-NEXT:    [[R:%.*]] = or i8 [[A]], [[SY]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = lshr i8 %x, %shamt
  %sy = shl i8 %y, %shamt
  %a = or i8 %sx, %z
  %r = or i8 %a, %sy
  ret i8 %r
}

; Negative test - multi-use

define i8 @xor_lshr_multiuse(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @xor_lshr_multiuse(
; CHECK-NEXT:    [[SX:%.*]] = lshr i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = lshr i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[A:%.*]] = xor i8 [[SX]], [[Z:%.*]]
; CHECK-NEXT:    [[R:%.*]] = xor i8 [[A]], [[SY]]
; CHECK-NEXT:    [[R2:%.*]] = sdiv i8 [[A]], [[R]]
; CHECK-NEXT:    ret i8 [[R2]]
;
  %sx = lshr i8 %x, %shamt
  %sy = lshr i8 %y, %shamt
  %a = xor i8 %sx, %z
  %r = xor i8 %a, %sy
  %r2 = sdiv i8 %a, %r
  ret i8 %r2
}

; Math ops work too. Change instruction positions too to verify placement.
; We only care about extra uses of the first associative value - in this
; case, it's %a. Everything else can have extra uses.

declare void @use(i8)

define i8 @add_lshr(i8 %x, i8 %y, i8 %z, i8 %shamt) {
; CHECK-LABEL: @add_lshr(
; CHECK-NEXT:    [[SX:%.*]] = lshr i8 [[X:%.*]], [[SHAMT:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = lshr i8 [[Y:%.*]], [[SHAMT]]
; CHECK-NEXT:    [[TMP1:%.*]] = add i8 [[SX]], [[SY]]
; CHECK-NEXT:    [[TMP2:%.*]] = add i8 [[TMP1]], [[Z:%.*]]
; CHECK-NEXT:    call void @use(i8 [[SX]])
; CHECK-NEXT:    call void @use(i8 [[SY]])
; CHECK-NEXT:    call void @use(i8 [[TMP2]])
; CHECK-NEXT:    ret i8 [[TMP2]]
;
  %sx = lshr i8 %x, %shamt
  %a = add i8 %sx, %z
  %sy = lshr i8 %y, %shamt
  %r = add i8 %a, %sy
  call void @use(i8 %sx)
  call void @use(i8 %sy)
  call void @use(i8 %r)
  ret i8 %r
}

; Make sure wrapping flags are cleared.

define i8 @mul_sub(i8 %x, i8 %y, i8 %z, i8 %m) {
; CHECK-LABEL: @mul_sub(
; CHECK-NEXT:    [[SX:%.*]] = sub i8 [[X:%.*]], [[M:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = sub i8 [[Y:%.*]], [[M]]
; CHECK-NEXT:    [[A:%.*]] = mul i8 [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = mul i8 [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = sub i8 %x, %m
  %sy = sub i8 %y, %m
  %a = mul nsw i8 %sx, %z
  %r = mul nuw i8 %a, %sy
  ret i8 %r
}

define i8 @add_mul(i8 %x, i8 %y, i8 %z, i8 %m) {
; CHECK-LABEL: @add_mul(
; CHECK-NEXT:    [[SX:%.*]] = mul nuw i8 [[X:%.*]], 42
; CHECK-NEXT:    [[SY:%.*]] = mul nsw i8 [[M:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[A:%.*]] = add i8 [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = add i8 [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %sx = mul nuw i8 %x, 42
  %a = add nuw i8 %sx, %z
  %sy = mul nsw i8 %y, %m
  %r = add nsw i8 %sy, %a
  ret i8 %r
}

; Floating-point works too if it's not strict.
; TODO: These should not require the full 'fast' FMF.

define float @fadd_fmul(float %x, float %y, float %z, float %m) {
; CHECK-LABEL: @fadd_fmul(
; CHECK-NEXT:    [[SX:%.*]] = fmul float [[X:%.*]], [[M:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = fmul float [[Y:%.*]], [[M]]
; CHECK-NEXT:    [[A:%.*]] = fadd fast float [[SX]], [[SY]]
; CHECK-NEXT:    [[R:%.*]] = fadd fast float [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %sx = fmul float %x, %m
  %a = fadd fast float %sx, %z
  %sy = fmul float %y, %m
  %r = fadd fast float %sy, %a
  ret float %r
}

define float @fmul_fdiv(float %x, float %y, float %z, float %m) {
; CHECK-LABEL: @fmul_fdiv(
; CHECK-NEXT:    [[SX:%.*]] = fdiv float [[X:%.*]], [[M:%.*]]
; CHECK-NEXT:    [[SY:%.*]] = fdiv float [[Y:%.*]], 4.200000e+01
; CHECK-NEXT:    [[A:%.*]] = fmul fast float [[SY]], [[SX]]
; CHECK-NEXT:    [[R:%.*]] = fmul fast float [[A]], [[Z:%.*]]
; CHECK-NEXT:    ret float [[R]]
;
  %sx = fdiv float %x, %m
  %sy = fdiv float %y, 42.0
  %a = fmul fast float %z, %sx
  %r = fmul fast float %sy, %a
  ret float %r
}

; Verify that debug info for modified instructions is not invalid.

define i32 @and_shl_dbg(i32 %x, i32 %y, i32 %z, i32 %shamt) {
; CHECK-LABEL: @and_shl_dbg(
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[X:%.*]], metadata !7, metadata !DIExpression()), !dbg !20
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[Y:%.*]], metadata !13, metadata !DIExpression()), !dbg !21
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[Z:%.*]], metadata !14, metadata !DIExpression()), !dbg !22
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[SHAMT:%.*]], metadata !15, metadata !DIExpression()), !dbg !23
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[X]], [[SHAMT]], !dbg !24
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[SHL]], metadata !16, metadata !DIExpression()), !dbg !25
; CHECK-NEXT:    [[SHL1:%.*]] = shl i32 [[Y]], [[SHAMT]], !dbg !26
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[SHL1]], metadata !17, metadata !DIExpression()), !dbg !27
; CHECK-NEXT:    call void @llvm.dbg.value(metadata !2, metadata !18, metadata !DIExpression()), !dbg !28
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[SHL]], [[SHL1]], !dbg !29
; CHECK-NEXT:    [[TMP2:%.*]] = and i32 [[TMP1]], [[Z]], !dbg !29
; CHECK-NEXT:    call void @llvm.dbg.value(metadata i32 [[TMP2]], metadata !19, metadata !DIExpression()), !dbg !30
; CHECK-NEXT:    ret i32 [[TMP2]], !dbg !31
;
  call void @llvm.dbg.value(metadata i32 %x, metadata !13, metadata !DIExpression()), !dbg !21
  call void @llvm.dbg.value(metadata i32 %y, metadata !14, metadata !DIExpression()), !dbg !22
  call void @llvm.dbg.value(metadata i32 %z, metadata !15, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.value(metadata i32 %shamt, metadata !16, metadata !DIExpression()), !dbg !24
  %shl = shl i32 %x, %shamt, !dbg !25
  call void @llvm.dbg.value(metadata i32 %shl, metadata !17, metadata !DIExpression()), !dbg !26
  %shl1 = shl i32 %y, %shamt, !dbg !27
  call void @llvm.dbg.value(metadata i32 %shl1, metadata !18, metadata !DIExpression()), !dbg !28
  %and = and i32 %shl, %z, !dbg !29
  call void @llvm.dbg.value(metadata i32 %and, metadata !19, metadata !DIExpression()), !dbg !30
  %and2 = and i32 %and, %shl1, !dbg !31
  call void @llvm.dbg.value(metadata i32 %and2, metadata !20, metadata !DIExpression()), !dbg !32
  ret i32 %and2, !dbg !33
}

declare void @llvm.dbg.value(metadata, metadata, metadata)

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.0 (trunk 331069)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "ass.c", directory: "/Users/spatel/myllvm/release/bin")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 7.0.0 (trunk 331069)"}
!8 = distinct !DISubprogram(name: "and_shl_dbg", scope: !1, file: !1, line: 1, type: !9, isLocal: false, isDefinition: true, scopeLine: 1, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !12)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !11, !11, !11, !11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !{!13, !14, !15, !16, !17, !18, !19, !20}
!13 = !DILocalVariable(name: "x", arg: 1, scope: !8, file: !1, line: 1, type: !11)
!14 = !DILocalVariable(name: "y", arg: 2, scope: !8, file: !1, line: 1, type: !11)
!15 = !DILocalVariable(name: "z", arg: 3, scope: !8, file: !1, line: 1, type: !11)
!16 = !DILocalVariable(name: "shamt", arg: 4, scope: !8, file: !1, line: 1, type: !11)
!17 = !DILocalVariable(name: "sx", scope: !8, file: !1, line: 2, type: !11)
!18 = !DILocalVariable(name: "sy", scope: !8, file: !1, line: 3, type: !11)
!19 = !DILocalVariable(name: "a", scope: !8, file: !1, line: 4, type: !11)
!20 = !DILocalVariable(name: "r", scope: !8, file: !1, line: 5, type: !11)
!21 = !DILocation(line: 1, column: 21, scope: !8)
!22 = !DILocation(line: 1, column: 28, scope: !8)
!23 = !DILocation(line: 1, column: 35, scope: !8)
!24 = !DILocation(line: 1, column: 42, scope: !8)
!25 = !DILocation(line: 2, column: 14, scope: !8)
!26 = !DILocation(line: 2, column: 7, scope: !8)
!27 = !DILocation(line: 3, column: 14, scope: !8)
!28 = !DILocation(line: 3, column: 7, scope: !8)
!29 = !DILocation(line: 4, column: 14, scope: !8)
!30 = !DILocation(line: 4, column: 7, scope: !8)
!31 = !DILocation(line: 5, column: 14, scope: !8)
!32 = !DILocation(line: 5, column: 7, scope: !8)
!33 = !DILocation(line: 6, column: 3, scope: !8)

