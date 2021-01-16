; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -scoped-noalias-aa -memcpyopt < %s | FileCheck %s

; ModuleID = '<stdin>'
source_filename = "test.cpp"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-android21"

define dso_local void @_Z1ml(i64 %e) {
; CHECK-LABEL: @_Z1ml(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[L:%.*]] = alloca i8, align 1
; CHECK-NEXT:    br label [[WHILE_COND:%.*]]
; CHECK:       for.cond.while.cond.loopexit_crit_edge.us-lcssa:
; CHECK-NEXT:    br label [[WHILE_COND_LOOPEXIT:%.*]]
; CHECK:       while.cond.loopexit:
; CHECK-NEXT:    [[TMP0:%.*]] = phi i8* [ [[ADD_PTR_I:%.*]], [[FOR_COND_WHILE_COND_LOOPEXIT_CRIT_EDGE_US_LCSSA:%.*]] ], [ [[TMP1:%.*]], [[WHILE_COND]] ]
; CHECK-NEXT:    [[I_1_LCSSA:%.*]] = phi i8* [ [[I_2:%.*]], [[FOR_COND_WHILE_COND_LOOPEXIT_CRIT_EDGE_US_LCSSA]] ], [ [[I_0:%.*]], [[WHILE_COND]] ]
; CHECK-NEXT:    br label [[WHILE_COND]]
; CHECK:       while.cond:
; CHECK-NEXT:    [[TMP1]] = phi i8* [ [[L]], [[ENTRY:%.*]] ], [ [[TMP0]], [[WHILE_COND_LOOPEXIT]] ]
; CHECK-NEXT:    [[I_0]] = phi i8* [ [[L]], [[ENTRY]] ], [ [[I_1_LCSSA]], [[WHILE_COND_LOOPEXIT]] ]
; CHECK-NEXT:    br i1 undef, label [[FOR_BODY_LR_PH:%.*]], label [[WHILE_COND_LOOPEXIT]]
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[TMP2:%.*]] = phi i8* [ [[TMP1]], [[FOR_BODY_LR_PH]] ], [ [[ADD_PTR_I]], [[IF_END5:%.*]] ]
; CHECK-NEXT:    [[I_15:%.*]] = phi i8* [ [[I_0]], [[FOR_BODY_LR_PH]] ], [ [[I_2]], [[IF_END5]] ]
; CHECK-NEXT:    [[ADD_PTR_I]] = getelementptr inbounds i8, i8* [[TMP2]], i64 [[E:%.*]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i8, i8* [[TMP2]], align 1, !noalias !0
; CHECK-NEXT:    [[TMP4:%.*]] = load i8, i8* [[I_15]], align 1, !alias.scope !0
; CHECK-NEXT:    store i8 [[TMP4]], i8* [[TMP2]], align 1
; CHECK-NEXT:    br label [[_Z1DPCS_L_EXIT:%.*]]
; CHECK:       _Z1dPcS_l.exit:
; CHECK-NEXT:    br i1 undef, label [[IF_THEN3:%.*]], label [[IF_END5]]
; CHECK:       if.then3:
; CHECK-NEXT:    [[ADD_PTR4:%.*]] = getelementptr inbounds i8, i8* [[I_15]], i64 [[E]]
; CHECK-NEXT:    br label [[IF_END5]]
; CHECK:       if.end5:
; CHECK-NEXT:    [[I_2]] = phi i8* [ [[ADD_PTR4]], [[IF_THEN3]] ], [ [[I_15]], [[_Z1DPCS_L_EXIT]] ]
; CHECK-NEXT:    br i1 false, label [[FOR_BODY]], label [[FOR_COND_WHILE_COND_LOOPEXIT_CRIT_EDGE_US_LCSSA]]
;
entry:
  %l = alloca i8, align 1
  br label %while.cond

for.cond.while.cond.loopexit_crit_edge.us-lcssa:  ; preds = %if.end5
  br label %while.cond.loopexit

while.cond.loopexit:                              ; preds = %while.cond, %for.cond.while.cond.loopexit_crit_edge.us-lcssa
  %0 = phi i8* [ %add.ptr.i, %for.cond.while.cond.loopexit_crit_edge.us-lcssa ], [ %1, %while.cond ]
  %i.1.lcssa = phi i8* [ %i.2, %for.cond.while.cond.loopexit_crit_edge.us-lcssa ], [ %i.0, %while.cond ]
  br label %while.cond

while.cond:                                       ; preds = %while.cond.loopexit, %entry
  %1 = phi i8* [ %l, %entry ], [ %0, %while.cond.loopexit ]
  %i.0 = phi i8* [ %l, %entry ], [ %i.1.lcssa, %while.cond.loopexit ]
  br i1 undef, label %for.body.lr.ph, label %while.cond.loopexit

for.body.lr.ph:                                   ; preds = %while.cond
  br label %for.body

for.body:                                         ; preds = %if.end5, %for.body.lr.ph
  %2 = phi i8* [ %1, %for.body.lr.ph ], [ %add.ptr.i, %if.end5 ]
  %i.15 = phi i8* [ %i.0, %for.body.lr.ph ], [ %i.2, %if.end5 ]
  %add.ptr.i = getelementptr inbounds i8, i8* %2, i64 %e
  %3 = load i8, i8* %2, align 1, !noalias !0
  %4 = load i8, i8* %i.15, align 1, !alias.scope !0
  store i8 %4, i8* %2, align 1
  br label %_Z1dPcS_l.exit

_Z1dPcS_l.exit:                                   ; preds = %for.body
  br i1 undef, label %if.then3, label %if.end5

if.then3:                                         ; preds = %_Z1dPcS_l.exit
  %add.ptr4 = getelementptr inbounds i8, i8* %i.15, i64 %e
  br label %if.end5

if.end5:                                          ; preds = %if.then3, %_Z1dPcS_l.exit
  %i.2 = phi i8* [ %add.ptr4, %if.then3 ], [ %i.15, %_Z1dPcS_l.exit ]
  br i1 false, label %for.body, label %for.cond.while.cond.loopexit_crit_edge.us-lcssa
}

!0 = !{!1}
!1 = distinct !{!1, !2, !"_Z1dPcS_l: %h"}
!2 = distinct !{!2, !"_Z1dPcS_l"}
