; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -lower-matrix-intrinsics -S < %s | FileCheck  %s
; RUN: opt -passes='lower-matrix-intrinsics' -S < %s | FileCheck %s

; Check that we do not emit shufflevectors to flatten the result of the
; transpose and store the columns directly.
define void @transpose_store(<8 x double> %a, <8 x double>* %Ptr) {
; CHECK-LABEL: @transpose_store(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x double> [[A:%.*]], <8 x double> undef, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    [[SPLIT2:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <2 x i32> <i32 4, i32 5>
; CHECK-NEXT:    [[SPLIT3:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <2 x i32> <i32 6, i32 7>
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <2 x double> [[SPLIT]], i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x double> undef, double [[TMP0]], i64 0
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x double> [[SPLIT1]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x double> [[TMP1]], double [[TMP2]], i64 1
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x double> [[SPLIT2]], i64 0
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <4 x double> [[TMP3]], double [[TMP4]], i64 2
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x double> [[SPLIT3]], i64 0
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x double> [[TMP5]], double [[TMP6]], i64 3
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <2 x double> [[SPLIT]], i64 1
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <4 x double> undef, double [[TMP8]], i64 0
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <2 x double> [[SPLIT1]], i64 1
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <4 x double> [[TMP9]], double [[TMP10]], i64 1
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <2 x double> [[SPLIT2]], i64 1
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <4 x double> [[TMP11]], double [[TMP12]], i64 2
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <2 x double> [[SPLIT3]], i64 1
; CHECK-NEXT:    [[TMP15:%.*]] = insertelement <4 x double> [[TMP13]], double [[TMP14]], i64 3
; CHECK-NEXT:    [[TMP16:%.*]] = bitcast <8 x double>* [[PTR:%.*]] to double*
; CHECK-NEXT:    [[VEC_CAST:%.*]] = bitcast double* [[TMP16]] to <4 x double>*
; CHECK-NEXT:    store <4 x double> [[TMP7]], <4 x double>* [[VEC_CAST]], align 8
; CHECK-NEXT:    [[VEC_GEP:%.*]] = getelementptr double, double* [[TMP16]], i32 4
; CHECK-NEXT:    [[VEC_CAST4:%.*]] = bitcast double* [[VEC_GEP]] to <4 x double>*
; CHECK-NEXT:    store <4 x double> [[TMP15]], <4 x double>* [[VEC_CAST4]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %c  = call <8 x double> @llvm.matrix.transpose(<8 x double> %a, i32 2, i32 4)
  store <8 x double> %c, <8 x double>* %Ptr, align 8
  ret void
}

declare <8 x double> @llvm.matrix.transpose(<8 x double>, i32, i32)

define <8 x double> @transpose_fadd(<8 x double> %a) {
; CHECK-LABEL: @transpose_fadd(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x double> [[A:%.*]], <8 x double> undef, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    [[SPLIT2:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <2 x i32> <i32 4, i32 5>
; CHECK-NEXT:    [[SPLIT3:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <2 x i32> <i32 6, i32 7>
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <2 x double> [[SPLIT]], i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x double> undef, double [[TMP0]], i64 0
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x double> [[SPLIT1]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x double> [[TMP1]], double [[TMP2]], i64 1
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x double> [[SPLIT2]], i64 0
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <4 x double> [[TMP3]], double [[TMP4]], i64 2
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x double> [[SPLIT3]], i64 0
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x double> [[TMP5]], double [[TMP6]], i64 3
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <2 x double> [[SPLIT]], i64 1
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <4 x double> undef, double [[TMP8]], i64 0
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <2 x double> [[SPLIT1]], i64 1
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <4 x double> [[TMP9]], double [[TMP10]], i64 1
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <2 x double> [[SPLIT2]], i64 1
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <4 x double> [[TMP11]], double [[TMP12]], i64 2
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <2 x double> [[SPLIT3]], i64 1
; CHECK-NEXT:    [[TMP15:%.*]] = insertelement <4 x double> [[TMP13]], double [[TMP14]], i64 3
; CHECK-NEXT:    [[SPLIT4:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[SPLIT5:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP16:%.*]] = fadd <4 x double> [[TMP7]], [[SPLIT4]]
; CHECK-NEXT:    [[TMP17:%.*]] = fadd <4 x double> [[TMP15]], [[SPLIT5]]
; CHECK-NEXT:    [[TMP18:%.*]] = shufflevector <4 x double> [[TMP16]], <4 x double> [[TMP17]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    ret <8 x double> [[TMP18]]
;
entry:
  %c  = call <8 x double> @llvm.matrix.transpose(<8 x double> %a, i32 2, i32 4)
  %res = fadd <8 x double> %c, %a
  ret <8 x double> %res
}

define <8 x double> @transpose_fmul(<8 x double> %a) {
; CHECK-LABEL: @transpose_fmul(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SPLIT:%.*]] = shufflevector <8 x double> [[A:%.*]], <8 x double> undef, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[SPLIT1:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    [[SPLIT2:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <2 x i32> <i32 4, i32 5>
; CHECK-NEXT:    [[SPLIT3:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <2 x i32> <i32 6, i32 7>
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <2 x double> [[SPLIT]], i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x double> undef, double [[TMP0]], i64 0
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x double> [[SPLIT1]], i64 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x double> [[TMP1]], double [[TMP2]], i64 1
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x double> [[SPLIT2]], i64 0
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <4 x double> [[TMP3]], double [[TMP4]], i64 2
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x double> [[SPLIT3]], i64 0
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <4 x double> [[TMP5]], double [[TMP6]], i64 3
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <2 x double> [[SPLIT]], i64 1
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <4 x double> undef, double [[TMP8]], i64 0
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <2 x double> [[SPLIT1]], i64 1
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <4 x double> [[TMP9]], double [[TMP10]], i64 1
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <2 x double> [[SPLIT2]], i64 1
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <4 x double> [[TMP11]], double [[TMP12]], i64 2
; CHECK-NEXT:    [[TMP14:%.*]] = extractelement <2 x double> [[SPLIT3]], i64 1
; CHECK-NEXT:    [[TMP15:%.*]] = insertelement <4 x double> [[TMP13]], double [[TMP14]], i64 3
; CHECK-NEXT:    [[SPLIT4:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[SPLIT5:%.*]] = shufflevector <8 x double> [[A]], <8 x double> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP16:%.*]] = fmul <4 x double> [[TMP7]], [[SPLIT4]]
; CHECK-NEXT:    [[TMP17:%.*]] = fmul <4 x double> [[TMP15]], [[SPLIT5]]
; CHECK-NEXT:    [[TMP18:%.*]] = shufflevector <4 x double> [[TMP16]], <4 x double> [[TMP17]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    ret <8 x double> [[TMP18]]
;
entry:
  %c  = call <8 x double> @llvm.matrix.transpose(<8 x double> %a, i32 2, i32 4)
  %res = fmul <8 x double> %c, %a
  ret <8 x double> %res
}
