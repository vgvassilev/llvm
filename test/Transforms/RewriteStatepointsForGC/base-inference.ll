; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -rewrite-statepoints-for-gc -S 2>&1 | FileCheck %s
; RUN: opt < %s -passes=rewrite-statepoints-for-gc -S 2>&1 | FileCheck %s

; A collection of tests for exercising the base inference logic in the
; findBasePointers.  That is, the logic which proves a potentially derived
; pointer is actually a base pointer itself.

define i8 addrspace(1)* @test(i8 addrspace(1)* %a) gc "statepoint-example" {
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i8 addrspace(1)* [[A:%.*]]) ]
; CHECK-NEXT:    [[A_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    ret i8 addrspace(1)* [[A_RELOCATED]]
;
  call void @foo()
  ret i8 addrspace(1)* %a
}

define i8 addrspace(1)* @test_select(i1 %c, i8 addrspace(1)* %a1, i8 addrspace(1)* %a2) gc "statepoint-example" {
; CHECK-LABEL: @test_select(
; CHECK-NEXT:    [[SEL_BASE:%.*]] = select i1 [[C:%.*]], i8 addrspace(1)* [[A1:%.*]], i8 addrspace(1)* [[A2:%.*]], !is_base_value !0
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[C]], i8 addrspace(1)* [[A1]], i8 addrspace(1)* [[A2]]
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i8 addrspace(1)* [[SEL]], i8 addrspace(1)* [[SEL_BASE]]) ]
; CHECK-NEXT:    [[SEL_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 0)
; CHECK-NEXT:    [[SEL_BASE_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 1)
; CHECK-NEXT:    ret i8 addrspace(1)* [[SEL_RELOCATED]]
;
  %sel = select i1 %c, i8 addrspace(1)* %a1, i8 addrspace(1)* %a2
  call void @foo()
  ret i8 addrspace(1)* %sel
}

define i8 addrspace(1)* @test_phi1(i1 %c, i8 addrspace(1)* %a1, i8 addrspace(1)* %a2) gc "statepoint-example" {
; CHECK-LABEL: @test_phi1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[TAKEN:%.*]], label [[UNTAKEN:%.*]]
; CHECK:       taken:
; CHECK-NEXT:    br label [[MERGE:%.*]]
; CHECK:       untaken:
; CHECK-NEXT:    br label [[MERGE]]
; CHECK:       merge:
; CHECK-NEXT:    [[PHI_BASE:%.*]] = phi i8 addrspace(1)* [ [[A1:%.*]], [[TAKEN]] ], [ [[A2:%.*]], [[UNTAKEN]] ], !is_base_value !0
; CHECK-NEXT:    [[PHI:%.*]] = phi i8 addrspace(1)* [ [[A1]], [[TAKEN]] ], [ [[A2]], [[UNTAKEN]] ]
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i8 addrspace(1)* [[PHI]], i8 addrspace(1)* [[PHI_BASE]]) ]
; CHECK-NEXT:    [[PHI_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 0)
; CHECK-NEXT:    [[PHI_BASE_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 1)
; CHECK-NEXT:    ret i8 addrspace(1)* [[PHI_RELOCATED]]
;
entry:
  br i1 %c, label %taken, label %untaken
taken:
  br label %merge
untaken:
  br label %merge
merge:
  %phi = phi i8 addrspace(1)* [%a1, %taken], [%a2, %untaken]
  call void @foo()
  ret i8 addrspace(1)* %phi
}

define i8 addrspace(1)* @test_phi_lcssa(i1 %c, i8 addrspace(1)* %a1, i8 addrspace(1)* %a2) gc "statepoint-example" {
; CHECK-LABEL: @test_phi_lcssa(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[MERGE:%.*]]
; CHECK:       merge:
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i8 addrspace(1)* [[A1:%.*]]) ]
; CHECK-NEXT:    [[A1_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    ret i8 addrspace(1)* [[A1_RELOCATED]]
;
entry:
  br label %merge
merge:
  %phi = phi i8 addrspace(1)* [%a1, %entry]
  call void @foo()
  ret i8 addrspace(1)* %phi
}


define i8 addrspace(1)* @test_loop1(i1 %c, i8 addrspace(1)* %a1, i8 addrspace(1)* %a2) gc "statepoint-example" {
; CHECK-LABEL: @test_loop1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[PHI_BASE:%.*]] = phi i8 addrspace(1)* [ [[A1:%.*]], [[ENTRY:%.*]] ], [ [[A2:%.*]], [[LOOP]] ], !is_base_value !0
; CHECK-NEXT:    [[PHI:%.*]] = phi i8 addrspace(1)* [ [[A1]], [[ENTRY]] ], [ [[A2]], [[LOOP]] ]
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i8 addrspace(1)* [[PHI]], i8 addrspace(1)* [[PHI_BASE]]) ]
; CHECK-NEXT:    [[PHI_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 0)
; CHECK-NEXT:    [[PHI_BASE_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 1)
; CHECK-NEXT:    ret i8 addrspace(1)* [[PHI_RELOCATED]]
;
entry:
  br label %loop
loop:
  %phi = phi i8 addrspace(1)* [%a1, %entry], [%a2, %loop]
  br i1 %c, label %exit, label %loop
exit:
  %phi2 = phi i8 addrspace(1)* [%phi, %loop]
  call void @foo()
  ret i8 addrspace(1)* %phi2
}

define i8 addrspace(1)* @test_loop2(i1 %c, i8 addrspace(1)* %a1) gc "statepoint-example" {
; CHECK-LABEL: @test_loop2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[PHI_BASE:%.*]] = phi i8 addrspace(1)* [ [[A1:%.*]], [[ENTRY:%.*]] ], [ [[O2:%.*]], [[LOOP]] ], !is_base_value !0
; CHECK-NEXT:    [[PHI:%.*]] = phi i8 addrspace(1)* [ [[A1]], [[ENTRY]] ], [ [[O2]], [[LOOP]] ]
; CHECK-NEXT:    [[ADDR:%.*]] = bitcast i8 addrspace(1)* [[PHI]] to i8 addrspace(1)* addrspace(1)*
; CHECK-NEXT:    [[O2]] = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* [[ADDR]], align 8
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i8 addrspace(1)* [[PHI]], i8 addrspace(1)* [[PHI_BASE]]) ]
; CHECK-NEXT:    [[PHI_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 0)
; CHECK-NEXT:    [[PHI_BASE_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 1)
; CHECK-NEXT:    ret i8 addrspace(1)* [[PHI_RELOCATED]]
;
entry:
  br label %loop
loop:
  %phi = phi i8 addrspace(1)* [%a1, %entry], [%o2, %loop]
  %addr = bitcast i8 addrspace(1)* %phi to i8 addrspace(1)* addrspace(1)*
  %o2 = load i8 addrspace(1)*, i8 addrspace(1)* addrspace(1)* %addr
  br i1 %c, label %exit, label %loop
exit:
  %phi2 = phi i8 addrspace(1)* [%phi, %loop]
  call void @foo()
  ret i8 addrspace(1)* %phi2
}

; %phi1 and phi2 are not base pointers, but they do have a single
; base pointer which is %a1
define i8 addrspace(1)* @test_loop3(i1 %c, i8 addrspace(1)* %a1) gc "statepoint-example" {
; CHECK-LABEL: @test_loop3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[PHI:%.*]] = phi i8 addrspace(1)* [ [[A1:%.*]], [[ENTRY:%.*]] ], [ [[GEP:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[GEP]] = getelementptr i8, i8 addrspace(1)* [[PHI]], i64 16
; CHECK-NEXT:    br i1 [[C:%.*]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i8 addrspace(1)* [[PHI]], i8 addrspace(1)* [[A1]]) ]
; CHECK-NEXT:    [[PHI_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 0)
; CHECK-NEXT:    [[A1_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 1)
; CHECK-NEXT:    ret i8 addrspace(1)* [[PHI_RELOCATED]]
;
entry:
  br label %loop
loop:
  %phi = phi i8 addrspace(1)* [%a1, %entry], [%gep, %loop]
  %gep = getelementptr i8, i8 addrspace(1)* %phi, i64 16
  br i1 %c, label %exit, label %loop
exit:
  %phi2 = phi i8 addrspace(1)* [%phi, %loop]
  call void @foo()
  ret i8 addrspace(1)* %phi2
}

define <2 x i8 addrspace(1)*> @test_vec_passthrough(<2 x i8 addrspace(1)*> %a) gc "statepoint-example" {
; CHECK-LABEL: @test_vec_passthrough(
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(<2 x i8 addrspace(1)*> [[A:%.*]]) ]
; CHECK-NEXT:    [[A_RELOCATED:%.*]] = call coldcc <2 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v2p1i8(token [[STATEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    ret <2 x i8 addrspace(1)*> [[A_RELOCATED]]
;
  call void @foo()
  ret <2 x i8 addrspace(1)*> %a
}


define <2 x i8 addrspace(1)*> @test_insert(i8 addrspace(1)* %a) gc "statepoint-example" {
; CHECK-LABEL: @test_insert(
; CHECK-NEXT:    [[VEC_BASE:%.*]] = insertelement <2 x i8 addrspace(1)*> zeroinitializer, i8 addrspace(1)* [[A:%.*]], i64 0, !is_base_value !0
; CHECK-NEXT:    [[VEC:%.*]] = insertelement <2 x i8 addrspace(1)*> zeroinitializer, i8 addrspace(1)* [[A]], i64 0
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(<2 x i8 addrspace(1)*> [[VEC]], <2 x i8 addrspace(1)*> [[VEC_BASE]]) ]
; CHECK-NEXT:    [[VEC_RELOCATED:%.*]] = call coldcc <2 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v2p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 0)
; CHECK-NEXT:    [[VEC_BASE_RELOCATED:%.*]] = call coldcc <2 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v2p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 1)
; CHECK-NEXT:    ret <2 x i8 addrspace(1)*> [[VEC_RELOCATED]]
;
  %vec = insertelement <2 x i8 addrspace(1)*> zeroinitializer, i8 addrspace(1)* %a, i64 0
  call void @foo()
  ret <2 x i8 addrspace(1)*> %vec
}

define i8 addrspace(1)* @test_extract(<2 x i8 addrspace(1)*> %a) gc "statepoint-example" {
; CHECK-LABEL: @test_extract(
; CHECK-NEXT:    [[BASE_EE:%.*]] = extractelement <2 x i8 addrspace(1)*> [[A:%.*]], i64 0, !is_base_value !0
; CHECK-NEXT:    [[EE:%.*]] = extractelement <2 x i8 addrspace(1)*> [[A]], i64 0
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(i8 addrspace(1)* [[EE]], i8 addrspace(1)* [[BASE_EE]]) ]
; CHECK-NEXT:    [[EE_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 0)
; CHECK-NEXT:    [[BASE_EE_RELOCATED:%.*]] = call coldcc i8 addrspace(1)* @llvm.experimental.gc.relocate.p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 1)
; CHECK-NEXT:    ret i8 addrspace(1)* [[EE_RELOCATED]]
;
  %ee = extractelement <2 x i8 addrspace(1)*> %a, i64 0
  call void @foo()
  ret i8 addrspace(1)* %ee
}

define <2 x i8 addrspace(1)*> @test_shuffle(<2 x i8 addrspace(1)*> %a1) gc "statepoint-example" {
; CHECK-LABEL: @test_shuffle(
; CHECK-NEXT:    [[RES:%.*]] = shufflevector <2 x i8 addrspace(1)*> [[A1:%.*]], <2 x i8 addrspace(1)*> [[A1]], <2 x i32> zeroinitializer
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(<2 x i8 addrspace(1)*> [[RES]], <2 x i8 addrspace(1)*> [[A1]]) ]
; CHECK-NEXT:    [[RES_RELOCATED:%.*]] = call coldcc <2 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v2p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 0)
; CHECK-NEXT:    [[A1_RELOCATED:%.*]] = call coldcc <2 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v2p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 1)
; CHECK-NEXT:    ret <2 x i8 addrspace(1)*> [[RES_RELOCATED]]
;
  %res = shufflevector <2 x i8 addrspace(1)*> %a1, <2 x i8 addrspace(1)*> %a1, <2 x i32> zeroinitializer
  call void @foo()
  ret <2 x i8 addrspace(1)*> %res
}

define <2 x i8 addrspace(1)*> @test_shuffle2(<2 x i8 addrspace(1)*> %a1, <2 x i8 addrspace(1)*> %a2) gc "statepoint-example" {
; CHECK-LABEL: @test_shuffle2(
; CHECK-NEXT:    [[RES_BASE:%.*]] = shufflevector <2 x i8 addrspace(1)*> [[A1:%.*]], <2 x i8 addrspace(1)*> [[A2:%.*]], <2 x i32> zeroinitializer, !is_base_value !0
; CHECK-NEXT:    [[RES:%.*]] = shufflevector <2 x i8 addrspace(1)*> [[A1]], <2 x i8 addrspace(1)*> [[A2]], <2 x i32> zeroinitializer
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(<2 x i8 addrspace(1)*> [[RES]], <2 x i8 addrspace(1)*> [[RES_BASE]]) ]
; CHECK-NEXT:    [[RES_RELOCATED:%.*]] = call coldcc <2 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v2p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 0)
; CHECK-NEXT:    [[RES_BASE_RELOCATED:%.*]] = call coldcc <2 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v2p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 1)
; CHECK-NEXT:    ret <2 x i8 addrspace(1)*> [[RES_RELOCATED]]
;
  %res = shufflevector <2 x i8 addrspace(1)*> %a1, <2 x i8 addrspace(1)*> %a2, <2 x i32> zeroinitializer
  call void @foo()
  ret <2 x i8 addrspace(1)*> %res
}

define <4 x i8 addrspace(1)*> @test_shuffle_concat(<2 x i8 addrspace(1)*> %a1, <2 x i8 addrspace(1)*> %a2) gc "statepoint-example" {
; CHECK-LABEL: @test_shuffle_concat(
; CHECK-NEXT:    [[RES_BASE:%.*]] = shufflevector <2 x i8 addrspace(1)*> [[A1:%.*]], <2 x i8 addrspace(1)*> [[A2:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>, !is_base_value !0
; CHECK-NEXT:    [[RES:%.*]] = shufflevector <2 x i8 addrspace(1)*> [[A1]], <2 x i8 addrspace(1)*> [[A2]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, void ()*, i32, i32, ...) @llvm.experimental.gc.statepoint.p0f_isVoidf(i64 2882400000, i32 0, void ()* @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(<4 x i8 addrspace(1)*> [[RES]], <4 x i8 addrspace(1)*> [[RES_BASE]]) ]
; CHECK-NEXT:    [[RES_RELOCATED:%.*]] = call coldcc <4 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v4p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 0)
; CHECK-NEXT:    [[RES_BASE_RELOCATED:%.*]] = call coldcc <4 x i8 addrspace(1)*> @llvm.experimental.gc.relocate.v4p1i8(token [[STATEPOINT_TOKEN]], i32 1, i32 1)
; CHECK-NEXT:    ret <4 x i8 addrspace(1)*> [[RES_RELOCATED]]
;
  %res = shufflevector <2 x i8 addrspace(1)*> %a1, <2 x i8 addrspace(1)*> %a2, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  call void @foo()
  ret <4 x i8 addrspace(1)*> %res
}





declare void @foo()
