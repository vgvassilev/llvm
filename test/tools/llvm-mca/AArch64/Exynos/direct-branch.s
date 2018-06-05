# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -march=aarch64 -mcpu=exynos-m3 -iterations=300 -timeline -timeline-max-iterations=3 -resource-pressure=false < %s | FileCheck %s -check-prefix=ALL -check-prefix=M3
# RUN: llvm-mca -march=aarch64 -mcpu=exynos-m1 -iterations=300 -timeline -timeline-max-iterations=3 -resource-pressure=false < %s | FileCheck %s -check-prefix=ALL -check-prefix=M1

  b   t

# ALL:      Iterations:        300
# ALL-NEXT: Instructions:      300

# M1-NEXT:  Total Cycles:      76
# M1-NEXT:  Dispatch Width:    4
# M1-NEXT:  IPC:               3.95
# M1-NEXT:  Block RThroughput: 0.3

# M3-NEXT:  Total Cycles:      51
# M3-NEXT:  Dispatch Width:    6
# M3-NEXT:  IPC:               5.88
# M3-NEXT:  Block RThroughput: 0.2

# ALL:      Instruction Info:
# ALL-NEXT: [1]: #uOps
# ALL-NEXT: [2]: Latency
# ALL-NEXT: [3]: RThroughput
# ALL-NEXT: [4]: MayLoad
# ALL-NEXT: [5]: MayStore
# ALL-NEXT: [6]: HasSideEffects

# ALL:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:

# M1-NEXT:   1      0     0.25                        b	t
# M3-NEXT:   1      0     0.17                        b	t

# ALL:      Timeline view:
# ALL-NEXT: Index     01

# ALL:      [0,0]     DR   b	t
# ALL-NEXT: [1,0]     DR   b	t
# ALL-NEXT: [2,0]     DR   b	t

# ALL:      Average Wait times (based on the timeline view):
# ALL-NEXT: [0]: Executions
# ALL-NEXT: [1]: Average time spent waiting in a scheduler's queue
# ALL-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# ALL-NEXT: [3]: Average time elapsed from WB until retire stage

# ALL:            [0]    [1]    [2]    [3]
# ALL-NEXT: 0.     3     0.0    0.0    0.0       b	t
