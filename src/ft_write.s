extern __errno_location

section .text
global ft_write


ft_write: 
			mov		rax, 1; 	sys_write NR on gnu-linux-x86-64
			syscall;			sys_write
			cmp		eax, 0;		if (ret < 0)
			jl		.err;		on LINUX syscall return -1 to -4096 if fail	
			ret;				return rax if all good	
.err		push	rbx;		save rbx;
			mov		ebx, eax;	mov return of sys_write to ebx
			neg		ebx;		we need positive num to store in errno
			call 	__errno_location wrt ..plt; get errno address on LINUX
			mov 	[rax], ebx;	mov return of sys_write to errno
			mov 	rax, -1; 	
			pop		rbx;
			ret;
