	.file	"divrem.s"
	.text
	.global	divrem
	.type	divrem, @function
divrem:
# void divrem (
# 	int *q_p: %rdi,
#	int *r_p: %rsi,
# 	const int dividend: %edx,
# 	const int divisor: %ecx
# ) {
.LFB0:
	# Update stack frame
	pushq	%rbp				# Save caller %rbp on the stack
	movq	%rsp,		%rbp		# Update our %rbp to caller %rsp

	# Save registers
	subq	$8,		%rsp		# Alloc on stack for caller %rdx (alloc old_rdx)
	movq	%rdx,		-8(%rbp)	# Save caller %rdx (assign old_rdx)

	# Do work

	movl	%edx,		%eax		# dividend -> tmp0
	movl	$0,		%edx		# 0 -> tmp1

	# Dividend in %eax
	# Divisor arg for inst div
	# After inst div, quotient in %eax, remainder in %edx

	idivl	%ecx				# divide %eax by %ecx -> q: %eax, r: %edx
	
	movl	%edx,		(%rsi)		# tmp1 -> *q_p
	movl	%eax,		(%rdi)		# tmp0 -> *r_p
	
	movq	-8(%rbp),	%rdx		# Resotre caller %rdx (from old_rdx)
	addq	$8,		%rsp		# Resotre %rsp (free old_rdx)

	movq	$0,		%rax		# ret = (void) 0

	popq	%rbp				# Restore caller %rbx
	ret					# Return
.LFE0:
# }
	.size 	divrem,		.-divrem

# vim: set ts=8 sw=8 noet syn=asm:
