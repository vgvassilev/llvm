# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=broadwell -instruction-tables < %s | FileCheck %s

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
# CHECK-NEXT:  1      3     1.00                        addsubpd	%xmm0, %xmm2
# CHECK-NEXT:  2      8     1.00    *                   addsubpd	(%rax), %xmm2
# CHECK-NEXT:  1      3     1.00                        addsubps	%xmm0, %xmm2
# CHECK-NEXT:  2      8     1.00    *                   addsubps	(%rax), %xmm2
# CHECK-NEXT:  3      5     2.00                        haddpd	%xmm0, %xmm2
# CHECK-NEXT:  4      10    2.00    *                   haddpd	(%rax), %xmm2
# CHECK-NEXT:  3      5     2.00                        haddps	%xmm0, %xmm2
# CHECK-NEXT:  4      10    2.00    *                   haddps	(%rax), %xmm2
# CHECK-NEXT:  3      5     2.00                        hsubpd	%xmm0, %xmm2
# CHECK-NEXT:  4      10    2.00    *                   hsubpd	(%rax), %xmm2
# CHECK-NEXT:  3      5     2.00                        hsubps	%xmm0, %xmm2
# CHECK-NEXT:  4      10    2.00    *                   hsubps	(%rax), %xmm2
# CHECK-NEXT:  1      5     0.50    *                   lddqu	(%rax), %xmm2
# CHECK-NEXT:  1      100   0.25                  U     monitor
# CHECK-NEXT:  1      1     1.00                        movddup	%xmm0, %xmm2
# CHECK-NEXT:  1      5     0.50    *                   movddup	(%rax), %xmm2
# CHECK-NEXT:  1      1     1.00                        movshdup	%xmm0, %xmm2
# CHECK-NEXT:  1      5     0.50    *                   movshdup	(%rax), %xmm2
# CHECK-NEXT:  1      1     1.00                        movsldup	%xmm0, %xmm2
# CHECK-NEXT:  1      5     0.50    *                   movsldup	(%rax), %xmm2
# CHECK-NEXT:  1      100   0.25    *      *      U     mwait

# CHECK:      Resources:
# CHECK-NEXT: [0]   - BWDivider
# CHECK-NEXT: [1]   - BWFPDivider
# CHECK-NEXT: [2]   - BWPort0
# CHECK-NEXT: [3]   - BWPort1
# CHECK-NEXT: [4]   - BWPort2
# CHECK-NEXT: [5]   - BWPort3
# CHECK-NEXT: [6]   - BWPort4
# CHECK-NEXT: [7]   - BWPort5
# CHECK-NEXT: [8]   - BWPort6
# CHECK-NEXT: [9]   - BWPort7

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]
# CHECK-NEXT:  -      -     0.50   12.50  5.00   5.00    -     19.50  0.50    -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    Instructions:
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     addsubpd	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -     1.00   0.50   0.50    -      -      -      -     addsubpd	(%rax), %xmm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     addsubps	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -     1.00   0.50   0.50    -      -      -      -     addsubps	(%rax), %xmm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -     2.00    -      -     haddpd	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -     1.00   0.50   0.50    -     2.00    -      -     haddpd	(%rax), %xmm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -     2.00    -      -     haddps	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -     1.00   0.50   0.50    -     2.00    -      -     haddps	(%rax), %xmm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -     2.00    -      -     hsubpd	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -     1.00   0.50   0.50    -     2.00    -      -     hsubpd	(%rax), %xmm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -     2.00    -      -     hsubps	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -     1.00   0.50   0.50    -     2.00    -      -     hsubps	(%rax), %xmm2
# CHECK-NEXT:  -      -      -      -     0.50   0.50    -      -      -      -     lddqu	(%rax), %xmm2
# CHECK-NEXT:  -      -     0.25   0.25    -      -      -     0.25   0.25    -     monitor
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     movddup	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -     0.50   0.50    -      -      -      -     movddup	(%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     movshdup	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -     0.50   0.50    -      -      -      -     movshdup	(%rax), %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     movsldup	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -     0.50   0.50    -      -      -      -     movsldup	(%rax), %xmm2
# CHECK-NEXT:  -      -     0.25   0.25    -      -      -     0.25   0.25    -     mwait
