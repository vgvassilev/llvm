; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=arm -type-promotion -verify -S %s -o - | FileCheck %s

define i32 @test_ult_254_inc_imm(i8 zeroext %x) {
; CHECK-LABEL: @test_ult_254_inc_imm(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[X:%.*]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[ADD]], -2
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %add = add i8 %x, 1
  %cmp = icmp ult i8 %add, 254
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define i32 @test_slt_254_inc_imm(i8 signext %x) {
; CHECK-LABEL: @test_slt_254_inc_imm(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[X:%.*]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i8 [[ADD]], -2
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %add = add i8 %x, 1
  %cmp = icmp slt i8 %add, 254
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define i32 @test_ult_254_inc_var(i8 zeroext %x, i8 zeroext %y) {
; CHECK-LABEL: @test_ult_254_inc_var(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[ADD]], -2
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %add = add i8 %x, %y
  %cmp = icmp ult i8 %add, 254
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define i32 @test_sle_254_inc_var(i8 %x, i8 %y) {
; CHECK-LABEL: @test_sle_254_inc_var(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i8 [[ADD]], -2
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %add = add i8 %x, %y
  %cmp = icmp sle i8 %add, 254
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define i32 @test_ugt_1_dec_imm(i8 zeroext %x) {
; CHECK-LABEL: @test_ugt_1_dec_imm(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i8 [[X:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = sub i32 [[TMP0]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[TMP1]], 1
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %add = add i8 %x, -1
  %cmp = icmp ugt i8 %add, 1
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define i32 @test_sgt_1_dec_imm(i8 %x) {
; CHECK-LABEL: @test_sgt_1_dec_imm(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[X:%.*]], -1
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 [[ADD]], 1
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %add = add i8 %x, -1
  %cmp = icmp sgt i8 %add, 1
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define i32 @test_ugt_1_dec_var(i8 zeroext %x, i8 zeroext %y) {
; CHECK-LABEL: @test_ugt_1_dec_var(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB:%.*]] = sub i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i8 [[SUB]], 1
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %sub = sub i8 %x, %y
  %cmp = icmp ugt i8 %sub, 1
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define i32 @test_sge_1_dec_var(i8 %x, i8 %y) {
; CHECK-LABEL: @test_sge_1_dec_var(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB:%.*]] = sub i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp sge i8 [[SUB]], 1
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %sub = sub i8 %x, %y
  %cmp = icmp sge i8 %sub, 1
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define i32 @dsp_imm1(i8 zeroext %x, i8 zeroext %y) {
; CHECK-LABEL: @dsp_imm1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[X]], 7
; CHECK-NEXT:    [[SUB:%.*]] = sub i8 [[AND]], [[XOR]]
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[SUB]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[ADD]], -2
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %xor = xor i8 %x, %y
  %and = and i8 %x, 7
  %sub = sub i8 %and, %xor
  %add = add i8 %sub, 1
  %cmp = icmp ult i8 %add, 254
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define i32 @dsp_var(i8 zeroext %x, i8 zeroext %y) {
; CHECK-LABEL: @dsp_var(
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[AND:%.*]] = and i8 [[X]], 7
; CHECK-NEXT:    [[SUB:%.*]] = sub i8 [[AND]], [[XOR]]
; CHECK-NEXT:    [[MUL:%.*]] = shl nuw i8 [[X]], 1
; CHECK-NEXT:    [[ADD:%.*]] = add i8 [[SUB]], [[MUL]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[ADD]], -2
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
  %xor = xor i8 %x, %y
  %and = and i8 %x, 7
  %sub = sub i8 %and, %xor
  %mul = shl nuw i8 %x, 1
  %add = add i8 %sub, %mul
  %cmp = icmp ult i8 %add, 254
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define void @store_dsp_res(i8* %in, i8* %out, i8 %compare) {
; CHECK-LABEL: @store_dsp_res(
; CHECK-NEXT:    [[FIRST:%.*]] = getelementptr inbounds i8, i8* [[IN:%.*]], i32 0
; CHECK-NEXT:    [[SECOND:%.*]] = getelementptr inbounds i8, i8* [[IN]], i32 1
; CHECK-NEXT:    [[LD0:%.*]] = load i8, i8* [[FIRST]]
; CHECK-NEXT:    [[LD1:%.*]] = load i8, i8* [[SECOND]]
; CHECK-NEXT:    [[XOR:%.*]] = xor i8 [[LD0]], -1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i8 [[COMPARE:%.*]], [[LD1]]
; CHECK-NEXT:    [[SELECT:%.*]] = select i1 [[CMP]], i8 [[COMPARE]], i8 [[XOR]]
; CHECK-NEXT:    [[SUB:%.*]] = sub i8 [[LD0]], [[SELECT]]
; CHECK-NEXT:    store i8 [[SUB]], i8* [[OUT:%.*]], align 1
; CHECK-NEXT:    ret void
;
  %first = getelementptr inbounds i8, i8* %in, i32 0
  %second = getelementptr inbounds i8, i8* %in, i32 1
  %ld0 = load i8, i8* %first
  %ld1 = load i8, i8* %second
  %xor = xor i8 %ld0, -1
  %cmp = icmp ult i8 %compare, %ld1
  %select = select i1 %cmp, i8 %compare, i8 %xor
  %sub = sub i8 %ld0, %select
  store i8 %sub, i8* %out, align 1
  ret void
}

define i32 @ugt_1_dec_imm(i8 zeroext %x) {
; CHECK-LABEL: @ugt_1_dec_imm(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i8 [[X:%.*]] to i32
; CHECK-NEXT:    [[TMP1:%.*]] = sub i32 [[TMP0]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i32 [[TMP1]], 1
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %add = add i8 %x, -1
  %cmp = icmp ugt i8 %add, 1
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define i32 @ugt_1_dec_var(i8 zeroext %x, i8 zeroext %y) {
; CHECK-LABEL: @ugt_1_dec_var(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB:%.*]] = sub i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i8 [[SUB]], 1
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 35, i32 47
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %sub = sub i8 %x, %y
  %cmp = icmp ugt i8 %sub, 1
  %res = select i1 %cmp, i32 35, i32 47
  ret i32 %res
}

define i32 @icmp_eq_minus_one(i8* %ptr) {
; CHECK-LABEL: @icmp_eq_minus_one(
; CHECK-NEXT:    [[LOAD:%.*]] = load i8, i8* [[PTR:%.*]], align 1
; CHECK-NEXT:    [[CONV:%.*]] = zext i8 [[LOAD]] to i32
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[LOAD]], -1
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[CMP]], i32 [[CONV]], i32 -1
; CHECK-NEXT:    ret i32 [[RET]]
;
  %load = load i8, i8* %ptr, align 1
  %conv = zext i8 %load to i32
  %cmp = icmp eq i8 %load, -1
  %ret = select i1 %cmp, i32 %conv, i32 -1
  ret i32 %ret
}

define i32 @icmp_not(i16 zeroext %arg0, i16 zeroext %arg1) {
; CHECK-LABEL: @icmp_not(
; CHECK-NEXT:    [[TMP1:%.*]] = zext i16 [[ARG0:%.*]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = zext i16 [[ARG1:%.*]] to i32
; CHECK-NEXT:    [[NOT:%.*]] = xor i32 [[TMP1]], 65535
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[NOT]], [[TMP2]]
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 16, i32 32
; CHECK-NEXT:    ret i32 [[RES]]
;
  %not = xor i16 %arg0, -1
  %cmp = icmp eq i16 %not, %arg1
  %res = select i1 %cmp, i32 16, i32 32
  ret i32 %res
}

define i32 @icmp_i1(i1* %arg0, i1 zeroext %arg1, i32 %a, i32 %b) {
; CHECK-LABEL: @icmp_i1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOAD:%.*]] = load i1, i1* [[ARG0:%.*]]
; CHECK-NEXT:    [[NOT:%.*]] = xor i1 [[LOAD]], true
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i1 [[ARG1:%.*]], [[NOT]]
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 [[A:%.*]], i32 [[B:%.*]]
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %load = load i1, i1* %arg0
  %not = xor i1 %load, 1
  %cmp = icmp eq i1 %arg1, %not
  %res = select i1 %cmp, i32 %a, i32 %b
  ret i32 %res
}

define i32 @icmp_i7(i7* %arg0, i7 zeroext %arg1, i32 %a, i32 %b) {
; CHECK-LABEL: @icmp_i7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i7 [[ARG1:%.*]] to i32
; CHECK-NEXT:    [[LOAD:%.*]] = load i7, i7* [[ARG0:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = zext i7 [[LOAD]] to i32
; CHECK-NEXT:    [[ADD:%.*]] = add nuw i32 [[TMP1]], 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[TMP0]], [[ADD]]
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 [[A:%.*]], i32 [[B:%.*]]
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %load = load i7, i7* %arg0
  %add = add nuw i7 %load, 1
  %cmp = icmp ult i7 %arg1, %add
  %res = select i1 %cmp, i32 %a, i32 %b
  ret i32 %res
}

define i32 @icmp_i15(i15 zeroext %arg0, i15 zeroext %arg1) {
; CHECK-LABEL: @icmp_i15(
; CHECK-NEXT:    [[TMP1:%.*]] = zext i15 [[ARG0:%.*]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = zext i15 [[ARG1:%.*]] to i32
; CHECK-NEXT:    [[XOR:%.*]] = xor i32 [[TMP1]], 32767
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[XOR]], [[TMP2]]
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[CMP]], i32 21, i32 42
; CHECK-NEXT:    ret i32 [[RES]]
;
  %xor = xor i15 %arg0, -1
  %cmp = icmp eq i15 %xor, %arg1
  %res = select i1 %cmp, i32 21, i32 42
  ret i32 %res
}

define i32 @icmp_minus_imm(i8* %a) {
; CHECK-LABEL: @icmp_minus_imm(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, i8* [[A:%.*]], align 1
; CHECK-NEXT:    [[ADD_I:%.*]] = add i8 [[TMP0]], -7
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i8 [[ADD_I]], -5
; CHECK-NEXT:    [[CONV1:%.*]] = zext i1 [[CMP]] to i32
; CHECK-NEXT:    ret i32 [[CONV1]]
;
entry:
  %0 = load i8, i8* %a, align 1
  %add.i = add i8 %0, -7
  %cmp = icmp ugt i8 %add.i, -5
  %conv1 = zext i1 %cmp to i32
  ret i32 %conv1
}

define void @mul_with_neg_imm(i32, i32* %b) {
; CHECK-LABEL: @mul_with_neg_imm(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i32 [[TMP0:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = zext i8 [[TMP1]] to i32
; CHECK-NEXT:    [[TMP3:%.*]] = and i32 [[TMP2]], 1
; CHECK-NEXT:    [[CONV_I:%.*]] = mul nuw i32 [[TMP3]], 132
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i32 [[CONV_I]], 0
; CHECK-NEXT:    br i1 [[TOBOOL]], label [[IF_END:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    store i32 0, i32* [[B:%.*]], align 4
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    ret void
;
entry:
  %1 = trunc i32 %0 to i8
  %2 = and i8 %1, 1
  %conv.i = mul nuw i8 %2, -124
  %tobool = icmp eq i8 %conv.i, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:
  store i32 0, i32* %b, align 4
  br label %if.end

if.end:
  ret void
}
