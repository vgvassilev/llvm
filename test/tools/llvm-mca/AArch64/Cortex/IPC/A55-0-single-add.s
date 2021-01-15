# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=aarch64 -mcpu=cortex-a55 --all-views=false --summary-view --iterations=1000 < %s | FileCheck %s

add	w8, w8, #1

# CHECK:      Iterations:        1000
# CHECK-NEXT: Instructions:      1000
# CHECK-NEXT: Total Cycles:      1003
# CHECK-NEXT: Total uOps:        1000

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    1.00
# CHECK-NEXT: IPC:               1.00
# CHECK-NEXT: Block RThroughput: 0.5
