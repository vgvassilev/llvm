; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes
; RUN: opt -max-heap-to-stack-size=-1 -attributor -enable-new-pm=0 -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=1 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_NPM,NOT_CGSCC_OPM,NOT_TUNIT_NPM,IS__TUNIT____,IS________OPM,IS__TUNIT_OPM
; RUN: opt -max-heap-to-stack-size=-1 -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=1 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_OPM,NOT_CGSCC_NPM,NOT_TUNIT_OPM,IS__TUNIT____,IS________NPM,IS__TUNIT_NPM
; RUN: opt -max-heap-to-stack-size=-1 -attributor-cgscc -enable-new-pm=0 -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_NPM,IS__CGSCC____,IS________OPM,IS__CGSCC_OPM
; RUN: opt -max-heap-to-stack-size=-1 -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_OPM,IS__CGSCC____,IS________NPM,IS__CGSCC_NPM

declare i64 @subfn(i8*) #0

declare noalias i8* @malloc(i64)
declare void @free(i8*)

define i64 @f(i64 %len) {
; IS________OPM-LABEL: define {{[^@]+}}@f
; IS________OPM-SAME: (i64 [[LEN:%.*]]) {
; IS________OPM-NEXT:  entry:
; IS________OPM-NEXT:    [[MEM:%.*]] = call noalias i8* @malloc(i64 [[LEN]])
; IS________OPM-NEXT:    [[RES:%.*]] = call i64 @subfn(i8* [[MEM]]) [[ATTR1:#.*]]
; IS________OPM-NEXT:    call void @free(i8* [[MEM]])
; IS________OPM-NEXT:    ret i64 [[RES]]
;
; IS________NPM-LABEL: define {{[^@]+}}@f
; IS________NPM-SAME: (i64 [[LEN:%.*]]) {
; IS________NPM-NEXT:  entry:
; IS________NPM-NEXT:    [[TMP0:%.*]] = alloca i8, i64 [[LEN]], align 1
; IS________NPM-NEXT:    [[RES:%.*]] = call i64 @subfn(i8* [[TMP0]]) [[ATTR1:#.*]]
; IS________NPM-NEXT:    ret i64 [[RES]]
;
entry:
  %mem = call i8* @malloc(i64 %len)
  %res = call i64 @subfn(i8* %mem)
  call void @free(i8* %mem)
  ret i64 %res
}

attributes #0 = { nounwind willreturn }
