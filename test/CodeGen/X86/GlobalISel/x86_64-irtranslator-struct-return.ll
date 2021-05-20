; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple=x86_64-linux-gnu -global-isel -stop-after=irtranslator < %s -o - | FileCheck %s --check-prefix=ALL

%struct.f1 = type { float }
%struct.d1 = type { double }
%struct.d2 = type { double, double }
%struct.i1 = type { i32 }
%struct.i2 = type { i32, i32 }
%struct.i3 = type { i32, i32, i32 }
%struct.i4 = type { i32, i32, i32, i32 }

define float @test_return_f1(float %f.coerce) {
  ; ALL-LABEL: name: test_return_f1
  ; ALL: bb.1.entry:
  ; ALL:   liveins: $xmm0
  ; ALL:   [[COPY:%[0-9]+]]:_(s32) = COPY $xmm0
  ; ALL:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; ALL:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0.retval
  ; ALL:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.1.f
  ; ALL:   G_STORE [[COPY]](s32), [[FRAME_INDEX1]](p0) :: (store (s32) into %ir.coerce.dive2)
  ; ALL:   G_MEMCPY [[FRAME_INDEX]](p0), [[FRAME_INDEX1]](p0), [[C]](s64), 0 :: (store (s8) into %ir.0, align 4), (load (s8) from %ir.1, align 4)
  ; ALL:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[FRAME_INDEX]](p0) :: (dereferenceable load (s32) from %ir.coerce.dive13)
  ; ALL:   $xmm0 = COPY [[LOAD]](s32)
  ; ALL:   RET 0, implicit $xmm0
entry:
  %retval = alloca %struct.f1, align 4
  %f = alloca %struct.f1, align 4
  %coerce.dive = getelementptr inbounds %struct.f1, %struct.f1* %f, i32 0, i32 0
  store float %f.coerce, float* %coerce.dive, align 4
  %0 = bitcast %struct.f1* %retval to i8*
  %1 = bitcast %struct.f1* %f to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %0, i8* align 4 %1, i64 4, i1 false)
  %coerce.dive1 = getelementptr inbounds %struct.f1, %struct.f1* %retval, i32 0, i32 0
  %2 = load float, float* %coerce.dive1, align 4
  ret float %2
}

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #1

define double @test_return_d1(double %d.coerce) {
  ; ALL-LABEL: name: test_return_d1
  ; ALL: bb.1.entry:
  ; ALL:   liveins: $xmm0
  ; ALL:   [[COPY:%[0-9]+]]:_(s64) = COPY $xmm0
  ; ALL:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; ALL:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0.retval
  ; ALL:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.1.d
  ; ALL:   G_STORE [[COPY]](s64), [[FRAME_INDEX1]](p0) :: (store (s64) into %ir.coerce.dive2)
  ; ALL:   G_MEMCPY [[FRAME_INDEX]](p0), [[FRAME_INDEX1]](p0), [[C]](s64), 0 :: (store (s8) into %ir.0, align 8), (load (s8) from %ir.1, align 8)
  ; ALL:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX]](p0) :: (dereferenceable load (s64) from %ir.coerce.dive13)
  ; ALL:   $xmm0 = COPY [[LOAD]](s64)
  ; ALL:   RET 0, implicit $xmm0
entry:
  %retval = alloca %struct.d1, align 8
  %d = alloca %struct.d1, align 8
  %coerce.dive = getelementptr inbounds %struct.d1, %struct.d1* %d, i32 0, i32 0
  store double %d.coerce, double* %coerce.dive, align 8
  %0 = bitcast %struct.d1* %retval to i8*
  %1 = bitcast %struct.d1* %d to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %0, i8* align 8 %1, i64 8, i1 false)
  %coerce.dive1 = getelementptr inbounds %struct.d1, %struct.d1* %retval, i32 0, i32 0
  %2 = load double, double* %coerce.dive1, align 8
  ret double %2
}

define { double, double } @test_return_d2(double %d.coerce0, double %d.coerce1) {
  ; ALL-LABEL: name: test_return_d2
  ; ALL: bb.1.entry:
  ; ALL:   liveins: $xmm0, $xmm1
  ; ALL:   [[COPY:%[0-9]+]]:_(s64) = COPY $xmm0
  ; ALL:   [[COPY1:%[0-9]+]]:_(s64) = COPY $xmm1
  ; ALL:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 16
  ; ALL:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0.retval
  ; ALL:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.1.d
  ; ALL:   G_STORE [[COPY]](s64), [[FRAME_INDEX1]](p0) :: (store (s64) into %ir.1)
  ; ALL:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; ALL:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[FRAME_INDEX1]], [[C1]](s64)
  ; ALL:   G_STORE [[COPY1]](s64), [[PTR_ADD]](p0) :: (store (s64) into %ir.2)
  ; ALL:   G_MEMCPY [[FRAME_INDEX]](p0), [[FRAME_INDEX1]](p0), [[C]](s64), 0 :: (store (s8) into %ir.3, align 8), (load (s8) from %ir.4, align 8)
  ; ALL:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX]](p0) :: (dereferenceable load (s64) from %ir.5)
  ; ALL:   [[PTR_ADD1:%[0-9]+]]:_(p0) = G_PTR_ADD [[FRAME_INDEX]], [[C1]](s64)
  ; ALL:   [[LOAD1:%[0-9]+]]:_(s64) = G_LOAD [[PTR_ADD1]](p0) :: (dereferenceable load (s64) from %ir.5 + 8)
  ; ALL:   $xmm0 = COPY [[LOAD]](s64)
  ; ALL:   $xmm1 = COPY [[LOAD1]](s64)
  ; ALL:   RET 0, implicit $xmm0, implicit $xmm1
entry:
  %retval = alloca %struct.d2, align 8
  %d = alloca %struct.d2, align 8
  %0 = bitcast %struct.d2* %d to { double, double }*
  %1 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 0
  store double %d.coerce0, double* %1, align 8
  %2 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 1
  store double %d.coerce1, double* %2, align 8
  %3 = bitcast %struct.d2* %retval to i8*
  %4 = bitcast %struct.d2* %d to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %3, i8* align 8 %4, i64 16, i1 false)
  %5 = bitcast %struct.d2* %retval to { double, double }*
  %6 = load { double, double }, { double, double }* %5, align 8
  ret { double, double } %6
}

define i32 @test_return_i1(i32 %i.coerce) {
  ; ALL-LABEL: name: test_return_i1
  ; ALL: bb.1.entry:
  ; ALL:   liveins: $edi
  ; ALL:   [[COPY:%[0-9]+]]:_(s32) = COPY $edi
  ; ALL:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 4
  ; ALL:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0.retval
  ; ALL:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.1.i
  ; ALL:   G_STORE [[COPY]](s32), [[FRAME_INDEX1]](p0) :: (store (s32) into %ir.coerce.dive2)
  ; ALL:   G_MEMCPY [[FRAME_INDEX]](p0), [[FRAME_INDEX1]](p0), [[C]](s64), 0 :: (store (s8) into %ir.0, align 4), (load (s8) from %ir.1, align 4)
  ; ALL:   [[LOAD:%[0-9]+]]:_(s32) = G_LOAD [[FRAME_INDEX]](p0) :: (dereferenceable load (s32) from %ir.coerce.dive13)
  ; ALL:   $eax = COPY [[LOAD]](s32)
  ; ALL:   RET 0, implicit $eax
entry:
  %retval = alloca %struct.i1, align 4
  %i = alloca %struct.i1, align 4
  %coerce.dive = getelementptr inbounds %struct.i1, %struct.i1* %i, i32 0, i32 0
  store i32 %i.coerce, i32* %coerce.dive, align 4
  %0 = bitcast %struct.i1* %retval to i8*
  %1 = bitcast %struct.i1* %i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %0, i8* align 4 %1, i64 4, i1 false)
  %coerce.dive1 = getelementptr inbounds %struct.i1, %struct.i1* %retval, i32 0, i32 0
  %2 = load i32, i32* %coerce.dive1, align 4
  ret i32 %2
}

define i64 @test_return_i2(i64 %i.coerce) {
  ; ALL-LABEL: name: test_return_i2
  ; ALL: bb.1.entry:
  ; ALL:   liveins: $rdi
  ; ALL:   [[COPY:%[0-9]+]]:_(s64) = COPY $rdi
  ; ALL:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; ALL:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0.retval
  ; ALL:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.1.i
  ; ALL:   G_STORE [[COPY]](s64), [[FRAME_INDEX1]](p0) :: (store (s64) into %ir.0, align 4)
  ; ALL:   G_MEMCPY [[FRAME_INDEX]](p0), [[FRAME_INDEX1]](p0), [[C]](s64), 0 :: (store (s8) into %ir.1, align 4), (load (s8) from %ir.2, align 4)
  ; ALL:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX]](p0) :: (dereferenceable load (s64) from %ir.3, align 4)
  ; ALL:   $rax = COPY [[LOAD]](s64)
  ; ALL:   RET 0, implicit $rax
entry:
  %retval = alloca %struct.i2, align 4
  %i = alloca %struct.i2, align 4
  %0 = bitcast %struct.i2* %i to i64*
  store i64 %i.coerce, i64* %0, align 4
  %1 = bitcast %struct.i2* %retval to i8*
  %2 = bitcast %struct.i2* %i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %1, i8* align 4 %2, i64 8, i1 false)
  %3 = bitcast %struct.i2* %retval to i64*
  %4 = load i64, i64* %3, align 4
  ret i64 %4
}

define { i64, i32 } @test_return_i3(i64 %i.coerce0, i32 %i.coerce1) {
  ; ALL-LABEL: name: test_return_i3
  ; ALL: bb.1.entry:
  ; ALL:   liveins: $esi, $rdi
  ; ALL:   [[COPY:%[0-9]+]]:_(s64) = COPY $rdi
  ; ALL:   [[COPY1:%[0-9]+]]:_(s32) = COPY $esi
  ; ALL:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 12
  ; ALL:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0.retval
  ; ALL:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.1.i
  ; ALL:   [[FRAME_INDEX2:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.2.coerce
  ; ALL:   [[FRAME_INDEX3:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.3.tmp
  ; ALL:   G_STORE [[COPY]](s64), [[FRAME_INDEX2]](p0) :: (store (s64) into %ir.0, align 4)
  ; ALL:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; ALL:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[FRAME_INDEX2]], [[C1]](s64)
  ; ALL:   G_STORE [[COPY1]](s32), [[PTR_ADD]](p0) :: (store (s32) into %ir.1)
  ; ALL:   G_MEMCPY [[FRAME_INDEX1]](p0), [[FRAME_INDEX2]](p0), [[C]](s64), 0 :: (store (s8) into %ir.2, align 4), (load (s8) from %ir.3, align 4)
  ; ALL:   G_MEMCPY [[FRAME_INDEX]](p0), [[FRAME_INDEX1]](p0), [[C]](s64), 0 :: (store (s8) into %ir.4, align 4), (load (s8) from %ir.5, align 4)
  ; ALL:   G_MEMCPY [[FRAME_INDEX3]](p0), [[FRAME_INDEX]](p0), [[C]](s64), 0 :: (store (s8) into %ir.6, align 8), (load (s8) from %ir.7, align 4)
  ; ALL:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX3]](p0) :: (dereferenceable load (s64) from %ir.tmp)
  ; ALL:   [[PTR_ADD1:%[0-9]+]]:_(p0) = G_PTR_ADD [[FRAME_INDEX3]], [[C1]](s64)
  ; ALL:   [[LOAD1:%[0-9]+]]:_(s32) = G_LOAD [[PTR_ADD1]](p0) :: (dereferenceable load (s32) from %ir.tmp + 8, align 8)
  ; ALL:   $rax = COPY [[LOAD]](s64)
  ; ALL:   $edx = COPY [[LOAD1]](s32)
  ; ALL:   RET 0, implicit $rax, implicit $edx
entry:
  %retval = alloca %struct.i3, align 4
  %i = alloca %struct.i3, align 4
  %coerce = alloca { i64, i32 }, align 4
  %tmp = alloca { i64, i32 }, align 8
  %0 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %coerce, i32 0, i32 0
  store i64 %i.coerce0, i64* %0, align 4
  %1 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %coerce, i32 0, i32 1
  store i32 %i.coerce1, i32* %1, align 4
  %2 = bitcast %struct.i3* %i to i8*
  %3 = bitcast { i64, i32 }* %coerce to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %2, i8* align 4 %3, i64 12, i1 false)
  %4 = bitcast %struct.i3* %retval to i8*
  %5 = bitcast %struct.i3* %i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %4, i8* align 4 %5, i64 12, i1 false)
  %6 = bitcast { i64, i32 }* %tmp to i8*
  %7 = bitcast %struct.i3* %retval to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %6, i8* align 4 %7, i64 12, i1 false)
  %8 = load { i64, i32 }, { i64, i32 }* %tmp, align 8
  ret { i64, i32 } %8
}

define { i64, i64 } @test_return_i4(i64 %i.coerce0, i64 %i.coerce1) {
  ; ALL-LABEL: name: test_return_i4
  ; ALL: bb.1.entry:
  ; ALL:   liveins: $rdi, $rsi
  ; ALL:   [[COPY:%[0-9]+]]:_(s64) = COPY $rdi
  ; ALL:   [[COPY1:%[0-9]+]]:_(s64) = COPY $rsi
  ; ALL:   [[C:%[0-9]+]]:_(s64) = G_CONSTANT i64 16
  ; ALL:   [[FRAME_INDEX:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.0.retval
  ; ALL:   [[FRAME_INDEX1:%[0-9]+]]:_(p0) = G_FRAME_INDEX %stack.1.i
  ; ALL:   G_STORE [[COPY]](s64), [[FRAME_INDEX1]](p0) :: (store (s64) into %ir.1, align 4)
  ; ALL:   [[C1:%[0-9]+]]:_(s64) = G_CONSTANT i64 8
  ; ALL:   [[PTR_ADD:%[0-9]+]]:_(p0) = G_PTR_ADD [[FRAME_INDEX1]], [[C1]](s64)
  ; ALL:   G_STORE [[COPY1]](s64), [[PTR_ADD]](p0) :: (store (s64) into %ir.2, align 4)
  ; ALL:   G_MEMCPY [[FRAME_INDEX]](p0), [[FRAME_INDEX1]](p0), [[C]](s64), 0 :: (store (s8) into %ir.3, align 4), (load (s8) from %ir.4, align 4)
  ; ALL:   [[LOAD:%[0-9]+]]:_(s64) = G_LOAD [[FRAME_INDEX]](p0) :: (dereferenceable load (s64) from %ir.5, align 4)
  ; ALL:   [[PTR_ADD1:%[0-9]+]]:_(p0) = G_PTR_ADD [[FRAME_INDEX]], [[C1]](s64)
  ; ALL:   [[LOAD1:%[0-9]+]]:_(s64) = G_LOAD [[PTR_ADD1]](p0) :: (dereferenceable load (s64) from %ir.5 + 8, align 4)
  ; ALL:   $rax = COPY [[LOAD]](s64)
  ; ALL:   $rdx = COPY [[LOAD1]](s64)
  ; ALL:   RET 0, implicit $rax, implicit $rdx
entry:
  %retval = alloca %struct.i4, align 4
  %i = alloca %struct.i4, align 4
  %0 = bitcast %struct.i4* %i to { i64, i64 }*
  %1 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %0, i32 0, i32 0
  store i64 %i.coerce0, i64* %1, align 4
  %2 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %0, i32 0, i32 1
  store i64 %i.coerce1, i64* %2, align 4
  %3 = bitcast %struct.i4* %retval to i8*
  %4 = bitcast %struct.i4* %i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %3, i8* align 4 %4, i64 16, i1 false)
  %5 = bitcast %struct.i4* %retval to { i64, i64 }*
  %6 = load { i64, i64 }, { i64, i64 }* %5, align 4
  ret { i64, i64 } %6
}
