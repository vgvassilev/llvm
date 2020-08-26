; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine < %s | FileCheck %s

declare void @usei32i32agg({ i32, i32 })

; If we have a phi of insertvalues, we can sink it,
; Here, we only need a PHI for inserted values.
define { i32, i32 } @test0({ i32, i32 } %agg, i32 %val_left, i32 %val_right, i1 %c) {
; CHECK-LABEL: @test0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       right:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[VAL_LEFT_PN:%.*]] = phi i32 [ [[VAL_LEFT:%.*]], [[LEFT]] ], [ [[VAL_RIGHT:%.*]], [[RIGHT]] ]
; CHECK-NEXT:    [[R:%.*]] = insertvalue { i32, i32 } [[AGG:%.*]], i32 [[VAL_LEFT_PN]], 0
; CHECK-NEXT:    ret { i32, i32 } [[R]]
;
entry:
  br i1 %c, label %left, label %right

left:
  %i0 = insertvalue { i32, i32 } %agg, i32 %val_left, 0
  br label %end

right:
  %i1 = insertvalue { i32, i32 } %agg, i32 %val_right, 0
  br label %end

end:
  %r = phi { i32, i32 } [ %i0, %left ], [ %i1, %right ]
  ret { i32, i32 } %r
}

; But only if the insertvalues have no extra uses
define { i32, i32 } @test1_extrause0({ i32, i32 } %agg, i32 %val_left, i32 %val_right, i1 %c) {
; CHECK-LABEL: @test1_extrause0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    [[I0:%.*]] = insertvalue { i32, i32 } [[AGG:%.*]], i32 [[VAL_LEFT:%.*]], 0
; CHECK-NEXT:    call void @usei32i32agg({ i32, i32 } [[I0]])
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       right:
; CHECK-NEXT:    [[I1:%.*]] = insertvalue { i32, i32 } [[AGG]], i32 [[VAL_RIGHT:%.*]], 0
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[R:%.*]] = phi { i32, i32 } [ [[I0]], [[LEFT]] ], [ [[I1]], [[RIGHT]] ]
; CHECK-NEXT:    ret { i32, i32 } [[R]]
;
entry:
  br i1 %c, label %left, label %right

left:
  %i0 = insertvalue { i32, i32 } %agg, i32 %val_left, 0
  call void  @usei32i32agg({ i32, i32 } %i0 )
  br label %end

right:
  %i1 = insertvalue { i32, i32 } %agg, i32 %val_right, 0
  br label %end

end:
  %r = phi { i32, i32 } [ %i0, %left ], [ %i1, %right ]
  ret { i32, i32 } %r
}
define { i32, i32 } @test2_extrause1({ i32, i32 } %agg, i32 %val_left, i32 %val_right, i1 %c) {
; CHECK-LABEL: @test2_extrause1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    [[I0:%.*]] = insertvalue { i32, i32 } [[AGG:%.*]], i32 [[VAL_LEFT:%.*]], 0
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       right:
; CHECK-NEXT:    [[I1:%.*]] = insertvalue { i32, i32 } [[AGG]], i32 [[VAL_RIGHT:%.*]], 0
; CHECK-NEXT:    call void @usei32i32agg({ i32, i32 } [[I1]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[R:%.*]] = phi { i32, i32 } [ [[I0]], [[LEFT]] ], [ [[I1]], [[RIGHT]] ]
; CHECK-NEXT:    ret { i32, i32 } [[R]]
;
entry:
  br i1 %c, label %left, label %right

left:
  %i0 = insertvalue { i32, i32 } %agg, i32 %val_left, 0
  br label %end

right:
  %i1 = insertvalue { i32, i32 } %agg, i32 %val_right, 0
  call void  @usei32i32agg({ i32, i32 } %i1 )
  br label %end

end:
  %r = phi { i32, i32 } [ %i0, %left ], [ %i1, %right ]
  ret { i32, i32 } %r
}
define { i32, i32 } @test3_extrause2({ i32, i32 } %agg, i32 %val_left, i32 %val_right, i1 %c) {
; CHECK-LABEL: @test3_extrause2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    [[I0:%.*]] = insertvalue { i32, i32 } [[AGG:%.*]], i32 [[VAL_LEFT:%.*]], 0
; CHECK-NEXT:    call void @usei32i32agg({ i32, i32 } [[I0]])
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       right:
; CHECK-NEXT:    [[I1:%.*]] = insertvalue { i32, i32 } [[AGG]], i32 [[VAL_RIGHT:%.*]], 0
; CHECK-NEXT:    call void @usei32i32agg({ i32, i32 } [[I1]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[R:%.*]] = phi { i32, i32 } [ [[I0]], [[LEFT]] ], [ [[I1]], [[RIGHT]] ]
; CHECK-NEXT:    ret { i32, i32 } [[R]]
;
entry:
  br i1 %c, label %left, label %right

left:
  %i0 = insertvalue { i32, i32 } %agg, i32 %val_left, 0
  call void  @usei32i32agg({ i32, i32 } %i0 )
  br label %end

right:
  %i1 = insertvalue { i32, i32 } %agg, i32 %val_right, 0
  call void  @usei32i32agg({ i32, i32 } %i1 )
  br label %end

end:
  %r = phi { i32, i32 } [ %i0, %left ], [ %i1, %right ]
  ret { i32, i32 } %r
}

; Here, we only need a PHI for base aggregate
define { i32, i32 } @test4({ i32, i32 } %agg_left, { i32, i32 } %agg_right, i32 %val, i1 %c) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       right:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[AGG_LEFT_PN:%.*]] = phi { i32, i32 } [ [[AGG_LEFT:%.*]], [[LEFT]] ], [ [[AGG_RIGHT:%.*]], [[RIGHT]] ]
; CHECK-NEXT:    [[R:%.*]] = insertvalue { i32, i32 } [[AGG_LEFT_PN]], i32 [[VAL:%.*]], 0
; CHECK-NEXT:    ret { i32, i32 } [[R]]
;
entry:
  br i1 %c, label %left, label %right

left:
  %i0 = insertvalue { i32, i32 } %agg_left, i32 %val, 0
  br label %end

right:
  %i1 = insertvalue { i32, i32 } %agg_right, i32 %val, 0
  br label %end

end:
  %r = phi { i32, i32 } [ %i0, %left ], [ %i1, %right ]
  ret { i32, i32 } %r
}

; Here, we need a PHI for both the base and the inserted value
define { i32, i32 } @test5({ i32, i32 } %agg_left, { i32, i32 } %agg_right, i32 %val_left, i32 %val_right, i1 %c) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       right:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[AGG_LEFT_PN:%.*]] = phi { i32, i32 } [ [[AGG_LEFT:%.*]], [[LEFT]] ], [ [[AGG_RIGHT:%.*]], [[RIGHT]] ]
; CHECK-NEXT:    [[VAL_LEFT_PN:%.*]] = phi i32 [ [[VAL_LEFT:%.*]], [[LEFT]] ], [ [[VAL_RIGHT:%.*]], [[RIGHT]] ]
; CHECK-NEXT:    [[R:%.*]] = insertvalue { i32, i32 } [[AGG_LEFT_PN]], i32 [[VAL_LEFT_PN]], 0
; CHECK-NEXT:    ret { i32, i32 } [[R]]
;
entry:
  br i1 %c, label %left, label %right

left:
  %i0 = insertvalue { i32, i32 } %agg_left, i32 %val_left, 0
  br label %end

right:
  %i1 = insertvalue { i32, i32 } %agg_right, i32 %val_right, 0
  br label %end

end:
  %r = phi { i32, i32 } [ %i0, %left ], [ %i1, %right ]
  ret { i32, i32 } %r
}

; But the indicies must match
define { i32, i32 } @test6({ i32, i32 } %agg, i32 %val_left, i32 %val_right, i1 %c) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    [[I0:%.*]] = insertvalue { i32, i32 } [[AGG:%.*]], i32 [[VAL_LEFT:%.*]], 0
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       right:
; CHECK-NEXT:    [[I1:%.*]] = insertvalue { i32, i32 } [[AGG]], i32 [[VAL_RIGHT:%.*]], 1
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[R:%.*]] = phi { i32, i32 } [ [[I0]], [[LEFT]] ], [ [[I1]], [[RIGHT]] ]
; CHECK-NEXT:    ret { i32, i32 } [[R]]
;
entry:
  br i1 %c, label %left, label %right

left:
  %i0 = insertvalue { i32, i32 } %agg, i32 %val_left, 0
  br label %end

right:
  %i1 = insertvalue { i32, i32 } %agg, i32 %val_right, 1
  br label %end

end:
  %r = phi { i32, i32 } [ %i0, %left ], [ %i1, %right ]
  ret { i32, i32 } %r
}

; More complex aggregates are fine, too, as long as indicies match.
define {{ i32, i32 }, { i32, i32 }} @test7({{ i32, i32 }, { i32, i32 }} %agg, i32 %val_left, i32 %val_right, i1 %c) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       right:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[VAL_LEFT_PN:%.*]] = phi i32 [ [[VAL_LEFT:%.*]], [[LEFT]] ], [ [[VAL_RIGHT:%.*]], [[RIGHT]] ]
; CHECK-NEXT:    [[R:%.*]] = insertvalue { { i32, i32 }, { i32, i32 } } [[AGG:%.*]], i32 [[VAL_LEFT_PN]], 0, 0
; CHECK-NEXT:    ret { { i32, i32 }, { i32, i32 } } [[R]]
;
entry:
  br i1 %c, label %left, label %right

left:
  %i0 = insertvalue {{ i32, i32 }, { i32, i32 }} %agg, i32 %val_left, 0, 0
  br label %end

right:
  %i1 = insertvalue {{ i32, i32 }, { i32, i32 }} %agg, i32 %val_right, 0, 0
  br label %end

end:
  %r = phi {{ i32, i32 }, { i32, i32 }} [ %i0, %left ], [ %i1, %right ]
  ret {{ i32, i32 }, { i32, i32 }} %r
}

; The indicies must fully match, on all levels.
define {{ i32, i32 }, { i32, i32 }} @test8({{ i32, i32 }, { i32, i32 }} %agg, i32 %val_left, i32 %val_right, i1 %c) {
; CHECK-LABEL: @test8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    [[I0:%.*]] = insertvalue { { i32, i32 }, { i32, i32 } } [[AGG:%.*]], i32 [[VAL_LEFT:%.*]], 0, 0
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       right:
; CHECK-NEXT:    [[I1:%.*]] = insertvalue { { i32, i32 }, { i32, i32 } } [[AGG]], i32 [[VAL_RIGHT:%.*]], 0, 1
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[R:%.*]] = phi { { i32, i32 }, { i32, i32 } } [ [[I0]], [[LEFT]] ], [ [[I1]], [[RIGHT]] ]
; CHECK-NEXT:    ret { { i32, i32 }, { i32, i32 } } [[R]]
;
entry:
  br i1 %c, label %left, label %right

left:
  %i0 = insertvalue {{ i32, i32 }, { i32, i32 }} %agg, i32 %val_left, 0, 0
  br label %end

right:
  %i1 = insertvalue {{ i32, i32 }, { i32, i32 }} %agg, i32 %val_right, 0, 1
  br label %end

end:
  %r = phi {{ i32, i32 }, { i32, i32 }} [ %i0, %left ], [ %i1, %right ]
  ret {{ i32, i32 }, { i32, i32 }} %r
}

; It is fine if there are multiple uses of the PHI's value, as long as they are all in the PHI node itself
define { i32, i32 } @test9({ i32, i32 } %agg, i32 %val_left, i32 %val_right, i1 %c0, i1 %c1) {
; CHECK-LABEL: @test9(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C0:%.*]], label [[END:%.*]], label [[DISPATCH:%.*]]
; CHECK:       dispatch:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    br label [[END]]
; CHECK:       right:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[VAL_LEFT_PN:%.*]] = phi i32 [ [[VAL_LEFT:%.*]], [[ENTRY:%.*]] ], [ [[VAL_LEFT]], [[LEFT]] ], [ [[VAL_RIGHT:%.*]], [[RIGHT]] ]
; CHECK-NEXT:    [[R:%.*]] = insertvalue { i32, i32 } [[AGG:%.*]], i32 [[VAL_LEFT_PN]], 0
; CHECK-NEXT:    ret { i32, i32 } [[R]]
;
entry:
  %i0 = insertvalue { i32, i32 } %agg, i32 %val_left, 0
  %i1 = insertvalue { i32, i32 } %agg, i32 %val_right, 0
  br i1 %c0, label %end, label %dispatch

dispatch:
  br i1 %c1, label %left, label %right

left:
  br label %end

right:
  br label %end

end:
  %r = phi { i32, i32 } [ %i0, %entry ], [ %i0, %left ], [ %i1, %right ]
  ret { i32, i32 } %r
}
; Which isn't the case here, there is a legitimate external use.
define { i32, i32 } @test10({ i32, i32 } %agg, i32 %val_left, i32 %val_right, i1 %c0, i1 %c1) {
; CHECK-LABEL: @test10(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[I0:%.*]] = insertvalue { i32, i32 } [[AGG:%.*]], i32 [[VAL_LEFT:%.*]], 0
; CHECK-NEXT:    [[I1:%.*]] = insertvalue { i32, i32 } [[AGG]], i32 [[VAL_RIGHT:%.*]], 0
; CHECK-NEXT:    call void @usei32i32agg({ i32, i32 } [[I0]])
; CHECK-NEXT:    br i1 [[C0:%.*]], label [[END:%.*]], label [[DISPATCH:%.*]]
; CHECK:       dispatch:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    br label [[END]]
; CHECK:       right:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[R:%.*]] = phi { i32, i32 } [ [[I0]], [[ENTRY:%.*]] ], [ [[I0]], [[LEFT]] ], [ [[I1]], [[RIGHT]] ]
; CHECK-NEXT:    ret { i32, i32 } [[R]]
;
entry:
  %i0 = insertvalue { i32, i32 } %agg, i32 %val_left, 0
  %i1 = insertvalue { i32, i32 } %agg, i32 %val_right, 0
  call void @usei32i32agg({ i32, i32 } %i0)
  br i1 %c0, label %end, label %dispatch

dispatch:
  br i1 %c1, label %left, label %right

left:
  br label %end

right:
  br label %end

end:
  %r = phi { i32, i32 } [ %i0, %entry ], [ %i0, %left ], [ %i1, %right ]
  ret { i32, i32 } %r
}
