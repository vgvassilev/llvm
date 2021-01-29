; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=aarch64 -global-isel -stop-after=irtranslator -verify-machineinstrs -o - %s | FileCheck %s

; Verify that we generate G_ASSERT_ZEXT for zeroext parameters.

define i8 @zeroext_param_i8(i8 zeroext %x) {
  ; CHECK-LABEL: name: zeroext_param_i8
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $w0
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK:   [[ASSERT_ZEXT:%[0-9]+]]:_(s32) = G_ASSERT_ZEXT [[COPY]], 8
  ; CHECK:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[ASSERT_ZEXT]](s32)
  ; CHECK:   [[ANYEXT:%[0-9]+]]:_(s32) = G_ANYEXT [[TRUNC]](s8)
  ; CHECK:   $w0 = COPY [[ANYEXT]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  ret i8 %x
}

define i8 @no_zeroext_param(i8 %x) {
  ; CHECK-LABEL: name: no_zeroext_param
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $w0
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[COPY]](s32)
  ; CHECK:   [[ANYEXT:%[0-9]+]]:_(s32) = G_ANYEXT [[TRUNC]](s8)
  ; CHECK:   $w0 = COPY [[ANYEXT]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  ret i8 %x
}

; Don't need G_ASSERT_ZEXT here. The sizes match.
define i32 @zeroext_param_i32(i32 zeroext %x) {
  ; CHECK-LABEL: name: zeroext_param_i32
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $w0
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK:   $w0 = COPY [[COPY]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  ret i32 %x
}

; Zeroext param is passed on the stack. We should still get a G_ASSERT_ZEXT.
define i32 @zeroext_param_stack(i64 %a, i64 %b, i64 %c, i64 %d, i64 %e, i64 %f,
                                i64 %g, i64 %h, i64 %i, i1 zeroext %j) {
  ; CHECK-LABEL: name: zeroext_param_stack
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $x0, $x1, $x2, $x3, $x4, $x5, $x6, $x7
  ; CHECK:   [[COPY:%[0-9]+]]:_(s64) = COPY $x0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x2
  ; CHECK:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK:   [[COPY5:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK:   [[COPY6:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK:   [[COPY7:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %fixed-stack.1
  ; CHECK:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX]](p0) :: (invariant load 8 from %fixed-stack.1, align 16)
  ; CHECK:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %fixed-stack.0
  ; CHECK:   [[LOAD1:%[0-9]+]]:_(s32) = G_LOAD [[FRAME_INDEX1]](p0) :: (invariant load 1 from %fixed-stack.0, align 8)
  ; CHECK:   [[ASSERT_ZEXT:%[0-9]+]]:_(s32) = G_ASSERT_ZEXT [[LOAD1]], 1
  ; CHECK:   [[TRUNC:%[0-9]+]]:_(s1) = G_TRUNC [[ASSERT_ZEXT]](s32)
  ; CHECK:   [[ZEXT:%[0-9]+]]:_(s32) = G_ZEXT [[TRUNC]](s1)
  ; CHECK:   $w0 = COPY [[ZEXT]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  %v = zext i1 %j to i32
  ret i32 %v
}

; The zeroext parameter is a s32, so there's no extension required.
define i32 @dont_need_assert_zext_stack(i64 %a, i64 %b, i64 %c, i64 %d, i64 %e,
                                        i64 %f, i64 %g, i64 %h, i64 %i,
                                        i32 zeroext %j) {
  ; CHECK-LABEL: name: dont_need_assert_zext_stack
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $x0, $x1, $x2, $x3, $x4, $x5, $x6, $x7
  ; CHECK:   [[COPY:%[0-9]+]]:_(s64) = COPY $x0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x2
  ; CHECK:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK:   [[COPY5:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK:   [[COPY6:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK:   [[COPY7:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %fixed-stack.1
  ; CHECK:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX]](p0) :: (invariant load 8 from %fixed-stack.1, align 16)
  ; CHECK:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %fixed-stack.0
  ; CHECK:   [[LOAD1:%[0-9]+]]:_(s32) = G_LOAD [[FRAME_INDEX1]](p0) :: (invariant load 4 from %fixed-stack.0, align 8)
  ; CHECK:   $w0 = COPY [[LOAD1]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  ret i32 %j
}

; s8 requires extension to s32, so we should get a G_ASSERT_ZEXT here.
define i8 @s8_assert_zext_stack(i64 %a, i64 %b, i64 %c, i64 %d, i64 %e,
                                        i64 %f, i64 %g, i64 %h, i64 %i,
                                        i8 zeroext %j) {
  ; CHECK-LABEL: name: s8_assert_zext_stack
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $x0, $x1, $x2, $x3, $x4, $x5, $x6, $x7
  ; CHECK:   [[COPY:%[0-9]+]]:_(s64) = COPY $x0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s64) = COPY $x1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s64) = COPY $x2
  ; CHECK:   [[COPY3:%[0-9]+]]:_(s64) = COPY $x3
  ; CHECK:   [[COPY4:%[0-9]+]]:_(s64) = COPY $x4
  ; CHECK:   [[COPY5:%[0-9]+]]:_(s64) = COPY $x5
  ; CHECK:   [[COPY6:%[0-9]+]]:_(s64) = COPY $x6
  ; CHECK:   [[COPY7:%[0-9]+]]:_(s64) = COPY $x7
  ; CHECK:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %fixed-stack.1
  ; CHECK:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX]](p0) :: (invariant load 8 from %fixed-stack.1, align 16)
  ; CHECK:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %fixed-stack.0
  ; CHECK:   [[LOAD1:%[0-9]+]]:_(s32) = G_LOAD [[FRAME_INDEX1]](p0) :: (invariant load 1 from %fixed-stack.0, align 8)
  ; CHECK:   [[ASSERT_ZEXT:%[0-9]+]]:_(s32) = G_ASSERT_ZEXT [[LOAD1]], 8
  ; CHECK:   [[TRUNC:%[0-9]+]]:_(s8) = G_TRUNC [[ASSERT_ZEXT]](s32)
  ; CHECK:   [[ANYEXT:%[0-9]+]]:_(s32) = G_ANYEXT [[TRUNC]](s8)
  ; CHECK:   $w0 = COPY [[ANYEXT]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  ret i8 %j
}
