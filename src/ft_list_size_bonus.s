section .text

global ft_list_size

ft_list_size:
				mov		rax, -1;	rax = -1
.loop			inc		rax;		rax++;	
				test	rdi, rdi;	if (current_node == NULL)	
				jz		.end;		return;
				mov		rdi, [rdi + 0x8];current_node = next_node
				jmp		.loop;	
.end			ret;
