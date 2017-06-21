@ RUN: llvm-mc %s -triple=armv7-linux-gnueabi | FileCheck -check-prefix=ASM %s
@ RUN: llvm-mc %s -triple=armv7-linux-gnueabi -filetype=obj -o %t.o
@ RUN:    llvm-objdump -d -r %t.o -triple=armv7-linux-gnueabi | FileCheck -check-prefix=OBJ %s
	.syntax unified
	.text
	.globl	barf
	.align	2
	.type	barf,%function
barf:                                   @ @barf
@ BB#0:                                 @ %entry
	movw	r0, :lower16:GOT-(.LPC0_2+8)
	movt	r0, :upper16:GOT-(.LPC0_2+8)
.LPC0_2:
@ ASM:          movw    r0, :lower16:(GOT-(.LPC0_2+8))
@ ASM-NEXT:     movt    r0, :upper16:(GOT-(.LPC0_2+8))

@OBJ:      Disassembly of section .text:
@OBJ-NEXT: barf:
@OBJ-NEXT: 0:             f0 0f 0f e3     movw    r0, #65520
@OBJ-NEXT: 00000000:         R_ARM_MOVW_PREL_NC   GOT
@OBJ-NEXT: 4:             f4 0f 4f e3     movt    r0, #65524
@OBJ-NEXT: 00000004:         R_ARM_MOVT_PREL      GOT
