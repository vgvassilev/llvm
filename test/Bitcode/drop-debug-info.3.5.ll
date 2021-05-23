; RUN: llvm-dis < %s.bc -o %t.ll 2>&1 | FileCheck -check-prefix=WARN %s
; RUN: FileCheck -input-file=%t.ll %s

; The bitcode paired with this test was generated by passing this file to
; llvm-dis-3.5.  This tests that llvm-dis warns correctly when reading old
; bitcode.

; CHECK-NOT: !llvm.dbg.cu
; CHECK-NOT: !dbg
; WARN: warning: ignoring debug info with an invalid version (1)
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  ret i32 0, !dbg !12
}

attributes #0 = { nounwind ssp uwtable "frame-pointer"="all" "stack-protector-buffer-size"="8" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 12, metadata !"clang version 3.5.2 (230356)", i1 false, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !"", i32 1} ; [ DW_TAG_compile_unit ] [/Users/dexonsmith/data/llvm/staging/test/Bitcode/t.c] [DW_LANG_C99]
!1 = metadata !{metadata !"t.c", metadata !"/Users/dexonsmith/data/llvm/staging/test/Bitcode"}
!2 = metadata !{}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !1, metadata !5, metadata !"main", metadata !"main", metadata !"", i32 1, metadata !6, i1 false, i1 true, i32 0, i32 0, null, i32 0, i1 false, i32 ()* @main, null, null, metadata !2, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [main]
!5 = metadata !{i32 786473, metadata !1}          ; [ DW_TAG_file_type ] [/Users/dexonsmith/data/llvm/staging/test/Bitcode/t.c]
!6 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !7, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!7 = metadata !{metadata !8}
!8 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 2}
!10 = metadata !{i32 2, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"clang version 3.5.2 (230356)"}
!12 = metadata !{i32 1, i32 14, metadata !4, null}
