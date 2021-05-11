section .text
global	ft_strcmp
ft_strcmp:
			test	rdi, rdi;
			jz		.end;
			test	rsi, rsi;
			jz		.end;
.loop:		
			cmp 	byte [rsi], 0x00;
			je		.end;
			cmpsb;
			jne		.end;
			jmp		.loop;
.end:
			mov   	rax, [rsi];
			sub		rax, [rdi];	
			ret;
