# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -march=aarch64 -mcpu=exynos-m3 -resource-pressure=false < %s | FileCheck %s -check-prefixes=ALL,M3
# RUN: llvm-mca -march=aarch64 -mcpu=exynos-m4 -resource-pressure=false < %s | FileCheck %s -check-prefixes=ALL,M4
# RUN: llvm-mca -march=aarch64 -mcpu=exynos-m5 -resource-pressure=false < %s | FileCheck %s -check-prefixes=ALL,M5

ld3	{v0.s, v1.s, v2.s}[0], [sp]
ld3r	{v0.2s, v1.2s, v2.2s}, [sp]
ld3	{v0.2s, v1.2s, v2.2s}, [sp]

ld3	{v0.d, v1.d, v2.d}[0], [sp]
ld3r	{v0.2d, v1.2d, v2.2d}, [sp]
ld3	{v0.2d, v1.2d, v2.2d}, [sp]

ld3	{v0.s, v1.s, v2.s}[0], [sp], #12
ld3r	{v0.2s, v1.2s, v2.2s}, [sp], #12
ld3	{v0.2s, v1.2s, v2.2s}, [sp], #24

ld3	{v0.d, v1.d, v2.d}[0], [sp], #24
ld3r	{v0.2d, v1.2d, v2.2d}, [sp], #24
ld3	{v0.2d, v1.2d, v2.2d}, [sp], #48

ld3	{v0.s, v1.s, v2.s}[0], [sp], x0
ld3r	{v0.2s, v1.2s, v2.2s}, [sp], x0
ld3	{v0.2s, v1.2s, v2.2s}, [sp], x0

ld3	{v0.d, v1.d, v2.d}[0], [sp], x0
ld3r	{v0.2d, v1.2d, v2.2d}, [sp], x0
ld3	{v0.2d, v1.2d, v2.2d}, [sp], x0

# ALL:      Iterations:        100
# ALL-NEXT: Instructions:      1800

# M3-NEXT:  Total Cycles:      12501
# M4-NEXT:  Total Cycles:      11804
# M5-NEXT:  Total Cycles:      12903

# ALL-NEXT: Total uOps:        7500

# ALL:      Dispatch Width:    6

# M3-NEXT:  uOps Per Cycle:    0.60
# M3-NEXT:  IPC:               0.14
# M3-NEXT:  Block RThroughput: 84.0

# M4-NEXT:  uOps Per Cycle:    0.64
# M4-NEXT:  IPC:               0.15
# M4-NEXT:  Block RThroughput: 54.0

# M5-NEXT:  uOps Per Cycle:    0.58
# M5-NEXT:  IPC:               0.14
# M5-NEXT:  Block RThroughput: 22.5

# ALL:      Instruction Info:
# ALL-NEXT: [1]: #uOps
# ALL-NEXT: [2]: Latency
# ALL-NEXT: [3]: RThroughput
# ALL-NEXT: [4]: MayLoad
# ALL-NEXT: [5]: MayStore
# ALL-NEXT: [6]: HasSideEffects (U)

# ALL:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:

# M3-NEXT:   4      7     1.00    *                   ld3	{ v0.s, v1.s, v2.s }[0], [sp]
# M3-NEXT:   3      6     1.50    *                   ld3r	{ v0.2s, v1.2s, v2.2s }, [sp]
# M3-NEXT:   3      12    9.00    *                   ld3	{ v0.2s, v1.2s, v2.2s }, [sp]
# M3-NEXT:   5      6     6.00    *                   ld3	{ v0.d, v1.d, v2.d }[0], [sp]
# M3-NEXT:   3      6     1.50    *                   ld3r	{ v0.2d, v1.2d, v2.2d }, [sp]
# M3-NEXT:   3      12    9.00    *                   ld3	{ v0.2d, v1.2d, v2.2d }, [sp]
# M3-NEXT:   5      7     1.00    *                   ld3	{ v0.s, v1.s, v2.s }[0], [sp], #12
# M3-NEXT:   4      6     1.50    *                   ld3r	{ v0.2s, v1.2s, v2.2s }, [sp], #12
# M3-NEXT:   4      12    9.00    *                   ld3	{ v0.2s, v1.2s, v2.2s }, [sp], #24
# M3-NEXT:   6      6     6.00    *                   ld3	{ v0.d, v1.d, v2.d }[0], [sp], #24
# M3-NEXT:   4      6     1.50    *                   ld3r	{ v0.2d, v1.2d, v2.2d }, [sp], #24
# M3-NEXT:   4      12    9.00    *                   ld3	{ v0.2d, v1.2d, v2.2d }, [sp], #48
# M3-NEXT:   5      7     1.00    *                   ld3	{ v0.s, v1.s, v2.s }[0], [sp], x0
# M3-NEXT:   4      6     1.50    *                   ld3r	{ v0.2s, v1.2s, v2.2s }, [sp], x0
# M3-NEXT:   4      12    9.00    *                   ld3	{ v0.2s, v1.2s, v2.2s }, [sp], x0
# M3-NEXT:   6      6     6.00    *                   ld3	{ v0.d, v1.d, v2.d }[0], [sp], x0
# M3-NEXT:   4      6     1.50    *                   ld3r	{ v0.2d, v1.2d, v2.2d }, [sp], x0
# M3-NEXT:   4      12    9.00    *                   ld3	{ v0.2d, v1.2d, v2.2d }, [sp], x0

# M4-NEXT:   4      7     1.50    *                   ld3	{ v0.s, v1.s, v2.s }[0], [sp]
# M4-NEXT:   3      6     1.50    *                   ld3r	{ v0.2s, v1.2s, v2.2s }, [sp]
# M4-NEXT:   3      12    4.50    *                   ld3	{ v0.2s, v1.2s, v2.2s }, [sp]
# M4-NEXT:   5      7     4.50    *                   ld3	{ v0.d, v1.d, v2.d }[0], [sp]
# M4-NEXT:   3      6     1.50    *                   ld3r	{ v0.2d, v1.2d, v2.2d }, [sp]
# M4-NEXT:   3      12    4.50    *                   ld3	{ v0.2d, v1.2d, v2.2d }, [sp]
# M4-NEXT:   5      7     1.50    *                   ld3	{ v0.s, v1.s, v2.s }[0], [sp], #12
# M4-NEXT:   4      6     1.50    *                   ld3r	{ v0.2s, v1.2s, v2.2s }, [sp], #12
# M4-NEXT:   4      12    4.50    *                   ld3	{ v0.2s, v1.2s, v2.2s }, [sp], #24
# M4-NEXT:   6      7     4.50    *                   ld3	{ v0.d, v1.d, v2.d }[0], [sp], #24
# M4-NEXT:   4      6     1.50    *                   ld3r	{ v0.2d, v1.2d, v2.2d }, [sp], #24
# M4-NEXT:   4      12    4.50    *                   ld3	{ v0.2d, v1.2d, v2.2d }, [sp], #48
# M4-NEXT:   5      7     1.50    *                   ld3	{ v0.s, v1.s, v2.s }[0], [sp], x0
# M4-NEXT:   4      6     1.50    *                   ld3r	{ v0.2s, v1.2s, v2.2s }, [sp], x0
# M4-NEXT:   4      12    4.50    *                   ld3	{ v0.2s, v1.2s, v2.2s }, [sp], x0
# M4-NEXT:   6      7     4.50    *                   ld3	{ v0.d, v1.d, v2.d }[0], [sp], x0
# M4-NEXT:   4      6     1.50    *                   ld3r	{ v0.2d, v1.2d, v2.2d }, [sp], x0
# M4-NEXT:   4      12    4.50    *                   ld3	{ v0.2d, v1.2d, v2.2d }, [sp], x0

# M5-NEXT:   4      8     1.50    *                   ld3	{ v0.s, v1.s, v2.s }[0], [sp]
# M5-NEXT:   3      7     1.50    *                   ld3r	{ v0.2s, v1.2s, v2.2s }, [sp]
# M5-NEXT:   3      13    1.50    *                   ld3	{ v0.2s, v1.2s, v2.2s }, [sp]
# M5-NEXT:   5      8     1.50    *                   ld3	{ v0.d, v1.d, v2.d }[0], [sp]
# M5-NEXT:   3      7     1.50    *                   ld3r	{ v0.2d, v1.2d, v2.2d }, [sp]
# M5-NEXT:   3      13    1.50    *                   ld3	{ v0.2d, v1.2d, v2.2d }, [sp]
# M5-NEXT:   5      8     1.50    *                   ld3	{ v0.s, v1.s, v2.s }[0], [sp], #12
# M5-NEXT:   4      7     1.50    *                   ld3r	{ v0.2s, v1.2s, v2.2s }, [sp], #12
# M5-NEXT:   4      13    1.50    *                   ld3	{ v0.2s, v1.2s, v2.2s }, [sp], #24
# M5-NEXT:   6      8     1.50    *                   ld3	{ v0.d, v1.d, v2.d }[0], [sp], #24
# M5-NEXT:   4      7     1.50    *                   ld3r	{ v0.2d, v1.2d, v2.2d }, [sp], #24
# M5-NEXT:   4      13    1.50    *                   ld3	{ v0.2d, v1.2d, v2.2d }, [sp], #48
# M5-NEXT:   5      8     1.50    *                   ld3	{ v0.s, v1.s, v2.s }[0], [sp], x0
# M5-NEXT:   4      7     1.50    *                   ld3r	{ v0.2s, v1.2s, v2.2s }, [sp], x0
# M5-NEXT:   4      13    1.50    *                   ld3	{ v0.2s, v1.2s, v2.2s }, [sp], x0
# M5-NEXT:   6      8     1.50    *                   ld3	{ v0.d, v1.d, v2.d }[0], [sp], x0
# M5-NEXT:   4      7     1.50    *                   ld3r	{ v0.2d, v1.2d, v2.2d }, [sp], x0
# M5-NEXT:   4      13    1.50    *                   ld3	{ v0.2d, v1.2d, v2.2d }, [sp], x0
