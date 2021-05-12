section .text
global	ft_strcmp

ft_strcmp:
			push		rcx;				save rcx
			xor			rcx, rcx;			i = 0;
			dec			rcx;				i--;
.loop		inc			rcx;				i++;
			mov			al,	[rdi + rcx];	al = s1[i]
			mov			ah, [rsi + rcx];	ah = s2[i]
			cmp			al, ah;				if (ah != al)
			jne			.end;					goto .end
			cmp			al, 0;				if (al == 0)
			je			.end;					goto .end
			jmp			.loop;				else goto .loop
.end		xor			rcx, rcx;			rcx = 0
			mov			cl, ah;				cl = s2[i]
			and			rax, 0xff;			zero all beside s1[i]
			sub			rax, rcx;			return(s1[i] - s2[i])
			pop			rcx;				get rcx back;
			ret;							ret rax
