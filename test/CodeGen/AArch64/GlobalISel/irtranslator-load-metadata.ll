; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=aarch64-- -mcpu=falkor -O0 -aarch64-enable-atomic-cfg-tidy=0 -stop-after=irtranslator -global-isel -verify-machineinstrs %s -o - | FileCheck %s

define i32 @load_invariant(i32* %ptr) {
  ; CHECK-LABEL: name: load_invariant
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $x0
  ; CHECK:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[COPY]](p0) :: (invariant load 4 from %ir.ptr)
  ; CHECK:   $w0 = COPY [[LOAD]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  %load = load i32, i32* %ptr, align 4, !invariant.load !0
  ret i32 %load
}

define i32 @load_volatile_invariant(i32* %ptr) {
  ; CHECK-LABEL: name: load_volatile_invariant
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $x0
  ; CHECK:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[COPY]](p0) :: (volatile invariant load 4 from %ir.ptr)
  ; CHECK:   $w0 = COPY [[LOAD]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  %load = load volatile i32, i32* %ptr, align 4, !invariant.load !0
  ret i32 %load
}

define i32 @load_dereferenceable(i32* dereferenceable(4) %ptr) {
  ; CHECK-LABEL: name: load_dereferenceable
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $x0
  ; CHECK:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[COPY]](p0) :: (dereferenceable load 4 from %ir.ptr)
  ; CHECK:   $w0 = COPY [[LOAD]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  %load = load i32, i32* %ptr, align 4
  ret i32 %load
}

define i32 @load_dereferenceable_invariant(i32* dereferenceable(4) %ptr) {
  ; CHECK-LABEL: name: load_dereferenceable_invariant
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $x0
  ; CHECK:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[COPY]](p0) :: (dereferenceable invariant load 4 from %ir.ptr)
  ; CHECK:   $w0 = COPY [[LOAD]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  %load = load i32, i32* %ptr, align 4, !invariant.load !0
  ret i32 %load
}

define i32 @load_nontemporal(i32* %ptr) {
  ; CHECK-LABEL: name: load_nontemporal
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $x0
  ; CHECK:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[COPY]](p0) :: (non-temporal load 4 from %ir.ptr)
  ; CHECK:   $w0 = COPY [[LOAD]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  %load = load i32, i32* %ptr, align 4, !nontemporal !0
  ret i32 %load
}

define i32 @load_falkor_strided_access(i32* %ptr) {
  ; CHECK-LABEL: name: load_falkor_strided_access
  ; CHECK: bb.1 (%ir-block.0):
  ; CHECK:   liveins: $x0
  ; CHECK:   [[COPY:%[0-9]+]]:_(p0) = COPY $x0
  ; CHECK:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[COPY]](p0) :: ("aarch64-strided-access" load 4 from %ir.ptr)
  ; CHECK:   $w0 = COPY [[LOAD]](s32)
  ; CHECK:   RET_ReallyLR implicit $w0
  %load = load i32, i32* %ptr, align 4, !falkor.strided.access !0
  ret i32 %load
}

!0 = !{}
