; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zbt -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IBT %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64I %s
; RUN: llc -mtriple=riscv64 -mattr=+experimental-zbt -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IBT %s

;; There are a few different ways to lower (select (and A, B), X, Y). This test
;; ensures that we do so with as few branches as possible.

define signext i32 @select_of_and(i1 zeroext %a, i1 zeroext %b, i32 signext %c, i32 signext %d) nounwind {
; RV32I-LABEL: select_of_and:
; RV32I:       # %bb.0:
; RV32I-NEXT:    and a1, a0, a1
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    bnez a1, .LBB0_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a0, a3
; RV32I-NEXT:  .LBB0_2:
; RV32I-NEXT:    ret
;
; RV32IBT-LABEL: select_of_and:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    and a0, a0, a1
; RV32IBT-NEXT:    cmov a0, a0, a2, a3
; RV32IBT-NEXT:    ret
;
; RV64I-LABEL: select_of_and:
; RV64I:       # %bb.0:
; RV64I-NEXT:    and a1, a0, a1
; RV64I-NEXT:    mv a0, a2
; RV64I-NEXT:    bnez a1, .LBB0_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a0, a3
; RV64I-NEXT:  .LBB0_2:
; RV64I-NEXT:    ret
;
; RV64IBT-LABEL: select_of_and:
; RV64IBT:       # %bb.0:
; RV64IBT-NEXT:    and a0, a0, a1
; RV64IBT-NEXT:    cmov a0, a0, a2, a3
; RV64IBT-NEXT:    ret
  %1 = and i1 %a, %b
  %2 = select i1 %1, i32 %c, i32 %d
  ret i32 %2
}

declare signext i32 @both() nounwind
declare signext i32 @neither() nounwind

define signext i32 @if_of_and(i1 zeroext %a, i1 zeroext %b) nounwind {
; RV32I-LABEL: if_of_and:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    beqz a0, .LBB1_2
; RV32I-NEXT:  # %bb.1: # %if.then
; RV32I-NEXT:    call both@plt
; RV32I-NEXT:    j .LBB1_3
; RV32I-NEXT:  .LBB1_2: # %if.else
; RV32I-NEXT:    call neither@plt
; RV32I-NEXT:  .LBB1_3: # %if.end
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV32IBT-LABEL: if_of_and:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    addi sp, sp, -16
; RV32IBT-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IBT-NEXT:    and a0, a0, a1
; RV32IBT-NEXT:    beqz a0, .LBB1_2
; RV32IBT-NEXT:  # %bb.1: # %if.then
; RV32IBT-NEXT:    call both@plt
; RV32IBT-NEXT:    j .LBB1_3
; RV32IBT-NEXT:  .LBB1_2: # %if.else
; RV32IBT-NEXT:    call neither@plt
; RV32IBT-NEXT:  .LBB1_3: # %if.end
; RV32IBT-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IBT-NEXT:    addi sp, sp, 16
; RV32IBT-NEXT:    ret
;
; RV64I-LABEL: if_of_and:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    beqz a0, .LBB1_2
; RV64I-NEXT:  # %bb.1: # %if.then
; RV64I-NEXT:    call both@plt
; RV64I-NEXT:    j .LBB1_3
; RV64I-NEXT:  .LBB1_2: # %if.else
; RV64I-NEXT:    call neither@plt
; RV64I-NEXT:  .LBB1_3: # %if.end
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
;
; RV64IBT-LABEL: if_of_and:
; RV64IBT:       # %bb.0:
; RV64IBT-NEXT:    addi sp, sp, -16
; RV64IBT-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IBT-NEXT:    and a0, a0, a1
; RV64IBT-NEXT:    beqz a0, .LBB1_2
; RV64IBT-NEXT:  # %bb.1: # %if.then
; RV64IBT-NEXT:    call both@plt
; RV64IBT-NEXT:    j .LBB1_3
; RV64IBT-NEXT:  .LBB1_2: # %if.else
; RV64IBT-NEXT:    call neither@plt
; RV64IBT-NEXT:  .LBB1_3: # %if.end
; RV64IBT-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IBT-NEXT:    addi sp, sp, 16
; RV64IBT-NEXT:    ret
  %1 = and i1 %a, %b
  br i1 %1, label %if.then, label %if.else

if.then:
  %2 = tail call i32 @both()
  br label %if.end

if.else:
  %3 = tail call i32 @neither()
  br label %if.end

if.end:
  %4 = phi i32 [%2, %if.then], [%3, %if.else]
  ret i32 %4
}
