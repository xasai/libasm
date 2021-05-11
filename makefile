NAME = libasm.a 

SSRC = $(wildcard *s)

OBJDIR = obj/
OBJ = $(addprefix $(OBJDIR), $(SSRC:.s=.o))

INC = libasm.h

all: $(OBJDIR) $(OBJ) $(NAME) test.o
	gcc test.o $(OBJ) -o test
test.o:
	gcc -c test.c

$(NAME):
	ar rc $(NAME) $(OBJ) 

$(OBJDIR)%.o: %.s
	nasm -f elf64 $< -o $@

$(OBJDIR):
	mkdir -p $@

clean:
	rm -f $(OBJ) *.o

fclean: clean
	rm -rf $(NAME) $(OBJDIR) test

re: fclean all

.PHONY: test re fclean clean all
