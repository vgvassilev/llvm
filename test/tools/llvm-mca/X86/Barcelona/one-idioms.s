# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -timeline -timeline-max-iterations=1 -register-file-stats < %s | FileCheck %s

# These are dependency-breaking one-idioms.
# Much like zero-idioms, but they produce ones, and do consume resources.

pcmpeqb %mm2, %mm2
pcmpeqd %mm2, %mm2
pcmpeqw %mm2, %mm2

pcmpeqb %xmm2, %xmm2
pcmpeqd %xmm2, %xmm2
pcmpeqq %xmm2, %xmm2
pcmpeqw %xmm2, %xmm2

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      700
# CHECK-NEXT: Total Cycles:      903
# CHECK-NEXT: Total uOps:        700

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    0.78
# CHECK-NEXT: IPC:               0.78
# CHECK-NEXT: Block RThroughput: 3.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     1.00                        pcmpeqb	%mm2, %mm2
# CHECK-NEXT:  1      3     1.00                        pcmpeqd	%mm2, %mm2
# CHECK-NEXT:  1      3     1.00                        pcmpeqw	%mm2, %mm2
# CHECK-NEXT:  1      1     0.50                        pcmpeqb	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.50                        pcmpeqd	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.50                        pcmpeqq	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.50                        pcmpeqw	%xmm2, %xmm2

# CHECK:      Register File statistics:
# CHECK-NEXT: Total number of mappings created:    700
# CHECK-NEXT: Max number of mappings used:         128

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -      -     4.10    -     2.90    -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -     pcmpeqb	%mm2, %mm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -     pcmpeqd	%mm2, %mm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -     pcmpeqw	%mm2, %mm2
# CHECK-NEXT:  -      -      -     0.10    -     0.90    -      -     pcmpeqb	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -     0.10    -     0.90    -      -     pcmpeqd	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -     0.11    -     0.89    -      -     pcmpeqq	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -     0.79    -     0.21    -      -     pcmpeqw	%xmm2, %xmm2

# CHECK:      Timeline view:
# CHECK-NEXT:                     01
# CHECK-NEXT: Index     0123456789

# CHECK:      [0,0]     DeeeER    ..   pcmpeqb	%mm2, %mm2
# CHECK-NEXT: [0,1]     D===eeeER ..   pcmpeqd	%mm2, %mm2
# CHECK-NEXT: [0,2]     D======eeeER   pcmpeqw	%mm2, %mm2
# CHECK-NEXT: [0,3]     DeE--------R   pcmpeqb	%xmm2, %xmm2
# CHECK-NEXT: [0,4]     .DeE-------R   pcmpeqd	%xmm2, %xmm2
# CHECK-NEXT: [0,5]     .D=eE------R   pcmpeqq	%xmm2, %xmm2
# CHECK-NEXT: [0,6]     .D==eE-----R   pcmpeqw	%xmm2, %xmm2

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       pcmpeqb	%mm2, %mm2
# CHECK-NEXT: 1.     1     4.0    0.0    0.0       pcmpeqd	%mm2, %mm2
# CHECK-NEXT: 2.     1     7.0    0.0    0.0       pcmpeqw	%mm2, %mm2
# CHECK-NEXT: 3.     1     1.0    1.0    8.0       pcmpeqb	%xmm2, %xmm2
# CHECK-NEXT: 4.     1     1.0    0.0    7.0       pcmpeqd	%xmm2, %xmm2
# CHECK-NEXT: 5.     1     2.0    0.0    6.0       pcmpeqq	%xmm2, %xmm2
# CHECK-NEXT: 6.     1     3.0    0.0    5.0       pcmpeqw	%xmm2, %xmm2
# CHECK-NEXT:        1     2.7    0.3    3.7       <total>
