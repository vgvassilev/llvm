; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-apple-darwin -mcpu=x86-64 -mattr=+sse2 < %s | FileCheck %s --check-prefixes=CHECK,SSE2-SSSE3,SSE2
; RUN: llc -mtriple=x86_64-apple-darwin -mcpu=x86-64 -mattr=+ssse3 < %s | FileCheck %s --check-prefixes=CHECK,SSE2-SSSE3,SSSE3
; RUN: llc -mtriple=x86_64-apple-darwin -mcpu=x86-64 -mattr=+avx < %s | FileCheck %s --check-prefixes=CHECK,AVX1
; RUN: llc -mtriple=x86_64-apple-darwin -mcpu=x86-64 -mattr=+avx512f,+avx512vl,+avx512bw < %s | FileCheck %s --check-prefixes=CHECK,AVX512

define i8 @v8i16(<8 x i16> %a, <8 x i16> %b) {
; SSE2-SSSE3-LABEL: v8i16:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    pcmpgtw %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pextrw $7, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $6, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $5, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $4, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $3, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $2, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $1, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movd %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v8i16:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vpcmpgtw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpextrw $7, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $6, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $5, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $4, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $3, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $2, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $1, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v8i16:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vpcmpgtw %xmm1, %xmm0, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    ## kill: %AL<def> %AL<kill> %EAX<kill>
; AVX512-NEXT:    retq
  %x = icmp sgt <8 x i16> %a, %b
  %res = bitcast <8 x i1> %x to i8
  ret i8 %res
}

define i4 @v4i32(<4 x i32> %a, <4 x i32> %b) {
; SSE2-SSSE3-LABEL: v4i32:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    pcmpgtd %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    movd %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[3,1,2,3]
; SSE2-SSSE3-NEXT:    movd %xmm1, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE2-SSSE3-NEXT:    movd %xmm1, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; SSE2-SSSE3-NEXT:    movd %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v4i32:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vpcmpgtd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpextrd $3, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrd $2, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrd $1, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v4i32:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vpcmpgtd %xmm1, %xmm0, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX512-NEXT:    retq
  %x = icmp sgt <4 x i32> %a, %b
  %res = bitcast <4 x i1> %x to i4
  ret i4 %res
}

define i4 @v4f32(<4 x float> %a, <4 x float> %b) {
; SSE2-SSSE3-LABEL: v4f32:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    cmpltps %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    movd %xmm1, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movaps %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    shufps {{.*#+}} xmm0 = xmm0[3,1,2,3]
; SSE2-SSSE3-NEXT:    movd %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE2-SSSE3-NEXT:    movd %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1,2,3]
; SSE2-SSSE3-NEXT:    movd %xmm1, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v4f32:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vcmpltps %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    vextractps $3, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vextractps $2, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vextractps $1, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vextractps $0, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v4f32:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vcmpltps %xmm0, %xmm1, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX512-NEXT:    retq
  %x = fcmp ogt <4 x float> %a, %b
  %res = bitcast <4 x i1> %x to i4
  ret i4 %res
}

define i16 @v16i8(<16 x i8> %a, <16 x i8> %b) {
; SSE2-SSSE3-LABEL: v16i8:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    pcmpgtb %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    movdqa %xmm0, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %cl
; SSE2-SSSE3-NEXT:    andb $1, %cl
; SSE2-SSSE3-NEXT:    movb %cl, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    andb $1, %al
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movzwl -{{[0-9]+}}(%rsp), %eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v16i8:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vpcmpgtb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpextrb $15, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $14, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $13, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $12, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $11, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $10, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $9, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $8, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $7, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $6, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $5, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $4, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $3, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $2, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $1, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrb $0, %xmm0, %eax
; AVX1-NEXT:    andb $1, %al
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movzwl -{{[0-9]+}}(%rsp), %eax
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v16i8:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vpcmpgtb %xmm1, %xmm0, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    ## kill: %AX<def> %AX<kill> %EAX<kill>
; AVX512-NEXT:    retq
  %x = icmp sgt <16 x i8> %a, %b
  %res = bitcast <16 x i1> %x to i16
  ret i16 %res
}

define i2 @v2i8(<2 x i8> %a, <2 x i8> %b) {
; SSE2-SSSE3-LABEL: v2i8:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    psllq $56, %xmm0
; SSE2-SSSE3-NEXT:    movdqa %xmm0, %xmm2
; SSE2-SSSE3-NEXT:    psrad $31, %xmm2
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,3,2,3]
; SSE2-SSSE3-NEXT:    psrad $24, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,3,2,3]
; SSE2-SSSE3-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE2-SSSE3-NEXT:    psllq $56, %xmm1
; SSE2-SSSE3-NEXT:    movdqa %xmm1, %xmm2
; SSE2-SSSE3-NEXT:    psrad $31, %xmm2
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,3,2,3]
; SSE2-SSSE3-NEXT:    psrad $24, %xmm1
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,3,2,3]
; SSE2-SSSE3-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
; SSE2-SSSE3-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,0,2147483648,0]
; SSE2-SSSE3-NEXT:    pxor %xmm2, %xmm1
; SSE2-SSSE3-NEXT:    pxor %xmm2, %xmm0
; SSE2-SSSE3-NEXT:    movdqa %xmm0, %xmm2
; SSE2-SSSE3-NEXT:    pcmpgtd %xmm1, %xmm2
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE2-SSSE3-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; SSE2-SSSE3-NEXT:    pand %xmm3, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[1,1,3,3]
; SSE2-SSSE3-NEXT:    por %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    movq %xmm1, %rax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE2-SSSE3-NEXT:    movq %xmm0, %rax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v2i8:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vpsllq $56, %xmm1, %xmm1
; AVX1-NEXT:    vpsrad $31, %xmm1, %xmm2
; AVX1-NEXT:    vpsrad $24, %xmm1, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm1 = xmm1[0,1],xmm2[2,3],xmm1[4,5],xmm2[6,7]
; AVX1-NEXT:    vpsllq $56, %xmm0, %xmm0
; AVX1-NEXT:    vpsrad $31, %xmm0, %xmm2
; AVX1-NEXT:    vpsrad $24, %xmm0, %xmm0
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm2[2,3],xmm0[4,5],xmm2[6,7]
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpextrq $1, %xmm0, %rax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v2i8:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vpsllq $56, %xmm1, %xmm1
; AVX512-NEXT:    vpsraq $56, %xmm1, %xmm1
; AVX512-NEXT:    vpsllq $56, %xmm0, %xmm0
; AVX512-NEXT:    vpsraq $56, %xmm0, %xmm0
; AVX512-NEXT:    vpcmpgtq %xmm1, %xmm0, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX512-NEXT:    retq
  %x = icmp sgt <2 x i8> %a, %b
  %res = bitcast <2 x i1> %x to i2
  ret i2 %res
}

define i2 @v2i16(<2 x i16> %a, <2 x i16> %b) {
; SSE2-SSSE3-LABEL: v2i16:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    psllq $48, %xmm0
; SSE2-SSSE3-NEXT:    movdqa %xmm0, %xmm2
; SSE2-SSSE3-NEXT:    psrad $31, %xmm2
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,3,2,3]
; SSE2-SSSE3-NEXT:    psrad $16, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,3,2,3]
; SSE2-SSSE3-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; SSE2-SSSE3-NEXT:    psllq $48, %xmm1
; SSE2-SSSE3-NEXT:    movdqa %xmm1, %xmm2
; SSE2-SSSE3-NEXT:    psrad $31, %xmm2
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm2 = xmm2[1,3,2,3]
; SSE2-SSSE3-NEXT:    psrad $16, %xmm1
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,3,2,3]
; SSE2-SSSE3-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
; SSE2-SSSE3-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,0,2147483648,0]
; SSE2-SSSE3-NEXT:    pxor %xmm2, %xmm1
; SSE2-SSSE3-NEXT:    pxor %xmm2, %xmm0
; SSE2-SSSE3-NEXT:    movdqa %xmm0, %xmm2
; SSE2-SSSE3-NEXT:    pcmpgtd %xmm1, %xmm2
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE2-SSSE3-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; SSE2-SSSE3-NEXT:    pand %xmm3, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[1,1,3,3]
; SSE2-SSSE3-NEXT:    por %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    movq %xmm1, %rax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE2-SSSE3-NEXT:    movq %xmm0, %rax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v2i16:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vpsllq $48, %xmm1, %xmm1
; AVX1-NEXT:    vpsrad $31, %xmm1, %xmm2
; AVX1-NEXT:    vpsrad $16, %xmm1, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm1 = xmm1[0,1],xmm2[2,3],xmm1[4,5],xmm2[6,7]
; AVX1-NEXT:    vpsllq $48, %xmm0, %xmm0
; AVX1-NEXT:    vpsrad $31, %xmm0, %xmm2
; AVX1-NEXT:    vpsrad $16, %xmm0, %xmm0
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm2[2,3],xmm0[4,5],xmm2[6,7]
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpextrq $1, %xmm0, %rax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v2i16:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vpsllq $48, %xmm1, %xmm1
; AVX512-NEXT:    vpsraq $48, %xmm1, %xmm1
; AVX512-NEXT:    vpsllq $48, %xmm0, %xmm0
; AVX512-NEXT:    vpsraq $48, %xmm0, %xmm0
; AVX512-NEXT:    vpcmpgtq %xmm1, %xmm0, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX512-NEXT:    retq
  %x = icmp sgt <2 x i16> %a, %b
  %res = bitcast <2 x i1> %x to i2
  ret i2 %res
}

define i2 @v2i32(<2 x i32> %a, <2 x i32> %b) {
; SSE2-SSSE3-LABEL: v2i32:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    psllq $32, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,3,2,3]
; SSE2-SSSE3-NEXT:    psrad $31, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,3,2,3]
; SSE2-SSSE3-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm0[0],xmm2[1],xmm0[1]
; SSE2-SSSE3-NEXT:    psllq $32, %xmm1
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,3,2,3]
; SSE2-SSSE3-NEXT:    psrad $31, %xmm1
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,3,2,3]
; SSE2-SSSE3-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; SSE2-SSSE3-NEXT:    movdqa {{.*#+}} xmm1 = [2147483648,0,2147483648,0]
; SSE2-SSSE3-NEXT:    pxor %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pxor %xmm1, %xmm2
; SSE2-SSSE3-NEXT:    movdqa %xmm2, %xmm1
; SSE2-SSSE3-NEXT:    pcmpgtd %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm3 = xmm1[0,0,2,2]
; SSE2-SSSE3-NEXT:    pcmpeqd %xmm0, %xmm2
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[1,1,3,3]
; SSE2-SSSE3-NEXT:    pand %xmm3, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE2-SSSE3-NEXT:    por %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    movq %xmm1, %rax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE2-SSSE3-NEXT:    movq %xmm0, %rax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v2i32:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vpsllq $32, %xmm1, %xmm1
; AVX1-NEXT:    vpsrad $31, %xmm1, %xmm2
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm1 = xmm1[0,1],xmm2[2,3],xmm1[4,5],xmm2[6,7]
; AVX1-NEXT:    vpsllq $32, %xmm0, %xmm0
; AVX1-NEXT:    vpsrad $31, %xmm0, %xmm2
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm2[2,3],xmm0[4,5],xmm2[6,7]
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpextrq $1, %xmm0, %rax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v2i32:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vpsllq $32, %xmm1, %xmm1
; AVX512-NEXT:    vpsraq $32, %xmm1, %xmm1
; AVX512-NEXT:    vpsllq $32, %xmm0, %xmm0
; AVX512-NEXT:    vpsraq $32, %xmm0, %xmm0
; AVX512-NEXT:    vpcmpgtq %xmm1, %xmm0, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX512-NEXT:    retq
  %x = icmp sgt <2 x i32> %a, %b
  %res = bitcast <2 x i1> %x to i2
  ret i2 %res
}

define i2 @v2i64(<2 x i64> %a, <2 x i64> %b) {
; SSE2-SSSE3-LABEL: v2i64:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,0,2147483648,0]
; SSE2-SSSE3-NEXT:    pxor %xmm2, %xmm1
; SSE2-SSSE3-NEXT:    pxor %xmm2, %xmm0
; SSE2-SSSE3-NEXT:    movdqa %xmm0, %xmm2
; SSE2-SSSE3-NEXT:    pcmpgtd %xmm1, %xmm2
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; SSE2-SSSE3-NEXT:    pcmpeqd %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; SSE2-SSSE3-NEXT:    pand %xmm3, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[1,1,3,3]
; SSE2-SSSE3-NEXT:    por %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    movq %xmm1, %rax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE2-SSSE3-NEXT:    movq %xmm0, %rax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v2i64:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpextrq $1, %xmm0, %rax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v2i64:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vpcmpgtq %xmm1, %xmm0, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX512-NEXT:    retq
  %x = icmp sgt <2 x i64> %a, %b
  %res = bitcast <2 x i1> %x to i2
  ret i2 %res
}

define i2 @v2f64(<2 x double> %a, <2 x double> %b) {
; SSE2-SSSE3-LABEL: v2f64:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    cmpltpd %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    movq %xmm1, %rax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE2-SSSE3-NEXT:    movq %xmm0, %rax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v2f64:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vcmpltpd %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    vpextrq $1, %xmm0, %rax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vmovq %xmm0, %rax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v2f64:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vcmpltpd %xmm0, %xmm1, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX512-NEXT:    retq
  %x = fcmp ogt <2 x double> %a, %b
  %res = bitcast <2 x i1> %x to i2
  ret i2 %res
}

define i4 @v4i8(<4 x i8> %a, <4 x i8> %b) {
; SSE2-SSSE3-LABEL: v4i8:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    pslld $24, %xmm1
; SSE2-SSSE3-NEXT:    psrad $24, %xmm1
; SSE2-SSSE3-NEXT:    pslld $24, %xmm0
; SSE2-SSSE3-NEXT:    psrad $24, %xmm0
; SSE2-SSSE3-NEXT:    pcmpgtd %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    movd %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[3,1,2,3]
; SSE2-SSSE3-NEXT:    movd %xmm1, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE2-SSSE3-NEXT:    movd %xmm1, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; SSE2-SSSE3-NEXT:    movd %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v4i8:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vpslld $24, %xmm1, %xmm1
; AVX1-NEXT:    vpsrad $24, %xmm1, %xmm1
; AVX1-NEXT:    vpslld $24, %xmm0, %xmm0
; AVX1-NEXT:    vpsrad $24, %xmm0, %xmm0
; AVX1-NEXT:    vpcmpgtd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpextrd $3, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrd $2, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrd $1, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v4i8:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vpslld $24, %xmm1, %xmm1
; AVX512-NEXT:    vpsrad $24, %xmm1, %xmm1
; AVX512-NEXT:    vpslld $24, %xmm0, %xmm0
; AVX512-NEXT:    vpsrad $24, %xmm0, %xmm0
; AVX512-NEXT:    vpcmpgtd %xmm1, %xmm0, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX512-NEXT:    retq
  %x = icmp sgt <4 x i8> %a, %b
  %res = bitcast <4 x i1> %x to i4
  ret i4 %res
}

define i4 @v4i16(<4 x i16> %a, <4 x i16> %b) {
; SSE2-SSSE3-LABEL: v4i16:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    pslld $16, %xmm1
; SSE2-SSSE3-NEXT:    psrad $16, %xmm1
; SSE2-SSSE3-NEXT:    pslld $16, %xmm0
; SSE2-SSSE3-NEXT:    psrad $16, %xmm0
; SSE2-SSSE3-NEXT:    pcmpgtd %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    movd %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[3,1,2,3]
; SSE2-SSSE3-NEXT:    movd %xmm1, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE2-SSSE3-NEXT:    movd %xmm1, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,2,3]
; SSE2-SSSE3-NEXT:    movd %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v4i16:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vpslld $16, %xmm1, %xmm1
; AVX1-NEXT:    vpsrad $16, %xmm1, %xmm1
; AVX1-NEXT:    vpslld $16, %xmm0, %xmm0
; AVX1-NEXT:    vpsrad $16, %xmm0, %xmm0
; AVX1-NEXT:    vpcmpgtd %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpextrd $3, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrd $2, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrd $1, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v4i16:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vpslld $16, %xmm1, %xmm1
; AVX512-NEXT:    vpsrad $16, %xmm1, %xmm1
; AVX512-NEXT:    vpslld $16, %xmm0, %xmm0
; AVX512-NEXT:    vpsrad $16, %xmm0, %xmm0
; AVX512-NEXT:    vpcmpgtd %xmm1, %xmm0, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX512-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX512-NEXT:    retq
  %x = icmp sgt <4 x i16> %a, %b
  %res = bitcast <4 x i1> %x to i4
  ret i4 %res
}

define i8 @v8i8(<8 x i8> %a, <8 x i8> %b) {
; SSE2-SSSE3-LABEL: v8i8:
; SSE2-SSSE3:       ## BB#0:
; SSE2-SSSE3-NEXT:    psllw $8, %xmm1
; SSE2-SSSE3-NEXT:    psraw $8, %xmm1
; SSE2-SSSE3-NEXT:    psllw $8, %xmm0
; SSE2-SSSE3-NEXT:    psraw $8, %xmm0
; SSE2-SSSE3-NEXT:    pcmpgtw %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pextrw $7, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $6, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $5, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $4, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $3, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $2, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    pextrw $1, %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movd %xmm0, %eax
; SSE2-SSSE3-NEXT:    andl $1, %eax
; SSE2-SSSE3-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; SSE2-SSSE3-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v8i8:
; AVX1:       ## BB#0:
; AVX1-NEXT:    vpsllw $8, %xmm1, %xmm1
; AVX1-NEXT:    vpsraw $8, %xmm1, %xmm1
; AVX1-NEXT:    vpsllw $8, %xmm0, %xmm0
; AVX1-NEXT:    vpsraw $8, %xmm0, %xmm0
; AVX1-NEXT:    vpcmpgtw %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpextrw $7, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $6, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $5, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $4, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $3, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $2, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vpextrw $1, %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    andl $1, %eax
; AVX1-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; AVX1-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; AVX1-NEXT:    retq
;
; AVX512-LABEL: v8i8:
; AVX512:       ## BB#0:
; AVX512-NEXT:    vpsllw $8, %xmm1, %xmm1
; AVX512-NEXT:    vpsraw $8, %xmm1, %xmm1
; AVX512-NEXT:    vpsllw $8, %xmm0, %xmm0
; AVX512-NEXT:    vpsraw $8, %xmm0, %xmm0
; AVX512-NEXT:    vpcmpgtw %xmm1, %xmm0, %k0
; AVX512-NEXT:    kmovd %k0, %eax
; AVX512-NEXT:    ## kill: %AL<def> %AL<kill> %EAX<kill>
; AVX512-NEXT:    retq
  %x = icmp sgt <8 x i8> %a, %b
  %res = bitcast <8 x i1> %x to i8
  ret i8 %res
}
