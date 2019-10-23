; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 -mtriple=mipsel-linux-gnu -global-isel -mcpu=mips32r5 -mattr=+msa,+fp64,+nan2008 -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=P5600

declare <16 x i8> @llvm.mips.subv.b(<16 x i8>, <16 x i8>)
define void @sub_v16i8_builtin(<16 x i8>* %a, <16 x i8>* %b, <16 x i8>* %c) {
; P5600-LABEL: sub_v16i8_builtin:
; P5600:       # %bb.0: # %entry
; P5600-NEXT:    ld.b $w0, 0($4)
; P5600-NEXT:    ld.b $w1, 0($5)
; P5600-NEXT:    subv.b $w0, $w0, $w1
; P5600-NEXT:    st.b $w0, 0($6)
; P5600-NEXT:    jr $ra
; P5600-NEXT:    nop
entry:
  %0 = load <16 x i8>, <16 x i8>* %a, align 16
  %1 = load <16 x i8>, <16 x i8>* %b, align 16
  %2 = tail call <16 x i8> @llvm.mips.subv.b(<16 x i8> %0, <16 x i8> %1)
  store <16 x i8> %2, <16 x i8>* %c, align 16
  ret void
}

declare <8 x i16> @llvm.mips.subv.h(<8 x i16>, <8 x i16>)
define void @sub_v8i16_builtin(<8 x i16>* %a, <8 x i16>* %b, <8 x i16>* %c) {
; P5600-LABEL: sub_v8i16_builtin:
; P5600:       # %bb.0: # %entry
; P5600-NEXT:    ld.h $w0, 0($4)
; P5600-NEXT:    ld.h $w1, 0($5)
; P5600-NEXT:    subv.h $w0, $w0, $w1
; P5600-NEXT:    st.h $w0, 0($6)
; P5600-NEXT:    jr $ra
; P5600-NEXT:    nop
entry:
  %0 = load <8 x i16>, <8 x i16>* %a, align 16
  %1 = load <8 x i16>, <8 x i16>* %b, align 16
  %2 = tail call <8 x i16> @llvm.mips.subv.h(<8 x i16> %0, <8 x i16> %1)
  store <8 x i16> %2, <8 x i16>* %c, align 16
  ret void
}

declare <4 x i32> @llvm.mips.subv.w(<4 x i32>, <4 x i32>)
define void @sub_v4i32_builtin(<4 x i32>* %a, <4 x i32>* %b, <4 x i32>* %c) {
; P5600-LABEL: sub_v4i32_builtin:
; P5600:       # %bb.0: # %entry
; P5600-NEXT:    ld.w $w0, 0($4)
; P5600-NEXT:    ld.w $w1, 0($5)
; P5600-NEXT:    subv.w $w0, $w0, $w1
; P5600-NEXT:    st.w $w0, 0($6)
; P5600-NEXT:    jr $ra
; P5600-NEXT:    nop
entry:
  %0 = load <4 x i32>, <4 x i32>* %a, align 16
  %1 = load <4 x i32>, <4 x i32>* %b, align 16
  %2 = tail call <4 x i32> @llvm.mips.subv.w(<4 x i32> %0, <4 x i32> %1)
  store <4 x i32> %2, <4 x i32>* %c, align 16
  ret void
}

declare <2 x i64> @llvm.mips.subv.d(<2 x i64>, <2 x i64>)
define void @sub_v2i64_builtin(<2 x i64>* %a, <2 x i64>* %b, <2 x i64>* %c) {
; P5600-LABEL: sub_v2i64_builtin:
; P5600:       # %bb.0: # %entry
; P5600-NEXT:    ld.d $w0, 0($4)
; P5600-NEXT:    ld.d $w1, 0($5)
; P5600-NEXT:    subv.d $w0, $w0, $w1
; P5600-NEXT:    st.d $w0, 0($6)
; P5600-NEXT:    jr $ra
; P5600-NEXT:    nop
entry:
  %0 = load <2 x i64>, <2 x i64>* %a, align 16
  %1 = load <2 x i64>, <2 x i64>* %b, align 16
  %2 = tail call <2 x i64> @llvm.mips.subv.d(<2 x i64> %0, <2 x i64> %1)
  store <2 x i64> %2, <2 x i64>* %c, align 16
  ret void
}

declare <16 x i8> @llvm.mips.subvi.b(<16 x i8>, i32 immarg)
define void @sub_v16i8_builtin_imm(<16 x i8>* %a, <16 x i8>* %c) {
; P5600-LABEL: sub_v16i8_builtin_imm:
; P5600:       # %bb.0: # %entry
; P5600-NEXT:    ld.b $w0, 0($4)
; P5600-NEXT:    subvi.b $w0, $w0, 3
; P5600-NEXT:    st.b $w0, 0($5)
; P5600-NEXT:    jr $ra
; P5600-NEXT:    nop
entry:
  %0 = load <16 x i8>, <16 x i8>* %a, align 16
  %1 = tail call <16 x i8> @llvm.mips.subvi.b(<16 x i8> %0, i32 3)
  store <16 x i8> %1, <16 x i8>* %c, align 16
  ret void
}

declare <8 x i16> @llvm.mips.subvi.h(<8 x i16>, i32 immarg)
define void @sub_v8i16_builtin_imm(<8 x i16>* %a, <8 x i16>* %c) {
; P5600-LABEL: sub_v8i16_builtin_imm:
; P5600:       # %bb.0: # %entry
; P5600-NEXT:    ld.h $w0, 0($4)
; P5600-NEXT:    subvi.h $w0, $w0, 18
; P5600-NEXT:    st.h $w0, 0($5)
; P5600-NEXT:    jr $ra
; P5600-NEXT:    nop
entry:
  %0 = load <8 x i16>, <8 x i16>* %a, align 16
  %1 = tail call <8 x i16> @llvm.mips.subvi.h(<8 x i16> %0, i32 18)
  store <8 x i16> %1, <8 x i16>* %c, align 16
  ret void
}

declare <4 x i32> @llvm.mips.subvi.w(<4 x i32>, i32 immarg)
define void @sub_v4i32_builtin_imm(<4 x i32>* %a, <4 x i32>* %c) {
; P5600-LABEL: sub_v4i32_builtin_imm:
; P5600:       # %bb.0: # %entry
; P5600-NEXT:    ld.w $w0, 0($4)
; P5600-NEXT:    subvi.w $w0, $w0, 25
; P5600-NEXT:    st.w $w0, 0($5)
; P5600-NEXT:    jr $ra
; P5600-NEXT:    nop
entry:
  %0 = load <4 x i32>, <4 x i32>* %a, align 16
  %1 = tail call <4 x i32> @llvm.mips.subvi.w(<4 x i32> %0, i32 25)
  store <4 x i32> %1, <4 x i32>* %c, align 16
  ret void
}

declare <2 x i64> @llvm.mips.subvi.d(<2 x i64>, i32 immarg)
define void @sub_v2i64_builtin_imm(<2 x i64>* %a, <2 x i64>* %c) {
; P5600-LABEL: sub_v2i64_builtin_imm:
; P5600:       # %bb.0: # %entry
; P5600-NEXT:    ld.d $w0, 0($4)
; P5600-NEXT:    subvi.d $w0, $w0, 31
; P5600-NEXT:    st.d $w0, 0($5)
; P5600-NEXT:    jr $ra
; P5600-NEXT:    nop
entry:
  %0 = load <2 x i64>, <2 x i64>* %a, align 16
  %1 = tail call <2 x i64> @llvm.mips.subvi.d(<2 x i64> %0, i32 31)
  store <2 x i64> %1, <2 x i64>* %c, align 16
  ret void
}
