# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=znver3 -instruction-tables < %s | FileCheck %s

addsubpd  %xmm0, %xmm2
addsubpd  (%rax),  %xmm2

addsubps  %xmm0, %xmm2
addsubps  (%rax), %xmm2

haddpd    %xmm0, %xmm2
haddpd    (%rax), %xmm2

haddps    %xmm0, %xmm2
haddps    (%rax), %xmm2

hsubpd    %xmm0, %xmm2
hsubpd    (%rax), %xmm2

hsubps    %xmm0, %xmm2
hsubps    (%rax), %xmm2

lddqu     (%rax), %xmm2

monitor

movddup   %xmm0, %xmm2
movddup   (%rax), %xmm2

movshdup  %xmm0, %xmm2
movshdup  (%rax), %xmm2

movsldup  %xmm0, %xmm2
movsldup  (%rax), %xmm2

mwait

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     0.50                        addsubpd	%xmm0, %xmm2
# CHECK-NEXT:  1      10    0.50    *                   addsubpd	(%rax), %xmm2
# CHECK-NEXT:  1      3     0.50                        addsubps	%xmm0, %xmm2
# CHECK-NEXT:  1      10    0.50    *                   addsubps	(%rax), %xmm2
# CHECK-NEXT:  4      6     2.00                        haddpd	%xmm0, %xmm2
# CHECK-NEXT:  4      13    2.00    *                   haddpd	(%rax), %xmm2
# CHECK-NEXT:  4      6     2.00                        haddps	%xmm0, %xmm2
# CHECK-NEXT:  4      13    2.00    *                   haddps	(%rax), %xmm2
# CHECK-NEXT:  4      6     2.00                        hsubpd	%xmm0, %xmm2
# CHECK-NEXT:  4      13    2.00    *                   hsubpd	(%rax), %xmm2
# CHECK-NEXT:  4      6     2.00                        hsubps	%xmm0, %xmm2
# CHECK-NEXT:  4      13    2.00    *                   hsubps	(%rax), %xmm2
# CHECK-NEXT:  1      8     0.50    *                   lddqu	(%rax), %xmm2
# CHECK-NEXT:  100    100   25.00                 U     monitor
# CHECK-NEXT:  1      1     0.50                        movddup	%xmm0, %xmm2
# CHECK-NEXT:  1      8     0.50    *                   movddup	(%rax), %xmm2
# CHECK-NEXT:  1      1     0.50                        movshdup	%xmm0, %xmm2
# CHECK-NEXT:  1      8     0.50    *                   movshdup	(%rax), %xmm2
# CHECK-NEXT:  1      1     0.50                        movsldup	%xmm0, %xmm2
# CHECK-NEXT:  1      8     0.50    *                   movsldup	(%rax), %xmm2
# CHECK-NEXT:  100    100   25.00   *      *      U     mwait

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
# CHECK-NEXT:  -      -      -     50.00  50.00  50.00  50.00   -      -     3.00   21.00  2.00   5.00   5.00    -     3.33   3.33   3.33   3.33   3.33   3.33    -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12.0] [12.1] [13]   [14.0] [14.1] [14.2] [15.0] [15.1] [15.2] [16.0] [16.1] Instructions:
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     0.50   0.50    -      -      -      -      -      -      -      -      -      -      -     addsubpd	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     0.50   0.50   0.50   0.50    -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     addsubpd	(%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     0.50   0.50    -      -      -      -      -      -      -      -      -      -      -     addsubps	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     0.50   0.50   0.50   0.50    -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     addsubps	(%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     2.00    -      -      -      -      -      -      -      -      -      -      -      -     haddpd	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     2.00    -     0.50   0.50    -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     haddpd	(%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     2.00    -      -      -      -      -      -      -      -      -      -      -      -     haddps	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     2.00    -     0.50   0.50    -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     haddps	(%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     2.00    -      -      -      -      -      -      -      -      -      -      -      -     hsubpd	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     2.00    -     0.50   0.50    -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     hsubpd	(%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     2.00    -      -      -      -      -      -      -      -      -      -      -      -     hsubps	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -     2.00    -     0.50   0.50    -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     hsubps	(%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -      -     0.50   0.50    -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     lddqu	(%rax), %xmm2
# CHECK-NEXT:  -      -      -     25.00  25.00  25.00  25.00   -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     monitor
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     0.50   0.50    -      -      -      -      -      -      -      -      -      -      -      -     movddup	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     0.50   0.50    -     0.50   0.50    -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     movddup	(%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     0.50   0.50    -      -      -      -      -      -      -      -      -      -      -      -     movshdup	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     0.50   0.50    -     0.50   0.50    -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     movshdup	(%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     0.50   0.50    -      -      -      -      -      -      -      -      -      -      -      -     movsldup	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     0.50   0.50    -     0.50   0.50    -     0.33   0.33   0.33   0.33   0.33   0.33    -      -     movsldup	(%rax), %xmm2
# CHECK-NEXT:  -      -      -     25.00  25.00  25.00  25.00   -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     mwait
