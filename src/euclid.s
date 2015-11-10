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

	# if (0 == a) {
	cmpq	$0,	%rdi
	jne	.LC0
	#	return b;
	movq	%rsi,	%rax
	jmp	END
.LC0:	# }

	# if (0 == b) {
	cmpq	$0,	%rsi
	jne	.LC1
	#	return a;
	movq	%rdi,	%rax
	jmp	END
.LC1:	# }

	subq	$24,	%rsp
	movq	%rdx,	-8(%rbp)
	movq	%rcx,	-16(%rbp)
	movq	%rbx,	-24(%rbp)

	# uint64_t u = a;
	movq	%rdi,	%rdx
	# uint64_t v = b;
	movq	%rsi,	%rcx
	# uint64_t i = 0;
	movq	$0,	%rax

	jmp	.LC3
.LC2:	# {
	#	u >>= 1;
	shrq	$1,	%rdx
	#	v >>= 1;
	shrq	$1,	%rcx
	incq	%rax
.LC3:	# } while (0 == (1 & (u | v)));
	movq	%rdx,	%rbx
	orq	%rcx,	%rbx
	andq	$1,	%rbx
	cmpq	$0,	%rbx
	je	.LC2

	jmp	.LC5
.LC4:	# {
	#	u >>= 1;
	shrq	$1,	%rdx
.LC5:	# } while (0 == (1 & u));
	movq	%rdx,	%rbx
	andq	$1,	%rbx
	cmpq	$0,	%rbx
	je	.LC4

.LC6:	# do { 
	jmp	.LC8
.LC7:	# {
	# v >>= 1;
	shrq	$1,	%rcx
.LC8:	# } while (0 == (v & 1));
	movq	%rcx,	%rbx
	andq	$1,	%rbx
	cmpq	$0,	%rbx
	je	.LC7

	# if (u > v)
	cmpq	%rdx,	%rcx
	jge	.LC9
	# {
	# t = u;
	movq	%rdx,	%rbx
	# u = v;
	movq	%rcx,	%rdx
	# v = t;
	movq	%rbx,	%rcx
.LC9:	# }

	# v = v - u;
	subq	%rdx,	%rcx

	# } while (0 != v);
	cmpq	$0,	%rcx
	jne	.LC6

	jmp	.LC11
.LC10:	# {
	# u >>= 1;
	shlq	$1,	%rdx
	# --i;
	decq	%rax
.LC11:	# } while (0 < i);
	cmpq	$0,	%rax
	jg	.LC10

	# return u;
	movq	%rdx,	%rax

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
