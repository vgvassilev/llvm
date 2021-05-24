; NOTE: To be able to use this file as an input, the string SRC_COMPDIR needs
;       replacing with a directory path by using sed or similar.

; NOTE: This file was generated by running
; clang -g -S -emit-llvm source-interleave-same-line-different-file.c -o \
;   source-interleave-same-line-different-file.ll

; ModuleID = 'source-interleave-same-line-different-file.c'
source_filename = "source-interleave-same-line-different-file.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @add1(i32 %a) #0 !dbg !7 {
entry:
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !12, metadata !DIExpression()), !dbg !13
  %0 = load i32, i32* %a.addr, align 4, !dbg !14
  %add = add nsw i32 %0, 1, !dbg !15
  ret i32 %add, !dbg !16
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @return4() #0 !dbg !17 {
entry:
  ret i32 4, !dbg !21
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "frame-pointer"="all" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 9.0.0 (https://github.com/llvm/llvm-project.git af0add6c39f7fcc641a2ae38753a9bc4eae47b28)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "source-interleave-same-line-different-file.c", directory: "SRC_COMPDIR")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 9.0.0 (https://github.com/llvm/llvm-project.git af0add6c39f7fcc641a2ae38753a9bc4eae47b28)"}
!7 = distinct !DISubprogram(name: "add1", scope: !8, file: !8, line: 1, type: !9, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "./source-interleave-header1.h", directory: "SRC_COMPDIR")
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !8, line: 1, type: !11)
!13 = !DILocation(line: 1, column: 14, scope: !7)
!14 = !DILocation(line: 1, column: 26, scope: !7)
!15 = !DILocation(line: 1, column: 28, scope: !7)
!16 = !DILocation(line: 1, column: 19, scope: !7)
!17 = distinct !DISubprogram(name: "return4", scope: !18, file: !18, line: 1, type: !19, scopeLine: 1, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!18 = !DIFile(filename: "./source-interleave-header2.h", directory: "SRC_COMPDIR")
!19 = !DISubroutineType(types: !20)
!20 = !{!11}
!21 = !DILocation(line: 1, column: 17, scope: !17)
