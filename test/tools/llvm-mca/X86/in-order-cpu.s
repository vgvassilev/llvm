# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca %s -mtriple=x86_64-unknown-unknown -mcpu=atom -o /dev/null 2>&1 | FileCheck %s
movsbw	%al, %di

# CHECK:      warning: support for in-order CPU 'atom' is experimental.
