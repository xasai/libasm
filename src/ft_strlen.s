section .text

global ft_strlen

ft_strlen:
		push 	rcx;						save rcx
		xor		rcx, rcx;					i = 0
		dec		rcx;						i = -1
.loop	inc		rcx;						i++
		cmp		byte [rdi + rcx], 0x0;		if str[i] == '\0'
		jne		.loop;

.end:	
		mov		rax, rcx;					return i;
		pop		rcx;						get rcx back	
		ret;
	
