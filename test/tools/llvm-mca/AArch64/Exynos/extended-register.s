# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -march=aarch64 -mcpu=exynos-m3 -resource-pressure=false < %s | FileCheck %s -check-prefixes=ALL,EM3
# RUN: llvm-mca -march=aarch64 -mcpu=exynos-m4 -resource-pressure=false < %s | FileCheck %s -check-prefixes=ALL,EM4
# RUN: llvm-mca -march=aarch64 -mcpu=exynos-m5 -resource-pressure=false < %s | FileCheck %s -check-prefixes=ALL,EM5

  sub	w0, w1, w2, sxtb #0
  add	x3, x4, w5, sxth #1
  subs	x6, x7, w8, uxtw #2
  adds	x9, x10, x11, uxtx #3
  sub	w12, w13, w14, uxtb #0
  add	x15, x16, w17, uxth #1
  subs	x18, x19, w20, sxtw #2
  adds	x21, x22, x23, sxtx #3

# ALL:      Iterations:        100
# ALL-NEXT: Instructions:      800

# EM3-NEXT: Total Cycles:      304
# EM4-NEXT: Total Cycles:      304
# EM5-NEXT: Total Cycles:      254

# ALL-NEXT: Total uOps:        800

# EM3:      Dispatch Width:    6
# EM3-NEXT: uOps Per Cycle:    2.63
# EM3-NEXT: IPC:               2.63
# EM3-NEXT: Block RThroughput: 3.0

# EM4:      Dispatch Width:    6
# EM4-NEXT: uOps Per Cycle:    2.63
# EM4-NEXT: IPC:               2.63
# EM4-NEXT: Block RThroughput: 3.0

# EM5:      Dispatch Width:    6
# EM5-NEXT: uOps Per Cycle:    3.15
# EM5-NEXT: IPC:               3.15
# EM5-NEXT: Block RThroughput: 2.5

# ALL:      Instruction Info:
# ALL-NEXT: [1]: #uOps
# ALL-NEXT: [2]: Latency
# ALL-NEXT: [3]: RThroughput
# ALL-NEXT: [4]: MayLoad
# ALL-NEXT: [5]: MayStore
# ALL-NEXT: [6]: HasSideEffects (U)

# ALL:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:

# EM3-NEXT:  1      1     0.25                        sub	w0, w1, w2, sxtb
# EM3-NEXT:  1      2     0.50                        add	x3, x4, w5, sxth #1
# EM3-NEXT:  1      1     0.25                        subs	x6, x7, w8, uxtw #2
# EM3-NEXT:  1      1     0.25                        adds	x9, x10, x11, uxtx #3
# EM3-NEXT:  1      1     0.25                        sub	w12, w13, w14, uxtb
# EM3-NEXT:  1      2     0.50                        add	x15, x16, w17, uxth #1
# EM3-NEXT:  1      2     0.50                        subs	x18, x19, w20, sxtw #2
# EM3-NEXT:  1      2     0.50                        adds	x21, x22, x23, sxtx #3

# EM4-NEXT:  1      1     0.25                        sub	w0, w1, w2, sxtb
# EM4-NEXT:  1      2     0.50                        add	x3, x4, w5, sxth #1
# EM4-NEXT:  1      1     0.25                        subs	x6, x7, w8, uxtw #2
# EM4-NEXT:  1      1     0.25                        adds	x9, x10, x11, uxtx #3
# EM4-NEXT:  1      1     0.25                        sub	w12, w13, w14, uxtb
# EM4-NEXT:  1      2     0.50                        add	x15, x16, w17, uxth #1
# EM4-NEXT:  1      2     0.50                        subs	x18, x19, w20, sxtw #2
# EM4-NEXT:  1      2     0.50                        adds	x21, x22, x23, sxtx #3

# EM5-NEXT:  1      1     0.17                        sub	w0, w1, w2, sxtb
# EM5-NEXT:  1      2     0.50                        add	x3, x4, w5, sxth #1
# EM5-NEXT:  1      1     0.25                        subs	x6, x7, w8, uxtw #2
# EM5-NEXT:  1      1     0.25                        adds	x9, x10, x11, uxtx #3
# EM5-NEXT:  1      1     0.17                        sub	w12, w13, w14, uxtb
# EM5-NEXT:  1      2     0.50                        add	x15, x16, w17, uxth #1
# EM5-NEXT:  1      2     0.50                        subs	x18, x19, w20, sxtw #2
# EM5-NEXT:  1      2     0.50                        adds	x21, x22, x23, sxtx #3
