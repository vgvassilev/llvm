; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -verify-machineinstrs -stop-before=ppc-vsx-copy -vec-extabi \
; RUN:     -mcpu=pwr7  -mtriple powerpc-ibm-aix-xcoff < %s | \
; RUN: FileCheck --check-prefix=32BIT %s

; RUN: llc -verify-machineinstrs -stop-before=ppc-vsx-copy -vec-extabi \
; RUN:     -mcpu=pwr7  -mtriple powerpc64-ibm-aix-xcoff < %s | \
; RUN: FileCheck --check-prefix=64BIT %s

define void @caller() {


  ; 32BIT-LABEL: name: caller
  ; 32BIT: bb.0.entry:
  ; 32BIT:   ADJCALLSTACKDOWN 88, 0, implicit-def dead $r1, implicit $r1
  ; 32BIT:   [[LWZtoc:%[0-9]+]]:gprc = LWZtoc %const.0, $r2 :: (load (s32) from got)
  ; 32BIT:   [[LXVW4X:%[0-9]+]]:vsrc = LXVW4X $zero, killed [[LWZtoc]] :: (load (s128) from constant-pool)
  ; 32BIT:   [[LI:%[0-9]+]]:gprc = LI 64
  ; 32BIT:   STXVW4X killed [[LXVW4X]], $r1, killed [[LI]] :: (store (s128))
  ; 32BIT:   [[LIS:%[0-9]+]]:gprc = LIS 38314
  ; 32BIT:   [[ORI:%[0-9]+]]:gprc = ORI killed [[LIS]], 63376
  ; 32BIT:   STW killed [[ORI]], 84, $r1 :: (store (s32) into unknown-address + 4, basealign 8)
  ; 32BIT:   [[LIS1:%[0-9]+]]:gprc = LIS 16389
  ; 32BIT:   [[ORI1:%[0-9]+]]:gprc = ORI killed [[LIS1]], 48905
  ; 32BIT:   STW killed [[ORI1]], 80, $r1 :: (store (s32), align 8)
  ; 32BIT:   [[LWZtoc1:%[0-9]+]]:gprc = LWZtoc %const.1, $r2 :: (load (s32) from got)
  ; 32BIT:   [[LXVW4X1:%[0-9]+]]:vsrc = LXVW4X $zero, killed [[LWZtoc1]] :: (load (s128) from constant-pool)
  ; 32BIT:   [[LWZtoc2:%[0-9]+]]:gprc_and_gprc_nor0 = LWZtoc %const.2, $r2 :: (load (s32) from got)
  ; 32BIT:   [[LFD:%[0-9]+]]:f8rc = LFD 0, killed [[LWZtoc2]] :: (load (s64) from constant-pool)
  ; 32BIT:   [[LIS2:%[0-9]+]]:gprc = LIS 16393
  ; 32BIT:   [[ORI2:%[0-9]+]]:gprc = ORI killed [[LIS2]], 8697
  ; 32BIT:   [[LIS3:%[0-9]+]]:gprc = LIS 61467
  ; 32BIT:   [[ORI3:%[0-9]+]]:gprc = ORI killed [[LIS3]], 34414
  ; 32BIT:   [[LWZtoc3:%[0-9]+]]:gprc_and_gprc_nor0 = LWZtoc %const.3, $r2 :: (load (s32) from got)
  ; 32BIT:   [[LFD1:%[0-9]+]]:f8rc = LFD 0, killed [[LWZtoc3]] :: (load (s64) from constant-pool)
  ; 32BIT:   [[LI1:%[0-9]+]]:gprc = LI 55
  ; 32BIT:   $r3 = COPY [[LI1]]
  ; 32BIT:   $v2 = COPY [[LXVW4X1]]
  ; 32BIT:   $f1 = COPY [[LFD]]
  ; 32BIT:   $r9 = COPY [[ORI2]]
  ; 32BIT:   $r10 = COPY [[ORI3]]
  ; 32BIT:   $f2 = COPY [[LFD1]]
  ; 32BIT:   BL_NOP <mcsymbol .callee[PR]>, csr_aix32_altivec, implicit-def dead $lr, implicit $rm, implicit $r3, implicit $v2, implicit $f1, implicit $r9, implicit $r10, implicit $f2, implicit $r2, implicit-def $r1, implicit-def $v2
  ; 32BIT:   ADJCALLSTACKUP 88, 0, implicit-def dead $r1, implicit $r1
  ; 32BIT:   [[COPY:%[0-9]+]]:vsrc = COPY $v2
  ; 32BIT:   BLR implicit $lr, implicit $rm
  ; 64BIT-LABEL: name: caller
  ; 64BIT: bb.0.entry:
  ; 64BIT:   ADJCALLSTACKDOWN 120, 0, implicit-def dead $r1, implicit $r1
  ; 64BIT:   [[LDtocCPT:%[0-9]+]]:g8rc = LDtocCPT %const.0, $x2 :: (load (s64) from got)
  ; 64BIT:   [[LXVW4X:%[0-9]+]]:vsrc = LXVW4X $zero8, killed [[LDtocCPT]] :: (load (s128) from constant-pool)
  ; 64BIT:   [[LI8_:%[0-9]+]]:g8rc = LI8 96
  ; 64BIT:   STXVW4X killed [[LXVW4X]], $x1, killed [[LI8_]] :: (store (s128))
  ; 64BIT:   [[LIS8_:%[0-9]+]]:g8rc = LIS8 16389
  ; 64BIT:   [[ORI8_:%[0-9]+]]:g8rc = ORI8 killed [[LIS8_]], 48905
  ; 64BIT:   [[RLDIC:%[0-9]+]]:g8rc = RLDIC killed [[ORI8_]], 32, 1
  ; 64BIT:   [[ORIS8_:%[0-9]+]]:g8rc = ORIS8 killed [[RLDIC]], 38314
  ; 64BIT:   [[ORI8_1:%[0-9]+]]:g8rc = ORI8 killed [[ORIS8_]], 63376
  ; 64BIT:   STD killed [[ORI8_1]], 112, $x1 :: (store (s64))
  ; 64BIT:   [[LDtocCPT1:%[0-9]+]]:g8rc = LDtocCPT %const.1, $x2 :: (load (s64) from got)
  ; 64BIT:   [[LXVW4X1:%[0-9]+]]:vsrc = LXVW4X $zero8, killed [[LDtocCPT1]] :: (load (s128) from constant-pool)
  ; 64BIT:   [[LD:%[0-9]+]]:g8rc = LD 104, $x1 :: (load (s64))
  ; 64BIT:   [[LD1:%[0-9]+]]:g8rc = LD 96, $x1 :: (load (s64))
  ; 64BIT:   [[LDtocCPT2:%[0-9]+]]:g8rc_and_g8rc_nox0 = LDtocCPT %const.2, $x2 :: (load (s64) from got)
  ; 64BIT:   [[LFD:%[0-9]+]]:f8rc = LFD 0, killed [[LDtocCPT2]] :: (load (s64) from constant-pool)
  ; 64BIT:   [[LDtocCPT3:%[0-9]+]]:g8rc_and_g8rc_nox0 = LDtocCPT %const.3, $x2 :: (load (s64) from got)
  ; 64BIT:   [[LFD1:%[0-9]+]]:f8rc = LFD 0, killed [[LDtocCPT3]] :: (load (s64) from constant-pool)
  ; 64BIT:   [[LIS8_1:%[0-9]+]]:g8rc = LIS8 16393
  ; 64BIT:   [[ORI8_2:%[0-9]+]]:g8rc = ORI8 killed [[LIS8_1]], 8697
  ; 64BIT:   [[RLDIC1:%[0-9]+]]:g8rc = RLDIC killed [[ORI8_2]], 32, 1
  ; 64BIT:   [[ORIS8_1:%[0-9]+]]:g8rc = ORIS8 killed [[RLDIC1]], 61467
  ; 64BIT:   [[ORI8_3:%[0-9]+]]:g8rc = ORI8 killed [[ORIS8_1]], 34414
  ; 64BIT:   [[LI8_1:%[0-9]+]]:g8rc = LI8 55
  ; 64BIT:   $x3 = COPY [[LI8_1]]
  ; 64BIT:   $v2 = COPY [[LXVW4X1]]
  ; 64BIT:   $f1 = COPY [[LFD]]
  ; 64BIT:   $x7 = COPY [[ORI8_3]]
  ; 64BIT:   $x9 = COPY [[LD1]]
  ; 64BIT:   $x10 = COPY [[LD]]
  ; 64BIT:   $f2 = COPY [[LFD1]]
  ; 64BIT:   BL8_NOP <mcsymbol .callee[PR]>, csr_ppc64_altivec, implicit-def dead $lr8, implicit $rm, implicit $x3, implicit $v2, implicit $f1, implicit $x7, implicit $x9, implicit $x10, implicit $f2, implicit $x2, implicit-def $r1, implicit-def $v2
  ; 64BIT:   ADJCALLSTACKUP 120, 0, implicit-def dead $r1, implicit $r1
  ; 64BIT:   [[COPY:%[0-9]+]]:vsrc = COPY $v2
  ; 64BIT:   BLR8 implicit $lr8, implicit $rm
entry:
  %call = tail call <4 x i32> (i32, <4 x i32>, double, ...) @callee(i32 signext 55, <4 x i32> <i32 170, i32 187, i32 204, i32 221>, double 3.141590e+00, <4 x i32> <i32 10, i32 20, i32 30, i32 40>, double 2.718280e+00)
  ret void
}

declare <4 x i32> @callee(i32 signext, <4 x i32>, double, ...)

