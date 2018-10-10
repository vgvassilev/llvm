; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mattr=+rtm -mcpu=x86-64 -mattr=+rtm | FileCheck %s --check-prefix=CHECK --check-prefix=GENERIC
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mattr=+rtm -mcpu=skylake | FileCheck %s --check-prefix=CHECK --check-prefix=SKYLAKE --check-prefix=SKL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mattr=+rtm -mcpu=skx | FileCheck %s --check-prefix=CHECK --check-prefix=SKYLAKE --check-prefix=SKX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mattr=+rtm -mcpu=cannonlake | FileCheck %s --check-prefix=CHECK --check-prefix=SKYLAKE --check-prefix=CNL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mattr=+rtm -mcpu=icelake-client | FileCheck %s --check-prefix=CHECK --check-prefix=SKYLAKE --check-prefix=ICL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mattr=+rtm -mcpu=icelake-server | FileCheck %s --check-prefix=CHECK --check-prefix=SKYLAKE --check-prefix=ICL

define i32 @test_xbegin() nounwind uwtable {
; GENERIC-LABEL: test_xbegin:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    xbegin .LBB0_2 # sched: [100:0.33]
; GENERIC-NEXT:  # %bb.1:
; GENERIC-NEXT:    movl $-1, %eax # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
; GENERIC-NEXT:  .LBB0_2:
; GENERIC-NEXT:    # XABORT DEF # sched: [100:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; SKYLAKE-LABEL: test_xbegin:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    xbegin .LBB0_2 # sched: [100:0.25]
; SKYLAKE-NEXT:  # %bb.1:
; SKYLAKE-NEXT:    movl $-1, %eax # sched: [1:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
; SKYLAKE-NEXT:  .LBB0_2:
; SKYLAKE-NEXT:    # XABORT DEF # sched: [100:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
  %1 = tail call i32 @llvm.x86.xbegin() nounwind
  ret i32 %1
}
declare i32 @llvm.x86.xbegin() nounwind

define void @test_xend() nounwind uwtable {
; GENERIC-LABEL: test_xend:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    xend # sched: [100:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; SKYLAKE-LABEL: test_xend:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    xend # sched: [100:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
  tail call void @llvm.x86.xend() nounwind
  ret void
}
declare void @llvm.x86.xend() nounwind

define void @test_xabort() nounwind uwtable {
; GENERIC-LABEL: test_xabort:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    xabort $2 # sched: [100:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; SKYLAKE-LABEL: test_xabort:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    xabort $2 # sched: [100:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
  tail call void @llvm.x86.xabort(i8 2)
  ret void
}
declare void @llvm.x86.xabort(i8) nounwind
