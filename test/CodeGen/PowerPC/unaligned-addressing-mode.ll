; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -mcpu=pwr9 -ppc-convert-rr-to-ri=false -ppc-asm-full-reg-names < %s | FileCheck %s

; ISEL matches address mode xaddr.
define i8 @test_xaddr(i8* %p) {
; CHECK-LABEL: test_xaddr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li r4, 0
; CHECK-NEXT:    std r3, -8(r1)
; CHECK-NEXT:    ori r4, r4, 40000
; CHECK-NEXT:    lbzx r3, r3, r4
; CHECK-NEXT:    blr
entry:
  %p.addr = alloca i8*, align 8
  store i8* %p, i8** %p.addr, align 8
  %0 = load i8*, i8** %p.addr, align 8
  %add.ptr = getelementptr inbounds i8, i8* %0, i64 40000
  %1 = load i8, i8* %add.ptr, align 1
  ret i8 %1
}

; ISEL matches address mode xaddrX4.
define i64 @test_xaddrX4(i8* %p) {
; CHECK-LABEL: test_xaddrX4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li r4, 3
; CHECK-NEXT:    std r3, -8(r1)
; CHECK-NEXT:    ldx r3, r3, r4
; CHECK-NEXT:    blr
entry:
  %p.addr = alloca i8*, align 8
  store i8* %p, i8** %p.addr, align 8
  %0 = load i8*, i8** %p.addr, align 8
  %add.ptr = getelementptr inbounds i8, i8* %0, i64 3
  %1 = bitcast i8* %add.ptr to i64*
  %2 = load i64, i64* %1, align 8
  ret i64 %2
}

; ISEL matches address mode xaddrX16.
define <2 x double> @test_xaddrX16(double* %arr) {
; CHECK-LABEL: test_xaddrX16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li r4, 40
; CHECK-NEXT:    lxvx vs34, r3, r4
; CHECK-NEXT:    blr
entry:
  %arrayidx1 = getelementptr inbounds double, double* %arr, i64 5
  %0 = bitcast double* %arrayidx1 to <2 x double>*
  %1 = load <2 x double>, <2 x double>* %0, align 16
  ret <2 x double> %1
}

; ISEL matches address mode xoaddr.
define void @test_xoaddr(i32* %arr, i32* %arrTo) {
; CHECK-LABEL: test_xoaddr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    li r5, 8
; CHECK-NEXT:    lxvx vs0, r3, r5
; CHECK-NEXT:    li r3, 4
; CHECK-NEXT:    stxvx vs0, r4, r3
; CHECK-NEXT:    blr
entry:
  %arrayidx = getelementptr inbounds i32, i32* %arrTo, i64 1
  %0 = bitcast i32* %arrayidx to <4 x i32>*
  %arrayidx1 = getelementptr inbounds i32, i32* %arr, i64 2
  %1 = bitcast i32* %arrayidx1 to <4 x i32>*
  %2 = load <4 x i32>, <4 x i32>* %1, align 8
  store <4 x i32> %2, <4 x i32>* %0, align 8
  ret void
}

; ISEL matches address mode xaddrX4 and generates LI which can be moved outside of
; loop.
define i64 @test_xaddrX4_loop(i8* %p) {
; CHECK-LABEL: test_xaddrX4_loop:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    addi r4, r3, -8
; CHECK-NEXT:    li r3, 8
; CHECK-NEXT:    li r5, 3
; CHECK-NEXT:    mtctr r3
; CHECK-NEXT:    li r3, 0
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  .LBB4_1: # %for.body
; CHECK-NEXT:    #
; CHECK-NEXT:    ldu r6, 8(r4)
; CHECK-NEXT:    ldx r7, r4, r5
; CHECK-NEXT:    maddld r3, r7, r6, r3
; CHECK-NEXT:    bdnz .LBB4_1
; CHECK-NEXT:  # %bb.2: # %for.end
; CHECK-NEXT:    blr
; loop instruction number is changed from 5 to 4, so its align is changed from 5 to 4.
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %i.015 = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %res.014 = phi i64 [ 0, %entry ], [ %add, %for.body ]
  %mul = shl i64 %i.015, 3
  %add.ptr = getelementptr inbounds i8, i8* %p, i64 %mul
  %0 = bitcast i8* %add.ptr to i64*
  %1 = load i64, i64* %0, align 8
  %add.ptr3 = getelementptr inbounds i8, i8* %add.ptr, i64 3
  %2 = bitcast i8* %add.ptr3 to i64*
  %3 = load i64, i64* %2, align 8
  %mul4 = mul i64 %3, %1
  %add = add i64 %mul4, %res.014
  %inc = add nuw nsw i64 %i.015, 1
  %exitcond = icmp eq i64 %inc, 8
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret i64 %add

}
