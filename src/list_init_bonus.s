section .text

extern	malloc

;t_list *
;list_init(void *data);

global list_init

list_init:
			;rdi data
			push	rdi; 				save data argument
			mov		rdi, 0x10; 			alloc 16 bytes
			call	malloc wrt ..plt; 
			pop		rdi; 				get data back
			test	rax, rax; 			if malloc ret NULL
			jz		.end;				ret NULL	
			and	qword [rax + 0x08], 0x0;	assign next field to NULL
			mov		[rax], rdi;			move data to field data	
.end		ret	
