; RUN: llc -march=bpfel -filetype=asm -o - %s | FileCheck -check-prefixes=CHECK %s
; RUN: llc -march=bpfeb -filetype=asm -o - %s | FileCheck -check-prefixes=CHECK %s

; Source code:
;   int test() { return 0; }
; Compilation flag:
;   clang -target bpf -O2 -g -S -emit-llvm t.c

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i32 @test() local_unnamed_addr #0 !dbg !7 {
  ret i32 0, !dbg !11
}

; CHECK:             .section        .BTF,"",@progbits
; CHECK-NEXT:        .short  60319                   # 0xeb9f
; CHECK-NEXT:        .byte   1
; CHECK-NEXT:        .byte   0
; CHECK-NEXT:        .long   24
; CHECK-NEXT:        .long   0
; CHECK-NEXT:        .long   40
; CHECK-NEXT:        .long   40
; CHECK-NEXT:        .long   63
; CHECK-NEXT:        .long   0                       # BTF_KIND_FUNC_PROTO(id = 1)
; CHECK-NEXT:        .long   218103808               # 0xd000000
; CHECK-NEXT:        .long   2
; CHECK-NEXT:        .long   54                      # BTF_KIND_INT(id = 2)
; CHECK-NEXT:        .long   16777216                # 0x1000000
; CHECK-NEXT:        .long   4
; CHECK-NEXT:        .long   16777248                # 0x1000020
; CHECK-NEXT:        .long   58                      # BTF_KIND_FUNC(id = 3)
; CHECK-NEXT:        .long   201326592               # 0xc000000
; CHECK-NEXT:        .long   1
; CHECK-NEXT:        .byte   0                       # string offset=0
; CHECK-NEXT:        .ascii  ".text"                 # string offset=1
; CHECK-NEXT:        .byte   0
; CHECK-NEXT:        .ascii  "/home/yhs/tmp/t.c"     # string offset=7
; CHECK-NEXT:        .byte   0
; CHECK-NEXT:        .ascii  "typedef int (f) (int); f *g;" # string offset=25
; CHECK-NEXT:        .byte   0
; CHECK-NEXT:        .ascii  "int"                   # string offset=54
; CHECK-NEXT:        .byte   0
; CHECK-NEXT:        .ascii  "test"                  # string offset=58
; CHECK-NEXT:        .byte   0
; CHECK-NEXT:        .section        .BTF.ext,"",@progbits
; CHECK-NEXT:        .short  60319                   # 0xeb9f
; CHECK-NEXT:        .byte   1
; CHECK-NEXT:        .byte   0
; CHECK-NEXT:        .long   24
; CHECK-NEXT:        .long   0
; CHECK-NEXT:        .long   20
; CHECK-NEXT:        .long   20
; CHECK-NEXT:        .long   28
; CHECK-NEXT:        .long   8                       # FuncInfo
; CHECK-NEXT:        .long   1                       # FuncInfo section string offset=1
; CHECK-NEXT:        .long   1
; CHECK-NEXT:        .long   .Lfunc_begin0
; CHECK-NEXT:        .long   3
; CHECK-NEXT:        .long   16                      # LineInfo
; CHECK-NEXT:        .long   1                       # LineInfo section string offset=1
; CHECK-NEXT:        .long   1
; CHECK-NEXT:        .long   .Ltmp0
; CHECK-NEXT:        .long   7
; CHECK-NEXT:        .long   25
; CHECK-NEXT:        .long   1038                    # Line 1 Col 14

attributes #0 = { norecurse nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.20181009 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "/home/yhs/tmp/t.c", directory: "/home/yhs/tmp")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.20181009 "}
!7 = distinct !DISubprogram(name: "test", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 1, isOptimized: true, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocation(line: 1, column: 14, scope: !7)
