; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -slp-threshold=-200 -mtriple=x86_64-unknown-linux -mcpu=core-avx2 -S | FileCheck %s

define void @test_add_sdiv(i32 *%arr1, i32 *%arr2, i32 %a0, i32 %a1, i32 %a2, i32 %a3) {
; CHECK-LABEL: @test_add_sdiv(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GEP1_0:%.*]] = getelementptr i32, i32* [[ARR1:%.*]], i32 0
; CHECK-NEXT:    [[GEP1_1:%.*]] = getelementptr i32, i32* [[ARR1]], i32 1
; CHECK-NEXT:    [[GEP1_2:%.*]] = getelementptr i32, i32* [[ARR1]], i32 2
; CHECK-NEXT:    [[GEP1_3:%.*]] = getelementptr i32, i32* [[ARR1]], i32 3
; CHECK-NEXT:    [[GEP2_0:%.*]] = getelementptr i32, i32* [[ARR2:%.*]], i32 0
; CHECK-NEXT:    [[GEP2_1:%.*]] = getelementptr i32, i32* [[ARR2]], i32 1
; CHECK-NEXT:    [[GEP2_2:%.*]] = getelementptr i32, i32* [[ARR2]], i32 2
; CHECK-NEXT:    [[GEP2_3:%.*]] = getelementptr i32, i32* [[ARR2]], i32 3
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[GEP1_0]] to <4 x i32>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, <4 x i32>* [[TMP0]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <4 x i32> undef, i32 [[A0:%.*]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x i32> [[TMP2]], i32 [[A1:%.*]], i32 1
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <4 x i32> [[TMP3]], i32 [[A2:%.*]], i32 2
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <4 x i32> [[TMP4]], i32 [[A3:%.*]], i32 3
; CHECK-NEXT:    [[TMP6:%.*]] = add nsw <4 x i32> [[TMP5]], <i32 1146, i32 146, i32 42, i32 0>
; CHECK-NEXT:    [[TMP7:%.*]] = add nsw <4 x i32> [[TMP1]], [[TMP6]]

;; FIXME: Last lane of TMP6 may contain zero (if %a3 is zero). In such case, the
;; next instruction would cause division by zero resulting in SIGFPE during
;; execution.
; CHECK-NEXT:    [[TMP8:%.*]] = sdiv <4 x i32> [[TMP1]], [[TMP6]]

; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <4 x i32> [[TMP7]], <4 x i32> [[TMP8]], <4 x i32> <i32 0, i32 1, i32 6, i32 3>
; CHECK-NEXT:    [[TMP10:%.*]] = bitcast i32* [[GEP2_0]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> [[TMP9]], <4 x i32>* [[TMP10]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %gep1.0 = getelementptr i32, i32* %arr1, i32 0
  %gep1.1 = getelementptr i32, i32* %arr1, i32 1
  %gep1.2 = getelementptr i32, i32* %arr1, i32 2
  %gep1.3 = getelementptr i32, i32* %arr1, i32 3
  %gep2.0 = getelementptr i32, i32* %arr2, i32 0
  %gep2.1 = getelementptr i32, i32* %arr2, i32 1
  %gep2.2 = getelementptr i32, i32* %arr2, i32 2
  %gep2.3 = getelementptr i32, i32* %arr2, i32 3
  %v0 = load i32, i32* %gep1.0
  %v1 = load i32, i32* %gep1.1
  %v2 = load i32, i32* %gep1.2
  %v3 = load i32, i32* %gep1.3
  %y0 = add nsw i32 %a0, 1146
  %y1 = add nsw i32 %a1, 146
  %y2 = add nsw i32 %a2, 42
  ;; %y3 is zero if %a3 is zero
  %y3 = add nsw i32 %a3, 0
  %res0 = add nsw i32 %v0, %y0
  %res1 = add nsw i32 %v1, %y1
  ;; As such, doing alternate shuffling would be incorrect:
  ;;   %vadd = add nsw %v[0-3], %y[0-3]
  ;;   %vsdiv = sdiv %v[0-3], %y[0-3]
  ;;   %result = shuffle %vadd, %vsdiv, <mask>
  ;; would be illegal.
  %res2 = sdiv i32 %v2, %y2
  %res3 = add nsw i32 %v3, %y3
  store i32 %res0, i32* %gep2.0
  store i32 %res1, i32* %gep2.1
  store i32 %res2, i32* %gep2.2
  store i32 %res3, i32* %gep2.3
  ret void
}

;; Similar test, but now div/rem is main opcode and not the alternate one. Same issue.
define void @test_urem_add(i32 *%arr1, i32 *%arr2, i32 %a0, i32 %a1, i32 %a2, i32 %a3) {
; CHECK-LABEL: @test_urem_add(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[GEP1_0:%.*]] = getelementptr i32, i32* [[ARR1:%.*]], i32 0
; CHECK-NEXT:    [[GEP1_1:%.*]] = getelementptr i32, i32* [[ARR1]], i32 1
; CHECK-NEXT:    [[GEP1_2:%.*]] = getelementptr i32, i32* [[ARR1]], i32 2
; CHECK-NEXT:    [[GEP1_3:%.*]] = getelementptr i32, i32* [[ARR1]], i32 3
; CHECK-NEXT:    [[GEP2_0:%.*]] = getelementptr i32, i32* [[ARR2:%.*]], i32 0
; CHECK-NEXT:    [[GEP2_1:%.*]] = getelementptr i32, i32* [[ARR2]], i32 1
; CHECK-NEXT:    [[GEP2_2:%.*]] = getelementptr i32, i32* [[ARR2]], i32 2
; CHECK-NEXT:    [[GEP2_3:%.*]] = getelementptr i32, i32* [[ARR2]], i32 3
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i32* [[GEP1_0]] to <4 x i32>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, <4 x i32>* [[TMP0]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <4 x i32> undef, i32 [[A0:%.*]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x i32> [[TMP2]], i32 [[A1:%.*]], i32 1
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <4 x i32> [[TMP3]], i32 [[A2:%.*]], i32 2
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <4 x i32> [[TMP4]], i32 [[A3:%.*]], i32 3
; CHECK-NEXT:    [[TMP6:%.*]] = add nsw <4 x i32> [[TMP5]], <i32 1146, i32 146, i32 42, i32 0>

;; FIXME: Last lane of TMP6 may contain zero (if %a3 is zero). In such case, the
;; next instruction would cause division by zero resulting in SIGFPE during
;; execution.
; CHECK-NEXT:    [[TMP7:%.*]] = urem <4 x i32> [[TMP1]], [[TMP6]]

; CHECK-NEXT:    [[TMP8:%.*]] = add nsw <4 x i32> [[TMP1]], [[TMP6]]
; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <4 x i32> [[TMP7]], <4 x i32> [[TMP8]], <4 x i32> <i32 0, i32 1, i32 2, i32 7>
; CHECK-NEXT:    [[TMP10:%.*]] = bitcast i32* [[GEP2_0]] to <4 x i32>*
; CHECK-NEXT:    store <4 x i32> [[TMP9]], <4 x i32>* [[TMP10]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %gep1.0 = getelementptr i32, i32* %arr1, i32 0
  %gep1.1 = getelementptr i32, i32* %arr1, i32 1
  %gep1.2 = getelementptr i32, i32* %arr1, i32 2
  %gep1.3 = getelementptr i32, i32* %arr1, i32 3
  %gep2.0 = getelementptr i32, i32* %arr2, i32 0
  %gep2.1 = getelementptr i32, i32* %arr2, i32 1
  %gep2.2 = getelementptr i32, i32* %arr2, i32 2
  %gep2.3 = getelementptr i32, i32* %arr2, i32 3
  %v0 = load i32, i32* %gep1.0
  %v1 = load i32, i32* %gep1.1
  %v2 = load i32, i32* %gep1.2
  %v3 = load i32, i32* %gep1.3
  %y0 = add nsw i32 %a0, 1146
  %y1 = add nsw i32 %a1, 146
  %y2 = add nsw i32 %a2, 42
  ;; %y3 is zero if %a3 is zero
  %y3 = add nsw i32 %a3, 0
  %res0 = urem i32 %v0, %y0
  %res1 = urem i32 %v1, %y1
  %res2 = urem i32 %v2, %y2
  ;; As such, doing alternate shuffling would be incorrect:
  ;;   %vurem = urem %v[0-3], %y[0-3]
  ;;   %vadd = add nsw %v[0-3], %y[0-3]
  ;;   %result = shuffle %vurem, %vadd, <mask>
  ;; would be illegal.
  %res3 = add nsw i32 %v3, %y3
  store i32 %res0, i32* %gep2.0
  store i32 %res1, i32* %gep2.1
  store i32 %res2, i32* %gep2.2
  store i32 %res3, i32* %gep2.3
  ret void
}
