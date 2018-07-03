// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d -mattr=+sve - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

sxth    z0.s, p0/m, z0.s
// CHECK-INST: sxth    z0.s, p0/m, z0.s
// CHECK-ENCODING: [0x00,0xa0,0x92,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: 00 a0 92 04 <unknown>

sxth    z0.d, p0/m, z0.d
// CHECK-INST: sxth    z0.d, p0/m, z0.d
// CHECK-ENCODING: [0x00,0xa0,0xd2,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: 00 a0 d2 04 <unknown>

sxth    z31.s, p7/m, z31.s
// CHECK-INST: sxth    z31.s, p7/m, z31.s
// CHECK-ENCODING: [0xff,0xbf,0x92,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: ff bf 92 04 <unknown>

sxth    z31.d, p7/m, z31.d
// CHECK-INST: sxth    z31.d, p7/m, z31.d
// CHECK-ENCODING: [0xff,0xbf,0xd2,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: ff bf d2 04 <unknown>
