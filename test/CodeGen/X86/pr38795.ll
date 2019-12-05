; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; FIXME: Fix machine verifier issues and remove -verify-machineinstrs=0. PR39440.
; RUN: llc %s -O2 -mtriple=i386-unknown-linux-gnu -o - -verify-machineinstrs=0 | FileCheck %s
@.str = external dso_local unnamed_addr constant [6 x i8], align 1
@a = external dso_local local_unnamed_addr global i32, align 4
@h = external dso_local local_unnamed_addr global i32, align 4
@g = external dso_local local_unnamed_addr global i8, align 1

define dso_local void @fn() {
; CHECK-LABEL: fn:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushl %ebp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    pushl %ebx
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:    pushl %edi
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:    .cfi_def_cfa_offset 20
; CHECK-NEXT:    subl $28, %esp
; CHECK-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEXT:    .cfi_offset %esi, -20
; CHECK-NEXT:    .cfi_offset %edi, -16
; CHECK-NEXT:    .cfi_offset %ebx, -12
; CHECK-NEXT:    .cfi_offset %ebp, -8
; CHECK-NEXT:    xorl %ebx, %ebx
; CHECK-NEXT:    # implicit-def: $ecx
; CHECK-NEXT:    # implicit-def: $edi
; CHECK-NEXT:    # implicit-def: $al
; CHECK-NEXT:    # kill: killed $al
; CHECK-NEXT:    # implicit-def: $dl
; CHECK-NEXT:    # implicit-def: $ebp
; CHECK-NEXT:    jmp .LBB0_1
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_16: # %for.inc
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    movb %dl, {{[-0-9]+}}(%e{{[sb]}}p) # 1-byte Spill
; CHECK-NEXT:    movb %dh, %dl
; CHECK-NEXT:  .LBB0_1: # %for.cond
; CHECK-NEXT:    # =>This Loop Header: Depth=1
; CHECK-NEXT:    # Child Loop BB0_20 Depth 2
; CHECK-NEXT:    cmpb $8, %dl
; CHECK-NEXT:    movb %dl, {{[-0-9]+}}(%e{{[sb]}}p) # 1-byte Spill
; CHECK-NEXT:    ja .LBB0_3
; CHECK-NEXT:  # %bb.2: # %for.cond
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    testb %bl, %bl
; CHECK-NEXT:    je .LBB0_3
; CHECK-NEXT:  # %bb.4: # %if.end
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    movl %ecx, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl a
; CHECK-NEXT:    movb {{[-0-9]+}}(%e{{[sb]}}p), %dl # 1-byte Reload
; CHECK-NEXT:    movb %cl, %dh
; CHECK-NEXT:    movl $0, h
; CHECK-NEXT:    cmpb $8, %dl
; CHECK-NEXT:    jg .LBB0_8
; CHECK-NEXT:  # %bb.5: # %if.then13
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    movl %eax, %esi
; CHECK-NEXT:    movl $.str, (%esp)
; CHECK-NEXT:    movb %dh, {{[-0-9]+}}(%e{{[sb]}}p) # 1-byte Spill
; CHECK-NEXT:    calll printf
; CHECK-NEXT:    movb {{[-0-9]+}}(%e{{[sb]}}p), %dh # 1-byte Reload
; CHECK-NEXT:    testb %bl, %bl
; CHECK-NEXT:    movl %esi, %ecx
; CHECK-NEXT:    # implicit-def: $eax
; CHECK-NEXT:    movb {{[-0-9]+}}(%e{{[sb]}}p), %dl # 1-byte Reload
; CHECK-NEXT:    movb %dl, {{[-0-9]+}}(%e{{[sb]}}p) # 1-byte Spill
; CHECK-NEXT:    movb %dh, %dl
; CHECK-NEXT:    jne .LBB0_16
; CHECK-NEXT:    jmp .LBB0_6
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_3: # %if.then
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    movl $.str, (%esp)
; CHECK-NEXT:    calll printf
; CHECK-NEXT:    movb {{[-0-9]+}}(%e{{[sb]}}p), %dl # 1-byte Reload
; CHECK-NEXT:    # implicit-def: $eax
; CHECK-NEXT:  .LBB0_6: # %for.cond35
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    je .LBB0_7
; CHECK-NEXT:  .LBB0_11: # %af
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    testb %bl, %bl
; CHECK-NEXT:    jne .LBB0_12
; CHECK-NEXT:  .LBB0_17: # %if.end39
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    testl %eax, %eax
; CHECK-NEXT:    je .LBB0_19
; CHECK-NEXT:  # %bb.18: # %if.then41
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    movl $0, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movl $fn, {{[0-9]+}}(%esp)
; CHECK-NEXT:    movl $.str, (%esp)
; CHECK-NEXT:    calll printf
; CHECK-NEXT:  .LBB0_19: # %for.end46
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    # implicit-def: $dl
; CHECK-NEXT:    # implicit-def: $dh
; CHECK-NEXT:    # implicit-def: $ebp
; CHECK-NEXT:    jmp .LBB0_20
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_8: # %if.end21
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    # implicit-def: $ebp
; CHECK-NEXT:    jmp .LBB0_9
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_7: # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    xorl %edi, %edi
; CHECK-NEXT:    movb %dl, %dh
; CHECK-NEXT:    movb {{[-0-9]+}}(%e{{[sb]}}p), %dl # 1-byte Reload
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_20: # %for.cond47
; CHECK-NEXT:    # Parent Loop BB0_1 Depth=1
; CHECK-NEXT:    # => This Inner Loop Header: Depth=2
; CHECK-NEXT:    testb %bl, %bl
; CHECK-NEXT:    jne .LBB0_20
; CHECK-NEXT:  # %bb.21: # %for.cond47
; CHECK-NEXT:    # in Loop: Header=BB0_20 Depth=2
; CHECK-NEXT:    testb %bl, %bl
; CHECK-NEXT:    jne .LBB0_20
; CHECK-NEXT:  .LBB0_9: # %ae
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    testb %bl, %bl
; CHECK-NEXT:    jne .LBB0_10
; CHECK-NEXT:  # %bb.13: # %if.end26
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    testb %dl, %dl
; CHECK-NEXT:    je .LBB0_16
; CHECK-NEXT:  # %bb.14: # %if.end26
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    testl %ebp, %ebp
; CHECK-NEXT:    jne .LBB0_16
; CHECK-NEXT:  # %bb.15: # %if.then31
; CHECK-NEXT:    # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    xorl %ebp, %ebp
; CHECK-NEXT:    jmp .LBB0_16
; CHECK-NEXT:    .p2align 4, 0x90
; CHECK-NEXT:  .LBB0_10: # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    # implicit-def: $eax
; CHECK-NEXT:    testb %bl, %bl
; CHECK-NEXT:    je .LBB0_17
; CHECK-NEXT:  .LBB0_12: # in Loop: Header=BB0_1 Depth=1
; CHECK-NEXT:    # implicit-def: $edi
; CHECK-NEXT:    # implicit-def: $cl
; CHECK-NEXT:    # kill: killed $cl
; CHECK-NEXT:    # implicit-def: $dl
; CHECK-NEXT:    # implicit-def: $ebp
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    jne .LBB0_11
; CHECK-NEXT:    jmp .LBB0_7
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %l.0 = phi i16 [ undef, %entry ], [ 0, %for.inc ]
  %m.0 = phi i32 [ undef, %entry ], [ %m.2, %for.inc ]
  %i.0 = phi i32 [ undef, %entry ], [ %i.2, %for.inc ]
  %p.0 = phi i8 [ undef, %entry ], [ %p.2, %for.inc ]
  %k.0 = phi i8 [ undef, %entry ], [ %k.2, %for.inc ]
  %q.0 = phi i32 [ undef, %entry ], [ %q.2, %for.inc ]
  %cmp = icmp ugt i8 %k.0, 8
  %or.cond61 = or i1 %cmp, undef
  br i1 %or.cond61, label %if.then, label %if.end

if.then:                                          ; preds = %for.cond
  tail call void (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i64 undef)
  br label %for.cond35

if.end:                                           ; preds = %for.cond
  %0 = load i32, i32* @a, align 4
  %div = sdiv i32 %m.0, %0
  br label %ac

ac:                                               ; preds = %ac, %if.end
  br i1 undef, label %if.end9, label %ac

if.end9:                                          ; preds = %ac
  %conv3 = trunc i32 %m.0 to i8
  %conv5 = sext i16 %l.0 to i32
  store i32 %conv5, i32* @h, align 4
  %cmp11 = icmp slt i8 %k.0, 9
  br i1 %cmp11, label %if.then13, label %if.end21

if.then13:                                        ; preds = %if.end9
  tail call void (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i64 undef)
  br i1 undef, label %for.inc, label %for.cond35

if.end21:                                         ; preds = %if.end9
  %1 = load i8, i8* @g, align 1
  br label %ae

ae:                                               ; preds = %for.cond47, %if.end21
  %l.2 = phi i16 [ undef, %if.end21 ], [ 0, %for.cond47 ]
  %i.1 = phi i32 [ %i.0, %if.end21 ], [ %i.5, %for.cond47 ]
  %p.1 = phi i8 [ %k.0, %if.end21 ], [ %p.6, %for.cond47 ]
  %k.1 = phi i8 [ %conv3, %if.end21 ], [ %k.6, %for.cond47 ]
  %q.1 = phi i32 [ undef, %if.end21 ], [ %q.5, %for.cond47 ]
  br i1 undef, label %if.end26, label %af

if.end26:                                         ; preds = %ae
  %tobool27 = icmp eq i32 %q.1, 0
  %tobool30 = icmp ne i8 %p.1, 0
  %or.cond = and i1 %tobool30, %tobool27
  br i1 %or.cond, label %if.then31, label %for.inc

if.then31:                                        ; preds = %if.end26
  br label %for.inc

for.inc:                                          ; preds = %if.then31, %if.end26, %if.then13
  %m.2 = phi i32 [ 0, %if.then31 ], [ 0, %if.end26 ], [ %div, %if.then13 ]
  %i.2 = phi i32 [ %i.1, %if.then31 ], [ %i.1, %if.end26 ], [ %i.0, %if.then13 ]
  %p.2 = phi i8 [ %p.1, %if.then31 ], [ %p.1, %if.end26 ], [ undef, %if.then13 ]
  %k.2 = phi i8 [ %k.1, %if.then31 ], [ %k.1, %if.end26 ], [ %conv3, %if.then13 ]
  %q.2 = phi i32 [ 0, %if.then31 ], [ %q.1, %if.end26 ], [ %q.0, %if.then13 ]
  %2 = load i32, i32* @h, align 4
  br label %for.cond

for.cond35:                                       ; preds = %for.inc44, %if.then13, %if.then
  %i.3 = phi i32 [ undef, %for.inc44 ], [ %i.0, %if.then ], [ %i.0, %if.then13 ]
  %o.2 = phi i32 [ %o.3, %for.inc44 ], [ undef, %if.then ], [ undef, %if.then13 ]
  %p.4 = phi i8 [ undef, %for.inc44 ], [ %p.0, %if.then ], [ %k.0, %if.then13 ]
  %k.4 = phi i8 [ undef, %for.inc44 ], [ %k.0, %if.then ], [ %conv3, %if.then13 ]
  %q.3 = phi i32 [ undef, %for.inc44 ], [ %q.0, %if.then ], [ %q.0, %if.then13 ]
  %tobool36 = icmp eq i32 %i.3, 0
  br i1 %tobool36, label %for.end46, label %af

af:                                               ; preds = %for.cond35, %ae
  %i.4 = phi i32 [ %i.3, %for.cond35 ], [ %i.1, %ae ]
  %o.3 = phi i32 [ %o.2, %for.cond35 ], [ undef, %ae ]
  br i1 undef, label %if.end39, label %for.inc44

if.end39:                                         ; preds = %af
  %tobool40 = icmp eq i32 %o.3, 0
  br i1 %tobool40, label %for.end46, label %if.then41

if.then41:                                        ; preds = %if.end39
  tail call void (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i64 ptrtoint (void ()* @fn to i64))
  br label %for.end46

for.inc44:                                        ; preds = %af
  br label %for.cond35

for.end46:                                        ; preds = %if.then41, %if.end39, %for.cond35
  %i.5 = phi i32 [ %i.4, %if.then41 ], [ %i.4, %if.end39 ], [ 0, %for.cond35 ]
  %p.6 = phi i8 [ undef, %if.then41 ], [ undef, %if.end39 ], [ %p.4, %for.cond35 ]
  %k.6 = phi i8 [ undef, %if.then41 ], [ undef, %if.end39 ], [ %k.4, %for.cond35 ]
  %q.5 = phi i32 [ undef, %if.then41 ], [ undef, %if.end39 ], [ %q.3, %for.cond35 ]
  br label %for.cond47

for.cond47:                                       ; preds = %for.cond47, %for.end46
  %brmerge = or i1 false, undef
  br i1 %brmerge, label %for.cond47, label %ae
}

declare dso_local void @printf(i8* nocapture readonly, ...) local_unnamed_addr
