; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-- -instsimplify -S | FileCheck %s

;
; constrained fadd
;

define float @fadd_nan_op0_strict(float %x) #0 {
; CHECK-LABEL: @fadd_nan_op0_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fadd.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fadd.f32(float 0x7FF8000000000000, float %x, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @fadd_nan_op0_maytrap(float %x) #0 {
; CHECK-LABEL: @fadd_nan_op0_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fadd.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fadd.f32(float 0x7FF8000000000000, float %x, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @fadd_nan_op0_upward(float %x) #0 {
; CHECK-LABEL: @fadd_nan_op0_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fadd.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fadd.f32(float 0x7FF8000000000000, float %x, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fadd_nan_op0_defaultfp(float %x) #0 {
; CHECK-LABEL: @fadd_nan_op0_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fadd.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fadd.f32(float 0x7FF8000000000000, float %x, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fadd_nan_op1_strict(float %x) #0 {
; CHECK-LABEL: @fadd_nan_op1_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fadd.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fadd.f32(float %x, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @fadd_nan_op1_maytrap(float %x) #0 {
; CHECK-LABEL: @fadd_nan_op1_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fadd.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fadd.f32(float %x, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @fadd_nan_op1_upward(float %x) #0 {
; CHECK-LABEL: @fadd_nan_op1_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fadd.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fadd.f32(float %x, float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fadd_nan_op1_defaultfp(float %x) #0 {
; CHECK-LABEL: @fadd_nan_op1_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fadd.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fadd.f32(float %x, float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

;
; constrained fsub
;

define float @fsub_nan_op0_strict(float %x) {
; CHECK-LABEL: @fsub_nan_op0_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fsub.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fsub.f32(float 0x7FF8000000000000, float %x, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @fsub_nan_op0_maytrap(float %x) {
; CHECK-LABEL: @fsub_nan_op0_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fsub.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fsub.f32(float 0x7FF8000000000000, float %x, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @fsub_nan_op0_upward(float %x) {
; CHECK-LABEL: @fsub_nan_op0_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fsub.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fsub.f32(float 0x7FF8000000000000, float %x, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fsub_nan_op0_defaultfp(float %x) {
; CHECK-LABEL: @fsub_nan_op0_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fsub.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fsub.f32(float 0x7FF8000000000000, float %x, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fsub_nan_op1_strict(float %x) {
; CHECK-LABEL: @fsub_nan_op1_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fsub.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fsub.f32(float %x, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @fsub_nan_op1_maytrap(float %x) {
; CHECK-LABEL: @fsub_nan_op1_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fsub.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fsub.f32(float %x, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @fsub_nan_op1_upward(float %x) {
; CHECK-LABEL: @fsub_nan_op1_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fsub.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fsub.f32(float %x, float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fsub_nan_op1_defaultfp(float %x) {
; CHECK-LABEL: @fsub_nan_op1_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fsub.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fsub.f32(float %x, float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

;
; constrained fmul
;

define float @fmul_nan_op0_strict(float %x) {
; CHECK-LABEL: @fmul_nan_op0_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fmul.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fmul.f32(float 0x7FF8000000000000, float %x, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @fmul_nan_op0_maytrap(float %x) {
; CHECK-LABEL: @fmul_nan_op0_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fmul.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fmul.f32(float 0x7FF8000000000000, float %x, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @fmul_nan_op0_upward(float %x) {
; CHECK-LABEL: @fmul_nan_op0_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fmul.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fmul.f32(float 0x7FF8000000000000, float %x, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fmul_nan_op0_defaultfp(float %x) {
; CHECK-LABEL: @fmul_nan_op0_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fmul.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fmul.f32(float 0x7FF8000000000000, float %x, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fmul_nan_op1_strict(float %x) {
; CHECK-LABEL: @fmul_nan_op1_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fmul.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fmul.f32(float %x, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @fmul_nan_op1_maytrap(float %x) {
; CHECK-LABEL: @fmul_nan_op1_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fmul.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fmul.f32(float %x, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @fmul_nan_op1_upward(float %x) {
; CHECK-LABEL: @fmul_nan_op1_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fmul.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fmul.f32(float %x, float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fmul_nan_op1_defaultfp(float %x) {
; CHECK-LABEL: @fmul_nan_op1_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fmul.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fmul.f32(float %x, float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

;
; constrained fdiv
;

define float @fdiv_nan_op0_strict(float %x) {
; CHECK-LABEL: @fdiv_nan_op0_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fdiv.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fdiv.f32(float 0x7FF8000000000000, float %x, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @fdiv_nan_op0_maytrap(float %x) {
; CHECK-LABEL: @fdiv_nan_op0_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fdiv.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fdiv.f32(float 0x7FF8000000000000, float %x, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @fdiv_nan_op0_upward(float %x) {
; CHECK-LABEL: @fdiv_nan_op0_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fdiv.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fdiv.f32(float 0x7FF8000000000000, float %x, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fdiv_nan_op0_defaultfp(float %x) {
; CHECK-LABEL: @fdiv_nan_op0_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fdiv.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fdiv.f32(float 0x7FF8000000000000, float %x, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fdiv_nan_op1_strict(float %x) {
; CHECK-LABEL: @fdiv_nan_op1_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fdiv.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fdiv.f32(float %x, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @fdiv_nan_op1_maytrap(float %x) {
; CHECK-LABEL: @fdiv_nan_op1_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fdiv.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fdiv.f32(float %x, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @fdiv_nan_op1_upward(float %x) {
; CHECK-LABEL: @fdiv_nan_op1_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fdiv.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fdiv.f32(float %x, float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fdiv_nan_op1_defaultfp(float %x) {
; CHECK-LABEL: @fdiv_nan_op1_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fdiv.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fdiv.f32(float %x, float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

;
; constrained frem
;

define float @frem_nan_op0_strict(float %x) {
; CHECK-LABEL: @frem_nan_op0_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.frem.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.frem.f32(float 0x7FF8000000000000, float %x, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @frem_nan_op0_maytrap(float %x) {
; CHECK-LABEL: @frem_nan_op0_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.frem.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.frem.f32(float 0x7FF8000000000000, float %x, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @frem_nan_op0_upward(float %x) {
; CHECK-LABEL: @frem_nan_op0_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.frem.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.frem.f32(float 0x7FF8000000000000, float %x, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @frem_nan_op0_defaultfp(float %x) {
; CHECK-LABEL: @frem_nan_op0_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.frem.f32(float 0x7FF8000000000000, float [[X:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.frem.f32(float 0x7FF8000000000000, float %x, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @frem_nan_op1_strict(float %x) {
; CHECK-LABEL: @frem_nan_op1_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.frem.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.frem.f32(float %x, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @frem_nan_op1_maytrap(float %x) {
; CHECK-LABEL: @frem_nan_op1_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.frem.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.frem.f32(float %x, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @frem_nan_op1_upward(float %x) {
; CHECK-LABEL: @frem_nan_op1_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.frem.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.frem.f32(float %x, float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @frem_nan_op1_defaultfp(float %x) {
; CHECK-LABEL: @frem_nan_op1_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.frem.f32(float [[X:%.*]], float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.frem.f32(float %x, float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

;
; constrained fma
;

define float @fma_nan_op0_strict(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op0_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float 0x7FF8000000000000, float [[X:%.*]], float [[Y:%.*]], metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float 0x7FF8000000000000, float %x, float %y, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @fma_nan_op0_maytrap(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op0_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float 0x7FF8000000000000, float [[X:%.*]], float [[Y:%.*]], metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float 0x7FF8000000000000, float %x, float %y, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @fma_nan_op0_upward(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op0_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float 0x7FF8000000000000, float [[X:%.*]], float [[Y:%.*]], metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float 0x7FF8000000000000, float %x, float %y, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fma_nan_op0_defaultfp(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op0_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float 0x7FF8000000000000, float [[X:%.*]], float [[Y:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float 0x7FF8000000000000, float %x, float %y, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fma_nan_op1_strict(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op1_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float [[X:%.*]], float 0x7FF8000000000000, float [[Y:%.*]], metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float %x, float 0x7FF8000000000000, float %y, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @fma_nan_op1_maytrap(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op1_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float [[X:%.*]], float 0x7FF8000000000000, float [[Y:%.*]], metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float %x, float 0x7FF8000000000000, float %y, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @fma_nan_op1_upward(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op1_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float [[X:%.*]], float 0x7FF8000000000000, float [[Y:%.*]], metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float %x, float 0x7FF8000000000000, float %y, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fma_nan_op1_defaultfp(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op1_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float [[X:%.*]], float 0x7FF8000000000000, float [[Y:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float %x, float 0x7FF8000000000000, float %y, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fma_nan_op2_strict(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op2_strict(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float [[X:%.*]], float [[Y:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float %x, float %y, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret float %r
}

define float @fma_nan_op2_maytrap(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op2_maytrap(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float [[X:%.*]], float [[Y:%.*]], float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float %x, float %y, float 0x7FF8000000000000, metadata !"round.dynamic", metadata !"fpexcept.maytrap") #0
  ret float %r
}

define float @fma_nan_op2_upward(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op2_upward(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float [[X:%.*]], float [[Y:%.*]], float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float %x, float %y, float 0x7FF8000000000000, metadata !"round.upward", metadata !"fpexcept.ignore") #0
  ret float %r
}

define float @fma_nan_op2_defaultfp(float %x, float %y) {
; CHECK-LABEL: @fma_nan_op2_defaultfp(
; CHECK-NEXT:    [[R:%.*]] = call float @llvm.experimental.constrained.fma.f32(float [[X:%.*]], float [[Y:%.*]], float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    ret float [[R]]
;
  %r = call float @llvm.experimental.constrained.fma.f32(float %x, float %y, float 0x7FF8000000000000, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  ret float %r
}

declare float @llvm.experimental.constrained.fadd.f32(float, float, metadata, metadata) #0
declare float @llvm.experimental.constrained.fsub.f32(float, float, metadata, metadata) #0
declare float @llvm.experimental.constrained.fmul.f32(float, float, metadata, metadata) #0
declare float @llvm.experimental.constrained.fdiv.f32(float, float, metadata, metadata) #0
declare float @llvm.experimental.constrained.frem.f32(float, float, metadata, metadata) #0
declare float @llvm.experimental.constrained.fma.f32(float, float, float, metadata, metadata) #0

attributes #0 = { strictfp }
