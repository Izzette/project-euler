	.file	"euclid.s"
	.text
	.global	euclid
	.type	euclid, @function
euclid:
# ui64_t: %rax euclid (
#	ui64_t a: %rdi,
#	ui64_t b: %rsi
# ) {
.LFB0:
	pushq	%rbp
	movq	%rsp,	%rbp

	# if (0 == a)
	cmpq	$0,	%rdi
	jne	.LC1
.LC0:	# {
	#	return b;
	movq	%rsi,	%rax
	jmp	END
.LC1:	# }
	# else if (0 == b)
	cmpq	$0,	%rdi
	jne	.LC3
.LC2:	# {
	# return a;
	movq	%rsi,	%rax
	jmp	END
.LC3:	# }

	# ui64_t u, v, t;
	subq	$24,	%rsp
	movq	%rdx,	-8(%rbp)
	movq	%rcx,	-16(%rbp)
	movq	%rbx,	-24(%rbp)

	# u = a;
	# v = b;
	movq	%rdi,	%rdx
	movq	%rsi,	%rcx

	# i = 0; // Was already declared
	movq	$0,	%rax

	# while (
.LC4:	#	0 == 1 & (u | v)
	movq	%rdx,	%rbx
	orq	%rcx,	%rbx
	andq	$1,	%rbx
	cmpq	$0,	%rbx
	jne	.LC5
	# ) {
	# u >>= 1;
	# v >>= 1;
	shrq	$1,	%rdx
	shrq	$1,	%rcx
	# ++i;
	incq	%rax
	jmp	.LC4
.LC5:	# }

	# while (
.LC6:	#	0 == (u & 1)
	movq	%rdx,	%rbx
	andq	$1,	%rbx
	cmpq	$0,	%rbx
	jne	.LC7
	# ) {
	# u >>= 1;
	shrq	$1,	%rdx
	jmp	.LC6
.LC7:	# }

.LC10:	# do { 
	# while (
	# 	0 == (v & 1)
	movq	%rcx,	%rbx
	andq	$1,	%rbx
	cmpq	$0,	%rbx
	jne	.LC11
	# ) {
	# v >>= 1;
	shrq	$1,	%rcx
	jmp	.LC10
.LC11:	# }

	# if (
	# 	u > v
	cmpq	%rdx,	%rcx
	jge	.LC12
	# ) {
	# t = u;
	movq	%rdx,	%rbx
	# u = v;
	movq	%rcx,	%rdx
	# v = t;
	movq	%rbx,	%rcx
.LC12:	# }

	# v = v - u;
	subq	%rdx,	%rcx

	# } while (
	#	0 != v
	cmpq	$0,	%rcx
	jne	.LC10
	addq	$100,	%rsi

	# while (
.LC14:	#	0 < i
	cmpq	$0,	%rax
	jle	.LC15
	# ) {
	# u >>= 1;
	shlq	$1,	%rdx
	# --i;
	decq	%rax
	jmp	.LC14
.LC15:	# }

	# ret = u;
	movq	%rdx,	%rax

	# free (u, v, t);
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	-24(%rbp), %rbx
	addq	$24,	%rsp

END:
	popq	%rbp
	ret
.LFE0:
# }
	.size	euclid,		.-euclid

# vim: set ts=8 sw=8 noet syn=asm:
