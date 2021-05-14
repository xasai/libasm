section	.text

extern	list_init
;void	ft_list_push_front(struct s_list **head, void *data)
global	ft_list_push_front

ft_list_push_front:
				push	rbp;
				mov		rbp, rsp;
				sub		rsp, 0x10; alloc 16 byte on stack
				mov 	[rbp - 0x10], rdi;	mov head to stack varible
				mov		rdi, [rdi];			mov	first node address to rdi
				mov		[rbp - 0x8], rdi;	mov first node address to stack
				mov		rdi, rsi;		mov data to 1st argument
				call	list_init;		init list with data
				and		rax, rax;		check ret for NULL
				jz		.end;			if true, return
				cmp		qword [rbp - 0x8], 0; if list is empty
				je		.head_init;		skip next section 
.next_init:		mov		rdi, [rbp - 0x8]; mov first node addr to rdi
				mov		[rax + 0x8], rdi; mov first node addr to list->next
.head_init		mov		rdi, [rbp - 0x10]; mov head addres to rdi
				mov		[rdi], rax;			aassign *head=list
.end			leave
				ret

