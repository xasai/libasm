extern __errno_location

section .text
global ft_read

ft_read:
			mov 		rax, 0;	sys_read NR on gnu-linux-x86_64	
			syscall;
			cmp			eax, 0;	if (ret < 0)
			jl			.err;	on LINUX syscall return from -1 to -4096 if fail
			ret;				return rax if succeed
.err:		push 		rbx;	save rbx
			mov			ebx, eax; mov return of sys_read to ebx
			neg			ebx;	get positive num from syscall return
			call		__errno_location wrt ..plt; get errno address on LINUX
			mov			[rax], ebx;	move errnum to errno
			mov			rax, -1; return -1
			pop			rbx; get rbx back
			ret;
