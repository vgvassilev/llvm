; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=x86_64-pc-linux-gnu -mcpu=generic -mattr=sse2 -slp-vectorizer -pass-remarks-output=%t < %s -slp-threshold=-2 | FileCheck %s
; RUN: FileCheck --input-file=%t --check-prefix=YAML %s

define void @fextr(i16* %ptr) {
; CHECK-LABEL: @fextr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LD:%.*]] = load <8 x i16>, <8 x i16>* undef, align 16
; CHECK-NEXT:    [[V0:%.*]] = extractelement <8 x i16> [[LD]], i32 0
; CHECK-NEXT:    br label [[T:%.*]]
; CHECK:       t:
; CHECK-NEXT:    [[V1:%.*]] = extractelement <8 x i16> [[LD]], i32 1
; CHECK-NEXT:    [[V2:%.*]] = extractelement <8 x i16> [[LD]], i32 2
; CHECK-NEXT:    [[V3:%.*]] = extractelement <8 x i16> [[LD]], i32 3
; CHECK-NEXT:    [[V4:%.*]] = extractelement <8 x i16> [[LD]], i32 4
; CHECK-NEXT:    [[V5:%.*]] = extractelement <8 x i16> [[LD]], i32 5
; CHECK-NEXT:    [[V6:%.*]] = extractelement <8 x i16> [[LD]], i32 6
; CHECK-NEXT:    [[V7:%.*]] = extractelement <8 x i16> [[LD]], i32 7
; CHECK-NEXT:    [[P0:%.*]] = getelementptr inbounds i16, i16* [[PTR:%.*]], i64 0
; CHECK-NEXT:    [[P1:%.*]] = getelementptr inbounds i16, i16* [[PTR]], i64 1
; CHECK-NEXT:    [[P2:%.*]] = getelementptr inbounds i16, i16* [[PTR]], i64 2
; CHECK-NEXT:    [[P3:%.*]] = getelementptr inbounds i16, i16* [[PTR]], i64 3
; CHECK-NEXT:    [[P4:%.*]] = getelementptr inbounds i16, i16* [[PTR]], i64 4
; CHECK-NEXT:    [[P5:%.*]] = getelementptr inbounds i16, i16* [[PTR]], i64 5
; CHECK-NEXT:    [[P6:%.*]] = getelementptr inbounds i16, i16* [[PTR]], i64 6
; CHECK-NEXT:    [[P7:%.*]] = getelementptr inbounds i16, i16* [[PTR]], i64 7
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <8 x i16> poison, i16 [[V0]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <8 x i16> [[TMP0]], i16 [[V1]], i32 1
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <8 x i16> [[TMP1]], i16 [[V2]], i32 2
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <8 x i16> [[TMP2]], i16 [[V3]], i32 3
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <8 x i16> [[TMP3]], i16 [[V4]], i32 4
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <8 x i16> [[TMP4]], i16 [[V5]], i32 5
; CHECK-NEXT:    [[TMP6:%.*]] = insertelement <8 x i16> [[TMP5]], i16 [[V6]], i32 6
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <8 x i16> [[TMP6]], i16 [[V7]], i32 7
; CHECK-NEXT:    [[TMP8:%.*]] = insertelement <2 x i16> poison, i16 [[V0]], i32 0
; CHECK-NEXT:    [[TMP9:%.*]] = insertelement <2 x i16> [[TMP8]], i16 undef, i32 1
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <2 x i16> [[TMP9]], <2 x i16> poison, <8 x i32> <i32 0, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
; CHECK-NEXT:    [[TMP10:%.*]] = add <8 x i16> [[TMP7]], [[SHUFFLE]]
; CHECK-NEXT:    [[TMP11:%.*]] = bitcast i16* [[P0]] to <8 x i16>*
; CHECK-NEXT:    store <8 x i16> [[TMP10]], <8 x i16>* [[TMP11]], align 2
; CHECK-NEXT:    ret void
;
; YAML:      Pass:            slp-vectorizer
; YAML-NEXT: Name:            StoresVectorized
; YAML-NEXT: Function:        fextr
; YAML-NEXT: Args:
; YAML-NEXT:   - String:          'Stores SLP vectorized with cost '
; YAML-NEXT:   - Cost:            '1'
; YAML-NEXT:   - String:          ' and with tree size '
; YAML-NEXT:   - TreeSize:        '4'

entry:
  %LD = load <8 x i16>, <8 x i16>* undef
  %V0 = extractelement <8 x i16> %LD, i32 0
  br label %t

t:
  %V1 = extractelement <8 x i16> %LD, i32 1
  %V2 = extractelement <8 x i16> %LD, i32 2
  %V3 = extractelement <8 x i16> %LD, i32 3
  %V4 = extractelement <8 x i16> %LD, i32 4
  %V5 = extractelement <8 x i16> %LD, i32 5
  %V6 = extractelement <8 x i16> %LD, i32 6
  %V7 = extractelement <8 x i16> %LD, i32 7
  %P0 = getelementptr inbounds i16, i16* %ptr, i64 0
  %P1 = getelementptr inbounds i16, i16* %ptr, i64 1
  %P2 = getelementptr inbounds i16, i16* %ptr, i64 2
  %P3 = getelementptr inbounds i16, i16* %ptr, i64 3
  %P4 = getelementptr inbounds i16, i16* %ptr, i64 4
  %P5 = getelementptr inbounds i16, i16* %ptr, i64 5
  %P6 = getelementptr inbounds i16, i16* %ptr, i64 6
  %P7 = getelementptr inbounds i16, i16* %ptr, i64 7
  %A0 = add i16 %V0, %V0
  %A1 = add i16 %V1, undef
  %A2 = add i16 %V2, %V0
  %A3 = add i16 %V3, %V0
  %A4 = add i16 %V4, %V0
  %A5 = add i16 %V5, %V0
  %A6 = add i16 %V6, %V0
  %A7 = add i16 %V7, %V0
  store i16 %A0, i16* %P0, align 2
  store i16 %A1, i16* %P1, align 2
  store i16 %A2, i16* %P2, align 2
  store i16 %A3, i16* %P3, align 2
  store i16 %A4, i16* %P4, align 2
  store i16 %A5, i16* %P5, align 2
  store i16 %A6, i16* %P6, align 2
  store i16 %A7, i16* %P7, align 2
  ret void
}
