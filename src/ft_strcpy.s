section .text

global ft_strcpy

ft_strcpy:
		push	rcx;				save rcx
		xor		rcx, rcx;			i = 0	
		dec		rcx;				i--
.loop	inc		rcx;				i++	
		mov		al, [rsi + rcx];	al = src[i]		
		cmp		al, 0;				if (al == 0)
		je		.end;					goto end
		mov		[rdi + rcx], al;	dst[i] = al
		jmp		.loop;				goto loop
.end	mov		byte [rdi + rcx], 0;dst[i] = '\0'
		mov		rax, rdi;			return dst
		pop		rcx;				get rcx back
		ret;
