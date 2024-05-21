	.text
	.file	"sinx.ispc"
	.globl	interleaved_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_ # -- Begin function interleaved_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_
	.p2align	4, 0x90
	.type	interleaved_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_,@function
interleaved_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_: # @interleaved_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_
# %bb.0:                                # %allocas
	pushq	%rbp
	pushq	%rbx
	vmovmskps	%ymm0, %eax
	cmpb	$-1, %al
	je	.LBB0_9
# %bb.1:                                # %for_test82.preheader
	testl	%edi, %edi
	jle	.LBB0_17
# %bb.2:                                # %for_loop83.lr.ph
	testl	%esi, %esi
	jle	.LBB0_7
# %bb.3:                                # %for_loop128.lr.ph.preheader
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB0_4:                                # %for_loop128.lr.ph
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_5 Depth 2
	leal	(,%r9,4), %eax
	movslq	%eax, %r8
	vmaskmovps	(%rdx,%r8), %ymm0, %ymm1
	vmulps	%ymm1, %ymm1, %ymm2
	movl	$6, %eax
	movl	$-1, %r10d
	movl	$1, %r11d
	movl	$4, %ebx
	vmovaps	%ymm1, %ymm3
	.p2align	4, 0x90
.LBB0_5:                                # %for_loop128
                                        #   Parent Loop BB0_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmulps	%ymm2, %ymm1, %ymm1
	vcvtsi2ss	%r10d, %xmm6, %xmm4
	vbroadcastss	%xmm4, %ymm4
	vmulps	%ymm4, %ymm1, %ymm4
	vcvtsi2ss	%eax, %xmm6, %xmm5
	vbroadcastss	%xmm5, %ymm5
	vdivps	%ymm5, %ymm4, %ymm4
	vaddps	%ymm4, %ymm3, %ymm3
	leal	1(%rbx), %ebp
	imull	%ebx, %eax
	imull	%ebp, %eax
	negl	%r10d
	incl	%r11d
	addl	$2, %ebx
	cmpl	%esi, %r11d
	jle	.LBB0_5
# %bb.6:                                # %for_exit130
                                        #   in Loop: Header=BB0_4 Depth=1
	vmaskmovps	%ymm3, %ymm0, (%rcx,%r8)
	addl	$8, %r9d
	cmpl	%edi, %r9d
	jl	.LBB0_4
	jmp	.LBB0_17
.LBB0_9:                                # %for_test.preheader
	testl	%edi, %edi
	jle	.LBB0_17
# %bb.10:                               # %for_loop.lr.ph
	testl	%esi, %esi
	jle	.LBB0_15
# %bb.11:                               # %for_loop39.lr.ph.preheader
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB0_12:                               # %for_loop39.lr.ph
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_13 Depth 2
	leal	(,%r9,4), %eax
	movslq	%eax, %r8
	vmovups	(%rdx,%r8), %ymm0
	vmulps	%ymm0, %ymm0, %ymm1
	movl	$6, %eax
	movl	$-1, %r10d
	movl	$1, %r11d
	movl	$4, %ebx
	vmovaps	%ymm0, %ymm2
	.p2align	4, 0x90
.LBB0_13:                               # %for_loop39
                                        #   Parent Loop BB0_12 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmulps	%ymm1, %ymm0, %ymm0
	vcvtsi2ss	%r10d, %xmm5, %xmm3
	vbroadcastss	%xmm3, %ymm3
	vmulps	%ymm3, %ymm0, %ymm3
	vcvtsi2ss	%eax, %xmm5, %xmm4
	vbroadcastss	%xmm4, %ymm4
	vdivps	%ymm4, %ymm3, %ymm3
	vaddps	%ymm3, %ymm2, %ymm2
	leal	1(%rbx), %ebp
	imull	%ebx, %eax
	imull	%ebp, %eax
	negl	%r10d
	incl	%r11d
	addl	$2, %ebx
	cmpl	%esi, %r11d
	jle	.LBB0_13
# %bb.14:                               # %for_exit41
                                        #   in Loop: Header=BB0_12 Depth=1
	vmovups	%ymm2, (%rcx,%r8)
	addl	$8, %r9d
	cmpl	%edi, %r9d
	jl	.LBB0_12
	jmp	.LBB0_17
.LBB0_7:                                # %for_exit130.us.preheader
	xorl	%eax, %eax
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB0_8:                                # %for_exit130.us
                                        # =>This Inner Loop Header: Depth=1
	cltq
	vmaskmovps	(%rdx,%rax), %ymm0, %ymm1
	vmaskmovps	%ymm1, %ymm0, (%rcx,%rax)
	addl	$8, %esi
	addl	$32, %eax
	cmpl	%edi, %esi
	jl	.LBB0_8
	jmp	.LBB0_17
.LBB0_15:                               # %for_exit41.us.preheader
	xorl	%eax, %eax
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB0_16:                               # %for_exit41.us
                                        # =>This Inner Loop Header: Depth=1
	cltq
	vmovups	(%rdx,%rax), %ymm0
	vmovups	%ymm0, (%rcx,%rax)
	addl	$8, %esi
	addl	$32, %eax
	cmpl	%edi, %esi
	jl	.LBB0_16
.LBB0_17:                               # %for_exit
	popq	%rbx
	popq	%rbp
	vzeroupper
	retq
.Lfunc_end0:
	.size	interleaved_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_, .Lfunc_end0-interleaved_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_
                                        # -- End function
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5                               # -- Begin function blocked_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_
.LCPI1_0:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	5                               # 0x5
	.long	6                               # 0x6
	.long	7                               # 0x7
	.text
	.globl	blocked_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_
	.p2align	4, 0x90
	.type	blocked_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_,@function
blocked_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_: # @blocked_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_
# %bb.0:                                # %allocas
	pushq	%rbp
	pushq	%r14
	pushq	%rbx
                                        # kill: def $edi killed $edi def $rdi
	vmovmskps	%ymm0, %r8d
	leal	7(%rdi), %r9d
	testl	%edi, %edi
	cmovnsl	%edi, %r9d
	vmovd	%r9d, %xmm1
	sarl	$3, %r9d
	vpbroadcastd	%xmm1, %ymm1
	vpsrad	$3, %ymm1, %ymm1
	vpmulld	.LCPI1_0(%rip), %ymm1, %ymm1
	cmpb	$-1, %r8b
	je	.LBB1_41
# %bb.1:                                # %for_test88.preheader
	cmpl	$8, %edi
	jl	.LBB1_49
# %bb.2:                                # %for_loop89.lr.ph
	movzbl	%r8b, %r10d
	testl	%esi, %esi
	jle	.LBB1_23
# %bb.3:                                # %for_loop135.lr.ph.preheader
	xorl	%r11d, %r11d
	jmp	.LBB1_4
	.p2align	4, 0x90
.LBB1_20:                               # %pl_loopend.6.i
                                        #   in Loop: Header=BB1_4 Depth=1
	testb	%r8b, %r8b
	js	.LBB1_21
# %bb.22:                               # %__scatter_factored_base_offsets32_float.exit
                                        #   in Loop: Header=BB1_4 Depth=1
	incl	%r11d
	cmpl	%r9d, %r11d
	je	.LBB1_49
.LBB1_4:                                # %for_loop135.lr.ph
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_5 Depth 2
	vmovd	%r11d, %xmm2
	vpbroadcastd	%xmm2, %ymm2
	vpaddd	%ymm1, %ymm2, %ymm2
	vpslld	$2, %ymm2, %ymm2
	vmovaps	%ymm0, %ymm3
	vxorps	%xmm4, %xmm4, %xmm4
	vgatherdps	%ymm3, (%rdx,%ymm2), %ymm4
	vmulps	%ymm4, %ymm4, %ymm5
	movl	$6, %edi
	movl	$-1, %ebp
	movl	$1, %ebx
	movl	$4, %eax
	vmovaps	%ymm4, %ymm3
	.p2align	4, 0x90
.LBB1_5:                                # %for_loop135
                                        #   Parent Loop BB1_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmulps	%ymm5, %ymm4, %ymm4
	vcvtsi2ss	%ebp, %xmm8, %xmm6
	vbroadcastss	%xmm6, %ymm6
	vmulps	%ymm6, %ymm4, %ymm6
	vcvtsi2ss	%edi, %xmm8, %xmm7
	vbroadcastss	%xmm7, %ymm7
	vdivps	%ymm7, %ymm6, %ymm6
	vaddps	%ymm6, %ymm3, %ymm3
	leal	1(%rax), %r14d
	imull	%eax, %edi
	imull	%r14d, %edi
	negl	%ebp
	incl	%ebx
	addl	$2, %eax
	cmpl	%esi, %ebx
	jle	.LBB1_5
# %bb.6:                                # %for_exit137
                                        #   in Loop: Header=BB1_4 Depth=1
	testb	$1, %r10b
	jne	.LBB1_7
# %bb.8:                                # %pl_loopend.i
                                        #   in Loop: Header=BB1_4 Depth=1
	testb	$2, %r10b
	jne	.LBB1_9
.LBB1_10:                               # %pl_loopend.1.i
                                        #   in Loop: Header=BB1_4 Depth=1
	testb	$4, %r10b
	jne	.LBB1_11
.LBB1_12:                               # %pl_loopend.2.i
                                        #   in Loop: Header=BB1_4 Depth=1
	testb	$8, %r10b
	jne	.LBB1_13
.LBB1_14:                               # %pl_loopend.3.i
                                        #   in Loop: Header=BB1_4 Depth=1
	testb	$16, %r10b
	jne	.LBB1_15
.LBB1_16:                               # %pl_loopend.4.i
                                        #   in Loop: Header=BB1_4 Depth=1
	testb	$32, %r10b
	jne	.LBB1_17
.LBB1_18:                               # %pl_loopend.5.i
                                        #   in Loop: Header=BB1_4 Depth=1
	testb	$64, %r10b
	je	.LBB1_20
	jmp	.LBB1_19
	.p2align	4, 0x90
.LBB1_7:                                # %pl_dolane.i
                                        #   in Loop: Header=BB1_4 Depth=1
	vmovd	%xmm2, %eax
	cltq
	vmovss	%xmm3, (%rcx,%rax)
	testb	$2, %r10b
	je	.LBB1_10
.LBB1_9:                                # %pl_dolane.1.i
                                        #   in Loop: Header=BB1_4 Depth=1
	vpextrd	$1, %xmm2, %eax
	cltq
	vextractps	$1, %xmm3, (%rcx,%rax)
	testb	$4, %r10b
	je	.LBB1_12
.LBB1_11:                               # %pl_dolane.2.i
                                        #   in Loop: Header=BB1_4 Depth=1
	vpextrd	$2, %xmm2, %eax
	cltq
	vextractps	$2, %xmm3, (%rcx,%rax)
	testb	$8, %r10b
	je	.LBB1_14
.LBB1_13:                               # %pl_dolane.3.i
                                        #   in Loop: Header=BB1_4 Depth=1
	vpextrd	$3, %xmm2, %eax
	cltq
	vextractps	$3, %xmm3, (%rcx,%rax)
	testb	$16, %r10b
	je	.LBB1_16
.LBB1_15:                               # %pl_dolane.4.i
                                        #   in Loop: Header=BB1_4 Depth=1
	vextracti128	$1, %ymm2, %xmm4
	vmovd	%xmm4, %eax
	cltq
	vextractf128	$1, %ymm3, %xmm4
	vmovss	%xmm4, (%rcx,%rax)
	testb	$32, %r10b
	je	.LBB1_18
.LBB1_17:                               # %pl_dolane.5.i
                                        #   in Loop: Header=BB1_4 Depth=1
	vextractf128	$1, %ymm2, %xmm4
	vextractps	$1, %xmm4, %eax
	cltq
	vextractf128	$1, %ymm3, %xmm4
	vextractps	$1, %xmm4, (%rcx,%rax)
	testb	$64, %r10b
	je	.LBB1_20
.LBB1_19:                               # %pl_dolane.6.i
                                        #   in Loop: Header=BB1_4 Depth=1
	vextractf128	$1, %ymm2, %xmm4
	vextractps	$2, %xmm4, %eax
	cltq
	vextractf128	$1, %ymm3, %xmm4
	vextractps	$2, %xmm4, (%rcx,%rax)
	jmp	.LBB1_20
	.p2align	4, 0x90
.LBB1_21:                               # %pl_dolane.7.i
                                        #   in Loop: Header=BB1_4 Depth=1
	vextractf128	$1, %ymm2, %xmm2
	vextractps	$3, %xmm2, %eax
	cltq
	vextractf128	$1, %ymm3, %xmm2
	vextractps	$3, %xmm2, (%rcx,%rax)
	incl	%r11d
	cmpl	%r9d, %r11d
	jne	.LBB1_4
	jmp	.LBB1_49
.LBB1_41:                               # %for_test.preheader
	cmpl	$8, %edi
	jl	.LBB1_49
# %bb.42:                               # %for_loop.lr.ph
	testl	%esi, %esi
	jle	.LBB1_47
# %bb.43:                               # %for_loop41.lr.ph.preheader
	xorl	%r8d, %r8d
	.p2align	4, 0x90
.LBB1_44:                               # %for_loop41.lr.ph
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_45 Depth 2
	vmovd	%r8d, %xmm0
	vpbroadcastd	%xmm0, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vpslld	$2, %ymm0, %ymm2
	vpcmpeqd	%ymm3, %ymm3, %ymm3
	vpxor	%xmm0, %xmm0, %xmm0
	vgatherdps	%ymm3, (%rdx,%ymm2), %ymm0
	vmulps	%ymm0, %ymm0, %ymm3
	movl	$6, %edi
	movl	$-1, %r10d
	movl	$1, %eax
	movl	$4, %ebx
	vmovaps	%ymm0, %ymm4
	.p2align	4, 0x90
.LBB1_45:                               # %for_loop41
                                        #   Parent Loop BB1_44 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmulps	%ymm3, %ymm4, %ymm4
	vcvtsi2ss	%r10d, %xmm7, %xmm5
	vbroadcastss	%xmm5, %ymm5
	vmulps	%ymm5, %ymm4, %ymm5
	vcvtsi2ss	%edi, %xmm7, %xmm6
	vbroadcastss	%xmm6, %ymm6
	vdivps	%ymm6, %ymm5, %ymm5
	vaddps	%ymm5, %ymm0, %ymm0
	leal	1(%rbx), %ebp
	imull	%ebx, %edi
	imull	%ebp, %edi
	negl	%r10d
	incl	%eax
	addl	$2, %ebx
	cmpl	%esi, %eax
	jle	.LBB1_45
# %bb.46:                               # %for_exit43
                                        #   in Loop: Header=BB1_44 Depth=1
	vmovd	%xmm2, %eax
	cltq
	vmovss	%xmm0, (%rcx,%rax)
	vpextrd	$1, %xmm2, %eax
	cltq
	vextractps	$1, %xmm0, (%rcx,%rax)
	vpextrd	$2, %xmm2, %eax
	cltq
	vextractps	$2, %xmm0, (%rcx,%rax)
	vpextrd	$3, %xmm2, %eax
	cltq
	vextractps	$3, %xmm0, (%rcx,%rax)
	vextracti128	$1, %ymm2, %xmm2
	vmovd	%xmm2, %eax
	cltq
	vextractf128	$1, %ymm0, %xmm0
	vmovss	%xmm0, (%rcx,%rax)
	vpextrd	$1, %xmm2, %eax
	cltq
	vextractps	$1, %xmm0, (%rcx,%rax)
	vpextrd	$2, %xmm2, %eax
	cltq
	vextractps	$2, %xmm0, (%rcx,%rax)
	vpextrd	$3, %xmm2, %eax
	cltq
	vextractps	$3, %xmm0, (%rcx,%rax)
	incl	%r8d
	cmpl	%r9d, %r8d
	jne	.LBB1_44
	jmp	.LBB1_49
.LBB1_23:                               # %for_exit137.us.preheader
	xorl	%eax, %eax
	jmp	.LBB1_24
	.p2align	4, 0x90
.LBB1_38:                               # %pl_loopend.6.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	testb	%r8b, %r8b
	js	.LBB1_39
# %bb.40:                               # %__scatter_factored_base_offsets32_float.exit.us
                                        #   in Loop: Header=BB1_24 Depth=1
	incl	%eax
	cmpl	%eax, %r9d
	je	.LBB1_49
.LBB1_24:                               # %for_exit137.us
                                        # =>This Inner Loop Header: Depth=1
	vmovd	%eax, %xmm2
	vpbroadcastd	%xmm2, %ymm2
	vpaddd	%ymm1, %ymm2, %ymm2
	vpslld	$2, %ymm2, %ymm2
	vxorps	%xmm3, %xmm3, %xmm3
	vmovaps	%ymm0, %ymm4
	vgatherdps	%ymm4, (%rdx,%ymm2), %ymm3
	testb	$1, %r10b
	jne	.LBB1_25
# %bb.26:                               # %pl_loopend.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	testb	$2, %r10b
	jne	.LBB1_27
.LBB1_28:                               # %pl_loopend.1.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	testb	$4, %r10b
	jne	.LBB1_29
.LBB1_30:                               # %pl_loopend.2.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	testb	$8, %r10b
	jne	.LBB1_31
.LBB1_32:                               # %pl_loopend.3.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	vextracti128	$1, %ymm2, %xmm4
	vextractf128	$1, %ymm3, %xmm2
	testb	$16, %r10b
	jne	.LBB1_33
.LBB1_34:                               # %pl_loopend.4.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	testb	$32, %r10b
	jne	.LBB1_35
.LBB1_36:                               # %pl_loopend.5.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	testb	$64, %r10b
	je	.LBB1_38
	jmp	.LBB1_37
	.p2align	4, 0x90
.LBB1_25:                               # %pl_dolane.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	vmovd	%xmm2, %esi
	movslq	%esi, %rsi
	vmovss	%xmm3, (%rcx,%rsi)
	testb	$2, %r10b
	je	.LBB1_28
.LBB1_27:                               # %pl_dolane.1.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	vpextrd	$1, %xmm2, %esi
	movslq	%esi, %rsi
	vextractps	$1, %xmm3, (%rcx,%rsi)
	testb	$4, %r10b
	je	.LBB1_30
.LBB1_29:                               # %pl_dolane.2.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	vpextrd	$2, %xmm2, %esi
	movslq	%esi, %rsi
	vextractps	$2, %xmm3, (%rcx,%rsi)
	testb	$8, %r10b
	je	.LBB1_32
.LBB1_31:                               # %pl_dolane.3.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	vpextrd	$3, %xmm2, %esi
	movslq	%esi, %rsi
	vextractps	$3, %xmm3, (%rcx,%rsi)
	vextracti128	$1, %ymm2, %xmm4
	vextractf128	$1, %ymm3, %xmm2
	testb	$16, %r10b
	je	.LBB1_34
.LBB1_33:                               # %pl_dolane.4.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	vmovd	%xmm4, %esi
	movslq	%esi, %rsi
	vmovss	%xmm2, (%rcx,%rsi)
	testb	$32, %r10b
	je	.LBB1_36
.LBB1_35:                               # %pl_dolane.5.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	vpextrd	$1, %xmm4, %esi
	movslq	%esi, %rsi
	vextractps	$1, %xmm2, (%rcx,%rsi)
	testb	$64, %r10b
	je	.LBB1_38
.LBB1_37:                               # %pl_dolane.6.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	vpextrd	$2, %xmm4, %esi
	movslq	%esi, %rsi
	vextractps	$2, %xmm2, (%rcx,%rsi)
	jmp	.LBB1_38
	.p2align	4, 0x90
.LBB1_39:                               # %pl_dolane.7.i.us
                                        #   in Loop: Header=BB1_24 Depth=1
	vpextrd	$3, %xmm4, %esi
	movslq	%esi, %rsi
	vextractps	$3, %xmm2, (%rcx,%rsi)
	incl	%eax
	cmpl	%eax, %r9d
	jne	.LBB1_24
	jmp	.LBB1_49
.LBB1_47:                               # %for_exit43.us.preheader
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB1_48:                               # %for_exit43.us
                                        # =>This Inner Loop Header: Depth=1
	vmovd	%eax, %xmm0
	vpbroadcastd	%xmm0, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm0
	vpslld	$2, %ymm0, %ymm0
	vpcmpeqd	%ymm2, %ymm2, %ymm2
	vxorps	%xmm3, %xmm3, %xmm3
	vgatherdps	%ymm2, (%rdx,%ymm0), %ymm3
	vmovd	%xmm0, %esi
	movslq	%esi, %rsi
	vmovss	%xmm3, (%rcx,%rsi)
	vpextrd	$1, %xmm0, %esi
	movslq	%esi, %rsi
	vextractps	$1, %xmm3, (%rcx,%rsi)
	vpextrd	$2, %xmm0, %esi
	movslq	%esi, %rsi
	vextractps	$2, %xmm3, (%rcx,%rsi)
	vpextrd	$3, %xmm0, %esi
	movslq	%esi, %rsi
	vextractps	$3, %xmm3, (%rcx,%rsi)
	vextracti128	$1, %ymm0, %xmm0
	vmovd	%xmm0, %esi
	movslq	%esi, %rsi
	vextractf128	$1, %ymm3, %xmm2
	vmovss	%xmm2, (%rcx,%rsi)
	vpextrd	$1, %xmm0, %esi
	movslq	%esi, %rsi
	vextractps	$1, %xmm2, (%rcx,%rsi)
	vpextrd	$2, %xmm0, %esi
	movslq	%esi, %rsi
	vextractps	$2, %xmm2, (%rcx,%rsi)
	vpextrd	$3, %xmm0, %esi
	movslq	%esi, %rsi
	vextractps	$3, %xmm2, (%rcx,%rsi)
	incl	%eax
	cmpl	%eax, %r9d
	jne	.LBB1_48
.LBB1_49:                               # %for_exit
	popq	%rbx
	popq	%r14
	popq	%rbp
	vzeroupper
	retq
.Lfunc_end1:
	.size	blocked_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_, .Lfunc_end1-blocked_sinx___uniuniun_3C_unf_3E_un_3C_unf_3E_
                                        # -- End function
	.globl	interleaved_sinx                # -- Begin function interleaved_sinx
	.p2align	4, 0x90
	.type	interleaved_sinx,@function
interleaved_sinx:                       # @interleaved_sinx
# %bb.0:                                # %allocas
	pushq	%rbp
	pushq	%rbx
	testl	%edi, %edi
	jle	.LBB2_8
# %bb.1:                                # %for_loop.lr.ph
	testl	%esi, %esi
	jle	.LBB2_6
# %bb.2:                                # %for_loop27.lr.ph.preheader
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB2_3:                                # %for_loop27.lr.ph
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_4 Depth 2
	leal	(,%r9,4), %eax
	movslq	%eax, %r8
	vmovups	(%rdx,%r8), %ymm0
	vmulps	%ymm0, %ymm0, %ymm1
	movl	$6, %eax
	movl	$-1, %r10d
	movl	$1, %r11d
	movl	$4, %ebx
	vmovaps	%ymm0, %ymm2
	.p2align	4, 0x90
.LBB2_4:                                # %for_loop27
                                        #   Parent Loop BB2_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmulps	%ymm1, %ymm0, %ymm0
	vcvtsi2ss	%r10d, %xmm5, %xmm3
	vbroadcastss	%xmm3, %ymm3
	vmulps	%ymm3, %ymm0, %ymm3
	vcvtsi2ss	%eax, %xmm5, %xmm4
	vbroadcastss	%xmm4, %ymm4
	vdivps	%ymm4, %ymm3, %ymm3
	vaddps	%ymm3, %ymm2, %ymm2
	leal	1(%rbx), %ebp
	imull	%ebx, %eax
	imull	%ebp, %eax
	negl	%r10d
	incl	%r11d
	addl	$2, %ebx
	cmpl	%esi, %r11d
	jle	.LBB2_4
# %bb.5:                                # %for_exit29
                                        #   in Loop: Header=BB2_3 Depth=1
	vmovups	%ymm2, (%rcx,%r8)
	addl	$8, %r9d
	cmpl	%edi, %r9d
	jl	.LBB2_3
	jmp	.LBB2_8
.LBB2_6:                                # %for_exit29.us.preheader
	xorl	%eax, %eax
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB2_7:                                # %for_exit29.us
                                        # =>This Inner Loop Header: Depth=1
	cltq
	vmovups	(%rdx,%rax), %ymm0
	vmovups	%ymm0, (%rcx,%rax)
	addl	$8, %esi
	addl	$32, %eax
	cmpl	%edi, %esi
	jl	.LBB2_7
.LBB2_8:                                # %for_exit
	popq	%rbx
	popq	%rbp
	vzeroupper
	retq
.Lfunc_end2:
	.size	interleaved_sinx, .Lfunc_end2-interleaved_sinx
                                        # -- End function
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5                               # -- Begin function blocked_sinx
.LCPI3_0:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	5                               # 0x5
	.long	6                               # 0x6
	.long	7                               # 0x7
	.text
	.globl	blocked_sinx
	.p2align	4, 0x90
	.type	blocked_sinx,@function
blocked_sinx:                           # @blocked_sinx
# %bb.0:                                # %allocas
	pushq	%rbx
                                        # kill: def $edi killed $edi def $rdi
	leal	7(%rdi), %r8d
	testl	%edi, %edi
	cmovnsl	%edi, %r8d
	cmpl	$8, %edi
	jl	.LBB3_8
# %bb.1:                                # %for_loop.lr.ph
	vmovd	%r8d, %xmm0
	sarl	$3, %r8d
	vpbroadcastd	%xmm0, %ymm0
	vpsrad	$3, %ymm0, %ymm0
	vpmulld	.LCPI3_0(%rip), %ymm0, %ymm0
	testl	%esi, %esi
	jle	.LBB3_6
# %bb.2:                                # %for_loop29.lr.ph.preheader
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB3_3:                                # %for_loop29.lr.ph
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_4 Depth 2
	vmovd	%r9d, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm1
	vpslld	$2, %ymm1, %ymm2
	vpxor	%xmm1, %xmm1, %xmm1
	vpcmpeqd	%ymm3, %ymm3, %ymm3
	vgatherdps	%ymm3, (%rdx,%ymm2), %ymm1
	vmulps	%ymm1, %ymm1, %ymm3
	movl	$6, %eax
	movl	$-1, %r10d
	movl	$1, %r11d
	movl	$4, %edi
	vmovaps	%ymm1, %ymm4
	.p2align	4, 0x90
.LBB3_4:                                # %for_loop29
                                        #   Parent Loop BB3_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmulps	%ymm3, %ymm4, %ymm4
	vcvtsi2ss	%r10d, %xmm7, %xmm5
	vbroadcastss	%xmm5, %ymm5
	vmulps	%ymm5, %ymm4, %ymm5
	vcvtsi2ss	%eax, %xmm7, %xmm6
	vbroadcastss	%xmm6, %ymm6
	vdivps	%ymm6, %ymm5, %ymm5
	vaddps	%ymm5, %ymm1, %ymm1
	leal	1(%rdi), %ebx
	imull	%edi, %eax
	imull	%ebx, %eax
	negl	%r10d
	incl	%r11d
	addl	$2, %edi
	cmpl	%esi, %r11d
	jle	.LBB3_4
# %bb.5:                                # %for_exit31
                                        #   in Loop: Header=BB3_3 Depth=1
	vmovd	%xmm2, %eax
	cltq
	vmovss	%xmm1, (%rcx,%rax)
	vpextrd	$1, %xmm2, %eax
	cltq
	vextractps	$1, %xmm1, (%rcx,%rax)
	vpextrd	$2, %xmm2, %eax
	cltq
	vextractps	$2, %xmm1, (%rcx,%rax)
	vpextrd	$3, %xmm2, %eax
	cltq
	vextractps	$3, %xmm1, (%rcx,%rax)
	vextracti128	$1, %ymm2, %xmm2
	vmovd	%xmm2, %eax
	cltq
	vextractf128	$1, %ymm1, %xmm1
	vmovss	%xmm1, (%rcx,%rax)
	vpextrd	$1, %xmm2, %eax
	cltq
	vextractps	$1, %xmm1, (%rcx,%rax)
	vpextrd	$2, %xmm2, %eax
	cltq
	vextractps	$2, %xmm1, (%rcx,%rax)
	vpextrd	$3, %xmm2, %eax
	cltq
	vextractps	$3, %xmm1, (%rcx,%rax)
	incl	%r9d
	cmpl	%r8d, %r9d
	jne	.LBB3_3
	jmp	.LBB3_8
.LBB3_6:                                # %for_exit31.us.preheader
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB3_7:                                # %for_exit31.us
                                        # =>This Inner Loop Header: Depth=1
	vmovd	%esi, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm1
	vpslld	$2, %ymm1, %ymm1
	vxorps	%xmm2, %xmm2, %xmm2
	vpcmpeqd	%ymm3, %ymm3, %ymm3
	vgatherdps	%ymm3, (%rdx,%ymm1), %ymm2
	vmovd	%xmm1, %eax
	cltq
	vmovss	%xmm2, (%rcx,%rax)
	vpextrd	$1, %xmm1, %eax
	cltq
	vextractps	$1, %xmm2, (%rcx,%rax)
	vpextrd	$2, %xmm1, %eax
	cltq
	vextractps	$2, %xmm2, (%rcx,%rax)
	vpextrd	$3, %xmm1, %eax
	cltq
	vextractps	$3, %xmm2, (%rcx,%rax)
	vextracti128	$1, %ymm1, %xmm1
	vmovd	%xmm1, %eax
	cltq
	vextractf128	$1, %ymm2, %xmm2
	vmovss	%xmm2, (%rcx,%rax)
	vpextrd	$1, %xmm1, %eax
	cltq
	vextractps	$1, %xmm2, (%rcx,%rax)
	vpextrd	$2, %xmm1, %eax
	cltq
	vextractps	$2, %xmm2, (%rcx,%rax)
	vpextrd	$3, %xmm1, %eax
	cltq
	vextractps	$3, %xmm2, (%rcx,%rax)
	incl	%esi
	cmpl	%esi, %r8d
	jne	.LBB3_7
.LBB3_8:                                # %for_exit
	popq	%rbx
	vzeroupper
	retq
.Lfunc_end3:
	.size	blocked_sinx, .Lfunc_end3-blocked_sinx
                                        # -- End function
	.ident	"clang version 12.0.1 (/usr/local/src/llvm/llvm-12.0/clang fed41342a82f5a3a9201819a82bf7a48313e296b)"
	.section	".note.GNU-stack","",@progbits
