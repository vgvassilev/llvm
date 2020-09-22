; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -O0 -mtriple=i686-- -mcpu=corei7 -verify-machineinstrs | FileCheck %s --check-prefix X32

@sc64 = external global i64

define void @atomic_fetch_add64() nounwind {
; X32-LABEL: atomic_fetch_add64:
; X32:       # %bb.0: # %entry
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $72, %esp
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB0_1
; X32-NEXT:  .LBB0_1: # %atomicrmw.start
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    addl $1, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    adcl $0, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB0_1
; X32-NEXT:    jmp .LBB0_2
; X32-NEXT:  .LBB0_2: # %atomicrmw.end
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB0_3
; X32-NEXT:  .LBB0_3: # %atomicrmw.start2
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    addl $3, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    adcl $0, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB0_3
; X32-NEXT:    jmp .LBB0_4
; X32-NEXT:  .LBB0_4: # %atomicrmw.end1
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB0_5
; X32-NEXT:  .LBB0_5: # %atomicrmw.start8
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    addl $5, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    adcl $0, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB0_5
; X32-NEXT:    jmp .LBB0_6
; X32-NEXT:  .LBB0_6: # %atomicrmw.end7
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB0_7
; X32-NEXT:  .LBB0_7: # %atomicrmw.start14
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %esi # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    addl %ecx, %ebx
; X32-NEXT:    movl %ebx, (%esp) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    adcl %esi, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB0_7
; X32-NEXT:    jmp .LBB0_8
; X32-NEXT:  .LBB0_8: # %atomicrmw.end13
; X32-NEXT:    addl $72, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
entry:
  %t1 = atomicrmw add  i64* @sc64, i64 1 acquire
  %t2 = atomicrmw add  i64* @sc64, i64 3 acquire
  %t3 = atomicrmw add  i64* @sc64, i64 5 acquire
  %t4 = atomicrmw add  i64* @sc64, i64 %t3 acquire
  ret void
}

define void @atomic_fetch_sub64() nounwind {
; X32-LABEL: atomic_fetch_sub64:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $72, %esp
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB1_1
; X32-NEXT:  .LBB1_1: # %atomicrmw.start
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    addl $-1, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    adcl $-1, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB1_1
; X32-NEXT:    jmp .LBB1_2
; X32-NEXT:  .LBB1_2: # %atomicrmw.end
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB1_3
; X32-NEXT:  .LBB1_3: # %atomicrmw.start2
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    addl $-3, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    adcl $-1, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB1_3
; X32-NEXT:    jmp .LBB1_4
; X32-NEXT:  .LBB1_4: # %atomicrmw.end1
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB1_5
; X32-NEXT:  .LBB1_5: # %atomicrmw.start8
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    addl $-5, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    adcl $-1, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB1_5
; X32-NEXT:    jmp .LBB1_6
; X32-NEXT:  .LBB1_6: # %atomicrmw.end7
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB1_7
; X32-NEXT:  .LBB1_7: # %atomicrmw.start14
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %esi # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    subl %ecx, %ebx
; X32-NEXT:    movl %ebx, (%esp) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    sbbl %esi, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB1_7
; X32-NEXT:    jmp .LBB1_8
; X32-NEXT:  .LBB1_8: # %atomicrmw.end13
; X32-NEXT:    addl $72, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
  %t1 = atomicrmw sub  i64* @sc64, i64 1 acquire
  %t2 = atomicrmw sub  i64* @sc64, i64 3 acquire
  %t3 = atomicrmw sub  i64* @sc64, i64 5 acquire
  %t4 = atomicrmw sub  i64* @sc64, i64 %t3 acquire
  ret void
}

define void @atomic_fetch_and64() nounwind {
; X32-LABEL: atomic_fetch_and64:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $52, %esp
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB2_1
; X32-NEXT:  .LBB2_1: # %atomicrmw.start
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    andl $3, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    xorl %ecx, %ecx
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB2_1
; X32-NEXT:    jmp .LBB2_2
; X32-NEXT:  .LBB2_2: # %atomicrmw.end
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB2_3
; X32-NEXT:  .LBB2_3: # %atomicrmw.start2
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    andl $1, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    andl $1, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB2_3
; X32-NEXT:    jmp .LBB2_4
; X32-NEXT:  .LBB2_4: # %atomicrmw.end1
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB2_5
; X32-NEXT:  .LBB2_5: # %atomicrmw.start8
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %esi # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    andl %ecx, %ebx
; X32-NEXT:    movl %ebx, (%esp) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    andl %esi, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB2_5
; X32-NEXT:    jmp .LBB2_6
; X32-NEXT:  .LBB2_6: # %atomicrmw.end7
; X32-NEXT:    addl $52, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
  %t1 = atomicrmw and  i64* @sc64, i64 3 acquire
  %t2 = atomicrmw and  i64* @sc64, i64 4294967297 acquire
  %t3 = atomicrmw and  i64* @sc64, i64 %t2 acquire
  ret void
}

define void @atomic_fetch_or64() nounwind {
; X32-LABEL: atomic_fetch_or64:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $52, %esp
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB3_1
; X32-NEXT:  .LBB3_1: # %atomicrmw.start
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    orl $3, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %ecx, %edx
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB3_1
; X32-NEXT:    jmp .LBB3_2
; X32-NEXT:  .LBB3_2: # %atomicrmw.end
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB3_3
; X32-NEXT:  .LBB3_3: # %atomicrmw.start2
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    orl $1, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    orl $1, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB3_3
; X32-NEXT:    jmp .LBB3_4
; X32-NEXT:  .LBB3_4: # %atomicrmw.end1
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB3_5
; X32-NEXT:  .LBB3_5: # %atomicrmw.start8
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %esi # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    orl %ecx, %ebx
; X32-NEXT:    movl %ebx, (%esp) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    orl %esi, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB3_5
; X32-NEXT:    jmp .LBB3_6
; X32-NEXT:  .LBB3_6: # %atomicrmw.end7
; X32-NEXT:    addl $52, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
  %t1 = atomicrmw or   i64* @sc64, i64 3 acquire
  %t2 = atomicrmw or   i64* @sc64, i64 4294967297 acquire
  %t3 = atomicrmw or   i64* @sc64, i64 %t2 acquire
  ret void
}

define void @atomic_fetch_xor64() nounwind {
; X32-LABEL: atomic_fetch_xor64:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $52, %esp
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB4_1
; X32-NEXT:  .LBB4_1: # %atomicrmw.start
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    xorl $3, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %ecx, %edx
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB4_1
; X32-NEXT:    jmp .LBB4_2
; X32-NEXT:  .LBB4_2: # %atomicrmw.end
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB4_3
; X32-NEXT:  .LBB4_3: # %atomicrmw.start2
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    xorl $1, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    xorl $1, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB4_3
; X32-NEXT:    jmp .LBB4_4
; X32-NEXT:  .LBB4_4: # %atomicrmw.end1
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB4_5
; X32-NEXT:  .LBB4_5: # %atomicrmw.start8
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %esi # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    xorl %ecx, %ebx
; X32-NEXT:    movl %ebx, (%esp) # 4-byte Spill
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    xorl %esi, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB4_5
; X32-NEXT:    jmp .LBB4_6
; X32-NEXT:  .LBB4_6: # %atomicrmw.end7
; X32-NEXT:    addl $52, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
  %t1 = atomicrmw xor  i64* @sc64, i64 3 acquire
  %t2 = atomicrmw xor  i64* @sc64, i64 4294967297 acquire
  %t3 = atomicrmw xor  i64* @sc64, i64 %t2 acquire
  ret void
}

define void @atomic_fetch_nand64(i64 %x) nounwind {
; X32-LABEL: atomic_fetch_nand64:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %edi
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $32, %esp
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB5_1
; X32-NEXT:  .LBB5_1: # %atomicrmw.start
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %esi # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edi # 4-byte Reload
; X32-NEXT:    movl %edx, %ecx
; X32-NEXT:    andl %edi, %ecx
; X32-NEXT:    movl %ecx, (%esp) # 4-byte Spill
; X32-NEXT:    movl %eax, %ebx
; X32-NEXT:    andl %esi, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    notl %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    notl %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB5_1
; X32-NEXT:    jmp .LBB5_2
; X32-NEXT:  .LBB5_2: # %atomicrmw.end
; X32-NEXT:    addl $32, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %edi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
  %t1 = atomicrmw nand i64* @sc64, i64 %x acquire
  ret void
}

define void @atomic_fetch_max64(i64 %x) nounwind {
; X32-LABEL: atomic_fetch_max64:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $32, %esp
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB6_1
; X32-NEXT:  .LBB6_1: # %atomicrmw.start
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ebx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X32-NEXT:    movl %ebx, %esi
; X32-NEXT:    subl %eax, %esi
; X32-NEXT:    movl %esi, (%esp) # 4-byte Spill
; X32-NEXT:    movl %ecx, %esi
; X32-NEXT:    sbbl %edx, %esi
; X32-NEXT:    movl %esi, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    cmovll %edx, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    cmovll %eax, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB6_1
; X32-NEXT:    jmp .LBB6_2
; X32-NEXT:  .LBB6_2: # %atomicrmw.end
; X32-NEXT:    addl $32, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
  %t1 = atomicrmw max  i64* @sc64, i64 %x acquire
  ret void
}

define void @atomic_fetch_min64(i64 %x) nounwind {
; X32-LABEL: atomic_fetch_min64:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $32, %esp
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB7_1
; X32-NEXT:  .LBB7_1: # %atomicrmw.start
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ebx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X32-NEXT:    movl %ebx, %esi
; X32-NEXT:    subl %eax, %esi
; X32-NEXT:    movl %esi, (%esp) # 4-byte Spill
; X32-NEXT:    movl %ecx, %esi
; X32-NEXT:    sbbl %edx, %esi
; X32-NEXT:    movl %esi, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    cmovgel %edx, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    cmovgel %eax, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB7_1
; X32-NEXT:    jmp .LBB7_2
; X32-NEXT:  .LBB7_2: # %atomicrmw.end
; X32-NEXT:    addl $32, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
  %t1 = atomicrmw min  i64* @sc64, i64 %x acquire
  ret void
}

define void @atomic_fetch_umax64(i64 %x) nounwind {
; X32-LABEL: atomic_fetch_umax64:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $32, %esp
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB8_1
; X32-NEXT:  .LBB8_1: # %atomicrmw.start
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ebx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X32-NEXT:    movl %ebx, %esi
; X32-NEXT:    subl %eax, %esi
; X32-NEXT:    movl %esi, (%esp) # 4-byte Spill
; X32-NEXT:    movl %ecx, %esi
; X32-NEXT:    sbbl %edx, %esi
; X32-NEXT:    movl %esi, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    cmovbl %edx, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    cmovbl %eax, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB8_1
; X32-NEXT:    jmp .LBB8_2
; X32-NEXT:  .LBB8_2: # %atomicrmw.end
; X32-NEXT:    addl $32, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
  %t1 = atomicrmw umax i64* @sc64, i64 %x acquire
  ret void
}

define void @atomic_fetch_umin64(i64 %x) nounwind {
; X32-LABEL: atomic_fetch_umin64:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    pushl %esi
; X32-NEXT:    subl $32, %esp
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB9_1
; X32-NEXT:  .LBB9_1: # %atomicrmw.start
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ebx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ecx # 4-byte Reload
; X32-NEXT:    movl %ebx, %esi
; X32-NEXT:    subl %eax, %esi
; X32-NEXT:    movl %esi, (%esp) # 4-byte Spill
; X32-NEXT:    movl %ecx, %esi
; X32-NEXT:    sbbl %edx, %esi
; X32-NEXT:    movl %esi, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    cmovael %edx, %ecx
; X32-NEXT:    movl %ecx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    cmovael %eax, %ebx
; X32-NEXT:    movl %ebx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB9_1
; X32-NEXT:    jmp .LBB9_2
; X32-NEXT:  .LBB9_2: # %atomicrmw.end
; X32-NEXT:    addl $32, %esp
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
  %t1 = atomicrmw umin i64* @sc64, i64 %x acquire
  ret void
}

define void @atomic_fetch_cmpxchg64() nounwind {
; X32-LABEL: atomic_fetch_cmpxchg64:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    xorl %ecx, %ecx
; X32-NEXT:    movl $1, %ebx
; X32-NEXT:    movl %ecx, %eax
; X32-NEXT:    movl %ecx, %edx
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
  %t1 = cmpxchg i64* @sc64, i64 0, i64 1 acquire acquire
  ret void
}

define void @atomic_fetch_store64(i64 %x) nounwind {
; X32-LABEL: atomic_fetch_store64:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movd %ecx, %xmm0
; X32-NEXT:    pinsrd $1, %eax, %xmm0
; X32-NEXT:    movq %xmm0, sc64
; X32-NEXT:    retl
  store atomic i64 %x, i64* @sc64 release, align 8
  ret void
}

define void @atomic_fetch_swap64(i64 %x) nounwind {
; X32-LABEL: atomic_fetch_swap64:
; X32:       # %bb.0:
; X32-NEXT:    pushl %ebx
; X32-NEXT:    subl $16, %esp
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, (%esp) # 4-byte Spill
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl sc64+4, %edx
; X32-NEXT:    movl sc64, %eax
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jmp .LBB12_1
; X32-NEXT:  .LBB12_1: # %atomicrmw.start
; X32-NEXT:    # =>This Inner Loop Header: Depth=1
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %edx # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %eax # 4-byte Reload
; X32-NEXT:    movl {{[-0-9]+}}(%e{{[sb]}}p), %ebx # 4-byte Reload
; X32-NEXT:    movl (%esp), %ecx # 4-byte Reload
; X32-NEXT:    lock cmpxchg8b sc64
; X32-NEXT:    movl %eax, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    movl %edx, {{[-0-9]+}}(%e{{[sb]}}p) # 4-byte Spill
; X32-NEXT:    jne .LBB12_1
; X32-NEXT:    jmp .LBB12_2
; X32-NEXT:  .LBB12_2: # %atomicrmw.end
; X32-NEXT:    addl $16, %esp
; X32-NEXT:    popl %ebx
; X32-NEXT:    retl
  %t1 = atomicrmw xchg i64* @sc64, i64 %x acquire
  ret void
}
