	.file	"euclid.s"
	.text
	.global	euclid
	.type	euclid, @function
# uint64_t euclid (
#	uint64_t a,
#	uint64_t b
# ) {
euclid:
.LFB0:
	pushq	%rbp
	movq	%rsp,	%rbp

	subq	$24,	%rsp
	movq	%rdx,	-8(%rbp)
	movq	%rcx,	-16(%rbp)
	movq	%rbx,	-24(%rbp)

	# if (0 == a) {
	cmpq	$0,	%rdi
	jne	.LC0
	#	return b;
	movq	%rsi,	%rax
	jmp	.LC10
.LC0:	# }

	# if (0 == b) {
	cmpq	$0,	%rsi
	jne	.LC1
	#	return a;
	movq	%rdi,	%rax
	jmp	.LC10
.LC1:	# }

	# uint64_t u = a;
	movq	%rdi,	%rax
	# uint64_t v = b;
	movq	%rsi,	%rcx
	# uint64_t i = 0;
	movq	$0,	%rdx

	jmp	.LC3
.LC2:	# {
	#	u >>= 1;
	shrq	$1,	%rax
	#	v >>= 1;
	shrq	$1,	%rcx
	incq	%rdx
.LC3:	# } until (0 == (1 & (u | v)));
	movq	%rax,	%rbx
	orq	%rcx,	%rbx
	andq	$1,	%rbx
	cmpq	$0,	%rbx
	je	.LC2

	jmp	.LC5
.LC4:	# {
	#	u >>= 1;
	shrq	$1,	%rax
.LC5:	# } until (0 == (1 & u));
	movq	%rax,	%rbx
	andq	$1,	%rbx
	cmpq	$0,	%rbx
	je	.LC4

.LC6:	# do { 
	jmp	.LC8
.LC7:	# {
	# v >>= 1;
	shrq	$1,	%rcx
.LC8:	# } until (0 == (v & 1));
	movq	%rcx,	%rbx
	andq	$1,	%rbx
	cmpq	$0,	%rbx
	je	.LC7

	# if (u > v)
	cmpq	%rax,	%rcx
	jge	.LC9
	# {
	# t = u;
	movq	%rax,	%rbx
	# u = v;
	movq	%rcx,	%rax
	# v = t;
	movq	%rbx,	%rcx
.LC9:	# }

	# v = v - u;
	subq	%rax,	%rcx

	# } until (0 != v);
	cmpq	$0,	%rcx
	jne	.LC6

	# __ret__ = u << i;
	movb	%dl,	%cl
	salq	%cl,	%rax

.LC10:  # done
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	-24(%rbp), %rbx
	addq	$24,	%rsp

	popq	%rbp
	ret
.LFE0:
# }
	.size	euclid,		.-euclid

# vim: set ts=8 sw=8 noet syn=asm:
