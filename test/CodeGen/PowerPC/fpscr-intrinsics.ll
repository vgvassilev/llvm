; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu < %s | \
; RUN:   FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-aix -mcpu=pwr7 \
; RUN:   < %s | FileCheck %s --check-prefix=CHECK-AIX64
; RUN: llc -verify-machineinstrs -mtriple=powerpc-unknown-aix -mcpu=pwr8 < %s | \
; RUN:   FileCheck %s --check-prefix=CHECK-AIX32

define dso_local void @mtfsb0() local_unnamed_addr #0 {
; CHECK-PWR8-LABEL: mtfsb0:
; CHECK-PWR8:       # %bb.0: # %entry
; CHECK-PWR8-NEXT:    mtfsb0 10
; CHECK-PWR8-NEXT:    blr
;
; CHECK-PWR7-LABEL: mtfsb0:
; CHECK-PWR7:       # %bb.0: # %entry
; CHECK-PWR7-NEXT:    mtfsb0 10
; CHECK-PWR7-NEXT:    blr
; CHECK-LABEL: mtfsb0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mtfsb0 10
; CHECK-NEXT:    blr
;
; CHECK-AIX64-LABEL: mtfsb0:
; CHECK-AIX64:       # %bb.0: # %entry
; CHECK-AIX64-NEXT:    mtfsb0 10
; CHECK-AIX64-NEXT:    blr
;
; CHECK-AIX32-LABEL: mtfsb0:
; CHECK-AIX32:       # %bb.0: # %entry
; CHECK-AIX32-NEXT:    mtfsb0 10
; CHECK-AIX32-NEXT:    blr
entry:
  tail call void @llvm.ppc.mtfsb0(i32 10)
  ret void
}

define dso_local void @mtfsb1() local_unnamed_addr #0 {
; CHECK-PWR8-LABEL: mtfsb1:
; CHECK-PWR8:       # %bb.0: # %entry
; CHECK-PWR8-NEXT:    mtfsb1 0
; CHECK-PWR8-NEXT:    blr
;
; CHECK-PWR7-LABEL: mtfsb1:
; CHECK-PWR7:       # %bb.0: # %entry
; CHECK-PWR7-NEXT:    mtfsb1 0
; CHECK-PWR7-NEXT:    blr
; CHECK-LABEL: mtfsb1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mtfsb1 0
; CHECK-NEXT:    blr
;
; CHECK-AIX64-LABEL: mtfsb1:
; CHECK-AIX64:       # %bb.0: # %entry
; CHECK-AIX64-NEXT:    mtfsb1 0
; CHECK-AIX64-NEXT:    blr
;
; CHECK-AIX32-LABEL: mtfsb1:
; CHECK-AIX32:       # %bb.0: # %entry
; CHECK-AIX32-NEXT:    mtfsb1 0
; CHECK-AIX32-NEXT:    blr
entry:
  tail call void @llvm.ppc.mtfsb1(i32 0)
  ret void
}

define dso_local void @callmtfsf(i32 zeroext %a) local_unnamed_addr {
; CHECK-LABEL: callmtfsf:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mtfprwz 0, 3
; CHECK-NEXT:    xscvuxddp 0, 0
; CHECK-NEXT:    mtfsf 7, 0
; CHECK-NEXT:    blr
;
; CHECK-AIX64-LABEL: callmtfsf:
; CHECK-AIX64:       # %bb.0: # %entry
; CHECK-AIX64-NEXT:    addi 4, 1, -4
; CHECK-AIX64-NEXT:    stw 3, -4(1)
; CHECK-AIX64-NEXT:    lfiwzx 0, 0, 4
; CHECK-AIX64-NEXT:    xscvuxddp 0, 0
; CHECK-AIX64-NEXT:    mtfsf 7, 0
; CHECK-AIX64-NEXT:    blr
;
; CHECK-AIX32-LABEL: callmtfsf:
; CHECK-AIX32:       # %bb.0: # %entry
; CHECK-AIX32-NEXT:    addi 4, 1, -4
; CHECK-AIX32-NEXT:    stw 3, -4(1)
; CHECK-AIX32-NEXT:    lfiwzx 0, 0, 4
; CHECK-AIX32-NEXT:    xscvuxddp 0, 0
; CHECK-AIX32-NEXT:    mtfsf 7, 0
; CHECK-AIX32-NEXT:    blr
entry:
  %0 = uitofp i32 %a to double
  tail call void @llvm.ppc.mtfsf(i32 7, double %0)
  ret void
}

define dso_local void @callmtfsfi(i32 zeroext %a) local_unnamed_addr {
; CHECK-LABEL: callmtfsfi:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mtfsfi 1, 3
; CHECK-NEXT:    blr
;
; CHECK-AIX64-LABEL: callmtfsfi:
; CHECK-AIX64:       # %bb.0: # %entry
; CHECK-AIX64-NEXT:    mtfsfi 1, 3
; CHECK-AIX64-NEXT:    blr
;
; CHECK-AIX32-LABEL: callmtfsfi:
; CHECK-AIX32:       # %bb.0: # %entry
; CHECK-AIX32-NEXT:    mtfsfi 1, 3
; CHECK-AIX32-NEXT:    blr
entry:
  tail call void @llvm.ppc.mtfsfi(i32 1, i32 3)
  ret void
}

declare void @llvm.ppc.mtfsb0(i32)
declare void @llvm.ppc.mtfsb1(i32)
declare void @llvm.ppc.mtfsfi(i32, i32)
declare void @llvm.ppc.mtfsf(i32, double)
