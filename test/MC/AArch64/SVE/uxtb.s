// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d -mattr=+sve - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve < %s \
// RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

uxtb    z0.h, p0/m, z0.h
// CHECK-INST: uxtb    z0.h, p0/m, z0.h
// CHECK-ENCODING: [0x00,0xa0,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: 00 a0 51 04 <unknown>

uxtb    z0.s, p0/m, z0.s
// CHECK-INST: uxtb    z0.s, p0/m, z0.s
// CHECK-ENCODING: [0x00,0xa0,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: 00 a0 91 04 <unknown>

uxtb    z0.d, p0/m, z0.d
// CHECK-INST: uxtb    z0.d, p0/m, z0.d
// CHECK-ENCODING: [0x00,0xa0,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: 00 a0 d1 04 <unknown>

uxtb    z31.h, p7/m, z31.h
// CHECK-INST: uxtb    z31.h, p7/m, z31.h
// CHECK-ENCODING: [0xff,0xbf,0x51,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: ff bf 51 04 <unknown>

uxtb    z31.s, p7/m, z31.s
// CHECK-INST: uxtb    z31.s, p7/m, z31.s
// CHECK-ENCODING: [0xff,0xbf,0x91,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: ff bf 91 04 <unknown>

uxtb    z31.d, p7/m, z31.d
// CHECK-INST: uxtb    z31.d, p7/m, z31.d
// CHECK-ENCODING: [0xff,0xbf,0xd1,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: ff bf d1 04 <unknown>
