; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -amdgpu-lower-intrinsics %s | FileCheck -check-prefix=OPT %s

declare void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* nocapture, i8 addrspace(1)* nocapture readonly, i64, i1) #1
declare void @llvm.memcpy.p1i8.p3i8.i32(i8 addrspace(1)* nocapture, i8 addrspace(3)* nocapture readonly, i32, i1) #1

declare void @llvm.memmove.p1i8.p1i8.i64(i8 addrspace(1)* nocapture, i8 addrspace(1)* nocapture readonly, i64, i1) #1
declare void @llvm.memset.p1i8.i64(i8 addrspace(1)* nocapture, i8, i64, i1) #1

; Test the upper bound for sizes to leave
define amdgpu_kernel void @max_size_small_static_memcpy_caller0(i8 addrspace(1)* %dst, i8 addrspace(1)* %src) #0 {
; OPT-LABEL: @max_size_small_static_memcpy_caller0(
; OPT-NEXT:    call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* [[DST:%.*]], i8 addrspace(1)* [[SRC:%.*]], i64 1024, i1 false)
; OPT-NEXT:    ret void
;
  call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %dst, i8 addrspace(1)* %src, i64 1024, i1 false)
  ret void
}

; Smallest static size which will be expanded
define amdgpu_kernel void @min_size_large_static_memcpy_caller0(i8 addrspace(1)* %dst, i8 addrspace(1)* %src) #0 {
; OPT-LABEL: @min_size_large_static_memcpy_caller0(
; OPT-NEXT:    br label [[LOAD_STORE_LOOP:%.*]]
; OPT:       load-store-loop:
; OPT-NEXT:    [[LOOP_INDEX:%.*]] = phi i64 [ 0, [[TMP0:%.*]] ], [ [[TMP4:%.*]], [[LOAD_STORE_LOOP]] ]
; OPT-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[SRC:%.*]], i64 [[LOOP_INDEX]]
; OPT-NEXT:    [[TMP2:%.*]] = load i8, i8 addrspace(1)* [[TMP1]]
; OPT-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[DST:%.*]], i64 [[LOOP_INDEX]]
; OPT-NEXT:    store i8 [[TMP2]], i8 addrspace(1)* [[TMP3]]
; OPT-NEXT:    [[TMP4]] = add i64 [[LOOP_INDEX]], 1
; OPT-NEXT:    [[TMP5:%.*]] = icmp ult i64 [[TMP4]], 1025
; OPT-NEXT:    br i1 [[TMP5]], label [[LOAD_STORE_LOOP]], label [[MEMCPY_SPLIT:%.*]]
; OPT:       memcpy-split:
; OPT-NEXT:    ret void
;
  call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %dst, i8 addrspace(1)* %src, i64 1025, i1 false)
  ret void
}

define amdgpu_kernel void @max_size_small_static_memmove_caller0(i8 addrspace(1)* %dst, i8 addrspace(1)* %src) #0 {
; OPT-LABEL: @max_size_small_static_memmove_caller0(
; OPT-NEXT:    call void @llvm.memmove.p1i8.p1i8.i64(i8 addrspace(1)* [[DST:%.*]], i8 addrspace(1)* [[SRC:%.*]], i64 1024, i1 false)
; OPT-NEXT:    ret void
;
  call void @llvm.memmove.p1i8.p1i8.i64(i8 addrspace(1)* %dst, i8 addrspace(1)* %src, i64 1024, i1 false)
  ret void
}

define amdgpu_kernel void @min_size_large_static_memmove_caller0(i8 addrspace(1)* %dst, i8 addrspace(1)* %src) #0 {
; OPT-LABEL: @min_size_large_static_memmove_caller0(
; OPT-NEXT:    [[COMPARE_SRC_DST:%.*]] = icmp ult i8 addrspace(1)* [[SRC:%.*]], [[DST:%.*]]
; OPT-NEXT:    [[COMPARE_N_TO_0:%.*]] = icmp eq i64 1025, 0
; OPT-NEXT:    br i1 [[COMPARE_SRC_DST]], label [[COPY_BACKWARDS:%.*]], label [[COPY_FORWARD:%.*]]
; OPT:       copy_backwards:
; OPT-NEXT:    br i1 [[COMPARE_N_TO_0]], label [[MEMMOVE_DONE:%.*]], label [[COPY_BACKWARDS_LOOP:%.*]]
; OPT:       copy_backwards_loop:
; OPT-NEXT:    [[TMP1:%.*]] = phi i64 [ [[INDEX_PTR:%.*]], [[COPY_BACKWARDS_LOOP]] ], [ 1025, [[COPY_BACKWARDS]] ]
; OPT-NEXT:    [[INDEX_PTR]] = sub i64 [[TMP1]], 1
; OPT-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[SRC]], i64 [[INDEX_PTR]]
; OPT-NEXT:    [[ELEMENT:%.*]] = load i8, i8 addrspace(1)* [[TMP2]]
; OPT-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[DST]], i64 [[INDEX_PTR]]
; OPT-NEXT:    store i8 [[ELEMENT]], i8 addrspace(1)* [[TMP3]]
; OPT-NEXT:    [[TMP4:%.*]] = icmp eq i64 [[INDEX_PTR]], 0
; OPT-NEXT:    br i1 [[TMP4]], label [[MEMMOVE_DONE]], label [[COPY_BACKWARDS_LOOP]]
; OPT:       copy_forward:
; OPT-NEXT:    br i1 [[COMPARE_N_TO_0]], label [[MEMMOVE_DONE]], label [[COPY_FORWARD_LOOP:%.*]]
; OPT:       copy_forward_loop:
; OPT-NEXT:    [[INDEX_PTR1:%.*]] = phi i64 [ [[INDEX_INCREMENT:%.*]], [[COPY_FORWARD_LOOP]] ], [ 0, [[COPY_FORWARD]] ]
; OPT-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[SRC]], i64 [[INDEX_PTR1]]
; OPT-NEXT:    [[ELEMENT2:%.*]] = load i8, i8 addrspace(1)* [[TMP5]]
; OPT-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[DST]], i64 [[INDEX_PTR1]]
; OPT-NEXT:    store i8 [[ELEMENT2]], i8 addrspace(1)* [[TMP6]]
; OPT-NEXT:    [[INDEX_INCREMENT]] = add i64 [[INDEX_PTR1]], 1
; OPT-NEXT:    [[TMP7:%.*]] = icmp eq i64 [[INDEX_INCREMENT]], 1025
; OPT-NEXT:    br i1 [[TMP7]], label [[MEMMOVE_DONE]], label [[COPY_FORWARD_LOOP]]
; OPT:       memmove_done:
; OPT-NEXT:    ret void
;
  call void @llvm.memmove.p1i8.p1i8.i64(i8 addrspace(1)* %dst, i8 addrspace(1)* %src, i64 1025, i1 false)
  ret void
}

define amdgpu_kernel void @max_size_small_static_memset_caller0(i8 addrspace(1)* %dst, i8 %val) #0 {
; OPT-LABEL: @max_size_small_static_memset_caller0(
; OPT-NEXT:    call void @llvm.memset.p1i8.i64(i8 addrspace(1)* [[DST:%.*]], i8 [[VAL:%.*]], i64 1024, i1 false)
; OPT-NEXT:    ret void
;
  call void @llvm.memset.p1i8.i64(i8 addrspace(1)* %dst, i8 %val, i64 1024, i1 false)
  ret void
}

define amdgpu_kernel void @min_size_large_static_memset_caller0(i8 addrspace(1)* %dst, i8 %val) #0 {
; OPT-LABEL: @min_size_large_static_memset_caller0(
; OPT-NEXT:    br i1 false, label [[SPLIT:%.*]], label [[LOADSTORELOOP:%.*]]
; OPT:       loadstoreloop:
; OPT-NEXT:    [[TMP1:%.*]] = phi i64 [ 0, [[TMP0:%.*]] ], [ [[TMP3:%.*]], [[LOADSTORELOOP]] ]
; OPT-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[DST:%.*]], i64 [[TMP1]]
; OPT-NEXT:    store i8 [[VAL:%.*]], i8 addrspace(1)* [[TMP2]]
; OPT-NEXT:    [[TMP3]] = add i64 [[TMP1]], 1
; OPT-NEXT:    [[TMP4:%.*]] = icmp ult i64 [[TMP3]], 1025
; OPT-NEXT:    br i1 [[TMP4]], label [[LOADSTORELOOP]], label [[SPLIT]]
; OPT:       split:
; OPT-NEXT:    ret void
;
  call void @llvm.memset.p1i8.i64(i8 addrspace(1)* %dst, i8 %val, i64 1025, i1 false)
  ret void
}

define amdgpu_kernel void @variable_memcpy_caller0(i8 addrspace(1)* %dst, i8 addrspace(1)* %src, i64 %n) #0 {
; OPT-LABEL: @variable_memcpy_caller0(
; OPT-NEXT:    [[TMP1:%.*]] = icmp ne i64 [[N:%.*]], 0
; OPT-NEXT:    br i1 [[TMP1]], label [[LOOP_MEMCPY_EXPANSION:%.*]], label [[POST_LOOP_MEMCPY_EXPANSION:%.*]]
; OPT:       loop-memcpy-expansion:
; OPT-NEXT:    [[LOOP_INDEX:%.*]] = phi i64 [ 0, [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[LOOP_MEMCPY_EXPANSION]] ]
; OPT-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[SRC:%.*]], i64 [[LOOP_INDEX]]
; OPT-NEXT:    [[TMP3:%.*]] = load i8, i8 addrspace(1)* [[TMP2]]
; OPT-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[DST:%.*]], i64 [[LOOP_INDEX]]
; OPT-NEXT:    store i8 [[TMP3]], i8 addrspace(1)* [[TMP4]]
; OPT-NEXT:    [[TMP5]] = add i64 [[LOOP_INDEX]], 1
; OPT-NEXT:    [[TMP6:%.*]] = icmp ult i64 [[TMP5]], [[N]]
; OPT-NEXT:    br i1 [[TMP6]], label [[LOOP_MEMCPY_EXPANSION]], label [[POST_LOOP_MEMCPY_EXPANSION]]
; OPT:       post-loop-memcpy-expansion:
; OPT-NEXT:    ret void
;
  call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %dst, i8 addrspace(1)* %src, i64 %n, i1 false)
  ret void
}

define amdgpu_kernel void @variable_memcpy_caller1(i8 addrspace(1)* %dst, i8 addrspace(1)* %src, i64 %n) #0 {
; OPT-LABEL: @variable_memcpy_caller1(
; OPT-NEXT:    [[TMP1:%.*]] = icmp ne i64 [[N:%.*]], 0
; OPT-NEXT:    br i1 [[TMP1]], label [[LOOP_MEMCPY_EXPANSION:%.*]], label [[POST_LOOP_MEMCPY_EXPANSION:%.*]]
; OPT:       loop-memcpy-expansion:
; OPT-NEXT:    [[LOOP_INDEX:%.*]] = phi i64 [ 0, [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[LOOP_MEMCPY_EXPANSION]] ]
; OPT-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[SRC:%.*]], i64 [[LOOP_INDEX]]
; OPT-NEXT:    [[TMP3:%.*]] = load i8, i8 addrspace(1)* [[TMP2]]
; OPT-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[DST:%.*]], i64 [[LOOP_INDEX]]
; OPT-NEXT:    store i8 [[TMP3]], i8 addrspace(1)* [[TMP4]]
; OPT-NEXT:    [[TMP5]] = add i64 [[LOOP_INDEX]], 1
; OPT-NEXT:    [[TMP6:%.*]] = icmp ult i64 [[TMP5]], [[N]]
; OPT-NEXT:    br i1 [[TMP6]], label [[LOOP_MEMCPY_EXPANSION]], label [[POST_LOOP_MEMCPY_EXPANSION]]
; OPT:       post-loop-memcpy-expansion:
; OPT-NEXT:    ret void
;
  call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %dst, i8 addrspace(1)* %src, i64 %n, i1 false)
  ret void
}

define amdgpu_kernel void @memcpy_multi_use_one_function(i8 addrspace(1)* %dst0, i8 addrspace(1)* %dst1, i8 addrspace(1)* %src, i64 %n, i64 %m) #0 {
; OPT-LABEL: @memcpy_multi_use_one_function(
; OPT-NEXT:    [[TMP1:%.*]] = icmp ne i64 [[N:%.*]], 0
; OPT-NEXT:    br i1 [[TMP1]], label [[LOOP_MEMCPY_EXPANSION2:%.*]], label [[POST_LOOP_MEMCPY_EXPANSION1:%.*]]
; OPT:       loop-memcpy-expansion2:
; OPT-NEXT:    [[LOOP_INDEX3:%.*]] = phi i64 [ 0, [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[LOOP_MEMCPY_EXPANSION2]] ]
; OPT-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[SRC:%.*]], i64 [[LOOP_INDEX3]]
; OPT-NEXT:    [[TMP3:%.*]] = load i8, i8 addrspace(1)* [[TMP2]]
; OPT-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[DST0:%.*]], i64 [[LOOP_INDEX3]]
; OPT-NEXT:    store i8 [[TMP3]], i8 addrspace(1)* [[TMP4]]
; OPT-NEXT:    [[TMP5]] = add i64 [[LOOP_INDEX3]], 1
; OPT-NEXT:    [[TMP6:%.*]] = icmp ult i64 [[TMP5]], [[N]]
; OPT-NEXT:    br i1 [[TMP6]], label [[LOOP_MEMCPY_EXPANSION2]], label [[POST_LOOP_MEMCPY_EXPANSION1]]
; OPT:       post-loop-memcpy-expansion1:
; OPT-NEXT:    [[TMP7:%.*]] = icmp ne i64 [[M:%.*]], 0
; OPT-NEXT:    br i1 [[TMP7]], label [[LOOP_MEMCPY_EXPANSION:%.*]], label [[POST_LOOP_MEMCPY_EXPANSION:%.*]]
; OPT:       loop-memcpy-expansion:
; OPT-NEXT:    [[LOOP_INDEX:%.*]] = phi i64 [ 0, [[POST_LOOP_MEMCPY_EXPANSION1]] ], [ [[TMP11:%.*]], [[LOOP_MEMCPY_EXPANSION]] ]
; OPT-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[SRC]], i64 [[LOOP_INDEX]]
; OPT-NEXT:    [[TMP9:%.*]] = load i8, i8 addrspace(1)* [[TMP8]]
; OPT-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[DST1:%.*]], i64 [[LOOP_INDEX]]
; OPT-NEXT:    store i8 [[TMP9]], i8 addrspace(1)* [[TMP10]]
; OPT-NEXT:    [[TMP11]] = add i64 [[LOOP_INDEX]], 1
; OPT-NEXT:    [[TMP12:%.*]] = icmp ult i64 [[TMP11]], [[M]]
; OPT-NEXT:    br i1 [[TMP12]], label [[LOOP_MEMCPY_EXPANSION]], label [[POST_LOOP_MEMCPY_EXPANSION]]
; OPT:       post-loop-memcpy-expansion:
; OPT-NEXT:    ret void
;
  call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %dst0, i8 addrspace(1)* %src, i64 %n, i1 false)
  call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %dst1, i8 addrspace(1)* %src, i64 %m, i1 false)
  ret void
}

define amdgpu_kernel void @memcpy_alt_type(i8 addrspace(1)* %dst, i8 addrspace(3)* %src, i32 %n) #0 {
; OPT-LABEL: @memcpy_alt_type(
; OPT-NEXT:    [[TMP1:%.*]] = icmp ne i32 [[N:%.*]], 0
; OPT-NEXT:    br i1 [[TMP1]], label [[LOOP_MEMCPY_EXPANSION:%.*]], label [[POST_LOOP_MEMCPY_EXPANSION:%.*]]
; OPT:       loop-memcpy-expansion:
; OPT-NEXT:    [[LOOP_INDEX:%.*]] = phi i32 [ 0, [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[LOOP_MEMCPY_EXPANSION]] ]
; OPT-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, i8 addrspace(3)* [[SRC:%.*]], i32 [[LOOP_INDEX]]
; OPT-NEXT:    [[TMP3:%.*]] = load i8, i8 addrspace(3)* [[TMP2]]
; OPT-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[DST:%.*]], i32 [[LOOP_INDEX]]
; OPT-NEXT:    store i8 [[TMP3]], i8 addrspace(1)* [[TMP4]]
; OPT-NEXT:    [[TMP5]] = add i32 [[LOOP_INDEX]], 1
; OPT-NEXT:    [[TMP6:%.*]] = icmp ult i32 [[TMP5]], [[N]]
; OPT-NEXT:    br i1 [[TMP6]], label [[LOOP_MEMCPY_EXPANSION]], label [[POST_LOOP_MEMCPY_EXPANSION]]
; OPT:       post-loop-memcpy-expansion:
; OPT-NEXT:    ret void
;
  call void @llvm.memcpy.p1i8.p3i8.i32(i8 addrspace(1)* %dst, i8 addrspace(3)* %src, i32 %n, i1 false)
  ret void
}

; One of the uses in the function should be expanded, the other left alone.
define amdgpu_kernel void @memcpy_multi_use_one_function_keep_small(i8 addrspace(1)* %dst0, i8 addrspace(1)* %dst1, i8 addrspace(1)* %src, i64 %n) #0 {
; OPT-LABEL: @memcpy_multi_use_one_function_keep_small(
; OPT-NEXT:    [[TMP1:%.*]] = icmp ne i64 [[N:%.*]], 0
; OPT-NEXT:    br i1 [[TMP1]], label [[LOOP_MEMCPY_EXPANSION:%.*]], label [[POST_LOOP_MEMCPY_EXPANSION:%.*]]
; OPT:       loop-memcpy-expansion:
; OPT-NEXT:    [[LOOP_INDEX:%.*]] = phi i64 [ 0, [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[LOOP_MEMCPY_EXPANSION]] ]
; OPT-NEXT:    [[TMP2:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[SRC:%.*]], i64 [[LOOP_INDEX]]
; OPT-NEXT:    [[TMP3:%.*]] = load i8, i8 addrspace(1)* [[TMP2]]
; OPT-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i8, i8 addrspace(1)* [[DST0:%.*]], i64 [[LOOP_INDEX]]
; OPT-NEXT:    store i8 [[TMP3]], i8 addrspace(1)* [[TMP4]]
; OPT-NEXT:    [[TMP5]] = add i64 [[LOOP_INDEX]], 1
; OPT-NEXT:    [[TMP6:%.*]] = icmp ult i64 [[TMP5]], [[N]]
; OPT-NEXT:    br i1 [[TMP6]], label [[LOOP_MEMCPY_EXPANSION]], label [[POST_LOOP_MEMCPY_EXPANSION]]
; OPT:       post-loop-memcpy-expansion:
; OPT-NEXT:    call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* [[DST1:%.*]], i8 addrspace(1)* [[SRC]], i64 102, i1 false)
; OPT-NEXT:    ret void
;
  call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %dst0, i8 addrspace(1)* %src, i64 %n, i1 false)
  call void @llvm.memcpy.p1i8.p1i8.i64(i8 addrspace(1)* %dst1, i8 addrspace(1)* %src, i64 102, i1 false)
  ret void
}

attributes #0 = { nounwind }
attributes #1 = { argmemonly nounwind }
