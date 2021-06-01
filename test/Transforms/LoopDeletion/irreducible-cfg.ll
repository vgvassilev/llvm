; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -loop-deletion -S | FileCheck %s
; RUN: opt < %s -passes='loop(loop-deletion)' -S | FileCheck %s

; Make sure we do not get the miscompile on this test with irreducible CFG.
define i16 @test_01(i16 %j, i16 %k, i16 %recurs) {                 ; If we have %j: 1, %k: 1, %recurs: 0
; CHECK-LABEL: @test_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i16 [[RECURS:%.*]], 0
; CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[IF_END:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[CALL:%.*]] = tail call i16 @test_01(i16 0, i16 0, i16 0)
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i16 [[J:%.*]], 0
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[K_ADDR_0:%.*]] = phi i16 [ [[K:%.*]], [[IF_END]] ], [ [[K_ADDR_2:%.*]], [[BB12:%.*]] ]
; CHECK-NEXT:    [[RESULT_0:%.*]] = phi i16 [ 0, [[IF_END]] ], [ 20, [[BB12]] ]
; CHECK-NEXT:    br i1 [[CMP]], label [[BB12]], label [[BB4:%.*]]
; CHECK:       bb4:
; CHECK-NEXT:    [[K_ADDR_1:%.*]] = phi i16 [ [[K_ADDR_0]], [[BB2]] ], [ [[K_ADDR_2]], [[BB12]] ]
; CHECK-NEXT:    [[X_1:%.*]] = phi i16 [ 0, [[BB2]] ], [ 1, [[BB12]] ]
; CHECK-NEXT:    [[RESULT_1:%.*]] = phi i16 [ [[RESULT_0]], [[BB2]] ], [ 10, [[BB12]] ]
; CHECK-NEXT:    [[CMP2:%.*]] = icmp eq i16 [[K_ADDR_1]], 0
; CHECK-NEXT:    br i1 [[CMP2]], label [[BB13:%.*]], label [[BB12]]
; CHECK:       bb12:
; CHECK-NEXT:    [[K_ADDR_2]] = phi i16 [ [[K_ADDR_0]], [[BB2]] ], [ 0, [[BB4]] ]
; CHECK-NEXT:    [[X_2:%.*]] = phi i16 [ 1, [[BB2]] ], [ [[X_1]], [[BB4]] ]
; CHECK-NEXT:    [[CMP5:%.*]] = icmp eq i16 [[X_2]], 0
; CHECK-NEXT:    br i1 [[CMP5]], label [[BB2]], label [[BB4]]
; CHECK:       bb13:
; CHECK-NEXT:    [[RESULT_1_LCSSA:%.*]] = phi i16 [ [[RESULT_1]], [[BB4]] ]
; CHECK-NEXT:    ret i16 [[RESULT_1_LCSSA]]
;
entry:
  %tobool.not = icmp eq i16 %recurs, 0                          ; 1
  br i1 %tobool.not, label %if.end, label %if.then              ; -> if.end

if.then:                                          ; preds = %entry
  %call = tail call i16 @test_01(i16 0, i16 0, i16 0)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %cmp = icmp eq i16 %j, 0                                      ; 0
  br label %bb2                                                 ; -> bb2

bb2:                                              ; preds = %bb12, %if.end
  %k.addr.0 = phi i16 [ %k, %if.end ], [ %k.addr.2, %bb12 ]     ; 1
  %result.0 = phi i16 [ 0, %if.end ], [ 20, %bb12 ]             ; 0
  br i1 %cmp, label %bb12, label %bb4                           ; %cmp: 0 -> bb4

bb4:                                              ; preds = %bb12, %bb2
  %k.addr.1 = phi i16 [ %k.addr.0, %bb2 ], [ %k.addr.2, %bb12 ] ; 1
  %x.1 = phi i16 [ 0, %bb2 ], [ 1, %bb12 ]                      ; 0
  %result.1 = phi i16 [ %result.0, %bb2 ], [ 10, %bb12 ]
  %cmp2 = icmp eq i16 %k.addr.1, 0                              ; 0
  br i1 %cmp2, label %bb13, label %bb12                         ; -> bb12

bb12:                                             ; preds = %bb4, %bb2
  %k.addr.2 = phi i16 [ %k.addr.0, %bb2 ], [ 0, %bb4 ]          ; 0
  %x.2 = phi i16 [ 1, %bb2 ], [ %x.1, %bb4 ]                    ; 0
  %cmp5 = icmp eq i16 %x.2, 0                                   ; 1
  br i1 %cmp5, label %bb2, label %bb4                           ; -> bb2

bb13:                                             ; preds = %bb4
  %result.1.lcssa = phi i16 [ %result.1, %bb4 ]
  ret i16 %result.1.lcssa
}

; Another nasty case of irreducible CFG. Make sure we do not crash here.
define void @test_02() {
; CHECK-LABEL: @test_02(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB17:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    ret void
; CHECK:       bb2:
; CHECK-NEXT:    unreachable
; CHECK:       bb3:
; CHECK-NEXT:    unreachable
; CHECK:       bb4:
; CHECK-NEXT:    unreachable
; CHECK:       bb5:
; CHECK-NEXT:    unreachable
; CHECK:       bb6:
; CHECK-NEXT:    unreachable
; CHECK:       bb7:
; CHECK-NEXT:    unreachable
; CHECK:       bb8:
; CHECK-NEXT:    unreachable
; CHECK:       bb9:
; CHECK-NEXT:    switch i8 undef, label [[BB13:%.*]] [
; CHECK-NEXT:    i8 3, label [[BB10:%.*]]
; CHECK-NEXT:    i8 43, label [[BB10]]
; CHECK-NEXT:    i8 37, label [[BB11:%.*]]
; CHECK-NEXT:    i8 2, label [[BB12:%.*]]
; CHECK-NEXT:    i8 4, label [[BB12]]
; CHECK-NEXT:    i8 20, label [[BB12]]
; CHECK-NEXT:    i8 42, label [[BB12]]
; CHECK-NEXT:    i8 44, label [[BB12]]
; CHECK-NEXT:    i8 54, label [[BB12]]
; CHECK-NEXT:    ]
; CHECK:       bb10:
; CHECK-NEXT:    unreachable
; CHECK:       bb11:
; CHECK-NEXT:    unreachable
; CHECK:       bb12:
; CHECK-NEXT:    br label [[BB19:%.*]]
; CHECK:       bb13:
; CHECK-NEXT:    unreachable
; CHECK:       bb14:
; CHECK-NEXT:    unreachable
; CHECK:       bb15:
; CHECK-NEXT:    unreachable
; CHECK:       bb16:
; CHECK-NEXT:    br label [[BB17]]
; CHECK:       bb17:
; CHECK-NEXT:    [[TMP:%.*]] = icmp sgt i32 0, 1
; CHECK-NEXT:    br i1 [[TMP]], label [[BB18:%.*]], label [[BB19]]
; CHECK:       bb18:
; CHECK-NEXT:    br label [[BB20:%.*]]
; CHECK:       bb19:
; CHECK-NEXT:    br label [[BB20]]
; CHECK:       bb20:
; CHECK-NEXT:    switch i8 undef, label [[BB16:%.*]] [
; CHECK-NEXT:    i8 0, label [[BB1:%.*]]
; CHECK-NEXT:    i8 1, label [[BB1]]
; CHECK-NEXT:    i8 8, label [[BB1]]
; CHECK-NEXT:    i8 9, label [[BB1]]
; CHECK-NEXT:    i8 12, label [[BB1]]
; CHECK-NEXT:    i8 13, label [[BB1]]
; CHECK-NEXT:    i8 40, label [[BB1]]
; CHECK-NEXT:    i8 41, label [[BB1]]
; CHECK-NEXT:    i8 52, label [[BB1]]
; CHECK-NEXT:    i8 53, label [[BB1]]
; CHECK-NEXT:    i8 55, label [[BB15:%.*]]
; CHECK-NEXT:    i8 15, label [[BB14:%.*]]
; CHECK-NEXT:    i8 29, label [[BB9:%.*]]
; CHECK-NEXT:    i8 37, label [[BB8:%.*]]
; CHECK-NEXT:    i8 69, label [[BB3:%.*]]
; CHECK-NEXT:    i8 89, label [[BB7:%.*]]
; CHECK-NEXT:    i8 85, label [[BB6:%.*]]
; CHECK-NEXT:    i8 81, label [[BB5:%.*]]
; CHECK-NEXT:    i8 65, label [[BB2:%.*]]
; CHECK-NEXT:    i8 73, label [[BB4:%.*]]
; CHECK-NEXT:    ]
;
bb:
  br label %bb17

bb1:                                              ; preds = %bb20, %bb20, %bb20, %bb20, %bb20, %bb20, %bb20, %bb20, %bb20, %bb20
  ret void

bb2:                                              ; preds = %bb20
  unreachable

bb3:                                              ; preds = %bb20
  unreachable

bb4:                                              ; preds = %bb20
  unreachable

bb5:                                              ; preds = %bb20
  unreachable

bb6:                                              ; preds = %bb20
  unreachable

bb7:                                              ; preds = %bb20
  unreachable

bb8:                                              ; preds = %bb20
  unreachable

bb9:                                              ; preds = %bb20
  switch i8 undef, label %bb13 [
  i8 3, label %bb10
  i8 43, label %bb10
  i8 37, label %bb11
  i8 2, label %bb12
  i8 4, label %bb12
  i8 20, label %bb12
  i8 42, label %bb12
  i8 44, label %bb12
  i8 54, label %bb12
  ]

bb10:                                             ; preds = %bb9, %bb9
  unreachable

bb11:                                             ; preds = %bb9
  unreachable

bb12:                                             ; preds = %bb9, %bb9, %bb9, %bb9, %bb9, %bb9
  br label %bb19

bb13:                                             ; preds = %bb9
  unreachable

bb14:                                             ; preds = %bb20
  unreachable

bb15:                                             ; preds = %bb20
  unreachable

bb16:                                             ; preds = %bb20
  br label %bb17

bb17:                                             ; preds = %bb16, %bb
  %tmp = icmp sgt i32 0, 1
  br i1 %tmp, label %bb18, label %bb19

bb18:                                             ; preds = %bb17
  br label %bb20

bb19:                                             ; preds = %bb17, %bb12
  br label %bb20

bb20:                                             ; preds = %bb19, %bb18
  switch i8 undef, label %bb16 [
  i8 0, label %bb1
  i8 1, label %bb1
  i8 8, label %bb1
  i8 9, label %bb1
  i8 12, label %bb1
  i8 13, label %bb1
  i8 40, label %bb1
  i8 41, label %bb1
  i8 52, label %bb1
  i8 53, label %bb1
  i8 55, label %bb15
  i8 15, label %bb14
  i8 29, label %bb9
  i8 37, label %bb8
  i8 69, label %bb3
  i8 89, label %bb7
  i8 85, label %bb6
  i8 81, label %bb5
  i8 65, label %bb2
  i8 73, label %bb4
  ]
}
