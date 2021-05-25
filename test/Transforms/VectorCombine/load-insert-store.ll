; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -vector-combine -data-layout=e < %s | FileCheck %s
; RUN: opt -S -vector-combine -data-layout=E < %s | FileCheck %s

define void @insert_store(<16 x i8>* %q, i8 zeroext %s) {
; CHECK-LABEL: @insert_store(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds <16 x i8>, <16 x i8>* [[Q:%.*]], i32 0, i32 3
; CHECK-NEXT:    store i8 [[S:%.*]], i8* [[TMP0]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <16 x i8>, <16 x i8>* %q
  %vecins = insertelement <16 x i8> %0, i8 %s, i32 3
  store <16 x i8> %vecins, <16 x i8>* %q, align 16
  ret void
}

define void @insert_store_i16_align1(<8 x i16>* %q, i16 zeroext %s) {
; CHECK-LABEL: @insert_store_i16_align1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds <8 x i16>, <8 x i16>* [[Q:%.*]], i32 0, i32 3
; CHECK-NEXT:    store i16 [[S:%.*]], i16* [[TMP0]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <8 x i16>, <8 x i16>* %q
  %vecins = insertelement <8 x i16> %0, i16 %s, i32 3
  store <8 x i16> %vecins, <8 x i16>* %q, align 1
  ret void
}

; To verify case when index is out of bounds
define void @insert_store_outofbounds(<8 x i16>* %q, i16 zeroext %s) {
; CHECK-LABEL: @insert_store_outofbounds(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <8 x i16>, <8 x i16>* [[Q:%.*]], align 16
; CHECK-NEXT:    [[VECINS:%.*]] = insertelement <8 x i16> [[TMP0]], i16 [[S:%.*]], i32 9
; CHECK-NEXT:    store <8 x i16> [[VECINS]], <8 x i16>* [[Q]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <8 x i16>, <8 x i16>* %q
  %vecins = insertelement <8 x i16> %0, i16 %s, i32 9
  store <8 x i16> %vecins, <8 x i16>* %q
  ret void
}

define void @insert_store_vscale(<vscale x 8 x i16>* %q, i16 zeroext %s) {
; CHECK-LABEL: @insert_store_vscale(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <vscale x 8 x i16>, <vscale x 8 x i16>* [[Q:%.*]], align 16
; CHECK-NEXT:    [[VECINS:%.*]] = insertelement <vscale x 8 x i16> [[TMP0]], i16 [[S:%.*]], i32 3
; CHECK-NEXT:    store <vscale x 8 x i16> [[VECINS]], <vscale x 8 x i16>* [[Q]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <vscale x 8 x i16>, <vscale x 8 x i16>* %q
  %vecins = insertelement <vscale x 8 x i16> %0, i16 %s, i32 3
  store <vscale x 8 x i16> %vecins, <vscale x 8 x i16>* %q
  ret void
}

define void @insert_store_v9i4(<9 x i4>* %q, i4 zeroext %s) {
; CHECK-LABEL: @insert_store_v9i4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <9 x i4>, <9 x i4>* [[Q:%.*]], align 16
; CHECK-NEXT:    [[VECINS:%.*]] = insertelement <9 x i4> [[TMP0]], i4 [[S:%.*]], i32 3
; CHECK-NEXT:    store <9 x i4> [[VECINS]], <9 x i4>* [[Q]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <9 x i4>, <9 x i4>* %q
  %vecins = insertelement <9 x i4> %0, i4 %s, i32 3
  store <9 x i4> %vecins, <9 x i4>* %q, align 1
  ret void
}

define void @insert_store_v4i27(<4 x i27>* %q, i27 zeroext %s) {
; CHECK-LABEL: @insert_store_v4i27(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <4 x i27>, <4 x i27>* [[Q:%.*]], align 16
; CHECK-NEXT:    [[VECINS:%.*]] = insertelement <4 x i27> [[TMP0]], i27 [[S:%.*]], i32 3
; CHECK-NEXT:    store <4 x i27> [[VECINS]], <4 x i27>* [[Q]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <4 x i27>, <4 x i27>* %q
  %vecins = insertelement <4 x i27> %0, i27 %s, i32 3
  store <4 x i27> %vecins, <4 x i27>* %q, align 1
  ret void
}

define void @insert_store_blk_differ(<8 x i16>* %q, i16 zeroext %s) {
; CHECK-LABEL: @insert_store_blk_differ(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <8 x i16>, <8 x i16>* [[Q:%.*]], align 16
; CHECK-NEXT:    br label [[CONT:%.*]]
; CHECK:       cont:
; CHECK-NEXT:    [[VECINS:%.*]] = insertelement <8 x i16> [[TMP0]], i16 [[S:%.*]], i32 3
; CHECK-NEXT:    store <8 x i16> [[VECINS]], <8 x i16>* [[Q]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <8 x i16>, <8 x i16>* %q
  br label %cont
cont:
  %vecins = insertelement <8 x i16> %0, i16 %s, i32 3
  store <8 x i16> %vecins, <8 x i16>* %q
  ret void
}

define void @insert_store_nonconst(<16 x i8>* %q, i8 zeroext %s, i32 %idx) {
; CHECK-LABEL: @insert_store_nonconst(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <16 x i8>, <16 x i8>* [[Q:%.*]], align 16
; CHECK-NEXT:    [[VECINS:%.*]] = insertelement <16 x i8> [[TMP0]], i8 [[S:%.*]], i32 [[IDX:%.*]]
; CHECK-NEXT:    store <16 x i8> [[VECINS]], <16 x i8>* [[Q]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <16 x i8>, <16 x i8>* %q
  %vecins = insertelement <16 x i8> %0, i8 %s, i32 %idx
  store <16 x i8> %vecins, <16 x i8>* %q
  ret void
}

define void @insert_store_nonconst_index_known_valid_by_assume(<16 x i8>* %q, i8 zeroext %s, i32 %idx) {
; CHECK-LABEL: @insert_store_nonconst_index_known_valid_by_assume(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[IDX:%.*]], 4
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds <16 x i8>, <16 x i8>* [[Q:%.*]], i32 0, i32 [[IDX]]
; CHECK-NEXT:    store i8 [[S:%.*]], i8* [[TMP0]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp ult i32 %idx, 4
  call void @llvm.assume(i1 %cmp)
  %0 = load <16 x i8>, <16 x i8>* %q
  %vecins = insertelement <16 x i8> %0, i8 %s, i32 %idx
  store <16 x i8> %vecins, <16 x i8>* %q
  ret void
}

declare void @maythrow() readnone

define void @insert_store_nonconst_index_not_known_valid_by_assume_after_load(<16 x i8>* %q, i8 zeroext %s, i32 %idx) {
; CHECK-LABEL: @insert_store_nonconst_index_not_known_valid_by_assume_after_load(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[IDX:%.*]], 4
; CHECK-NEXT:    [[TMP0:%.*]] = load <16 x i8>, <16 x i8>* [[Q:%.*]], align 16
; CHECK-NEXT:    call void @maythrow()
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    [[VECINS:%.*]] = insertelement <16 x i8> [[TMP0]], i8 [[S:%.*]], i32 [[IDX]]
; CHECK-NEXT:    store <16 x i8> [[VECINS]], <16 x i8>* [[Q]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp ult i32 %idx, 4
  %0 = load <16 x i8>, <16 x i8>* %q
  call void @maythrow()
  call void @llvm.assume(i1 %cmp)
  %vecins = insertelement <16 x i8> %0, i8 %s, i32 %idx
  store <16 x i8> %vecins, <16 x i8>* %q
  ret void
}

define void @insert_store_nonconst_index_not_known_valid_by_assume(<16 x i8>* %q, i8 zeroext %s, i32 %idx) {
; CHECK-LABEL: @insert_store_nonconst_index_not_known_valid_by_assume(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[IDX:%.*]], 17
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    [[TMP0:%.*]] = load <16 x i8>, <16 x i8>* [[Q:%.*]], align 16
; CHECK-NEXT:    [[VECINS:%.*]] = insertelement <16 x i8> [[TMP0]], i8 [[S:%.*]], i32 [[IDX]]
; CHECK-NEXT:    store <16 x i8> [[VECINS]], <16 x i8>* [[Q]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp ult i32 %idx, 17
  call void @llvm.assume(i1 %cmp)
  %0 = load <16 x i8>, <16 x i8>* %q
  %vecins = insertelement <16 x i8> %0, i8 %s, i32 %idx
  store <16 x i8> %vecins, <16 x i8>* %q
  ret void
}

declare void @llvm.assume(i1)

define void @insert_store_nonconst_index_known_valid_by_and(<16 x i8>* %q, i8 zeroext %s, i32 %idx) {
; CHECK-LABEL: @insert_store_nonconst_index_known_valid_by_and(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[IDX_CLAMPED:%.*]] = and i32 [[IDX:%.*]], 7
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds <16 x i8>, <16 x i8>* [[Q:%.*]], i32 0, i32 [[IDX_CLAMPED]]
; CHECK-NEXT:    store i8 [[S:%.*]], i8* [[TMP0]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <16 x i8>, <16 x i8>* %q
  %idx.clamped = and i32 %idx, 7
  %vecins = insertelement <16 x i8> %0, i8 %s, i32 %idx.clamped
  store <16 x i8> %vecins, <16 x i8>* %q
  ret void
}

define void @insert_store_nonconst_index_not_known_valid_by_and(<16 x i8>* %q, i8 zeroext %s, i32 %idx) {
; CHECK-LABEL: @insert_store_nonconst_index_not_known_valid_by_and(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <16 x i8>, <16 x i8>* [[Q:%.*]], align 16
; CHECK-NEXT:    [[IDX_CLAMPED:%.*]] = and i32 [[IDX:%.*]], 16
; CHECK-NEXT:    [[VECINS:%.*]] = insertelement <16 x i8> [[TMP0]], i8 [[S:%.*]], i32 [[IDX_CLAMPED]]
; CHECK-NEXT:    store <16 x i8> [[VECINS]], <16 x i8>* [[Q]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <16 x i8>, <16 x i8>* %q
  %idx.clamped = and i32 %idx, 16
  %vecins = insertelement <16 x i8> %0, i8 %s, i32 %idx.clamped
  store <16 x i8> %vecins, <16 x i8>* %q
  ret void
}

define void @insert_store_nonconst_index_known_valid_by_urem(<16 x i8>* %q, i8 zeroext %s, i32 %idx) {
; CHECK-LABEL: @insert_store_nonconst_index_known_valid_by_urem(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[IDX_CLAMPED:%.*]] = urem i32 [[IDX:%.*]], 16
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds <16 x i8>, <16 x i8>* [[Q:%.*]], i32 0, i32 [[IDX_CLAMPED]]
; CHECK-NEXT:    store i8 [[S:%.*]], i8* [[TMP0]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <16 x i8>, <16 x i8>* %q
  %idx.clamped = urem i32 %idx, 16
  %vecins = insertelement <16 x i8> %0, i8 %s, i32 %idx.clamped
  store <16 x i8> %vecins, <16 x i8>* %q
  ret void
}

define void @insert_store_nonconst_index_not_known_valid_by_urem(<16 x i8>* %q, i8 zeroext %s, i32 %idx) {
; CHECK-LABEL: @insert_store_nonconst_index_not_known_valid_by_urem(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <16 x i8>, <16 x i8>* [[Q:%.*]], align 16
; CHECK-NEXT:    [[IDX_CLAMPED:%.*]] = urem i32 [[IDX:%.*]], 17
; CHECK-NEXT:    [[VECINS:%.*]] = insertelement <16 x i8> [[TMP0]], i8 [[S:%.*]], i32 [[IDX_CLAMPED]]
; CHECK-NEXT:    store <16 x i8> [[VECINS]], <16 x i8>* [[Q]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <16 x i8>, <16 x i8>* %q
  %idx.clamped = urem i32 %idx, 17
  %vecins = insertelement <16 x i8> %0, i8 %s, i32 %idx.clamped
  store <16 x i8> %vecins, <16 x i8>* %q
  ret void
}

define void @insert_store_ptr_strip(<16 x i8>* %q, i8 zeroext %s) {
; CHECK-LABEL: @insert_store_ptr_strip(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADDR0:%.*]] = bitcast <16 x i8>* [[Q:%.*]] to <2 x i64>*
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds <16 x i8>, <16 x i8>* [[Q]], i32 0, i32 3
; CHECK-NEXT:    store i8 [[S:%.*]], i8* [[TMP0]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <16 x i8>, <16 x i8>* %q
  %vecins = insertelement <16 x i8> %0, i8 %s, i32 3
  %addr0 = bitcast <16 x i8>* %q to <2 x i64>*
  %addr1 = getelementptr <2 x i64>, <2 x i64>* %addr0, i64 0
  %addr2 = bitcast <2 x i64>* %addr1 to <16 x i8>*
  store <16 x i8> %vecins, <16 x i8>* %addr2
  ret void
}

define void @volatile_update(<16 x i8>* %q, <16 x i8>* %p, i8 zeroext %s) {
; CHECK-LABEL: @volatile_update(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <16 x i8>, <16 x i8>* [[Q:%.*]], align 16
; CHECK-NEXT:    [[VECINS0:%.*]] = insertelement <16 x i8> [[TMP0]], i8 [[S:%.*]], i32 3
; CHECK-NEXT:    store volatile <16 x i8> [[VECINS0]], <16 x i8>* [[Q]], align 16
; CHECK-NEXT:    [[TMP1:%.*]] = load volatile <16 x i8>, <16 x i8>* [[P:%.*]], align 16
; CHECK-NEXT:    [[VECINS1:%.*]] = insertelement <16 x i8> [[TMP1]], i8 [[S]], i32 1
; CHECK-NEXT:    store <16 x i8> [[VECINS1]], <16 x i8>* [[P]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %0 = load <16 x i8>, <16 x i8>* %q
  %vecins0 = insertelement <16 x i8> %0, i8 %s, i32 3
  store volatile <16 x i8> %vecins0, <16 x i8>* %q

  %1 = load volatile <16 x i8>, <16 x i8>* %p
  %vecins1 = insertelement <16 x i8> %1, i8 %s, i32 1
  store <16 x i8> %vecins1, <16 x i8>* %p
  ret void
}

define void @insert_store_addr_differ(<16 x i8>* %p, <16 x i8>* %q, i8 %s) {
; CHECK-LABEL: @insert_store_addr_differ(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LD:%.*]] = load <16 x i8>, <16 x i8>* [[P:%.*]], align 16
; CHECK-NEXT:    [[INS:%.*]] = insertelement <16 x i8> [[LD]], i8 [[S:%.*]], i32 3
; CHECK-NEXT:    store <16 x i8> [[INS]], <16 x i8>* [[Q:%.*]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %ld = load <16 x i8>, <16 x i8>* %p
  %ins = insertelement <16 x i8> %ld, i8 %s, i32 3
  store <16 x i8> %ins, <16 x i8>* %q
  ret void
}

; We can't transform if any instr could modify memory in between.
define void @insert_store_mem_modify(<16 x i8>* %p, <16 x i8>* %q, <16 x i8>* noalias %r, i8 %s, i32 %m) {
; CHECK-LABEL: @insert_store_mem_modify(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LD:%.*]] = load <16 x i8>, <16 x i8>* [[P:%.*]], align 16
; CHECK-NEXT:    store <16 x i8> zeroinitializer, <16 x i8>* [[Q:%.*]], align 16
; CHECK-NEXT:    [[INS:%.*]] = insertelement <16 x i8> [[LD]], i8 [[S:%.*]], i32 3
; CHECK-NEXT:    store <16 x i8> [[INS]], <16 x i8>* [[P]], align 16
; CHECK-NEXT:    store <16 x i8> zeroinitializer, <16 x i8>* [[R:%.*]], align 16
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds <16 x i8>, <16 x i8>* [[Q]], i32 0, i32 7
; CHECK-NEXT:    store i8 [[S]], i8* [[TMP0]], align 1
; CHECK-NEXT:    [[PTR0:%.*]] = bitcast <16 x i8>* [[P]] to <4 x i32>*
; CHECK-NEXT:    [[LD3:%.*]] = load <4 x i32>, <4 x i32>* [[PTR0]], align 16
; CHECK-NEXT:    store <16 x i8> zeroinitializer, <16 x i8>* [[P]], align 16
; CHECK-NEXT:    [[INS3:%.*]] = insertelement <4 x i32> [[LD3]], i32 [[M:%.*]], i32 0
; CHECK-NEXT:    store <4 x i32> [[INS3]], <4 x i32>* [[PTR0]], align 16
; CHECK-NEXT:    ret void
;
entry:
  ; p may alias q
  %ld = load <16 x i8>, <16 x i8>* %p
  store <16 x i8> zeroinitializer, <16 x i8>* %q
  %ins = insertelement <16 x i8> %ld, i8 %s, i32 3
  store <16 x i8> %ins, <16 x i8>* %p

  ; p never aliases r
  %ld2 = load <16 x i8>, <16 x i8>* %q
  store <16 x i8> zeroinitializer, <16 x i8>* %r
  %ins2 = insertelement <16 x i8> %ld2, i8 %s, i32 7
  store <16 x i8> %ins2, <16 x i8>* %q

  ; p must alias ptr0
  %ptr0 = bitcast <16 x i8>* %p to <4 x i32>*
  %ld3 = load <4 x i32>, <4 x i32>* %ptr0
  store <16 x i8> zeroinitializer, <16 x i8>* %p
  %ins3 = insertelement <4 x i32> %ld3, i32 %m, i32 0
  store <4 x i32> %ins3, <4 x i32>* %ptr0

  ret void
}

; Check cases when calls may modify memory
define void @insert_store_with_call(<16 x i8>* %p, <16 x i8>* %q, i8 %s) {
; CHECK-LABEL: @insert_store_with_call(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LD:%.*]] = load <16 x i8>, <16 x i8>* [[P:%.*]], align 16
; CHECK-NEXT:    call void @maywrite(<16 x i8>* [[P]])
; CHECK-NEXT:    [[INS:%.*]] = insertelement <16 x i8> [[LD]], i8 [[S:%.*]], i32 3
; CHECK-NEXT:    store <16 x i8> [[INS]], <16 x i8>* [[P]], align 16
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    call void @nowrite(<16 x i8>* [[P]])
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds <16 x i8>, <16 x i8>* [[P]], i32 0, i32 7
; CHECK-NEXT:    store i8 [[S]], i8* [[TMP0]], align 1
; CHECK-NEXT:    ret void
;
entry:
  %ld = load <16 x i8>, <16 x i8>* %p
  call void @maywrite(<16 x i8>* %p)
  %ins = insertelement <16 x i8> %ld, i8 %s, i32 3
  store <16 x i8> %ins, <16 x i8>* %p
  call void @foo()  ; Barrier
  %ld2 = load <16 x i8>, <16 x i8>* %p
  call void @nowrite(<16 x i8>* %p)
  %ins2 = insertelement <16 x i8> %ld2, i8 %s, i32 7
  store <16 x i8> %ins2, <16 x i8>* %p
  ret void
}

declare void @foo()
declare void @maywrite(<16 x i8>*)
declare void @nowrite(<16 x i8>*) readonly

; To test if number of instructions in-between exceeds the limit (default 30),
; the combine will quit.
define i32 @insert_store_maximum_scan_instrs(i32 %arg, i16* %arg1, <16 x i8>* %arg2, i8 zeroext %arg3) {
; CHECK-LABEL: @insert_store_maximum_scan_instrs(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[I:%.*]] = or i32 [[ARG:%.*]], 1
; CHECK-NEXT:    [[I4:%.*]] = load <16 x i8>, <16 x i8>* [[ARG2:%.*]], align 16
; CHECK-NEXT:    [[I5:%.*]] = tail call i32 @bar(i32 [[I]], i1 true)
; CHECK-NEXT:    [[I6:%.*]] = shl i32 [[ARG]], [[I5]]
; CHECK-NEXT:    [[I7:%.*]] = lshr i32 [[I6]], 26
; CHECK-NEXT:    [[I8:%.*]] = trunc i32 [[I7]] to i8
; CHECK-NEXT:    [[I9:%.*]] = and i8 [[I8]], 31
; CHECK-NEXT:    [[I10:%.*]] = lshr i32 [[I6]], 11
; CHECK-NEXT:    [[I11:%.*]] = and i32 [[I10]], 32767
; CHECK-NEXT:    [[I12:%.*]] = zext i8 [[I9]] to i64
; CHECK-NEXT:    [[I13:%.*]] = getelementptr inbounds i16, i16* [[ARG1:%.*]], i64 [[I12]]
; CHECK-NEXT:    [[I14:%.*]] = load i16, i16* [[I13]], align 2
; CHECK-NEXT:    [[I15:%.*]] = zext i16 [[I14]] to i32
; CHECK-NEXT:    [[I16:%.*]] = add nuw nsw i8 [[I9]], 1
; CHECK-NEXT:    [[I17:%.*]] = zext i8 [[I16]] to i64
; CHECK-NEXT:    [[I18:%.*]] = getelementptr inbounds i16, i16* [[ARG1]], i64 [[I17]]
; CHECK-NEXT:    [[I19:%.*]] = load i16, i16* [[I18]], align 2
; CHECK-NEXT:    [[I20:%.*]] = zext i16 [[I19]] to i32
; CHECK-NEXT:    [[I21:%.*]] = sub nsw i32 [[I20]], [[I15]]
; CHECK-NEXT:    [[I22:%.*]] = mul nsw i32 [[I11]], [[I21]]
; CHECK-NEXT:    [[I23:%.*]] = ashr i32 [[I22]], 15
; CHECK-NEXT:    [[I24:%.*]] = shl nuw nsw i32 [[I5]], 15
; CHECK-NEXT:    [[I25:%.*]] = xor i32 [[I24]], 1015808
; CHECK-NEXT:    [[I26:%.*]] = add nuw nsw i32 [[I25]], [[I15]]
; CHECK-NEXT:    [[I27:%.*]] = add nsw i32 [[I26]], [[I23]]
; CHECK-NEXT:    [[I28:%.*]] = sitofp i32 [[ARG]] to double
; CHECK-NEXT:    [[I29:%.*]] = tail call double @llvm.log2.f64(double [[I28]])
; CHECK-NEXT:    [[I30:%.*]] = fptosi double [[I29]] to i32
; CHECK-NEXT:    [[I31:%.*]] = shl nsw i32 [[I30]], 15
; CHECK-NEXT:    [[I32:%.*]] = or i32 [[I31]], 4
; CHECK-NEXT:    [[I33:%.*]] = icmp eq i32 [[I27]], [[I32]]
; CHECK-NEXT:    [[I34:%.*]] = select i1 [[I33]], i32 [[ARG]], i32 [[I31]]
; CHECK-NEXT:    [[I35:%.*]] = lshr i32 [[I34]], 1
; CHECK-NEXT:    [[I36:%.*]] = insertelement <16 x i8> [[I4]], i8 [[ARG3:%.*]], i32 3
; CHECK-NEXT:    store <16 x i8> [[I36]], <16 x i8>* [[ARG2]], align 16
; CHECK-NEXT:    ret i32 [[I35]]
;
bb:
  %i = or i32 %arg, 1
  %i4 = load <16 x i8>, <16 x i8>* %arg2, align 16
  %i5 = tail call i32 @bar(i32 %i, i1 true)
  %i6 = shl i32 %arg, %i5
  %i7 = lshr i32 %i6, 26
  %i8 = trunc i32 %i7 to i8
  %i9 = and i8 %i8, 31
  %i10 = lshr i32 %i6, 11
  %i11 = and i32 %i10, 32767
  %i12 = zext i8 %i9 to i64
  %i13 = getelementptr inbounds i16, i16* %arg1, i64 %i12
  %i14 = load i16, i16* %i13, align 2
  %i15 = zext i16 %i14 to i32
  %i16 = add nuw nsw i8 %i9, 1
  %i17 = zext i8 %i16 to i64
  %i18 = getelementptr inbounds i16, i16* %arg1, i64 %i17
  %i19 = load i16, i16* %i18, align 2
  %i20 = zext i16 %i19 to i32
  %i21 = sub nsw i32 %i20, %i15
  %i22 = mul nsw i32 %i11, %i21
  %i23 = ashr i32 %i22, 15
  %i24 = shl nuw nsw i32 %i5, 15
  %i25 = xor i32 %i24, 1015808
  %i26 = add nuw nsw i32 %i25, %i15
  %i27 = add nsw i32 %i26, %i23
  %i28 = sitofp i32 %arg to double
  %i29 = tail call double @llvm.log2.f64(double %i28)
  %i30 = fptosi double %i29 to i32
  %i31 = shl nsw i32 %i30, 15
  %i32 = or i32 %i31, 4
  %i33 = icmp eq i32 %i27, %i32
  %i34 = select i1 %i33, i32 %arg, i32 %i31
  %i35 = lshr i32 %i34, 1
  %i36 = insertelement <16 x i8> %i4, i8 %arg3, i32 3
  store <16 x i8> %i36, <16 x i8>* %arg2, align 16
  ret i32 %i35
}

declare i32 @bar(i32, i1) readonly
declare double @llvm.log2.f64(double)
