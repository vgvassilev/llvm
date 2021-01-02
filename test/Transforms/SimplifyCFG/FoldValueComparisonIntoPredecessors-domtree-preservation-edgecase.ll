; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -simplifycfg -simplifycfg-require-and-preserve-domtree=0 < %s | FileCheck %s

define dso_local i32 @readCBPandCoeffsFromNAL(i1 %c, i32 %x, i32 %y) local_unnamed_addr {
; CHECK-LABEL: @readCBPandCoeffsFromNAL(
; CHECK-NEXT:  if.end:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[IF_END80:%.*]], label [[IF_THEN64:%.*]]
; CHECK:       if.then64:
; CHECK-NEXT:    [[MERGE:%.*]] = phi i32 [ [[Y:%.*]], [[IF_END:%.*]] ], [ 1, [[IF_END172237:%.*]] ], [ 0, [[IF_END80]] ], [ 0, [[IF_END80]] ]
; CHECK-NEXT:    ret i32 [[MERGE]]
; CHECK:       if.end80:
; CHECK-NEXT:    switch i32 [[X:%.*]], label [[INFLOOP:%.*]] [
; CHECK-NEXT:    i32 10, label [[IF_END172237]]
; CHECK-NEXT:    i32 14, label [[IF_END172237]]
; CHECK-NEXT:    i32 9, label [[IF_THEN64]]
; CHECK-NEXT:    i32 12, label [[IF_THEN64]]
; CHECK-NEXT:    ]
; CHECK:       if.end172237:
; CHECK-NEXT:    br label [[IF_THEN64]]
; CHECK:       infloop:
; CHECK-NEXT:    br label [[INFLOOP]]
;
if.end:
  br i1 %c, label %if.end80, label %if.then64

if.then64:                                        ; preds = %if.end
  ret i32 %y

if.end80:                                         ; preds = %if.end
  switch i32 %x, label %lor.lhs.false89 [
  i32 10, label %if.end172237
  i32 14, label %if.end172237
  i32 9, label %if.end172
  ]

lor.lhs.false89:                                  ; preds = %lor.lhs.false89, %if.end80
  %cmp91 = icmp eq i32 %x, 12
  br i1 %cmp91, label %if.end172, label %lor.lhs.false89

if.end172:                                        ; preds = %lor.lhs.false89, %if.end80
  br label %if.end239

if.end172237:                                     ; preds = %if.end80, %if.end80
  br label %if.end239

if.end239:                                        ; preds = %if.end172237, %if.end172
  %cbp.0 = phi i32 [ 1, %if.end172237 ], [ 0, %if.end172 ]
  ret i32 %cbp.0
}
