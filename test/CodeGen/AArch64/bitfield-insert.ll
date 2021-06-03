; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-none-linux-gnu < %s | FileCheck %s

; First, a simple example from Clang. The registers could plausibly be
; different, but probably won't be.

%struct.foo = type { i8, [2 x i8], i8 }

define [1 x i64] @from_clang([1 x i64] %f.coerce, i32 %n) nounwind readnone {
; CHECK-LABEL: from_clang:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w8, #135
; CHECK-NEXT:    and w8, w0, w8
; CHECK-NEXT:    bfi w8, w1, #3, #4
; CHECK-NEXT:    and x9, x0, #0xffffff00
; CHECK-NEXT:    orr x0, x8, x9
; CHECK-NEXT:    ret
entry:
  %f.coerce.fca.0.extract = extractvalue [1 x i64] %f.coerce, 0
  %tmp.sroa.0.0.extract.trunc = trunc i64 %f.coerce.fca.0.extract to i32
  %bf.value = shl i32 %n, 3
  %0 = and i32 %bf.value, 120
  %f.sroa.0.0.insert.ext.masked = and i32 %tmp.sroa.0.0.extract.trunc, 135
  %1 = or i32 %f.sroa.0.0.insert.ext.masked, %0
  %f.sroa.0.0.extract.trunc = zext i32 %1 to i64
  %tmp1.sroa.1.1.insert.insert = and i64 %f.coerce.fca.0.extract, 4294967040
  %tmp1.sroa.0.0.insert.insert = or i64 %f.sroa.0.0.extract.trunc, %tmp1.sroa.1.1.insert.insert
  %.fca.0.insert = insertvalue [1 x i64] undef, i64 %tmp1.sroa.0.0.insert.insert, 0
  ret [1 x i64] %.fca.0.insert
}

define void @test_whole32(i32* %existing, i32* %new) {
; CHECK-LABEL: test_whole32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    ldr w9, [x1]
; CHECK-NEXT:    bfi w8, w9, #26, #5
; CHECK-NEXT:    str w8, [x0]
; CHECK-NEXT:    ret
  %oldval = load volatile i32, i32* %existing
  %oldval_keep = and i32 %oldval, 2214592511 ; =0x83ffffff

  %newval = load volatile i32, i32* %new
  %newval_shifted = shl i32 %newval, 26
  %newval_masked = and i32 %newval_shifted, 2080374784 ; = 0x7c000000

  %combined = or i32 %oldval_keep, %newval_masked
  store volatile i32 %combined, i32* %existing

  ret void
}

define void @test_whole64(i64* %existing, i64* %new) {
; CHECK-LABEL: test_whole64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    ldr x9, [x1]
; CHECK-NEXT:    bfi x8, x9, #26, #14
; CHECK-NEXT:    str x8, [x0]
; CHECK-NEXT:    ret
  %oldval = load volatile i64, i64* %existing
  %oldval_keep = and i64 %oldval, 18446742974265032703 ; = 0xffffff0003ffffffL

  %newval = load volatile i64, i64* %new
  %newval_shifted = shl i64 %newval, 26
  %newval_masked = and i64 %newval_shifted, 1099444518912 ; = 0xfffc000000

  %combined = or i64 %oldval_keep, %newval_masked
  store volatile i64 %combined, i64* %existing

  ret void
}

define void @test_whole32_from64(i64* %existing, i64* %new) {
; CHECK-LABEL: test_whole32_from64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    ldr x9, [x1]
; CHECK-NEXT:    and x8, x8, #0xffff0000
; CHECK-NEXT:    bfxil x8, x9, #0, #16
; CHECK-NEXT:    str x8, [x0]
; CHECK-NEXT:    ret
  %oldval = load volatile i64, i64* %existing
  %oldval_keep = and i64 %oldval, 4294901760 ; = 0xffff0000

  %newval = load volatile i64, i64* %new
  %newval_masked = and i64 %newval, 65535 ; = 0xffff

  %combined = or i64 %oldval_keep, %newval_masked
  store volatile i64 %combined, i64* %existing

  ret void
}

define void @test_32bit_masked(i32 *%existing, i32 *%new) {
; CHECK-LABEL: test_32bit_masked:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    ldr w9, [x1]
; CHECK-NEXT:    mov w10, #135
; CHECK-NEXT:    and w8, w8, w10
; CHECK-NEXT:    bfi w8, w9, #3, #4
; CHECK-NEXT:    str w8, [x0]
; CHECK-NEXT:    ret
  %oldval = load volatile i32, i32* %existing
  %oldval_keep = and i32 %oldval, 135 ; = 0x87

  %newval = load volatile i32, i32* %new
  %newval_shifted = shl i32 %newval, 3
  %newval_masked = and i32 %newval_shifted, 120 ; = 0x78

  %combined = or i32 %oldval_keep, %newval_masked
  store volatile i32 %combined, i32* %existing

  ret void
}

define void @test_64bit_masked(i64 *%existing, i64 *%new) {
; CHECK-LABEL: test_64bit_masked:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    ldr x9, [x1]
; CHECK-NEXT:    and x8, x8, #0xff00000000
; CHECK-NEXT:    bfi x8, x9, #40, #8
; CHECK-NEXT:    str x8, [x0]
; CHECK-NEXT:    ret
  %oldval = load volatile i64, i64* %existing
  %oldval_keep = and i64 %oldval, 1095216660480 ; = 0xff_0000_0000

  %newval = load volatile i64, i64* %new
  %newval_shifted = shl i64 %newval, 40
  %newval_masked = and i64 %newval_shifted, 280375465082880 ; = 0xff00_0000_0000

  %combined = or i64 %newval_masked, %oldval_keep
  store volatile i64 %combined, i64* %existing

  ret void
}

; Mask is too complicated for literal ANDwwi, make sure other avenues are tried.
define void @test_32bit_complexmask(i32 *%existing, i32 *%new) {
; CHECK-LABEL: test_32bit_complexmask:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    ldr w9, [x1]
; CHECK-NEXT:    mov w10, #647
; CHECK-NEXT:    and w8, w8, w10
; CHECK-NEXT:    bfi w8, w9, #3, #4
; CHECK-NEXT:    str w8, [x0]
; CHECK-NEXT:    ret
  %oldval = load volatile i32, i32* %existing
  %oldval_keep = and i32 %oldval, 647 ; = 0x287

  %newval = load volatile i32, i32* %new
  %newval_shifted = shl i32 %newval, 3
  %newval_masked = and i32 %newval_shifted, 120 ; = 0x278

  %combined = or i32 %oldval_keep, %newval_masked
  store volatile i32 %combined, i32* %existing

  ret void
}

; Neither mask is a contiguous set of 1s. BFI can't be used
define void @test_32bit_badmask(i32 *%existing, i32 *%new) {
; CHECK-LABEL: test_32bit_badmask:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    ldr w9, [x1]
; CHECK-NEXT:    mov w10, #135
; CHECK-NEXT:    mov w11, #632
; CHECK-NEXT:    and w8, w8, w10
; CHECK-NEXT:    and w9, w11, w9, lsl #3
; CHECK-NEXT:    orr w8, w8, w9
; CHECK-NEXT:    str w8, [x0]
; CHECK-NEXT:    ret
  %oldval = load volatile i32, i32* %existing
  %oldval_keep = and i32 %oldval, 135 ; = 0x87

  %newval = load volatile i32, i32* %new
  %newval_shifted = shl i32 %newval, 3
  %newval_masked = and i32 %newval_shifted, 632 ; = 0x278

  %combined = or i32 %oldval_keep, %newval_masked
  store volatile i32 %combined, i32* %existing

  ret void
}

; Ditto
define void @test_64bit_badmask(i64 *%existing, i64 *%new) {
; CHECK-LABEL: test_64bit_badmask:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr x8, [x0]
; CHECK-NEXT:    ldr x9, [x1]
; CHECK-NEXT:    mov w10, #135
; CHECK-NEXT:    and x8, x8, x10
; CHECK-NEXT:    lsl w9, w9, #3
; CHECK-NEXT:    mov w10, #664
; CHECK-NEXT:    and x9, x9, x10
; CHECK-NEXT:    orr x8, x8, x9
; CHECK-NEXT:    str x8, [x0]
; CHECK-NEXT:    ret
  %oldval = load volatile i64, i64* %existing
  %oldval_keep = and i64 %oldval, 135 ; = 0x87

  %newval = load volatile i64, i64* %new
  %newval_shifted = shl i64 %newval, 3
  %newval_masked = and i64 %newval_shifted, 664 ; = 0x278

  %combined = or i64 %oldval_keep, %newval_masked
  store volatile i64 %combined, i64* %existing

  ret void
}

; Bitfield insert where there's a left-over shr needed at the beginning
; (e.g. result of str.bf1 = str.bf2)
define void @test_32bit_with_shr(i32* %existing, i32* %new) {
; CHECK-LABEL: test_32bit_with_shr:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    ldr w9, [x1]
; CHECK-NEXT:    lsr w9, w9, #14
; CHECK-NEXT:    bfi w8, w9, #26, #5
; CHECK-NEXT:    str w8, [x0]
; CHECK-NEXT:    ret
  %oldval = load volatile i32, i32* %existing
  %oldval_keep = and i32 %oldval, 2214592511 ; =0x83ffffff

  %newval = load i32, i32* %new
  %newval_shifted = shl i32 %newval, 12
  %newval_masked = and i32 %newval_shifted, 2080374784 ; = 0x7c000000

  %combined = or i32 %oldval_keep, %newval_masked
  store volatile i32 %combined, i32* %existing

  ret void
}

; Bitfield insert where the second or operand is a better match to be folded into the BFM
define void @test_32bit_opnd1_better(i32* %existing, i32* %new) {
; CHECK-LABEL: test_32bit_opnd1_better:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    ldr w9, [x1]
; CHECK-NEXT:    and w8, w8, #0xffff
; CHECK-NEXT:    bfi w8, w9, #16, #8
; CHECK-NEXT:    str w8, [x0]
; CHECK-NEXT:    ret
  %oldval = load volatile i32, i32* %existing
  %oldval_keep = and i32 %oldval, 65535 ; 0x0000ffff

  %newval = load i32, i32* %new
  %newval_shifted = shl i32 %newval, 16
  %newval_masked = and i32 %newval_shifted, 16711680 ; 0x00ff0000

  %combined = or i32 %oldval_keep, %newval_masked
  store volatile i32 %combined, i32* %existing

  ret void
}

; Tests when all the bits from one operand are not useful
define i32 @test_nouseful_bits(i8 %a, i32 %b) {
; CHECK-LABEL: test_nouseful_bits:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xff
; CHECK-NEXT:    lsl w8, w8, #8
; CHECK-NEXT:    mov w9, w8
; CHECK-NEXT:    bfxil w9, w0, #0, #8
; CHECK-NEXT:    bfi w8, w9, #16, #16
; CHECK-NEXT:    mov w0, w8
; CHECK-NEXT:    ret
  %conv = zext i8 %a to i32     ;   0  0  0  A
  %shl = shl i32 %b, 8          ;   B2 B1 B0 0
  %or = or i32 %conv, %shl      ;   B2 B1 B0 A
  %shl.1 = shl i32 %or, 8       ;   B1 B0 A 0
  %or.1 = or i32 %conv, %shl.1  ;   B1 B0 A A
  %shl.2 = shl i32 %or.1, 8     ;   B0 A A 0
  %or.2 = or i32 %conv, %shl.2  ;   B0 A A A
  %shl.3 = shl i32 %or.2, 8     ;   A A A 0
  %or.3 = or i32 %conv, %shl.3  ;   A A A A
  %shl.4 = shl i32 %or.3, 8     ;   A A A 0
  ret i32 %shl.4
}

define void @test_nouseful_strb(i32* %ptr32, i8* %ptr8, i32 %x)  {
; CHECK-LABEL: test_nouseful_strb:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    bfxil w8, w2, #16, #3
; CHECK-NEXT:    strb w8, [x1]
; CHECK-NEXT:    ret
entry:
  %0 = load i32, i32* %ptr32, align 8
  %and = and i32 %0, -8
  %shr = lshr i32 %x, 16
  %and1 = and i32 %shr, 7
  %or = or i32 %and, %and1
  %trunc = trunc i32 %or to i8
  store i8 %trunc, i8* %ptr8
  ret void
}

define void @test_nouseful_strh(i32* %ptr32, i16* %ptr16, i32 %x)  {
; CHECK-LABEL: test_nouseful_strh:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    bfxil w8, w2, #16, #4
; CHECK-NEXT:    strh w8, [x1]
; CHECK-NEXT:    ret
entry:
  %0 = load i32, i32* %ptr32, align 8
  %and = and i32 %0, -16
  %shr = lshr i32 %x, 16
  %and1 = and i32 %shr, 15
  %or = or i32 %and, %and1
  %trunc = trunc i32 %or to i16
  store i16 %trunc, i16* %ptr16
  ret void
}

define void @test_nouseful_sturb(i32* %ptr32, i8* %ptr8, i32 %x)  {
; CHECK-LABEL: test_nouseful_sturb:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    bfxil w8, w2, #16, #3
; CHECK-NEXT:    sturb w8, [x1, #-1]
; CHECK-NEXT:    ret
entry:
  %0 = load i32, i32* %ptr32, align 8
  %and = and i32 %0, -8
  %shr = lshr i32 %x, 16
  %and1 = and i32 %shr, 7
  %or = or i32 %and, %and1
  %trunc = trunc i32 %or to i8
  %gep = getelementptr i8, i8* %ptr8, i64 -1
  store i8 %trunc, i8* %gep
  ret void
}

define void @test_nouseful_sturh(i32* %ptr32, i16* %ptr16, i32 %x)  {
; CHECK-LABEL: test_nouseful_sturh:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    bfxil w8, w2, #16, #4
; CHECK-NEXT:    sturh w8, [x1, #-2]
; CHECK-NEXT:    ret
entry:
  %0 = load i32, i32* %ptr32, align 8
  %and = and i32 %0, -16
  %shr = lshr i32 %x, 16
  %and1 = and i32 %shr, 15
  %or = or i32 %and, %and1
  %trunc = trunc i32 %or to i16
  %gep = getelementptr i16, i16* %ptr16, i64 -1
  store i16 %trunc, i16* %gep
  ret void
}

; The next set of tests generate a BFXIL from 'or (and X, Mask0Imm),
; (and Y, Mask1Imm)' iff Mask0Imm and ~Mask1Imm are equivalent and one of the
; MaskImms is a shifted mask (e.g., 0x000ffff0).

define i32 @test_or_and_and1(i32 %a, i32 %b) {
; CHECK-LABEL: test_or_and_and1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsr w8, w1, #4
; CHECK-NEXT:    bfi w0, w8, #4, #12
; CHECK-NEXT:    ret
entry:
  %and = and i32 %a, -65521 ; 0xffff000f
  %and1 = and i32 %b, 65520 ; 0x0000fff0
  %or = or i32 %and1, %and
  ret i32 %or
}

define i32 @test_or_and_and2(i32 %a, i32 %b) {
; CHECK-LABEL: test_or_and_and2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsr w8, w0, #4
; CHECK-NEXT:    bfi w1, w8, #4, #12
; CHECK-NEXT:    mov w0, w1
; CHECK-NEXT:    ret
entry:
  %and = and i32 %a, 65520   ; 0x0000fff0
  %and1 = and i32 %b, -65521 ; 0xffff000f
  %or = or i32 %and1, %and
  ret i32 %or
}

define i64 @test_or_and_and3(i64 %a, i64 %b) {
; CHECK-LABEL: test_or_and_and3:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsr x8, x1, #16
; CHECK-NEXT:    bfi x0, x8, #16, #32
; CHECK-NEXT:    ret
entry:
  %and = and i64 %a, -281474976645121 ; 0xffff00000000ffff
  %and1 = and i64 %b, 281474976645120 ; 0x0000ffffffff0000
  %or = or i64 %and1, %and
  ret i64 %or
}

; Don't convert 'and' with multiple uses.
define i32 @test_or_and_and4(i32 %a, i32 %b, i32* %ptr) {
; CHECK-LABEL: test_or_and_and4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    and w8, w0, #0xffff000f
; CHECK-NEXT:    and w9, w1, #0xfff0
; CHECK-NEXT:    orr w0, w9, w8
; CHECK-NEXT:    str w8, [x2]
; CHECK-NEXT:    ret
entry:
  %and = and i32 %a, -65521
  store i32 %and, i32* %ptr, align 4
  %and2 = and i32 %b, 65520
  %or = or i32 %and2, %and
  ret i32 %or
}

; Don't convert 'and' with multiple uses.
define i32 @test_or_and_and5(i32 %a, i32 %b, i32* %ptr) {
; CHECK-LABEL: test_or_and_and5:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    and w8, w1, #0xfff0
; CHECK-NEXT:    and w9, w0, #0xffff000f
; CHECK-NEXT:    orr w0, w8, w9
; CHECK-NEXT:    str w8, [x2]
; CHECK-NEXT:    ret
entry:
  %and = and i32 %b, 65520
  store i32 %and, i32* %ptr, align 4
  %and1 = and i32 %a, -65521
  %or = or i32 %and, %and1
  ret i32 %or
}

define i32 @test1(i32 %a) {
; CHECK-LABEL: test1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #5
; CHECK-NEXT:    bfxil w0, w8, #0, #4
; CHECK-NEXT:    ret
  %1 = and i32 %a, -16 ; 0xfffffff0
  %2 = or i32 %1, 5    ; 0x00000005
  ret i32 %2
}

define i32 @test2(i32 %a) {
; CHECK-LABEL: test2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #10
; CHECK-NEXT:    bfi w0, w8, #22, #4
; CHECK-NEXT:    ret
  %1 = and i32 %a, -62914561 ; 0xfc3fffff
  %2 = or i32 %1, 41943040   ; 0x06400000
  ret i32 %2
}

define i64 @test3(i64 %a) {
; CHECK-LABEL: test3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #5
; CHECK-NEXT:    bfxil x0, x8, #0, #3
; CHECK-NEXT:    ret
  %1 = and i64 %a, -8 ; 0xfffffffffffffff8
  %2 = or i64 %1, 5   ; 0x0000000000000005
  ret i64 %2
}

define i64 @test4(i64 %a) {
; CHECK-LABEL: test4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #9
; CHECK-NEXT:    bfi x0, x8, #1, #7
; CHECK-NEXT:    ret
  %1 = and i64 %a, -255 ; 0xffffffffffffff01
  %2 = or i64 %1,  18   ; 0x0000000000000012
  ret i64 %2
}

; Don't generate BFI/BFXIL if the immediate can be encoded in the ORR.
define i32 @test5(i32 %a) {
; CHECK-LABEL: test5:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0xfffffff0
; CHECK-NEXT:    orr w0, w8, #0x6
; CHECK-NEXT:    ret
  %1 = and i32 %a, 4294967280 ; 0xfffffff0
  %2 = or i32 %1, 6           ; 0x00000006
  ret i32 %2
}

; BFXIL will use the same constant as the ORR, so we don't care how the constant
; is materialized (it's an equal cost either way).
define i32 @test6(i32 %a) {
; CHECK-LABEL: test6:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #23250
; CHECK-NEXT:    movk w8, #11, lsl #16
; CHECK-NEXT:    bfxil w0, w8, #0, #20
; CHECK-NEXT:    ret
  %1 = and i32 %a, 4293918720 ; 0xfff00000
  %2 = or i32 %1, 744146      ; 0x000b5ad2
  ret i32 %2
}

; BFIs that require the same number of instruction to materialize the constant
; as the original ORR are okay.
define i32 @test7(i32 %a) {
; CHECK-LABEL: test7:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #44393
; CHECK-NEXT:    movk w8, #5, lsl #16
; CHECK-NEXT:    bfi w0, w8, #1, #19
; CHECK-NEXT:    ret
  %1 = and i32 %a, 4293918721 ; 0xfff00001
  %2 = or i32 %1, 744146      ; 0x000b5ad2
  ret i32 %2
}

; BFIs that require more instructions to materialize the constant as compared
; to the original ORR are not okay.  In this case we would be replacing the
; 'and' with a 'movk', which would decrease ILP while using the same number of
; instructions.
define i64 @test8(i64 %a) {
; CHECK-LABEL: test8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x9, #2035482624
; CHECK-NEXT:    and x8, x0, #0xff000000000000ff
; CHECK-NEXT:    movk x9, #36694, lsl #32
; CHECK-NEXT:    orr x0, x8, x9
; CHECK-NEXT:    ret
  %1 = and i64 %a, -72057594037927681 ; 0xff000000000000ff
  %2 = or i64 %1, 157601565442048     ; 0x00008f5679530000
  ret i64 %2
}

; This test exposed an issue with an overly aggressive assert.  The bit of code
; that is expected to catch this case is unable to deal with the trunc, which
; results in a failing check due to a mismatch between the BFI opcode and
; the expected value type of the OR.
define i32 @test9(i64 %b, i32 %e) {
; CHECK-LABEL: test9:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsr x0, x0, #12
; CHECK-NEXT:    lsr w8, w1, #23
; CHECK-NEXT:    bfi w0, w8, #23, #9
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %c = lshr i64 %b, 12
  %d = trunc i64 %c to i32
  %f = and i32 %d, 8388607
  %g = and i32 %e, -8388608
  %h = or i32 %g, %f
  ret i32 %h
}

define <2 x i32> @test_complex_type(<2 x i32>* %addr, i64 %in, i64* %bf ) {
; CHECK-LABEL: test_complex_type:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0], #8
; CHECK-NEXT:    orr x8, x0, x1, lsl #32
; CHECK-NEXT:    str x8, [x2]
; CHECK-NEXT:    ret
  %vec = load <2 x i32>, <2 x i32>* %addr

  %vec.next = getelementptr <2 x i32>, <2 x i32>* %addr, i32 1
  %lo = ptrtoint <2 x i32>* %vec.next to i64

  %hi = shl i64 %in, 32
  %both = or i64 %lo, %hi
  store i64 %both, i64* %bf

  ret <2 x i32> %vec
}

define i64 @test_truncated_shift(i64 %x, i64 %y) {
; CHECK-LABEL: test_truncated_shift:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    lsl w8, w1, #25
; CHECK-NEXT:    lsr x8, x8, #25
; CHECK-NEXT:    bfi x0, x8, #25, #5
; CHECK-NEXT:    ret
entry:
  %and = and i64 %x, -1040187393
  %shl4 = shl i64 %y, 25
  %and5 = and i64 %shl4, 1040187392
  %or = or i64 %and5, %and
  ret i64 %or
}
