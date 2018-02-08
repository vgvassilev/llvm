; NOTE: Assertions have been autogenerated by update_test_checks.py
; RUN: opt -instsimplify -S < %s 2>&1 -pass-remarks-analysis=.* | FileCheck %s

; Verify that warnings are emitted for the 2nd and 3rd tests.

; CHECK: remark: /tmp/s.c:1:13: Detected conflicting code assumptions.
; CHECK: remark: /tmp/s.c:4:10: Detected conflicting code assumptions.
; CHECK: remark: /tmp/s.c:5:50: Detected conflicting code assumptions.

define void @test1() {
; CHECK-LABEL: @test1(
; CHECK:         ret void
;
  call void @llvm.assume(i1 1)
  ret void

}

; The alloca guarantees that the low bits of %a are zero because of alignment.
; The assume says the opposite. The assume is processed last, so that's the 
; return value. There's no way to win (we can't undo transforms that happened
; based on half-truths), so just don't crash.

define i64 @PR31809() !dbg !7 {
; CHECK-LABEL: @PR31809(
; CHECK-NEXT:    ret i64 3
;
  %a = alloca i32
  %t1 = ptrtoint i32* %a to i64, !dbg !9
  %cond = icmp eq i64 %t1, 3
  call void @llvm.assume(i1 %cond)
  ret i64 %t1
}

; Similar to above: there's no way to know which assumption is truthful,
; so just don't crash. The second icmp+assume gets processed later, so that
; determines the return value.

define i8 @conflicting_assumptions(i8 %x) !dbg !10 {
; CHECK-LABEL: @conflicting_assumptions(
; CHECK-NEXT:    call void @llvm.assume(i1 false)
; CHECK-NEXT:    [[COND2:%.*]] = icmp eq i8 %x, 4
; CHECK-NEXT:    call void @llvm.assume(i1 [[COND2]])
; CHECK-NEXT:    ret i8 5
;
  %add = add i8 %x, 1, !dbg !11
  %cond1 = icmp eq i8 %x, 3
  call void @llvm.assume(i1 %cond1)
  %cond2 = icmp eq i8 %x, 4
  call void @llvm.assume(i1 %cond2)
  ret i8 %add
}

; Another case of conflicting assumptions. This would crash because we'd
; try to set more known bits than existed in the known bits struct.

define void @PR36270(i32 %b) !dbg !13 {
; CHECK-LABEL: @PR36270(
; CHECK-NEXT:    tail call void @llvm.assume(i1 false)
; CHECK-NEXT:    unreachable
;
  %B7 = xor i32 -1, 2147483647
  %and1 = and i32 %b, 3
  %B12 = lshr i32 %B7, %and1, !dbg !14
  %C1 = icmp ult i32 %and1, %B12
  tail call void @llvm.assume(i1 %C1)
  %cmp2 = icmp eq i32 0, %B12
  tail call void @llvm.assume(i1 %cmp2)
  unreachable
}

declare void @llvm.assume(i1) nounwind

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 4.0.0 (trunk 282540) (llvm/trunk 282542)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, enums: !2)
!1 = !DIFile(filename: "/tmp/s.c", directory: "/tmp")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"PIC Level", i32 2}
!6 = !{!"clang version 4.0.0 (trunk 282540) (llvm/trunk 282542)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 1, isOptimized: true, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !2)
!9 = !DILocation(line: 1, column: 13, scope: !7)
!10 = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 3, isOptimized: true, unit: !0, variables: !2)
!11 = !DILocation(line: 4, column: 10, scope: !10)
!12 = !DILocation(line: 4, column: 3, scope: !10)
!13 = distinct !DISubprogram(name: "PR36270", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 3, isOptimized: true, unit: !0, variables: !2)
!14 = !DILocation(line: 5, column: 50, scope: !13)

