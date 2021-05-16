##########################################################################################
NAME :=	$(shell basename $(CURDIR)).a

SRCPATH := src/
SRC := ft_read.s ft_write.s ft_strcmp.s ft_strcpy.s ft_strdup.s ft_strlen.s
SRC := $(addprefix $(SRCPATH), $(SRC))

VPATH := $(SRCPATH)

OBJPATH := obj/
OBJDIR := $(subst $(SRCPATH), $(OBJPATH), $(shell find $(SRCPATH)* -type d))
OBJ := $(subst $(SRCPATH), $(OBJPATH), $(SRC:.s=.o))


BONUSRC := ft_list_push_front_bonus.s  ft_list_remove_if_bonus.s\
			ft_list_remove_if_bonus.s  ft_list_size_bonus.s\
			ft_list_sort_bonus.s  list_init_bonus.s

BONUSRC := $(addprefix $(SRCPATH), $(BONUSRC))
BONUSOBJ := $(subst $(SRCPATH), $(OBJPATH), $(BONUSRC:.s=.o))
BONUS := bonusrule
############################################################################################
CC := gcc  												  #_____    _____    _____ 
CFLAGS := -Wall -Wextra -Werror  						#/ ____|  / ____|  / ____|
INC := -Iinclude/ -Imy_libc/include						#| |  __  | |      | |     
														#| | |_ | | |      | |     
														#| |__| | | |____  | |____ 
														 #\_____|  \____|  \_____|
############################################################################################
AS := nasm#	 											 #| \ | |     /\      / ____| |  \/  |
ASFLAGS := -felf64 # -gdwarf #debugging ELF64			 #|  \| |    /  \    | (___   | \  / |
														 #| . ` |   / /\ \    \___ \  | |\/| |
														 #| |\  |  / ____ \   ____) | | |  | |
														 #|_| \_| /_/    \_\ |_____/  |_|  |_|
############################################################################################
TEST := test
TEST_SRC := main.c
TEST_OBJ := $(TEST_SRC:.c=.o)
TEST_LIB := -L. -lasm 
############################################################################################

all: $(NAME) 
bonus: $(BONUS) 

############################################################################################
$(TEST): $(BONUS) 
	$(CC) $(CFLAGS) $(TEST_SRC) $(TEST_LIB) $(INC) -o $(TEST)
	./test | less -r 

val: $(BONUS)
	$(CC) $(CFLAGS) $(TEST_SRC) $(TEST_LIB) $(INC) -o $(TEST)
	valgrind --leak-check=full ./$(TEST)

debug: $(BONUS) 
	$(CC) $(CFLAGS) $(TEST_SRC) $(TEST_LIB) $(INC) -o $(TEST)
	gdb	./$(TEST)
############################################################################################

$(NAME): $(OBJPATH) $(OBJ)
	ar rc $(NAME) $(OBJ) 

$(BONUS): $(NAME) $(BONUSOBJ)
	ar rc $(NAME) $(BONUSOBJ)

$(OBJPATH)%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

$(OBJPATH)%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

$(OBJPATH):
	mkdir -p $(OBJPATH) $(OBJDIR)

clean:
	rm -rf $(OBJPATH)

fclean: clean
	rm -rf $(NAME) $(TEST) 

re: fclean all

.PHONY: test re fclean clean all
