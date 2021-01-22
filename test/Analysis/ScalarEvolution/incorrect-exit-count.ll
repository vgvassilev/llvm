; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -analyze -scalar-evolution < %s -enable-new-pm=0 | FileCheck %s
; RUN: opt -passes='print<scalar-evolution>' < %s -disable-output 2>&1 | FileCheck %s

@b = dso_local global i32 5, align 4
@__const.f.g = private unnamed_addr constant [1 x [4 x i16]] [[4 x i16] [i16 1, i16 0, i16 0, i16 0]], align 2
@a = common dso_local global i32 0, align 4
@c = common dso_local global i32 0, align 4
@d = common dso_local global i32 0, align 4
@e = common dso_local global i32 0, align 4

; When inner.loop is taken as an exiting block of outer.loop, we cannot use the
; addrec of %storemerge1921.3, which is {3, +, -1}<inner.loop>, to calculate the
; exit count because it doesn't belong to outer.loop.
define dso_local i32 @f() {
; CHECK-LABEL: 'f'
; CHECK-NEXT:  Classifying expressions for: @f
; CHECK-NEXT:    %storemerge23 = phi i32 [ 3, %entry ], [ %dec16, %for.inc13.3 ]
; CHECK-NEXT:    --> {3,+,-1}<nsw><%outer.loop> U: [-2147483648,4) S: [-2147483648,4) Exits: 3 LoopDispositions: { %outer.loop: Computable, %for.cond6: Invariant, %inner.loop: Invariant }
; CHECK-NEXT:    %storemerge1921 = phi i32 [ 3, %outer.loop ], [ %dec, %for.end ]
; CHECK-NEXT:    --> {3,+,-1}<nuw><nsw><%for.cond6> U: [3,4) S: [3,4) Exits: <<Unknown>> LoopDispositions: { %for.cond6: Computable, %outer.loop: Variant }
; CHECK-NEXT:    %idxprom20 = zext i32 %storemerge1921 to i64
; CHECK-NEXT:    --> {3,+,4294967295}<nuw><nsw><%for.cond6> U: [3,4) S: [3,4) Exits: <<Unknown>> LoopDispositions: { %for.cond6: Computable, %outer.loop: Variant }
; CHECK-NEXT:    %arrayidx7 = getelementptr inbounds [1 x [4 x i16]], [1 x [4 x i16]]* @__const.f.g, i64 0, i64 0, i64 %idxprom20
; CHECK-NEXT:    --> {(6 + @__const.f.g)<nuw>,+,8589934590}<nuw><%for.cond6> U: [6,-1) S: [-9223372036854775808,9223372036854775807) Exits: <<Unknown>> LoopDispositions: { %for.cond6: Computable, %outer.loop: Variant }
; CHECK-NEXT:    %i = load i16, i16* %arrayidx7, align 2
; CHECK-NEXT:    --> %i U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %for.cond6: Variant, %outer.loop: Variant }
; CHECK-NEXT:    %storemerge1822.lcssa.ph = phi i32 [ 0, %for.cond6 ]
; CHECK-NEXT:    --> 0 U: [0,1) S: [0,1)
; CHECK-NEXT:    %storemerge1822.lcssa.ph32 = phi i32 [ 3, %inner.loop ]
; CHECK-NEXT:    --> 3 U: [3,4) S: [3,4)
; CHECK-NEXT:    %storemerge1822.lcssa = phi i32 [ %storemerge1822.lcssa.ph, %if.end.loopexit ], [ %storemerge1822.lcssa.ph32, %if.end.loopexit31 ]
; CHECK-NEXT:    --> %storemerge1822.lcssa U: [0,4) S: [0,4)
; CHECK-NEXT:    %i1 = load i32, i32* @e, align 4
; CHECK-NEXT:    --> %i1 U: full-set S: full-set
; CHECK-NEXT:    %i2 = load volatile i32, i32* @b, align 4
; CHECK-NEXT:    --> %i2 U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %for.cond6: Variant, %outer.loop: Variant }
; CHECK-NEXT:    %dec = add nsw i32 %storemerge1921, -1
; CHECK-NEXT:    --> {2,+,-1}<nsw><%for.cond6> U: [2,3) S: [2,3) Exits: <<Unknown>> LoopDispositions: { %for.cond6: Computable, %outer.loop: Variant }
; CHECK-NEXT:    %inc.lcssa.lcssa = phi i32 [ 4, %for.inc13.3 ]
; CHECK-NEXT:    --> 4 U: [4,5) S: [4,5)
; CHECK-NEXT:    %retval.0 = phi i32 [ %i1, %if.end ], [ 0, %cleanup.loopexit ]
; CHECK-NEXT:    --> %retval.0 U: full-set S: full-set
; CHECK-NEXT:    %storemerge1921.3 = phi i32 [ 3, %for.end ], [ %dec.3, %for.end.3 ]
; CHECK-NEXT:    --> {3,+,-1}<nuw><nsw><%inner.loop> U: [3,4) S: [3,4) Exits: <<Unknown>> LoopDispositions: { %inner.loop: Computable, %outer.loop: Variant }
; CHECK-NEXT:    %idxprom20.3 = zext i32 %storemerge1921.3 to i64
; CHECK-NEXT:    --> {3,+,4294967295}<nuw><nsw><%inner.loop> U: [3,4) S: [3,4) Exits: <<Unknown>> LoopDispositions: { %inner.loop: Computable, %outer.loop: Variant }
; CHECK-NEXT:    %arrayidx7.3 = getelementptr inbounds [1 x [4 x i16]], [1 x [4 x i16]]* @__const.f.g, i64 0, i64 0, i64 %idxprom20.3
; CHECK-NEXT:    --> {(6 + @__const.f.g)<nuw>,+,8589934590}<nuw><%inner.loop> U: [6,-1) S: [-9223372036854775808,9223372036854775807) Exits: <<Unknown>> LoopDispositions: { %inner.loop: Computable, %outer.loop: Variant }
; CHECK-NEXT:    %i7 = load i16, i16* %arrayidx7.3, align 2
; CHECK-NEXT:    --> %i7 U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %inner.loop: Variant, %outer.loop: Variant }
; CHECK-NEXT:    %i8 = load volatile i32, i32* @b, align 4
; CHECK-NEXT:    --> %i8 U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %inner.loop: Variant, %outer.loop: Variant }
; CHECK-NEXT:    %dec.3 = add nsw i32 %storemerge1921.3, -1
; CHECK-NEXT:    --> {2,+,-1}<nsw><%inner.loop> U: [2,3) S: [2,3) Exits: <<Unknown>> LoopDispositions: { %inner.loop: Computable, %outer.loop: Variant }
; CHECK-NEXT:    %storemerge1921.lcssa25.3 = phi i32 [ %storemerge1921.3, %for.end.3 ]
; CHECK-NEXT:    --> %storemerge1921.lcssa25.3 U: [3,4) S: [3,4) Exits: <<Unknown>> LoopDispositions: { %outer.loop: Variant, %for.cond6: Invariant, %inner.loop: Invariant }
; CHECK-NEXT:    %dec16 = add nsw i32 %storemerge23, -1
; CHECK-NEXT:    --> {2,+,-1}<nw><%outer.loop> U: full-set S: full-set Exits: 2 LoopDispositions: { %outer.loop: Computable, %for.cond6: Invariant, %inner.loop: Invariant }
; CHECK-NEXT:  Determining loop execution counts for: @f
; CHECK-NEXT:  Loop %for.cond6: <multiple exits> Unpredictable backedge-taken count.
; CHECK-NEXT:    exit count for for.cond6: 0
; CHECK-NEXT:    exit count for for.end: ***COULDNOTCOMPUTE***
; CHECK-NEXT:  Loop %for.cond6: max backedge-taken count is 0
; CHECK-NEXT:  Loop %for.cond6: Unpredictable predicated backedge-taken count.
; CHECK-NEXT:  Loop %inner.loop: <multiple exits> Unpredictable backedge-taken count.
; CHECK-NEXT:    exit count for inner.loop: 0
; CHECK-NEXT:    exit count for for.end.3: ***COULDNOTCOMPUTE***
; CHECK-NEXT:  Loop %inner.loop: max backedge-taken count is 0
; CHECK-NEXT:  Loop %inner.loop: Unpredictable predicated backedge-taken count.
; CHECK-NEXT:  Loop %outer.loop: <multiple exits> backedge-taken count is 0
; CHECK-NEXT:    exit count for for.cond6: 0
; CHECK-NEXT:    exit count for inner.loop: 0
; CHECK-NEXT:    exit count for for.inc13.3: 2
; CHECK-NEXT:  Loop %outer.loop: max backedge-taken count is 0
; CHECK-NEXT:  Loop %outer.loop: Predicated backedge-taken count is 0
; CHECK-NEXT:   Predicates:
; CHECK:       Loop %outer.loop: Trip multiple is 0
;
entry:
  store i32 3, i32* @a, align 4
  br label %outer.loop

outer.loop:                              ; preds = %for.inc13.3, %entry
  %storemerge23 = phi i32 [ 3, %entry ], [ %dec16, %for.inc13.3 ]
  br label %for.cond6

for.cond6:                                        ; preds = %for.end, %outer.loop
  %storemerge1921 = phi i32 [ 3, %outer.loop ], [ %dec, %for.end ]
  %idxprom20 = zext i32 %storemerge1921 to i64
  %arrayidx7 = getelementptr inbounds [1 x [4 x i16]], [1 x [4 x i16]]* @__const.f.g, i64 0, i64 0, i64 %idxprom20
  %i = load i16, i16* %arrayidx7, align 2
  %tobool8 = icmp eq i16 %i, 0
  br i1 %tobool8, label %if.end.loopexit, label %for.end

if.end.loopexit:                                  ; preds = %for.cond6
  %storemerge1822.lcssa.ph = phi i32 [ 0, %for.cond6 ]
  br label %if.end

if.end.loopexit31:                                ; preds = %inner.loop
  %storemerge1822.lcssa.ph32 = phi i32 [ 3, %inner.loop ]
  br label %if.end

if.end:                                           ; preds = %if.end.loopexit31, %if.end.loopexit
  %storemerge1822.lcssa = phi i32 [ %storemerge1822.lcssa.ph, %if.end.loopexit ], [ %storemerge1822.lcssa.ph32, %if.end.loopexit31 ]
  store i32 %storemerge1822.lcssa, i32* @c, align 4
  store i32 2, i32* @d, align 4
  %i1 = load i32, i32* @e, align 4
  br label %cleanup

for.end:                                          ; preds = %for.cond6
  %i2 = load volatile i32, i32* @b, align 4
  %tobool9 = icmp eq i32 %i2, 0
  %dec = add nsw i32 %storemerge1921, -1
  br i1 %tobool9, label %for.cond6, label %inner.loop

cleanup.loopexit:                                 ; preds = %for.inc13.3
  %inc.lcssa.lcssa = phi i32 [ 4, %for.inc13.3 ]
  store i32 %inc.lcssa.lcssa, i32* @c, align 4
  br label %cleanup

cleanup:                                          ; preds = %cleanup.loopexit, %if.end
  %retval.0 = phi i32 [ %i1, %if.end ], [ 0, %cleanup.loopexit ]
  ret i32 %retval.0

inner.loop:                                      ; preds = %for.end.3, %for.end
  %storemerge1921.3 = phi i32 [ 3, %for.end ], [ %dec.3, %for.end.3 ]
  %idxprom20.3 = zext i32 %storemerge1921.3 to i64
  %arrayidx7.3 = getelementptr inbounds [1 x [4 x i16]], [1 x [4 x i16]]* @__const.f.g, i64 0, i64 0, i64 %idxprom20.3
  %i7 = load i16, i16* %arrayidx7.3, align 2
  %tobool8.3 = icmp eq i16 %i7, 0
  br i1 %tobool8.3, label %if.end.loopexit31, label %for.end.3

for.end.3:                                        ; preds = %inner.loop
  %i8 = load volatile i32, i32* @b, align 4
  %tobool9.3 = icmp eq i32 %i8, 0
  %dec.3 = add nsw i32 %storemerge1921.3, -1
  br i1 %tobool9.3, label %inner.loop, label %for.inc13.3

for.inc13.3:                                      ; preds = %for.end.3
  %storemerge1921.lcssa25.3 = phi i32 [ %storemerge1921.3, %for.end.3 ]
  store i32 %storemerge1921.lcssa25.3, i32* @d, align 4
  %dec16 = add nsw i32 %storemerge23, -1
  store i32 %dec16, i32* @a, align 4
  %tobool = icmp eq i32 %dec16, 0
  br i1 %tobool, label %cleanup.loopexit, label %outer.loop
}
