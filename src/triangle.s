	.file	"triangle.s"
	.text

	.globl	tri_num
	.type	tri_num, @function
tri_num:
.LFB0:
	pushq	%rbp
	movq	%rsp,	%rbp

	# ret = (n * (n + 1)) >> 1;
	movq	%rdi,	%rax
	addq	$1,	%rax
	imulq	%rdi,	%rax
	shrq	%rax

	popq	%rbp
	ret
.LFE0:
	.size	tri_num, .-tri_num

	.globl	pyra_num
	.type	pyra_num, @function
pyra_num:
.LFB1:
	pushq	%rbp
	movq	%rsp,	%rbp

	# save b;
	subq	$16,	%rsp
	movq	%rbx,	-8(%rbp)
	movq	%rdx,	-16(%rbp)

	# a = n;
	# a *= n + 1;
	# a *= (n << 2) + 1;
	movq	%rdi,	%rax
	movq	%rax,	%rbx
	incq	%rax
	imulq	%rbx,	%rax
	shlq	%rbx
	incq	%rbx
	imulq	%rbx,	%rax

	# a >>= 1;
	# a /= 3;
	shrq	%rax
	movq	$3,	%rbx
	movq	$0,	%rdx
	idivq	%rbx

	# restore b;
	movq	-8(%rbp), %rbx
	movq	-16(%rbp), %rdx
	addq	$16,	%rsp

	# return;
	popq	%rbp
	ret
.LFE1:
	.size	pyra_num, .-pyra_num

// vim: set ts=8 sw=8 noet syn=asm:
