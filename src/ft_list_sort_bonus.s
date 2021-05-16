section .text

extern	ft_list_size

global	ft_list_sort

ft_list_sort: 
				push	rbp;
				mov		rbp, rsp;
				sub		rsp, 0x1c;			28 byte on stack
				mov		[rbp - 0x10], rsi;	move cmp_function_addr to rbp - 0x10
				mov		rdi, [rdi];			mov *list_head
				mov		[rbp - 0x8], rdi;	move *list_head to rbp - 0x8 
				call	ft_list_size;		get list_size for bubble sort
				mov		[rbp - 0x1c], eax;	mov	list_size to rbp - 0x1c

.loop			dec		dword [rbp - 0x1c];		  i--;
				cmp		dword [rbp - 0x1c],0; if i < 0 
				jl		.end;
				mov		rdi, [rbp - 0x8];	mov *list_head to rdi

.bubl			mov		rsi, [rdi + 8];		next = cur->next
				test	rsi, rsi;			if (next->data == NULL)
				jz		.loop;				go to root buble loop
				push	rsi;				save next address
				mov		rsi, [rsi];			mov next->data to rsi
				push	rdi;				save cur address
				mov 	rdi, [rdi];			mov cur->data to rdi
				call	[rbp - 0x10];		call compare function
				pop		rdi;				get back cur address
				pop		rsi;				get back next address
				and		eax, 0x70000000;	if (cmp > 0)	
				jz		.swap;					swap 
.next			mov		rdi, [rdi + 8];			cur = next;	
				jmp		.bubl

.end			leave
				ret

.swap			push	rsi;				save rsi(next);
				mov		rsi, [rsi];			get next->data
				mov		[rbp - 0x18], rsi;	save next->data on stack		
				pop		rsi;				get back rsi	
				mov		rax, [rdi];			mov cur->data to rax	
				mov		[rsi], rax;			mov cur->data to next node	
				mov		rax, [rbp - 0x18];	get next->data from stack	
				mov		[rdi], rax;			mov next->data to cur node 
				jmp		.next
