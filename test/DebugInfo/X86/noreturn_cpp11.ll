; RUN: %llc_dwarf -filetype=obj < %s | llvm-dwarfdump -debug-info - | FileCheck %s

; Generated by clang++ -S -c -std=c++11 --emit-llvm -g from the following C++11 source:
;class foo {
;[[noreturn]] void foo_member(){throw 1;}
;};
;
;[[ noreturn ]] void f() {
;    throw 1;
;}
;
;void func(){
;    foo object;
;}

; CHECK: DW_TAG_subprogram
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_name{{.*}}"f"
; CHECK-NOT: DW_TAG
; CHECK: DW_AT_noreturn
; CHECK: DW_TAG_class_type
; CHECK: DW_TAG_subprogram
; CHECK: DW_AT_name{{.*}}"foo_member"
; CHECK: DW_AT_noreturn
; ModuleID = 'test.cpp'

source_filename = "noreturn1.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.foo = type { i8 }

@_ZTIi = external dso_local constant i8*

; Function Attrs: noinline noreturn optnone uwtable
define dso_local void @_Z1fv() #0 !dbg !7 {
  %1 = call i8* @__cxa_allocate_exception(i64 4) #3, !dbg !10
  %2 = bitcast i8* %1 to i32*, !dbg !10
  store i32 1, i32* %2, align 16, !dbg !10
  call void @__cxa_throw(i8* %1, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #4, !dbg !10
  unreachable, !dbg !10
}

declare dso_local i8* @__cxa_allocate_exception(i64)

declare dso_local void @__cxa_throw(i8*, i8*, i8*)

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @_Z4funcv() #1 !dbg !11 {
  %1 = alloca %class.foo, align 1
  call void @llvm.dbg.declare(metadata %class.foo* %1, metadata !12, metadata !DIExpression()), !dbg !19
  ret void, !dbg !20
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

attributes #0 = { noinline noreturn optnone uwtable }
attributes #1 = { noinline nounwind optnone uwtable }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }
attributes #4 = { noreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_11, file: !1, producer: "clang version 10.0.0 (https://github.com/llvm/llvm-project.git 3fcdd25ad5566114ac3322dcbf71d3c38bfec1ed)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test.cpp", directory: "/home/sourabh/work/dwarf/c_c++/c++11")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.0 (https://github.com/llvm/llvm-project.git 3fcdd25ad5566114ac3322dcbf71d3c38bfec1ed)"}
!7 = distinct !DISubprogram(name: "f", linkageName: "_Z1fv", scope: !1, file: !1, line: 5, type: !8, scopeLine: 5, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !DILocation(line: 6, column: 5, scope: !7)
!11 = distinct !DISubprogram(name: "func", linkageName: "_Z4funcv", scope: !1, file: !1, line: 9, type: !8, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!12 = !DILocalVariable(name: "object", scope: !11, file: !1, line: 10, type: !13)
!13 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "foo", file: !1, line: 1, size: 8, flags: DIFlagTypePassByValue, elements: !14, identifier: "_ZTS3foo")
!14 = !{!15}
!15 = !DISubprogram(name: "foo_member", linkageName: "_ZN3foo10foo_memberEv", scope: !13, file: !1, line: 2, type: !16, scopeLine: 2, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!16 = !DISubroutineType(types: !17)
!17 = !{null, !18}
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!19 = !DILocation(line: 10, column: 9, scope: !11)
!20 = !DILocation(line: 11, column: 1, scope: !11)
