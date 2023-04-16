	.file	"correl.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB5:
	.section	.text.startup,"ax",@progbits
.LHOTB5:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB36:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	movl	$1, %eax
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx
	addq	$-128, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	movq	$0, -112(%rbp)
	movq	$0, -104(%rbp)
	movq	$0, -96(%rbp)
	movq	$0, -88(%rbp)
	movq	$0, -80(%rbp)
	movq	$0, -72(%rbp)
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	cmpl	$3, %edi
	je	.L61
.L54:
	subq	$-128, %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L61:
	.cfi_restore_state
	movq	8(%rsi), %rdi
	leaq	-112(%rbp), %rdx
	movq	%rsi, %rbx
	movl	$16, %esi
	call	sf_open
	movq	16(%rbx), %rdi
	leaq	-80(%rbp), %rdx
	movl	$32, %esi
	movq	%rax, -128(%rbp)
	movl	-104(%rbp), %eax
	movl	$1, -68(%rbp)
	movl	%eax, -72(%rbp)
	movl	-96(%rbp), %eax
	movl	%eax, -64(%rbp)
	call	sf_open
	movq	-112(%rbp), %r13
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sd	-104(%rbp), %xmm0, %xmm0
	movslq	-100(%rbp), %rdi
	movq	%rax, -136(%rbp)
	vmulsd	.LC1(%rip), %xmm0, %xmm0
	leaq	0(,%r13,8), %rbx
	imulq	%r13, %rdi
	vcvttsd2si	%xmm0, %r15d
	salq	$3, %rdi
	call	malloc
	movq	%rbx, %rdi
	movq	%rax, -120(%rbp)
	call	malloc
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	malloc
	movq	%rbx, %rdi
	movq	%rax, -144(%rbp)
	call	malloc
	movq	-120(%rbp), %rsi
	movq	%r13, %rdx
	movq	-128(%rbp), %rdi
	movq	%rax, %r14
	call	sf_readf_double
	testl	%r15d, %r15d
	movq	-144(%rbp), %r10
	jle	.L3
	leal	-1(%r15), %eax
	xorl	%esi, %esi
	movq	%r14, %rdi
	movq	%r10, -152(%rbp)
	leaq	8(,%rax,8), %rdx
	movl	%eax, -144(%rbp)
	call	memset
	testq	%r13, %r13
	movl	-144(%rbp), %r11d
	movq	-152(%rbp), %r10
	jle	.L4
.L28:
	testq	%r13, %r13
	movl	$1, %edx
	cmovg	%r13, %rdx
	leaq	-4(%rdx), %rax
	shrq	$2, %rax
	addq	$1, %rax
	leaq	0(,%rax,4), %rdi
	cmpq	$3, %r13
	jle	.L36
	xorl	%esi, %esi
	xorl	%r11d, %r11d
.L6:
	movq	-120(%rbp), %rcx
	addq	$1, %r11
	vmovupd	(%rcx,%rsi,2), %xmm1
	vinsertf128	$0x1, 16(%rcx,%rsi,2), %ymm1, %ymm0
	vmovupd	32(%rcx,%rsi,2), %xmm1
	vinsertf128	$0x1, 48(%rcx,%rsi,2), %ymm1, %ymm1
	vinsertf128	$1, %xmm1, %ymm0, %ymm2
	vperm2f128	$49, %ymm1, %ymm0, %ymm1
	vunpcklpd	%ymm1, %ymm2, %ymm0
	vunpckhpd	%ymm1, %ymm2, %ymm1
	vmulpd	%ymm1, %ymm0, %ymm2
	vmulpd	%ymm0, %ymm0, %ymm0
	vmulpd	%ymm1, %ymm1, %ymm1
	vaddpd	%ymm1, %ymm0, %ymm0
	vmovups	%xmm2, (%r12,%rsi)
	vextractf128	$0x1, %ymm2, 16(%r12,%rsi)
	vmovups	%xmm0, (%r10,%rsi)
	vextractf128	$0x1, %ymm0, 16(%r10,%rsi)
	addq	$32, %rsi
	cmpq	%rax, %r11
	jb	.L6
	movslq	%edi, %rax
	cmpq	%rdx, %rdi
	je	.L62
	vzeroupper
.L5:
	movq	-120(%rbp), %rcx
	leal	(%rax,%rax), %edx
	movslq	%edx, %rdx
	leaq	(%rcx,%rdx,8), %rdx
.L8:
	vmovsd	(%rdx), %xmm0
	addq	$16, %rdx
	vmovsd	-8(%rdx), %xmm1
	vmulsd	%xmm1, %xmm0, %xmm2
	vmulsd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm1, %xmm1, %xmm1
	vmovsd	%xmm2, (%r12,%rax,8)
	vaddsd	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, (%r10,%rax,8)
	addq	$1, %rax
	cmpq	%rax, %r13
	jg	.L8
.L9:
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sd	-104(%rbp), %xmm0, %xmm0
	vmovsd	.LC2(%rip), %xmm1
	movq	%r10, -144(%rbp)
	vdivsd	%xmm0, %xmm1, %xmm1
	vmovsd	.LC3(%rip), %xmm0
	call	pow
	testl	%r15d, %r15d
	movq	-144(%rbp), %r10
	jle	.L10
	leal	-1(%r15), %r11d
.L27:
	testl	%r15d, %r15d
	movl	$8, %eax
	movq	%r14, %rdi
	movq	%r10, -152(%rbp)
	leaq	8(,%r11,8), %rdx
	vmovsd	%xmm0, -144(%rbp)
	cmovle	%rax, %rdx
	xorl	%esi, %esi
	call	memset
	movq	-152(%rbp), %r10
	vmovsd	-144(%rbp), %xmm0
.L10:
	leal	-1(%r13), %edi
	movslq	%r15d, %rax
	movq	%r13, %rsi
	subq	%rax, %rsi
	movslq	%edi, %rdx
	cmpq	%rsi, %rdx
	jl	.L37
	vxorpd	%xmm3, %xmm3, %xmm3
	subq	$1, %rsi
	vmovapd	%xmm3, %xmm2
	vmovapd	%xmm3, %xmm1
	.p2align 4,,10
	.p2align 3
.L12:
	vmulsd	%xmm0, %xmm1, %xmm1
	vmulsd	%xmm0, %xmm2, %xmm2
	vaddsd	(%r12,%rdx,8), %xmm1, %xmm1
	vaddsd	(%r10,%rdx,8), %xmm2, %xmm2
	subq	$1, %rdx
	cmpq	%rsi, %rdx
	jne	.L12
.L11:
	subl	%r15d, %edi
	js	.L17
	movl	%edi, %edx
	movslq	%edi, %rdi
	leaq	0(,%rdi,8), %rsi
	addq	$1, %rdx
	addq	%rax, %rdi
	imulq	$-8, %rdx, %rdx
	xorl	%eax, %eax
	leaq	(%r12,%rsi), %r11
	addq	%r10, %rsi
	leaq	(%r14,%rdi,8), %rdi
	.p2align 4,,10
	.p2align 3
.L16:
	vmulsd	%xmm0, %xmm1, %xmm1
	vmulsd	%xmm0, %xmm2, %xmm2
	vaddsd	(%r11,%rax), %xmm1, %xmm1
	vaddsd	(%rsi,%rax), %xmm2, %xmm2
	vdivsd	%xmm2, %xmm1, %xmm4
	vmovsd	%xmm4, (%rdi,%rax)
	subq	$8, %rax
	cmpq	%rdx, %rax
	jne	.L16
.L17:
	testq	%r13, %r13
	jle	.L15
	vmovsd	.LC4(%rip), %xmm2
	addq	%r14, %rbx
	movq	%r14, %rax
	vmovapd	%xmm3, %xmm1
	.p2align 4,,10
	.p2align 3
.L21:
	vmovsd	(%rax), %xmm0
	addq	$8, %rax
	vmaxsd	%xmm1, %xmm0, %xmm1
	vxorpd	%xmm2, %xmm0, %xmm0
	vmaxsd	%xmm1, %xmm0, %xmm0
	vmovapd	%xmm0, %xmm1
	cmpq	%rbx, %rax
	jne	.L21
	movq	%r14, %rax
	andl	$31, %eax
	shrq	$3, %rax
	negq	%rax
	andl	$3, %eax
	cmpq	%rax, %r13
	cmovbe	%r13, %rax
	cmpq	$4, %r13
	movq	%rax, %rsi
	cmovbe	%r13, %rsi
	testq	%rsi, %rsi
	je	.L38
	xorl	%eax, %eax
.L32:
	vmovsd	(%r14,%rax,8), %xmm1
	leal	1(%rax), %edx
	vdivsd	%xmm0, %xmm1, %xmm1
	vmovsd	%xmm1, (%r14,%rax,8)
	addq	$1, %rax
	cmpq	%rsi, %rax
	jne	.L32
	movl	%edx, %eax
	cmpq	%rsi, %r13
	je	.L15
.L31:
	leaq	-1(%r13), %rdx
	movq	%r13, %r11
	subq	%rsi, %r11
	subq	%rsi, %rdx
	leaq	-4(%r11), %rdi
	shrq	$2, %rdi
	addq	$1, %rdi
	leaq	0(,%rdi,4), %rbx
	cmpq	$2, %rdx
	jbe	.L34
	leaq	(%r14,%rsi,8), %r15
	xorl	%edx, %edx
	vmovddup	%xmm0, %xmm2
	vinsertf128	$1, %xmm2, %ymm2, %ymm2
.L23:
	movq	%rdx, %rsi
	addq	$1, %rdx
	salq	$5, %rsi
	vmovapd	(%r15,%rsi), %ymm1
	vdivpd	%ymm2, %ymm1, %ymm1
	vmovapd	%ymm1, (%r15,%rsi)
	cmpq	%rdi, %rdx
	jb	.L23
	addl	%ebx, %eax
	cmpq	%r11, %rbx
	je	.L53
	vzeroupper
.L34:
	cltq
.L25:
	vmovsd	(%r14,%rax,8), %xmm1
	vdivsd	%xmm0, %xmm1, %xmm1
	vmovsd	%xmm1, (%r14,%rax,8)
	addq	$1, %rax
	cmpq	%rax, %r13
	jg	.L25
.L15:
	movq	-136(%rbp), %rbx
	movq	%r13, %rdx
	movq	%r14, %rsi
	movq	%r10, -144(%rbp)
	movq	%rbx, %rdi
	call	sf_writef_double
	movq	%rbx, %rdi
	call	sf_write_sync
	movq	%rbx, %rdi
	call	sf_close
	movq	-128(%rbp), %rdi
	call	sf_close
	movq	-120(%rbp), %rdi
	call	free
	movq	%r12, %rdi
	call	free
	movq	-144(%rbp), %r10
	movq	%r10, %rdi
	call	free
	movq	%r14, %rdi
	call	free
	xorl	%eax, %eax
	jmp	.L54
.L38:
	xorl	%eax, %eax
	jmp	.L31
.L36:
	xorl	%eax, %eax
	jmp	.L5
.L62:
	vzeroupper
	jmp	.L9
.L53:
	vzeroupper
	jmp	.L15
.L37:
	vxorpd	%xmm3, %xmm3, %xmm3
	vmovapd	%xmm3, %xmm2
	vmovapd	%xmm3, %xmm1
	jmp	.L11
.L3:
	testq	%r13, %r13
	jg	.L28
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sd	-104(%rbp), %xmm0, %xmm0
	vmovsd	.LC2(%rip), %xmm1
	movq	%r10, -144(%rbp)
	vdivsd	%xmm0, %xmm1, %xmm1
	vmovsd	.LC3(%rip), %xmm0
	call	pow
	movq	-144(%rbp), %r10
	jmp	.L10
.L4:
	vxorpd	%xmm0, %xmm0, %xmm0
	vcvtsi2sd	-104(%rbp), %xmm0, %xmm0
	vmovsd	.LC2(%rip), %xmm1
	movl	%r11d, -152(%rbp)
	movq	%r10, -144(%rbp)
	vdivsd	%xmm0, %xmm1, %xmm1
	vmovsd	.LC3(%rip), %xmm0
	call	pow
	movq	-144(%rbp), %r10
	movl	-152(%rbp), %r11d
	jmp	.L27
	.cfi_endproc
.LFE36:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE5:
	.section	.text.startup
.LHOTE5:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1074790400
	.align 8
.LC2:
	.long	0
	.long	1072693248
	.align 8
.LC3:
	.long	0
	.long	1071644672
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC4:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.ident	"GCC: (Debian 4.9.1-14) 4.9.1"
	.section	.note.GNU-stack,"",@progbits
