; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes --check-attributes
; RUN: opt -attributor -enable-new-pm=0 -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=6 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_NPM,NOT_CGSCC_OPM,NOT_TUNIT_NPM,IS__TUNIT____,IS________OPM,IS__TUNIT_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=6 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_OPM,NOT_CGSCC_NPM,NOT_TUNIT_OPM,IS__TUNIT____,IS________NPM,IS__TUNIT_NPM
; RUN: opt -attributor-cgscc -enable-new-pm=0 -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_NPM,IS__CGSCC____,IS________OPM,IS__CGSCC_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_OPM,IS__CGSCC____,IS________NPM,IS__CGSCC_NPM

define internal i32 @deref(i32* %x) nounwind {
; IS__TUNIT_OPM: Function Attrs: argmemonly nofree nosync nounwind readonly willreturn
; IS__TUNIT_OPM-LABEL: define {{[^@]+}}@deref
; IS__TUNIT_OPM-SAME: (i32* noalias nocapture nofree noundef nonnull readonly align 4 dereferenceable(4) [[X:%.*]])
; IS__TUNIT_OPM-NEXT:  entry:
; IS__TUNIT_OPM-NEXT:    [[TMP2:%.*]] = load i32, i32* [[X]], align 4
; IS__TUNIT_OPM-NEXT:    ret i32 [[TMP2]]
;
; IS__TUNIT_NPM: Function Attrs: argmemonly nofree nosync nounwind readonly willreturn
; IS__TUNIT_NPM-LABEL: define {{[^@]+}}@deref
; IS__TUNIT_NPM-SAME: (i32 [[TMP0:%.*]])
; IS__TUNIT_NPM-NEXT:  entry:
; IS__TUNIT_NPM-NEXT:    [[X_PRIV:%.*]] = alloca i32, align 4
; IS__TUNIT_NPM-NEXT:    store i32 [[TMP0]], i32* [[X_PRIV]], align 4
; IS__TUNIT_NPM-NEXT:    [[TMP2:%.*]] = load i32, i32* [[X_PRIV]], align 4
; IS__TUNIT_NPM-NEXT:    ret i32 [[TMP2]]
;
; IS__CGSCC____: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@deref
; IS__CGSCC____-SAME: (i32* nocapture nofree noundef nonnull readonly align 4 dereferenceable(4) [[X:%.*]])
; IS__CGSCC____-NEXT:  entry:
; IS__CGSCC____-NEXT:    [[TMP2:%.*]] = load i32, i32* [[X]], align 4
; IS__CGSCC____-NEXT:    ret i32 [[TMP2]]
;
entry:
  %tmp2 = load i32, i32* %x, align 4
  ret i32 %tmp2
}

define i32 @f(i32 %x) {
; IS__TUNIT_OPM: Function Attrs: nofree nosync nounwind readnone willreturn
; IS__TUNIT_OPM-LABEL: define {{[^@]+}}@f
; IS__TUNIT_OPM-SAME: (i32 [[X:%.*]])
; IS__TUNIT_OPM-NEXT:  entry:
; IS__TUNIT_OPM-NEXT:    [[X_ADDR:%.*]] = alloca i32, align 4
; IS__TUNIT_OPM-NEXT:    store i32 [[X]], i32* [[X_ADDR]], align 4
; IS__TUNIT_OPM-NEXT:    [[TMP1:%.*]] = call i32 @deref(i32* noalias nocapture nofree noundef nonnull readonly align 4 dereferenceable(4) [[X_ADDR]])
; IS__TUNIT_OPM-NEXT:    ret i32 [[TMP1]]
;
; IS__TUNIT_NPM: Function Attrs: nofree nosync nounwind readnone willreturn
; IS__TUNIT_NPM-LABEL: define {{[^@]+}}@f
; IS__TUNIT_NPM-SAME: (i32 [[X:%.*]])
; IS__TUNIT_NPM-NEXT:  entry:
; IS__TUNIT_NPM-NEXT:    [[X_ADDR:%.*]] = alloca i32, align 4
; IS__TUNIT_NPM-NEXT:    store i32 [[X]], i32* [[X_ADDR]], align 4
; IS__TUNIT_NPM-NEXT:    [[TMP0:%.*]] = load i32, i32* [[X_ADDR]], align 4
; IS__TUNIT_NPM-NEXT:    [[TMP1:%.*]] = call i32 @deref(i32 [[TMP0]])
; IS__TUNIT_NPM-NEXT:    ret i32 [[TMP1]]
;
; IS__CGSCC____: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@f
; IS__CGSCC____-SAME: (i32 [[X:%.*]])
; IS__CGSCC____-NEXT:  entry:
; IS__CGSCC____-NEXT:    [[X_ADDR:%.*]] = alloca i32, align 4
; IS__CGSCC____-NEXT:    store i32 [[X]], i32* [[X_ADDR]], align 4
; IS__CGSCC____-NEXT:    [[TMP1:%.*]] = call i32 @deref(i32* noalias nocapture nofree noundef nonnull readonly align 4 dereferenceable(4) [[X_ADDR]])
; IS__CGSCC____-NEXT:    ret i32 [[TMP1]]
;
entry:
  %x_addr = alloca i32
  store i32 %x, i32* %x_addr, align 4
  %tmp1 = call i32 @deref( i32* %x_addr ) nounwind
  ret i32 %tmp1
}
