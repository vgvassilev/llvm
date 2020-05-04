; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; RUN: opt -attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=7 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_NPM,NOT_CGSCC_OPM,NOT_TUNIT_NPM,IS__TUNIT____,IS________OPM,IS__TUNIT_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=7 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_OPM,NOT_CGSCC_NPM,NOT_TUNIT_OPM,IS__TUNIT____,IS________NPM,IS__TUNIT_NPM
; RUN: opt -attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_NPM,IS__CGSCC____,IS________OPM,IS__CGSCC_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_OPM,IS__CGSCC____,IS________NPM,IS__CGSCC_NPM

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"

; Test cases specifically designed for "align" attribute.
; We use FIXME's to indicate problems and missing attributes.


; TEST 1
define i32* @test1(i32* align 8 %0) #0 {
; CHECK-LABEL: define {{[^@]+}}@test1
; CHECK-SAME: (i32* nofree readnone returned align 8 "no-capture-maybe-returned" [[TMP0:%.*]])
; CHECK-NEXT:    ret i32* [[TMP0]]
;
  ret i32* %0
}

; TEST 2
define i32* @test2(i32* %0) #0 {
; CHECK-LABEL: define {{[^@]+}}@test2
; CHECK-SAME: (i32* nofree readnone returned "no-capture-maybe-returned" [[TMP0:%.*]])
; CHECK-NEXT:    ret i32* [[TMP0]]
;
  ret i32* %0
}

; TEST 3
define i32* @test3(i32* align 8 %0, i32* align 4 %1, i1 %2) #0 {
; CHECK-LABEL: define {{[^@]+}}@test3
; CHECK-SAME: (i32* nofree readnone align 8 "no-capture-maybe-returned" [[TMP0:%.*]], i32* nofree readnone align 4 "no-capture-maybe-returned" [[TMP1:%.*]], i1 [[TMP2:%.*]])
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[TMP2]], i32* [[TMP0]], i32* [[TMP1]]
; CHECK-NEXT:    ret i32* [[RET]]
;
  %ret = select i1 %2, i32* %0, i32* %1
  ret i32* %ret
}

; TEST 4
define i32* @test4(i32* align 32 %0, i32* align 32 %1, i1 %2) #0 {
; CHECK-LABEL: define {{[^@]+}}@test4
; CHECK-SAME: (i32* nofree readnone align 32 "no-capture-maybe-returned" [[TMP0:%.*]], i32* nofree readnone align 32 "no-capture-maybe-returned" [[TMP1:%.*]], i1 [[TMP2:%.*]])
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[TMP2]], i32* [[TMP0]], i32* [[TMP1]]
; CHECK-NEXT:    ret i32* [[RET]]
;
  %ret = select i1 %2, i32* %0, i32* %1
  ret i32* %ret
}

; TEST 5
declare i32* @unknown()
declare align 8 i32* @align8()


define i32* @test5_1() {
; CHECK-LABEL: define {{[^@]+}}@test5_1()
; CHECK-NEXT:    [[RET:%.*]] = tail call align 8 i32* @unknown()
; CHECK-NEXT:    ret i32* [[RET]]
;
  %ret = tail call align 8 i32* @unknown()
  ret i32* %ret
}

define i32* @test5_2() {
; CHECK-LABEL: define {{[^@]+}}@test5_2()
; CHECK-NEXT:    [[RET:%.*]] = tail call align 8 i32* @align8()
; CHECK-NEXT:    ret i32* [[RET]]
;
  %ret = tail call i32* @align8()
  ret i32* %ret
}

; TEST 6
; SCC
define i32* @test6_1() #0 {
; CHECK-LABEL: define {{[^@]+}}@test6_1()
; CHECK-NEXT:    unreachable
;
  %ret = tail call i32* @test6_2()
  ret i32* %ret
}

define i32* @test6_2() #0 {
; CHECK-LABEL: define {{[^@]+}}@test6_2()
; CHECK-NEXT:    unreachable
;
  %ret = tail call i32* @test6_1()
  ret i32* %ret
}


; char a1 __attribute__((aligned(8)));
; char a2 __attribute__((aligned(16)));
;
; char* f1(char* a ){
;     return a?a:f2(&a1);
; }
; char* f2(char* a){
;     return a?f1(a):f3(&a2);
; }
;
; char* f3(char* a){
;     return a?&a1: f1(&a2);
; }

@a1 = common global i8 0, align 8
@a2 = common global i8 0, align 16

; Function Attrs: nounwind readnone ssp uwtable
define internal i8* @f1(i8* readnone %0) local_unnamed_addr #0 {
; IS__TUNIT____-LABEL: define {{[^@]+}}@f1
; IS__TUNIT____-SAME: (i8* noalias nofree nonnull readnone align 8 dereferenceable(1) "no-capture-maybe-returned" [[TMP0:%.*]]) local_unnamed_addr
; IS__TUNIT____-NEXT:    [[TMP2:%.*]] = icmp eq i8* [[TMP0]], null
; IS__TUNIT____-NEXT:    br i1 [[TMP2]], label [[TMP3:%.*]], label [[TMP5:%.*]]
; IS__TUNIT____:       3:
; IS__TUNIT____-NEXT:    [[TMP4:%.*]] = tail call align 8 i8* @f2()
; IS__TUNIT____-NEXT:    br label [[TMP5]]
; IS__TUNIT____:       5:
; IS__TUNIT____-NEXT:    [[TMP6:%.*]] = phi i8* [ [[TMP4]], [[TMP3]] ], [ [[TMP0]], [[TMP1:%.*]] ]
; IS__TUNIT____-NEXT:    ret i8* [[TMP6]]
;
; IS__CGSCC____-LABEL: define {{[^@]+}}@f1
; IS__CGSCC____-SAME: (i8* nofree nonnull readnone align 8 dereferenceable(1) "no-capture-maybe-returned" [[TMP0:%.*]]) local_unnamed_addr
; IS__CGSCC____-NEXT:    [[TMP2:%.*]] = icmp eq i8* [[TMP0]], null
; IS__CGSCC____-NEXT:    br i1 [[TMP2]], label [[TMP3:%.*]], label [[TMP5:%.*]]
; IS__CGSCC____:       3:
; IS__CGSCC____-NEXT:    [[TMP4:%.*]] = tail call align 8 i8* @f2()
; IS__CGSCC____-NEXT:    br label [[TMP5]]
; IS__CGSCC____:       5:
; IS__CGSCC____-NEXT:    [[TMP6:%.*]] = phi i8* [ [[TMP4]], [[TMP3]] ], [ [[TMP0]], [[TMP1:%.*]] ]
; IS__CGSCC____-NEXT:    ret i8* [[TMP6]]
;
  %2 = icmp eq i8* %0, null
  br i1 %2, label %3, label %5

; <label>:3:                                      ; preds = %1
  %4 = tail call i8* @f2(i8* nonnull @a1)
  %l = load i8, i8* %4
  br label %5

; <label>:5:                                      ; preds = %1, %3
  %6 = phi i8* [ %4, %3 ], [ %0, %1 ]
  ret i8* %6
}

; Function Attrs: nounwind readnone ssp uwtable
define internal i8* @f2(i8* readnone %0) local_unnamed_addr #0 {
; CHECK-LABEL: define {{[^@]+}}@f2() local_unnamed_addr
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i8* @a1, null
; CHECK-NEXT:    br i1 [[TMP1]], label [[TMP4:%.*]], label [[TMP2:%.*]]
; CHECK:       2:
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i8* @f1(i8* noalias nofree nonnull readnone align 8 dereferenceable(1) "no-capture-maybe-returned" @a1)
; CHECK-NEXT:    br label [[TMP6:%.*]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = tail call i8* @f3()
; CHECK-NEXT:    br label [[TMP6]]
; CHECK:       6:
; CHECK-NEXT:    [[TMP7:%.*]] = phi i8* [ [[TMP3]], [[TMP2]] ], [ [[TMP5]], [[TMP4]] ]
; CHECK-NEXT:    ret i8* [[TMP7]]
;
  %2 = icmp eq i8* %0, null
  br i1 %2, label %5, label %3

; <label>:3:                                      ; preds = %1

  %4 = tail call i8* @f1(i8* nonnull %0)
  br label %7

; <label>:5:                                      ; preds = %1
  %6 = tail call i8* @f3(i8* nonnull @a2)
  br label %7

; <label>:7:                                      ; preds = %5, %3
  %8 = phi i8* [ %4, %3 ], [ %6, %5 ]
  ret i8* %8
}

; Function Attrs: nounwind readnone ssp uwtable
define internal i8* @f3(i8* readnone %0) local_unnamed_addr #0 {
; CHECK-LABEL: define {{[^@]+}}@f3() local_unnamed_addr
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i8* @a2, null
; CHECK-NEXT:    br i1 [[TMP1]], label [[TMP2:%.*]], label [[TMP4:%.*]]
; CHECK:       2:
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i8* @f1(i8* noalias nofree nonnull readnone align 16 dereferenceable(1) "no-capture-maybe-returned" @a2)
; CHECK-NEXT:    br label [[TMP4]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = phi i8* [ [[TMP3]], [[TMP2]] ], [ @a1, [[TMP0:%.*]] ]
; CHECK-NEXT:    ret i8* [[TMP5]]
;
  %2 = icmp eq i8* %0, null
  br i1 %2, label %3, label %5

; <label>:3:                                      ; preds = %1
  %4 = tail call i8* @f1(i8* nonnull @a2)
  br label %5

; <label>:5:                                      ; preds = %1, %3
  %6 = phi i8* [ %4, %3 ], [ @a1, %1 ]
  ret i8* %6
}

; TEST 7
; Better than IR information
define align 4 i8* @test7() #0 {
; IS__TUNIT____-LABEL: define {{[^@]+}}@test7()
; IS__TUNIT____-NEXT:    [[C:%.*]] = tail call i8* @f1(i8* noalias nofree nonnull readnone align 8 dereferenceable(1) "no-capture-maybe-returned" @a1)
; IS__TUNIT____-NEXT:    ret i8* [[C]]
;
; IS__CGSCC____-LABEL: define {{[^@]+}}@test7()
; IS__CGSCC____-NEXT:    [[C:%.*]] = tail call nonnull align 8 dereferenceable(1) i8* @f1(i8* noalias nofree nonnull readnone align 8 dereferenceable(1) @a1)
; IS__CGSCC____-NEXT:    ret i8* [[C]]
;
  %c = tail call i8* @f1(i8* align 8 dereferenceable(1) @a1)
  ret i8* %c
}

; TEST 7b
; Function Attrs: nounwind readnone ssp uwtable
define internal i8* @f1b(i8* readnone %0) local_unnamed_addr #0 {
; IS__TUNIT____-LABEL: define {{[^@]+}}@f1b
; IS__TUNIT____-SAME: (i8* noalias nofree nonnull readnone align 8 dereferenceable(1) "no-capture-maybe-returned" [[TMP0:%.*]]) local_unnamed_addr
; IS__TUNIT____-NEXT:    [[TMP2:%.*]] = icmp eq i8* [[TMP0]], null
; IS__TUNIT____-NEXT:    br i1 [[TMP2]], label [[TMP3:%.*]], label [[TMP5:%.*]]
; IS__TUNIT____:       3:
; IS__TUNIT____-NEXT:    [[TMP4:%.*]] = tail call align 8 i8* @f2b()
; IS__TUNIT____-NEXT:    [[L:%.*]] = load i8, i8* [[TMP4]], align 8
; IS__TUNIT____-NEXT:    store i8 [[L]], i8* @a1, align 8
; IS__TUNIT____-NEXT:    br label [[TMP5]]
; IS__TUNIT____:       5:
; IS__TUNIT____-NEXT:    [[TMP6:%.*]] = phi i8* [ [[TMP4]], [[TMP3]] ], [ [[TMP0]], [[TMP1:%.*]] ]
; IS__TUNIT____-NEXT:    ret i8* [[TMP6]]
;
; IS__CGSCC____-LABEL: define {{[^@]+}}@f1b
; IS__CGSCC____-SAME: (i8* nofree nonnull readnone align 8 dereferenceable(1) "no-capture-maybe-returned" [[TMP0:%.*]]) local_unnamed_addr
; IS__CGSCC____-NEXT:    [[TMP2:%.*]] = icmp eq i8* [[TMP0]], null
; IS__CGSCC____-NEXT:    br i1 [[TMP2]], label [[TMP3:%.*]], label [[TMP5:%.*]]
; IS__CGSCC____:       3:
; IS__CGSCC____-NEXT:    [[TMP4:%.*]] = tail call align 8 i8* @f2b()
; IS__CGSCC____-NEXT:    [[L:%.*]] = load i8, i8* [[TMP4]], align 8
; IS__CGSCC____-NEXT:    store i8 [[L]], i8* @a1, align 8
; IS__CGSCC____-NEXT:    br label [[TMP5]]
; IS__CGSCC____:       5:
; IS__CGSCC____-NEXT:    [[TMP6:%.*]] = phi i8* [ [[TMP4]], [[TMP3]] ], [ [[TMP0]], [[TMP1:%.*]] ]
; IS__CGSCC____-NEXT:    ret i8* [[TMP6]]
;
  %2 = icmp eq i8* %0, null
  br i1 %2, label %3, label %5

; <label>:3:                                      ; preds = %1
  %4 = tail call i8* @f2b(i8* nonnull @a1)
  %l = load i8, i8* %4
  store i8 %l, i8* @a1
  br label %5

; <label>:5:                                      ; preds = %1, %3
  %6 = phi i8* [ %4, %3 ], [ %0, %1 ]
  ret i8* %6
}

; Function Attrs: nounwind readnone ssp uwtable
define internal i8* @f2b(i8* readnone %0) local_unnamed_addr #0 {
;
; CHECK-LABEL: define {{[^@]+}}@f2b() local_unnamed_addr
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i8* @a1, null
; CHECK-NEXT:    br i1 [[TMP1]], label [[TMP4:%.*]], label [[TMP2:%.*]]
; CHECK:       2:
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i8* @f1b(i8* noalias nofree nonnull readnone align 8 dereferenceable(1) "no-capture-maybe-returned" @a1)
; CHECK-NEXT:    br label [[TMP6:%.*]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = tail call i8* @f3b()
; CHECK-NEXT:    br label [[TMP6]]
; CHECK:       6:
; CHECK-NEXT:    [[TMP7:%.*]] = phi i8* [ [[TMP3]], [[TMP2]] ], [ [[TMP5]], [[TMP4]] ]
; CHECK-NEXT:    ret i8* [[TMP7]]
;
  %2 = icmp eq i8* %0, null
  br i1 %2, label %5, label %3

; <label>:3:                                      ; preds = %1

  %4 = tail call i8* @f1b(i8* nonnull %0)
  br label %7

; <label>:5:                                      ; preds = %1
  %6 = tail call i8* @f3b(i8* nonnull @a2)
  br label %7

; <label>:7:                                      ; preds = %5, %3
  %8 = phi i8* [ %4, %3 ], [ %6, %5 ]
  ret i8* %8
}

; Function Attrs: nounwind readnone ssp uwtable
define internal i8* @f3b(i8* readnone %0) local_unnamed_addr #0 {
;
; CHECK-LABEL: define {{[^@]+}}@f3b() local_unnamed_addr
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i8* @a2, null
; CHECK-NEXT:    br i1 [[TMP1]], label [[TMP2:%.*]], label [[TMP4:%.*]]
; CHECK:       2:
; CHECK-NEXT:    [[TMP3:%.*]] = tail call i8* @f1b(i8* noalias nofree nonnull readnone align 16 dereferenceable(1) "no-capture-maybe-returned" @a2)
; CHECK-NEXT:    br label [[TMP4]]
; CHECK:       4:
; CHECK-NEXT:    [[TMP5:%.*]] = phi i8* [ [[TMP3]], [[TMP2]] ], [ @a1, [[TMP0:%.*]] ]
; CHECK-NEXT:    ret i8* [[TMP5]]
;
  %2 = icmp eq i8* %0, null
  br i1 %2, label %3, label %5

; <label>:3:                                      ; preds = %1
  %4 = tail call i8* @f1b(i8* nonnull @a2)
  br label %5

; <label>:5:                                      ; preds = %1, %3
  %6 = phi i8* [ %4, %3 ], [ @a1, %1 ]
  ret i8* %6
}

define align 4 i32* @test7b(i32* align 32 %p) #0 {
; IS__TUNIT____-LABEL: define {{[^@]+}}@test7b
; IS__TUNIT____-SAME: (i32* nofree readnone returned align 32 "no-capture-maybe-returned" [[P:%.*]])
; IS__TUNIT____-NEXT:    [[TMP1:%.*]] = tail call i8* @f1b(i8* noalias nofree nonnull readnone align 8 dereferenceable(1) "no-capture-maybe-returned" @a1)
; IS__TUNIT____-NEXT:    ret i32* [[P]]
;
; IS__CGSCC____-LABEL: define {{[^@]+}}@test7b
; IS__CGSCC____-SAME: (i32* nofree readnone returned align 32 "no-capture-maybe-returned" [[P:%.*]])
; IS__CGSCC____-NEXT:    [[TMP1:%.*]] = tail call i8* @f1b(i8* noalias nofree nonnull readnone align 8 dereferenceable(1) @a1)
; IS__CGSCC____-NEXT:    ret i32* [[P]]
;
  tail call i8* @f1b(i8* align 8 dereferenceable(1) @a1)
  ret i32* %p
}

; TEST 8
define void @test8_helper() {
; CHECK-LABEL: define {{[^@]+}}@test8_helper()
; CHECK-NEXT:    [[PTR0:%.*]] = tail call i32* @unknown()
; CHECK-NEXT:    [[PTR1:%.*]] = tail call align 4 i32* @unknown()
; CHECK-NEXT:    [[PTR2:%.*]] = tail call align 8 i32* @unknown()
; CHECK-NEXT:    tail call void @test8(i32* noalias nocapture readnone align 4 [[PTR1]], i32* noalias nocapture readnone align 4 [[PTR1]], i32* noalias nocapture readnone [[PTR0]])
; CHECK-NEXT:    tail call void @test8(i32* noalias nocapture readnone align 8 [[PTR2]], i32* noalias nocapture readnone align 4 [[PTR1]], i32* noalias nocapture readnone align 4 [[PTR1]])
; CHECK-NEXT:    tail call void @test8(i32* noalias nocapture readnone align 8 [[PTR2]], i32* noalias nocapture readnone align 4 [[PTR1]], i32* noalias nocapture readnone align 4 [[PTR1]])
; CHECK-NEXT:    ret void
;
  %ptr0 = tail call i32* @unknown()
  %ptr1 = tail call align 4 i32* @unknown()
  %ptr2 = tail call align 8 i32* @unknown()

  tail call void @test8(i32* %ptr1, i32* %ptr1, i32* %ptr0)
  tail call void @test8(i32* %ptr2, i32* %ptr1, i32* %ptr1)
  tail call void @test8(i32* %ptr2, i32* %ptr1, i32* %ptr1)
  ret void
}

declare void @user_i32_ptr(i32* nocapture readnone) nounwind
define internal void @test8(i32* %a, i32* %b, i32* %c) {
; IS__TUNIT____-LABEL: define {{[^@]+}}@test8
; IS__TUNIT____-SAME: (i32* noalias nocapture readnone align 4 [[A:%.*]], i32* noalias nocapture readnone align 4 [[B:%.*]], i32* noalias nocapture readnone [[C:%.*]])
; IS__TUNIT____-NEXT:    call void @user_i32_ptr(i32* noalias nocapture readnone align 4 [[A]])
; IS__TUNIT____-NEXT:    call void @user_i32_ptr(i32* noalias nocapture readnone align 4 [[B]])
; IS__TUNIT____-NEXT:    call void @user_i32_ptr(i32* noalias nocapture readnone [[C]])
; IS__TUNIT____-NEXT:    ret void
;
; IS__CGSCC____-LABEL: define {{[^@]+}}@test8
; IS__CGSCC____-SAME: (i32* nocapture readnone align 4 [[A:%.*]], i32* nocapture readnone align 4 [[B:%.*]], i32* nocapture readnone [[C:%.*]])
; IS__CGSCC____-NEXT:    call void @user_i32_ptr(i32* noalias nocapture readnone align 4 [[A]])
; IS__CGSCC____-NEXT:    call void @user_i32_ptr(i32* noalias nocapture readnone align 4 [[B]])
; IS__CGSCC____-NEXT:    call void @user_i32_ptr(i32* noalias nocapture readnone [[C]])
; IS__CGSCC____-NEXT:    ret void
;
  call void @user_i32_ptr(i32* %a)
  call void @user_i32_ptr(i32* %b)
  call void @user_i32_ptr(i32* %c)
  ret void
}

declare void @test9_helper(i32* %A)
define void @test9_traversal(i1 %cnd, i32* align 4 %B, i32* align 8 %C) {
; CHECK-LABEL: define {{[^@]+}}@test9_traversal
; CHECK-SAME: (i1 [[CND:%.*]], i32* align 4 [[B:%.*]], i32* align 8 [[C:%.*]])
; CHECK-NEXT:    [[SEL:%.*]] = select i1 [[CND]], i32* [[B]], i32* [[C]]
; CHECK-NEXT:    call void @test9_helper(i32* align 4 [[SEL]])
; CHECK-NEXT:    ret void
;
  %sel = select i1 %cnd, i32* %B, i32* %C
  call void @test9_helper(i32* %sel)
  ret void
}

; FIXME: This will work with an upcoming patch (D66618 or similar)
;             define align 32 i32* @test10a(i32* align 32 "no-capture-maybe-returned" %p)
; FIXME: This will work with an upcoming patch (D66618 or similar)
;             store i32 1, i32* %r, align 32
; FIXME: This will work with an upcoming patch (D66618 or similar)
;             store i32 -1, i32* %g1, align 32
define i32* @test10a(i32* align 32 %p) {
; CHECK-LABEL: define {{[^@]+}}@test10a
; CHECK-SAME: (i32* nofree nonnull align 32 dereferenceable(4) "no-capture-maybe-returned" [[P:%.*]])
; CHECK-NEXT:    [[L:%.*]] = load i32, i32* [[P]], align 32
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[L]], 0
; CHECK-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       t:
; CHECK-NEXT:    [[R:%.*]] = call i32* @test10a(i32* nofree nonnull align 32 dereferenceable(4) "no-capture-maybe-returned" [[P]])
; CHECK-NEXT:    store i32 1, i32* [[R]]
; CHECK-NEXT:    [[G0:%.*]] = getelementptr i32, i32* [[P]], i32 8
; CHECK-NEXT:    br label [[E:%.*]]
; CHECK:       f:
; CHECK-NEXT:    [[G1:%.*]] = getelementptr i32, i32* [[P]], i32 8
; CHECK-NEXT:    store i32 -1, i32* [[G1]], align 4
; CHECK-NEXT:    br label [[E]]
; CHECK:       e:
; CHECK-NEXT:    [[PHI:%.*]] = phi i32* [ [[G0]], [[T]] ], [ [[G1]], [[F]] ]
; CHECK-NEXT:    ret i32* [[PHI]]
;
  %l = load i32, i32* %p
  %c = icmp eq i32 %l, 0
  br i1 %c, label %t, label %f
t:
  %r = call i32* @test10a(i32* %p)
  store i32 1, i32* %r
  %g0 = getelementptr i32, i32* %p, i32 8
  br label %e
f:
  %g1 = getelementptr i32, i32* %p, i32 8
  store i32 -1, i32* %g1
  br label %e
e:
  %phi = phi i32* [%g0, %t], [%g1, %f]
  ret i32* %phi
}

; FIXME: This will work with an upcoming patch (D66618 or similar)
;             define align 32 i32* @test10b(i32* align 32 "no-capture-maybe-returned" %p)
; FIXME: This will work with an upcoming patch (D66618 or similar)
;             store i32 1, i32* %r, align 32
; FIXME: This will work with an upcoming patch (D66618 or similar)
;             store i32 -1, i32* %g1, align 32
define i32* @test10b(i32* align 32 %p) {
; CHECK-LABEL: define {{[^@]+}}@test10b
; CHECK-SAME: (i32* nofree nonnull align 32 dereferenceable(4) "no-capture-maybe-returned" [[P:%.*]])
; CHECK-NEXT:    [[L:%.*]] = load i32, i32* [[P]], align 32
; CHECK-NEXT:    [[C:%.*]] = icmp eq i32 [[L]], 0
; CHECK-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       t:
; CHECK-NEXT:    [[R:%.*]] = call i32* @test10b(i32* nofree nonnull align 32 dereferenceable(4) "no-capture-maybe-returned" [[P]])
; CHECK-NEXT:    store i32 1, i32* [[R]]
; CHECK-NEXT:    [[G0:%.*]] = getelementptr i32, i32* [[P]], i32 8
; CHECK-NEXT:    br label [[E:%.*]]
; CHECK:       f:
; CHECK-NEXT:    [[G1:%.*]] = getelementptr i32, i32* [[P]], i32 -8
; CHECK-NEXT:    store i32 -1, i32* [[G1]], align 4
; CHECK-NEXT:    br label [[E]]
; CHECK:       e:
; CHECK-NEXT:    [[PHI:%.*]] = phi i32* [ [[G0]], [[T]] ], [ [[G1]], [[F]] ]
; CHECK-NEXT:    ret i32* [[PHI]]
;
  %l = load i32, i32* %p
  %c = icmp eq i32 %l, 0
  br i1 %c, label %t, label %f
t:
  %r = call i32* @test10b(i32* %p)
  store i32 1, i32* %r
  %g0 = getelementptr i32, i32* %p, i32 8
  br label %e
f:
  %g1 = getelementptr i32, i32* %p, i32 -8
  store i32 -1, i32* %g1
  br label %e
e:
  %phi = phi i32* [%g0, %t], [%g1, %f]
  ret i32* %phi
}


define i64 @test11(i32* %p) {
; CHECK-LABEL: define {{[^@]+}}@test11
; CHECK-SAME: (i32* nocapture nofree nonnull readonly align 8 dereferenceable(8) [[P:%.*]])
; CHECK-NEXT:    [[P_CAST:%.*]] = bitcast i32* [[P]] to i64*
; CHECK-NEXT:    [[RET:%.*]] = load i64, i64* [[P_CAST]], align 8
; CHECK-NEXT:    ret i64 [[RET]]
;
  %p-cast = bitcast i32* %p to i64*
  %ret = load i64, i64* %p-cast, align 8
  ret i64 %ret
}

; TEST 12
; Test for deduction using must-be-executed-context and GEP instruction

; FXIME: %p should have nonnull
define i64 @test12-1(i32* align 4 %p) {
; CHECK-LABEL: define {{[^@]+}}@test12-1
; CHECK-SAME: (i32* nocapture nofree readonly align 16 [[P:%.*]])
; CHECK-NEXT:    [[P_CAST:%.*]] = bitcast i32* [[P]] to i64*
; CHECK-NEXT:    [[ARRAYIDX0:%.*]] = getelementptr i64, i64* [[P_CAST]], i64 1
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr i64, i64* [[ARRAYIDX0]], i64 3
; CHECK-NEXT:    [[RET:%.*]] = load i64, i64* [[ARRAYIDX1]], align 16
; CHECK-NEXT:    ret i64 [[RET]]
;
  %p-cast = bitcast i32* %p to i64*
  %arrayidx0 = getelementptr i64, i64* %p-cast, i64 1
  %arrayidx1 = getelementptr i64, i64* %arrayidx0, i64 3
  %ret = load i64, i64* %arrayidx1, align 16
  ret i64 %ret
}

define i64 @test12-2(i32* align 4 %p) {
; CHECK-LABEL: define {{[^@]+}}@test12-2
; CHECK-SAME: (i32* nocapture nofree nonnull readonly align 16 dereferenceable(8) [[P:%.*]])
; CHECK-NEXT:    [[P_CAST:%.*]] = bitcast i32* [[P]] to i64*
; CHECK-NEXT:    [[ARRAYIDX0:%.*]] = getelementptr i64, i64* [[P_CAST]], i64 0
; CHECK-NEXT:    [[RET:%.*]] = load i64, i64* [[ARRAYIDX0]], align 16
; CHECK-NEXT:    ret i64 [[RET]]
;
  %p-cast = bitcast i32* %p to i64*
  %arrayidx0 = getelementptr i64, i64* %p-cast, i64 0
  %ret = load i64, i64* %arrayidx0, align 16
  ret i64 %ret
}

; FXIME: %p should have nonnull
define void @test12-3(i32* align 4 %p) {
; CHECK-LABEL: define {{[^@]+}}@test12-3
; CHECK-SAME: (i32* nocapture nofree writeonly align 16 [[P:%.*]])
; CHECK-NEXT:    [[P_CAST:%.*]] = bitcast i32* [[P]] to i64*
; CHECK-NEXT:    [[ARRAYIDX0:%.*]] = getelementptr i64, i64* [[P_CAST]], i64 1
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr i64, i64* [[ARRAYIDX0]], i64 3
; CHECK-NEXT:    store i64 0, i64* [[ARRAYIDX1]], align 16
; CHECK-NEXT:    ret void
;
  %p-cast = bitcast i32* %p to i64*
  %arrayidx0 = getelementptr i64, i64* %p-cast, i64 1
  %arrayidx1 = getelementptr i64, i64* %arrayidx0, i64 3
  store i64 0, i64* %arrayidx1, align 16
  ret void
}

define void @test12-4(i32* align 4 %p) {
; CHECK-LABEL: define {{[^@]+}}@test12-4
; CHECK-SAME: (i32* nocapture nofree nonnull writeonly align 16 dereferenceable(8) [[P:%.*]])
; CHECK-NEXT:    [[P_CAST:%.*]] = bitcast i32* [[P]] to i64*
; CHECK-NEXT:    [[ARRAYIDX0:%.*]] = getelementptr i64, i64* [[P_CAST]], i64 0
; CHECK-NEXT:    store i64 0, i64* [[ARRAYIDX0]], align 16
; CHECK-NEXT:    ret void
;
  %p-cast = bitcast i32* %p to i64*
  %arrayidx0 = getelementptr i64, i64* %p-cast, i64 0
  store i64 0, i64* %arrayidx0, align 16
  ret void
}

declare void @use(i64*) willreturn nounwind

define void @test12-5(i32* align 4 %p) {
; CHECK-LABEL: define {{[^@]+}}@test12-5
; CHECK-SAME: (i32* align 16 [[P:%.*]])
; CHECK-NEXT:    [[P_CAST:%.*]] = bitcast i32* [[P]] to i64*
; CHECK-NEXT:    [[ARRAYIDX0:%.*]] = getelementptr i64, i64* [[P_CAST]], i64 1
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr i64, i64* [[ARRAYIDX0]], i64 3
; CHECK-NEXT:    tail call void @use(i64* align 16 [[ARRAYIDX1]])
; CHECK-NEXT:    ret void
;
  %p-cast = bitcast i32* %p to i64*
  %arrayidx0 = getelementptr i64, i64* %p-cast, i64 1
  %arrayidx1 = getelementptr i64, i64* %arrayidx0, i64 3
  tail call void @use(i64* align 16 %arrayidx1)
  ret void
}

define void @test12-6(i32* align 4 %p) {
; CHECK-LABEL: define {{[^@]+}}@test12-6
; CHECK-SAME: (i32* align 16 [[P:%.*]])
; CHECK-NEXT:    [[P_CAST:%.*]] = bitcast i32* [[P]] to i64*
; CHECK-NEXT:    [[ARRAYIDX0:%.*]] = getelementptr i64, i64* [[P_CAST]], i64 0
; CHECK-NEXT:    tail call void @use(i64* align 16 [[ARRAYIDX0]])
; CHECK-NEXT:    ret void
;
  %p-cast = bitcast i32* %p to i64*
  %arrayidx0 = getelementptr i64, i64* %p-cast, i64 0
  tail call void @use(i64* align 16 %arrayidx0)
  ret void
}

define void @test13(i1 %c, i32* align 32 %dst) #0 {
; CHECK-LABEL: define {{[^@]+}}@test13
; CHECK-SAME: (i1 [[C:%.*]], i32* nocapture nofree writeonly align 32 [[DST:%.*]])
; CHECK-NEXT:    br i1 [[C]], label [[TRUEBB:%.*]], label [[FALSEBB:%.*]]
; CHECK:       truebb:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       falsebb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[PTR:%.*]] = phi i32* [ [[DST]], [[TRUEBB]] ], [ null, [[FALSEBB]] ]
; CHECK-NEXT:    store i32 0, i32* [[PTR]], align 32
; CHECK-NEXT:    ret void
;
  br i1 %c, label %truebb, label %falsebb
truebb:
  br label %end
falsebb:
  br label %end
end:
  %ptr = phi i32* [ %dst, %truebb ], [ null, %falsebb ]
  store i32 0, i32* %ptr
  ret void
}

define void @test13-1(i1 %c, i32* align 32 %dst) {
; CHECK-LABEL: define {{[^@]+}}@test13-1
; CHECK-SAME: (i1 [[C:%.*]], i32* nocapture nofree writeonly align 32 [[DST:%.*]])
; CHECK-NEXT:    br i1 [[C]], label [[TRUEBB:%.*]], label [[FALSEBB:%.*]]
; CHECK:       truebb:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       falsebb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[PTR:%.*]] = phi i32* [ [[DST]], [[TRUEBB]] ], [ inttoptr (i64 48 to i32*), [[FALSEBB]] ]
; CHECK-NEXT:    store i32 0, i32* [[PTR]], align 16
; CHECK-NEXT:    ret void
;
  br i1 %c, label %truebb, label %falsebb
truebb:
  br label %end
falsebb:
  br label %end
end:
  %ptr = phi i32* [ %dst, %truebb ], [ inttoptr (i64 48 to i32*), %falsebb ]
  store i32 0, i32* %ptr
  ret void
}

define void @test13-2(i1 %c, i32* align 32 %dst) {
; CHECK-LABEL: define {{[^@]+}}@test13-2
; CHECK-SAME: (i1 [[C:%.*]], i32* nocapture nofree writeonly align 32 [[DST:%.*]])
; CHECK-NEXT:    br i1 [[C]], label [[TRUEBB:%.*]], label [[FALSEBB:%.*]]
; CHECK:       truebb:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       falsebb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[PTR:%.*]] = phi i32* [ [[DST]], [[TRUEBB]] ], [ inttoptr (i64 160 to i32*), [[FALSEBB]] ]
; CHECK-NEXT:    store i32 0, i32* [[PTR]], align 32
; CHECK-NEXT:    ret void
;
  br i1 %c, label %truebb, label %falsebb
truebb:
  br label %end
falsebb:
  br label %end
end:
  %ptr = phi i32* [ %dst, %truebb ], [ inttoptr (i64 160 to i32*), %falsebb ]
  store i32 0, i32* %ptr
  ret void
}

define void @test13-3(i1 %c, i32* align 32 %dst) {
; CHECK-LABEL: define {{[^@]+}}@test13-3
; CHECK-SAME: (i1 [[C:%.*]], i32* nocapture nofree writeonly align 32 [[DST:%.*]])
; CHECK-NEXT:    br i1 [[C]], label [[TRUEBB:%.*]], label [[FALSEBB:%.*]]
; CHECK:       truebb:
; CHECK-NEXT:    br label [[END:%.*]]
; CHECK:       falsebb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[PTR:%.*]] = phi i32* [ [[DST]], [[TRUEBB]] ], [ inttoptr (i64 128 to i32*), [[FALSEBB]] ]
; CHECK-NEXT:    store i32 0, i32* [[PTR]], align 32
; CHECK-NEXT:    ret void
;
  br i1 %c, label %truebb, label %falsebb
truebb:
  br label %end
falsebb:
  br label %end
end:
  %ptr = phi i32* [ %dst, %truebb ], [ inttoptr (i64 128 to i32*), %falsebb ]
  store i32 0, i32* %ptr
  ret void
}

; Don't crash on ptr2int/int2ptr uses.
define i64 @ptr2int(i32* %p) {
; CHECK-LABEL: define {{[^@]+}}@ptr2int
; CHECK-SAME: (i32* nofree readnone [[P:%.*]])
; CHECK-NEXT:    [[P2I:%.*]] = ptrtoint i32* [[P]] to i64
; CHECK-NEXT:    ret i64 [[P2I]]
;
  %p2i = ptrtoint i32* %p to i64
  ret i64 %p2i
}
define i64* @int2ptr(i64 %i) {
; CHECK-LABEL: define {{[^@]+}}@int2ptr
; CHECK-SAME: (i64 [[I:%.*]])
; CHECK-NEXT:    [[I2P:%.*]] = inttoptr i64 [[I]] to i64*
; CHECK-NEXT:    ret i64* [[I2P]]
;
  %i2p = inttoptr i64 %i to i64*
  ret i64* %i2p
}

; Use the store alignment only for the pointer operand.
define void @aligned_store(i8* %Value, i8** %Ptr) {
; CHECK-LABEL: define {{[^@]+}}@aligned_store
; CHECK-SAME: (i8* nofree writeonly [[VALUE:%.*]], i8** nocapture nofree nonnull writeonly align 32 dereferenceable(8) [[PTR:%.*]])
; CHECK-NEXT:    store i8* [[VALUE]], i8** [[PTR]], align 32
; CHECK-NEXT:    ret void
;
  store i8* %Value, i8** %Ptr, align 32
  ret void
}

declare i8* @some_func(i8*)
define void @align_call_op_not_store(i8* align 2048 %arg) {
; CHECK-LABEL: define {{[^@]+}}@align_call_op_not_store
; CHECK-SAME: (i8* align 2048 [[ARG:%.*]])
; CHECK-NEXT:    [[UNKNOWN:%.*]] = call i8* @some_func(i8* align 2048 [[ARG]])
; CHECK-NEXT:    store i8 0, i8* [[UNKNOWN]]
; CHECK-NEXT:    ret void
;
  %unknown = call i8* @some_func(i8* %arg)
  store i8 0, i8* %unknown
  ret void
}
define void @align_store_after_bc(i32* align 2048 %arg) {
;
; CHECK-LABEL: define {{[^@]+}}@align_store_after_bc
; CHECK-SAME: (i32* nocapture nofree nonnull writeonly align 2048 dereferenceable(1) [[ARG:%.*]])
; CHECK-NEXT:    [[BC:%.*]] = bitcast i32* [[ARG]] to i8*
; CHECK-NEXT:    store i8 0, i8* [[BC]], align 2048
; CHECK-NEXT:    ret void
;
  %bc = bitcast i32* %arg to i8*
  store i8 0, i8* %bc
  ret void
}

; Make sure we do not annotate the callee of a must-tail call with an alignment
; we cannot also put on the caller.
@cnd = external global i1
define i32 @musttail_callee_1(i32* %p) {
; CHECK-LABEL: define {{[^@]+}}@musttail_callee_1
; CHECK-SAME: (i32* nocapture nofree nonnull readonly dereferenceable(4) [[P:%.*]])
; CHECK-NEXT:    [[V:%.*]] = load i32, i32* [[P]], align 32
; CHECK-NEXT:    ret i32 [[V]]
;
  %v = load i32, i32* %p, align 32
  ret i32 %v
}
define i32 @musttail_caller_1(i32* %p) {
; IS__TUNIT____-LABEL: define {{[^@]+}}@musttail_caller_1
; IS__TUNIT____-SAME: (i32* nocapture nofree readonly [[P:%.*]])
; IS__TUNIT____-NEXT:    [[C:%.*]] = load i1, i1* @cnd, align 1
; IS__TUNIT____-NEXT:    br i1 [[C]], label [[MT:%.*]], label [[EXIT:%.*]]
; IS__TUNIT____:       mt:
; IS__TUNIT____-NEXT:    [[V:%.*]] = musttail call i32 @musttail_callee_1(i32* nocapture nofree readonly [[P]])
; IS__TUNIT____-NEXT:    ret i32 [[V]]
; IS__TUNIT____:       exit:
; IS__TUNIT____-NEXT:    ret i32 0
;
; IS__CGSCC____-LABEL: define {{[^@]+}}@musttail_caller_1
; IS__CGSCC____-SAME: (i32* nocapture nofree readonly [[P:%.*]])
; IS__CGSCC____-NEXT:    [[C:%.*]] = load i1, i1* @cnd, align 1
; IS__CGSCC____-NEXT:    br i1 [[C]], label [[MT:%.*]], label [[EXIT:%.*]]
; IS__CGSCC____:       mt:
; IS__CGSCC____-NEXT:    [[V:%.*]] = musttail call i32 @musttail_callee_1(i32* nocapture nofree nonnull readonly dereferenceable(4) [[P]])
; IS__CGSCC____-NEXT:    ret i32 [[V]]
; IS__CGSCC____:       exit:
; IS__CGSCC____-NEXT:    ret i32 0
;
  %c = load i1, i1* @cnd
  br i1 %c, label %mt, label %exit
mt:
  %v = musttail call i32 @musttail_callee_1(i32* %p)
  ret i32 %v
exit:
  ret i32 0
}

attributes #0 = { nounwind uwtable noinline }
attributes #1 = { uwtable noinline }
attributes #2 = { "null-pointer-is-valid"="true" }
