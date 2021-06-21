; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -mtriple=aarch64 -slp-vectorizer | FileCheck %s

%struct.buf = type { [8 x i8] }

define i8 @reduce_or(%struct.buf* %a, %struct.buf* %b) {
; CHECK-LABEL: @reduce_or(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [[STRUCT_BUF:%.*]], %struct.buf* [[A:%.*]], i64 0, i32 0, i64 0
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, i8* [[ARRAYIDX]], align 1
; CHECK-NEXT:    [[ARRAYIDX3:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[B:%.*]], i64 0, i32 0, i64 0
; CHECK-NEXT:    [[TMP1:%.*]] = load i8, i8* [[ARRAYIDX3]], align 1
; CHECK-NEXT:    [[XOR12:%.*]] = xor i8 [[TMP1]], [[TMP0]]
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[A]], i64 0, i32 0, i64 1
; CHECK-NEXT:    [[TMP2:%.*]] = load i8, i8* [[ARRAYIDX_1]], align 1
; CHECK-NEXT:    [[ARRAYIDX3_1:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[B]], i64 0, i32 0, i64 1
; CHECK-NEXT:    [[TMP3:%.*]] = load i8, i8* [[ARRAYIDX3_1]], align 1
; CHECK-NEXT:    [[XOR12_1:%.*]] = xor i8 [[TMP3]], [[TMP2]]
; CHECK-NEXT:    [[OR13_1:%.*]] = or i8 [[XOR12_1]], [[XOR12]]
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[A]], i64 0, i32 0, i64 2
; CHECK-NEXT:    [[TMP4:%.*]] = load i8, i8* [[ARRAYIDX_2]], align 1
; CHECK-NEXT:    [[ARRAYIDX3_2:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[B]], i64 0, i32 0, i64 2
; CHECK-NEXT:    [[TMP5:%.*]] = load i8, i8* [[ARRAYIDX3_2]], align 1
; CHECK-NEXT:    [[XOR12_2:%.*]] = xor i8 [[TMP5]], [[TMP4]]
; CHECK-NEXT:    [[OR13_2:%.*]] = or i8 [[XOR12_2]], [[OR13_1]]
; CHECK-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[A]], i64 0, i32 0, i64 3
; CHECK-NEXT:    [[TMP6:%.*]] = load i8, i8* [[ARRAYIDX_3]], align 1
; CHECK-NEXT:    [[ARRAYIDX3_3:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[B]], i64 0, i32 0, i64 3
; CHECK-NEXT:    [[TMP7:%.*]] = load i8, i8* [[ARRAYIDX3_3]], align 1
; CHECK-NEXT:    [[XOR12_3:%.*]] = xor i8 [[TMP7]], [[TMP6]]
; CHECK-NEXT:    [[OR13_3:%.*]] = or i8 [[XOR12_3]], [[OR13_2]]
; CHECK-NEXT:    [[ARRAYIDX_4:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[A]], i64 0, i32 0, i64 4
; CHECK-NEXT:    [[TMP8:%.*]] = load i8, i8* [[ARRAYIDX_4]], align 1
; CHECK-NEXT:    [[ARRAYIDX3_4:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[B]], i64 0, i32 0, i64 4
; CHECK-NEXT:    [[TMP9:%.*]] = load i8, i8* [[ARRAYIDX3_4]], align 1
; CHECK-NEXT:    [[XOR12_4:%.*]] = xor i8 [[TMP9]], [[TMP8]]
; CHECK-NEXT:    [[OR13_4:%.*]] = or i8 [[XOR12_4]], [[OR13_3]]
; CHECK-NEXT:    [[ARRAYIDX_5:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[A]], i64 0, i32 0, i64 5
; CHECK-NEXT:    [[TMP10:%.*]] = load i8, i8* [[ARRAYIDX_5]], align 1
; CHECK-NEXT:    [[ARRAYIDX3_5:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[B]], i64 0, i32 0, i64 5
; CHECK-NEXT:    [[TMP11:%.*]] = load i8, i8* [[ARRAYIDX3_5]], align 1
; CHECK-NEXT:    [[XOR12_5:%.*]] = xor i8 [[TMP11]], [[TMP10]]
; CHECK-NEXT:    [[OR13_5:%.*]] = or i8 [[XOR12_5]], [[OR13_4]]
; CHECK-NEXT:    [[ARRAYIDX_6:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[A]], i64 0, i32 0, i64 6
; CHECK-NEXT:    [[TMP12:%.*]] = load i8, i8* [[ARRAYIDX_6]], align 1
; CHECK-NEXT:    [[ARRAYIDX3_6:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[B]], i64 0, i32 0, i64 6
; CHECK-NEXT:    [[TMP13:%.*]] = load i8, i8* [[ARRAYIDX3_6]], align 1
; CHECK-NEXT:    [[XOR12_6:%.*]] = xor i8 [[TMP13]], [[TMP12]]
; CHECK-NEXT:    [[OR13_6:%.*]] = or i8 [[XOR12_6]], [[OR13_5]]
; CHECK-NEXT:    [[ARRAYIDX_7:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[A]], i64 0, i32 0, i64 7
; CHECK-NEXT:    [[TMP14:%.*]] = load i8, i8* [[ARRAYIDX_7]], align 1
; CHECK-NEXT:    [[ARRAYIDX3_7:%.*]] = getelementptr inbounds [[STRUCT_BUF]], %struct.buf* [[B]], i64 0, i32 0, i64 7
; CHECK-NEXT:    [[TMP15:%.*]] = load i8, i8* [[ARRAYIDX3_7]], align 1
; CHECK-NEXT:    [[XOR12_7:%.*]] = xor i8 [[TMP15]], [[TMP14]]
; CHECK-NEXT:    [[OR13_7:%.*]] = or i8 [[XOR12_7]], [[OR13_6]]
; CHECK-NEXT:    ret i8 [[OR13_7]]
;
entry:
  %arrayidx = getelementptr inbounds %struct.buf, %struct.buf* %a, i64 0, i32 0, i64 0
  %0 = load i8, i8* %arrayidx, align 1
  %arrayidx3 = getelementptr inbounds %struct.buf, %struct.buf* %b, i64 0, i32 0, i64 0
  %1 = load i8, i8* %arrayidx3, align 1
  %xor12 = xor i8 %1, %0
  %arrayidx.1 = getelementptr inbounds %struct.buf, %struct.buf* %a, i64 0, i32 0, i64 1
  %2 = load i8, i8* %arrayidx.1, align 1
  %arrayidx3.1 = getelementptr inbounds %struct.buf, %struct.buf* %b, i64 0, i32 0, i64 1
  %3 = load i8, i8* %arrayidx3.1, align 1
  %xor12.1 = xor i8 %3, %2
  %or13.1 = or i8 %xor12.1, %xor12
  %arrayidx.2 = getelementptr inbounds %struct.buf, %struct.buf* %a, i64 0, i32 0, i64 2
  %4 = load i8, i8* %arrayidx.2, align 1
  %arrayidx3.2 = getelementptr inbounds %struct.buf, %struct.buf* %b, i64 0, i32 0, i64 2
  %5 = load i8, i8* %arrayidx3.2, align 1
  %xor12.2 = xor i8 %5, %4
  %or13.2 = or i8 %xor12.2, %or13.1
  %arrayidx.3 = getelementptr inbounds %struct.buf, %struct.buf* %a, i64 0, i32 0, i64 3
  %6 = load i8, i8* %arrayidx.3, align 1
  %arrayidx3.3 = getelementptr inbounds %struct.buf, %struct.buf* %b, i64 0, i32 0, i64 3
  %7 = load i8, i8* %arrayidx3.3, align 1
  %xor12.3 = xor i8 %7, %6
  %or13.3 = or i8 %xor12.3, %or13.2
  %arrayidx.4 = getelementptr inbounds %struct.buf, %struct.buf* %a, i64 0, i32 0, i64 4
  %8 = load i8, i8* %arrayidx.4, align 1
  %arrayidx3.4 = getelementptr inbounds %struct.buf, %struct.buf* %b, i64 0, i32 0, i64 4
  %9 = load i8, i8* %arrayidx3.4, align 1
  %xor12.4 = xor i8 %9, %8
  %or13.4 = or i8 %xor12.4, %or13.3
  %arrayidx.5 = getelementptr inbounds %struct.buf, %struct.buf* %a, i64 0, i32 0, i64 5
  %10 = load i8, i8* %arrayidx.5, align 1
  %arrayidx3.5 = getelementptr inbounds %struct.buf, %struct.buf* %b, i64 0, i32 0, i64 5
  %11 = load i8, i8* %arrayidx3.5, align 1
  %xor12.5 = xor i8 %11, %10
  %or13.5 = or i8 %xor12.5, %or13.4
  %arrayidx.6 = getelementptr inbounds %struct.buf, %struct.buf* %a, i64 0, i32 0, i64 6
  %12 = load i8, i8* %arrayidx.6, align 1
  %arrayidx3.6 = getelementptr inbounds %struct.buf, %struct.buf* %b, i64 0, i32 0, i64 6
  %13 = load i8, i8* %arrayidx3.6, align 1
  %xor12.6 = xor i8 %13, %12
  %or13.6 = or i8 %xor12.6, %or13.5
  %arrayidx.7 = getelementptr inbounds %struct.buf, %struct.buf* %a, i64 0, i32 0, i64 7
  %14 = load i8, i8* %arrayidx.7, align 1
  %arrayidx3.7 = getelementptr inbounds %struct.buf, %struct.buf* %b, i64 0, i32 0, i64 7
  %15 = load i8, i8* %arrayidx3.7, align 1
  %xor12.7 = xor i8 %15, %14
  %or13.7 = or i8 %xor12.7, %or13.6
  ret i8 %or13.7
}
