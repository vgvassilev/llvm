; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple aarch64-none-linux-gnu -mattr=+dotprod    < %s | FileCheck %s

declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>)

define i32 @test_udot_v8i8(i8* nocapture readonly %a, i8* nocapture readonly %b) {
; CHECK-LABEL: test_udot_v8i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    dup v2.2s, wzr
; CHECK-NEXT:    udot v2.2s, v1.8b, v0.8b
; CHECK-NEXT:    addp v0.2s, v2.2s, v2.2s
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
entry:
  %0 = bitcast i8* %a to <8 x i8>*
  %1 = load <8 x i8>, <8 x i8>* %0
  %2 = zext <8 x i8> %1 to <8 x i32>
  %3 = bitcast i8* %b to <8 x i8>*
  %4 = load <8 x i8>, <8 x i8>* %3
  %5 = zext <8 x i8> %4 to <8 x i32>
  %6 = mul nuw nsw <8 x i32> %5, %2
  %7 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %6)
  ret i32 %7
}

define i32 @test_udot_v8i8_nomla(i8* nocapture readonly %a1) {
; CHECK-LABEL: test_udot_v8i8_nomla:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    ushll v1.4s, v0.4h, #0
; CHECK-NEXT:    uaddw2 v0.4s, v1.4s, v0.8h
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %0 = bitcast i8* %a1 to <8 x i8>*
  %1 = load <8 x i8>, <8 x i8>* %0
  %2 = zext <8 x i8> %1 to <8 x i32>
  %3 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %2)
  ret i32 %3
}

define i32 @test_sdot_v8i8(i8* nocapture readonly %a, i8* nocapture readonly %b) {
; CHECK-LABEL: test_sdot_v8i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    dup v2.2s, wzr
; CHECK-NEXT:    sdot v2.2s, v1.8b, v0.8b
; CHECK-NEXT:    addp v0.2s, v2.2s, v2.2s
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
entry:
  %0 = bitcast i8* %a to <8 x i8>*
  %1 = load <8 x i8>, <8 x i8>* %0
  %2 = sext <8 x i8> %1 to <8 x i32>
  %3 = bitcast i8* %b to <8 x i8>*
  %4 = load <8 x i8>, <8 x i8>* %3
  %5 = sext <8 x i8> %4 to <8 x i32>
  %6 = mul nsw <8 x i32> %5, %2
  %7 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %6)
  ret i32 %7
}

define i32 @test_sdot_v8i8_nomla(i8* nocapture readonly %a1) {
; CHECK-LABEL: test_sdot_v8i8_nomla:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    sshll v1.4s, v0.4h, #0
; CHECK-NEXT:    saddw2 v0.4s, v1.4s, v0.8h
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %0 = bitcast i8* %a1 to <8 x i8>*
  %1 = load <8 x i8>, <8 x i8>* %0
  %2 = sext <8 x i8> %1 to <8 x i32>
  %3 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %2)
  ret i32 %3
}


define i32 @test_udot_v16i8(i8* nocapture readonly %a, i8* nocapture readonly %b, i32 %sum) {
; CHECK-LABEL: test_udot_v16i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr q1, [x1]
; CHECK-NEXT:    dup v2.4s, wzr
; CHECK-NEXT:    udot v2.4s, v1.16b, v0.16b
; CHECK-NEXT:    addv s0, v2.4s
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    add w0, w8, w2
; CHECK-NEXT:    ret
entry:
  %0 = bitcast i8* %a to <16 x i8>*
  %1 = load <16 x i8>, <16 x i8>* %0
  %2 = zext <16 x i8> %1 to <16 x i32>
  %3 = bitcast i8* %b to <16 x i8>*
  %4 = load <16 x i8>, <16 x i8>* %3
  %5 = zext <16 x i8> %4 to <16 x i32>
  %6 = mul nuw nsw <16 x i32> %5, %2
  %7 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %6)
  %op.extra = add i32 %7, %sum
  ret i32 %op.extra
}

define i32 @test_udot_v16i8_nomla(i8* nocapture readonly %a1) {
; CHECK-LABEL: test_udot_v16i8_nomla:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    movi v1.16b, #1
; CHECK-NEXT:    movi v2.2d, #0000000000000000
; CHECK-NEXT:    udot v2.4s, v1.16b, v0.16b
; CHECK-NEXT:    addv s0, v2.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %0 = bitcast i8* %a1 to <16 x i8>*
  %1 = load <16 x i8>, <16 x i8>* %0
  %2 = zext <16 x i8> %1 to <16 x i32>
  %3 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %2)
  ret i32 %3
}

define i32 @test_sdot_v16i8(i8* nocapture readonly %a, i8* nocapture readonly %b, i32 %sum) {
; CHECK-LABEL: test_sdot_v16i8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr q1, [x1]
; CHECK-NEXT:    dup v2.4s, wzr
; CHECK-NEXT:    sdot v2.4s, v1.16b, v0.16b
; CHECK-NEXT:    addv s0, v2.4s
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    add w0, w8, w2
; CHECK-NEXT:    ret
entry:
  %0 = bitcast i8* %a to <16 x i8>*
  %1 = load <16 x i8>, <16 x i8>* %0
  %2 = sext <16 x i8> %1 to <16 x i32>
  %3 = bitcast i8* %b to <16 x i8>*
  %4 = load <16 x i8>, <16 x i8>* %3
  %5 = sext <16 x i8> %4 to <16 x i32>
  %6 = mul nsw <16 x i32> %5, %2
  %7 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %6)
  %op.extra = add nsw i32 %7, %sum
  ret i32 %op.extra
}

define i32 @test_sdot_v16i8_nomla(i8* nocapture readonly %a1) {
; CHECK-LABEL: test_sdot_v16i8_nomla:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    movi v1.16b, #1
; CHECK-NEXT:    movi v2.2d, #0000000000000000
; CHECK-NEXT:    sdot v2.4s, v1.16b, v0.16b
; CHECK-NEXT:    addv s0, v2.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %0 = bitcast i8* %a1 to <16 x i8>*
  %1 = load <16 x i8>, <16 x i8>* %0
  %2 = sext <16 x i8> %1 to <16 x i32>
  %3 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %2)
  ret i32 %3
}


define i32 @test_udot_v8i8_double(<8 x i8> %a, <8 x i8> %b, <8 x i8> %c, <8 x i8> %d) {
; CHECK-LABEL: test_udot_v8i8_double:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-NEXT:    ushll v2.8h, v2.8b, #0
; CHECK-NEXT:    ushll v3.8h, v3.8b, #0
; CHECK-NEXT:    ext v4.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    ext v5.16b, v1.16b, v1.16b, #8
; CHECK-NEXT:    umull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ext v1.16b, v2.16b, v2.16b, #8
; CHECK-NEXT:    umull v2.4s, v2.4h, v3.4h
; CHECK-NEXT:    ext v3.16b, v3.16b, v3.16b, #8
; CHECK-NEXT:    umlal v0.4s, v4.4h, v5.4h
; CHECK-NEXT:    umlal v2.4s, v1.4h, v3.4h
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %az = zext <8 x i8> %a to <8 x i32>
  %bz = zext <8 x i8> %b to <8 x i32>
  %m1 = mul nuw nsw <8 x i32> %az, %bz
  %r1 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %m1)
  %cz = zext <8 x i8> %c to <8 x i32>
  %dz = zext <8 x i8> %d to <8 x i32>
  %m2 = mul nuw nsw <8 x i32> %cz, %dz
  %r2 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %m2)
  %x = add i32 %r1, %r2
  ret i32 %x
}

define i32 @test_udot_v8i8_double_nomla(<8 x i8> %a, <8 x i8> %b, <8 x i8> %c, <8 x i8> %d) {
; CHECK-LABEL: test_udot_v8i8_double_nomla:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    ushll v1.8h, v2.8b, #0
; CHECK-NEXT:    ushll v2.4s, v0.4h, #0
; CHECK-NEXT:    ushll v3.4s, v1.4h, #0
; CHECK-NEXT:    uaddw2 v0.4s, v2.4s, v0.8h
; CHECK-NEXT:    uaddw2 v1.4s, v3.4s, v1.8h
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %az = zext <8 x i8> %a to <8 x i32>
  %r1 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %az)
  %cz = zext <8 x i8> %c to <8 x i32>
  %r2 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %cz)
  %x = add i32 %r1, %r2
  ret i32 %x
}

define i32 @test_udot_v16i8_double(<16 x i8> %a, <16 x i8> %b, <16 x i8> %c, <16 x i8> %d) {
; CHECK-LABEL: test_udot_v16i8_double:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ushll2 v4.8h, v0.16b, #0
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    ushll2 v5.8h, v1.16b, #0
; CHECK-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-NEXT:    ext v6.16b, v4.16b, v4.16b, #8
; CHECK-NEXT:    ext v7.16b, v5.16b, v5.16b, #8
; CHECK-NEXT:    umull2 v16.4s, v0.8h, v1.8h
; CHECK-NEXT:    umlal v16.4s, v6.4h, v7.4h
; CHECK-NEXT:    ushll2 v6.8h, v2.16b, #0
; CHECK-NEXT:    ushll v2.8h, v2.8b, #0
; CHECK-NEXT:    ushll2 v7.8h, v3.16b, #0
; CHECK-NEXT:    ushll v3.8h, v3.8b, #0
; CHECK-NEXT:    umull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ext v1.16b, v6.16b, v6.16b, #8
; CHECK-NEXT:    umlal v0.4s, v4.4h, v5.4h
; CHECK-NEXT:    ext v4.16b, v7.16b, v7.16b, #8
; CHECK-NEXT:    umull v5.4s, v2.4h, v3.4h
; CHECK-NEXT:    umull2 v2.4s, v2.8h, v3.8h
; CHECK-NEXT:    umlal v2.4s, v1.4h, v4.4h
; CHECK-NEXT:    umlal v5.4s, v6.4h, v7.4h
; CHECK-NEXT:    add v0.4s, v0.4s, v16.4s
; CHECK-NEXT:    add v1.4s, v5.4s, v2.4s
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %az = zext <16 x i8> %a to <16 x i32>
  %bz = zext <16 x i8> %b to <16 x i32>
  %m1 = mul nuw nsw <16 x i32> %az, %bz
  %r1 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %m1)
  %cz = zext <16 x i8> %c to <16 x i32>
  %dz = zext <16 x i8> %d to <16 x i32>
  %m2 = mul nuw nsw <16 x i32> %cz, %dz
  %r2 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %m2)
  %x = add i32 %r1, %r2
  ret i32 %x
}

define i32 @test_udot_v16i8_double_nomla(<16 x i8> %a, <16 x i8> %b, <16 x i8> %c, <16 x i8> %d) {
; CHECK-LABEL: test_udot_v16i8_double_nomla:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v1.16b, #1
; CHECK-NEXT:    movi v3.2d, #0000000000000000
; CHECK-NEXT:    udot v3.4s, v1.16b, v2.16b
; CHECK-NEXT:    udot v3.4s, v1.16b, v0.16b
; CHECK-NEXT:    addv s0, v3.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %az = zext <16 x i8> %a to <16 x i32>
  %r1 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %az)
  %cz = zext <16 x i8> %c to <16 x i32>
  %r2 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %cz)
  %x = add i32 %r1, %r2
  ret i32 %x
}

define i32 @test_sdot_v8i8_double(<8 x i8> %a, <8 x i8> %b, <8 x i8> %c, <8 x i8> %d) {
; CHECK-LABEL: test_sdot_v8i8_double:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    sshll v1.8h, v1.8b, #0
; CHECK-NEXT:    sshll v2.8h, v2.8b, #0
; CHECK-NEXT:    sshll v3.8h, v3.8b, #0
; CHECK-NEXT:    ext v4.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    ext v5.16b, v1.16b, v1.16b, #8
; CHECK-NEXT:    smull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ext v1.16b, v2.16b, v2.16b, #8
; CHECK-NEXT:    smull v2.4s, v2.4h, v3.4h
; CHECK-NEXT:    ext v3.16b, v3.16b, v3.16b, #8
; CHECK-NEXT:    smlal v0.4s, v4.4h, v5.4h
; CHECK-NEXT:    smlal v2.4s, v1.4h, v3.4h
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %az = sext <8 x i8> %a to <8 x i32>
  %bz = sext <8 x i8> %b to <8 x i32>
  %m1 = mul nuw nsw <8 x i32> %az, %bz
  %r1 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %m1)
  %cz = sext <8 x i8> %c to <8 x i32>
  %dz = sext <8 x i8> %d to <8 x i32>
  %m2 = mul nuw nsw <8 x i32> %cz, %dz
  %r2 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %m2)
  %x = add i32 %r1, %r2
  ret i32 %x
}

define i32 @test_sdot_v8i8_double_nomla(<8 x i8> %a, <8 x i8> %b, <8 x i8> %c, <8 x i8> %d) {
; CHECK-LABEL: test_sdot_v8i8_double_nomla:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    sshll v1.8h, v2.8b, #0
; CHECK-NEXT:    sshll v2.4s, v0.4h, #0
; CHECK-NEXT:    sshll v3.4s, v1.4h, #0
; CHECK-NEXT:    saddw2 v0.4s, v2.4s, v0.8h
; CHECK-NEXT:    saddw2 v1.4s, v3.4s, v1.8h
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %az = sext <8 x i8> %a to <8 x i32>
  %r1 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %az)
  %cz = sext <8 x i8> %c to <8 x i32>
  %r2 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %cz)
  %x = add i32 %r1, %r2
  ret i32 %x
}

define i32 @test_sdot_v16i8_double(<16 x i8> %a, <16 x i8> %b, <16 x i8> %c, <16 x i8> %d) {
; CHECK-LABEL: test_sdot_v16i8_double:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    sshll2 v4.8h, v0.16b, #0
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    sshll2 v5.8h, v1.16b, #0
; CHECK-NEXT:    sshll v1.8h, v1.8b, #0
; CHECK-NEXT:    ext v6.16b, v4.16b, v4.16b, #8
; CHECK-NEXT:    ext v7.16b, v5.16b, v5.16b, #8
; CHECK-NEXT:    smull2 v16.4s, v0.8h, v1.8h
; CHECK-NEXT:    smlal v16.4s, v6.4h, v7.4h
; CHECK-NEXT:    sshll2 v6.8h, v2.16b, #0
; CHECK-NEXT:    sshll v2.8h, v2.8b, #0
; CHECK-NEXT:    sshll2 v7.8h, v3.16b, #0
; CHECK-NEXT:    sshll v3.8h, v3.8b, #0
; CHECK-NEXT:    smull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ext v1.16b, v6.16b, v6.16b, #8
; CHECK-NEXT:    smlal v0.4s, v4.4h, v5.4h
; CHECK-NEXT:    ext v4.16b, v7.16b, v7.16b, #8
; CHECK-NEXT:    smull v5.4s, v2.4h, v3.4h
; CHECK-NEXT:    smull2 v2.4s, v2.8h, v3.8h
; CHECK-NEXT:    smlal v2.4s, v1.4h, v4.4h
; CHECK-NEXT:    smlal v5.4s, v6.4h, v7.4h
; CHECK-NEXT:    add v0.4s, v0.4s, v16.4s
; CHECK-NEXT:    add v1.4s, v5.4s, v2.4s
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %az = sext <16 x i8> %a to <16 x i32>
  %bz = sext <16 x i8> %b to <16 x i32>
  %m1 = mul nuw nsw <16 x i32> %az, %bz
  %r1 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %m1)
  %cz = sext <16 x i8> %c to <16 x i32>
  %dz = sext <16 x i8> %d to <16 x i32>
  %m2 = mul nuw nsw <16 x i32> %cz, %dz
  %r2 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %m2)
  %x = add i32 %r1, %r2
  ret i32 %x
}

define i32 @test_sdot_v16i8_double_nomla(<16 x i8> %a, <16 x i8> %b, <16 x i8> %c, <16 x i8> %d) {
; CHECK-LABEL: test_sdot_v16i8_double_nomla:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v1.16b, #1
; CHECK-NEXT:    movi v3.2d, #0000000000000000
; CHECK-NEXT:    sdot v3.4s, v1.16b, v2.16b
; CHECK-NEXT:    sdot v3.4s, v1.16b, v0.16b
; CHECK-NEXT:    addv s0, v3.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %az = sext <16 x i8> %a to <16 x i32>
  %r1 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %az)
  %cz = sext <16 x i8> %c to <16 x i32>
  %r2 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %cz)
  %x = add i32 %r1, %r2
  ret i32 %x
}
