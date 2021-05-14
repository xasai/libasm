;char *ft_strdup(const char *string)
;       The  strdup() function returns a pointer to a new string which is a du‐
;       plicate of the string s.  Memory for the new string  is  obtained  with
;       malloc(3), and can be freed with free(3).
;		RETURN VALUE: address of duplicated string or NULL if insufficient 
;		memory was available

section .text
global ft_strdup

extern ft_strlen
extern ft_strcpy
extern malloc

ft_strdup:		
			push	rsi;				save rsi on stack
			call	ft_strlen;			get len of string 	
			push	rdi;				mov string address to stack
			mov		rdi, rax;			mov len to first argument of malloc
			inc		rdi;				len++ for '\0'
			call	malloc wrt ..plt;	call malloc(len)
			test	rax, rax; 			if return == NULL
			jz		.end; 				skip the copy the string
			pop		rdi;				get string from stack
			mov		rsi, rdi;			place it in arg src	
			mov		rdi, rax;			place malloc return to dst
			call	ft_strcpy;			call ft_strcpy(rsi, rdi);
.end		pop		rsi;				get rsi back	
			ret;
