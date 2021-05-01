# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=znver3 -instruction-tables < %s | FileCheck %s

popcntw     %cx, %cx
popcntw     (%rax), %cx

popcntl     %eax, %ecx
popcntl     (%rax), %ecx

popcntq     %rax, %rcx
popcntq     (%rax), %rcx

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00                        popcntw	%cx, %cx
# CHECK-NEXT:  1      5     0.33    *                   popcntw	(%rax), %cx
# CHECK-NEXT:  1      1     0.25                        popcntl	%eax, %ecx
# CHECK-NEXT:  1      5     0.33    *                   popcntl	(%rax), %ecx
# CHECK-NEXT:  1      1     0.25                        popcntq	%rax, %rcx
# CHECK-NEXT:  1      5     0.33    *                   popcntq	(%rax), %rcx

# CHECK:      Resources:
# CHECK-NEXT: [0]   - Zn3AGU0
# CHECK-NEXT: [1]   - Zn3AGU1
# CHECK-NEXT: [2]   - Zn3AGU2
# CHECK-NEXT: [3]   - Zn3ALU0
# CHECK-NEXT: [4]   - Zn3ALU1
# CHECK-NEXT: [5]   - Zn3ALU2
# CHECK-NEXT: [6]   - Zn3ALU3
# CHECK-NEXT: [7]   - Zn3BRU1
# CHECK-NEXT: [8]   - Zn3FPP0
# CHECK-NEXT: [9]   - Zn3FPP1
# CHECK-NEXT: [10]  - Zn3FPP2
# CHECK-NEXT: [11]  - Zn3FPP3
# CHECK-NEXT: [12.0] - Zn3FPP45
# CHECK-NEXT: [12.1] - Zn3FPP45
# CHECK-NEXT: [13]  - Zn3FPSt
# CHECK-NEXT: [14.0] - Zn3LSU
# CHECK-NEXT: [14.1] - Zn3LSU
# CHECK-NEXT: [14.2] - Zn3LSU
# CHECK-NEXT: [15.0] - Zn3Load
# CHECK-NEXT: [15.1] - Zn3Load
# CHECK-NEXT: [15.2] - Zn3Load
# CHECK-NEXT: [16.0] - Zn3Store
# CHECK-NEXT: [16.1] - Zn3Store

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12.0] [12.1] [13]   [14.0] [14.1] [14.2] [15.0] [15.1] [15.2] [16.0] [16.1]
# CHECK-NEXT: 1.00   1.00   1.00   2.25   2.25   2.25   2.25    -      -      -      -      -      -      -      -     1.00   1.00   1.00   1.00   1.00   1.00    -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12.0] [12.1] [13]   [14.0] [14.1] [14.2] [15.0] [15.1] [15.2] [16.0] [16.1] Instructions:
# CHECK-NEXT:  -      -      -     1.00   1.00   1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     popcntw	%cx, %cx
# CHECK-NEXT: 0.33   0.33   0.33   0.25   0.25   0.25   0.25    -      -      -      -      -      -      -      -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     popcntw	(%rax), %cx
# CHECK-NEXT:  -      -      -     0.25   0.25   0.25   0.25    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     popcntl	%eax, %ecx
# CHECK-NEXT: 0.33   0.33   0.33   0.25   0.25   0.25   0.25    -      -      -      -      -      -      -      -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     popcntl	(%rax), %ecx
# CHECK-NEXT:  -      -      -     0.25   0.25   0.25   0.25    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     popcntq	%rax, %rcx
# CHECK-NEXT: 0.33   0.33   0.33   0.25   0.25   0.25   0.25    -      -      -      -      -      -      -      -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     popcntq	(%rax), %rcx
