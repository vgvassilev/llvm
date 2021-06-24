; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -ppc-asm-full-reg-names -verify-machineinstrs < %s -mtriple=ppc32--     -mcpu=ppc32 | FileCheck %s --check-prefixes=X32
; RUN: llc -ppc-asm-full-reg-names -verify-machineinstrs < %s -mtriple=ppc32--     -mcpu=pwr7  | FileCheck %s --check-prefixes=X32,PWR7_32
; RUN: llc -ppc-asm-full-reg-names -verify-machineinstrs < %s -mtriple=powerpc64-- -mcpu=ppc64 | FileCheck %s --check-prefixes=X64
; RUN: llc -ppc-asm-full-reg-names -verify-machineinstrs < %s -mtriple=powerpc64-- -mcpu=pwr7  | FileCheck %s --check-prefixes=PWR7_64


define void @STWBRX(i32 %i, i8* %ptr, i32 %off) {
; X32-LABEL: STWBRX:
; X32:       # %bb.0:
; X32-NEXT:    stwbrx r3, r4, r5
; X32-NEXT:    blr
;
; X64-LABEL: STWBRX:
; X64:       # %bb.0:
; X64-NEXT:    extsw r5, r5
; X64-NEXT:    stwbrx r3, r4, r5
; X64-NEXT:    blr
;
; PWR7_64-LABEL: STWBRX:
; PWR7_64:       # %bb.0:
; PWR7_64-NEXT:    extsw r5, r5
; PWR7_64-NEXT:    stwbrx r3, r4, r5
; PWR7_64-NEXT:    blr
  %tmp1 = getelementptr i8, i8* %ptr, i32 %off
  %tmp1.upgrd.1 = bitcast i8* %tmp1 to i32*
  %tmp13 = tail call i32 @llvm.bswap.i32( i32 %i )
  store i32 %tmp13, i32* %tmp1.upgrd.1
  ret void
}

define i32 @LWBRX(i8* %ptr, i32 %off) {
; X32-LABEL: LWBRX:
; X32:       # %bb.0:
; X32-NEXT:    lwbrx r3, r3, r4
; X32-NEXT:    blr
;
; X64-LABEL: LWBRX:
; X64:       # %bb.0:
; X64-NEXT:    extsw r4, r4
; X64-NEXT:    lwbrx r3, r3, r4
; X64-NEXT:    blr
;
; PWR7_64-LABEL: LWBRX:
; PWR7_64:       # %bb.0:
; PWR7_64-NEXT:    extsw r4, r4
; PWR7_64-NEXT:    lwbrx r3, r3, r4
; PWR7_64-NEXT:    blr
  %tmp1 = getelementptr i8, i8* %ptr, i32 %off
  %tmp1.upgrd.2 = bitcast i8* %tmp1 to i32*
  %tmp = load i32, i32* %tmp1.upgrd.2
  %tmp14 = tail call i32 @llvm.bswap.i32( i32 %tmp )
  ret i32 %tmp14
}

define void @STHBRX(i16 %s, i8* %ptr, i32 %off) {
; X32-LABEL: STHBRX:
; X32:       # %bb.0:
; X32-NEXT:    sthbrx r3, r4, r5
; X32-NEXT:    blr
;
; X64-LABEL: STHBRX:
; X64:       # %bb.0:
; X64-NEXT:    extsw r5, r5
; X64-NEXT:    sthbrx r3, r4, r5
; X64-NEXT:    blr
;
; PWR7_64-LABEL: STHBRX:
; PWR7_64:       # %bb.0:
; PWR7_64-NEXT:    extsw r5, r5
; PWR7_64-NEXT:    sthbrx r3, r4, r5
; PWR7_64-NEXT:    blr
  %tmp1 = getelementptr i8, i8* %ptr, i32 %off
  %tmp1.upgrd.3 = bitcast i8* %tmp1 to i16*
  %tmp5 = call i16 @llvm.bswap.i16( i16 %s )
  store i16 %tmp5, i16* %tmp1.upgrd.3
  ret void
}

define i16 @LHBRX(i8* %ptr, i32 %off) {
; X32-LABEL: LHBRX:
; X32:       # %bb.0:
; X32-NEXT:    lhbrx r3, r3, r4
; X32-NEXT:    blr
;
; X64-LABEL: LHBRX:
; X64:       # %bb.0:
; X64-NEXT:    extsw r4, r4
; X64-NEXT:    lhbrx r3, r3, r4
; X64-NEXT:    blr
;
; PWR7_64-LABEL: LHBRX:
; PWR7_64:       # %bb.0:
; PWR7_64-NEXT:    extsw r4, r4
; PWR7_64-NEXT:    lhbrx r3, r3, r4
; PWR7_64-NEXT:    blr
  %tmp1 = getelementptr i8, i8* %ptr, i32 %off
  %tmp1.upgrd.4 = bitcast i8* %tmp1 to i16*
  %tmp = load i16, i16* %tmp1.upgrd.4
  %tmp6 = call i16 @llvm.bswap.i16( i16 %tmp )
  ret i16 %tmp6
}

; TODO: combine the bswap feeding a store on subtargets
; that do not have an STDBRX.
define void @STDBRX(i64 %i, i8* %ptr, i64 %off) {
; PWR7_32-LABEL: STDBRX:
; PWR7_32:       # %bb.0:
; PWR7_32-NEXT:    li r6, 4
; PWR7_32-NEXT:    add r7, r5, r8
; PWR7_32-NEXT:    stwbrx r4, r5, r8
; PWR7_32-NEXT:    stwbrx r3, r7, r6
; PWR7_32-NEXT:    blr
;
; X64-LABEL: STDBRX:
; X64:       # %bb.0:
; X64-NEXT:    rotldi r6, r3, 16
; X64-NEXT:    rotldi r7, r3, 8
; X64-NEXT:    rldimi r7, r6, 8, 48
; X64-NEXT:    rotldi r6, r3, 24
; X64-NEXT:    rldimi r7, r6, 16, 40
; X64-NEXT:    rotldi r6, r3, 32
; X64-NEXT:    rldimi r7, r6, 24, 32
; X64-NEXT:    rotldi r6, r3, 48
; X64-NEXT:    rldimi r7, r6, 40, 16
; X64-NEXT:    rotldi r6, r3, 56
; X64-NEXT:    rldimi r7, r6, 48, 8
; X64-NEXT:    rldimi r7, r3, 56, 0
; X64-NEXT:    stdx r7, r4, r5
; X64-NEXT:    blr
;
; PWR7_64-LABEL: STDBRX:
; PWR7_64:       # %bb.0:
; PWR7_64-NEXT:    stdbrx r3, r4, r5
; PWR7_64-NEXT:    blr
  %tmp1 = getelementptr i8, i8* %ptr, i64 %off
  %tmp1.upgrd.1 = bitcast i8* %tmp1 to i64*
  %tmp13 = tail call i64 @llvm.bswap.i64( i64 %i )
  store i64 %tmp13, i64* %tmp1.upgrd.1
  ret void
}

define i64 @LDBRX(i8* %ptr, i64 %off) {
; PWR7_32-LABEL: LDBRX:
; PWR7_32:       # %bb.0:
; PWR7_32-NEXT:    li r5, 4
; PWR7_32-NEXT:    add r7, r3, r6
; PWR7_32-NEXT:    lwbrx r4, r3, r6
; PWR7_32-NEXT:    lwbrx r3, r7, r5
; PWR7_32-NEXT:    blr
;
; X64-LABEL: LDBRX:
; X64:       # %bb.0:
; X64-NEXT:    li r6, 4
; X64-NEXT:    lwbrx r5, r3, r4
; X64-NEXT:    add r3, r3, r4
; X64-NEXT:    lwbrx r3, r3, r6
; X64-NEXT:    rldimi r5, r3, 32, 0
; X64-NEXT:    mr r3, r5
; X64-NEXT:    blr
;
; PWR7_64-LABEL: LDBRX:
; PWR7_64:       # %bb.0:
; PWR7_64-NEXT:    ldbrx r3, r3, r4
; PWR7_64-NEXT:    blr
  %tmp1 = getelementptr i8, i8* %ptr, i64 %off
  %tmp1.upgrd.2 = bitcast i8* %tmp1 to i64*
  %tmp = load i64, i64* %tmp1.upgrd.2
  %tmp14 = tail call i64 @llvm.bswap.i64( i64 %tmp )
  ret i64 %tmp14
}

declare i16 @llvm.bswap.i16(i16)
declare i32 @llvm.bswap.i32(i32)
declare i64 @llvm.bswap.i64(i64)
