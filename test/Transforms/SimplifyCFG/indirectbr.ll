; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -simplifycfg -simplifycfg-require-and-preserve-domtree=1 < %s | FileCheck %s

; SimplifyCFG should eliminate redundant indirectbr edges.

declare void @foo()
declare void @A()
declare void @B(i32)
declare void @C()

define void @indbrtest0(i8** %P, i8** %Q) {
; CHECK-LABEL: @indbrtest0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i8* blockaddress(@indbrtest0, [[BB0:%.*]]), i8** [[P:%.*]], align 8
; CHECK-NEXT:    store i8* blockaddress(@indbrtest0, [[BB1:%.*]]), i8** [[P]], align 8
; CHECK-NEXT:    store i8* blockaddress(@indbrtest0, [[BB2:%.*]]), i8** [[P]], align 8
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    [[T:%.*]] = load i8*, i8** [[Q:%.*]], align 8
; CHECK-NEXT:    indirectbr i8* [[T]], [label [[BB0]], label [[BB1]], label %BB2]
; CHECK:       BB0:
; CHECK-NEXT:    call void @A()
; CHECK-NEXT:    br label [[BB1]]
; CHECK:       common.ret:
; CHECK-NEXT:    ret void
; CHECK:       BB1:
; CHECK-NEXT:    [[X:%.*]] = phi i32 [ 0, [[BB0]] ], [ 1, [[ENTRY:%.*]] ]
; CHECK-NEXT:    call void @B(i32 [[X]])
; CHECK-NEXT:    br label [[COMMON_RET:%.*]]
; CHECK:       BB2:
; CHECK-NEXT:    call void @C()
; CHECK-NEXT:    br label [[COMMON_RET]]
;
entry:
  store i8* blockaddress(@indbrtest0, %BB0), i8** %P
  store i8* blockaddress(@indbrtest0, %BB1), i8** %P
  store i8* blockaddress(@indbrtest0, %BB2), i8** %P
  call void @foo()
  %t = load i8*, i8** %Q
  indirectbr i8* %t, [label %BB0, label %BB1, label %BB2, label %BB0, label %BB1, label %BB2]
BB0:
  call void @A()
  br label %BB1
BB1:
  %x = phi i32 [ 0, %BB0 ], [ 1, %entry ], [ 1, %entry ]
  call void @B(i32 %x)
  ret void
BB2:
  call void @C()
  ret void
}

; SimplifyCFG should convert the indirectbr into a directbr. It would be even
; better if it removed the branch altogether, but simplifycfdg currently misses
; that because the predecessor is the entry block.


define void @indbrtest1(i8** %P, i8** %Q) {
; CHECK-LABEL: @indbrtest1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i8* blockaddress(@indbrtest1, [[BB0:%.*]]), i8** [[P:%.*]], align 8
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    br label [[BB0]]
; CHECK:       BB0:
; CHECK-NEXT:    call void @A()
; CHECK-NEXT:    ret void
;
entry:
  store i8* blockaddress(@indbrtest1, %BB0), i8** %P
  call void @foo()
  %t = load i8*, i8** %Q
  indirectbr i8* %t, [label %BB0, label %BB0]
BB0:
  call void @A()
  ret void
}

; SimplifyCFG should notice that BB0 does not have its address taken and
; remove it from entry's successor list.


define void @indbrtest2(i8* %t) {
; CHECK-LABEL: @indbrtest2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    unreachable
;
entry:
  indirectbr i8* %t, [label %BB0, label %BB0]
BB0:
  ret void
}


; Make sure the blocks in the next few tests aren't trivially removable as
; successors by taking their addresses.

@anchor = constant [13 x i8*] [
  i8* blockaddress(@indbrtest3, %L1), i8* blockaddress(@indbrtest3, %L2), i8* blockaddress(@indbrtest3, %L3),
  i8* blockaddress(@indbrtest4, %L1), i8* blockaddress(@indbrtest4, %L2), i8* blockaddress(@indbrtest4, %L3),
  i8* blockaddress(@indbrtest5, %L1), i8* blockaddress(@indbrtest5, %L2), i8* blockaddress(@indbrtest5, %L3), i8* blockaddress(@indbrtest5, %L4),
  i8* blockaddress(@indbrtest6, %L1), i8* blockaddress(@indbrtest6, %L2), i8* blockaddress(@indbrtest6, %L3)
]

; SimplifyCFG should turn the indirectbr into a conditional branch on the
; condition of the select.

define void @indbrtest3(i1 %cond, i8* %address) nounwind {
; CHECK-LABEL: @indbrtest3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[L1:%.*]], label [[L2:%.*]]
; CHECK:       common.ret:
; CHECK-NEXT:    ret void
; CHECK:       L1:
; CHECK-NEXT:    call void @A()
; CHECK-NEXT:    br label [[COMMON_RET:%.*]]
; CHECK:       L2:
; CHECK-NEXT:    call void @C()
; CHECK-NEXT:    br label [[COMMON_RET]]
;
entry:
  %indirect.goto.dest = select i1 %cond, i8* blockaddress(@indbrtest3, %L1), i8* blockaddress(@indbrtest3, %L2)
  indirectbr i8* %indirect.goto.dest, [label %L1, label %L2, label %L3]

L1:
  call void @A()
  ret void
L2:
  call void @C()
  ret void
L3:
  call void @foo()
  ret void
}

; SimplifyCFG should turn the indirectbr into an unconditional branch to the
; only possible destination.
; As in @indbrtest1, it should really remove the branch entirely, but it doesn't
; because it's in the entry block.

define void @indbrtest4(i1 %cond) nounwind {
; CHECK-LABEL: @indbrtest4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[L1:%.*]]
; CHECK:       L1:
; CHECK-NEXT:    call void @A()
; CHECK-NEXT:    ret void
;
entry:
  %indirect.goto.dest = select i1 %cond, i8* blockaddress(@indbrtest4, %L1), i8* blockaddress(@indbrtest4, %L1)
  indirectbr i8* %indirect.goto.dest, [label %L1, label %L2, label %L3]

L1:
  call void @A()
  ret void
L2:
  call void @C()
  ret void
L3:
  call void @foo()
  ret void
}

; SimplifyCFG should turn the indirectbr into an unreachable because neither
; destination is listed as a successor.

define void @indbrtest5(i1 %cond, i8* %anchor) nounwind {
; CHECK-LABEL: @indbrtest5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    unreachable
;
entry:
  %indirect.goto.dest = select i1 %cond, i8* blockaddress(@indbrtest5, %L1), i8* blockaddress(@indbrtest5, %L2)
; This needs to have more than one successor for this test, otherwise it gets
; replaced with an unconditional branch to the single successor.
  indirectbr i8* %indirect.goto.dest, [label %L3, label %L4]

L1:
  call void @A()
  ret void
L2:
  call void @C()
  ret void
L3:
  call void @foo()
  ret void
L4:
  call void @foo()

; This keeps blockaddresses not otherwise listed as successors from being zapped
; before SimplifyCFG even looks at the indirectbr.
  indirectbr i8* %anchor, [label %L1, label %L2]
}

; The same as above, except the selected addresses are equal.

define void @indbrtest6(i1 %cond, i8* %anchor) nounwind {
; CHECK-LABEL: @indbrtest6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    unreachable
;
entry:
  %indirect.goto.dest = select i1 %cond, i8* blockaddress(@indbrtest6, %L1), i8* blockaddress(@indbrtest6, %L1)
; This needs to have more than one successor for this test, otherwise it gets
; replaced with an unconditional branch to the single successor.
  indirectbr i8* %indirect.goto.dest, [label %L2, label %L3]

L1:
  call void @A()
  ret void
L2:
  call void @C()
  ret void
L3:
  call void @foo()

; This keeps blockaddresses not otherwise listed as successors from being zapped
; before SimplifyCFG even looks at the indirectbr.
  indirectbr i8* %anchor, [label %L1, label %L2]
}

; PR10072

@xblkx.bbs = internal unnamed_addr constant [9 x i8*] [i8* blockaddress(@indbrtest7, %xblkx.begin), i8* blockaddress(@indbrtest7, %xblkx.begin3), i8* blockaddress(@indbrtest7, %xblkx.begin4), i8* blockaddress(@indbrtest7, %xblkx.begin5), i8* blockaddress(@indbrtest7, %xblkx.begin6), i8* blockaddress(@indbrtest7, %xblkx.begin7), i8* blockaddress(@indbrtest7, %xblkx.begin8), i8* blockaddress(@indbrtest7, %xblkx.begin9), i8* blockaddress(@indbrtest7, %xblkx.end)]

define void @indbrtest7() {
; CHECK-LABEL: @indbrtest7(
; CHECK-NEXT:  escape-string.top:
; CHECK-NEXT:    [[XVAL202X:%.*]] = call i32 @xfunc5x()
; CHECK-NEXT:    br label [[XLAB5X:%.*]]
; CHECK:       xlab8x:
; CHECK-NEXT:    [[XVALUEX:%.*]] = call i32 @xselectorx()
; CHECK-NEXT:    [[XBLKX_X:%.*]] = getelementptr [9 x i8*], [9 x i8*]* @xblkx.bbs, i32 0, i32 [[XVALUEX]]
; CHECK-NEXT:    [[XBLKX_LOAD:%.*]] = load i8*, i8** [[XBLKX_X]], align 8
; CHECK-NEXT:    indirectbr i8* [[XBLKX_LOAD]], [label [[XLAB4X:%.*]], label %v2j]
; CHECK:       v2j:
; CHECK-NEXT:    [[XUNUSEDX:%.*]] = call i32 @xactionx()
; CHECK-NEXT:    br label [[XLAB4X]]
; CHECK:       xlab4x:
; CHECK-NEXT:    [[INCR19:%.*]] = add i32 [[XVAL704X_0:%.*]], 1
; CHECK-NEXT:    br label [[XLAB5X]]
; CHECK:       xlab5x:
; CHECK-NEXT:    [[XVAL704X_0]] = phi i32 [ 0, [[ESCAPE_STRING_TOP:%.*]] ], [ [[INCR19]], [[XLAB4X]] ]
; CHECK-NEXT:    [[XVAL10X:%.*]] = icmp ult i32 [[XVAL704X_0]], [[XVAL202X]]
; CHECK-NEXT:    br i1 [[XVAL10X]], label [[XLAB8X:%.*]], label [[XLAB9X:%.*]]
; CHECK:       xlab9x:
; CHECK-NEXT:    ret void
;
escape-string.top:
  %xval202x = call i32 @xfunc5x()
  br label %xlab5x

xlab8x:                                           ; preds = %xlab5x
  %xvaluex = call i32 @xselectorx()
  %xblkx.x = getelementptr [9 x i8*], [9 x i8*]* @xblkx.bbs, i32 0, i32 %xvaluex
  %xblkx.load = load i8*, i8** %xblkx.x
  indirectbr i8* %xblkx.load, [label %xblkx.begin, label %xblkx.begin3, label %xblkx.begin4, label %xblkx.begin5, label %xblkx.begin6, label %xblkx.begin7, label %xblkx.begin8, label %xblkx.begin9, label %xblkx.end]

xblkx.begin:
  br label %xblkx.end

xblkx.begin3:
  br label %xblkx.end

xblkx.begin4:
  br label %xblkx.end

xblkx.begin5:
  br label %xblkx.end

xblkx.begin6:
  br label %xblkx.end

xblkx.begin7:
  br label %xblkx.end

xblkx.begin8:
  br label %xblkx.end

xblkx.begin9:
  br label %xblkx.end

xblkx.end:
  %yes.0 = phi i1 [ false, %xblkx.begin ], [ true, %xlab8x ], [ false, %xblkx.begin9 ], [ false, %xblkx.begin8 ], [ false, %xblkx.begin7 ], [ false, %xblkx.begin6 ], [ false, %xblkx.begin5 ], [ true, %xblkx.begin4 ], [ false, %xblkx.begin3 ]
  br i1 %yes.0, label %v2j, label %xlab17x

v2j:
  %xunusedx = call i32 @xactionx()
  br label %xlab4x

xlab17x:
  br label %xlab4x

xlab4x:
  %incr19 = add i32 %xval704x.0, 1
  br label %xlab5x

xlab5x:
  %xval704x.0 = phi i32 [ 0, %escape-string.top ], [ %incr19, %xlab4x ]
  %xval10x = icmp ult i32 %xval704x.0, %xval202x
  br i1 %xval10x, label %xlab8x, label %xlab9x

xlab9x:
  ret void
}

define void @indbrtest8() {
; CHECK-LABEL: @indbrtest8(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @B(i32 undef)
; CHECK-NEXT:    ret void
;
entry:
  indirectbr i8* blockaddress(@indbrtest8, %BB1), [label %BB0, label %BB1]
BB0:
  call void @A()
  ret void
BB1:
  call void @B(i32 undef)
  ret void
}

define void @indbrtest9() {
; CHECK-LABEL: @indbrtest9(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    unreachable
;
entry:
  indirectbr i8* blockaddress(@indbrtest9, %BB1), [label %BB0]
BB0:
  call void @A()
  ret void
BB1:
  call void @B(i32 undef)
  ret void
}

define void @indbrtest10() {
; CHECK-LABEL: @indbrtest10(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @B(i32 undef)
; CHECK-NEXT:    ret void
;
entry:
  indirectbr i8* blockaddress(@indbrtest10, %BB1), [label %BB1]
BB0:
  call void @A()
  ret void
BB1:
  call void @B(i32 undef)
  ret void
}

define void @indbrtest11() {
; CHECK-LABEL: @indbrtest11(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @A()
; CHECK-NEXT:    ret void
;
entry:
  indirectbr i8* blockaddress(@indbrtest11, %BB0), [label %BB0, label %BB1, label %BB1]
BB0:
  call void @A()
  ret void
BB1:
  call void @B(i32 undef)
  ret void
}

define void @indbrtest12() {
; CHECK-LABEL: @indbrtest12(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @B(i32 undef)
; CHECK-NEXT:    ret void
;
entry:
  indirectbr i8* blockaddress(@indbrtest12, %BB1), [label %BB0, label %BB1, label %BB1]
BB0:
  call void @A()
  ret void
BB1:
  call void @B(i32 undef)
  ret void
}

declare i32 @xfunc5x()
declare i8 @xfunc7x()
declare i32 @xselectorx()
declare i32 @xactionx()
