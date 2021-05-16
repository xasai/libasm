section .text

extern ft_list_size
extern free

global 	ft_list_remove_if

ft_list_remove_if:
				push	rbp;
				mov		rbp, rsp;
				sub		rsp, 0x18;
				mov 	[rbp - 0x18], rdx;	(*compare_data)()
				mov		[rbp - 0x10], rsi;	*data_ref
				mov		[rbp - 0x8], rcx;	(*erase_data)()	
				push	r14;
				mov		r14, rdi;			r14 = **list_head
				mov		rdi, [r14];			rdi = *list_head
				call	ft_list_size;
				mov		rcx, rax;			rcx = list_size
.rm_head		test	rcx, rcx;			if rcx == 0
				jz		.end;					goto end;
				mov		rdi, [r14];			rdi = *list_head
				mov		rdi, [rdi];			rdi = list_head->data
				mov		rsi, [rbp - 0x10];	rsi = *data_ref 
				call	[rbp - 0x18];		call (*compare_data)(list_head->data, data_ref);
				mov		rdi, [r14];			rdi = *list_head
				test	rax, rax;			if (*data_ref != list_head->data)	
				jnz		.loop;					goto loop
				mov		rsi, [rdi + 0x8];	rsi = list_head->next
				push 	rsi;				save rsi;
				mov		rdi, [rdi];			rdi = list_head->data
				call	[rbp - 0x8];		call (*erase_data)(list_head->data)
				mov		rdi, [r14];			rdi = *list_head
				call	free wrt ..plt;		free(list_head)
				pop		rsi;				get rsi
				mov		[r14],	rsi;		*list_head = next_node
				dec		rcx;				rcx--
				jmp		.rm_head;			 goto remove_head

;;.loop			test	rcx, rcx;			if rcx == 0;	
;;				jz		.end;					goto end;
;;				dec		rcx;				rcx--;
.loop			mov		r14, rdi;			r14 = *prev_node
				mov		rdi, [rdi + 8];		rdi = *curr_node	
				test	rdi, rdi;			if (curr == NULL)
				jz		.end;					goto end
				mov		rdi, [rdi];			rdi = curr_node->data
				mov		rsi, [rbp - 0x10];	rsi = *data_ref
				call	[rbp - 0x18];		(*compare_data)(curr_node->data, data_ref)
				mov		rdi, [r14 + 8];		rdi = *curr_node
				test	rax, rax;			if (*data_ref != curr_node->data)
				jnz		.loop;					goto loop
				mov		rdi, [rdi];			rdi = curr_node->data
				call	[rbp - 0x8];		erase curr_node->data	
				mov		rdi, [r14 + 8];		rdi = curr_node
				mov		rsi, [rdi + 8];		rsi = curr_node->next
				push	rsi;
				call	free wrt ..plt;		free(curr_node)
				pop		rsi;
				mov		[r14 + 8], rsi;		prev->next = curr_node->next
				mov		rdi, rsi;			curr_node = curr_node->next
				jmp		.loop
.end			
				pop		r14;
				leave	
				ret
