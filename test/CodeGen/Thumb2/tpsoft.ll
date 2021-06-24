; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc  %s -mtriple=thumbv7-linux-gnueabi -o - | \
; RUN:    FileCheck  -check-prefix=ELFASM %s
; RUN: llc  %s -mtriple=thumbebv7-linux-gnueabi -o - | \
; RUN:    FileCheck  -check-prefix=ELFASM %s
; RUN: llc  %s -mtriple=thumbv7-linux-gnueabi -filetype=obj -o - | \
; RUN:    llvm-readobj -S --sd - | FileCheck  -check-prefix=ELFOBJ -check-prefix=ELFOBJ-LE %s
; RUN: llc  %s -mtriple=thumbebv7-linux-gnueabi -filetype=obj -o - | \
; RUN:    llvm-readobj -S --sd - | FileCheck  -check-prefix=ELFOBJ -check-prefix=ELFOBJ-BE %s

;; Make sure that bl __aeabi_read_tp is materialized and fixed up correctly
;; in the obj case.

@i = external thread_local global i32
@a = external global i8
@b = external global [10 x i8]

define arm_aapcs_vfpcc i32 @main() nounwind {
; ELFASM-LABEL: main:
; ELFASM:       @ %bb.0: @ %entry
; ELFASM-NEXT:    .save {r7, lr}
; ELFASM-NEXT:    push {r7, lr}
; ELFASM-NEXT:    ldr r0, .LCPI0_0
; ELFASM-NEXT:  .LPC0_0:
; ELFASM-NEXT:    add r0, pc
; ELFASM-NEXT:    ldr r1, [r0]
; ELFASM-NEXT:    bl __aeabi_read_tp
; ELFASM-NEXT:    ldr r0, [r0, r1]
; ELFASM-NEXT:    cmp r0, #12
; ELFASM-NEXT:    beq .LBB0_3
; ELFASM-NEXT:  @ %bb.1: @ %entry
; ELFASM-NEXT:    cmp r0, #13
; ELFASM-NEXT:    itt ne
; ELFASM-NEXT:    movne.w r0, #-1
; ELFASM-NEXT:    popne {r7, pc}
; ELFASM-NEXT:  .LBB0_2: @ %bb1
; ELFASM-NEXT:    movw r0, :lower16:b
; ELFASM-NEXT:    movt r0, :upper16:b
; ELFASM-NEXT:    pop.w {r7, lr}
; ELFASM-NEXT:    b bar
; ELFASM-NEXT:  .LBB0_3: @ %bb
; ELFASM-NEXT:    movw r0, :lower16:a
; ELFASM-NEXT:    movt r0, :upper16:a
; ELFASM-NEXT:    pop.w {r7, lr}
; ELFASM-NEXT:    b foo
; ELFASM-NEXT:    .p2align 2
; ELFASM-NEXT:  @ %bb.4:
; ELFASM-NEXT:  .LCPI0_0:
; ELFASM-NEXT:  .Ltmp0:
; ELFASM-NEXT:    .long i(GOTTPOFF)-((.LPC0_0+4)-.Ltmp0)
entry:
  %0 = load i32, i32* @i, align 4
  switch i32 %0, label %bb2 [
    i32 12, label %bb
    i32 13, label %bb1
  ]

bb:                                               ; preds = %entry
  %1 = tail call arm_aapcs_vfpcc  i32 @foo(i8* @a) nounwind
  ret i32 %1


; ELFOBJ:      Sections [
; ELFOBJ:        Section {
; ELFOBJ:          Name: .text
; ELFOBJ-LE:          SectionData (
;;;                  BL __aeabi_read_tp is ---+
;;;                                           V
; ELFOBJ-LE-NEXT:     0000: 80B50E48 78440168 FFF7FEFF 40580C28
; ELFOBJ-BE:          SectionData (
;;;                  BL __aeabi_read_tp is ---+
;;;                                           V
; ELFOBJ-BE-NEXT:     0000: B580480E 44786801 F7FFFFFE 5840280C


bb1:                                              ; preds = %entry
  %2 = tail call arm_aapcs_vfpcc  i32 @bar(i32* bitcast ([10 x i8]* @b to i32*)) nounwind
  ret i32 %2

bb2:                                              ; preds = %entry
  ret i32 -1
}

declare arm_aapcs_vfpcc i32 @foo(i8*)

declare arm_aapcs_vfpcc i32 @bar(i32*)
