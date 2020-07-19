; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes --check-attributes
; RUN: opt -attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=1 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_NPM,NOT_CGSCC_OPM,NOT_TUNIT_NPM,IS__TUNIT____,IS________OPM,IS__TUNIT_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=1 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_OPM,NOT_CGSCC_NPM,NOT_TUNIT_OPM,IS__TUNIT____,IS________NPM,IS__TUNIT_NPM
; RUN: opt -attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_NPM,IS__CGSCC____,IS________OPM,IS__CGSCC_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_OPM,IS__CGSCC____,IS________NPM,IS__CGSCC_NPM

%T = type { i32, i32, i32, i32 }
@G = constant %T { i32 0, i32 0, i32 17, i32 25 }

define internal i32 @test(%T* %p) {
; IS__TUNIT____: Function Attrs: nofree nosync nounwind readonly willreturn
; IS__TUNIT____-LABEL: define {{[^@]+}}@test()
; IS__TUNIT____-NEXT:  entry:
; IS__TUNIT____-NEXT:    [[A_GEP:%.*]] = getelementptr [[T:%.*]], %T* @G, i64 0, i32 3
; IS__TUNIT____-NEXT:    [[B_GEP:%.*]] = getelementptr [[T]], %T* @G, i64 0, i32 2
; IS__TUNIT____-NEXT:    [[A:%.*]] = load i32, i32* [[A_GEP]], align 4
; IS__TUNIT____-NEXT:    [[B:%.*]] = load i32, i32* [[B_GEP]], align 4
; IS__TUNIT____-NEXT:    [[V:%.*]] = add i32 [[A]], [[B]]
; IS__TUNIT____-NEXT:    ret i32 [[V]]
;
; IS__CGSCC____: Function Attrs: nofree norecurse nosync nounwind readonly willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@test()
; IS__CGSCC____-NEXT:  entry:
; IS__CGSCC____-NEXT:    [[A_GEP:%.*]] = getelementptr [[T:%.*]], %T* @G, i64 0, i32 3
; IS__CGSCC____-NEXT:    [[B_GEP:%.*]] = getelementptr [[T]], %T* @G, i64 0, i32 2
; IS__CGSCC____-NEXT:    [[A:%.*]] = load i32, i32* [[A_GEP]], align 4
; IS__CGSCC____-NEXT:    [[B:%.*]] = load i32, i32* [[B_GEP]], align 4
; IS__CGSCC____-NEXT:    [[V:%.*]] = add i32 [[A]], [[B]]
; IS__CGSCC____-NEXT:    ret i32 [[V]]
;
entry:
  %a.gep = getelementptr %T, %T* %p, i64 0, i32 3
  %b.gep = getelementptr %T, %T* %p, i64 0, i32 2
  %a = load i32, i32* %a.gep
  %b = load i32, i32* %b.gep
  %v = add i32 %a, %b
  ret i32 %v
}

define i32 @caller() {
; IS__TUNIT____: Function Attrs: nofree nosync nounwind readonly willreturn
; IS__TUNIT____-LABEL: define {{[^@]+}}@caller()
; IS__TUNIT____-NEXT:  entry:
; IS__TUNIT____-NEXT:    [[V:%.*]] = call i32 @test()
; IS__TUNIT____-NEXT:    ret i32 [[V]]
;
; IS__CGSCC____: Function Attrs: nofree norecurse nosync nounwind readonly willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@caller()
; IS__CGSCC____-NEXT:  entry:
; IS__CGSCC____-NEXT:    [[V:%.*]] = call i32 @test()
; IS__CGSCC____-NEXT:    ret i32 [[V]]
;
entry:
  %v = call i32 @test(%T* @G)
  ret i32 %v
}
