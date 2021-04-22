; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-b -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32IB
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zbp -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32IBP

declare i32 @llvm.riscv.grev.i32(i32 %a, i32 %b)

define i32 @grev32(i32 %a, i32 %b) nounwind {
; RV32IB-LABEL: grev32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    grev a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBP-LABEL: grev32:
; RV32IBP:       # %bb.0:
; RV32IBP-NEXT:    grev a0, a0, a1
; RV32IBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.grev.i32(i32 %a, i32 %b)
 ret i32 %tmp
}

declare i32 @llvm.riscv.grevi.i32(i32 %a)

define i32 @grevi32(i32 %a) nounwind {
; RV32IB-LABEL: grevi32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    grevi a0, a0, 13
; RV32IB-NEXT:    ret
;
; RV32IBP-LABEL: grevi32:
; RV32IBP:       # %bb.0:
; RV32IBP-NEXT:    grevi a0, a0, 13
; RV32IBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.grev.i32(i32 %a, i32 13)
 ret i32 %tmp
}

declare i32 @llvm.riscv.gorc.i32(i32 %a, i32 %b)

define i32 @gorc32(i32 %a, i32 %b) nounwind {
; RV32IB-LABEL: gorc32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    gorc a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBP-LABEL: gorc32:
; RV32IBP:       # %bb.0:
; RV32IBP-NEXT:    gorc a0, a0, a1
; RV32IBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.gorc.i32(i32 %a, i32 %b)
 ret i32 %tmp
}

declare i32 @llvm.riscv.gorci.i32(i32 %a)

define i32 @gorci32(i32 %a) nounwind {
; RV32IB-LABEL: gorci32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    gorci a0, a0, 13
; RV32IB-NEXT:    ret
;
; RV32IBP-LABEL: gorci32:
; RV32IBP:       # %bb.0:
; RV32IBP-NEXT:    gorci a0, a0, 13
; RV32IBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.gorc.i32(i32 %a, i32 13)
 ret i32 %tmp
}

declare i32 @llvm.riscv.shfl.i32(i32 %a, i32 %b)

define i32 @shfl32(i32 %a, i32 %b) nounwind {
; RV32IB-LABEL: shfl32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    shfl a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBP-LABEL: shfl32:
; RV32IBP:       # %bb.0:
; RV32IBP-NEXT:    shfl a0, a0, a1
; RV32IBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.shfl.i32(i32 %a, i32 %b)
 ret i32 %tmp
}

declare i32 @llvm.riscv.shfli.i32(i32 %a)

define i32 @shfli32(i32 %a) nounwind {
; RV32IB-LABEL: shfli32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    shfli a0, a0, 13
; RV32IB-NEXT:    ret
;
; RV32IBP-LABEL: shfli32:
; RV32IBP:       # %bb.0:
; RV32IBP-NEXT:    shfli a0, a0, 13
; RV32IBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.shfl.i32(i32 %a, i32 13)
 ret i32 %tmp
}

declare i32 @llvm.riscv.unshfl.i32(i32 %a, i32 %b)

define i32 @unshfl32(i32 %a, i32 %b) nounwind {
; RV32IB-LABEL: unshfl32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    unshfl a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBP-LABEL: unshfl32:
; RV32IBP:       # %bb.0:
; RV32IBP-NEXT:    unshfl a0, a0, a1
; RV32IBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.unshfl.i32(i32 %a, i32 %b)
 ret i32 %tmp
}

declare i32 @llvm.riscv.unshfli.i32(i32 %a)

define i32 @unshfli32(i32 %a) nounwind {
; RV32IB-LABEL: unshfli32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    unshfli a0, a0, 13
; RV32IB-NEXT:    ret
;
; RV32IBP-LABEL: unshfli32:
; RV32IBP:       # %bb.0:
; RV32IBP-NEXT:    unshfli a0, a0, 13
; RV32IBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.unshfl.i32(i32 %a, i32 13)
 ret i32 %tmp
}

declare i32 @llvm.riscv.xperm.n.i32(i32 %a, i32 %b)

define i32 @xpermn32(i32 %a, i32 %b) nounwind {
; RV32IB-LABEL: xpermn32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    xperm.n a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBP-LABEL: xpermn32:
; RV32IBP:       # %bb.0:
; RV32IBP-NEXT:    xperm.n a0, a0, a1
; RV32IBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.xperm.n.i32(i32 %a, i32 %b)
 ret i32 %tmp
}

declare i32 @llvm.riscv.xperm.b.i32(i32 %a, i32 %b)

define i32 @xpermb32(i32 %a, i32 %b) nounwind {
; RV32IB-LABEL: xpermb32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    xperm.b a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBP-LABEL: xpermb32:
; RV32IBP:       # %bb.0:
; RV32IBP-NEXT:    xperm.b a0, a0, a1
; RV32IBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.xperm.b.i32(i32 %a, i32 %b)
 ret i32 %tmp
}

declare i32 @llvm.riscv.xperm.h.i32(i32 %a, i32 %b)

define i32 @xpermh32(i32 %a, i32 %b) nounwind {
; RV32IB-LABEL: xpermh32:
; RV32IB:       # %bb.0:
; RV32IB-NEXT:    xperm.h a0, a0, a1
; RV32IB-NEXT:    ret
;
; RV32IBP-LABEL: xpermh32:
; RV32IBP:       # %bb.0:
; RV32IBP-NEXT:    xperm.h a0, a0, a1
; RV32IBP-NEXT:    ret
  %tmp = call i32 @llvm.riscv.xperm.h.i32(i32 %a, i32 %b)
 ret i32 %tmp
}
