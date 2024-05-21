	.text
	.file	"minmax.ispc"
	.p2align	4, 0x90                         # -- Begin function __new_varying32_64rt
	.type	__new_varying32_64rt,@function
__new_varying32_64rt:                   # @__new_varying32_64rt
	.cfi_startproc
# %bb.0:                                # %pl_loop.preheader
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	andq	$-64, %rsp
	subq	$128, %rsp
	.cfi_offset %rbx, -24
	vxorps	%xmm1, %xmm1, %xmm1
	vmovaps	%ymm1, 32(%rsp)
	vmovaps	%ymm1, (%rsp)
	vmovmskps	%ymm0, %ebx
	testb	$1, %bl
	jne	.LBB0_1
# %bb.2:                                # %pl_loopend
	testb	$2, %bl
	jne	.LBB0_3
.LBB0_4:                                # %pl_loopend.1
	testb	$4, %bl
	jne	.LBB0_5
.LBB0_6:                                # %pl_loopend.2
	testb	$8, %bl
	jne	.LBB0_7
.LBB0_8:                                # %pl_loopend.3
	testb	$16, %bl
	jne	.LBB0_9
.LBB0_10:                               # %pl_loopend.4
	testb	$32, %bl
	jne	.LBB0_11
.LBB0_12:                               # %pl_loopend.5
	testb	$64, %bl
	jne	.LBB0_13
.LBB0_14:                               # %pl_loopend.6
	testb	%bl, %bl
	js	.LBB0_15
.LBB0_16:                               # %pl_done
	vmovaps	(%rsp), %ymm0
	vmovaps	32(%rsp), %ymm1
	leaq	-8(%rbp), %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB0_1:                                # %pl_dolane
	.cfi_def_cfa %rbp, 16
	movq	%rsp, %rdi
	movl	$32, %esi
	movl	$8, %edx
	vzeroupper
	callq	posix_memalign@PLT
	testb	$2, %bl
	je	.LBB0_4
.LBB0_3:                                # %pl_dolane.1
	leaq	8(%rsp), %rdi
	movl	$32, %esi
	movl	$8, %edx
	vzeroupper
	callq	posix_memalign@PLT
	testb	$4, %bl
	je	.LBB0_6
.LBB0_5:                                # %pl_dolane.2
	leaq	16(%rsp), %rdi
	movl	$32, %esi
	movl	$8, %edx
	vzeroupper
	callq	posix_memalign@PLT
	testb	$8, %bl
	je	.LBB0_8
.LBB0_7:                                # %pl_dolane.3
	leaq	24(%rsp), %rdi
	movl	$32, %esi
	movl	$8, %edx
	vzeroupper
	callq	posix_memalign@PLT
	testb	$16, %bl
	je	.LBB0_10
.LBB0_9:                                # %pl_dolane.4
	leaq	32(%rsp), %rdi
	movl	$32, %esi
	movl	$8, %edx
	vzeroupper
	callq	posix_memalign@PLT
	testb	$32, %bl
	je	.LBB0_12
.LBB0_11:                               # %pl_dolane.5
	leaq	40(%rsp), %rdi
	movl	$32, %esi
	movl	$8, %edx
	vzeroupper
	callq	posix_memalign@PLT
	testb	$64, %bl
	je	.LBB0_14
.LBB0_13:                               # %pl_dolane.6
	leaq	48(%rsp), %rdi
	movl	$32, %esi
	movl	$8, %edx
	vzeroupper
	callq	posix_memalign@PLT
	testb	%bl, %bl
	jns	.LBB0_16
.LBB0_15:                               # %pl_dolane.7
	leaq	56(%rsp), %rdi
	movl	$32, %esi
	movl	$8, %edx
	vzeroupper
	callq	posix_memalign@PLT
	jmp	.LBB0_16
.Lfunc_end0:
	.size	__new_varying32_64rt, .Lfunc_end0-__new_varying32_64rt
	.cfi_endproc
                                        # -- End function
	.globl	check_local_compare_is_done___vy_3C_unf_3E_uni # -- Begin function check_local_compare_is_done___vy_3C_unf_3E_uni
	.p2align	4, 0x90
	.type	check_local_compare_is_done___vy_3C_unf_3E_uni,@function
check_local_compare_is_done___vy_3C_unf_3E_uni: # @check_local_compare_is_done___vy_3C_unf_3E_uni
# %bb.0:                                # %allocas
	vmovmskps	%ymm2, %eax
	vmovd	%edi, %xmm3
	vpbroadcastd	%xmm3, %ymm12
	cmpb	$-1, %al
	je	.LBB1_6
# %bb.1:                                # %for_test50.preheader
	vpxor	%xmm14, %xmm14, %xmm14
	vpcmpgtd	%ymm14, %ymm12, %ymm5
	vpand	%ymm2, %ymm5, %ymm9
	vmovmskps	%ymm9, %ecx
	testb	%cl, %cl
	je	.LBB1_11
# %bb.2:                                # %for_loop51.preheader
	vpcmpeqd	%ymm11, %ymm11, %ymm11
	vpxor	%xmm8, %xmm8, %xmm8
	vxorps	%xmm7, %xmm7, %xmm7
	.p2align	4, 0x90
.LBB1_3:                                # %for_loop51
                                        # =>This Inner Loop Header: Depth=1
	vpslld	$2, %ymm8, %ymm3
	vpmovsxdq	%xmm3, %ymm10
	vextracti128	$1, %ymm3, %xmm3
	vpmovsxdq	%xmm3, %ymm3
	vpaddq	%ymm0, %ymm10, %ymm10
	vextractf128	$1, %ymm9, %xmm6
	vxorps	%xmm13, %xmm13, %xmm13
	vgatherqps	%xmm9, (,%ymm10), %xmm13
	vpaddq	%ymm1, %ymm3, %ymm3
	vxorps	%xmm4, %xmm4, %xmm4
	vgatherqps	%xmm6, (,%ymm3), %xmm4
	vinsertf128	$1, %xmm4, %ymm13, %ymm3
	vcmpeqps	%ymm3, %ymm14, %ymm3
	vandps	%ymm5, %ymm3, %ymm3
	vandps	%ymm2, %ymm3, %ymm3
	vorps	%ymm7, %ymm3, %ymm7
	vmovmskps	%ymm7, %ecx
	cmpb	%cl, %al
	je	.LBB1_14
# %bb.4:                                # %no_return87
                                        #   in Loop: Header=BB1_3 Depth=1
	vandnps	%ymm5, %ymm7, %ymm3
	vpsubd	%ymm11, %ymm8, %ymm8
	vpcmpgtd	%ymm8, %ymm12, %ymm4
	vpand	%ymm3, %ymm4, %ymm5
	vpand	%ymm2, %ymm5, %ymm9
	vmovmskps	%ymm9, %ecx
	testb	%cl, %cl
	jne	.LBB1_3
# %bb.5:                                # %for_test50.for_exit53_crit_edge
	vpcmpeqd	%ymm0, %ymm0, %ymm0
	vxorps	%ymm0, %ymm7, %ymm0
	vpslld	$31, %ymm0, %ymm0
	vpsrad	$31, %ymm0, %ymm0
	retq
.LBB1_6:                                # %for_test.preheader
	vpxor	%xmm11, %xmm11, %xmm11
	vpcmpgtd	%ymm11, %ymm12, %ymm4
	vmovmskps	%ymm4, %eax
	testb	%al, %al
	je	.LBB1_11
# %bb.7:                                # %for_loop.lr.ph
	vpcmpeqd	%ymm10, %ymm10, %ymm10
	vpxor	%xmm7, %xmm7, %xmm7
	vxorps	%xmm6, %xmm6, %xmm6
	.p2align	4, 0x90
.LBB1_8:                                # %for_loop
                                        # =>This Inner Loop Header: Depth=1
	vpslld	$2, %ymm7, %ymm8
	vpmovsxdq	%xmm8, %ymm9
	vextracti128	$1, %ymm8, %xmm5
	vpmovsxdq	%xmm5, %ymm5
	vpaddq	%ymm1, %ymm5, %ymm5
	vpaddq	%ymm0, %ymm9, %ymm8
	vpxor	%xmm9, %xmm9, %xmm9
	vmovaps	%xmm4, %xmm2
	vgatherqps	%xmm2, (,%ymm8), %xmm9
	vextractf128	$1, %ymm4, %xmm2
	vpxor	%xmm3, %xmm3, %xmm3
	vgatherqps	%xmm2, (,%ymm5), %xmm3
	vinsertf128	$1, %xmm3, %ymm9, %ymm2
	vcmpeqps	%ymm2, %ymm11, %ymm2
	vandps	%ymm4, %ymm2, %ymm2
	vorps	%ymm6, %ymm2, %ymm6
	vmovmskps	%ymm6, %eax
	cmpb	$-1, %al
	je	.LBB1_14
# %bb.9:                                # %no_return
                                        #   in Loop: Header=BB1_8 Depth=1
	vandnps	%ymm4, %ymm6, %ymm2
	vpsubd	%ymm10, %ymm7, %ymm7
	vpcmpgtd	%ymm7, %ymm12, %ymm3
	vpand	%ymm2, %ymm3, %ymm4
	vmovmskps	%ymm4, %eax
	testb	%al, %al
	jne	.LBB1_8
# %bb.10:                               # %for_test.for_exit_crit_edge
	vpcmpeqd	%ymm0, %ymm0, %ymm0
	vxorps	%ymm0, %ymm6, %ymm0
	vpslld	$31, %ymm0, %ymm0
	vpsrad	$31, %ymm0, %ymm0
	retq
.LBB1_11:
	vpcmpeqd	%ymm0, %ymm0, %ymm0
	retq
.LBB1_14:
	vpxor	%xmm0, %xmm0, %xmm0
	retq
.Lfunc_end1:
	.size	check_local_compare_is_done___vy_3C_unf_3E_uni, .Lfunc_end1-check_local_compare_is_done___vy_3C_unf_3E_uni
                                        # -- End function
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5                               # -- Begin function parallelmin___un_3C_unf_3E_uni
.LCPI2_0:
	.quad	4                               # 0x4
	.quad	5                               # 0x5
	.quad	6                               # 0x6
	.quad	7                               # 0x7
.LCPI2_1:
	.quad	0                               # 0x0
	.quad	1                               # 0x1
	.quad	2                               # 0x2
	.quad	3                               # 0x3
.LCPI2_3:
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	4                               # 0x4
	.byte	5                               # 0x5
	.byte	8                               # 0x8
	.byte	9                               # 0x9
	.byte	12                              # 0xc
	.byte	13                              # 0xd
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.byte	16                              # 0x10
	.byte	17                              # 0x11
	.byte	20                              # 0x14
	.byte	21                              # 0x15
	.byte	24                              # 0x18
	.byte	25                              # 0x19
	.byte	28                              # 0x1c
	.byte	29                              # 0x1d
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI2_2:
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
.LCPI2_4:
	.byte	0                               # 0x0
	.byte	2                               # 0x2
	.byte	4                               # 0x4
	.byte	6                               # 0x6
	.byte	8                               # 0x8
	.byte	10                              # 0xa
	.byte	12                              # 0xc
	.byte	14                              # 0xe
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
.LCPI2_5:
	.zero	16,128
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI2_6:
	.long	8                               # 0x8
	.text
	.globl	parallelmin___un_3C_unf_3E_uni
	.p2align	4, 0x90
	.type	parallelmin___un_3C_unf_3E_uni,@function
parallelmin___un_3C_unf_3E_uni:         # @parallelmin___un_3C_unf_3E_uni
# %bb.0:                                # %allocas
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	movl	%esi, %ebp
	movq	%rdi, %rbx
	vmovmskps	%ymm0, %r14d
	cmpb	$-1, %r14b
	je	.LBB2_10
# %bb.1:                                # %some_on
	vmovups	%ymm0, (%rsp)                   # 32-byte Spill
	callq	__new_varying32_64rt
	vpaddq	.LCPI2_1(%rip), %ymm0, %ymm0
	movzbl	%r14b, %eax
	testb	$1, %al
	jne	.LBB2_27
# %bb.2:                                # %pl_loopend.i642
	testb	$2, %al
	jne	.LBB2_28
.LBB2_3:                                # %pl_loopend.1.i648
	vextracti128	$1, %ymm0, %xmm2
	testb	$4, %al
	vmovups	(%rsp), %ymm15                  # 32-byte Reload
	jne	.LBB2_29
.LBB2_4:                                # %pl_loopend.2.i654
	testb	$8, %al
	jne	.LBB2_30
.LBB2_5:                                # %pl_loopend.3.i660
	vpaddq	.LCPI2_0(%rip), %ymm1, %ymm1
	testb	$16, %al
	jne	.LBB2_31
.LBB2_6:                                # %pl_loopend.4.i666
	testb	$32, %al
	jne	.LBB2_32
.LBB2_7:                                # %pl_loopend.5.i672
	vextracti128	$1, %ymm1, %xmm3
	testb	$64, %al
	jne	.LBB2_33
.LBB2_8:                                # %pl_loopend.6.i677
	testb	%r14b, %r14b
	js	.LBB2_34
.LBB2_9:                                # %__scatter64_i8.exit681
	testl	%ebp, %ebp
	jg	.LBB2_35
	jmp	.LBB2_39
.LBB2_10:                               # %all_on
	vpcmpeqd	%ymm0, %ymm0, %ymm0
	callq	__new_varying32_64rt
	vpaddq	.LCPI2_0(%rip), %ymm1, %ymm1
	vpaddq	.LCPI2_1(%rip), %ymm0, %ymm0
	vmovq	%xmm0, %r8
	vpextrq	$1, %xmm0, %r9
	movb	$0, (%r8)
	movb	$0, (%r9)
	vextracti128	$1, %ymm0, %xmm0
	vmovq	%xmm0, %r10
	movb	$0, (%r10)
	vpextrq	$1, %xmm0, %r11
	movb	$0, (%r11)
	vmovq	%xmm1, %r14
	movb	$0, (%r14)
	vpextrq	$1, %xmm1, %r15
	movb	$0, (%r15)
	vextracti128	$1, %ymm1, %xmm0
	vmovq	%xmm0, %r12
	movb	$0, (%r12)
	vpextrq	$1, %xmm0, %rdx
	movb	$0, (%rdx)
	testl	%ebp, %ebp
	jle	.LBB2_15
# %bb.11:                               # %for_loop.lr.ph
	xorl	%esi, %esi
	xorl	%edi, %edi
	jmp	.LBB2_13
	.p2align	4, 0x90
.LBB2_12:                               # %safe_if_after_true
                                        #   in Loop: Header=BB2_13 Depth=1
	addl	$8, %edi
	addl	$32, %esi
	cmpl	%ebp, %edi
	jge	.LBB2_15
.LBB2_13:                               # %for_loop
                                        # =>This Inner Loop Header: Depth=1
	movslq	%esi, %rax
	vmovups	(%rbx,%rax), %ymm0
	vcmpltps	(%rbx), %ymm0, %ymm0
	vmovmskps	%ymm0, %ecx
	testb	%cl, %cl
	je	.LBB2_12
# %bb.14:                               # %safe_if_run_true
                                        #   in Loop: Header=BB2_13 Depth=1
	addq	%rbx, %rax
	vmaskmovps	(%rax), %ymm0, %ymm1
	vmaskmovps	%ymm1, %ymm0, (%rbx)
	jmp	.LBB2_12
.LBB2_15:                               # %for_exit
	movb	$-1, (%r8)
	movb	$-1, (%r9)
	movb	$-1, (%r10)
	movb	$-1, (%r11)
	movb	$-1, (%r14)
	movb	$-1, (%r15)
	movb	$-1, (%r12)
	movb	$-1, (%rdx)
	vmovaps	.LCPI2_2(%rip), %xmm0           # xmm0 = [4294967295,0,0,0]
	vmovdqa	.LCPI2_3(%rip), %ymm1           # ymm1 = <0,1,4,5,8,9,12,13,u,u,u,u,u,u,u,u,16,17,20,21,24,25,28,29,u,u,u,u,u,u,u,u>
	vmovdqa	.LCPI2_4(%rip), %xmm2           # xmm2 = <0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u>
	vpcmpeqd	%xmm12, %xmm12, %xmm12
	vxorps	%xmm13, %xmm13, %xmm13
	vmovdqa	.LCPI2_5(%rip), %xmm5           # xmm5 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
	vpxor	%xmm6, %xmm6, %xmm6
                                        # implicit-def: $xmm7
	vpcmpeqd	%ymm14, %ymm14, %ymm14
	jmp	.LBB2_19
	.p2align	4, 0x90
.LBB2_16:                               #   in Loop: Header=BB2_19 Depth=1
	vxorps	%xmm9, %xmm9, %xmm9
.LBB2_17:                               # %for_exit.i519
                                        #   in Loop: Header=BB2_19 Depth=1
	vpshufb	%ymm1, %ymm9, %ymm3
	vpermq	$232, %ymm3, %ymm3              # ymm3 = ymm3[0,2,2,3]
	vpshufb	%xmm2, %xmm3, %xmm3
	vpsllw	$7, %xmm3, %xmm3
	vpblendvb	%xmm3, %xmm7, %xmm12, %xmm7
.LBB2_18:                               # %check_local_compare_is_done___vy_3C_unf_3E_uni.exit558
                                        #   in Loop: Header=BB2_19 Depth=1
	vpxor	%xmm7, %xmm12, %xmm3
	vpmovsxbd	%xmm3, %ymm3
	vpand	%ymm3, %ymm0, %ymm0
	vmovmskps	%ymm0, %eax
	testb	%al, %al
	je	.LBB2_63
.LBB2_19:                               # %for_test71
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_25 Depth 2
                                        #     Child Loop BB2_22 Depth 2
	vmovmskps	%ymm0, %eax
	testb	%al, %al
	je	.LBB2_16
# %bb.20:                               # %for_test71
                                        #   in Loop: Header=BB2_19 Depth=1
	vpxor	%xmm8, %xmm8, %xmm8
	vpcmpeqd	%ymm10, %ymm10, %ymm10
	cmpb	$-1, %al
	jne	.LBB2_24
# %bb.21:                               # %for_loop.i515.preheader
                                        #   in Loop: Header=BB2_19 Depth=1
	xorl	%eax, %eax
	vpxor	%xmm9, %xmm9, %xmm9
	.p2align	4, 0x90
.LBB2_22:                               # %for_loop.i515
                                        #   Parent Loop BB2_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%eax, %rcx
	vmovss	(%rbx,%rcx), %xmm11             # xmm11 = mem[0],zero,zero,zero
	vcmpeqps	%ymm13, %ymm11, %ymm11
	vpbroadcastw	%xmm11, %xmm3
	vpmovsxwd	%xmm3, %ymm3
	vpand	%ymm3, %ymm10, %ymm3
	vpshufb	%ymm1, %ymm3, %ymm11
	vpermq	$232, %ymm11, %ymm11            # ymm11 = ymm11[0,2,2,3]
	vpshufb	%xmm2, %xmm11, %xmm4
	vpsllw	$7, %xmm4, %xmm4
	vpand	%xmm5, %xmm4, %xmm4
	vpcmpgtb	%xmm4, %xmm6, %xmm4
	vpandn	%xmm7, %xmm4, %xmm7
	vpor	%ymm3, %ymm9, %ymm9
	vmovmskps	%ymm9, %ecx
	cmpb	$-1, %cl
	je	.LBB2_18
# %bb.23:                               # %no_return.i550
                                        #   in Loop: Header=BB2_22 Depth=2
	vpandn	%ymm10, %ymm9, %ymm3
	vpsubd	%ymm14, %ymm8, %ymm8
	vpbroadcastd	.LCPI2_6(%rip), %ymm4   # ymm4 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm8, %ymm4, %ymm4
	vpand	%ymm3, %ymm4, %ymm10
	vmovmskps	%ymm10, %ecx
	addl	$4, %eax
	testb	%cl, %cl
	jne	.LBB2_22
	jmp	.LBB2_17
	.p2align	4, 0x90
.LBB2_24:                               # %for_loop51.i539.preheader
                                        #   in Loop: Header=BB2_19 Depth=1
	xorl	%ecx, %ecx
	vpxor	%xmm9, %xmm9, %xmm9
	.p2align	4, 0x90
.LBB2_25:                               # %for_loop51.i539
                                        #   Parent Loop BB2_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%ecx, %rdx
	vmovss	(%rbx,%rdx), %xmm3              # xmm3 = mem[0],zero,zero,zero
	vcmpeqps	%ymm3, %ymm13, %ymm3
	vpbroadcastw	%xmm3, %xmm3
	vpmovsxwd	%xmm3, %ymm3
	vpand	%ymm3, %ymm10, %ymm3
	vpshufb	%ymm1, %ymm3, %ymm4
	vpermq	$232, %ymm4, %ymm4              # ymm4 = ymm4[0,2,2,3]
	vpshufb	%xmm2, %xmm4, %xmm4
	vpsllw	$7, %xmm4, %xmm4
	vpand	%xmm5, %xmm4, %xmm4
	vpcmpgtb	%xmm4, %xmm6, %xmm4
	vpandn	%xmm7, %xmm4, %xmm7
	vpand	%ymm0, %ymm3, %ymm3
	vpor	%ymm3, %ymm9, %ymm9
	vmovmskps	%ymm9, %edx
	cmpb	%dl, %al
	je	.LBB2_18
# %bb.26:                               # %no_return87.i557
                                        #   in Loop: Header=BB2_25 Depth=2
	vpandn	%ymm10, %ymm9, %ymm3
	vpsubd	%ymm14, %ymm8, %ymm8
	vpbroadcastd	.LCPI2_6(%rip), %ymm4   # ymm4 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm8, %ymm4, %ymm4
	vpand	%ymm3, %ymm4, %ymm10
	vpand	%ymm0, %ymm10, %ymm3
	vmovmskps	%ymm3, %edx
	addl	$4, %ecx
	testb	%dl, %dl
	jne	.LBB2_25
	jmp	.LBB2_17
.LBB2_27:                               # %pl_dolane.i639
	vmovq	%xmm0, %rcx
	movb	$0, (%rcx)
	testb	$2, %al
	je	.LBB2_3
.LBB2_28:                               # %pl_dolane.1.i645
	vpextrq	$1, %xmm0, %rcx
	movb	$0, (%rcx)
	vextracti128	$1, %ymm0, %xmm2
	testb	$4, %al
	vmovups	(%rsp), %ymm15                  # 32-byte Reload
	je	.LBB2_4
.LBB2_29:                               # %pl_dolane.2.i651
	vmovq	%xmm2, %rcx
	movb	$0, (%rcx)
	testb	$8, %al
	je	.LBB2_5
.LBB2_30:                               # %pl_dolane.3.i657
	vpextrq	$1, %xmm2, %rcx
	movb	$0, (%rcx)
	vpaddq	.LCPI2_0(%rip), %ymm1, %ymm1
	testb	$16, %al
	je	.LBB2_6
.LBB2_31:                               # %pl_dolane.4.i663
	vmovq	%xmm1, %rcx
	movb	$0, (%rcx)
	testb	$32, %al
	je	.LBB2_7
.LBB2_32:                               # %pl_dolane.5.i669
	vpextrq	$1, %xmm1, %rcx
	movb	$0, (%rcx)
	vextracti128	$1, %ymm1, %xmm3
	testb	$64, %al
	je	.LBB2_8
.LBB2_33:                               # %pl_dolane.6.i675
	vmovq	%xmm3, %rcx
	movb	$0, (%rcx)
	testb	%r14b, %r14b
	jns	.LBB2_9
.LBB2_34:                               # %pl_dolane.7.i680
	vpextrq	$1, %xmm3, %rcx
	movb	$0, (%rcx)
	testl	%ebp, %ebp
	jle	.LBB2_39
.LBB2_35:                               # %for_loop156.lr.ph
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	jmp	.LBB2_37
	.p2align	4, 0x90
.LBB2_36:                               # %safe_if_after_true184
                                        #   in Loop: Header=BB2_37 Depth=1
	addl	$8, %edx
	addl	$32, %ecx
	cmpl	%ebp, %edx
	jge	.LBB2_39
.LBB2_37:                               # %for_loop156
                                        # =>This Inner Loop Header: Depth=1
	movslq	%ecx, %rsi
	vmaskmovps	(%rbx,%rsi), %ymm15, %ymm4
	vmaskmovps	(%rbx), %ymm15, %ymm5
	vcmpltps	%ymm5, %ymm4, %ymm4
	vandps	%ymm4, %ymm15, %ymm4
	vmovmskps	%ymm4, %edi
	testb	%dil, %dil
	je	.LBB2_36
# %bb.38:                               # %safe_if_run_true185
                                        #   in Loop: Header=BB2_37 Depth=1
	addq	%rbx, %rsi
	vmaskmovps	(%rsi), %ymm4, %ymm5
	vmaskmovps	%ymm5, %ymm4, (%rbx)
	jmp	.LBB2_36
.LBB2_39:                               # %for_exit158
	testb	$1, %al
	jne	.LBB2_77
# %bb.40:                               # %pl_loopend.i
	testb	$2, %al
	jne	.LBB2_78
.LBB2_41:                               # %pl_loopend.1.i
	testb	$4, %al
	jne	.LBB2_79
.LBB2_42:                               # %pl_loopend.2.i
	testb	$8, %al
	jne	.LBB2_80
.LBB2_43:                               # %pl_loopend.3.i
	testb	$16, %al
	jne	.LBB2_81
.LBB2_44:                               # %pl_loopend.4.i
	testb	$32, %al
	jne	.LBB2_82
.LBB2_45:                               # %pl_loopend.5.i
	testb	$64, %al
	jne	.LBB2_83
.LBB2_46:                               # %pl_loopend.6.i
	testb	%r14b, %r14b
	js	.LBB2_84
.LBB2_47:                               # %__scatter64_i8.exit
	vxorps	%xmm13, %xmm13, %xmm13
	vblendps	$1, %xmm15, %xmm13, %xmm1       # xmm1 = xmm15[0],xmm13[1,2,3]
	vmovmskps	%ymm1, %eax
	testb	%al, %al
	je	.LBB2_85
# %bb.48:                               # %for_test234.preheader
	vmovaps	.LCPI2_2(%rip), %xmm1           # xmm1 = [4294967295,0,0,0]
	vmovdqa	.LCPI2_3(%rip), %ymm2           # ymm2 = <0,1,4,5,8,9,12,13,u,u,u,u,u,u,u,u,16,17,20,21,24,25,28,29,u,u,u,u,u,u,u,u>
	vmovdqa	.LCPI2_4(%rip), %xmm3           # xmm3 = <0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u>
	vpcmpeqd	%xmm8, %xmm8, %xmm8
	vxorps	%xmm5, %xmm5, %xmm5
	vmovdqa	.LCPI2_5(%rip), %xmm6           # xmm6 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
	vpcmpeqd	%ymm14, %ymm14, %ymm14
                                        # implicit-def: $xmm4
	jmp	.LBB2_53
	.p2align	4, 0x90
.LBB2_49:                               #   in Loop: Header=BB2_53 Depth=1
	vxorps	%xmm11, %xmm11, %xmm11
.LBB2_50:                               # %check_local_compare_is_done___vy_3C_unf_3E_uni.exit
                                        #   in Loop: Header=BB2_53 Depth=1
	vpshufb	%ymm2, %ymm11, %ymm0
.LBB2_51:                               # %check_local_compare_is_done___vy_3C_unf_3E_uni.exit
                                        #   in Loop: Header=BB2_53 Depth=1
	vpermq	$232, %ymm0, %ymm0              # ymm0 = ymm0[0,2,2,3]
	vpshufb	%xmm3, %xmm0, %xmm0
	vpsllw	$7, %xmm0, %xmm0
	vpblendvb	%xmm0, %xmm4, %xmm8, %xmm4
.LBB2_52:                               # %check_local_compare_is_done___vy_3C_unf_3E_uni.exit
                                        #   in Loop: Header=BB2_53 Depth=1
	vpxor	%xmm4, %xmm8, %xmm0
	vpmovsxbd	%xmm0, %ymm0
	vandps	%ymm0, %ymm1, %ymm1
	vandps	%ymm1, %ymm15, %ymm0
	vmovmskps	%ymm0, %eax
	testb	%al, %al
	je	.LBB2_63
.LBB2_53:                               # %for_test234
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_60 Depth 2
                                        #     Child Loop BB2_56 Depth 2
	vandps	%ymm1, %ymm15, %ymm9
	vmovmskps	%ymm9, %eax
	testb	%al, %al
	je	.LBB2_49
# %bb.54:                               # %for_test234
                                        #   in Loop: Header=BB2_53 Depth=1
	cmpb	$-1, %al
	jne	.LBB2_59
# %bb.55:                               # %for_loop.i.preheader
                                        #   in Loop: Header=BB2_53 Depth=1
	vpxor	%xmm9, %xmm9, %xmm9
	vpcmpeqd	%ymm11, %ymm11, %ymm11
	xorl	%eax, %eax
	vpxor	%xmm10, %xmm10, %xmm10
	.p2align	4, 0x90
.LBB2_56:                               # %for_loop.i
                                        #   Parent Loop BB2_53 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%eax, %rcx
	vmovss	(%rbx,%rcx), %xmm12             # xmm12 = mem[0],zero,zero,zero
	vcmpeqps	%ymm5, %ymm12, %ymm12
	vpbroadcastw	%xmm12, %xmm0
	vpmovsxwd	%xmm0, %ymm0
	vpand	%ymm0, %ymm11, %ymm0
	vpshufb	%ymm2, %ymm0, %ymm12
	vpermq	$232, %ymm12, %ymm12            # ymm12 = ymm12[0,2,2,3]
	vpshufb	%xmm3, %xmm12, %xmm7
	vpsllw	$7, %xmm7, %xmm7
	vpand	%xmm6, %xmm7, %xmm7
	vpcmpgtb	%xmm7, %xmm13, %xmm7
	vpandn	%xmm4, %xmm7, %xmm4
	vpor	%ymm0, %ymm10, %ymm10
	vmovmskps	%ymm10, %ecx
	cmpb	$-1, %cl
	je	.LBB2_52
# %bb.57:                               # %no_return.i
                                        #   in Loop: Header=BB2_56 Depth=2
	vpandn	%ymm11, %ymm10, %ymm0
	vpsubd	%ymm14, %ymm9, %ymm9
	vpbroadcastd	.LCPI2_6(%rip), %ymm7   # ymm7 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm9, %ymm7, %ymm7
	vpand	%ymm0, %ymm7, %ymm11
	vmovmskps	%ymm11, %ecx
	addl	$4, %eax
	testb	%cl, %cl
	jne	.LBB2_56
# %bb.58:                               # %for_exit.i
                                        #   in Loop: Header=BB2_53 Depth=1
	vpshufb	%ymm2, %ymm10, %ymm0
	jmp	.LBB2_51
	.p2align	4, 0x90
.LBB2_59:                               # %for_loop51.i.preheader
                                        #   in Loop: Header=BB2_53 Depth=1
	vpxor	%xmm10, %xmm10, %xmm10
	vpcmpeqd	%ymm12, %ymm12, %ymm12
	xorl	%ecx, %ecx
	vpxor	%xmm11, %xmm11, %xmm11
	.p2align	4, 0x90
.LBB2_60:                               # %for_loop51.i
                                        #   Parent Loop BB2_53 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%ecx, %rdx
	vmovss	(%rbx,%rdx), %xmm0              # xmm0 = mem[0],zero,zero,zero
	vcmpeqps	%ymm5, %ymm0, %ymm0
	vpbroadcastw	%xmm0, %xmm0
	vpmovsxwd	%xmm0, %ymm0
	vpand	%ymm0, %ymm12, %ymm0
	vpshufb	%ymm2, %ymm0, %ymm7
	vpermq	$232, %ymm7, %ymm7              # ymm7 = ymm7[0,2,2,3]
	vpshufb	%xmm3, %xmm7, %xmm7
	vpsllw	$7, %xmm7, %xmm7
	vpand	%xmm6, %xmm7, %xmm7
	vpcmpgtb	%xmm7, %xmm13, %xmm7
	vpandn	%xmm4, %xmm7, %xmm4
	vpand	%ymm0, %ymm9, %ymm0
	vpor	%ymm0, %ymm11, %ymm11
	vmovmskps	%ymm11, %edx
	cmpb	%dl, %al
	je	.LBB2_52
# %bb.61:                               # %no_return87.i
                                        #   in Loop: Header=BB2_60 Depth=2
	vpandn	%ymm12, %ymm11, %ymm0
	vpsubd	%ymm14, %ymm10, %ymm10
	vpbroadcastd	.LCPI2_6(%rip), %ymm7   # ymm7 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm10, %ymm7, %ymm7
	vpand	%ymm0, %ymm7, %ymm12
	vpand	%ymm9, %ymm12, %ymm0
	vmovmskps	%ymm0, %edx
	addl	$4, %ecx
	testb	%dl, %dl
	jne	.LBB2_60
	jmp	.LBB2_50
.LBB2_63:                               # %for_test96.preheader
	vmovss	(%rbx), %xmm0                   # xmm0 = mem[0],zero,zero,zero
	vmovss	4(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB2_64
# %bb.70:                               # %if_then
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	8(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB2_71
.LBB2_65:                               # %for_step98.1
	vmovss	12(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB2_66
.LBB2_72:                               # %if_then.2
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	16(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB2_73
.LBB2_67:                               # %for_step98.3
	vmovss	20(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB2_68
.LBB2_74:                               # %if_then.4
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	24(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB2_75
.LBB2_69:                               # %for_step98.5
	vmovss	28(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB2_76
	jmp	.LBB2_86
.LBB2_64:                               # %for_step98
	vmovss	8(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB2_65
.LBB2_71:                               # %if_then.1
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	12(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB2_72
.LBB2_66:                               # %for_step98.2
	vmovss	16(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB2_67
.LBB2_73:                               # %if_then.3
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	20(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB2_74
.LBB2_68:                               # %for_step98.4
	vmovss	24(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB2_69
.LBB2_75:                               # %if_then.5
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	28(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB2_86
.LBB2_76:                               # %if_then.6
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	jmp	.LBB2_86
.LBB2_77:                               # %pl_dolane.i
	vmovq	%xmm0, %rcx
	movb	$-1, (%rcx)
	testb	$2, %al
	je	.LBB2_41
.LBB2_78:                               # %pl_dolane.1.i
	vpextrq	$1, %xmm0, %rcx
	movb	$-1, (%rcx)
	testb	$4, %al
	je	.LBB2_42
.LBB2_79:                               # %pl_dolane.2.i
	vmovq	%xmm2, %rcx
	movb	$-1, (%rcx)
	testb	$8, %al
	je	.LBB2_43
.LBB2_80:                               # %pl_dolane.3.i
	vpextrq	$1, %xmm2, %rcx
	movb	$-1, (%rcx)
	testb	$16, %al
	je	.LBB2_44
.LBB2_81:                               # %pl_dolane.4.i
	vmovq	%xmm1, %rcx
	movb	$-1, (%rcx)
	testb	$32, %al
	je	.LBB2_45
.LBB2_82:                               # %pl_dolane.5.i
	vpextrq	$1, %xmm1, %rcx
	movb	$-1, (%rcx)
	testb	$64, %al
	je	.LBB2_46
.LBB2_83:                               # %pl_dolane.6.i
	vmovq	%xmm3, %rax
	movb	$-1, (%rax)
	testb	%r14b, %r14b
	jns	.LBB2_47
.LBB2_84:                               # %pl_dolane.7.i
	vpextrq	$1, %xmm3, %rax
	movb	$-1, (%rax)
	jmp	.LBB2_47
.LBB2_85:
                                        # implicit-def: $xmm0
.LBB2_86:                               # %safe_if_after_true64
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
.Lfunc_end2:
	.size	parallelmin___un_3C_unf_3E_uni, .Lfunc_end2-parallelmin___un_3C_unf_3E_uni
                                        # -- End function
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5                               # -- Begin function parallelmax___un_3C_unf_3E_uni
.LCPI3_0:
	.quad	4                               # 0x4
	.quad	5                               # 0x5
	.quad	6                               # 0x6
	.quad	7                               # 0x7
.LCPI3_1:
	.quad	0                               # 0x0
	.quad	1                               # 0x1
	.quad	2                               # 0x2
	.quad	3                               # 0x3
.LCPI3_3:
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	4                               # 0x4
	.byte	5                               # 0x5
	.byte	8                               # 0x8
	.byte	9                               # 0x9
	.byte	12                              # 0xc
	.byte	13                              # 0xd
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.byte	16                              # 0x10
	.byte	17                              # 0x11
	.byte	20                              # 0x14
	.byte	21                              # 0x15
	.byte	24                              # 0x18
	.byte	25                              # 0x19
	.byte	28                              # 0x1c
	.byte	29                              # 0x1d
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI3_2:
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
.LCPI3_4:
	.byte	0                               # 0x0
	.byte	2                               # 0x2
	.byte	4                               # 0x4
	.byte	6                               # 0x6
	.byte	8                               # 0x8
	.byte	10                              # 0xa
	.byte	12                              # 0xc
	.byte	14                              # 0xe
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
.LCPI3_5:
	.zero	16,128
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI3_6:
	.long	8                               # 0x8
	.text
	.globl	parallelmax___un_3C_unf_3E_uni
	.p2align	4, 0x90
	.type	parallelmax___un_3C_unf_3E_uni,@function
parallelmax___un_3C_unf_3E_uni:         # @parallelmax___un_3C_unf_3E_uni
# %bb.0:                                # %allocas
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	movl	%esi, %ebp
	movq	%rdi, %rbx
	vmovmskps	%ymm0, %r14d
	cmpb	$-1, %r14b
	je	.LBB3_10
# %bb.1:                                # %some_on
	vmovups	%ymm0, (%rsp)                   # 32-byte Spill
	callq	__new_varying32_64rt
	vpaddq	.LCPI3_1(%rip), %ymm0, %ymm0
	movzbl	%r14b, %eax
	testb	$1, %al
	jne	.LBB3_27
# %bb.2:                                # %pl_loopend.i642
	testb	$2, %al
	jne	.LBB3_28
.LBB3_3:                                # %pl_loopend.1.i648
	vextracti128	$1, %ymm0, %xmm2
	testb	$4, %al
	vmovups	(%rsp), %ymm15                  # 32-byte Reload
	jne	.LBB3_29
.LBB3_4:                                # %pl_loopend.2.i654
	testb	$8, %al
	jne	.LBB3_30
.LBB3_5:                                # %pl_loopend.3.i660
	vpaddq	.LCPI3_0(%rip), %ymm1, %ymm1
	testb	$16, %al
	jne	.LBB3_31
.LBB3_6:                                # %pl_loopend.4.i666
	testb	$32, %al
	jne	.LBB3_32
.LBB3_7:                                # %pl_loopend.5.i672
	vextracti128	$1, %ymm1, %xmm3
	testb	$64, %al
	jne	.LBB3_33
.LBB3_8:                                # %pl_loopend.6.i677
	testb	%r14b, %r14b
	js	.LBB3_34
.LBB3_9:                                # %__scatter64_i8.exit681
	testl	%ebp, %ebp
	jg	.LBB3_35
	jmp	.LBB3_39
.LBB3_10:                               # %all_on
	vpcmpeqd	%ymm0, %ymm0, %ymm0
	callq	__new_varying32_64rt
	vpaddq	.LCPI3_0(%rip), %ymm1, %ymm1
	vpaddq	.LCPI3_1(%rip), %ymm0, %ymm0
	vmovq	%xmm0, %r8
	vpextrq	$1, %xmm0, %r9
	movb	$0, (%r8)
	movb	$0, (%r9)
	vextracti128	$1, %ymm0, %xmm0
	vmovq	%xmm0, %r10
	movb	$0, (%r10)
	vpextrq	$1, %xmm0, %r11
	movb	$0, (%r11)
	vmovq	%xmm1, %r14
	movb	$0, (%r14)
	vpextrq	$1, %xmm1, %r15
	movb	$0, (%r15)
	vextracti128	$1, %ymm1, %xmm0
	vmovq	%xmm0, %r12
	movb	$0, (%r12)
	vpextrq	$1, %xmm0, %rdx
	movb	$0, (%rdx)
	testl	%ebp, %ebp
	jle	.LBB3_15
# %bb.11:                               # %for_loop.lr.ph
	xorl	%esi, %esi
	xorl	%edi, %edi
	jmp	.LBB3_13
	.p2align	4, 0x90
.LBB3_12:                               # %safe_if_after_true
                                        #   in Loop: Header=BB3_13 Depth=1
	addl	$8, %edi
	addl	$32, %esi
	cmpl	%ebp, %edi
	jge	.LBB3_15
.LBB3_13:                               # %for_loop
                                        # =>This Inner Loop Header: Depth=1
	movslq	%esi, %rax
	vmovups	(%rbx), %ymm0
	vcmpltps	(%rbx,%rax), %ymm0, %ymm0
	vmovmskps	%ymm0, %ecx
	testb	%cl, %cl
	je	.LBB3_12
# %bb.14:                               # %safe_if_run_true
                                        #   in Loop: Header=BB3_13 Depth=1
	addq	%rbx, %rax
	vmaskmovps	(%rax), %ymm0, %ymm1
	vmaskmovps	%ymm1, %ymm0, (%rbx)
	jmp	.LBB3_12
.LBB3_15:                               # %for_exit
	movb	$-1, (%r8)
	movb	$-1, (%r9)
	movb	$-1, (%r10)
	movb	$-1, (%r11)
	movb	$-1, (%r14)
	movb	$-1, (%r15)
	movb	$-1, (%r12)
	movb	$-1, (%rdx)
	vmovaps	.LCPI3_2(%rip), %xmm0           # xmm0 = [4294967295,0,0,0]
	vmovdqa	.LCPI3_3(%rip), %ymm1           # ymm1 = <0,1,4,5,8,9,12,13,u,u,u,u,u,u,u,u,16,17,20,21,24,25,28,29,u,u,u,u,u,u,u,u>
	vmovdqa	.LCPI3_4(%rip), %xmm2           # xmm2 = <0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u>
	vpcmpeqd	%xmm12, %xmm12, %xmm12
	vxorps	%xmm13, %xmm13, %xmm13
	vmovdqa	.LCPI3_5(%rip), %xmm5           # xmm5 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
	vpxor	%xmm6, %xmm6, %xmm6
                                        # implicit-def: $xmm7
	vpcmpeqd	%ymm14, %ymm14, %ymm14
	jmp	.LBB3_19
	.p2align	4, 0x90
.LBB3_16:                               #   in Loop: Header=BB3_19 Depth=1
	vxorps	%xmm9, %xmm9, %xmm9
.LBB3_17:                               # %for_exit.i519
                                        #   in Loop: Header=BB3_19 Depth=1
	vpshufb	%ymm1, %ymm9, %ymm3
	vpermq	$232, %ymm3, %ymm3              # ymm3 = ymm3[0,2,2,3]
	vpshufb	%xmm2, %xmm3, %xmm3
	vpsllw	$7, %xmm3, %xmm3
	vpblendvb	%xmm3, %xmm7, %xmm12, %xmm7
.LBB3_18:                               # %check_local_compare_is_done___vy_3C_unf_3E_uni.exit558
                                        #   in Loop: Header=BB3_19 Depth=1
	vpxor	%xmm7, %xmm12, %xmm3
	vpmovsxbd	%xmm3, %ymm3
	vpand	%ymm3, %ymm0, %ymm0
	vmovmskps	%ymm0, %eax
	testb	%al, %al
	je	.LBB3_63
.LBB3_19:                               # %for_test71
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_25 Depth 2
                                        #     Child Loop BB3_22 Depth 2
	vmovmskps	%ymm0, %eax
	testb	%al, %al
	je	.LBB3_16
# %bb.20:                               # %for_test71
                                        #   in Loop: Header=BB3_19 Depth=1
	vpxor	%xmm8, %xmm8, %xmm8
	vpcmpeqd	%ymm10, %ymm10, %ymm10
	cmpb	$-1, %al
	jne	.LBB3_24
# %bb.21:                               # %for_loop.i515.preheader
                                        #   in Loop: Header=BB3_19 Depth=1
	xorl	%eax, %eax
	vpxor	%xmm9, %xmm9, %xmm9
	.p2align	4, 0x90
.LBB3_22:                               # %for_loop.i515
                                        #   Parent Loop BB3_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%eax, %rcx
	vmovss	(%rbx,%rcx), %xmm11             # xmm11 = mem[0],zero,zero,zero
	vcmpeqps	%ymm13, %ymm11, %ymm11
	vpbroadcastw	%xmm11, %xmm3
	vpmovsxwd	%xmm3, %ymm3
	vpand	%ymm3, %ymm10, %ymm3
	vpshufb	%ymm1, %ymm3, %ymm11
	vpermq	$232, %ymm11, %ymm11            # ymm11 = ymm11[0,2,2,3]
	vpshufb	%xmm2, %xmm11, %xmm4
	vpsllw	$7, %xmm4, %xmm4
	vpand	%xmm5, %xmm4, %xmm4
	vpcmpgtb	%xmm4, %xmm6, %xmm4
	vpandn	%xmm7, %xmm4, %xmm7
	vpor	%ymm3, %ymm9, %ymm9
	vmovmskps	%ymm9, %ecx
	cmpb	$-1, %cl
	je	.LBB3_18
# %bb.23:                               # %no_return.i550
                                        #   in Loop: Header=BB3_22 Depth=2
	vpandn	%ymm10, %ymm9, %ymm3
	vpsubd	%ymm14, %ymm8, %ymm8
	vpbroadcastd	.LCPI3_6(%rip), %ymm4   # ymm4 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm8, %ymm4, %ymm4
	vpand	%ymm3, %ymm4, %ymm10
	vmovmskps	%ymm10, %ecx
	addl	$4, %eax
	testb	%cl, %cl
	jne	.LBB3_22
	jmp	.LBB3_17
	.p2align	4, 0x90
.LBB3_24:                               # %for_loop51.i539.preheader
                                        #   in Loop: Header=BB3_19 Depth=1
	xorl	%ecx, %ecx
	vpxor	%xmm9, %xmm9, %xmm9
	.p2align	4, 0x90
.LBB3_25:                               # %for_loop51.i539
                                        #   Parent Loop BB3_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%ecx, %rdx
	vmovss	(%rbx,%rdx), %xmm3              # xmm3 = mem[0],zero,zero,zero
	vcmpeqps	%ymm3, %ymm13, %ymm3
	vpbroadcastw	%xmm3, %xmm3
	vpmovsxwd	%xmm3, %ymm3
	vpand	%ymm3, %ymm10, %ymm3
	vpshufb	%ymm1, %ymm3, %ymm4
	vpermq	$232, %ymm4, %ymm4              # ymm4 = ymm4[0,2,2,3]
	vpshufb	%xmm2, %xmm4, %xmm4
	vpsllw	$7, %xmm4, %xmm4
	vpand	%xmm5, %xmm4, %xmm4
	vpcmpgtb	%xmm4, %xmm6, %xmm4
	vpandn	%xmm7, %xmm4, %xmm7
	vpand	%ymm0, %ymm3, %ymm3
	vpor	%ymm3, %ymm9, %ymm9
	vmovmskps	%ymm9, %edx
	cmpb	%dl, %al
	je	.LBB3_18
# %bb.26:                               # %no_return87.i557
                                        #   in Loop: Header=BB3_25 Depth=2
	vpandn	%ymm10, %ymm9, %ymm3
	vpsubd	%ymm14, %ymm8, %ymm8
	vpbroadcastd	.LCPI3_6(%rip), %ymm4   # ymm4 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm8, %ymm4, %ymm4
	vpand	%ymm3, %ymm4, %ymm10
	vpand	%ymm0, %ymm10, %ymm3
	vmovmskps	%ymm3, %edx
	addl	$4, %ecx
	testb	%dl, %dl
	jne	.LBB3_25
	jmp	.LBB3_17
.LBB3_27:                               # %pl_dolane.i639
	vmovq	%xmm0, %rcx
	movb	$0, (%rcx)
	testb	$2, %al
	je	.LBB3_3
.LBB3_28:                               # %pl_dolane.1.i645
	vpextrq	$1, %xmm0, %rcx
	movb	$0, (%rcx)
	vextracti128	$1, %ymm0, %xmm2
	testb	$4, %al
	vmovups	(%rsp), %ymm15                  # 32-byte Reload
	je	.LBB3_4
.LBB3_29:                               # %pl_dolane.2.i651
	vmovq	%xmm2, %rcx
	movb	$0, (%rcx)
	testb	$8, %al
	je	.LBB3_5
.LBB3_30:                               # %pl_dolane.3.i657
	vpextrq	$1, %xmm2, %rcx
	movb	$0, (%rcx)
	vpaddq	.LCPI3_0(%rip), %ymm1, %ymm1
	testb	$16, %al
	je	.LBB3_6
.LBB3_31:                               # %pl_dolane.4.i663
	vmovq	%xmm1, %rcx
	movb	$0, (%rcx)
	testb	$32, %al
	je	.LBB3_7
.LBB3_32:                               # %pl_dolane.5.i669
	vpextrq	$1, %xmm1, %rcx
	movb	$0, (%rcx)
	vextracti128	$1, %ymm1, %xmm3
	testb	$64, %al
	je	.LBB3_8
.LBB3_33:                               # %pl_dolane.6.i675
	vmovq	%xmm3, %rcx
	movb	$0, (%rcx)
	testb	%r14b, %r14b
	jns	.LBB3_9
.LBB3_34:                               # %pl_dolane.7.i680
	vpextrq	$1, %xmm3, %rcx
	movb	$0, (%rcx)
	testl	%ebp, %ebp
	jle	.LBB3_39
.LBB3_35:                               # %for_loop156.lr.ph
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	jmp	.LBB3_37
	.p2align	4, 0x90
.LBB3_36:                               # %safe_if_after_true184
                                        #   in Loop: Header=BB3_37 Depth=1
	addl	$8, %edx
	addl	$32, %ecx
	cmpl	%ebp, %edx
	jge	.LBB3_39
.LBB3_37:                               # %for_loop156
                                        # =>This Inner Loop Header: Depth=1
	movslq	%ecx, %rsi
	vmaskmovps	(%rbx,%rsi), %ymm15, %ymm4
	vmaskmovps	(%rbx), %ymm15, %ymm5
	vcmpltps	%ymm4, %ymm5, %ymm4
	vandps	%ymm4, %ymm15, %ymm4
	vmovmskps	%ymm4, %edi
	testb	%dil, %dil
	je	.LBB3_36
# %bb.38:                               # %safe_if_run_true185
                                        #   in Loop: Header=BB3_37 Depth=1
	addq	%rbx, %rsi
	vmaskmovps	(%rsi), %ymm4, %ymm5
	vmaskmovps	%ymm5, %ymm4, (%rbx)
	jmp	.LBB3_36
.LBB3_39:                               # %for_exit158
	testb	$1, %al
	jne	.LBB3_77
# %bb.40:                               # %pl_loopend.i
	testb	$2, %al
	jne	.LBB3_78
.LBB3_41:                               # %pl_loopend.1.i
	testb	$4, %al
	jne	.LBB3_79
.LBB3_42:                               # %pl_loopend.2.i
	testb	$8, %al
	jne	.LBB3_80
.LBB3_43:                               # %pl_loopend.3.i
	testb	$16, %al
	jne	.LBB3_81
.LBB3_44:                               # %pl_loopend.4.i
	testb	$32, %al
	jne	.LBB3_82
.LBB3_45:                               # %pl_loopend.5.i
	testb	$64, %al
	jne	.LBB3_83
.LBB3_46:                               # %pl_loopend.6.i
	testb	%r14b, %r14b
	js	.LBB3_84
.LBB3_47:                               # %__scatter64_i8.exit
	vxorps	%xmm13, %xmm13, %xmm13
	vblendps	$1, %xmm15, %xmm13, %xmm1       # xmm1 = xmm15[0],xmm13[1,2,3]
	vmovmskps	%ymm1, %eax
	testb	%al, %al
	je	.LBB3_85
# %bb.48:                               # %for_test234.preheader
	vmovaps	.LCPI3_2(%rip), %xmm1           # xmm1 = [4294967295,0,0,0]
	vmovdqa	.LCPI3_3(%rip), %ymm2           # ymm2 = <0,1,4,5,8,9,12,13,u,u,u,u,u,u,u,u,16,17,20,21,24,25,28,29,u,u,u,u,u,u,u,u>
	vmovdqa	.LCPI3_4(%rip), %xmm3           # xmm3 = <0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u>
	vpcmpeqd	%xmm8, %xmm8, %xmm8
	vxorps	%xmm5, %xmm5, %xmm5
	vmovdqa	.LCPI3_5(%rip), %xmm6           # xmm6 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
	vpcmpeqd	%ymm14, %ymm14, %ymm14
                                        # implicit-def: $xmm4
	jmp	.LBB3_53
	.p2align	4, 0x90
.LBB3_49:                               #   in Loop: Header=BB3_53 Depth=1
	vxorps	%xmm11, %xmm11, %xmm11
.LBB3_50:                               # %check_local_compare_is_done___vy_3C_unf_3E_uni.exit
                                        #   in Loop: Header=BB3_53 Depth=1
	vpshufb	%ymm2, %ymm11, %ymm0
.LBB3_51:                               # %check_local_compare_is_done___vy_3C_unf_3E_uni.exit
                                        #   in Loop: Header=BB3_53 Depth=1
	vpermq	$232, %ymm0, %ymm0              # ymm0 = ymm0[0,2,2,3]
	vpshufb	%xmm3, %xmm0, %xmm0
	vpsllw	$7, %xmm0, %xmm0
	vpblendvb	%xmm0, %xmm4, %xmm8, %xmm4
.LBB3_52:                               # %check_local_compare_is_done___vy_3C_unf_3E_uni.exit
                                        #   in Loop: Header=BB3_53 Depth=1
	vpxor	%xmm4, %xmm8, %xmm0
	vpmovsxbd	%xmm0, %ymm0
	vandps	%ymm0, %ymm1, %ymm1
	vandps	%ymm1, %ymm15, %ymm0
	vmovmskps	%ymm0, %eax
	testb	%al, %al
	je	.LBB3_63
.LBB3_53:                               # %for_test234
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_60 Depth 2
                                        #     Child Loop BB3_56 Depth 2
	vandps	%ymm1, %ymm15, %ymm9
	vmovmskps	%ymm9, %eax
	testb	%al, %al
	je	.LBB3_49
# %bb.54:                               # %for_test234
                                        #   in Loop: Header=BB3_53 Depth=1
	cmpb	$-1, %al
	jne	.LBB3_59
# %bb.55:                               # %for_loop.i.preheader
                                        #   in Loop: Header=BB3_53 Depth=1
	vpxor	%xmm9, %xmm9, %xmm9
	vpcmpeqd	%ymm11, %ymm11, %ymm11
	xorl	%eax, %eax
	vpxor	%xmm10, %xmm10, %xmm10
	.p2align	4, 0x90
.LBB3_56:                               # %for_loop.i
                                        #   Parent Loop BB3_53 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%eax, %rcx
	vmovss	(%rbx,%rcx), %xmm12             # xmm12 = mem[0],zero,zero,zero
	vcmpeqps	%ymm5, %ymm12, %ymm12
	vpbroadcastw	%xmm12, %xmm0
	vpmovsxwd	%xmm0, %ymm0
	vpand	%ymm0, %ymm11, %ymm0
	vpshufb	%ymm2, %ymm0, %ymm12
	vpermq	$232, %ymm12, %ymm12            # ymm12 = ymm12[0,2,2,3]
	vpshufb	%xmm3, %xmm12, %xmm7
	vpsllw	$7, %xmm7, %xmm7
	vpand	%xmm6, %xmm7, %xmm7
	vpcmpgtb	%xmm7, %xmm13, %xmm7
	vpandn	%xmm4, %xmm7, %xmm4
	vpor	%ymm0, %ymm10, %ymm10
	vmovmskps	%ymm10, %ecx
	cmpb	$-1, %cl
	je	.LBB3_52
# %bb.57:                               # %no_return.i
                                        #   in Loop: Header=BB3_56 Depth=2
	vpandn	%ymm11, %ymm10, %ymm0
	vpsubd	%ymm14, %ymm9, %ymm9
	vpbroadcastd	.LCPI3_6(%rip), %ymm7   # ymm7 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm9, %ymm7, %ymm7
	vpand	%ymm0, %ymm7, %ymm11
	vmovmskps	%ymm11, %ecx
	addl	$4, %eax
	testb	%cl, %cl
	jne	.LBB3_56
# %bb.58:                               # %for_exit.i
                                        #   in Loop: Header=BB3_53 Depth=1
	vpshufb	%ymm2, %ymm10, %ymm0
	jmp	.LBB3_51
	.p2align	4, 0x90
.LBB3_59:                               # %for_loop51.i.preheader
                                        #   in Loop: Header=BB3_53 Depth=1
	vpxor	%xmm10, %xmm10, %xmm10
	vpcmpeqd	%ymm12, %ymm12, %ymm12
	xorl	%ecx, %ecx
	vpxor	%xmm11, %xmm11, %xmm11
	.p2align	4, 0x90
.LBB3_60:                               # %for_loop51.i
                                        #   Parent Loop BB3_53 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%ecx, %rdx
	vmovss	(%rbx,%rdx), %xmm0              # xmm0 = mem[0],zero,zero,zero
	vcmpeqps	%ymm5, %ymm0, %ymm0
	vpbroadcastw	%xmm0, %xmm0
	vpmovsxwd	%xmm0, %ymm0
	vpand	%ymm0, %ymm12, %ymm0
	vpshufb	%ymm2, %ymm0, %ymm7
	vpermq	$232, %ymm7, %ymm7              # ymm7 = ymm7[0,2,2,3]
	vpshufb	%xmm3, %xmm7, %xmm7
	vpsllw	$7, %xmm7, %xmm7
	vpand	%xmm6, %xmm7, %xmm7
	vpcmpgtb	%xmm7, %xmm13, %xmm7
	vpandn	%xmm4, %xmm7, %xmm4
	vpand	%ymm0, %ymm9, %ymm0
	vpor	%ymm0, %ymm11, %ymm11
	vmovmskps	%ymm11, %edx
	cmpb	%dl, %al
	je	.LBB3_52
# %bb.61:                               # %no_return87.i
                                        #   in Loop: Header=BB3_60 Depth=2
	vpandn	%ymm12, %ymm11, %ymm0
	vpsubd	%ymm14, %ymm10, %ymm10
	vpbroadcastd	.LCPI3_6(%rip), %ymm7   # ymm7 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm10, %ymm7, %ymm7
	vpand	%ymm0, %ymm7, %ymm12
	vpand	%ymm9, %ymm12, %ymm0
	vmovmskps	%ymm0, %edx
	addl	$4, %ecx
	testb	%dl, %dl
	jne	.LBB3_60
	jmp	.LBB3_50
.LBB3_63:                               # %for_test96.preheader
	vmovss	(%rbx), %xmm0                   # xmm0 = mem[0],zero,zero,zero
	vmovss	4(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB3_64
# %bb.70:                               # %if_then
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	8(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB3_71
.LBB3_65:                               # %for_step98.1
	vmovss	12(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB3_66
.LBB3_72:                               # %if_then.2
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	16(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB3_73
.LBB3_67:                               # %for_step98.3
	vmovss	20(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB3_68
.LBB3_74:                               # %if_then.4
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	24(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB3_75
.LBB3_69:                               # %for_step98.5
	vmovss	28(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB3_76
	jmp	.LBB3_86
.LBB3_64:                               # %for_step98
	vmovss	8(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB3_65
.LBB3_71:                               # %if_then.1
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	12(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB3_72
.LBB3_66:                               # %for_step98.2
	vmovss	16(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB3_67
.LBB3_73:                               # %if_then.3
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	20(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB3_74
.LBB3_68:                               # %for_step98.4
	vmovss	24(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB3_69
.LBB3_75:                               # %if_then.5
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	28(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB3_86
.LBB3_76:                               # %if_then.6
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	jmp	.LBB3_86
.LBB3_77:                               # %pl_dolane.i
	vmovq	%xmm0, %rcx
	movb	$-1, (%rcx)
	testb	$2, %al
	je	.LBB3_41
.LBB3_78:                               # %pl_dolane.1.i
	vpextrq	$1, %xmm0, %rcx
	movb	$-1, (%rcx)
	testb	$4, %al
	je	.LBB3_42
.LBB3_79:                               # %pl_dolane.2.i
	vmovq	%xmm2, %rcx
	movb	$-1, (%rcx)
	testb	$8, %al
	je	.LBB3_43
.LBB3_80:                               # %pl_dolane.3.i
	vpextrq	$1, %xmm2, %rcx
	movb	$-1, (%rcx)
	testb	$16, %al
	je	.LBB3_44
.LBB3_81:                               # %pl_dolane.4.i
	vmovq	%xmm1, %rcx
	movb	$-1, (%rcx)
	testb	$32, %al
	je	.LBB3_45
.LBB3_82:                               # %pl_dolane.5.i
	vpextrq	$1, %xmm1, %rcx
	movb	$-1, (%rcx)
	testb	$64, %al
	je	.LBB3_46
.LBB3_83:                               # %pl_dolane.6.i
	vmovq	%xmm3, %rax
	movb	$-1, (%rax)
	testb	%r14b, %r14b
	jns	.LBB3_47
.LBB3_84:                               # %pl_dolane.7.i
	vpextrq	$1, %xmm3, %rax
	movb	$-1, (%rax)
	jmp	.LBB3_47
.LBB3_85:
                                        # implicit-def: $xmm0
.LBB3_86:                               # %safe_if_after_true64
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
.Lfunc_end3:
	.size	parallelmax___un_3C_unf_3E_uni, .Lfunc_end3-parallelmax___un_3C_unf_3E_uni
                                        # -- End function
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5                               # -- Begin function parallelmin
.LCPI4_0:
	.quad	4                               # 0x4
	.quad	5                               # 0x5
	.quad	6                               # 0x6
	.quad	7                               # 0x7
.LCPI4_1:
	.quad	0                               # 0x0
	.quad	1                               # 0x1
	.quad	2                               # 0x2
	.quad	3                               # 0x3
.LCPI4_3:
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	4                               # 0x4
	.byte	5                               # 0x5
	.byte	8                               # 0x8
	.byte	9                               # 0x9
	.byte	12                              # 0xc
	.byte	13                              # 0xd
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.byte	16                              # 0x10
	.byte	17                              # 0x11
	.byte	20                              # 0x14
	.byte	21                              # 0x15
	.byte	24                              # 0x18
	.byte	25                              # 0x19
	.byte	28                              # 0x1c
	.byte	29                              # 0x1d
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI4_2:
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
.LCPI4_4:
	.byte	0                               # 0x0
	.byte	2                               # 0x2
	.byte	4                               # 0x4
	.byte	6                               # 0x6
	.byte	8                               # 0x8
	.byte	10                              # 0xa
	.byte	12                              # 0xc
	.byte	14                              # 0xe
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
.LCPI4_5:
	.zero	16,128
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI4_6:
	.long	8                               # 0x8
	.text
	.globl	parallelmin
	.p2align	4, 0x90
	.type	parallelmin,@function
parallelmin:                            # @parallelmin
# %bb.0:                                # %allocas
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movl	%esi, %ebp
	movq	%rdi, %rbx
	vpcmpeqd	%ymm0, %ymm0, %ymm0
	callq	__new_varying32_64rt
	vpaddq	.LCPI4_0(%rip), %ymm1, %ymm1
	vpaddq	.LCPI4_1(%rip), %ymm0, %ymm0
	vmovq	%xmm0, %r8
	vpextrq	$1, %xmm0, %r9
	movb	$0, (%r8)
	movb	$0, (%r9)
	vextracti128	$1, %ymm0, %xmm0
	vmovq	%xmm0, %r10
	movb	$0, (%r10)
	vpextrq	$1, %xmm0, %r11
	movb	$0, (%r11)
	vmovq	%xmm1, %r14
	movb	$0, (%r14)
	vpextrq	$1, %xmm1, %r15
	movb	$0, (%r15)
	vextracti128	$1, %ymm1, %xmm0
	vmovq	%xmm0, %r12
	movb	$0, (%r12)
	vpextrq	$1, %xmm0, %rdx
	movb	$0, (%rdx)
	testl	%ebp, %ebp
	jle	.LBB4_4
# %bb.1:                                # %for_loop.lr.ph
	xorl	%esi, %esi
	xorl	%edi, %edi
	jmp	.LBB4_2
	.p2align	4, 0x90
.LBB4_3:                                # %safe_if_after_true
                                        #   in Loop: Header=BB4_2 Depth=1
	addl	$8, %edi
	addl	$32, %esi
	cmpl	%ebp, %edi
	jge	.LBB4_4
.LBB4_2:                                # %for_loop
                                        # =>This Inner Loop Header: Depth=1
	movslq	%esi, %rax
	vmovups	(%rbx,%rax), %ymm0
	vcmpltps	(%rbx), %ymm0, %ymm0
	vmovmskps	%ymm0, %ecx
	testb	%cl, %cl
	je	.LBB4_3
# %bb.31:                               # %safe_if_run_true
                                        #   in Loop: Header=BB4_2 Depth=1
	addq	%rbx, %rax
	vmaskmovps	(%rax), %ymm0, %ymm1
	vmaskmovps	%ymm1, %ymm0, (%rbx)
	jmp	.LBB4_3
.LBB4_4:                                # %for_exit
	movb	$-1, (%r8)
	movb	$-1, (%r9)
	movb	$-1, (%r10)
	movb	$-1, (%r11)
	movb	$-1, (%r14)
	movb	$-1, (%r15)
	movb	$-1, (%r12)
	movb	$-1, (%rdx)
	vmovaps	.LCPI4_2(%rip), %xmm0           # xmm0 = [4294967295,0,0,0]
	vmovdqa	.LCPI4_3(%rip), %ymm1           # ymm1 = <0,1,4,5,8,9,12,13,u,u,u,u,u,u,u,u,16,17,20,21,24,25,28,29,u,u,u,u,u,u,u,u>
	vmovdqa	.LCPI4_4(%rip), %xmm2           # xmm2 = <0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u>
	vpcmpeqd	%xmm12, %xmm12, %xmm12
	vxorps	%xmm13, %xmm13, %xmm13
	vmovdqa	.LCPI4_5(%rip), %xmm5           # xmm5 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
	vpxor	%xmm6, %xmm6, %xmm6
                                        # implicit-def: $xmm7
	vpcmpeqd	%ymm14, %ymm14, %ymm14
	jmp	.LBB4_5
	.p2align	4, 0x90
.LBB4_6:                                #   in Loop: Header=BB4_5 Depth=1
	vxorps	%xmm9, %xmm9, %xmm9
.LBB4_11:                               # %for_exit.i396
                                        #   in Loop: Header=BB4_5 Depth=1
	vpshufb	%ymm1, %ymm9, %ymm3
	vpermq	$232, %ymm3, %ymm3              # ymm3 = ymm3[0,2,2,3]
	vpshufb	%xmm2, %xmm3, %xmm3
	vpsllw	$7, %xmm3, %xmm3
	vpblendvb	%xmm3, %xmm7, %xmm12, %xmm7
.LBB4_12:                               # %check_local_compare_is_done___vy_3C_unf_3E_uni.exit435
                                        #   in Loop: Header=BB4_5 Depth=1
	vpxor	%xmm7, %xmm12, %xmm3
	vpmovsxbd	%xmm3, %ymm3
	vpand	%ymm3, %ymm0, %ymm0
	vmovmskps	%ymm0, %eax
	testb	%al, %al
	je	.LBB4_13
.LBB4_5:                                # %for_test43
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_29 Depth 2
                                        #     Child Loop BB4_9 Depth 2
	vmovmskps	%ymm0, %eax
	testb	%al, %al
	je	.LBB4_6
# %bb.7:                                # %for_test43
                                        #   in Loop: Header=BB4_5 Depth=1
	vpxor	%xmm8, %xmm8, %xmm8
	vpcmpeqd	%ymm10, %ymm10, %ymm10
	cmpb	$-1, %al
	jne	.LBB4_28
# %bb.8:                                # %for_loop.i392.preheader
                                        #   in Loop: Header=BB4_5 Depth=1
	xorl	%eax, %eax
	vpxor	%xmm9, %xmm9, %xmm9
	.p2align	4, 0x90
.LBB4_9:                                # %for_loop.i392
                                        #   Parent Loop BB4_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%eax, %rcx
	vmovss	(%rbx,%rcx), %xmm11             # xmm11 = mem[0],zero,zero,zero
	vcmpeqps	%ymm13, %ymm11, %ymm11
	vpbroadcastw	%xmm11, %xmm3
	vpmovsxwd	%xmm3, %ymm3
	vpand	%ymm3, %ymm10, %ymm3
	vpshufb	%ymm1, %ymm3, %ymm11
	vpermq	$232, %ymm11, %ymm11            # ymm11 = ymm11[0,2,2,3]
	vpshufb	%xmm2, %xmm11, %xmm4
	vpsllw	$7, %xmm4, %xmm4
	vpand	%xmm5, %xmm4, %xmm4
	vpcmpgtb	%xmm4, %xmm6, %xmm4
	vpandn	%xmm7, %xmm4, %xmm7
	vpor	%ymm3, %ymm9, %ymm9
	vmovmskps	%ymm9, %ecx
	cmpb	$-1, %cl
	je	.LBB4_12
# %bb.10:                               # %no_return.i427
                                        #   in Loop: Header=BB4_9 Depth=2
	vpandn	%ymm10, %ymm9, %ymm3
	vpsubd	%ymm14, %ymm8, %ymm8
	vpbroadcastd	.LCPI4_6(%rip), %ymm4   # ymm4 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm8, %ymm4, %ymm4
	vpand	%ymm3, %ymm4, %ymm10
	vmovmskps	%ymm10, %ecx
	addl	$4, %eax
	testb	%cl, %cl
	jne	.LBB4_9
	jmp	.LBB4_11
	.p2align	4, 0x90
.LBB4_28:                               # %for_loop51.i416.preheader
                                        #   in Loop: Header=BB4_5 Depth=1
	xorl	%ecx, %ecx
	vpxor	%xmm9, %xmm9, %xmm9
	.p2align	4, 0x90
.LBB4_29:                               # %for_loop51.i416
                                        #   Parent Loop BB4_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%ecx, %rdx
	vmovss	(%rbx,%rdx), %xmm3              # xmm3 = mem[0],zero,zero,zero
	vcmpeqps	%ymm3, %ymm13, %ymm3
	vpbroadcastw	%xmm3, %xmm3
	vpmovsxwd	%xmm3, %ymm3
	vpand	%ymm3, %ymm10, %ymm3
	vpshufb	%ymm1, %ymm3, %ymm4
	vpermq	$232, %ymm4, %ymm4              # ymm4 = ymm4[0,2,2,3]
	vpshufb	%xmm2, %xmm4, %xmm4
	vpsllw	$7, %xmm4, %xmm4
	vpand	%xmm5, %xmm4, %xmm4
	vpcmpgtb	%xmm4, %xmm6, %xmm4
	vpandn	%xmm7, %xmm4, %xmm7
	vpand	%ymm0, %ymm3, %ymm3
	vpor	%ymm3, %ymm9, %ymm9
	vmovmskps	%ymm9, %edx
	cmpb	%dl, %al
	je	.LBB4_12
# %bb.30:                               # %no_return87.i434
                                        #   in Loop: Header=BB4_29 Depth=2
	vpandn	%ymm10, %ymm9, %ymm3
	vpsubd	%ymm14, %ymm8, %ymm8
	vpbroadcastd	.LCPI4_6(%rip), %ymm4   # ymm4 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm8, %ymm4, %ymm4
	vpand	%ymm3, %ymm4, %ymm10
	vpand	%ymm0, %ymm10, %ymm3
	vmovmskps	%ymm3, %edx
	addl	$4, %ecx
	testb	%dl, %dl
	jne	.LBB4_29
	jmp	.LBB4_11
.LBB4_13:                               # %for_test59.preheader
	vmovss	(%rbx), %xmm0                   # xmm0 = mem[0],zero,zero,zero
	vmovss	4(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB4_14
# %bb.15:                               # %for_step61
	vmovss	8(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB4_16
.LBB4_17:                               # %for_step61.1
	vmovss	12(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB4_18
.LBB4_19:                               # %for_step61.2
	vmovss	16(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB4_20
.LBB4_21:                               # %for_step61.3
	vmovss	20(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB4_22
.LBB4_23:                               # %for_step61.4
	vmovss	24(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB4_24
.LBB4_25:                               # %for_step61.5
	vmovss	28(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB4_27
.LBB4_26:                               # %if_then.6
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
.LBB4_27:                               # %for_step61.6
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
.LBB4_14:                               # %if_then
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	8(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB4_17
.LBB4_16:                               # %if_then.1
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	12(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB4_19
.LBB4_18:                               # %if_then.2
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	16(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB4_21
.LBB4_20:                               # %if_then.3
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	20(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB4_23
.LBB4_22:                               # %if_then.4
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	24(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	jbe	.LBB4_25
.LBB4_24:                               # %if_then.5
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	28(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm1, %xmm0
	ja	.LBB4_26
	jmp	.LBB4_27
.Lfunc_end4:
	.size	parallelmin, .Lfunc_end4-parallelmin
                                        # -- End function
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5                               # -- Begin function parallelmax
.LCPI5_0:
	.quad	4                               # 0x4
	.quad	5                               # 0x5
	.quad	6                               # 0x6
	.quad	7                               # 0x7
.LCPI5_1:
	.quad	0                               # 0x0
	.quad	1                               # 0x1
	.quad	2                               # 0x2
	.quad	3                               # 0x3
.LCPI5_3:
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	4                               # 0x4
	.byte	5                               # 0x5
	.byte	8                               # 0x8
	.byte	9                               # 0x9
	.byte	12                              # 0xc
	.byte	13                              # 0xd
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.byte	16                              # 0x10
	.byte	17                              # 0x11
	.byte	20                              # 0x14
	.byte	21                              # 0x15
	.byte	24                              # 0x18
	.byte	25                              # 0x19
	.byte	28                              # 0x1c
	.byte	29                              # 0x1d
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI5_2:
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.long	0                               # 0x0
	.long	0                               # 0x0
.LCPI5_4:
	.byte	0                               # 0x0
	.byte	2                               # 0x2
	.byte	4                               # 0x4
	.byte	6                               # 0x6
	.byte	8                               # 0x8
	.byte	10                              # 0xa
	.byte	12                              # 0xc
	.byte	14                              # 0xe
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
.LCPI5_5:
	.zero	16,128
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI5_6:
	.long	8                               # 0x8
	.text
	.globl	parallelmax
	.p2align	4, 0x90
	.type	parallelmax,@function
parallelmax:                            # @parallelmax
# %bb.0:                                # %allocas
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movl	%esi, %ebp
	movq	%rdi, %rbx
	vpcmpeqd	%ymm0, %ymm0, %ymm0
	callq	__new_varying32_64rt
	vpaddq	.LCPI5_0(%rip), %ymm1, %ymm1
	vpaddq	.LCPI5_1(%rip), %ymm0, %ymm0
	vmovq	%xmm0, %r8
	vpextrq	$1, %xmm0, %r9
	movb	$0, (%r8)
	movb	$0, (%r9)
	vextracti128	$1, %ymm0, %xmm0
	vmovq	%xmm0, %r10
	movb	$0, (%r10)
	vpextrq	$1, %xmm0, %r11
	movb	$0, (%r11)
	vmovq	%xmm1, %r14
	movb	$0, (%r14)
	vpextrq	$1, %xmm1, %r15
	movb	$0, (%r15)
	vextracti128	$1, %ymm1, %xmm0
	vmovq	%xmm0, %r12
	movb	$0, (%r12)
	vpextrq	$1, %xmm0, %rdx
	movb	$0, (%rdx)
	testl	%ebp, %ebp
	jle	.LBB5_4
# %bb.1:                                # %for_loop.lr.ph
	xorl	%esi, %esi
	xorl	%edi, %edi
	jmp	.LBB5_2
	.p2align	4, 0x90
.LBB5_3:                                # %safe_if_after_true
                                        #   in Loop: Header=BB5_2 Depth=1
	addl	$8, %edi
	addl	$32, %esi
	cmpl	%ebp, %edi
	jge	.LBB5_4
.LBB5_2:                                # %for_loop
                                        # =>This Inner Loop Header: Depth=1
	movslq	%esi, %rax
	vmovups	(%rbx), %ymm0
	vcmpltps	(%rbx,%rax), %ymm0, %ymm0
	vmovmskps	%ymm0, %ecx
	testb	%cl, %cl
	je	.LBB5_3
# %bb.31:                               # %safe_if_run_true
                                        #   in Loop: Header=BB5_2 Depth=1
	addq	%rbx, %rax
	vmaskmovps	(%rax), %ymm0, %ymm1
	vmaskmovps	%ymm1, %ymm0, (%rbx)
	jmp	.LBB5_3
.LBB5_4:                                # %for_exit
	movb	$-1, (%r8)
	movb	$-1, (%r9)
	movb	$-1, (%r10)
	movb	$-1, (%r11)
	movb	$-1, (%r14)
	movb	$-1, (%r15)
	movb	$-1, (%r12)
	movb	$-1, (%rdx)
	vmovaps	.LCPI5_2(%rip), %xmm0           # xmm0 = [4294967295,0,0,0]
	vmovdqa	.LCPI5_3(%rip), %ymm1           # ymm1 = <0,1,4,5,8,9,12,13,u,u,u,u,u,u,u,u,16,17,20,21,24,25,28,29,u,u,u,u,u,u,u,u>
	vmovdqa	.LCPI5_4(%rip), %xmm2           # xmm2 = <0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u>
	vpcmpeqd	%xmm12, %xmm12, %xmm12
	vxorps	%xmm13, %xmm13, %xmm13
	vmovdqa	.LCPI5_5(%rip), %xmm5           # xmm5 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
	vpxor	%xmm6, %xmm6, %xmm6
                                        # implicit-def: $xmm7
	vpcmpeqd	%ymm14, %ymm14, %ymm14
	jmp	.LBB5_5
	.p2align	4, 0x90
.LBB5_6:                                #   in Loop: Header=BB5_5 Depth=1
	vxorps	%xmm9, %xmm9, %xmm9
.LBB5_11:                               # %for_exit.i396
                                        #   in Loop: Header=BB5_5 Depth=1
	vpshufb	%ymm1, %ymm9, %ymm3
	vpermq	$232, %ymm3, %ymm3              # ymm3 = ymm3[0,2,2,3]
	vpshufb	%xmm2, %xmm3, %xmm3
	vpsllw	$7, %xmm3, %xmm3
	vpblendvb	%xmm3, %xmm7, %xmm12, %xmm7
.LBB5_12:                               # %check_local_compare_is_done___vy_3C_unf_3E_uni.exit435
                                        #   in Loop: Header=BB5_5 Depth=1
	vpxor	%xmm7, %xmm12, %xmm3
	vpmovsxbd	%xmm3, %ymm3
	vpand	%ymm3, %ymm0, %ymm0
	vmovmskps	%ymm0, %eax
	testb	%al, %al
	je	.LBB5_13
.LBB5_5:                                # %for_test43
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_29 Depth 2
                                        #     Child Loop BB5_9 Depth 2
	vmovmskps	%ymm0, %eax
	testb	%al, %al
	je	.LBB5_6
# %bb.7:                                # %for_test43
                                        #   in Loop: Header=BB5_5 Depth=1
	vpxor	%xmm8, %xmm8, %xmm8
	vpcmpeqd	%ymm10, %ymm10, %ymm10
	cmpb	$-1, %al
	jne	.LBB5_28
# %bb.8:                                # %for_loop.i392.preheader
                                        #   in Loop: Header=BB5_5 Depth=1
	xorl	%eax, %eax
	vpxor	%xmm9, %xmm9, %xmm9
	.p2align	4, 0x90
.LBB5_9:                                # %for_loop.i392
                                        #   Parent Loop BB5_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%eax, %rcx
	vmovss	(%rbx,%rcx), %xmm11             # xmm11 = mem[0],zero,zero,zero
	vcmpeqps	%ymm13, %ymm11, %ymm11
	vpbroadcastw	%xmm11, %xmm3
	vpmovsxwd	%xmm3, %ymm3
	vpand	%ymm3, %ymm10, %ymm3
	vpshufb	%ymm1, %ymm3, %ymm11
	vpermq	$232, %ymm11, %ymm11            # ymm11 = ymm11[0,2,2,3]
	vpshufb	%xmm2, %xmm11, %xmm4
	vpsllw	$7, %xmm4, %xmm4
	vpand	%xmm5, %xmm4, %xmm4
	vpcmpgtb	%xmm4, %xmm6, %xmm4
	vpandn	%xmm7, %xmm4, %xmm7
	vpor	%ymm3, %ymm9, %ymm9
	vmovmskps	%ymm9, %ecx
	cmpb	$-1, %cl
	je	.LBB5_12
# %bb.10:                               # %no_return.i427
                                        #   in Loop: Header=BB5_9 Depth=2
	vpandn	%ymm10, %ymm9, %ymm3
	vpsubd	%ymm14, %ymm8, %ymm8
	vpbroadcastd	.LCPI5_6(%rip), %ymm4   # ymm4 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm8, %ymm4, %ymm4
	vpand	%ymm3, %ymm4, %ymm10
	vmovmskps	%ymm10, %ecx
	addl	$4, %eax
	testb	%cl, %cl
	jne	.LBB5_9
	jmp	.LBB5_11
	.p2align	4, 0x90
.LBB5_28:                               # %for_loop51.i416.preheader
                                        #   in Loop: Header=BB5_5 Depth=1
	xorl	%ecx, %ecx
	vpxor	%xmm9, %xmm9, %xmm9
	.p2align	4, 0x90
.LBB5_29:                               # %for_loop51.i416
                                        #   Parent Loop BB5_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%ecx, %rdx
	vmovss	(%rbx,%rdx), %xmm3              # xmm3 = mem[0],zero,zero,zero
	vcmpeqps	%ymm3, %ymm13, %ymm3
	vpbroadcastw	%xmm3, %xmm3
	vpmovsxwd	%xmm3, %ymm3
	vpand	%ymm3, %ymm10, %ymm3
	vpshufb	%ymm1, %ymm3, %ymm4
	vpermq	$232, %ymm4, %ymm4              # ymm4 = ymm4[0,2,2,3]
	vpshufb	%xmm2, %xmm4, %xmm4
	vpsllw	$7, %xmm4, %xmm4
	vpand	%xmm5, %xmm4, %xmm4
	vpcmpgtb	%xmm4, %xmm6, %xmm4
	vpandn	%xmm7, %xmm4, %xmm7
	vpand	%ymm0, %ymm3, %ymm3
	vpor	%ymm3, %ymm9, %ymm9
	vmovmskps	%ymm9, %edx
	cmpb	%dl, %al
	je	.LBB5_12
# %bb.30:                               # %no_return87.i434
                                        #   in Loop: Header=BB5_29 Depth=2
	vpandn	%ymm10, %ymm9, %ymm3
	vpsubd	%ymm14, %ymm8, %ymm8
	vpbroadcastd	.LCPI5_6(%rip), %ymm4   # ymm4 = [8,8,8,8,8,8,8,8]
	vpcmpgtd	%ymm8, %ymm4, %ymm4
	vpand	%ymm3, %ymm4, %ymm10
	vpand	%ymm0, %ymm10, %ymm3
	vmovmskps	%ymm3, %edx
	addl	$4, %ecx
	testb	%dl, %dl
	jne	.LBB5_29
	jmp	.LBB5_11
.LBB5_13:                               # %for_test59.preheader
	vmovss	(%rbx), %xmm0                   # xmm0 = mem[0],zero,zero,zero
	vmovss	4(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB5_14
# %bb.15:                               # %for_step61
	vmovss	8(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB5_16
.LBB5_17:                               # %for_step61.1
	vmovss	12(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB5_18
.LBB5_19:                               # %for_step61.2
	vmovss	16(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB5_20
.LBB5_21:                               # %for_step61.3
	vmovss	20(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB5_22
.LBB5_23:                               # %for_step61.4
	vmovss	24(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB5_24
.LBB5_25:                               # %for_step61.5
	vmovss	28(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB5_27
.LBB5_26:                               # %if_then.6
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
.LBB5_27:                               # %for_step61.6
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
.LBB5_14:                               # %if_then
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	8(%rbx), %xmm1                  # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB5_17
.LBB5_16:                               # %if_then.1
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	12(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB5_19
.LBB5_18:                               # %if_then.2
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	16(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB5_21
.LBB5_20:                               # %if_then.3
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	20(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB5_23
.LBB5_22:                               # %if_then.4
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	24(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	.LBB5_25
.LBB5_24:                               # %if_then.5
	vmovss	%xmm1, (%rbx)
	vmovaps	%xmm1, %xmm0
	vmovss	28(%rbx), %xmm1                 # xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	.LBB5_26
	jmp	.LBB5_27
.Lfunc_end5:
	.size	parallelmax, .Lfunc_end5-parallelmax
                                        # -- End function
	.ident	"clang version 12.0.1 (/usr/local/src/llvm/llvm-12.0/clang fed41342a82f5a3a9201819a82bf7a48313e296b)"
	.section	".note.GNU-stack","",@progbits
