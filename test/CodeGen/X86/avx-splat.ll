; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --no_x86_scrub_mem_shuffle
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=CHECK,X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=CHECK,X64

define <32 x i8> @funcA(<32 x i8> %a) nounwind uwtable readnone ssp {
; CHECK-LABEL: funcA:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5]
; CHECK-NEXT:    vinsertf128 $1, %xmm0, %ymm0, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  %shuffle = shufflevector <32 x i8> %a, <32 x i8> undef, <32 x i32> <i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5>
  ret <32 x i8> %shuffle
}

define <16 x i16> @funcB(<16 x i16> %a) nounwind uwtable readnone ssp {
; CHECK-LABEL: funcB:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpshufhw {{.*#+}} xmm0 = xmm0[0,1,2,3,5,5,5,5]
; CHECK-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,2,2,2]
; CHECK-NEXT:    vinsertf128 $1, %xmm0, %ymm0, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  %shuffle = shufflevector <16 x i16> %a, <16 x i16> undef, <16 x i32> <i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5>
  ret <16 x i16> %shuffle
}

define <4 x i64> @funcC(i64 %q) nounwind uwtable readnone ssp {
; X86-LABEL: funcC:
; X86:       # %bb.0: # %entry
; X86-NEXT:    vbroadcastsd {{[0-9]+}}(%esp), %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: funcC:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vmovq %rdi, %xmm0
; X64-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,1,0,1]
; X64-NEXT:    vinsertf128 $1, %xmm0, %ymm0, %ymm0
; X64-NEXT:    retq
entry:
  %vecinit.i = insertelement <4 x i64> undef, i64 %q, i32 0
  %vecinit2.i = insertelement <4 x i64> %vecinit.i, i64 %q, i32 1
  %vecinit4.i = insertelement <4 x i64> %vecinit2.i, i64 %q, i32 2
  %vecinit6.i = insertelement <4 x i64> %vecinit4.i, i64 %q, i32 3
  ret <4 x i64> %vecinit6.i
}

define <4 x double> @funcD(double %q) nounwind uwtable readnone ssp {
; X86-LABEL: funcD:
; X86:       # %bb.0: # %entry
; X86-NEXT:    vbroadcastsd {{[0-9]+}}(%esp), %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: funcD:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vmovddup {{.*#+}} xmm0 = xmm0[0,0]
; X64-NEXT:    vinsertf128 $1, %xmm0, %ymm0, %ymm0
; X64-NEXT:    retq
entry:
  %vecinit.i = insertelement <4 x double> undef, double %q, i32 0
  %vecinit2.i = insertelement <4 x double> %vecinit.i, double %q, i32 1
  %vecinit4.i = insertelement <4 x double> %vecinit2.i, double %q, i32 2
  %vecinit6.i = insertelement <4 x double> %vecinit4.i, double %q, i32 3
  ret <4 x double> %vecinit6.i
}

; Test this turns into a broadcast:
;   shuffle (scalar_to_vector (load (ptr + 4))), undef, <0, 0, 0, 0>
;
define <8 x float> @funcE() nounwind {
; X86-LABEL: funcE:
; X86:       # %bb.0: # %allocas
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    testb %al, %al
; X86-NEXT:    # implicit-def: $ymm0
; X86-NEXT:    jne .LBB4_2
; X86-NEXT:  # %bb.1: # %load.i1247
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    andl $-32, %esp
; X86-NEXT:    subl $1312, %esp # imm = 0x520
; X86-NEXT:    vbroadcastss {{[0-9]+}}(%esp), %ymm0
; X86-NEXT:    movl %ebp, %esp
; X86-NEXT:    popl %ebp
; X86-NEXT:  .LBB4_2: # %__load_and_broadcast_32.exit1249
; X86-NEXT:    retl
;
; X64-LABEL: funcE:
; X64:       # %bb.0: # %allocas
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    testb %al, %al
; X64-NEXT:    # implicit-def: $ymm0
; X64-NEXT:    jne .LBB4_2
; X64-NEXT:  # %bb.1: # %load.i1247
; X64-NEXT:    pushq %rbp
; X64-NEXT:    movq %rsp, %rbp
; X64-NEXT:    andq $-32, %rsp
; X64-NEXT:    subq $1312, %rsp # imm = 0x520
; X64-NEXT:    vbroadcastss {{[0-9]+}}(%rsp), %ymm0
; X64-NEXT:    movq %rbp, %rsp
; X64-NEXT:    popq %rbp
; X64-NEXT:  .LBB4_2: # %__load_and_broadcast_32.exit1249
; X64-NEXT:    retq
allocas:
  %udx495 = alloca [18 x [18 x float]], align 32
  br label %for_test505.preheader

for_test505.preheader:                            ; preds = %for_test505.preheader, %allocas
  br i1 undef, label %for_exit499, label %for_test505.preheader

for_exit499:                                      ; preds = %for_test505.preheader
  br i1 undef, label %__load_and_broadcast_32.exit1249, label %load.i1247

load.i1247:                                       ; preds = %for_exit499
  %ptr1227 = getelementptr [18 x [18 x float]], [18 x [18 x float]]* %udx495, i64 0, i64 1, i64 1
  %ptr.i1237 = bitcast float* %ptr1227 to i32*
  %val.i1238 = load i32, i32* %ptr.i1237, align 4
  %ret6.i1245 = insertelement <8 x i32> undef, i32 %val.i1238, i32 6
  %ret7.i1246 = insertelement <8 x i32> %ret6.i1245, i32 %val.i1238, i32 7
  %phitmp = bitcast <8 x i32> %ret7.i1246 to <8 x float>
  br label %__load_and_broadcast_32.exit1249

__load_and_broadcast_32.exit1249:                 ; preds = %load.i1247, %for_exit499
  %load_broadcast12281250 = phi <8 x float> [ %phitmp, %load.i1247 ], [ undef, %for_exit499 ]
  ret <8 x float> %load_broadcast12281250
}

define <8 x float> @funcF(i32 %val) nounwind {
; X86-LABEL: funcF:
; X86:       # %bb.0:
; X86-NEXT:    vbroadcastss {{[0-9]+}}(%esp), %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: funcF:
; X64:       # %bb.0:
; X64-NEXT:    vmovd %edi, %xmm0
; X64-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; X64-NEXT:    vinsertf128 $1, %xmm0, %ymm0, %ymm0
; X64-NEXT:    retq
  %ret6 = insertelement <8 x i32> undef, i32 %val, i32 6
  %ret7 = insertelement <8 x i32> %ret6, i32 %val, i32 7
  %tmp = bitcast <8 x i32> %ret7 to <8 x float>
  ret <8 x float> %tmp
}

define <8 x float> @funcG(<8 x float> %a) nounwind uwtable readnone ssp {
; CHECK-LABEL: funcG:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpermilps {{.*#+}} xmm0 = xmm0[0,0,0,0]
; CHECK-NEXT:    vinsertf128 $1, %xmm0, %ymm0, %ymm0
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  %shuffle = shufflevector <8 x float> %a, <8 x float> undef, <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  ret <8 x float> %shuffle
}

define <8 x float> @funcH(<8 x float> %a) nounwind uwtable readnone ssp {
; CHECK-LABEL: funcH:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vperm2f128 {{.*#+}} ymm0 = ymm0[2,3,2,3]
; CHECK-NEXT:    vpermilps {{.*#+}} ymm0 = ymm0[1,1,1,1,5,5,5,5]
; CHECK-NEXT:    ret{{[l|q]}}
entry:
  %shuffle = shufflevector <8 x float> %a, <8 x float> undef, <8 x i32> <i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5>
  ret <8 x float> %shuffle
}

define <2 x double> @splat_load_2f64_11(<2 x double>* %ptr) {
; X86-LABEL: splat_load_2f64_11:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    vmovddup 8(%eax), %xmm0 # xmm0 = mem[0,0]
; X86-NEXT:    retl
;
; X64-LABEL: splat_load_2f64_11:
; X64:       # %bb.0:
; X64-NEXT:    vmovddup 8(%rdi), %xmm0 # xmm0 = mem[0,0]
; X64-NEXT:    retq
  %x = load <2 x double>, <2 x double>* %ptr
  %x1 = shufflevector <2 x double> %x, <2 x double> undef, <2 x i32> <i32 1, i32 1>
  ret <2 x double> %x1
}

define <4 x double> @splat_load_4f64_2222(<4 x double>* %ptr) {
; X86-LABEL: splat_load_4f64_2222:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    vbroadcastsd 16(%eax), %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: splat_load_4f64_2222:
; X64:       # %bb.0:
; X64-NEXT:    vbroadcastsd 16(%rdi), %ymm0
; X64-NEXT:    retq
  %x = load <4 x double>, <4 x double>* %ptr
  %x1 = shufflevector <4 x double> %x, <4 x double> undef, <4 x i32> <i32 2, i32 2, i32 2, i32 2>
  ret <4 x double> %x1
}

define <4 x float> @splat_load_4f32_0000(<4 x float>* %ptr) {
; X86-LABEL: splat_load_4f32_0000:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    vbroadcastss (%eax), %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: splat_load_4f32_0000:
; X64:       # %bb.0:
; X64-NEXT:    vbroadcastss (%rdi), %xmm0
; X64-NEXT:    retq
  %x = load <4 x float>, <4 x float>* %ptr
  %x1 = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 0, i32 0, i32 0, i32 0>
  ret <4 x float> %x1
}

define <8 x float> @splat_load_8f32_77777777(<8 x float>* %ptr) {
; X86-LABEL: splat_load_8f32_77777777:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    vbroadcastss 28(%eax), %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: splat_load_8f32_77777777:
; X64:       # %bb.0:
; X64-NEXT:    vbroadcastss 28(%rdi), %ymm0
; X64-NEXT:    retq
  %x = load <8 x float>, <8 x float>* %ptr
  %x1 = shufflevector <8 x float> %x, <8 x float> undef, <8 x i32> <i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7>
  ret <8 x float> %x1
}
