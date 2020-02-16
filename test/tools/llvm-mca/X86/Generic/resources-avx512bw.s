# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -instruction-tables < %s | FileCheck %s

kaddd             %k0, %k1, %k2
kaddq             %k0, %k1, %k2
kandd             %k0, %k1, %k2
kandq             %k0, %k1, %k2
kandnd            %k0, %k1, %k2
kandnq            %k0, %k1, %k2
kord              %k0, %k1, %k2
korq              %k0, %k1, %k2
kxnord            %k0, %k1, %k2
kxnorq            %k0, %k1, %k2
kxord             %k0, %k1, %k2
kxorq             %k0, %k1, %k2
kshiftld          $2, %k1, %k2
kshiftlq          $2, %k1, %k2
kshiftrd          $2, %k1, %k2
kshiftrq          $2, %k1, %k2
kunpckdq          %k0, %k1, %k2
kunpckwd          %k0, %k1, %k2

vpabsb            %zmm16, %zmm19
vpabsb            (%rax), %zmm19
vpabsb            %zmm16, %zmm19 {k1}
vpabsb            (%rax), %zmm19 {k1}
vpabsb            %zmm16, %zmm19 {z}{k1}
vpabsb            (%rax), %zmm19 {z}{k1}

vpabsw            %zmm16, %zmm19
vpabsw            (%rax), %zmm19
vpabsw            %zmm16, %zmm19 {k1}
vpabsw            (%rax), %zmm19 {k1}
vpabsw            %zmm16, %zmm19 {z}{k1}
vpabsw            (%rax), %zmm19 {z}{k1}

vpaddb            %zmm16, %zmm17, %zmm19
vpaddb            (%rax), %zmm17, %zmm19
vpaddb            %zmm16, %zmm17, %zmm19 {k1}
vpaddb            (%rax), %zmm17, %zmm19 {k1}
vpaddb            %zmm16, %zmm17, %zmm19 {z}{k1}
vpaddb            (%rax), %zmm17, %zmm19 {z}{k1}

vpaddw            %zmm16, %zmm17, %zmm19
vpaddw            (%rax), %zmm17, %zmm19
vpaddw            %zmm16, %zmm17, %zmm19 {k1}
vpaddw            (%rax), %zmm17, %zmm19 {k1}
vpaddw            %zmm16, %zmm17, %zmm19 {z}{k1}
vpaddw            (%rax), %zmm17, %zmm19 {z}{k1}

vpcmpb            $0, %zmm0, %zmm1, %k2
vpcmpb            $0, (%rax), %zmm1, %k2
vpcmpb            $0, %zmm0, %zmm1, %k2 {k3}
vpcmpb            $0, (%rax), %zmm1, %k2 {k3}

vpcmpeqb          %zmm0, %zmm1, %k2
vpcmpeqb          (%rax), %zmm1, %k2
vpcmpeqb          %zmm0, %zmm1, %k2 {k3}
vpcmpeqb          (%rax), %zmm1, %k2 {k3}

vpcmpeqw          %zmm0, %zmm1, %k2
vpcmpeqw          (%rax), %zmm1, %k2
vpcmpeqw          %zmm0, %zmm1, %k2 {k3}
vpcmpeqw          (%rax), %zmm1, %k2 {k3}

vpcmpgtb          %zmm0, %zmm1, %k2
vpcmpgtb          (%rax), %zmm1, %k2
vpcmpgtb          %zmm0, %zmm1, %k2 {k3}
vpcmpgtb          (%rax), %zmm1, %k2 {k3}

vpcmpgtw          %zmm0, %zmm1, %k2
vpcmpgtw          (%rax), %zmm1, %k2
vpcmpgtw          %zmm0, %zmm1, %k2 {k3}
vpcmpgtw          (%rax), %zmm1, %k2 {k3}

vpcmpub           $0, %zmm0, %zmm1, %k2
vpcmpub           $0, (%rax), %zmm1, %k2
vpcmpub           $0, %zmm0, %zmm1, %k2 {k3}
vpcmpub           $0, (%rax), %zmm1, %k2 {k3}

vpcmpuw           $0, %zmm0, %zmm1, %k2
vpcmpuw           $0, (%rax), %zmm1, %k2
vpcmpuw           $0, %zmm0, %zmm1, %k2 {k3}
vpcmpuw           $0, (%rax), %zmm1, %k2 {k3}

vpcmpw            $0, %zmm0, %zmm1, %k2
vpcmpw            $0, (%rax), %zmm1, %k2
vpcmpw            $0, %zmm0, %zmm1, %k2 {k3}
vpcmpw            $0, (%rax), %zmm1, %k2 {k3}

vpermw            %zmm16, %zmm17, %zmm19
vpermw            (%rax), %zmm17, %zmm19
vpermw            %zmm16, %zmm17, %zmm19 {k1}
vpermw            (%rax), %zmm17, %zmm19 {k1}
vpermw            %zmm16, %zmm17, %zmm19 {z}{k1}
vpermw            (%rax), %zmm17, %zmm19 {z}{k1}

vpshufb           %zmm16, %zmm17, %zmm19
vpshufb           (%rax), %zmm17, %zmm19
vpshufb           %zmm16, %zmm17, %zmm19 {k1}
vpshufb           (%rax), %zmm17, %zmm19 {k1}
vpshufb           %zmm16, %zmm17, %zmm19 {z}{k1}
vpshufb           (%rax), %zmm17, %zmm19 {z}{k1}

vpshufhw          $0, %zmm16, %zmm19
vpshufhw          $0, (%rax), %zmm19
vpshufhw          $0, %zmm16, %zmm19 {k1}
vpshufhw          $0, (%rax), %zmm19 {k1}
vpshufhw          $0, %zmm16, %zmm19 {z}{k1}
vpshufhw          $0, (%rax), %zmm19 {z}{k1}

vpshuflw          $0, %zmm16, %zmm19
vpshuflw          $0, (%rax), %zmm19
vpshuflw          $0, %zmm16, %zmm19 {k1}
vpshuflw          $0, (%rax), %zmm19 {k1}
vpshuflw          $0, %zmm16, %zmm19 {z}{k1}
vpshuflw          $0, (%rax), %zmm19 {z}{k1}

vpsubb            %zmm16, %zmm17, %zmm19
vpsubb            (%rax), %zmm17, %zmm19
vpsubb            %zmm16, %zmm17, %zmm19 {k1}
vpsubb            (%rax), %zmm17, %zmm19 {k1}
vpsubb            %zmm16, %zmm17, %zmm19 {z}{k1}
vpsubb            (%rax), %zmm17, %zmm19 {z}{k1}

vpsubw            %zmm16, %zmm17, %zmm19
vpsubw            (%rax), %zmm17, %zmm19
vpsubw            %zmm16, %zmm17, %zmm19 {k1}
vpsubw            (%rax), %zmm17, %zmm19 {k1}
vpsubw            %zmm16, %zmm17, %zmm19 {z}{k1}
vpsubw            (%rax), %zmm17, %zmm19 {z}{k1}

vptestmb          %zmm0, %zmm1, %k2
vptestmb          (%rax), %zmm1, %k2
vptestmb          %zmm0, %zmm1, %k2 {k3}
vptestmb          (%rax), %zmm1, %k2 {k3}

vptestmw          %zmm0, %zmm1, %k2
vptestmw          (%rax), %zmm1, %k2
vptestmw          %zmm0, %zmm1, %k2 {k3}
vptestmw          (%rax), %zmm1, %k2 {k3}

vptestnmb         %zmm0, %zmm1, %k2
vptestnmb         (%rax), %zmm1, %k2
vptestnmb         %zmm0, %zmm1, %k2 {k3}
vptestnmb         (%rax), %zmm1, %k2 {k3}

vptestnmw         %zmm0, %zmm1, %k2
vptestnmw         (%rax), %zmm1, %k2
vptestnmw         %zmm0, %zmm1, %k2 {k3}
vptestnmw         (%rax), %zmm1, %k2 {k3}

vpunpckhbw        %zmm16, %zmm17, %zmm19
vpunpckhbw        (%rax), %zmm17, %zmm19
vpunpckhbw        %zmm16, %zmm17, %zmm19 {k1}
vpunpckhbw        (%rax), %zmm17, %zmm19 {k1}
vpunpckhbw        %zmm16, %zmm17, %zmm19 {z}{k1}
vpunpckhbw        (%rax), %zmm17, %zmm19 {z}{k1}

vpunpckhwd        %zmm16, %zmm17, %zmm19
vpunpckhwd        (%rax), %zmm17, %zmm19
vpunpckhwd        %zmm16, %zmm17, %zmm19 {k1}
vpunpckhwd        (%rax), %zmm17, %zmm19 {k1}
vpunpckhwd        %zmm16, %zmm17, %zmm19 {z}{k1}
vpunpckhwd        (%rax), %zmm17, %zmm19 {z}{k1}

vpunpcklbw        %zmm16, %zmm17, %zmm19
vpunpcklbw        (%rax), %zmm17, %zmm19
vpunpcklbw        %zmm16, %zmm17, %zmm19 {k1}
vpunpcklbw        (%rax), %zmm17, %zmm19 {k1}
vpunpcklbw        %zmm16, %zmm17, %zmm19 {z}{k1}
vpunpcklbw        (%rax), %zmm17, %zmm19 {z}{k1}

vpunpcklwd        %zmm16, %zmm17, %zmm19
vpunpcklwd        (%rax), %zmm17, %zmm19
vpunpcklwd        %zmm16, %zmm17, %zmm19 {k1}
vpunpcklwd        (%rax), %zmm17, %zmm19 {k1}
vpunpcklwd        %zmm16, %zmm17, %zmm19 {z}{k1}
vpunpcklwd        (%rax), %zmm17, %zmm19 {z}{k1}

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.33                        kaddd	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.33                        kaddq	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.33                        kandd	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.33                        kandq	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.33                        kandnd	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.33                        kandnq	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.33                        kord	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.33                        korq	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.33                        kxnord	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.33                        kxnorq	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.33                        kxord	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.33                        kxorq	%k0, %k1, %k2
# CHECK-NEXT:  1      1     1.00                        kshiftld	$2, %k1, %k2
# CHECK-NEXT:  1      1     1.00                        kshiftlq	$2, %k1, %k2
# CHECK-NEXT:  1      1     1.00                        kshiftrd	$2, %k1, %k2
# CHECK-NEXT:  1      1     1.00                        kshiftrq	$2, %k1, %k2
# CHECK-NEXT:  1      1     1.00                        kunpckdq	%k0, %k1, %k2
# CHECK-NEXT:  1      1     1.00                        kunpckwd	%k0, %k1, %k2
# CHECK-NEXT:  1      1     0.50                        vpabsb	%zmm16, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vpabsb	(%rax), %zmm19
# CHECK-NEXT:  1      1     0.50                        vpabsb	%zmm16, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vpabsb	(%rax), %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vpabsb	%zmm16, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vpabsb	(%rax), %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vpabsw	%zmm16, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vpabsw	(%rax), %zmm19
# CHECK-NEXT:  1      1     0.50                        vpabsw	%zmm16, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vpabsw	(%rax), %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vpabsw	%zmm16, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vpabsw	(%rax), %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vpaddb	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vpaddb	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vpaddb	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vpaddb	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vpaddb	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vpaddb	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vpaddw	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vpaddw	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vpaddw	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vpaddw	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vpaddw	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vpaddw	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vpcmpeqb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vpcmpeqb	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.50                        vpcmpeqb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vpcmpeqb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     0.50                        vpcmpeqb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vpcmpeqb	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.50                        vpcmpeqb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vpcmpeqb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     0.50                        vpcmpeqw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vpcmpeqw	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.50                        vpcmpeqw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vpcmpeqw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     0.50                        vpcmpgtb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vpcmpgtb	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.50                        vpcmpgtb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vpcmpgtb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     0.50                        vpcmpgtw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vpcmpgtw	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.50                        vpcmpgtw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vpcmpgtw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     0.50                        vpcmpequb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vpcmpequb	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.50                        vpcmpequb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vpcmpequb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     0.50                        vpcmpequw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vpcmpequw	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.50                        vpcmpequw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vpcmpequw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     0.50                        vpcmpeqw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vpcmpeqw	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.50                        vpcmpeqw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vpcmpeqw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     1.00                        vpermw	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     1.00    *                   vpermw	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  1      1     1.00                        vpermw	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     1.00    *                   vpermw	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     1.00                        vpermw	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     1.00    *                   vpermw	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vpshufb	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vpshufb	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vpshufb	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vpshufb	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vpshufb	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vpshufb	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     1.00                        vpshufhw	$0, %zmm16, %zmm19
# CHECK-NEXT:  2      8     1.00    *                   vpshufhw	$0, (%rax), %zmm19
# CHECK-NEXT:  1      1     1.00                        vpshufhw	$0, %zmm16, %zmm19 {%k1}
# CHECK-NEXT:  2      8     1.00    *                   vpshufhw	$0, (%rax), %zmm19 {%k1}
# CHECK-NEXT:  1      1     1.00                        vpshufhw	$0, %zmm16, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     1.00    *                   vpshufhw	$0, (%rax), %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     1.00                        vpshuflw	$0, %zmm16, %zmm19
# CHECK-NEXT:  2      8     1.00    *                   vpshuflw	$0, (%rax), %zmm19
# CHECK-NEXT:  1      1     1.00                        vpshuflw	$0, %zmm16, %zmm19 {%k1}
# CHECK-NEXT:  2      8     1.00    *                   vpshuflw	$0, (%rax), %zmm19 {%k1}
# CHECK-NEXT:  1      1     1.00                        vpshuflw	$0, %zmm16, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     1.00    *                   vpshuflw	$0, (%rax), %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vpsubb	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vpsubb	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vpsubb	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vpsubb	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vpsubb	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vpsubb	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.50                        vpsubw	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     0.50    *                   vpsubw	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  1      1     0.50                        vpsubw	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     0.50    *                   vpsubw	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     0.50                        vpsubw	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     0.50    *                   vpsubw	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     0.33                        vptestmb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vptestmb	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.33                        vptestmb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vptestmb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     0.33                        vptestmw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vptestmw	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.33                        vptestmw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vptestmw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     0.33                        vptestnmb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vptestnmb	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.33                        vptestnmb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vptestnmb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     0.33                        vptestnmw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  2      8     0.50    *                   vptestnmw	(%rax), %zmm1, %k2
# CHECK-NEXT:  1      1     0.33                        vptestnmw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  2      8     0.50    *                   vptestnmw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  1      1     1.00                        vpunpckhbw	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     1.00    *                   vpunpckhbw	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  1      1     1.00                        vpunpckhbw	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     1.00    *                   vpunpckhbw	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     1.00                        vpunpckhbw	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     1.00    *                   vpunpckhbw	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     1.00                        vpunpckhwd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     1.00    *                   vpunpckhwd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  1      1     1.00                        vpunpckhwd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     1.00    *                   vpunpckhwd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     1.00                        vpunpckhwd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     1.00    *                   vpunpckhwd	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     1.00                        vpunpcklbw	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     1.00    *                   vpunpcklbw	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  1      1     1.00                        vpunpcklbw	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     1.00    *                   vpunpcklbw	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     1.00                        vpunpcklbw	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     1.00    *                   vpunpcklbw	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  1      1     1.00                        vpunpcklwd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  2      8     1.00    *                   vpunpcklwd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  1      1     1.00                        vpunpcklwd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  2      8     1.00    *                   vpunpcklwd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  1      1     1.00                        vpunpcklwd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  2      8     1.00    *                   vpunpcklwd	(%rax), %zmm17, %zmm19 {%k1} {z}

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
# CHECK-NEXT:  -      -     9.33   46.33   -     94.33  33.00  33.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     kaddd	%k0, %k1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     kaddq	%k0, %k1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     kandd	%k0, %k1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     kandq	%k0, %k1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     kandnd	%k0, %k1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     kandnq	%k0, %k1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     kord	%k0, %k1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     korq	%k0, %k1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     kxnord	%k0, %k1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     kxnorq	%k0, %k1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     kxord	%k0, %k1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     kxorq	%k0, %k1, %k2
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     kshiftld	$2, %k1, %k2
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     kshiftlq	$2, %k1, %k2
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     kshiftrd	$2, %k1, %k2
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     kshiftrq	$2, %k1, %k2
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     kunpckdq	%k0, %k1, %k2
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     kunpckwd	%k0, %k1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpabsb	%zmm16, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpabsb	(%rax), %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpabsb	%zmm16, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpabsb	(%rax), %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpabsb	%zmm16, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpabsb	(%rax), %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpabsw	%zmm16, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpabsw	(%rax), %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpabsw	%zmm16, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpabsw	(%rax), %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpabsw	%zmm16, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpabsw	(%rax), %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpaddb	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpaddb	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpaddb	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpaddb	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpaddb	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpaddb	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpaddw	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpaddw	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpaddw	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpaddw	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpaddw	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpaddw	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpeqb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpeqb	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpeqb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpeqb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpeqb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpeqb	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpeqb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpeqb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpeqw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpeqw	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpeqw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpeqw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpgtb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpgtb	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpgtb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpgtb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpgtw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpgtw	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpgtw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpgtw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpequb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpequb	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpequb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpequb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpequw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpequw	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpequw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpequw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpeqw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpeqw	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpcmpeqw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpcmpeqw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpermw	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpermw	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpermw	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpermw	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpermw	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpermw	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpshufb	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpshufb	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpshufb	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpshufb	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpshufb	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpshufb	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpshufhw	$0, %zmm16, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpshufhw	$0, (%rax), %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpshufhw	$0, %zmm16, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpshufhw	$0, (%rax), %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpshufhw	$0, %zmm16, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpshufhw	$0, (%rax), %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpshuflw	$0, %zmm16, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpshuflw	$0, (%rax), %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpshuflw	$0, %zmm16, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpshuflw	$0, (%rax), %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpshuflw	$0, %zmm16, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpshuflw	$0, (%rax), %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpsubb	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpsubb	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpsubb	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpsubb	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpsubb	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpsubb	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpsubw	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpsubw	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpsubw	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpsubw	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -     0.50    -     0.50    -      -     vpsubw	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -     0.50    -     0.50   0.50   0.50   vpsubw	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     vptestmb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33   0.50   0.50   vptestmb	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     vptestmb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33   0.50   0.50   vptestmb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     vptestmw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33   0.50   0.50   vptestmw	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     vptestmw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33   0.50   0.50   vptestmw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     vptestnmb	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33   0.50   0.50   vptestnmb	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     vptestnmb	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33   0.50   0.50   vptestnmb	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     vptestnmw	%zmm0, %zmm1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33   0.50   0.50   vptestnmw	(%rax), %zmm1, %k2
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33    -      -     vptestnmw	%zmm0, %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -     0.33   0.33    -     0.33   0.50   0.50   vptestnmw	(%rax), %zmm1, %k2 {%k3}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpckhbw	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpckhbw	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpckhbw	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpckhbw	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpckhbw	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpckhbw	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpckhwd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpckhwd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpckhwd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpckhwd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpckhwd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpckhwd	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpcklbw	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpcklbw	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpcklbw	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpcklbw	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpcklbw	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpcklbw	(%rax), %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpcklwd	%zmm16, %zmm17, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpcklwd	(%rax), %zmm17, %zmm19
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpcklwd	%zmm16, %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpcklwd	(%rax), %zmm17, %zmm19 {%k1}
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -     vpunpcklwd	%zmm16, %zmm17, %zmm19 {%k1} {z}
# CHECK-NEXT:  -      -      -      -      -     1.00   0.50   0.50   vpunpcklwd	(%rax), %zmm17, %zmm19 {%k1} {z}
