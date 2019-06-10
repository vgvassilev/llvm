; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mcpu=pwr8 -mtriple=powerpc64le-unknown-unknown \
; RUN:   -ppc-asm-full-reg-names -verify-machineinstrs -O2 < %s | FileCheck %s
; RUN: llc -mcpu=pwr8 -mtriple=powerpc64-unknown-unknown \
; RUN:   -ppc-asm-full-reg-names -verify-machineinstrs -O2 < %s | FileCheck %s \
; RUN:   --check-prefix=CHECK-BE
; RUN: llc -mcpu=pwr9 -mtriple=powerpc64le-unknown-unknown \
; RUN:   -ppc-asm-full-reg-names -verify-machineinstrs -O2 < %s | FileCheck %s \
; RUN:   --check-prefix=CHECK-P9
; RUN: llc -mcpu=pwr9 -mtriple=powerpc64-unknown-unknown \
; RUN:   -ppc-asm-full-reg-names -verify-machineinstrs -O2 < %s | FileCheck %s \
; RUN:   --check-prefix=CHECK-P9-BE

define <2 x i64> @testllv(<2 x i64> returned %a, <2 x i64> %b, i64* nocapture %ap, i64 %Idx) local_unnamed_addr #0 {
; CHECK-LABEL: testllv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxswapd vs0, vs34
; CHECK-NEXT:    sldi r3, r8, 3
; CHECK-NEXT:    stfdx f0, r7, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testllv:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sldi r3, r8, 3
; CHECK-BE-NEXT:    stxsdx vs34, r7, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testllv:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxswapd vs0, vs34
; CHECK-P9-NEXT:    sldi r3, r8, 3
; CHECK-P9-NEXT:    stfdx f0, r7, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testllv:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    sldi r3, r8, 3
; CHECK-P9-BE-NEXT:    stxsdx vs34, r7, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <2 x i64> %a, i32 0
  %arrayidx = getelementptr inbounds i64, i64* %ap, i64 %Idx
  store i64 %vecext, i64* %arrayidx, align 8
  ret <2 x i64> %a
}

define <2 x i64> @testll0(<2 x i64> returned %a, <2 x i64> %b, i64* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testll0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxswapd vs0, vs34
; CHECK-NEXT:    stfd f0, 24(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testll0:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    addi r3, r7, 24
; CHECK-BE-NEXT:    stxsdx vs34, 0, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testll0:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxswapd vs0, vs34
; CHECK-P9-NEXT:    stfd f0, 24(r7)
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testll0:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    stxsd v2, 24(r7)
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <2 x i64> %a, i32 0
  %arrayidx = getelementptr inbounds i64, i64* %ap, i64 3
  store i64 %vecext, i64* %arrayidx, align 8
  ret <2 x i64> %a
}

; Function Attrs: norecurse nounwind writeonly
define <2 x i64> @testll1(<2 x i64> returned %a, i64 %b, i64* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testll1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi r3, r6, 24
; CHECK-NEXT:    stxsdx vs34, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testll1:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxswapd vs0, vs34
; CHECK-BE-NEXT:    stfd f0, 24(r6)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testll1:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    stxsd v2, 24(r6)
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testll1:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxswapd vs0, vs34
; CHECK-P9-BE-NEXT:    stfd f0, 24(r6)
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <2 x i64> %a, i32 1
  %arrayidx = getelementptr inbounds i64, i64* %ap, i64 3
  store i64 %vecext, i64* %arrayidx, align 8
  ret <2 x i64> %a
}

define <2 x double> @testdv(<2 x double> returned %a, <2 x double> %b, double* nocapture %ap, i64 %Idx) local_unnamed_addr #0 {
; CHECK-LABEL: testdv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxswapd vs0, vs34
; CHECK-NEXT:    sldi r3, r8, 3
; CHECK-NEXT:    stfdx f0, r7, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testdv:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    sldi r3, r8, 3
; CHECK-BE-NEXT:    stxsdx vs34, r7, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testdv:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxswapd vs0, vs34
; CHECK-P9-NEXT:    sldi r3, r8, 3
; CHECK-P9-NEXT:    stfdx f0, r7, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testdv:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    sldi r3, r8, 3
; CHECK-P9-BE-NEXT:    stxsdx vs34, r7, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <2 x double> %a, i32 0
  %arrayidx = getelementptr inbounds double, double* %ap, i64 %Idx
  store double %vecext, double* %arrayidx, align 8
  ret <2 x double> %a
}

define <2 x double> @testd0(<2 x double> returned %a, <2 x double> %b, double* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testd0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxswapd vs0, vs34
; CHECK-NEXT:    stfd f0, 24(r7)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testd0:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    addi r3, r7, 24
; CHECK-BE-NEXT:    stxsdx vs34, 0, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testd0:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxswapd vs0, vs34
; CHECK-P9-NEXT:    stfd f0, 24(r7)
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testd0:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    stxsd v2, 24(r7)
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <2 x double> %a, i32 0
  %arrayidx = getelementptr inbounds double, double* %ap, i64 3
  store double %vecext, double* %arrayidx, align 8
  ret <2 x double> %a
}

; Function Attrs: norecurse nounwind writeonly
define <2 x double> @testd1(<2 x double> returned %a, <2 x double> %b, double* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testd1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi r3, r7, 24
; CHECK-NEXT:    stxsdx vs34, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testd1:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxswapd vs0, vs34
; CHECK-BE-NEXT:    stfd f0, 24(r7)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testd1:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    stxsd v2, 24(r7)
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testd1:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxswapd vs0, vs34
; CHECK-P9-BE-NEXT:    stfd f0, 24(r7)
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <2 x double> %a, i32 1
  %arrayidx = getelementptr inbounds double, double* %ap, i64 3
  store double %vecext, double* %arrayidx, align 8
  ret <2 x double> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x float> @testf0(<4 x float> returned %a, <4 x float> %b, float* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testf0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-NEXT:    addi r3, r7, 12
; CHECK-NEXT:    stfiwx f0, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testf0:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-BE-NEXT:    addi r3, r7, 12
; CHECK-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testf0:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-P9-NEXT:    addi r3, r7, 12
; CHECK-P9-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testf0:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-P9-BE-NEXT:    addi r3, r7, 12
; CHECK-P9-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x float> %a, i32 0
  %arrayidx = getelementptr inbounds float, float* %ap, i64 3
  store float %vecext, float* %arrayidx, align 4
  ret <4 x float> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x float> @testf1(<4 x float> returned %a, <4 x float> %b, float* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testf1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-NEXT:    addi r3, r7, 12
; CHECK-NEXT:    stfiwx f0, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testf1:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    addi r3, r7, 12
; CHECK-BE-NEXT:    stxsiwx vs34, 0, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testf1:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-P9-NEXT:    addi r3, r7, 12
; CHECK-P9-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testf1:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    addi r3, r7, 12
; CHECK-P9-BE-NEXT:    stxsiwx vs34, 0, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x float> %a, i32 1
  %arrayidx = getelementptr inbounds float, float* %ap, i64 3
  store float %vecext, float* %arrayidx, align 4
  ret <4 x float> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x float> @testf2(<4 x float> returned %a, <4 x float> %b, float* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testf2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi r3, r7, 12
; CHECK-NEXT:    stxsiwx vs34, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testf2:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-BE-NEXT:    addi r3, r7, 12
; CHECK-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testf2:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addi r3, r7, 12
; CHECK-P9-NEXT:    stxsiwx vs34, 0, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testf2:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-P9-BE-NEXT:    addi r3, r7, 12
; CHECK-P9-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x float> %a, i32 2
  %arrayidx = getelementptr inbounds float, float* %ap, i64 3
  store float %vecext, float* %arrayidx, align 4
  ret <4 x float> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x float> @testf3(<4 x float> returned %a, <4 x float> %b, float* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testf3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-NEXT:    addi r3, r7, 12
; CHECK-NEXT:    stfiwx f0, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testf3:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-BE-NEXT:    addi r3, r7, 12
; CHECK-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testf3:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-P9-NEXT:    addi r3, r7, 12
; CHECK-P9-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testf3:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-P9-BE-NEXT:    addi r3, r7, 12
; CHECK-P9-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x float> %a, i32 3
  %arrayidx = getelementptr inbounds float, float* %ap, i64 3
  store float %vecext, float* %arrayidx, align 4
  ret <4 x float> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x i32> @testi0(<4 x i32> returned %a, <4 x i32> %b, i32* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testi0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-NEXT:    addi r3, r7, 12
; CHECK-NEXT:    stfiwx f0, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testi0:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-BE-NEXT:    addi r3, r7, 12
; CHECK-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testi0:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-P9-NEXT:    addi r3, r7, 12
; CHECK-P9-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testi0:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-P9-BE-NEXT:    addi r3, r7, 12
; CHECK-P9-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %a, i32 0
  %arrayidx = getelementptr inbounds i32, i32* %ap, i64 3
  store i32 %vecext, i32* %arrayidx, align 4
  ret <4 x i32> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x i32> @testi1(<4 x i32> returned %a, <4 x i32> %b, i32* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testi1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-NEXT:    addi r3, r7, 12
; CHECK-NEXT:    stfiwx f0, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testi1:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    addi r3, r7, 12
; CHECK-BE-NEXT:    stxsiwx vs34, 0, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testi1:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-P9-NEXT:    addi r3, r7, 12
; CHECK-P9-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testi1:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    addi r3, r7, 12
; CHECK-P9-BE-NEXT:    stxsiwx vs34, 0, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %a, i32 1
  %arrayidx = getelementptr inbounds i32, i32* %ap, i64 3
  store i32 %vecext, i32* %arrayidx, align 4
  ret <4 x i32> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x i32> @testi2(<4 x i32> returned %a, <4 x i32> %b, i32* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testi2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi r3, r7, 12
; CHECK-NEXT:    stxsiwx vs34, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testi2:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-BE-NEXT:    addi r3, r7, 12
; CHECK-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testi2:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addi r3, r7, 12
; CHECK-P9-NEXT:    stxsiwx vs34, 0, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testi2:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-P9-BE-NEXT:    addi r3, r7, 12
; CHECK-P9-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %a, i32 2
  %arrayidx = getelementptr inbounds i32, i32* %ap, i64 3
  store i32 %vecext, i32* %arrayidx, align 4
  ret <4 x i32> %a
}

; Function Attrs: norecurse nounwind writeonly
define <4 x i32> @testi3(<4 x i32> returned %a, <4 x i32> %b, i32* nocapture %ap) local_unnamed_addr #0 {
; CHECK-LABEL: testi3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-NEXT:    addi r3, r7, 12
; CHECK-NEXT:    stfiwx f0, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: testi3:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-BE-NEXT:    addi r3, r7, 12
; CHECK-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: testi3:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-P9-NEXT:    addi r3, r7, 12
; CHECK-P9-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: testi3:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-P9-BE-NEXT:    addi r3, r7, 12
; CHECK-P9-BE-NEXT:    stfiwx f0, 0, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %a, i32 3
  %arrayidx = getelementptr inbounds i32, i32* %ap, i64 3
  store i32 %vecext, i32* %arrayidx, align 4
  ret <4 x i32> %a
}

define dso_local void @test_consecutive_i32(<4 x i32> %a, i32* nocapture %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_consecutive_i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-NEXT:    li r3, 4
; CHECK-NEXT:    stfiwx f0, 0, r5
; CHECK-NEXT:    stxsiwx vs34, r5, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: test_consecutive_i32:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-BE-NEXT:    xxsldwi vs1, vs34, vs34, 1
; CHECK-BE-NEXT:    li r3, 4
; CHECK-BE-NEXT:    stfiwx f0, 0, r5
; CHECK-BE-NEXT:    stfiwx f1, r5, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: test_consecutive_i32:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-P9-NEXT:    li r3, 4
; CHECK-P9-NEXT:    stfiwx f0, 0, r5
; CHECK-P9-NEXT:    stxsiwx vs34, r5, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: test_consecutive_i32:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-P9-BE-NEXT:    stfiwx f0, 0, r5
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-P9-BE-NEXT:    li r3, 4
; CHECK-P9-BE-NEXT:    stfiwx f0, r5, r3
; CHECK-P9-BE-NEXT:    blr
entry:

  %vecext = extractelement <4 x i32> %a, i32 0
  store i32 %vecext, i32* %b, align 4
  %vecext1 = extractelement <4 x i32> %a, i32 2
  %arrayidx2 = getelementptr inbounds i32, i32* %b, i64 1
  store i32 %vecext1, i32* %arrayidx2, align 4
  ret void
}

define dso_local void @test_consecutive_float(<4 x float> %a, float* nocapture %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_consecutive_float:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-NEXT:    xxsldwi vs1, vs34, vs34, 3
; CHECK-NEXT:    li r3, 4
; CHECK-NEXT:    stfiwx f0, 0, r5
; CHECK-NEXT:    stfiwx f1, r5, r3
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: test_consecutive_float:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-BE-NEXT:    li r3, 4
; CHECK-BE-NEXT:    stxsiwx vs34, 0, r5
; CHECK-BE-NEXT:    stfiwx f0, r5, r3
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: test_consecutive_float:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-P9-NEXT:    stfiwx f0, 0, r5
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-P9-NEXT:    li r3, 4
; CHECK-P9-NEXT:    stfiwx f0, r5, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: test_consecutive_float:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-P9-BE-NEXT:    li r3, 4
; CHECK-P9-BE-NEXT:    stxsiwx vs34, 0, r5
; CHECK-P9-BE-NEXT:    stfiwx f0, r5, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x float> %a, i32 1
  store float %vecext, float* %b, align 4
  %vecext1 = extractelement <4 x float> %a, i32 3
  %arrayidx2 = getelementptr inbounds float, float* %b, i64 1
  store float %vecext1, float* %arrayidx2, align 4
  ret void
}

define dso_local void @test_stores_exceed_vec_size(<4 x i32> %a, i32* nocapture %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_stores_exceed_vec_size:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addis r3, r2, .LCPI16_0@toc@ha
; CHECK-NEXT:    xxsldwi vs1, vs34, vs34, 1
; CHECK-NEXT:    li r4, 20
; CHECK-NEXT:    addi r3, r3, .LCPI16_0@toc@l
; CHECK-NEXT:    lvx v3, 0, r3
; CHECK-NEXT:    li r3, 16
; CHECK-NEXT:    vperm v3, v2, v2, v3
; CHECK-NEXT:    xxswapd vs0, vs35
; CHECK-NEXT:    stxvd2x vs0, 0, r5
; CHECK-NEXT:    stfiwx f1, r5, r3
; CHECK-NEXT:    stxsiwx vs34, r5, r4
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: test_stores_exceed_vec_size:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxspltw vs0, vs34, 0
; CHECK-BE-NEXT:    xxsldwi vs1, vs34, vs34, 1
; CHECK-BE-NEXT:    li r3, 16
; CHECK-BE-NEXT:    li r4, 20
; CHECK-BE-NEXT:    stxsiwx vs34, r5, r3
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs0, 2
; CHECK-BE-NEXT:    stxvw4x vs0, 0, r5
; CHECK-BE-NEXT:    stfiwx f1, r5, r4
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: test_stores_exceed_vec_size:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    addis r3, r2, .LCPI16_0@toc@ha
; CHECK-P9-NEXT:    addi r3, r3, .LCPI16_0@toc@l
; CHECK-P9-NEXT:    lxvx vs35, 0, r3
; CHECK-P9-NEXT:    li r3, 16
; CHECK-P9-NEXT:    vperm v3, v2, v2, v3
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-P9-NEXT:    stxv vs35, 0(r5)
; CHECK-P9-NEXT:    stfiwx f0, r5, r3
; CHECK-P9-NEXT:    li r3, 20
; CHECK-P9-NEXT:    stxsiwx vs34, r5, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: test_stores_exceed_vec_size:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxspltw vs0, vs34, 0
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs0, 2
; CHECK-P9-BE-NEXT:    li r3, 16
; CHECK-P9-BE-NEXT:    stxv vs0, 0(r5)
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 1
; CHECK-P9-BE-NEXT:    stxsiwx vs34, r5, r3
; CHECK-P9-BE-NEXT:    li r3, 20
; CHECK-P9-BE-NEXT:    stfiwx f0, r5, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %a, i32 2
  store i32 %vecext, i32* %b, align 4
  %vecext1 = extractelement <4 x i32> %a, i32 3
  %arrayidx2 = getelementptr inbounds i32, i32* %b, i64 1
  store i32 %vecext1, i32* %arrayidx2, align 4
  %vecext3 = extractelement <4 x i32> %a, i32 0
  %arrayidx4 = getelementptr inbounds i32, i32* %b, i64 2
  store i32 %vecext3, i32* %arrayidx4, align 4
  %arrayidx6 = getelementptr inbounds i32, i32* %b, i64 3
  store i32 %vecext3, i32* %arrayidx6, align 4
  %vecext7 = extractelement <4 x i32> %a, i32 1
  %arrayidx8 = getelementptr inbounds i32, i32* %b, i64 4
  store i32 %vecext7, i32* %arrayidx8, align 4
  %arrayidx10 = getelementptr inbounds i32, i32* %b, i64 5
  store i32 %vecext, i32* %arrayidx10, align 4
  ret void
}

define void @test_5_consecutive_stores_of_bytes(<16 x i8> %a, i8* nocapture %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_5_consecutive_stores_of_bytes:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxswapd vs0, vs34
; CHECK-NEXT:    mfvsrd r3, vs34
; CHECK-NEXT:    rldicl r6, r3, 32, 56
; CHECK-NEXT:    rldicl r3, r3, 56, 56
; CHECK-NEXT:    mfvsrd r4, f0
; CHECK-NEXT:    stb r6, 1(r5)
; CHECK-NEXT:    stb r3, 2(r5)
; CHECK-NEXT:    rldicl r6, r4, 32, 56
; CHECK-NEXT:    rldicl r3, r4, 8, 56
; CHECK-NEXT:    rldicl r4, r4, 16, 56
; CHECK-NEXT:    stb r6, 0(r5)
; CHECK-NEXT:    stb r3, 3(r5)
; CHECK-NEXT:    stb r4, 4(r5)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: test_5_consecutive_stores_of_bytes:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxswapd vs0, vs34
; CHECK-BE-NEXT:    mfvsrd r3, vs34
; CHECK-BE-NEXT:    rldicl r6, r3, 40, 56
; CHECK-BE-NEXT:    mfvsrd r4, f0
; CHECK-BE-NEXT:    stb r6, 0(r5)
; CHECK-BE-NEXT:    rldicl r6, r4, 40, 56
; CHECK-BE-NEXT:    rldicl r4, r4, 16, 56
; CHECK-BE-NEXT:    stb r6, 1(r5)
; CHECK-BE-NEXT:    clrldi r6, r3, 56
; CHECK-BE-NEXT:    rldicl r3, r3, 56, 56
; CHECK-BE-NEXT:    stb r4, 2(r5)
; CHECK-BE-NEXT:    stb r6, 3(r5)
; CHECK-BE-NEXT:    stb r3, 4(r5)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: test_5_consecutive_stores_of_bytes:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 4
; CHECK-P9-NEXT:    stxsibx vs35, 0, r5
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 12
; CHECK-P9-NEXT:    li r3, 1
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 15
; CHECK-P9-NEXT:    li r3, 2
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 1
; CHECK-P9-NEXT:    li r3, 3
; CHECK-P9-NEXT:    vsldoi v2, v2, v2, 2
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    li r3, 4
; CHECK-P9-NEXT:    stxsibx vs34, r5, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: test_5_consecutive_stores_of_bytes:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 13
; CHECK-P9-BE-NEXT:    stxsibx vs35, 0, r5
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 5
; CHECK-P9-BE-NEXT:    li r3, 1
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 2
; CHECK-P9-BE-NEXT:    li r3, 2
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    li r3, 3
; CHECK-P9-BE-NEXT:    stxsibx vs34, r5, r3
; CHECK-P9-BE-NEXT:    vsldoi v2, v2, v2, 15
; CHECK-P9-BE-NEXT:    li r3, 4
; CHECK-P9-BE-NEXT:    stxsibx vs34, r5, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <16 x i8> %a, i32 4
  store i8 %vecext, i8* %b, align 1
  %vecext1 = extractelement <16 x i8> %a, i32 12
  %arrayidx2 = getelementptr inbounds i8, i8* %b, i64 1
  store i8 %vecext1, i8* %arrayidx2, align 1
  %vecext3 = extractelement <16 x i8> %a, i32 9
  %arrayidx4 = getelementptr inbounds i8, i8* %b, i64 2
  store i8 %vecext3, i8* %arrayidx4, align 1
  %vecext5 = extractelement <16 x i8> %a, i32 7
  %arrayidx6 = getelementptr inbounds i8, i8* %b, i64 3
  store i8 %vecext5, i8* %arrayidx6, align 1
  %vecext7 = extractelement <16 x i8> %a, i32 6
  %arrayidx8 = getelementptr inbounds i8, i8* %b, i64 4
  store i8 %vecext7, i8* %arrayidx8, align 1
  ret void
}

define void @test_13_consecutive_stores_of_bytes(<16 x i8> %a, i8* nocapture %b) local_unnamed_addr #0 {
; CHECK-LABEL: test_13_consecutive_stores_of_bytes:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxswapd vs0, vs34
; CHECK-NEXT:    mfvsrd r3, vs34
; CHECK-NEXT:    rldicl r4, r3, 32, 56
; CHECK-NEXT:    rldicl r6, r3, 56, 56
; CHECK-NEXT:    stb r4, 1(r5)
; CHECK-NEXT:    rldicl r4, r3, 40, 56
; CHECK-NEXT:    mfvsrd r7, f0
; CHECK-NEXT:    stb r6, 2(r5)
; CHECK-NEXT:    rldicl r6, r3, 24, 56
; CHECK-NEXT:    stb r4, 6(r5)
; CHECK-NEXT:    rldicl r4, r3, 8, 56
; CHECK-NEXT:    stb r6, 7(r5)
; CHECK-NEXT:    rldicl r3, r3, 16, 56
; CHECK-NEXT:    stb r4, 9(r5)
; CHECK-NEXT:    rldicl r4, r7, 32, 56
; CHECK-NEXT:    rldicl r6, r7, 8, 56
; CHECK-NEXT:    stb r4, 0(r5)
; CHECK-NEXT:    rldicl r4, r7, 16, 56
; CHECK-NEXT:    stb r6, 3(r5)
; CHECK-NEXT:    clrldi r6, r7, 56
; CHECK-NEXT:    stb r4, 4(r5)
; CHECK-NEXT:    rldicl r4, r7, 48, 56
; CHECK-NEXT:    stb r6, 5(r5)
; CHECK-NEXT:    rldicl r6, r7, 56, 56
; CHECK-NEXT:    stb r4, 8(r5)
; CHECK-NEXT:    rldicl r4, r7, 24, 56
; CHECK-NEXT:    stb r6, 10(r5)
; CHECK-NEXT:    stb r4, 11(r5)
; CHECK-NEXT:    stb r3, 12(r5)
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: test_13_consecutive_stores_of_bytes:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    mfvsrd r3, vs34
; CHECK-BE-NEXT:    xxswapd vs0, vs34
; CHECK-BE-NEXT:    rldicl r4, r3, 40, 56
; CHECK-BE-NEXT:    clrldi r6, r3, 56
; CHECK-BE-NEXT:    stb r4, 0(r5)
; CHECK-BE-NEXT:    rldicl r4, r3, 56, 56
; CHECK-BE-NEXT:    mfvsrd r7, f0
; CHECK-BE-NEXT:    stb r6, 3(r5)
; CHECK-BE-NEXT:    rldicl r6, r3, 8, 56
; CHECK-BE-NEXT:    stb r4, 4(r5)
; CHECK-BE-NEXT:    rldicl r4, r3, 24, 56
; CHECK-BE-NEXT:    stb r6, 5(r5)
; CHECK-BE-NEXT:    rldicl r6, r3, 16, 56
; CHECK-BE-NEXT:    stb r4, 8(r5)
; CHECK-BE-NEXT:    rldicl r4, r7, 40, 56
; CHECK-BE-NEXT:    stb r6, 10(r5)
; CHECK-BE-NEXT:    rldicl r6, r7, 16, 56
; CHECK-BE-NEXT:    stb r4, 1(r5)
; CHECK-BE-NEXT:    rldicl r4, r7, 32, 56
; CHECK-BE-NEXT:    stb r6, 2(r5)
; CHECK-BE-NEXT:    rldicl r6, r7, 48, 56
; CHECK-BE-NEXT:    stb r4, 6(r5)
; CHECK-BE-NEXT:    clrldi r4, r7, 56
; CHECK-BE-NEXT:    stb r6, 7(r5)
; CHECK-BE-NEXT:    rldicl r3, r3, 48, 56
; CHECK-BE-NEXT:    rldicl r6, r7, 56, 56
; CHECK-BE-NEXT:    stb r4, 9(r5)
; CHECK-BE-NEXT:    stb r3, 11(r5)
; CHECK-BE-NEXT:    stb r6, 12(r5)
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: test_13_consecutive_stores_of_bytes:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 4
; CHECK-P9-NEXT:    stxsibx vs35, 0, r5
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 12
; CHECK-P9-NEXT:    li r3, 1
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 15
; CHECK-P9-NEXT:    li r3, 2
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 1
; CHECK-P9-NEXT:    li r3, 3
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 2
; CHECK-P9-NEXT:    li r3, 4
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 8
; CHECK-P9-NEXT:    li r3, 5
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 13
; CHECK-P9-NEXT:    li r3, 6
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 11
; CHECK-P9-NEXT:    li r3, 7
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 6
; CHECK-P9-NEXT:    li r3, 8
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 9
; CHECK-P9-NEXT:    li r3, 9
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 7
; CHECK-P9-NEXT:    li r3, 10
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    vsldoi v3, v2, v2, 3
; CHECK-P9-NEXT:    li r3, 11
; CHECK-P9-NEXT:    vsldoi v2, v2, v2, 10
; CHECK-P9-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-NEXT:    li r3, 12
; CHECK-P9-NEXT:    stxsibx vs34, r5, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: test_13_consecutive_stores_of_bytes:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 13
; CHECK-P9-BE-NEXT:    stxsibx vs35, 0, r5
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 5
; CHECK-P9-BE-NEXT:    li r3, 1
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 2
; CHECK-P9-BE-NEXT:    li r3, 2
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    li r3, 3
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 15
; CHECK-P9-BE-NEXT:    stxsibx vs34, r5, r3
; CHECK-P9-BE-NEXT:    li r3, 4
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 9
; CHECK-P9-BE-NEXT:    li r3, 5
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 4
; CHECK-P9-BE-NEXT:    li r3, 6
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 6
; CHECK-P9-BE-NEXT:    li r3, 7
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 11
; CHECK-P9-BE-NEXT:    li r3, 8
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 8
; CHECK-P9-BE-NEXT:    li r3, 9
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 10
; CHECK-P9-BE-NEXT:    li r3, 10
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    vsldoi v3, v2, v2, 14
; CHECK-P9-BE-NEXT:    li r3, 11
; CHECK-P9-BE-NEXT:    vsldoi v2, v2, v2, 7
; CHECK-P9-BE-NEXT:    stxsibx vs35, r5, r3
; CHECK-P9-BE-NEXT:    li r3, 12
; CHECK-P9-BE-NEXT:    stxsibx vs34, r5, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <16 x i8> %a, i32 4
  store i8 %vecext, i8* %b, align 1
  %vecext1 = extractelement <16 x i8> %a, i32 12
  %arrayidx2 = getelementptr inbounds i8, i8* %b, i64 1
  store i8 %vecext1, i8* %arrayidx2, align 1
  %vecext3 = extractelement <16 x i8> %a, i32 9
  %arrayidx4 = getelementptr inbounds i8, i8* %b, i64 2
  store i8 %vecext3, i8* %arrayidx4, align 1
  %vecext5 = extractelement <16 x i8> %a, i32 7
  %arrayidx6 = getelementptr inbounds i8, i8* %b, i64 3
  store i8 %vecext5, i8* %arrayidx6, align 1
  %vecext7 = extractelement <16 x i8> %a, i32 6
  %arrayidx8 = getelementptr inbounds i8, i8* %b, i64 4
  store i8 %vecext7, i8* %arrayidx8, align 1
  %vecext9 = extractelement <16 x i8> %a, i32 0
  %arrayidx10 = getelementptr inbounds i8, i8* %b, i64 5
  store i8 %vecext9, i8* %arrayidx10, align 1
  %vecext11 = extractelement <16 x i8> %a, i32 11
  %arrayidx12 = getelementptr inbounds i8, i8* %b, i64 6
  store i8 %vecext11, i8* %arrayidx12, align 1
  %vecext13 = extractelement <16 x i8> %a, i32 13
  %arrayidx14 = getelementptr inbounds i8, i8* %b, i64 7
  store i8 %vecext13, i8* %arrayidx14, align 1
  %vecext15 = extractelement <16 x i8> %a, i32 2
  %arrayidx16 = getelementptr inbounds i8, i8* %b, i64 8
  store i8 %vecext15, i8* %arrayidx16, align 1
  %vecext17 = extractelement <16 x i8> %a, i32 15
  %arrayidx18 = getelementptr inbounds i8, i8* %b, i64 9
  store i8 %vecext17, i8* %arrayidx18, align 1
  %vecext19 = extractelement <16 x i8> %a, i32 1
  %arrayidx20 = getelementptr inbounds i8, i8* %b, i64 10
  store i8 %vecext19, i8* %arrayidx20, align 1
  %vecext21 = extractelement <16 x i8> %a, i32 5
  %arrayidx22 = getelementptr inbounds i8, i8* %b, i64 11
  store i8 %vecext21, i8* %arrayidx22, align 1
  %vecext23 = extractelement <16 x i8> %a, i32 14
  %arrayidx24 = getelementptr inbounds i8, i8* %b, i64 12
  store i8 %vecext23, i8* %arrayidx24, align 1
  ret void
}

define void @test_elements_from_two_vec(<4 x i32> %a, <4 x i32> %b, i32* nocapture %c) local_unnamed_addr #0 {
; CHECK-LABEL: test_elements_from_two_vec:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-NEXT:    xxsldwi vs1, vs35, vs35, 1
; CHECK-NEXT:    li r3, 4
; CHECK-NEXT:    stfiwx f0, r7, r3
; CHECK-NEXT:    stfiwx f1, 0, r7
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: test_elements_from_two_vec:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-BE-NEXT:    li r3, 4
; CHECK-BE-NEXT:    stfiwx f0, r7, r3
; CHECK-BE-NEXT:    stxsiwx vs35, 0, r7
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: test_elements_from_two_vec:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-P9-NEXT:    li r3, 4
; CHECK-P9-NEXT:    stfiwx f0, r7, r3
; CHECK-P9-NEXT:    xxsldwi vs0, vs35, vs35, 1
; CHECK-P9-NEXT:    stfiwx f0, 0, r7
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: test_elements_from_two_vec:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-P9-BE-NEXT:    li r3, 4
; CHECK-P9-BE-NEXT:    stfiwx f0, r7, r3
; CHECK-P9-BE-NEXT:    stxsiwx vs35, 0, r7
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %a, i32 0
  %arrayidx = getelementptr inbounds i32, i32* %c, i64 1
  store i32 %vecext, i32* %arrayidx, align 4
  %vecext1 = extractelement <4 x i32> %b, i32 1
  store i32 %vecext1, i32* %c, align 4
  ret void
}

define dso_local void @test_elements_from_three_vec(<4 x float> %a, <4 x float> %b, <4 x float> %c, float* nocapture %d) local_unnamed_addr #0 {
; CHECK-LABEL: test_elements_from_three_vec:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-NEXT:    xxsldwi vs1, vs36, vs36, 1
; CHECK-NEXT:    li r3, 4
; CHECK-NEXT:    li r4, 8
; CHECK-NEXT:    stxsiwx vs35, r9, r3
; CHECK-NEXT:    stfiwx f0, 0, r9
; CHECK-NEXT:    stfiwx f1, r9, r4
; CHECK-NEXT:    blr
;
; CHECK-BE-LABEL: test_elements_from_three_vec:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-BE-NEXT:    xxsldwi vs1, vs35, vs35, 1
; CHECK-BE-NEXT:    li r3, 4
; CHECK-BE-NEXT:    li r4, 8
; CHECK-BE-NEXT:    stfiwx f1, r9, r3
; CHECK-BE-NEXT:    stfiwx f0, 0, r9
; CHECK-BE-NEXT:    stxsiwx vs36, r9, r4
; CHECK-BE-NEXT:    blr
;
; CHECK-P9-LABEL: test_elements_from_three_vec:
; CHECK-P9:       # %bb.0: # %entry
; CHECK-P9-NEXT:    xxsldwi vs0, vs34, vs34, 3
; CHECK-P9-NEXT:    li r3, 4
; CHECK-P9-NEXT:    stfiwx f0, 0, r9
; CHECK-P9-NEXT:    xxsldwi vs0, vs36, vs36, 1
; CHECK-P9-NEXT:    stxsiwx vs35, r9, r3
; CHECK-P9-NEXT:    li r3, 8
; CHECK-P9-NEXT:    stfiwx f0, r9, r3
; CHECK-P9-NEXT:    blr
;
; CHECK-P9-BE-LABEL: test_elements_from_three_vec:
; CHECK-P9-BE:       # %bb.0: # %entry
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs34, vs34, 2
; CHECK-P9-BE-NEXT:    stfiwx f0, 0, r9
; CHECK-P9-BE-NEXT:    xxsldwi vs0, vs35, vs35, 1
; CHECK-P9-BE-NEXT:    li r3, 4
; CHECK-P9-BE-NEXT:    stfiwx f0, r9, r3
; CHECK-P9-BE-NEXT:    li r3, 8
; CHECK-P9-BE-NEXT:    stxsiwx vs36, r9, r3
; CHECK-P9-BE-NEXT:    blr
entry:
  %vecext = extractelement <4 x float> %a, i32 3
  store float %vecext, float* %d, align 4
  %vecext1 = extractelement <4 x float> %b, i32 2
  %arrayidx2 = getelementptr inbounds float, float* %d, i64 1
  store float %vecext1, float* %arrayidx2, align 4
  %vecext3 = extractelement <4 x float> %c, i32 1
  %arrayidx4 = getelementptr inbounds float, float* %d, i64 2
  store float %vecext3, float* %arrayidx4, align 4
  ret void
}
