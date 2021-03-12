; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -analyze -scalar-evolution %s -enable-new-pm=0 | FileCheck %s
; RUN: opt -passes='print<scalar-evolution>' -disable-output %s 2>&1 | FileCheck %s

; Test case for PR40961. The loop guard limit the max backedge-taken count.

define void @test_guard_less_than_16(i32* nocapture %a, i64 %i) {
; CHECK-LABEL: 'test_guard_less_than_16'
; CHECK-NEXT:  Classifying expressions for: @test_guard_less_than_16
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ %i, %entry ]
; CHECK-NEXT:    --> {%i,+,1}<nuw><nsw><%loop> U: full-set S: full-set Exits: 15 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {((4 * %i) + %a),+,4}<nw><%loop> U: full-set S: full-set Exits: (60 + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 1
; CHECK-NEXT:    --> {(1 + %i),+,1}<nuw><nsw><%loop> U: full-set S: full-set Exits: 16 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_guard_less_than_16
; CHECK-NEXT:  Loop %loop: backedge-taken count is (15 + (-1 * %i))
; CHECK-NEXT:  Loop %loop: max backedge-taken count is 15
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (15 + (-1 * %i))
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %cmp3 = icmp ult i64 %i, 16
  br i1 %cmp3, label %loop, label %exit

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ %i, %entry ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 16
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test_guard_less_than_16_operands_swapped(i32* nocapture %a, i64 %i) {
; CHECK-LABEL: 'test_guard_less_than_16_operands_swapped'
; CHECK-NEXT:  Classifying expressions for: @test_guard_less_than_16_operands_swapped
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ %i, %entry ]
; CHECK-NEXT:    --> {%i,+,1}<nuw><nsw><%loop> U: full-set S: full-set Exits: 15 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {((4 * %i) + %a),+,4}<nw><%loop> U: full-set S: full-set Exits: (60 + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 1
; CHECK-NEXT:    --> {(1 + %i),+,1}<nuw><nsw><%loop> U: full-set S: full-set Exits: 16 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_guard_less_than_16_operands_swapped
; CHECK-NEXT:  Loop %loop: backedge-taken count is (15 + (-1 * %i))
; CHECK-NEXT:  Loop %loop: max backedge-taken count is 15
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (15 + (-1 * %i))
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %cmp3 = icmp ugt i64 16, %i
  br i1 %cmp3, label %loop, label %exit

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ %i, %entry ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 16
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test_guard_less_than_16_branches_flipped(i32* nocapture %a, i64 %i) {
; CHECK-LABEL: 'test_guard_less_than_16_branches_flipped'
; CHECK-NEXT:  Classifying expressions for: @test_guard_less_than_16_branches_flipped
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ %i, %entry ]
; CHECK-NEXT:    --> {%i,+,1}<nuw><nsw><%loop> U: full-set S: full-set Exits: 15 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {((4 * %i) + %a),+,4}<nw><%loop> U: full-set S: full-set Exits: (60 + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 1
; CHECK-NEXT:    --> {(1 + %i),+,1}<nuw><nsw><%loop> U: full-set S: full-set Exits: 16 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_guard_less_than_16_branches_flipped
; CHECK-NEXT:  Loop %loop: backedge-taken count is (15 + (-1 * %i))
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (15 + (-1 * %i))
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %cmp3 = icmp ult i64 %i, 16
  br i1 %cmp3, label %exit, label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ %i, %entry ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 16
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test_guard_uge_16_branches_flipped(i32* nocapture %a, i64 %i) {
; CHECK-LABEL: 'test_guard_uge_16_branches_flipped'
; CHECK-NEXT:  Classifying expressions for: @test_guard_uge_16_branches_flipped
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ %i, %entry ]
; CHECK-NEXT:    --> {%i,+,1}<nuw><nsw><%loop> U: full-set S: full-set Exits: 15 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {((4 * %i) + %a),+,4}<nw><%loop> U: full-set S: full-set Exits: (60 + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 1
; CHECK-NEXT:    --> {(1 + %i),+,1}<nuw><nsw><%loop> U: full-set S: full-set Exits: 16 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_guard_uge_16_branches_flipped
; CHECK-NEXT:  Loop %loop: backedge-taken count is (15 + (-1 * %i))
; CHECK-NEXT:  Loop %loop: max backedge-taken count is 15
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (15 + (-1 * %i))
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %cmp3 = icmp uge i64 %i, 16
  br i1 %cmp3, label %exit, label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ %i, %entry ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv.next, 16
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test_guard_eq_12(i32* nocapture %a, i64 %N) {
; CHECK-LABEL: 'test_guard_eq_12'
; CHECK-NEXT:  Classifying expressions for: @test_guard_eq_12
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%loop> U: [0,13) S: [0,13) Exits: %N LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {%a,+,4}<nuw><%loop> U: full-set S: full-set Exits: ((4 * %N) + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%loop> U: [1,14) S: [1,14) Exits: (1 + %N) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_guard_eq_12
; CHECK-NEXT:  Loop %loop: backedge-taken count is %N
; CHECK-NEXT:  Loop %loop: max backedge-taken count is 12
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %N
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %c.1 = icmp eq i64 %N, 12
  br i1 %c.1, label %loop, label %exit

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, %N
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test_guard_ule_12(i32* nocapture %a, i64 %N) {
; CHECK-LABEL: 'test_guard_ule_12'
; CHECK-NEXT:  Classifying expressions for: @test_guard_ule_12
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%loop> U: [0,13) S: [0,13) Exits: %N LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {%a,+,4}<nuw><%loop> U: full-set S: full-set Exits: ((4 * %N) + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%loop> U: [1,14) S: [1,14) Exits: (1 + %N) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_guard_ule_12
; CHECK-NEXT:  Loop %loop: backedge-taken count is %N
; CHECK-NEXT:  Loop %loop: max backedge-taken count is 12
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %N
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %c.1 = icmp ule i64 %N, 12
  br i1 %c.1, label %loop, label %exit

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, %N
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test_guard_ule_12_step2(i32* nocapture %a, i64 %N) {
; CHECK-LABEL: 'test_guard_ule_12_step2'
; CHECK-NEXT:  Classifying expressions for: @test_guard_ule_12_step2
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,2}<nuw><nsw><%loop> U: [0,-9223372036854775808) S: [0,9223372036854775807) Exits: (2 * (%N /u 2))<nuw> LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {%a,+,8}<nuw><%loop> U: full-set S: full-set Exits: ((8 * (%N /u 2)) + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 2
; CHECK-NEXT:    --> {2,+,2}<nuw><%loop> U: [2,-1) S: [-9223372036854775808,9223372036854775807) Exits: (2 + (2 * (%N /u 2))<nuw>) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_guard_ule_12_step2
; CHECK-NEXT:  Loop %loop: backedge-taken count is (%N /u 2)
; CHECK-NEXT:  Loop %loop: max backedge-taken count is 9223372036854775807
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (%N /u 2)
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %c.1 = icmp ule i64 %N, 12
  br i1 %c.1, label %loop, label %exit

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 2
  %exitcond = icmp eq i64 %iv, %N
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test_multiple_const_guards_order1(i32* nocapture %a, i64 %i) {
; CHECK-LABEL: 'test_multiple_const_guards_order1'
; CHECK-NEXT:  Classifying expressions for: @test_multiple_const_guards_order1
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%loop> U: [0,10) S: [0,10) Exits: %i LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {%a,+,4}<nuw><%loop> U: full-set S: full-set Exits: ((4 * %i) + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%loop> U: [1,11) S: [1,11) Exits: (1 + %i) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_multiple_const_guards_order1
; CHECK-NEXT:  Loop %loop: backedge-taken count is %i
; CHECK-NEXT:  Loop %loop: max backedge-taken count is 9
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %i
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %c.1 = icmp ult i64 %i, 16
  br i1 %c.1, label %guardbb, label %exit

guardbb:
  %c.2 = icmp ult i64 %i, 10
  br i1 %c.2, label %loop, label %exit

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, %i
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test_multiple_const_guards_order2(i32* nocapture %a, i64 %i) {
; CHECK-LABEL: 'test_multiple_const_guards_order2'
; CHECK-NEXT:  Classifying expressions for: @test_multiple_const_guards_order2
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%loop> U: [0,10) S: [0,10) Exits: %i LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {%a,+,4}<nuw><%loop> U: full-set S: full-set Exits: ((4 * %i) + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%loop> U: [1,11) S: [1,11) Exits: (1 + %i) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_multiple_const_guards_order2
; CHECK-NEXT:  Loop %loop: backedge-taken count is %i
; CHECK-NEXT:  Loop %loop: max backedge-taken count is 9
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %i
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %c.1 = icmp ult i64 %i, 10
  br i1 %c.1, label %guardbb, label %exit

guardbb:
  %c.2 = icmp ult i64 %i, 16
  br i1 %c.2, label %loop, label %exit

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, %i
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

; TODO: Currently we miss getting the tightest max backedge-taken count (11).
define void @test_multiple_var_guards_order1(i32* nocapture %a, i64 %i, i64 %N) {
; CHECK-LABEL: 'test_multiple_var_guards_order1'
; CHECK-NEXT:  Classifying expressions for: @test_multiple_var_guards_order1
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%loop> U: [0,-9223372036854775808) S: [0,-9223372036854775808) Exits: %i LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {%a,+,4}<nuw><%loop> U: full-set S: full-set Exits: ((4 * %i) + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%loop> U: [1,0) S: [1,0) Exits: (1 + %i) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_multiple_var_guards_order1
; CHECK-NEXT:  Loop %loop: backedge-taken count is %i
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %i
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %c.1 = icmp ult i64 %N, 12
  br i1 %c.1, label %guardbb, label %exit

guardbb:
  %c.2 = icmp ult i64 %i, %N
  br i1 %c.2, label %loop, label %exit

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, %i
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

; TODO: Currently we miss getting the tightest max backedge-taken count (11).
define void @test_multiple_var_guards_order2(i32* nocapture %a, i64 %i, i64 %N) {
; CHECK-LABEL: 'test_multiple_var_guards_order2'
; CHECK-NEXT:  Classifying expressions for: @test_multiple_var_guards_order2
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%loop> U: [0,-9223372036854775808) S: [0,-9223372036854775808) Exits: %i LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {%a,+,4}<nuw><%loop> U: full-set S: full-set Exits: ((4 * %i) + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%loop> U: [1,0) S: [1,0) Exits: (1 + %i) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_multiple_var_guards_order2
; CHECK-NEXT:  Loop %loop: backedge-taken count is %i
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %i
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %c.1 = icmp ult i64 %i, %N
  br i1 %c.1, label %guardbb, label %exit

guardbb:
  %c.2 = icmp ult i64 %N, 12
  br i1 %c.2, label %loop, label %exit

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, %i
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

; The guards here reference each other in a cycle.
define void @test_multiple_var_guards_cycle(i32* nocapture %a, i64 %i, i64 %N) {
; CHECK-LABEL: 'test_multiple_var_guards_cycle'
; CHECK-NEXT:  Classifying expressions for: @test_multiple_var_guards_cycle
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%loop> U: [0,-9223372036854775808) S: [0,-9223372036854775808) Exits: %N LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %a, i64 %iv
; CHECK-NEXT:    --> {%a,+,4}<nuw><%loop> U: full-set S: full-set Exits: ((4 * %N) + %a) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw nsw i64 %iv, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%loop> U: [1,0) S: [1,0) Exits: (1 + %N) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_multiple_var_guards_cycle
; CHECK-NEXT:  Loop %loop: backedge-taken count is %N
; CHECK-NEXT:  Loop %loop: max backedge-taken count is -1
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is %N
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %c.1 = icmp ult i64 %N, %i
  br i1 %c.1, label %guardbb, label %exit

guardbb:
  %c.2 = icmp ult i64 %i, %N
  br i1 %c.2, label %loop, label %exit

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
  %idx = getelementptr inbounds i32, i32* %a, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw nsw i64 %iv, 1
  %exitcond = icmp eq i64 %iv, %N
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @test_guard_ult_ne(i32* nocapture readonly %data, i64 %count) {
; CHECK-LABEL: 'test_guard_ult_ne'
; CHECK-NEXT:  Classifying expressions for: @test_guard_ult_ne
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%loop> U: [0,4) S: [0,4) Exits: (-1 + %count) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %data, i64 %iv
; CHECK-NEXT:    --> {%data,+,4}<nuw><%loop> U: full-set S: full-set Exits: (-4 + (4 * %count) + %data) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw i64 %iv, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%loop> U: [1,5) S: [1,5) Exits: %count LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_guard_ult_ne
; CHECK-NEXT:  Loop %loop: backedge-taken count is (-1 + %count)
; CHECK-NEXT:  Loop %loop: max backedge-taken count is 3
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (-1 + %count)
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %cmp.ult = icmp ult i64 %count, 5
  br i1 %cmp.ult, label %guardbb, label %exit

guardbb:
  %cmp.ne = icmp ne i64 %count, 0
  br i1 %cmp.ne, label %loop, label %exit

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %guardbb ]
  %idx = getelementptr inbounds i32, i32* %data, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %count
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

; Test case for PR47247. Both the guard condition and the assume limit the
; max backedge-taken count.

define void @test_guard_and_assume(i32* nocapture readonly %data, i64 %count) {
; CHECK-LABEL: 'test_guard_and_assume'
; CHECK-NEXT:  Classifying expressions for: @test_guard_and_assume
; CHECK-NEXT:    %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><%loop> U: [0,4) S: [0,4) Exits: (-1 + %count) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %idx = getelementptr inbounds i32, i32* %data, i64 %iv
; CHECK-NEXT:    --> {%data,+,4}<nuw><%loop> U: full-set S: full-set Exits: (-4 + (4 * %count) + %data) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add nuw i64 %iv, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%loop> U: [1,5) S: [1,5) Exits: %count LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @test_guard_and_assume
; CHECK-NEXT:  Loop %loop: backedge-taken count is (-1 + %count)
; CHECK-NEXT:  Loop %loop: max backedge-taken count is 3
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (-1 + %count)
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  %cmp = icmp ult i64 %count, 5
  tail call void @llvm.assume(i1 %cmp)
  %cmp18.not = icmp eq i64 %count, 0
  br i1 %cmp18.not, label %exit, label %loop

loop:
  %iv = phi i64 [ %iv.next, %loop ], [ 0, %entry ]
  %idx = getelementptr inbounds i32, i32* %data, i64 %iv
  store i32 1, i32* %idx, align 4
  %iv.next = add nuw i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv.next, %count
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}

; Function Attrs: nounwind willreturn
declare void @llvm.assume(i1 noundef)

define void @guard_pessimizes_analysis(i1 %c, i32 %N) {
; CHECK-LABEL: 'guard_pessimizes_analysis'
; CHECK-NEXT:  Classifying expressions for: @guard_pessimizes_analysis
; CHECK-NEXT:    %init = phi i32 [ 2, %entry ], [ 3, %bb1 ]
; CHECK-NEXT:    --> %init U: [2,4) S: [2,4)
; CHECK-NEXT:    %iv = phi i32 [ %iv.next, %loop ], [ %init, %loop.ph ]
; CHECK-NEXT:    --> {%init,+,1}<%loop> U: [2,11) S: [2,11) Exits: 9 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %iv.next = add i32 %iv, 1
; CHECK-NEXT:    --> {(1 + %init)<nuw><nsw>,+,1}<%loop> U: [3,12) S: [3,12) Exits: 10 LoopDispositions: { %loop: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @guard_pessimizes_analysis
; CHECK-NEXT:  Loop %loop: backedge-taken count is (9 + (-1 * %init)<nsw>)<nsw>
; CHECK-NEXT:  Loop %loop: max backedge-taken count is 7
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is (9 + (-1 * %init)<nsw>)<nsw>
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %loop: Trip multiple is 1
;
entry:
  br i1 %c, label %bb1, label %guard

bb1:
  br label %guard

guard:
  %init = phi i32 [ 2, %entry ], [ 3, %bb1 ]
  %c.1 = icmp ult i32 %init, %N
  br i1 %c.1, label %loop.ph, label %exit

loop.ph:
  br label %loop

loop:
  %iv = phi i32 [ %iv.next, %loop ], [ %init, %loop.ph ]
  %iv.next = add i32 %iv, 1
  %exitcond = icmp eq i32 %iv.next, 10
  br i1 %exitcond, label %exit, label %loop

exit:
  ret void
}

define void @crash(i8* %ptr) {
; CHECK-LABEL: 'crash'
; CHECK-NEXT:  Classifying expressions for: @crash
; CHECK-NEXT:    %text.addr.5 = phi i8* [ %incdec.ptr112, %while.cond111 ], [ null, %while.body ]
; CHECK-NEXT:    --> {null,+,-1}<nw><%while.cond111> U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %while.cond111: Computable, %while.body: Variant }
; CHECK-NEXT:    %incdec.ptr112 = getelementptr inbounds i8, i8* %text.addr.5, i64 -1
; CHECK-NEXT:    --> {(-1 + null)<nuw><nsw>,+,-1}<nw><%while.cond111> U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %while.cond111: Computable, %while.body: Variant }
; CHECK-NEXT:    %lastout.2271 = phi i8* [ %incdec.ptr126, %while.body125 ], [ %ptr, %while.end117 ]
; CHECK-NEXT:    --> {%ptr,+,1}<nuw><%while.body125> U: full-set S: full-set Exits: {(-2 + null)<nuw><nsw>,+,-1}<nw><%while.cond111> LoopDispositions: { %while.body125: Computable }
; CHECK-NEXT:    %incdec.ptr126 = getelementptr inbounds i8, i8* %lastout.2271, i64 1
; CHECK-NEXT:    --> {(1 + %ptr)<nuw>,+,1}<nuw><%while.body125> U: [1,0) S: [1,0) Exits: {(-1 + null)<nuw><nsw>,+,-1}<nw><%while.cond111> LoopDispositions: { %while.body125: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @crash
; CHECK-NEXT:  Loop %while.body125: backedge-taken count is {(-2 + (-1 * %ptr) + null),+,-1}<nw><%while.cond111>
; CHECK-NEXT:  Loop %while.body125: max backedge-taken count is -1
; CHECK-NEXT:  Loop %while.body125: Predicated backedge-taken count is {(-2 + (-1 * %ptr) + null),+,-1}<nw><%while.cond111>
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %while.body125: Trip multiple is 1
; CHECK-NEXT:  Loop %while.cond111: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %while.cond111: Unpredictable max backedge-taken count.
; CHECK-NEXT:  Loop %while.cond111: Unpredictable predicated backedge-taken count.
; CHECK-NEXT:  Loop %while.body: Unpredictable backedge-taken count.
; CHECK-NEXT:  Loop %while.body: Unpredictable max backedge-taken count.
; CHECK-NEXT:  Loop %while.body: Unpredictable predicated backedge-taken count.
;
entry:
  br label %while.body

while.body:
  br label %while.cond111

while.cond111:
  %text.addr.5 = phi i8* [ %incdec.ptr112, %while.cond111 ], [ null, %while.body ]
  %incdec.ptr112 = getelementptr inbounds i8, i8* %text.addr.5, i64 -1
  br i1 false, label %while.end117, label %while.cond111

while.end117:
  %cmp118 = icmp ult i8* %ptr, %incdec.ptr112
  br i1 %cmp118, label %while.body125, label %while.cond134.preheader


while.cond134.preheader:
  br label %while.body

while.body125:
  %lastout.2271 = phi i8* [ %incdec.ptr126, %while.body125 ], [ %ptr, %while.end117 ]
  %incdec.ptr126 = getelementptr inbounds i8, i8* %lastout.2271, i64 1
  %exitcond.not = icmp eq i8* %incdec.ptr126, %incdec.ptr112
  br i1 %exitcond.not, label %while.end129, label %while.body125

while.end129:                                     ; preds = %while.body125
  ret void
}
