; RUN: llc < %s -mcpu=sm_20 | FileCheck %s

target triple = "nvptx64-nvidia-cuda"

%struct.ham = type { [4 x i32] }

; // Verify that load with static offset into parameter is done directly.
; CHECK-LABEL: .visible .entry static_offset
; CHECK: ld.param.u64    [[result_addr:%rd[0-9]+]], [{{.*}}_param_0]
; CHECK: mov.b64         %[[param_addr:rd[0-9]+]], {{.*}}_param_1
; CHECK: mov.u64         %[[param_addr1:rd[0-9]+]], %[[param_addr]]
; CHECK: cvta.to.global.u64 [[result_addr_g:%rd[0-9]+]], [[result_addr]]
; CHECK: ld.param.u32    [[value:%r[0-9]+]], [%[[param_addr1]]+12];
; CHECK  st.global.u32   [[[result_addr_g]]], [[value]];
; Function Attrs: nofree norecurse nounwind willreturn mustprogress
define dso_local void @static_offset(i32* nocapture %arg, %struct.ham* nocapture readonly byval(%struct.ham) align 4 %arg1, i32 %arg2) local_unnamed_addr #0 {
bb:
  %tmp = icmp eq i32 %arg2, 3
  br i1 %tmp, label %bb3, label %bb6

bb3:                                              ; preds = %bb
  %tmp4 = getelementptr inbounds %struct.ham, %struct.ham* %arg1, i64 0, i32 0, i64 3
  %tmp5 = load i32, i32* %tmp4, align 4
  store i32 %tmp5, i32* %arg, align 4
  br label %bb6

bb6:                                              ; preds = %bb3, %bb
  ret void
}

; // Verify that load with dynamic offset into parameter is also done directly.
; CHECK-LABEL: .visible .entry dynamic_offset
; CHECK: ld.param.u64    [[result_addr:%rd[0-9]+]], [{{.*}}_param_0]
; CHECK: mov.b64         %[[param_addr:rd[0-9]+]], {{.*}}_param_1
; CHECK: mov.u64         %[[param_addr1:rd[0-9]+]], %[[param_addr]]
; CHECK: cvta.to.global.u64 [[result_addr_g:%rd[0-9]+]], [[result_addr]]
; CHECK: add.s64         %[[param_w_offset:rd[0-9]+]], %[[param_addr1]],
; CHECK: ld.param.u32    [[value:%r[0-9]+]], [%[[param_w_offset]]];
; CHECK  st.global.u32   [[[result_addr_g]]], [[value]];

; Function Attrs: nofree norecurse nounwind willreturn mustprogress
define dso_local void @dynamic_offset(i32* nocapture %arg, %struct.ham* nocapture readonly byval(%struct.ham) align 4 %arg1, i32 %arg2) local_unnamed_addr #0 {
bb:
  %tmp = sext i32 %arg2 to i64
  %tmp3 = getelementptr inbounds %struct.ham, %struct.ham* %arg1, i64 0, i32 0, i64 %tmp
  %tmp4 = load i32, i32* %tmp3, align 4
  store i32 %tmp4, i32* %arg, align 4
  ret void
}

; Verify that if the pointer escapes, then we do fall back onto using a temp copy.
; CHECK-LABEL: .visible .entry pointer_escapes
; CHECK: .local .align 8 .b8     __local_depot{{.*}}
; CHECK: ld.param.u64    [[result_addr:%rd[0-9]+]], [{{.*}}_param_0]
; CHECK: add.u64         %[[copy_addr:rd[0-9]+]], %SPL, 0;
; CHECK-DAG: ld.param.u32    %{{.*}}, [pointer_escapes_param_1+12];
; CHECK-DAG: ld.param.u32    %{{.*}}, [pointer_escapes_param_1+8];
; CHECK-DAG: ld.param.u32    %{{.*}}, [pointer_escapes_param_1+4];
; CHECK-DAG: ld.param.u32    %{{.*}}, [pointer_escapes_param_1];
; CHECK-DAG: st.local.u32    [%[[copy_addr]]+12],
; CHECK-DAG: st.local.u32    [%[[copy_addr]]+8],
; CHECK-DAG: st.local.u32    [%[[copy_addr]]+4],
; CHECK-DAG: st.local.u32    [%[[copy_addr]]],
; CHECK: cvta.to.global.u64 [[result_addr_g:%rd[0-9]+]], [[result_addr]]
; CHECK: add.s64         %[[copy_w_offset:rd[0-9]+]], %[[copy_addr]],
; CHECK: ld.local.u32    [[value:%r[0-9]+]], [%[[copy_w_offset]]];
; CHECK  st.global.u32   [[[result_addr_g]]], [[value]];

; Function Attrs: convergent norecurse nounwind mustprogress
define dso_local void @pointer_escapes(i32* nocapture %arg, %struct.ham* byval(%struct.ham) align 4 %arg1, i32 %arg2) local_unnamed_addr #1 {
bb:
  %tmp = sext i32 %arg2 to i64
  %tmp3 = getelementptr inbounds %struct.ham, %struct.ham* %arg1, i64 0, i32 0, i64 %tmp
  %tmp4 = load i32, i32* %tmp3, align 4
  store i32 %tmp4, i32* %arg, align 4
  %tmp5 = call i32* @escape(i32* nonnull %tmp3) #3
  ret void
}

; Function Attrs: convergent nounwind
declare dso_local i32* @escape(i32*) local_unnamed_addr


!llvm.module.flags = !{!0, !1, !2}
!nvvm.annotations = !{!3, !4, !5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 9, i32 1]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 4, !"nvvm-reflect-ftz", i32 0}
!3 = !{void (i32*, %struct.ham*, i32)* @static_offset, !"kernel", i32 1}
!4 = !{void (i32*, %struct.ham*, i32)* @dynamic_offset, !"kernel", i32 1}
!5 = !{void (i32*, %struct.ham*, i32)* @pointer_escapes, !"kernel", i32 1}
