; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S %s | FileCheck %s

define i32 @test.ult(i32* readonly %src, i32* readnone %min, i32* readnone %max) {
; CHECK-LABEL: @test.ult(
; CHECK-NEXT:  check.0.min:
; CHECK-NEXT:    [[C_MIN_0:%.*]] = icmp ult i32* [[SRC:%.*]], [[MIN:%.*]]
; CHECK-NEXT:    br i1 [[C_MIN_0]], label [[TRAP:%.*]], label [[CHECK_0_MAX:%.*]]
; CHECK:       trap:
; CHECK-NEXT:    ret i32 10
; CHECK:       check.0.max:
; CHECK-NEXT:    [[C_MAX_0:%.*]] = icmp ult i32* [[SRC]], [[MAX:%.*]]
; CHECK-NEXT:    br i1 [[C_MAX_0]], label [[CHECK_3_MIN:%.*]], label [[TRAP]]
; CHECK:       check.3.min:
; CHECK-NEXT:    [[L0:%.*]] = load i32, i32* [[SRC]], align 4
; CHECK-NEXT:    [[ADD_PTR_I36:%.*]] = getelementptr inbounds i32, i32* [[SRC]], i64 3
; CHECK-NEXT:    [[C_3_MIN:%.*]] = icmp ult i32* [[ADD_PTR_I36]], [[MIN]]
; CHECK-NEXT:    br i1 [[C_3_MIN]], label [[TRAP]], label [[CHECK_3_MAX:%.*]]
; CHECK:       check.3.max:
; CHECK-NEXT:    [[C_3_MAX:%.*]] = icmp ult i32* [[ADD_PTR_I36]], [[MAX]]
; CHECK-NEXT:    br i1 [[C_3_MAX]], label [[CHECK_1_MIN:%.*]], label [[TRAP]]
; CHECK:       check.1.min:
; CHECK-NEXT:    [[L1:%.*]] = load i32, i32* [[ADD_PTR_I36]], align 4
; CHECK-NEXT:    [[ADD_PTR_I29:%.*]] = getelementptr inbounds i32, i32* [[SRC]], i64 1
; CHECK-NEXT:    [[C_1_MIN:%.*]] = icmp ult i32* [[ADD_PTR_I29]], [[MIN]]
; CHECK-NEXT:    br i1 [[C_1_MIN]], label [[TRAP]], label [[CHECK_1_MAX:%.*]]
; CHECK:       check.1.max:
; CHECK-NEXT:    [[C_1_MAX:%.*]] = icmp ult i32* [[ADD_PTR_I29]], [[MAX]]
; CHECK-NEXT:    br i1 [[C_1_MAX]], label [[CHECK_2_MIN:%.*]], label [[TRAP]]
; CHECK:       check.2.min:
; CHECK-NEXT:    [[L2:%.*]] = load i32, i32* [[ADD_PTR_I29]], align 4
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i32, i32* [[SRC]], i64 2
; CHECK-NEXT:    [[C_2_MIN:%.*]] = icmp ult i32* [[ADD_PTR_I]], [[MIN]]
; CHECK-NEXT:    br i1 [[C_2_MIN]], label [[TRAP]], label [[CHECK_2_MAX:%.*]]
; CHECK:       check.2.max:
; CHECK-NEXT:    [[C_2_MAX:%.*]] = icmp ult i32* [[ADD_PTR_I]], [[MAX]]
; CHECK-NEXT:    br i1 [[C_2_MAX]], label [[EXIT:%.*]], label [[TRAP]]
; CHECK:       exit:
; CHECK-NEXT:    [[L3:%.*]] = load i32, i32* [[ADD_PTR_I]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[L1]], [[L0]]
; CHECK-NEXT:    [[ADD8:%.*]] = add nsw i32 [[ADD]], [[L2]]
; CHECK-NEXT:    [[ADD9:%.*]] = add nsw i32 [[ADD8]], [[L3]]
; CHECK-NEXT:    ret i32 [[ADD9]]
;
check.0.min:
  %c.min.0 = icmp ult i32* %src, %min
  br i1 %c.min.0, label %trap, label %check.0.max

trap:                                             ; preds = %check.2.max, %check.2.min, %check.1.max, %check.1.min, %check.3.max, %check.3.min, %check.0.max, %check.0.min
  ret i32 10

check.0.max:                                      ; preds = %check.0.min
  %c.max.0 = icmp ult i32* %src, %max
  br i1 %c.max.0, label %check.3.min, label %trap

check.3.min:                                      ; preds = %check.0.max
  %l0 = load i32, i32* %src, align 4
  %add.ptr.i36 = getelementptr inbounds i32, i32* %src, i64 3
  %c.3.min = icmp ult i32* %add.ptr.i36, %min
  br i1 %c.3.min, label %trap, label %check.3.max

check.3.max:                                      ; preds = %check.3.min
  %c.3.max = icmp ult i32* %add.ptr.i36, %max
  br i1 %c.3.max, label %check.1.min, label %trap

check.1.min:                                      ; preds = %check.3.max
  %l1 = load i32, i32* %add.ptr.i36, align 4
  %add.ptr.i29 = getelementptr inbounds i32, i32* %src, i64 1
  %c.1.min = icmp ult i32* %add.ptr.i29, %min
  br i1 %c.1.min, label %trap, label %check.1.max

check.1.max:                                      ; preds = %check.1.min
  %c.1.max = icmp ult i32* %add.ptr.i29, %max
  br i1 %c.1.max, label %check.2.min, label %trap

check.2.min:                                      ; preds = %check.1.max
  %l2 = load i32, i32* %add.ptr.i29, align 4
  %add.ptr.i = getelementptr inbounds i32, i32* %src, i64 2
  %c.2.min = icmp ult i32* %add.ptr.i, %min
  br i1 %c.2.min, label %trap, label %check.2.max

check.2.max:                                      ; preds = %check.2.min
  %c.2.max = icmp ult i32* %add.ptr.i, %max
  br i1 %c.2.max, label %exit, label %trap

exit:                                             ; preds = %check.2.max
  %l3 = load i32, i32* %add.ptr.i, align 4
  %add = add nsw i32 %l1, %l0
  %add8 = add nsw i32 %add, %l2
  %add9 = add nsw i32 %add8, %l3
  ret i32 %add9
}

define void @test.not.uge.ult(i8* %start, i8* %low, i8* %high) {
; CHECK-LABEL: @test.not.uge.ult(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, i8* [[START:%.*]], i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp uge i8* [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[T_0:%.*]] = icmp ult i8* [[START]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_0]])
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 1
; CHECK-NEXT:    [[T_1:%.*]] = icmp ult i8* [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_1]])
; CHECK-NEXT:    [[START_2:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 2
; CHECK-NEXT:    [[T_2:%.*]] = icmp ult i8* [[START_2]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_2]])
; CHECK-NEXT:    [[START_3:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 3
; CHECK-NEXT:    [[T_3:%.*]] = icmp ult i8* [[START_3]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_3]])
; CHECK-NEXT:    [[START_4:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 4
; CHECK-NEXT:    [[C_4:%.*]] = icmp ult i8* [[START_4]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds i8, i8* %start, i64 3
  %c.1 = icmp uge i8* %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  ret void

if.end:                                           ; preds = %entry
  %t.0 = icmp ult i8* %start, %high
  call void @use(i1 %t.0)
  %start.1 = getelementptr inbounds i8, i8* %start, i64 1
  %t.1 = icmp ult i8* %start.1, %high
  call void @use(i1 %t.1)
  %start.2 = getelementptr inbounds i8, i8* %start, i64 2
  %t.2 = icmp ult i8* %start.2, %high
  call void @use(i1 %t.2)
  %start.3 = getelementptr inbounds i8, i8* %start, i64 3
  %t.3 = icmp ult i8* %start.3, %high
  call void @use(i1 %t.3)
  %start.4 = getelementptr inbounds i8, i8* %start, i64 4
  %c.4 = icmp ult i8* %start.4, %high
  call void @use(i1 %c.4)
  ret void
}

define void @test.not.uge.ule(i8* %start, i8* %low, i8* %high) {
; CHECK-LABEL: @test.not.uge.ule(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, i8* [[START:%.*]], i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp uge i8* [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[T_0:%.*]] = icmp ule i8* [[START]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_0]])
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 1
; CHECK-NEXT:    [[T_1:%.*]] = icmp ule i8* [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_1]])
; CHECK-NEXT:    [[START_2:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 2
; CHECK-NEXT:    [[T_2:%.*]] = icmp ule i8* [[START_2]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_2]])
; CHECK-NEXT:    [[START_3:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 3
; CHECK-NEXT:    [[T_3:%.*]] = icmp ule i8* [[START_3]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_3]])
; CHECK-NEXT:    [[START_4:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 4
; CHECK-NEXT:    [[T_4:%.*]] = icmp ule i8* [[START_4]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[T_4]])
; CHECK-NEXT:    [[START_5:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 5
; CHECK-NEXT:    [[C_5:%.*]] = icmp ule i8* [[START_5]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds i8, i8* %start, i64 3
  %c.1 = icmp uge i8* %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  ret void

if.end:                                           ; preds = %entry
  %t.0 = icmp ule i8* %start, %high
  call void @use(i1 %t.0)
  %start.1 = getelementptr inbounds i8, i8* %start, i64 1
  %t.1 = icmp ule i8* %start.1, %high
  call void @use(i1 %t.1)
  %start.2 = getelementptr inbounds i8, i8* %start, i64 2
  %t.2 = icmp ule i8* %start.2, %high
  call void @use(i1 %t.2)
  %start.3 = getelementptr inbounds i8, i8* %start, i64 3
  %t.3 = icmp ule i8* %start.3, %high
  call void @use(i1 %t.3)
  %start.4 = getelementptr inbounds i8, i8* %start, i64 4
  %t.4 = icmp ule i8* %start.4, %high
  call void @use(i1 %t.4)

  %start.5 = getelementptr inbounds i8, i8* %start, i64 5
  %c.5 = icmp ule i8* %start.5, %high
  call void @use(i1 %c.5)

  ret void
}

define void @test.not.uge.ugt(i8* %start, i8* %low, i8* %high) {
; CHECK-LABEL: @test.not.uge.ugt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, i8* [[START:%.*]], i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp uge i8* [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[F_0:%.*]] = icmp ugt i8* [[START]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_0]])
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 1
; CHECK-NEXT:    [[F_1:%.*]] = icmp ugt i8* [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_1]])
; CHECK-NEXT:    [[START_2:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 2
; CHECK-NEXT:    [[F_2:%.*]] = icmp ugt i8* [[START_2]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_2]])
; CHECK-NEXT:    [[START_3:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 3
; CHECK-NEXT:    [[F_3:%.*]] = icmp ugt i8* [[START_3]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_3]])
; CHECK-NEXT:    [[START_4:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 4
; CHECK-NEXT:    [[F_4:%.*]] = icmp ugt i8* [[START_4]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_4]])
; CHECK-NEXT:    [[START_5:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 5
; CHECK-NEXT:    [[C_5:%.*]] = icmp ugt i8* [[START_5]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds i8, i8* %start, i64 3
  %c.1 = icmp uge i8* %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  ret void

if.end:                                           ; preds = %entry
  %f.0 = icmp ugt i8* %start, %high
  call void @use(i1 %f.0)

  %start.1 = getelementptr inbounds i8, i8* %start, i64 1
  %f.1 = icmp ugt i8* %start.1, %high
  call void @use(i1 %f.1)

  %start.2 = getelementptr inbounds i8, i8* %start, i64 2
  %f.2 = icmp ugt i8* %start.2, %high
  call void @use(i1 %f.2)

  %start.3 = getelementptr inbounds i8, i8* %start, i64 3
  %f.3 = icmp ugt i8* %start.3, %high
  call void @use(i1 %f.3)

  %start.4 = getelementptr inbounds i8, i8* %start, i64 4
  %f.4 = icmp ugt i8* %start.4, %high
  call void @use(i1 %f.4)

  %start.5 = getelementptr inbounds i8, i8* %start, i64 5
  %c.5 = icmp ugt i8* %start.5, %high
  call void @use(i1 %c.5)

  ret void
}

define void @test.not.uge.uge(i8* %start, i8* %low, i8* %high) {
; CHECK-LABEL: @test.not.uge.uge(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD_PTR_I:%.*]] = getelementptr inbounds i8, i8* [[START:%.*]], i64 3
; CHECK-NEXT:    [[C_1:%.*]] = icmp uge i8* [[ADD_PTR_I]], [[HIGH:%.*]]
; CHECK-NEXT:    br i1 [[C_1]], label [[IF_THEN:%.*]], label [[IF_END:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[F_0:%.*]] = icmp ugt i8* [[START]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_0]])
; CHECK-NEXT:    [[START_1:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 1
; CHECK-NEXT:    [[F_1:%.*]] = icmp uge i8* [[START_1]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_1]])
; CHECK-NEXT:    [[START_2:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 2
; CHECK-NEXT:    [[F_2:%.*]] = icmp uge i8* [[START_2]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_2]])
; CHECK-NEXT:    [[START_3:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 3
; CHECK-NEXT:    [[F_3:%.*]] = icmp uge i8* [[START_3]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[F_3]])
; CHECK-NEXT:    [[START_4:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 4
; CHECK-NEXT:    [[C_4:%.*]] = icmp uge i8* [[START_4]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_4]])
; CHECK-NEXT:    [[START_5:%.*]] = getelementptr inbounds i8, i8* [[START]], i64 5
; CHECK-NEXT:    [[C_5:%.*]] = icmp uge i8* [[START_5]], [[HIGH]]
; CHECK-NEXT:    call void @use(i1 [[C_5]])
; CHECK-NEXT:    ret void
;
entry:
  %add.ptr.i = getelementptr inbounds i8, i8* %start, i64 3
  %c.1 = icmp uge i8* %add.ptr.i, %high
  br i1 %c.1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  ret void

if.end:                                           ; preds = %entry
  %f.0 = icmp ugt i8* %start, %high
  call void @use(i1 %f.0)

  %start.1 = getelementptr inbounds i8, i8* %start, i64 1
  %f.1 = icmp uge i8* %start.1, %high
  call void @use(i1 %f.1)

  %start.2 = getelementptr inbounds i8, i8* %start, i64 2
  %f.2 = icmp uge i8* %start.2, %high
  call void @use(i1 %f.2)

  %start.3 = getelementptr inbounds i8, i8* %start, i64 3
  %f.3 = icmp uge i8* %start.3, %high
  call void @use(i1 %f.3)

  %start.4 = getelementptr inbounds i8, i8* %start, i64 4
  %c.4 = icmp uge i8* %start.4, %high
  call void @use(i1 %c.4)

  %start.5 = getelementptr inbounds i8, i8* %start, i64 5
  %c.5 = icmp uge i8* %start.5, %high
  call void @use(i1 %c.5)

  ret void
}


declare void @use(i1)
declare void @llvm.trap()
