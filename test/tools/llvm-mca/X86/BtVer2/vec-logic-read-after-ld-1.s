# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=btver2 -iterations=1 -timeline -resource-pressure=false < %s | FileCheck %s

vaddps %xmm0, %xmm0, %xmm1
vandps (%rdi), %xmm1, %xmm2

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      2
# CHECK-NEXT: Total Cycles:      9
# CHECK-NEXT: Total uOps:        2

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.22
# CHECK-NEXT: IPC:               0.22
# CHECK-NEXT: Block RThroughput: 1.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     1.00                        vaddps	%xmm0, %xmm0, %xmm1
# CHECK-NEXT:  1      6     1.00    *                   vandps	(%rdi), %xmm1, %xmm2

# CHECK:      Timeline view:
# CHECK-NEXT: Index     012345678

# CHECK:      [0,0]     DeeeER  .   vaddps	%xmm0, %xmm0, %xmm1
# CHECK-NEXT: [0,1]     DeeeeeeER   vandps	(%rdi), %xmm1, %xmm2

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       vaddps	%xmm0, %xmm0, %xmm1
# CHECK-NEXT: 1.     1     1.0    0.0    0.0       vandps	(%rdi), %xmm1, %xmm2
# CHECK-NEXT:        1     1.0    0.5    0.0       <total>
