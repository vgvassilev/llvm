# With B extension:
# RUN: llvm-mc %s -triple=riscv64 -mattr=+experimental-b -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 -mattr=+experimental-b < %s \
# RUN:     | llvm-objdump --mattr=+experimental-b -d -r - \
# RUN:     | FileCheck --check-prefixes=CHECK-OBJ,CHECK-ASM-AND-OBJ %s

# With Bitmanip permutation extension:
# RUN: llvm-mc %s -triple=riscv64 -mattr=+experimental-zbp -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 -mattr=+experimental-zbp < %s \
# RUN:     | llvm-objdump --mattr=+experimental-zbp -d -r - \
# RUN:     | FileCheck --check-prefixes=CHECK-OBJ,CHECK-ASM-AND-OBJ %s

# CHECK-ASM-AND-OBJ: slow t0, t1, t2
# CHECK-ASM: encoding: [0xbb,0x12,0x73,0x20]
slow t0, t1, t2
# CHECK-ASM-AND-OBJ: srow t0, t1, t2
# CHECK-ASM: encoding: [0xbb,0x52,0x73,0x20]
srow t0, t1, t2
# CHECK-ASM-AND-OBJ: sloiw t0, t1, 0
# CHECK-ASM: encoding: [0x9b,0x12,0x03,0x20]
sloiw t0, t1, 0
# CHECK-ASM-AND-OBJ: sroiw t0, t1, 0
# CHECK-ASM: encoding: [0x9b,0x52,0x03,0x20]
sroiw t0, t1, 0
# CHECK-ASM-AND-OBJ: gorcw t0, t1, t2
# CHECK-ASM: encoding: [0xbb,0x52,0x73,0x28]
gorcw t0, t1, t2
# CHECK-ASM-AND-OBJ: grevw t0, t1, t2
# CHECK-ASM: encoding: [0xbb,0x52,0x73,0x68]
grevw t0, t1, t2
# CHECK-ASM-AND-OBJ: gorciw t0, t1, 0
# CHECK-ASM: encoding: [0x9b,0x52,0x03,0x28]
gorciw t0, t1, 0
# CHECK-ASM-AND-OBJ: greviw t0, t1, 0
# CHECK-ASM: encoding: [0x9b,0x52,0x03,0x68]
greviw t0, t1, 0
# CHECK-ASM-AND-OBJ: shflw t0, t1, t2
# CHECK-ASM: encoding: [0xbb,0x12,0x73,0x08]
shflw t0, t1, t2
# CHECK-ASM-AND-OBJ: unshflw t0, t1, t2
# CHECK-ASM: encoding: [0xbb,0x52,0x73,0x08]
unshflw t0, t1, t2
# CHECK-ASM-AND-OBJ: packw t0, t1, t2
# CHECK-ASM: encoding: [0xbb,0x42,0x73,0x08]
packw t0, t1, t2
# CHECK-ASM-AND-OBJ: packuw t0, t1, t2
# CHECK-ASM: encoding: [0xbb,0x42,0x73,0x48]
packuw t0, t1, t2
# CHECK-ASM-AND-OBJ: zext.h t0, t1
# CHECK-ASM: encoding: [0xbb,0x42,0x03,0x08]
zext.h t0, t1
# CHECK-ASM: packw t0, t1, zero
# CHECK-OBJ: zext.h t0, t1
# CHECK-ASM: encoding: [0xbb,0x42,0x03,0x08]
packw t0, t1, x0
# CHECK-ASM-AND-OBJ: rev8 t0, t1
# CHECK-ASM: encoding: [0x93,0x52,0x83,0x6b]
rev8 t0, t1
# CHECK-ASM: grevi t0, t1, 56
# CHECK-OBJ: rev8 t0, t1
# CHECK-ASM: encoding: [0x93,0x52,0x83,0x6b]
grevi t0, t1, 56
# CHECK-ASM-AND-OBJ: orc.b t0, t1
# CHECK-ASM: encoding: [0x93,0x52,0x73,0x28]
orc.b t0, t1
# CHECK-ASM: gorci t0, t1, 7
# CHECK-OBJ: orc.b t0, t1
# CHECK-ASM: encoding: [0x93,0x52,0x73,0x28]
gorci t0, t1, 7
