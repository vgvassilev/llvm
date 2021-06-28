## Check that 'llvm-objdump -d' prints comments generated by the disassembler.

# RUN: llvm-mc -filetype=obj -triple=aarch64 -mattr=+sve %s -o %t
# RUN: llvm-objdump -d --mattr=+sve --no-show-raw-insn %t | FileCheck %s

# CHECK:      0000000000000000 <foo>:
# CHECK-NEXT:        0:   add x0, x2, #2, lsl #12    // =8192
# CHECK-NEXT:        4:   add z31.d, z31.d, #65280   // =0xff00

    .text
foo:
    add x0, x2, 8192
    add z31.d, z31.d, #65280
