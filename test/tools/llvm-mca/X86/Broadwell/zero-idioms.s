# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=broadwell -timeline -register-file-stats -iterations=1 < %s | FileCheck %s

# On BDW, renamer-based zeroing does not work for:
#  - 16 and 8-bit GPRs
#  - MMX
#  - ANDN variants

subl  %eax, %eax
subq  %rax, %rax
xorl  %eax, %eax
xorq  %rax, %rax

pcmpgtb   %mm2, %mm2
pcmpgtd   %mm2, %mm2
# pcmpgtq   %mm2, %mm2 # invalid operand for instruction
pcmpgtw   %mm2, %mm2

pcmpgtb   %xmm2, %xmm2
pcmpgtd   %xmm2, %xmm2
pcmpgtq   %xmm2, %xmm2
pcmpgtw   %xmm2, %xmm2

vpcmpgtb  %xmm3, %xmm3, %xmm3
vpcmpgtd  %xmm3, %xmm3, %xmm3
vpcmpgtq  %xmm3, %xmm3, %xmm3
vpcmpgtw  %xmm3, %xmm3, %xmm3

vpcmpgtb  %xmm3, %xmm3, %xmm5
vpcmpgtd  %xmm3, %xmm3, %xmm5
vpcmpgtq  %xmm3, %xmm3, %xmm5
vpcmpgtw  %xmm3, %xmm3, %xmm5

psubb   %mm2, %mm2
psubd   %mm2, %mm2
psubq   %mm2, %mm2
psubw   %mm2, %mm2
psubb   %xmm2, %xmm2
psubd   %xmm2, %xmm2
psubq   %xmm2, %xmm2
psubw   %xmm2, %xmm2
vpsubb  %xmm3, %xmm3, %xmm3
vpsubd  %xmm3, %xmm3, %xmm3
vpsubq  %xmm3, %xmm3, %xmm3
vpsubw  %xmm3, %xmm3, %xmm3
vpsubb  %ymm3, %ymm3, %ymm3
vpsubd  %ymm3, %ymm3, %ymm3
vpsubq  %ymm3, %ymm3, %ymm3
vpsubw  %ymm3, %ymm3, %ymm3

vpsubb  %xmm3, %xmm3, %xmm5
vpsubd  %xmm3, %xmm3, %xmm5
vpsubq  %xmm3, %xmm3, %xmm5
vpsubw  %xmm3, %xmm3, %xmm5
vpsubb  %ymm3, %ymm3, %ymm5
vpsubd  %ymm3, %ymm3, %ymm5
vpsubq  %ymm3, %ymm3, %ymm5
vpsubw  %ymm3, %ymm3, %ymm5

andnps  %xmm0, %xmm0
andnpd  %xmm1, %xmm1
vandnps %xmm2, %xmm2, %xmm2
vandnpd %xmm1, %xmm1, %xmm1
vandnps %ymm2, %ymm2, %ymm2
vandnpd %ymm1, %ymm1, %ymm1
pandn   %mm2, %mm2
pandn   %xmm2, %xmm2
vpandn  %xmm3, %xmm3, %xmm3
vpandn  %ymm3, %ymm3, %ymm3

vandnps %xmm2, %xmm2, %xmm5
vandnpd %xmm1, %xmm1, %xmm5
vpandn  %xmm3, %xmm3, %xmm5
vandnps %ymm2, %ymm2, %ymm5
vandnpd %ymm1, %ymm1, %ymm5
vpandn  %ymm3, %ymm3, %ymm5

xorps  %xmm0, %xmm0
xorpd  %xmm1, %xmm1
vxorps %xmm2, %xmm2, %xmm2
vxorpd %xmm1, %xmm1, %xmm1
vxorps %ymm2, %ymm2, %ymm2
vxorpd %ymm1, %ymm1, %ymm1
pxor   %mm2, %mm2
pxor   %xmm2, %xmm2
vpxor  %xmm3, %xmm3, %xmm3
vpxor  %ymm3, %ymm3, %ymm3

vxorps %xmm4, %xmm4, %xmm5
vxorpd %xmm1, %xmm1, %xmm3
vxorps %ymm4, %ymm4, %ymm5
vxorpd %ymm1, %ymm1, %ymm3
vpxor  %xmm3, %xmm3, %xmm5
vpxor  %ymm3, %ymm3, %ymm5

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      75
# CHECK-NEXT: Total Cycles:      41
# CHECK-NEXT: Total uOps:        75

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    1.83
# CHECK-NEXT: IPC:               1.83
# CHECK-NEXT: Block RThroughput: 20.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.25                        subl	%eax, %eax
# CHECK-NEXT:  1      1     0.25                        subq	%rax, %rax
# CHECK-NEXT:  1      1     0.25                        xorl	%eax, %eax
# CHECK-NEXT:  1      1     0.25                        xorq	%rax, %rax
# CHECK-NEXT:  1      1     0.50                        pcmpgtb	%mm2, %mm2
# CHECK-NEXT:  1      1     0.50                        pcmpgtd	%mm2, %mm2
# CHECK-NEXT:  1      1     0.50                        pcmpgtw	%mm2, %mm2
# CHECK-NEXT:  1      1     0.50                        pcmpgtb	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.50                        pcmpgtd	%xmm2, %xmm2
# CHECK-NEXT:  1      5     1.00                        pcmpgtq	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.50                        pcmpgtw	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.50                        vpcmpgtb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.50                        vpcmpgtd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      5     1.00                        vpcmpgtq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.50                        vpcmpgtw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.50                        vpcmpgtb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.50                        vpcmpgtd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      5     1.00                        vpcmpgtq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.50                        vpcmpgtw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.50                        psubb	%mm2, %mm2
# CHECK-NEXT:  1      1     0.50                        psubd	%mm2, %mm2
# CHECK-NEXT:  1      1     0.50                        psubq	%mm2, %mm2
# CHECK-NEXT:  1      1     0.50                        psubw	%mm2, %mm2
# CHECK-NEXT:  1      1     0.50                        psubb	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.50                        psubd	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.50                        psubq	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.50                        psubw	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.50                        vpsubb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.50                        vpsubd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.50                        vpsubq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.50                        vpsubw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.50                        vpsubb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.50                        vpsubd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.50                        vpsubq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.50                        vpsubw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     0.50                        vpsubb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.50                        vpsubd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.50                        vpsubq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.50                        vpsubw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.50                        vpsubb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.50                        vpsubd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.50                        vpsubq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     0.50                        vpsubw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     1.00                        andnps	%xmm0, %xmm0
# CHECK-NEXT:  1      1     1.00                        andnpd	%xmm1, %xmm1
# CHECK-NEXT:  1      1     1.00                        vandnps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT:  1      1     1.00                        vandnpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT:  1      1     1.00                        vandnps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT:  1      1     1.00                        vandnpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT:  1      1     0.33                        pandn	%mm2, %mm2
# CHECK-NEXT:  1      1     0.33                        pandn	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.33                        vpandn	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.33                        vpandn	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     1.00                        vandnps	%xmm2, %xmm2, %xmm5
# CHECK-NEXT:  1      1     1.00                        vandnpd	%xmm1, %xmm1, %xmm5
# CHECK-NEXT:  1      1     0.33                        vpandn	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     1.00                        vandnps	%ymm2, %ymm2, %ymm5
# CHECK-NEXT:  1      1     1.00                        vandnpd	%ymm1, %ymm1, %ymm5
# CHECK-NEXT:  1      1     0.33                        vpandn	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  1      1     1.00                        xorps	%xmm0, %xmm0
# CHECK-NEXT:  1      1     1.00                        xorpd	%xmm1, %xmm1
# CHECK-NEXT:  1      1     1.00                        vxorps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT:  1      1     1.00                        vxorpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT:  1      1     1.00                        vxorps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT:  1      1     1.00                        vxorpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT:  1      1     0.33                        pxor	%mm2, %mm2
# CHECK-NEXT:  1      1     0.33                        pxor	%xmm2, %xmm2
# CHECK-NEXT:  1      1     0.33                        vpxor	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  1      1     0.33                        vpxor	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  1      1     1.00                        vxorps	%xmm4, %xmm4, %xmm5
# CHECK-NEXT:  1      1     1.00                        vxorpd	%xmm1, %xmm1, %xmm3
# CHECK-NEXT:  1      1     1.00                        vxorps	%ymm4, %ymm4, %ymm5
# CHECK-NEXT:  1      1     1.00                        vxorpd	%ymm1, %ymm1, %ymm3
# CHECK-NEXT:  1      1     0.33                        vpxor	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  1      1     0.33                        vpxor	%ymm3, %ymm3, %ymm5

# CHECK:      Register File statistics:
# CHECK-NEXT: Total number of mappings created:    79
# CHECK-NEXT: Max number of mappings used:         58

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
# CHECK-NEXT:  -      -     14.00  24.00   -      -      -     35.00  2.00    -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    Instructions:
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -     subl	%eax, %eax
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     subq	%rax, %rax
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     xorl	%eax, %eax
# CHECK-NEXT:  -      -      -      -      -      -      -      -     1.00    -     xorq	%rax, %rax
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     pcmpgtb	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     pcmpgtd	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     pcmpgtw	%mm2, %mm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     pcmpgtb	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     pcmpgtd	%xmm2, %xmm2
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     pcmpgtq	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     pcmpgtw	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vpcmpgtb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vpcmpgtd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     vpcmpgtq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpcmpgtw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpcmpgtb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vpcmpgtd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     vpcmpgtq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpcmpgtw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     psubb	%mm2, %mm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     psubd	%mm2, %mm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     psubq	%mm2, %mm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     psubw	%mm2, %mm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     psubb	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     psubd	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     psubq	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     psubw	%xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vpsubb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpsubd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpsubq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpsubw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpsubb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpsubd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpsubq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpsubw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpsubb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vpsubd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpsubq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vpsubw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpsubb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vpsubd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpsubq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vpsubw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     andnps	%xmm0, %xmm0
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     andnpd	%xmm1, %xmm1
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vandnps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vandnpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vandnps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vandnpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     pandn	%mm2, %mm2
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     pandn	%xmm2, %xmm2
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     vpandn	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     vpandn	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vandnps	%xmm2, %xmm2, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vandnpd	%xmm1, %xmm1, %xmm5
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     vpandn	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vandnps	%ymm2, %ymm2, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vandnpd	%ymm1, %ymm1, %ymm5
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     vpandn	%ymm3, %ymm3, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     xorps	%xmm0, %xmm0
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     xorpd	%xmm1, %xmm1
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vxorps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vxorpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vxorps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vxorpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     pxor	%mm2, %mm2
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     pxor	%xmm2, %xmm2
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     vpxor	%xmm3, %xmm3, %xmm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpxor	%ymm3, %ymm3, %ymm3
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vxorps	%xmm4, %xmm4, %xmm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vxorpd	%xmm1, %xmm1, %xmm3
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vxorps	%ymm4, %ymm4, %ymm5
# CHECK-NEXT:  -      -      -      -      -      -      -     1.00    -      -     vxorpd	%ymm1, %ymm1, %ymm3
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -      -      -     vpxor	%xmm3, %xmm3, %xmm5
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -     vpxor	%ymm3, %ymm3, %ymm5

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789          0123456789
# CHECK-NEXT: Index     0123456789          0123456789          0

# CHECK:      [0,0]     DeER .    .    .    .    .    .    .    .   subl	%eax, %eax
# CHECK-NEXT: [0,1]     D=eER.    .    .    .    .    .    .    .   subq	%rax, %rax
# CHECK-NEXT: [0,2]     D==eER    .    .    .    .    .    .    .   xorl	%eax, %eax
# CHECK-NEXT: [0,3]     D===eER   .    .    .    .    .    .    .   xorq	%rax, %rax
# CHECK-NEXT: [0,4]     .DeE--R   .    .    .    .    .    .    .   pcmpgtb	%mm2, %mm2
# CHECK-NEXT: [0,5]     .D=eE-R   .    .    .    .    .    .    .   pcmpgtd	%mm2, %mm2
# CHECK-NEXT: [0,6]     .D==eER   .    .    .    .    .    .    .   pcmpgtw	%mm2, %mm2
# CHECK-NEXT: [0,7]     .D=eE-R   .    .    .    .    .    .    .   pcmpgtb	%xmm2, %xmm2
# CHECK-NEXT: [0,8]     . D=eER   .    .    .    .    .    .    .   pcmpgtd	%xmm2, %xmm2
# CHECK-NEXT: [0,9]     . D==eeeeeER   .    .    .    .    .    .   pcmpgtq	%xmm2, %xmm2
# CHECK-NEXT: [0,10]    . D=======eER  .    .    .    .    .    .   pcmpgtw	%xmm2, %xmm2
# CHECK-NEXT: [0,11]    . D==eE-----R  .    .    .    .    .    .   vpcmpgtb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,12]    .  D==eE----R  .    .    .    .    .    .   vpcmpgtd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,13]    .  D===eeeeeER .    .    .    .    .    .   vpcmpgtq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,14]    .  D========eER.    .    .    .    .    .   vpcmpgtw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,15]    .  D=========eER    .    .    .    .    .   vpcmpgtb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,16]    .   D========eER    .    .    .    .    .   vpcmpgtd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,17]    .   D========eeeeeER.    .    .    .    .   vpcmpgtq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,18]    .   D=========eE---R.    .    .    .    .   vpcmpgtw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,19]    .   DeE------------R.    .    .    .    .   psubb	%mm2, %mm2
# CHECK-NEXT: [0,20]    .    DeE-----------R.    .    .    .    .   psubd	%mm2, %mm2
# CHECK-NEXT: [0,21]    .    D=eE----------R.    .    .    .    .   psubq	%mm2, %mm2
# CHECK-NEXT: [0,22]    .    D==eE---------R.    .    .    .    .   psubw	%mm2, %mm2
# CHECK-NEXT: [0,23]    .    D=====eE------R.    .    .    .    .   psubb	%xmm2, %xmm2
# CHECK-NEXT: [0,24]    .    .D=====eE-----R.    .    .    .    .   psubd	%xmm2, %xmm2
# CHECK-NEXT: [0,25]    .    .D=======eE---R.    .    .    .    .   psubq	%xmm2, %xmm2
# CHECK-NEXT: [0,26]    .    .D========eE--R.    .    .    .    .   psubw	%xmm2, %xmm2
# CHECK-NEXT: [0,27]    .    .D========eE--R.    .    .    .    .   vpsubb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,28]    .    . D========eE-R.    .    .    .    .   vpsubd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,29]    .    . D=========eER.    .    .    .    .   vpsubq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,30]    .    . D==========eER    .    .    .    .   vpsubw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,31]    .    . D===========eER   .    .    .    .   vpsubb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,32]    .    .  D===========eER  .    .    .    .   vpsubd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,33]    .    .  D============eER .    .    .    .   vpsubq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,34]    .    .  D=============eER.    .    .    .   vpsubw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,35]    .    .  D==============eER    .    .    .   vpsubb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,36]    .    .   D=============eER    .    .    .   vpsubd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,37]    .    .   D==============eER   .    .    .   vpsubq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,38]    .    .   D==============eER   .    .    .   vpsubw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,39]    .    .   D===============eER  .    .    .   vpsubb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,40]    .    .    D==============eER  .    .    .   vpsubd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,41]    .    .    D===============eER .    .    .   vpsubq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,42]    .    .    D===============eER .    .    .   vpsubw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,43]    .    .    DeE---------------R .    .    .   andnps	%xmm0, %xmm0
# CHECK-NEXT: [0,44]    .    .    .D====eE----------R .    .    .   andnpd	%xmm1, %xmm1
# CHECK-NEXT: [0,45]    .    .    .D=====eE---------R .    .    .   vandnps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT: [0,46]    .    .    .D=======eE-------R .    .    .   vandnpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT: [0,47]    .    .    .D======eE--------R .    .    .   vandnps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT: [0,48]    .    .    . D=======eE------R .    .    .   vandnpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT: [0,49]    .    .    . D=eE------------R .    .    .   pandn	%mm2, %mm2
# CHECK-NEXT: [0,50]    .    .    . D======eE-------R .    .    .   pandn	%xmm2, %xmm2
# CHECK-NEXT: [0,51]    .    .    . D==========eE---R .    .    .   vpandn	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,52]    .    .    .  D==========eE--R .    .    .   vpandn	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,53]    .    .    .  D=======eE-----R .    .    .   vandnps	%xmm2, %xmm2, %xmm5
# CHECK-NEXT: [0,54]    .    .    .  D========eE----R .    .    .   vandnpd	%xmm1, %xmm1, %xmm5
# CHECK-NEXT: [0,55]    .    .    .  D===========eE-R .    .    .   vpandn	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,56]    .    .    .   D============eER.    .    .   vandnps	%ymm2, %ymm2, %ymm5
# CHECK-NEXT: [0,57]    .    .    .   D=============eER    .    .   vandnpd	%ymm1, %ymm1, %ymm5
# CHECK-NEXT: [0,58]    .    .    .   D===========eE--R    .    .   vpandn	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: [0,59]    .    .    .   D===============eER  .    .   xorps	%xmm0, %xmm0
# CHECK-NEXT: [0,60]    .    .    .    D=============eE-R  .    .   xorpd	%xmm1, %xmm1
# CHECK-NEXT: [0,61]    .    .    .    D===============eER .    .   vxorps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT: [0,62]    .    .    .    D================eER.    .   vxorpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT: [0,63]    .    .    .    D==================eER   .   vxorps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT: [0,64]    .    .    .    .D================eE-R   .   vxorpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT: [0,65]    .    .    .    .DeE-----------------R   .   pxor	%mm2, %mm2
# CHECK-NEXT: [0,66]    .    .    .    .D==================eER  .   pxor	%xmm2, %xmm2
# CHECK-NEXT: [0,67]    .    .    .    .D==========eE--------R  .   vpxor	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: [0,68]    .    .    .    . D==========eE-------R  .   vpxor	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: [0,69]    .    .    .    . D==================eER .   vxorps	%xmm4, %xmm4, %xmm5
# CHECK-NEXT: [0,70]    .    .    .    . D===================eER.   vxorpd	%xmm1, %xmm1, %xmm3
# CHECK-NEXT: [0,71]    .    .    .    . D====================eER   vxorps	%ymm4, %ymm4, %ymm5
# CHECK-NEXT: [0,72]    .    .    .    .  D================eE---R   vxorpd	%ymm1, %ymm1, %ymm3
# CHECK-NEXT: [0,73]    .    .    .    .  D=================eE--R   vpxor	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: [0,74]    .    .    .    .  D=================eE--R   vpxor	%ymm3, %ymm3, %ymm5

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       subl	%eax, %eax
# CHECK-NEXT: 1.     1     2.0    0.0    0.0       subq	%rax, %rax
# CHECK-NEXT: 2.     1     3.0    0.0    0.0       xorl	%eax, %eax
# CHECK-NEXT: 3.     1     4.0    0.0    0.0       xorq	%rax, %rax
# CHECK-NEXT: 4.     1     1.0    1.0    2.0       pcmpgtb	%mm2, %mm2
# CHECK-NEXT: 5.     1     2.0    0.0    1.0       pcmpgtd	%mm2, %mm2
# CHECK-NEXT: 6.     1     3.0    0.0    0.0       pcmpgtw	%mm2, %mm2
# CHECK-NEXT: 7.     1     2.0    2.0    1.0       pcmpgtb	%xmm2, %xmm2
# CHECK-NEXT: 8.     1     2.0    0.0    0.0       pcmpgtd	%xmm2, %xmm2
# CHECK-NEXT: 9.     1     3.0    0.0    0.0       pcmpgtq	%xmm2, %xmm2
# CHECK-NEXT: 10.    1     8.0    0.0    0.0       pcmpgtw	%xmm2, %xmm2
# CHECK-NEXT: 11.    1     3.0    3.0    5.0       vpcmpgtb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 12.    1     3.0    0.0    4.0       vpcmpgtd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 13.    1     4.0    0.0    0.0       vpcmpgtq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 14.    1     9.0    0.0    0.0       vpcmpgtw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 15.    1     10.0   0.0    0.0       vpcmpgtb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 16.    1     9.0    0.0    0.0       vpcmpgtd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 17.    1     9.0    0.0    0.0       vpcmpgtq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 18.    1     10.0   1.0    3.0       vpcmpgtw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 19.    1     1.0    0.0    12.0      psubb	%mm2, %mm2
# CHECK-NEXT: 20.    1     1.0    0.0    11.0      psubd	%mm2, %mm2
# CHECK-NEXT: 21.    1     2.0    0.0    10.0      psubq	%mm2, %mm2
# CHECK-NEXT: 22.    1     3.0    0.0    9.0       psubw	%mm2, %mm2
# CHECK-NEXT: 23.    1     6.0    0.0    6.0       psubb	%xmm2, %xmm2
# CHECK-NEXT: 24.    1     6.0    0.0    5.0       psubd	%xmm2, %xmm2
# CHECK-NEXT: 25.    1     8.0    1.0    3.0       psubq	%xmm2, %xmm2
# CHECK-NEXT: 26.    1     9.0    0.0    2.0       psubw	%xmm2, %xmm2
# CHECK-NEXT: 27.    1     9.0    2.0    2.0       vpsubb	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 28.    1     9.0    0.0    1.0       vpsubd	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 29.    1     10.0   0.0    0.0       vpsubq	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 30.    1     11.0   0.0    0.0       vpsubw	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 31.    1     12.0   0.0    0.0       vpsubb	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 32.    1     12.0   0.0    0.0       vpsubd	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 33.    1     13.0   0.0    0.0       vpsubq	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 34.    1     14.0   0.0    0.0       vpsubw	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 35.    1     15.0   0.0    0.0       vpsubb	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 36.    1     14.0   0.0    0.0       vpsubd	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 37.    1     15.0   1.0    0.0       vpsubq	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 38.    1     15.0   1.0    0.0       vpsubw	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 39.    1     16.0   2.0    0.0       vpsubb	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 40.    1     15.0   2.0    0.0       vpsubd	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 41.    1     16.0   3.0    0.0       vpsubq	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 42.    1     16.0   3.0    0.0       vpsubw	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 43.    1     1.0    1.0    15.0      andnps	%xmm0, %xmm0
# CHECK-NEXT: 44.    1     5.0    5.0    10.0      andnpd	%xmm1, %xmm1
# CHECK-NEXT: 45.    1     6.0    1.0    9.0       vandnps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT: 46.    1     8.0    2.0    7.0       vandnpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT: 47.    1     7.0    0.0    8.0       vandnps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT: 48.    1     8.0    0.0    6.0       vandnpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT: 49.    1     2.0    2.0    12.0      pandn	%mm2, %mm2
# CHECK-NEXT: 50.    1     7.0    0.0    7.0       pandn	%xmm2, %xmm2
# CHECK-NEXT: 51.    1     11.0   0.0    3.0       vpandn	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 52.    1     11.0   0.0    2.0       vpandn	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 53.    1     8.0    1.0    5.0       vandnps	%xmm2, %xmm2, %xmm5
# CHECK-NEXT: 54.    1     9.0    1.0    4.0       vandnpd	%xmm1, %xmm1, %xmm5
# CHECK-NEXT: 55.    1     12.0   0.0    1.0       vpandn	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 56.    1     13.0   7.0    0.0       vandnps	%ymm2, %ymm2, %ymm5
# CHECK-NEXT: 57.    1     14.0   7.0    0.0       vandnpd	%ymm1, %ymm1, %ymm5
# CHECK-NEXT: 58.    1     12.0   1.0    2.0       vpandn	%ymm3, %ymm3, %ymm5
# CHECK-NEXT: 59.    1     16.0   16.0   0.0       xorps	%xmm0, %xmm0
# CHECK-NEXT: 60.    1     14.0   8.0    1.0       xorpd	%xmm1, %xmm1
# CHECK-NEXT: 61.    1     16.0   11.0   0.0       vxorps	%xmm2, %xmm2, %xmm2
# CHECK-NEXT: 62.    1     17.0   2.0    0.0       vxorpd	%xmm1, %xmm1, %xmm1
# CHECK-NEXT: 63.    1     19.0   2.0    0.0       vxorps	%ymm2, %ymm2, %ymm2
# CHECK-NEXT: 64.    1     17.0   0.0    1.0       vxorpd	%ymm1, %ymm1, %ymm1
# CHECK-NEXT: 65.    1     1.0    1.0    17.0      pxor	%mm2, %mm2
# CHECK-NEXT: 66.    1     19.0   0.0    0.0       pxor	%xmm2, %xmm2
# CHECK-NEXT: 67.    1     11.0   2.0    8.0       vpxor	%xmm3, %xmm3, %xmm3
# CHECK-NEXT: 68.    1     11.0   0.0    7.0       vpxor	%ymm3, %ymm3, %ymm3
# CHECK-NEXT: 69.    1     19.0   19.0   0.0       vxorps	%xmm4, %xmm4, %xmm5
# CHECK-NEXT: 70.    1     20.0   3.0    0.0       vxorpd	%xmm1, %xmm1, %xmm3
# CHECK-NEXT: 71.    1     21.0   21.0   0.0       vxorps	%ymm4, %ymm4, %ymm5
# CHECK-NEXT: 72.    1     17.0   1.0    3.0       vxorpd	%ymm1, %ymm1, %ymm3
# CHECK-NEXT: 73.    1     18.0   0.0    2.0       vpxor	%xmm3, %xmm3, %xmm5
# CHECK-NEXT: 74.    1     18.0   0.0    2.0       vpxor	%ymm3, %ymm3, %ymm5
