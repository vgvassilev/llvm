; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s  -instcombine -S | FileCheck %s

define  void @test(float* %a, float* readnone %a_end, i64 %b) unnamed_addr  {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult float* [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[B_FLOAT:%.*]] = inttoptr i64 [[B:%.*]] to float*
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi float* [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_FLOAT:%.*]] = phi float* [ [[B_ADDR_FLOAT_INC:%.*]], [[FOR_BODY]] ], [ [[B_FLOAT]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[L:%.*]] = load float, float* [[B_ADDR_FLOAT]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[L]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], float* [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[B_ADDR_FLOAT_INC]] = getelementptr inbounds float, float* [[B_ADDR_FLOAT]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, float* [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult float* [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult float* %a, %a_end
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %b.float = inttoptr i64 %b to float*
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %a.addr.03 = phi float* [ %incdec.ptr, %for.body ], [ %a, %for.body.preheader ]
  %b.addr.float = phi float* [ %b.addr.float.inc, %for.body ], [ %b.float, %for.body.preheader ]
  %b.addr.i64 = phi i64 [ %b.addr.i64.inc, %for.body ], [ %b, %for.body.preheader ]
  %l = load float, float* %b.addr.float, align 4
  %mul.i = fmul float %l, 4.200000e+01
  store float %mul.i, float* %a.addr.03, align 4
  %b.addr.float.2 = inttoptr i64 %b.addr.i64 to float*
  %b.addr.float.inc = getelementptr inbounds float, float* %b.addr.float.2, i64 1
  %b.addr.i64.inc = ptrtoint float* %b.addr.float.inc to i64
  %incdec.ptr = getelementptr inbounds float, float* %a.addr.03, i64 1
  %cmp = icmp ult float* %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}



