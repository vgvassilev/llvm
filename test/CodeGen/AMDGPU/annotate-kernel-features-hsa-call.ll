; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -S -mtriple=amdgcn-unknown-amdhsa -amdgpu-annotate-kernel-features %s | FileCheck -check-prefix=HSA %s

declare i32 @llvm.amdgcn.workgroup.id.x() #0
declare i32 @llvm.amdgcn.workgroup.id.y() #0
declare i32 @llvm.amdgcn.workgroup.id.z() #0

declare i32 @llvm.amdgcn.workitem.id.x() #0
declare i32 @llvm.amdgcn.workitem.id.y() #0
declare i32 @llvm.amdgcn.workitem.id.z() #0

declare i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr() #0
declare i8 addrspace(4)* @llvm.amdgcn.queue.ptr() #0
declare i8 addrspace(4)* @llvm.amdgcn.kernarg.segment.ptr() #0
declare i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr() #0
declare i64 @llvm.amdgcn.dispatch.id() #0

define void @use_workitem_id_x() #1 {
; HSA-LABEL: define {{[^@]+}}@use_workitem_id_x
; HSA-SAME: () #[[ATTR1:[0-9]+]] {
; HSA-NEXT:    [[VAL:%.*]] = call i32 @llvm.amdgcn.workitem.id.x()
; HSA-NEXT:    store volatile i32 [[VAL]], i32 addrspace(1)* undef, align 4
; HSA-NEXT:    ret void
;
  %val = call i32 @llvm.amdgcn.workitem.id.x()
  store volatile i32 %val, i32 addrspace(1)* undef
  ret void
}

define void @use_workitem_id_y() #1 {
; HSA-LABEL: define {{[^@]+}}@use_workitem_id_y
; HSA-SAME: () #[[ATTR2:[0-9]+]] {
; HSA-NEXT:    [[VAL:%.*]] = call i32 @llvm.amdgcn.workitem.id.y()
; HSA-NEXT:    store volatile i32 [[VAL]], i32 addrspace(1)* undef, align 4
; HSA-NEXT:    ret void
;
  %val = call i32 @llvm.amdgcn.workitem.id.y()
  store volatile i32 %val, i32 addrspace(1)* undef
  ret void
}

define void @use_workitem_id_z() #1 {
; HSA-LABEL: define {{[^@]+}}@use_workitem_id_z
; HSA-SAME: () #[[ATTR3:[0-9]+]] {
; HSA-NEXT:    [[VAL:%.*]] = call i32 @llvm.amdgcn.workitem.id.z()
; HSA-NEXT:    store volatile i32 [[VAL]], i32 addrspace(1)* undef, align 4
; HSA-NEXT:    ret void
;
  %val = call i32 @llvm.amdgcn.workitem.id.z()
  store volatile i32 %val, i32 addrspace(1)* undef
  ret void
}

define void @use_workgroup_id_x() #1 {
; HSA-LABEL: define {{[^@]+}}@use_workgroup_id_x
; HSA-SAME: () #[[ATTR4:[0-9]+]] {
; HSA-NEXT:    [[VAL:%.*]] = call i32 @llvm.amdgcn.workgroup.id.x()
; HSA-NEXT:    store volatile i32 [[VAL]], i32 addrspace(1)* undef, align 4
; HSA-NEXT:    ret void
;
  %val = call i32 @llvm.amdgcn.workgroup.id.x()
  store volatile i32 %val, i32 addrspace(1)* undef
  ret void
}

define void @use_workgroup_id_y() #1 {
; HSA-LABEL: define {{[^@]+}}@use_workgroup_id_y
; HSA-SAME: () #[[ATTR5:[0-9]+]] {
; HSA-NEXT:    [[VAL:%.*]] = call i32 @llvm.amdgcn.workgroup.id.y()
; HSA-NEXT:    store volatile i32 [[VAL]], i32 addrspace(1)* undef, align 4
; HSA-NEXT:    ret void
;
  %val = call i32 @llvm.amdgcn.workgroup.id.y()
  store volatile i32 %val, i32 addrspace(1)* undef
  ret void
}

define void @use_workgroup_id_z() #1 {
; HSA-LABEL: define {{[^@]+}}@use_workgroup_id_z
; HSA-SAME: () #[[ATTR6:[0-9]+]] {
; HSA-NEXT:    [[VAL:%.*]] = call i32 @llvm.amdgcn.workgroup.id.z()
; HSA-NEXT:    store volatile i32 [[VAL]], i32 addrspace(1)* undef, align 4
; HSA-NEXT:    ret void
;
  %val = call i32 @llvm.amdgcn.workgroup.id.z()
  store volatile i32 %val, i32 addrspace(1)* undef
  ret void
}

define void @use_dispatch_ptr() #1 {
; HSA-LABEL: define {{[^@]+}}@use_dispatch_ptr
; HSA-SAME: () #[[ATTR7:[0-9]+]] {
; HSA-NEXT:    [[DISPATCH_PTR:%.*]] = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()
; HSA-NEXT:    store volatile i8 addrspace(4)* [[DISPATCH_PTR]], i8 addrspace(4)* addrspace(1)* undef, align 8
; HSA-NEXT:    ret void
;
  %dispatch.ptr = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()
  store volatile i8 addrspace(4)* %dispatch.ptr, i8 addrspace(4)* addrspace(1)* undef
  ret void
}

define void @use_queue_ptr() #1 {
; HSA-LABEL: define {{[^@]+}}@use_queue_ptr
; HSA-SAME: () #[[ATTR8:[0-9]+]] {
; HSA-NEXT:    [[QUEUE_PTR:%.*]] = call i8 addrspace(4)* @llvm.amdgcn.queue.ptr()
; HSA-NEXT:    store volatile i8 addrspace(4)* [[QUEUE_PTR]], i8 addrspace(4)* addrspace(1)* undef, align 8
; HSA-NEXT:    ret void
;
  %queue.ptr = call i8 addrspace(4)* @llvm.amdgcn.queue.ptr()
  store volatile i8 addrspace(4)* %queue.ptr, i8 addrspace(4)* addrspace(1)* undef
  ret void
}

define void @use_dispatch_id() #1 {
; HSA-LABEL: define {{[^@]+}}@use_dispatch_id
; HSA-SAME: () #[[ATTR9:[0-9]+]] {
; HSA-NEXT:    [[VAL:%.*]] = call i64 @llvm.amdgcn.dispatch.id()
; HSA-NEXT:    store volatile i64 [[VAL]], i64 addrspace(1)* undef, align 4
; HSA-NEXT:    ret void
;
  %val = call i64 @llvm.amdgcn.dispatch.id()
  store volatile i64 %val, i64 addrspace(1)* undef
  ret void
}

define void @use_workgroup_id_y_workgroup_id_z() #1 {
; HSA-LABEL: define {{[^@]+}}@use_workgroup_id_y_workgroup_id_z
; HSA-SAME: () #[[ATTR10:[0-9]+]] {
; HSA-NEXT:    [[VAL0:%.*]] = call i32 @llvm.amdgcn.workgroup.id.y()
; HSA-NEXT:    [[VAL1:%.*]] = call i32 @llvm.amdgcn.workgroup.id.z()
; HSA-NEXT:    store volatile i32 [[VAL0]], i32 addrspace(1)* undef, align 4
; HSA-NEXT:    store volatile i32 [[VAL1]], i32 addrspace(1)* undef, align 4
; HSA-NEXT:    ret void
;
  %val0 = call i32 @llvm.amdgcn.workgroup.id.y()
  %val1 = call i32 @llvm.amdgcn.workgroup.id.z()
  store volatile i32 %val0, i32 addrspace(1)* undef
  store volatile i32 %val1, i32 addrspace(1)* undef
  ret void
}

define void @func_indirect_use_workitem_id_x() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_workitem_id_x
; HSA-SAME: () #[[ATTR1]] {
; HSA-NEXT:    call void @use_workitem_id_x()
; HSA-NEXT:    ret void
;
  call void @use_workitem_id_x()
  ret void
}

define void @kernel_indirect_use_workitem_id_x() #1 {
; HSA-LABEL: define {{[^@]+}}@kernel_indirect_use_workitem_id_x
; HSA-SAME: () #[[ATTR1]] {
; HSA-NEXT:    call void @use_workitem_id_x()
; HSA-NEXT:    ret void
;
  call void @use_workitem_id_x()
  ret void
}

define void @func_indirect_use_workitem_id_y() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_workitem_id_y
; HSA-SAME: () #[[ATTR2]] {
; HSA-NEXT:    call void @use_workitem_id_y()
; HSA-NEXT:    ret void
;
  call void @use_workitem_id_y()
  ret void
}

define void @func_indirect_use_workitem_id_z() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_workitem_id_z
; HSA-SAME: () #[[ATTR3]] {
; HSA-NEXT:    call void @use_workitem_id_z()
; HSA-NEXT:    ret void
;
  call void @use_workitem_id_z()
  ret void
}

define void @func_indirect_use_workgroup_id_x() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_workgroup_id_x
; HSA-SAME: () #[[ATTR4]] {
; HSA-NEXT:    call void @use_workgroup_id_x()
; HSA-NEXT:    ret void
;
  call void @use_workgroup_id_x()
  ret void
}

define void @kernel_indirect_use_workgroup_id_x() #1 {
; HSA-LABEL: define {{[^@]+}}@kernel_indirect_use_workgroup_id_x
; HSA-SAME: () #[[ATTR4]] {
; HSA-NEXT:    call void @use_workgroup_id_x()
; HSA-NEXT:    ret void
;
  call void @use_workgroup_id_x()
  ret void
}

define void @func_indirect_use_workgroup_id_y() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_workgroup_id_y
; HSA-SAME: () #[[ATTR5]] {
; HSA-NEXT:    call void @use_workgroup_id_y()
; HSA-NEXT:    ret void
;
  call void @use_workgroup_id_y()
  ret void
}

define void @func_indirect_use_workgroup_id_z() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_workgroup_id_z
; HSA-SAME: () #[[ATTR6]] {
; HSA-NEXT:    call void @use_workgroup_id_z()
; HSA-NEXT:    ret void
;
  call void @use_workgroup_id_z()
  ret void
}

define void @func_indirect_indirect_use_workgroup_id_y() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_indirect_use_workgroup_id_y
; HSA-SAME: () #[[ATTR5]] {
; HSA-NEXT:    call void @func_indirect_use_workgroup_id_y()
; HSA-NEXT:    ret void
;
  call void @func_indirect_use_workgroup_id_y()
  ret void
}

define void @indirect_x2_use_workgroup_id_y() #1 {
; HSA-LABEL: define {{[^@]+}}@indirect_x2_use_workgroup_id_y
; HSA-SAME: () #[[ATTR5]] {
; HSA-NEXT:    call void @func_indirect_indirect_use_workgroup_id_y()
; HSA-NEXT:    ret void
;
  call void @func_indirect_indirect_use_workgroup_id_y()
  ret void
}

define void @func_indirect_use_dispatch_ptr() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_dispatch_ptr
; HSA-SAME: () #[[ATTR7]] {
; HSA-NEXT:    call void @use_dispatch_ptr()
; HSA-NEXT:    ret void
;
  call void @use_dispatch_ptr()
  ret void
}

define void @func_indirect_use_queue_ptr() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_queue_ptr
; HSA-SAME: () #[[ATTR8]] {
; HSA-NEXT:    call void @use_queue_ptr()
; HSA-NEXT:    ret void
;
  call void @use_queue_ptr()
  ret void
}

define void @func_indirect_use_dispatch_id() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_dispatch_id
; HSA-SAME: () #[[ATTR9]] {
; HSA-NEXT:    call void @use_dispatch_id()
; HSA-NEXT:    ret void
;
  call void @use_dispatch_id()
  ret void
}

define void @func_indirect_use_workgroup_id_y_workgroup_id_z() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_workgroup_id_y_workgroup_id_z
; HSA-SAME: () #[[ATTR11:[0-9]+]] {
; HSA-NEXT:    call void @func_indirect_use_workgroup_id_y_workgroup_id_z()
; HSA-NEXT:    ret void
;
  call void @func_indirect_use_workgroup_id_y_workgroup_id_z()
  ret void
}

define void @recursive_use_workitem_id_y() #1 {
; HSA-LABEL: define {{[^@]+}}@recursive_use_workitem_id_y
; HSA-SAME: () #[[ATTR2]] {
; HSA-NEXT:    [[VAL:%.*]] = call i32 @llvm.amdgcn.workitem.id.y()
; HSA-NEXT:    store volatile i32 [[VAL]], i32 addrspace(1)* undef, align 4
; HSA-NEXT:    call void @recursive_use_workitem_id_y()
; HSA-NEXT:    ret void
;
  %val = call i32 @llvm.amdgcn.workitem.id.y()
  store volatile i32 %val, i32 addrspace(1)* undef
  call void @recursive_use_workitem_id_y()
  ret void
}

define void @call_recursive_use_workitem_id_y() #1 {
; HSA-LABEL: define {{[^@]+}}@call_recursive_use_workitem_id_y
; HSA-SAME: () #[[ATTR2]] {
; HSA-NEXT:    call void @recursive_use_workitem_id_y()
; HSA-NEXT:    ret void
;
  call void @recursive_use_workitem_id_y()
  ret void
}

define void @use_group_to_flat_addrspacecast(i32 addrspace(3)* %ptr) #1 {
; HSA-LABEL: define {{[^@]+}}@use_group_to_flat_addrspacecast
; HSA-SAME: (i32 addrspace(3)* [[PTR:%.*]]) #[[ATTR8]] {
; HSA-NEXT:    [[STOF:%.*]] = addrspacecast i32 addrspace(3)* [[PTR]] to i32 addrspace(4)*
; HSA-NEXT:    store volatile i32 0, i32 addrspace(4)* [[STOF]], align 4
; HSA-NEXT:    ret void
;
  %stof = addrspacecast i32 addrspace(3)* %ptr to i32 addrspace(4)*
  store volatile i32 0, i32 addrspace(4)* %stof
  ret void
}

define void @use_group_to_flat_addrspacecast_gfx9(i32 addrspace(3)* %ptr) #2 {
; HSA-LABEL: define {{[^@]+}}@use_group_to_flat_addrspacecast_gfx9
; HSA-SAME: (i32 addrspace(3)* [[PTR:%.*]]) #[[ATTR12:[0-9]+]] {
; HSA-NEXT:    [[STOF:%.*]] = addrspacecast i32 addrspace(3)* [[PTR]] to i32 addrspace(4)*
; HSA-NEXT:    store volatile i32 0, i32 addrspace(4)* [[STOF]], align 4
; HSA-NEXT:    ret void
;
  %stof = addrspacecast i32 addrspace(3)* %ptr to i32 addrspace(4)*
  store volatile i32 0, i32 addrspace(4)* %stof
  ret void
}

define void @use_group_to_flat_addrspacecast_queue_ptr_gfx9(i32 addrspace(3)* %ptr) #2 {
; HSA-LABEL: define {{[^@]+}}@use_group_to_flat_addrspacecast_queue_ptr_gfx9
; HSA-SAME: (i32 addrspace(3)* [[PTR:%.*]]) #[[ATTR13:[0-9]+]] {
; HSA-NEXT:    [[STOF:%.*]] = addrspacecast i32 addrspace(3)* [[PTR]] to i32 addrspace(4)*
; HSA-NEXT:    store volatile i32 0, i32 addrspace(4)* [[STOF]], align 4
; HSA-NEXT:    call void @func_indirect_use_queue_ptr()
; HSA-NEXT:    ret void
;
  %stof = addrspacecast i32 addrspace(3)* %ptr to i32 addrspace(4)*
  store volatile i32 0, i32 addrspace(4)* %stof
  call void @func_indirect_use_queue_ptr()
  ret void
}

define void @indirect_use_group_to_flat_addrspacecast() #1 {
; HSA-LABEL: define {{[^@]+}}@indirect_use_group_to_flat_addrspacecast
; HSA-SAME: () #[[ATTR8]] {
; HSA-NEXT:    call void @use_group_to_flat_addrspacecast(i32 addrspace(3)* null)
; HSA-NEXT:    ret void
;
  call void @use_group_to_flat_addrspacecast(i32 addrspace(3)* null)
  ret void
}

define void @indirect_use_group_to_flat_addrspacecast_gfx9() #1 {
; HSA-LABEL: define {{[^@]+}}@indirect_use_group_to_flat_addrspacecast_gfx9
; HSA-SAME: () #[[ATTR11]] {
; HSA-NEXT:    call void @use_group_to_flat_addrspacecast_gfx9(i32 addrspace(3)* null)
; HSA-NEXT:    ret void
;
  call void @use_group_to_flat_addrspacecast_gfx9(i32 addrspace(3)* null)
  ret void
}

define void @indirect_use_group_to_flat_addrspacecast_queue_ptr_gfx9() #1 {
; HSA-LABEL: define {{[^@]+}}@indirect_use_group_to_flat_addrspacecast_queue_ptr_gfx9
; HSA-SAME: () #[[ATTR8]] {
; HSA-NEXT:    call void @use_group_to_flat_addrspacecast_queue_ptr_gfx9(i32 addrspace(3)* null)
; HSA-NEXT:    ret void
;
  call void @use_group_to_flat_addrspacecast_queue_ptr_gfx9(i32 addrspace(3)* null)
  ret void
}

define void @use_kernarg_segment_ptr() #1 {
; HSA-LABEL: define {{[^@]+}}@use_kernarg_segment_ptr
; HSA-SAME: () #[[ATTR14:[0-9]+]] {
; HSA-NEXT:    [[KERNARG_SEGMENT_PTR:%.*]] = call i8 addrspace(4)* @llvm.amdgcn.kernarg.segment.ptr()
; HSA-NEXT:    store volatile i8 addrspace(4)* [[KERNARG_SEGMENT_PTR]], i8 addrspace(4)* addrspace(1)* undef, align 8
; HSA-NEXT:    ret void
;
  %kernarg.segment.ptr = call i8 addrspace(4)* @llvm.amdgcn.kernarg.segment.ptr()
  store volatile i8 addrspace(4)* %kernarg.segment.ptr, i8 addrspace(4)* addrspace(1)* undef
  ret void
}

define void @func_indirect_use_kernarg_segment_ptr() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_kernarg_segment_ptr
; HSA-SAME: () #[[ATTR11]] {
; HSA-NEXT:    call void @use_kernarg_segment_ptr()
; HSA-NEXT:    ret void
;
  call void @use_kernarg_segment_ptr()
  ret void
}

define amdgpu_kernel void @kern_use_implicitarg_ptr() #1 {
; HSA-LABEL: define {{[^@]+}}@kern_use_implicitarg_ptr
; HSA-SAME: () #[[ATTR15:[0-9]+]] {
; HSA-NEXT:    [[IMPLICITARG_PTR:%.*]] = call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
; HSA-NEXT:    store volatile i8 addrspace(4)* [[IMPLICITARG_PTR]], i8 addrspace(4)* addrspace(1)* undef, align 8
; HSA-NEXT:    ret void
;
  %implicitarg.ptr = call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
  store volatile i8 addrspace(4)* %implicitarg.ptr, i8 addrspace(4)* addrspace(1)* undef
  ret void
}

define void @use_implicitarg_ptr() #1 {
; HSA-LABEL: define {{[^@]+}}@use_implicitarg_ptr
; HSA-SAME: () #[[ATTR16:[0-9]+]] {
; HSA-NEXT:    [[IMPLICITARG_PTR:%.*]] = call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
; HSA-NEXT:    store volatile i8 addrspace(4)* [[IMPLICITARG_PTR]], i8 addrspace(4)* addrspace(1)* undef, align 8
; HSA-NEXT:    ret void
;
  %implicitarg.ptr = call i8 addrspace(4)* @llvm.amdgcn.implicitarg.ptr()
  store volatile i8 addrspace(4)* %implicitarg.ptr, i8 addrspace(4)* addrspace(1)* undef
  ret void
}

define void @func_indirect_use_implicitarg_ptr() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_implicitarg_ptr
; HSA-SAME: () #[[ATTR16]] {
; HSA-NEXT:    call void @use_implicitarg_ptr()
; HSA-NEXT:    ret void
;
  call void @use_implicitarg_ptr()
  ret void
}

declare void @external.func() #3

define internal void @defined.func() #3 {
; HSA-LABEL: define {{[^@]+}}@defined.func
; HSA-SAME: () #[[ATTR17:[0-9]+]] {
; HSA-NEXT:    ret void
;
  ret void
}

define void @func_call_external() #3 {
; HSA-LABEL: define {{[^@]+}}@func_call_external
; HSA-SAME: () #[[ATTR17]] {
; HSA-NEXT:    call void @external.func()
; HSA-NEXT:    ret void
;
  call void @external.func()
  ret void
}

define void @func_call_defined() #3 {
; HSA-LABEL: define {{[^@]+}}@func_call_defined
; HSA-SAME: () #[[ATTR17]] {
; HSA-NEXT:    call void @defined.func()
; HSA-NEXT:    ret void
;
  call void @defined.func()
  ret void
}

define void @func_call_asm() #3 {
; HSA-LABEL: define {{[^@]+}}@func_call_asm
; HSA-SAME: () #[[ATTR18:[0-9]+]] {
; HSA-NEXT:    call void asm sideeffect "", ""() #[[ATTR18]]
; HSA-NEXT:    ret void
;
  call void asm sideeffect "", ""() #3
  ret void
}

define amdgpu_kernel void @kern_call_external() #3 {
; HSA-LABEL: define {{[^@]+}}@kern_call_external
; HSA-SAME: () #[[ATTR19:[0-9]+]] {
; HSA-NEXT:    call void @external.func()
; HSA-NEXT:    ret void
;
  call void @external.func()
  ret void
}

define amdgpu_kernel void @func_kern_defined() #3 {
; HSA-LABEL: define {{[^@]+}}@func_kern_defined
; HSA-SAME: () #[[ATTR19]] {
; HSA-NEXT:    call void @defined.func()
; HSA-NEXT:    ret void
;
  call void @defined.func()
  ret void
}

define i32 @use_dispatch_ptr_ret_type() #1 {
; HSA-LABEL: define {{[^@]+}}@use_dispatch_ptr_ret_type
; HSA-SAME: () #[[ATTR20:[0-9]+]] {
; HSA-NEXT:    [[DISPATCH_PTR:%.*]] = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()
; HSA-NEXT:    store volatile i8 addrspace(4)* [[DISPATCH_PTR]], i8 addrspace(4)* addrspace(1)* undef, align 8
; HSA-NEXT:    ret i32 0
;
  %dispatch.ptr = call i8 addrspace(4)* @llvm.amdgcn.dispatch.ptr()
  store volatile i8 addrspace(4)* %dispatch.ptr, i8 addrspace(4)* addrspace(1)* undef
  ret i32 0
}

define float @func_indirect_use_dispatch_ptr_constexpr_cast_func() #1 {
; HSA-LABEL: define {{[^@]+}}@func_indirect_use_dispatch_ptr_constexpr_cast_func
; HSA-SAME: () #[[ATTR20]] {
; HSA-NEXT:    [[F:%.*]] = call float bitcast (i32 ()* @use_dispatch_ptr_ret_type to float ()*)()
; HSA-NEXT:    [[FADD:%.*]] = fadd float [[F]], 1.000000e+00
; HSA-NEXT:    ret float [[FADD]]
;
  %f = call float bitcast (i32()* @use_dispatch_ptr_ret_type to float()*)()
  %fadd = fadd float %f, 1.0
  ret float %fadd
}

attributes #0 = { nounwind readnone speculatable }
attributes #1 = { nounwind "target-cpu"="fiji" }
attributes #2 = { nounwind "target-cpu"="gfx900" }
attributes #3 = { nounwind }

;.
; HSA: attributes #[[ATTR0:[0-9]+]] = { nounwind readnone speculatable willreturn }
; HSA: attributes #[[ATTR1]] = { nounwind "amdgpu-work-item-id-x" "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR2]] = { nounwind "amdgpu-work-item-id-y" "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR3]] = { nounwind "amdgpu-work-item-id-z" "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR4]] = { nounwind "amdgpu-work-group-id-x" "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR5]] = { nounwind "amdgpu-work-group-id-y" "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR6]] = { nounwind "amdgpu-work-group-id-z" "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR7]] = { nounwind "amdgpu-dispatch-ptr" "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR8]] = { nounwind "amdgpu-queue-ptr" "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR9]] = { nounwind "amdgpu-dispatch-id" "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR10]] = { nounwind "amdgpu-work-group-id-y" "amdgpu-work-group-id-z" "target-cpu"="fiji" }
; HSA: attributes #[[ATTR11]] = { nounwind "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR12]] = { nounwind "target-cpu"="gfx900" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR13]] = { nounwind "amdgpu-queue-ptr" "target-cpu"="gfx900" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR14]] = { nounwind "amdgpu-kernarg-segment-ptr" "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR15]] = { nounwind "amdgpu-implicitarg-ptr" "target-cpu"="fiji" }
; HSA: attributes #[[ATTR16]] = { nounwind "amdgpu-implicitarg-ptr" "target-cpu"="fiji" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR17]] = { nounwind "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR18]] = { nounwind }
; HSA: attributes #[[ATTR19]] = { nounwind "amdgpu-calls" "uniform-work-group-size"="false" }
; HSA: attributes #[[ATTR20]] = { nounwind "amdgpu-dispatch-id" "amdgpu-dispatch-ptr" "amdgpu-implicitarg-ptr" "amdgpu-queue-ptr" "amdgpu-work-group-id-x" "amdgpu-work-group-id-y" "amdgpu-work-group-id-z" "amdgpu-work-item-id-x" "amdgpu-work-item-id-y" "amdgpu-work-item-id-z" "target-cpu"="fiji" }
;.
