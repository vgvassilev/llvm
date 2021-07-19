; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown -basic-aa -slp-vectorizer -S | FileCheck %s
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=corei7 -basic-aa -slp-vectorizer -S | FileCheck %s
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=corei7-avx -basic-aa -slp-vectorizer -S | FileCheck %s
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=core-avx2 -basic-aa -slp-vectorizer -S | FileCheck %s

;
; dot4(float *x, float *y) - ((x[0]*y[0])+(x[1]*y[1])+(x[2]*y[2])+(x[3]*y[3]))
;

define double @dotf64(double* dereferenceable(32) %ptrx, double* dereferenceable(32) %ptry) {
; CHECK-LABEL: @dotf64(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds double, double* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds double, double* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[PTRX2:%.*]] = getelementptr inbounds double, double* [[PTRX]], i64 2
; CHECK-NEXT:    [[PTRY2:%.*]] = getelementptr inbounds double, double* [[PTRY]], i64 2
; CHECK-NEXT:    [[PTRX3:%.*]] = getelementptr inbounds double, double* [[PTRX]], i64 3
; CHECK-NEXT:    [[PTRY3:%.*]] = getelementptr inbounds double, double* [[PTRY]], i64 3
; CHECK-NEXT:    [[X0:%.*]] = load double, double* [[PTRX]], align 4
; CHECK-NEXT:    [[Y0:%.*]] = load double, double* [[PTRY]], align 4
; CHECK-NEXT:    [[X1:%.*]] = load double, double* [[PTRX1]], align 4
; CHECK-NEXT:    [[Y1:%.*]] = load double, double* [[PTRY1]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast double* [[PTRX2]] to <2 x double>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x double>, <2 x double>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast double* [[PTRY2]] to <2 x double>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x double>, <2 x double>* [[TMP3]], align 4
; CHECK-NEXT:    [[MUL0:%.*]] = fmul double [[X0]], [[Y0]]
; CHECK-NEXT:    [[MUL1:%.*]] = fmul double [[X1]], [[Y1]]
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x double> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[DOT01:%.*]] = fadd double [[MUL0]], [[MUL1]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x double> [[TMP5]], i32 0
; CHECK-NEXT:    [[DOT012:%.*]] = fadd double [[DOT01]], [[TMP6]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x double> [[TMP5]], i32 1
; CHECK-NEXT:    [[DOT0123:%.*]] = fadd double [[DOT012]], [[TMP7]]
; CHECK-NEXT:    ret double [[DOT0123]]
;
  %ptrx1 = getelementptr inbounds double, double* %ptrx, i64 1
  %ptry1 = getelementptr inbounds double, double* %ptry, i64 1
  %ptrx2 = getelementptr inbounds double, double* %ptrx, i64 2
  %ptry2 = getelementptr inbounds double, double* %ptry, i64 2
  %ptrx3 = getelementptr inbounds double, double* %ptrx, i64 3
  %ptry3 = getelementptr inbounds double, double* %ptry, i64 3
  %x0 = load double, double* %ptrx, align 4
  %y0 = load double, double* %ptry, align 4
  %x1 = load double, double* %ptrx1, align 4
  %y1 = load double, double* %ptry1, align 4
  %x2 = load double, double* %ptrx2, align 4
  %y2 = load double, double* %ptry2, align 4
  %x3 = load double, double* %ptrx3, align 4
  %y3 = load double, double* %ptry3, align 4
  %mul0 = fmul double %x0, %y0
  %mul1 = fmul double %x1, %y1
  %mul2 = fmul double %x2, %y2
  %mul3 = fmul double %x3, %y3
  %dot01 = fadd double %mul0, %mul1
  %dot012 = fadd double %dot01, %mul2
  %dot0123 = fadd double %dot012, %mul3
  ret double %dot0123
}

define float @dotf32(float* dereferenceable(16) %ptrx, float* dereferenceable(16) %ptry) {
; CHECK-LABEL: @dotf32(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds float, float* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds float, float* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[PTRX2:%.*]] = getelementptr inbounds float, float* [[PTRX]], i64 2
; CHECK-NEXT:    [[PTRY2:%.*]] = getelementptr inbounds float, float* [[PTRY]], i64 2
; CHECK-NEXT:    [[PTRX3:%.*]] = getelementptr inbounds float, float* [[PTRX]], i64 3
; CHECK-NEXT:    [[PTRY3:%.*]] = getelementptr inbounds float, float* [[PTRY]], i64 3
; CHECK-NEXT:    [[X0:%.*]] = load float, float* [[PTRX]], align 4
; CHECK-NEXT:    [[Y0:%.*]] = load float, float* [[PTRY]], align 4
; CHECK-NEXT:    [[X1:%.*]] = load float, float* [[PTRX1]], align 4
; CHECK-NEXT:    [[Y1:%.*]] = load float, float* [[PTRY1]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[PTRX2]] to <2 x float>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x float>, <2 x float>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[PTRY2]] to <2 x float>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x float>, <2 x float>* [[TMP3]], align 4
; CHECK-NEXT:    [[MUL0:%.*]] = fmul float [[X0]], [[Y0]]
; CHECK-NEXT:    [[MUL1:%.*]] = fmul float [[X1]], [[Y1]]
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x float> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[DOT01:%.*]] = fadd float [[MUL0]], [[MUL1]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x float> [[TMP5]], i32 0
; CHECK-NEXT:    [[DOT012:%.*]] = fadd float [[DOT01]], [[TMP6]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x float> [[TMP5]], i32 1
; CHECK-NEXT:    [[DOT0123:%.*]] = fadd float [[DOT012]], [[TMP7]]
; CHECK-NEXT:    ret float [[DOT0123]]
;
  %ptrx1 = getelementptr inbounds float, float* %ptrx, i64 1
  %ptry1 = getelementptr inbounds float, float* %ptry, i64 1
  %ptrx2 = getelementptr inbounds float, float* %ptrx, i64 2
  %ptry2 = getelementptr inbounds float, float* %ptry, i64 2
  %ptrx3 = getelementptr inbounds float, float* %ptrx, i64 3
  %ptry3 = getelementptr inbounds float, float* %ptry, i64 3
  %x0 = load float, float* %ptrx, align 4
  %y0 = load float, float* %ptry, align 4
  %x1 = load float, float* %ptrx1, align 4
  %y1 = load float, float* %ptry1, align 4
  %x2 = load float, float* %ptrx2, align 4
  %y2 = load float, float* %ptry2, align 4
  %x3 = load float, float* %ptrx3, align 4
  %y3 = load float, float* %ptry3, align 4
  %mul0 = fmul float %x0, %y0
  %mul1 = fmul float %x1, %y1
  %mul2 = fmul float %x2, %y2
  %mul3 = fmul float %x3, %y3
  %dot01 = fadd float %mul0, %mul1
  %dot012 = fadd float %dot01, %mul2
  %dot0123 = fadd float %dot012, %mul3
  ret float %dot0123
}

define double @dotf64_fast(double* dereferenceable(32) %ptrx, double* dereferenceable(32) %ptry) {
; CHECK-LABEL: @dotf64_fast(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds double, double* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds double, double* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[PTRX2:%.*]] = getelementptr inbounds double, double* [[PTRX]], i64 2
; CHECK-NEXT:    [[PTRY2:%.*]] = getelementptr inbounds double, double* [[PTRY]], i64 2
; CHECK-NEXT:    [[PTRX3:%.*]] = getelementptr inbounds double, double* [[PTRX]], i64 3
; CHECK-NEXT:    [[PTRY3:%.*]] = getelementptr inbounds double, double* [[PTRY]], i64 3
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast double* [[PTRX]] to <4 x double>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x double>, <4 x double>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast double* [[PTRY]] to <4 x double>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <4 x double>, <4 x double>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <4 x double> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = call fast double @llvm.vector.reduce.fadd.v4f64(double -0.000000e+00, <4 x double> [[TMP5]])
; CHECK-NEXT:    ret double [[TMP6]]
;
  %ptrx1 = getelementptr inbounds double, double* %ptrx, i64 1
  %ptry1 = getelementptr inbounds double, double* %ptry, i64 1
  %ptrx2 = getelementptr inbounds double, double* %ptrx, i64 2
  %ptry2 = getelementptr inbounds double, double* %ptry, i64 2
  %ptrx3 = getelementptr inbounds double, double* %ptrx, i64 3
  %ptry3 = getelementptr inbounds double, double* %ptry, i64 3
  %x0 = load double, double* %ptrx, align 4
  %y0 = load double, double* %ptry, align 4
  %x1 = load double, double* %ptrx1, align 4
  %y1 = load double, double* %ptry1, align 4
  %x2 = load double, double* %ptrx2, align 4
  %y2 = load double, double* %ptry2, align 4
  %x3 = load double, double* %ptrx3, align 4
  %y3 = load double, double* %ptry3, align 4
  %mul0 = fmul double %x0, %y0
  %mul1 = fmul double %x1, %y1
  %mul2 = fmul double %x2, %y2
  %mul3 = fmul double %x3, %y3
  %dot01 = fadd fast double %mul0, %mul1
  %dot012 = fadd fast double %dot01, %mul2
  %dot0123 = fadd fast double %dot012, %mul3
  ret double %dot0123
}

define float @dot4f32_fast(float* dereferenceable(16) %ptrx, float* dereferenceable(16) %ptry) {
; CHECK-LABEL: @dot4f32_fast(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds float, float* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds float, float* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[PTRX2:%.*]] = getelementptr inbounds float, float* [[PTRX]], i64 2
; CHECK-NEXT:    [[PTRY2:%.*]] = getelementptr inbounds float, float* [[PTRY]], i64 2
; CHECK-NEXT:    [[PTRX3:%.*]] = getelementptr inbounds float, float* [[PTRX]], i64 3
; CHECK-NEXT:    [[PTRY3:%.*]] = getelementptr inbounds float, float* [[PTRY]], i64 3
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[PTRX]] to <4 x float>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <4 x float>, <4 x float>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[PTRY]] to <4 x float>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <4 x float>, <4 x float>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <4 x float> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = call fast float @llvm.vector.reduce.fadd.v4f32(float -0.000000e+00, <4 x float> [[TMP5]])
; CHECK-NEXT:    ret float [[TMP6]]
;
  %ptrx1 = getelementptr inbounds float, float* %ptrx, i64 1
  %ptry1 = getelementptr inbounds float, float* %ptry, i64 1
  %ptrx2 = getelementptr inbounds float, float* %ptrx, i64 2
  %ptry2 = getelementptr inbounds float, float* %ptry, i64 2
  %ptrx3 = getelementptr inbounds float, float* %ptrx, i64 3
  %ptry3 = getelementptr inbounds float, float* %ptry, i64 3
  %x0 = load float, float* %ptrx, align 4
  %y0 = load float, float* %ptry, align 4
  %x1 = load float, float* %ptrx1, align 4
  %y1 = load float, float* %ptry1, align 4
  %x2 = load float, float* %ptrx2, align 4
  %y2 = load float, float* %ptry2, align 4
  %x3 = load float, float* %ptrx3, align 4
  %y3 = load float, float* %ptry3, align 4
  %mul0 = fmul float %x0, %y0
  %mul1 = fmul float %x1, %y1
  %mul2 = fmul float %x2, %y2
  %mul3 = fmul float %x3, %y3
  %dot01 = fadd fast float %mul0, %mul1
  %dot012 = fadd fast float %dot01, %mul2
  %dot0123 = fadd fast float %dot012, %mul3
  ret float %dot0123
}

;
; dot3(float *x, float *y) - ((x[0]*y[0])+(x[1]*y[1])+(x[2]*y[2]))
;

define double @dot3_f64(double* dereferenceable(32) %ptrx, double* dereferenceable(32) %ptry) {
; CHECK-LABEL: @dot3_f64(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds double, double* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds double, double* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[PTRX2:%.*]] = getelementptr inbounds double, double* [[PTRX]], i64 2
; CHECK-NEXT:    [[PTRY2:%.*]] = getelementptr inbounds double, double* [[PTRY]], i64 2
; CHECK-NEXT:    [[X0:%.*]] = load double, double* [[PTRX]], align 4
; CHECK-NEXT:    [[Y0:%.*]] = load double, double* [[PTRY]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast double* [[PTRX1]] to <2 x double>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x double>, <2 x double>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast double* [[PTRY1]] to <2 x double>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x double>, <2 x double>* [[TMP3]], align 4
; CHECK-NEXT:    [[MUL0:%.*]] = fmul double [[X0]], [[Y0]]
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x double> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x double> [[TMP5]], i32 0
; CHECK-NEXT:    [[DOT01:%.*]] = fadd double [[MUL0]], [[TMP6]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x double> [[TMP5]], i32 1
; CHECK-NEXT:    [[DOT012:%.*]] = fadd double [[DOT01]], [[TMP7]]
; CHECK-NEXT:    ret double [[DOT012]]
;
  %ptrx1 = getelementptr inbounds double, double* %ptrx, i64 1
  %ptry1 = getelementptr inbounds double, double* %ptry, i64 1
  %ptrx2 = getelementptr inbounds double, double* %ptrx, i64 2
  %ptry2 = getelementptr inbounds double, double* %ptry, i64 2
  %x0 = load double, double* %ptrx, align 4
  %y0 = load double, double* %ptry, align 4
  %x1 = load double, double* %ptrx1, align 4
  %y1 = load double, double* %ptry1, align 4
  %x2 = load double, double* %ptrx2, align 4
  %y2 = load double, double* %ptry2, align 4
  %mul0 = fmul double %x0, %y0
  %mul1 = fmul double %x1, %y1
  %mul2 = fmul double %x2, %y2
  %dot01 = fadd double %mul0, %mul1
  %dot012 = fadd double %dot01, %mul2
  ret double %dot012
}

define float @dot3_f32(float* dereferenceable(16) %ptrx, float* dereferenceable(16) %ptry) {
; CHECK-LABEL: @dot3_f32(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds float, float* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds float, float* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[PTRX2:%.*]] = getelementptr inbounds float, float* [[PTRX]], i64 2
; CHECK-NEXT:    [[PTRY2:%.*]] = getelementptr inbounds float, float* [[PTRY]], i64 2
; CHECK-NEXT:    [[X0:%.*]] = load float, float* [[PTRX]], align 4
; CHECK-NEXT:    [[Y0:%.*]] = load float, float* [[PTRY]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[PTRX1]] to <2 x float>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x float>, <2 x float>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[PTRY1]] to <2 x float>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x float>, <2 x float>* [[TMP3]], align 4
; CHECK-NEXT:    [[MUL0:%.*]] = fmul float [[X0]], [[Y0]]
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x float> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x float> [[TMP5]], i32 0
; CHECK-NEXT:    [[DOT01:%.*]] = fadd float [[MUL0]], [[TMP6]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x float> [[TMP5]], i32 1
; CHECK-NEXT:    [[DOT012:%.*]] = fadd float [[DOT01]], [[TMP7]]
; CHECK-NEXT:    ret float [[DOT012]]
;
  %ptrx1 = getelementptr inbounds float, float* %ptrx, i64 1
  %ptry1 = getelementptr inbounds float, float* %ptry, i64 1
  %ptrx2 = getelementptr inbounds float, float* %ptrx, i64 2
  %ptry2 = getelementptr inbounds float, float* %ptry, i64 2
  %x0 = load float, float* %ptrx, align 4
  %y0 = load float, float* %ptry, align 4
  %x1 = load float, float* %ptrx1, align 4
  %y1 = load float, float* %ptry1, align 4
  %x2 = load float, float* %ptrx2, align 4
  %y2 = load float, float* %ptry2, align 4
  %mul0 = fmul float %x0, %y0
  %mul1 = fmul float %x1, %y1
  %mul2 = fmul float %x2, %y2
  %dot01 = fadd float %mul0, %mul1
  %dot012 = fadd float %dot01, %mul2
  ret float %dot012
}

define double @dot3f64_fast(double* dereferenceable(32) %ptrx, double* dereferenceable(32) %ptry) {
; CHECK-LABEL: @dot3f64_fast(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds double, double* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds double, double* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[PTRX2:%.*]] = getelementptr inbounds double, double* [[PTRX]], i64 2
; CHECK-NEXT:    [[PTRY2:%.*]] = getelementptr inbounds double, double* [[PTRY]], i64 2
; CHECK-NEXT:    [[X0:%.*]] = load double, double* [[PTRX]], align 4
; CHECK-NEXT:    [[Y0:%.*]] = load double, double* [[PTRY]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast double* [[PTRX1]] to <2 x double>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x double>, <2 x double>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast double* [[PTRY1]] to <2 x double>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x double>, <2 x double>* [[TMP3]], align 4
; CHECK-NEXT:    [[MUL0:%.*]] = fmul double [[X0]], [[Y0]]
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x double> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x double> [[TMP5]], i32 0
; CHECK-NEXT:    [[DOT01:%.*]] = fadd fast double [[MUL0]], [[TMP6]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x double> [[TMP5]], i32 1
; CHECK-NEXT:    [[DOT012:%.*]] = fadd fast double [[DOT01]], [[TMP7]]
; CHECK-NEXT:    ret double [[DOT012]]
;
  %ptrx1 = getelementptr inbounds double, double* %ptrx, i64 1
  %ptry1 = getelementptr inbounds double, double* %ptry, i64 1
  %ptrx2 = getelementptr inbounds double, double* %ptrx, i64 2
  %ptry2 = getelementptr inbounds double, double* %ptry, i64 2
  %x0 = load double, double* %ptrx, align 4
  %y0 = load double, double* %ptry, align 4
  %x1 = load double, double* %ptrx1, align 4
  %y1 = load double, double* %ptry1, align 4
  %x2 = load double, double* %ptrx2, align 4
  %y2 = load double, double* %ptry2, align 4
  %mul0 = fmul double %x0, %y0
  %mul1 = fmul double %x1, %y1
  %mul2 = fmul double %x2, %y2
  %dot01 = fadd fast double %mul0, %mul1
  %dot012 = fadd fast double %dot01, %mul2
  ret double %dot012
}

define float @dot3f32_fast(float* dereferenceable(16) %ptrx, float* dereferenceable(16) %ptry) {
; CHECK-LABEL: @dot3f32_fast(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds float, float* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds float, float* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[PTRX2:%.*]] = getelementptr inbounds float, float* [[PTRX]], i64 2
; CHECK-NEXT:    [[PTRY2:%.*]] = getelementptr inbounds float, float* [[PTRY]], i64 2
; CHECK-NEXT:    [[X0:%.*]] = load float, float* [[PTRX]], align 4
; CHECK-NEXT:    [[Y0:%.*]] = load float, float* [[PTRY]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[PTRX1]] to <2 x float>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x float>, <2 x float>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[PTRY1]] to <2 x float>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x float>, <2 x float>* [[TMP3]], align 4
; CHECK-NEXT:    [[MUL0:%.*]] = fmul float [[X0]], [[Y0]]
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x float> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x float> [[TMP5]], i32 0
; CHECK-NEXT:    [[DOT01:%.*]] = fadd fast float [[MUL0]], [[TMP6]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x float> [[TMP5]], i32 1
; CHECK-NEXT:    [[DOT012:%.*]] = fadd fast float [[DOT01]], [[TMP7]]
; CHECK-NEXT:    ret float [[DOT012]]
;
  %ptrx1 = getelementptr inbounds float, float* %ptrx, i64 1
  %ptry1 = getelementptr inbounds float, float* %ptry, i64 1
  %ptrx2 = getelementptr inbounds float, float* %ptrx, i64 2
  %ptry2 = getelementptr inbounds float, float* %ptry, i64 2
  %x0 = load float, float* %ptrx, align 4
  %y0 = load float, float* %ptry, align 4
  %x1 = load float, float* %ptrx1, align 4
  %y1 = load float, float* %ptry1, align 4
  %x2 = load float, float* %ptrx2, align 4
  %y2 = load float, float* %ptry2, align 4
  %mul0 = fmul float %x0, %y0
  %mul1 = fmul float %x1, %y1
  %mul2 = fmul float %x2, %y2
  %dot01 = fadd fast float %mul0, %mul1
  %dot012 = fadd fast float %dot01, %mul2
  ret float %dot012
}

;
; dot2(float *x, float *y) - ((x[0]*y[0])+(x[1]*y[1]))
;

define double @dot2f64(double* dereferenceable(16) %ptrx, double* dereferenceable(16) %ptry) {
; CHECK-LABEL: @dot2f64(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds double, double* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds double, double* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast double* [[PTRX]] to <2 x double>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x double>, <2 x double>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast double* [[PTRY]] to <2 x double>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x double>, <2 x double>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x double> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x double> [[TMP5]], i32 0
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x double> [[TMP5]], i32 1
; CHECK-NEXT:    [[DOT01:%.*]] = fadd double [[TMP6]], [[TMP7]]
; CHECK-NEXT:    ret double [[DOT01]]
;
  %ptrx1 = getelementptr inbounds double, double* %ptrx, i64 1
  %ptry1 = getelementptr inbounds double, double* %ptry, i64 1
  %x0 = load double, double* %ptrx, align 4
  %y0 = load double, double* %ptry, align 4
  %x1 = load double, double* %ptrx1, align 4
  %y1 = load double, double* %ptry1, align 4
  %mul0 = fmul double %x0, %y0
  %mul1 = fmul double %x1, %y1
  %dot01 = fadd double %mul0, %mul1
  ret double %dot01
}

define float @dot2f32(float* dereferenceable(16) %ptrx, float* dereferenceable(16) %ptry) {
; CHECK-LABEL: @dot2f32(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds float, float* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds float, float* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[PTRX]] to <2 x float>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x float>, <2 x float>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[PTRY]] to <2 x float>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x float>, <2 x float>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x float> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x float> [[TMP5]], i32 0
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x float> [[TMP5]], i32 1
; CHECK-NEXT:    [[DOT01:%.*]] = fadd float [[TMP6]], [[TMP7]]
; CHECK-NEXT:    ret float [[DOT01]]
;
  %ptrx1 = getelementptr inbounds float, float* %ptrx, i64 1
  %ptry1 = getelementptr inbounds float, float* %ptry, i64 1
  %x0 = load float, float* %ptrx, align 4
  %y0 = load float, float* %ptry, align 4
  %x1 = load float, float* %ptrx1, align 4
  %y1 = load float, float* %ptry1, align 4
  %mul0 = fmul float %x0, %y0
  %mul1 = fmul float %x1, %y1
  %dot01 = fadd float %mul0, %mul1
  ret float %dot01
}

define double @dot2f64_fast(double* dereferenceable(16) %ptrx, double* dereferenceable(16) %ptry) {
; CHECK-LABEL: @dot2f64_fast(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds double, double* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds double, double* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast double* [[PTRX]] to <2 x double>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x double>, <2 x double>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast double* [[PTRY]] to <2 x double>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x double>, <2 x double>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x double> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x double> [[TMP5]], i32 0
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x double> [[TMP5]], i32 1
; CHECK-NEXT:    [[DOT01:%.*]] = fadd fast double [[TMP6]], [[TMP7]]
; CHECK-NEXT:    ret double [[DOT01]]
;
  %ptrx1 = getelementptr inbounds double, double* %ptrx, i64 1
  %ptry1 = getelementptr inbounds double, double* %ptry, i64 1
  %x0 = load double, double* %ptrx, align 4
  %y0 = load double, double* %ptry, align 4
  %x1 = load double, double* %ptrx1, align 4
  %y1 = load double, double* %ptry1, align 4
  %mul0 = fmul double %x0, %y0
  %mul1 = fmul double %x1, %y1
  %dot01 = fadd fast double %mul0, %mul1
  ret double %dot01
}

define float @dot2f32_fast(float* dereferenceable(16) %ptrx, float* dereferenceable(16) %ptry) {
; CHECK-LABEL: @dot2f32_fast(
; CHECK-NEXT:    [[PTRX1:%.*]] = getelementptr inbounds float, float* [[PTRX:%.*]], i64 1
; CHECK-NEXT:    [[PTRY1:%.*]] = getelementptr inbounds float, float* [[PTRY:%.*]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast float* [[PTRX]] to <2 x float>*
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x float>, <2 x float>* [[TMP1]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[PTRY]] to <2 x float>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <2 x float>, <2 x float>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = fmul <2 x float> [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <2 x float> [[TMP5]], i32 0
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x float> [[TMP5]], i32 1
; CHECK-NEXT:    [[DOT01:%.*]] = fadd fast float [[TMP6]], [[TMP7]]
; CHECK-NEXT:    ret float [[DOT01]]
;
  %ptrx1 = getelementptr inbounds float, float* %ptrx, i64 1
  %ptry1 = getelementptr inbounds float, float* %ptry, i64 1
  %x0 = load float, float* %ptrx, align 4
  %y0 = load float, float* %ptry, align 4
  %x1 = load float, float* %ptrx1, align 4
  %y1 = load float, float* %ptry1, align 4
  %mul0 = fmul float %x0, %y0
  %mul1 = fmul float %x1, %y1
  %dot01 = fadd fast float %mul0, %mul1
  ret float %dot01
}
