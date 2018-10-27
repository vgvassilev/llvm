# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=bdver2 -iterations=1 -resource-pressure=0 -timeline -dispatch=3 < %s | FileCheck %s

  add %rdi, %rsi
  add (%rsp), %rsi
  add %rdx, %r8

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      3
# CHECK-NEXT: Total Cycles:      8
# CHECK-NEXT: Total uOps:        3

# CHECK:      Dispatch Width:    3
# CHECK-NEXT: uOps Per Cycle:    0.38
# CHECK-NEXT: IPC:               0.38
# CHECK-NEXT: Block RThroughput: 1.5

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.50                        addq	%rdi, %rsi
# CHECK-NEXT:  1      5     0.50    *                   addq	(%rsp), %rsi
# CHECK-NEXT:  1      1     0.50                        addq	%rdx, %r8

# CHECK:      Timeline view:
# CHECK-NEXT: Index     01234567

# CHECK:      [0,0]     DeER . .   addq	%rdi, %rsi
# CHECK-NEXT: [0,1]     DeeeeeER   addq	(%rsp), %rsi
# CHECK-NEXT: [0,2]     D=eE---R   addq	%rdx, %r8

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       addq	%rdi, %rsi
# CHECK-NEXT: 1.     1     1.0    0.0    0.0       addq	(%rsp), %rsi
# CHECK-NEXT: 2.     1     2.0    2.0    3.0       addq	%rdx, %r8
