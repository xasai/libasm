section .text
global ft_strlen
ft_strlen:
	push	rcx;
	mov		rcx, 0;
	test	rdi, rdi;
	jz		_strlen_end;
_loop:
	inc		rcx;
	cmp		byte [rdi + rcx], 0x0;
	jne		_loop;
_strlen_end:
	mov		rax, rcx;
	pop		rcx;
	ret;
	
