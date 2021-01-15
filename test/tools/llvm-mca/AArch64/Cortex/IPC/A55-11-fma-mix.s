# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=aarch64 -mcpu=cortex-a55 --all-views=false --summary-view --iterations=1000 < %s | FileCheck %s

# FMADD writes and retires out-of-order
fmadd  s3, s5, s6, s7
# ADD instructions are issued and retire in-order
add    w8, w8, #1
add    w9, w9, #1
add    w10, w10, #1

# CHECK:      Iterations:        1000
# CHECK-NEXT: Instructions:      4000
# CHECK-NEXT: Total Cycles:      2003
# CHECK-NEXT: Total uOps:        4000

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    2.00
# CHECK-NEXT: IPC:               2.00
# CHECK-NEXT: Block RThroughput: 2.0
