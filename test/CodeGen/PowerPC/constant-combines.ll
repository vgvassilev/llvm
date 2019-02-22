; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=powerpc64-unknown-linux-gnu   -o - %s | FileCheck --check-prefix=BE %s 
; RUN: llc -mtriple=powerpc64le-unknown-linux-gnu -o - %s | FileCheck --check-prefix=LE %s

define void @fold_constant_stores_loaddr(i8* %i8_ptr) {
; BE-LABEL: fold_constant_stores_loaddr:
; BE:       # %bb.0: # %entry
; BE-NEXT:    li 4, 85
; BE-NEXT:    sldi 4, 4, 57
; BE-NEXT:    std 4, 0(3)
; BE-NEXT:    blr
;
; LE-LABEL: fold_constant_stores_loaddr:
; LE:       # %bb.0: # %entry
; LE-NEXT:    li 4, 170
; LE-NEXT:    std 4, 0(3)
; LE-NEXT:    blr
entry:
  %i64_ptr = bitcast i8* %i8_ptr to i64*
  store i64   0, i64* %i64_ptr, align 8
  store i8  170,  i8*  %i8_ptr,  align 1
  ret void
}


define void @fold_constant_stores_hiaddr(i8* %i8_ptr) {
; BE-LABEL: fold_constant_stores_hiaddr:
; BE:       # %bb.0: # %entry
; BE-NEXT:    li 4, 85
; BE-NEXT:    sldi 4, 4, 57
; BE-NEXT:    std 4, 0(3)
; BE-NEXT:    blr
;
; LE-LABEL: fold_constant_stores_hiaddr:
; LE:       # %bb.0: # %entry
; LE-NEXT:    li 4, 170
; LE-NEXT:    std 4, 0(3)
; LE-NEXT:    blr
entry:
  %i64_ptr = bitcast i8* %i8_ptr to i64*
  store i64   0, i64* %i64_ptr, align 8
  %i8_ptr2 = getelementptr inbounds i8, i8* %i8_ptr, i64 7
  store i8  170,  i8*  %i8_ptr,  align 1
  ret void
}
