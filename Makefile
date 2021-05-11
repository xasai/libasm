##########################################################################################
NAME =	$(shell basename $(CURDIR)).a

SRCPATH = src/
SRC = $(wildcard $(SRCPATH)*s)

VPATH = $(SRCPATH)

OBJPATH := obj/
OBJDIR = $(subst $(SRCPATH), $(OBJPATH), $(shell find $(SRCPATH)* -type d))
OBJ = $(subst $(SRCPATH), $(OBJPATH), $(SRC:.s=.o))

INC := -Iinclude/

############################################################################################
   #_____    _____    _____ 
  #/ ____|  / ____|  / ____|
 #| |  __  | |      | |     
 #| | |_ | | |      | |     
 #| |__| | | |____  | |____ 
  #\_____|  \_____|  \_____|

CC = gcc 
CFLAGS = -Wall -Wextra -Werror 

############################################################################################
 # _   _               _____   __  __ 
 #| \ | |     /\      / ____| |  \/  |
 #|  \| |    /  \    | (___   | \  / |
 #| . ` |   / /\ \    \___ \  | |\/| |
 #| |\  |  / ____ \   ____) | | |  | |
 #|_| \_| /_/    \_\ |_____/  |_|  |_|
  
AS = nasm
ASFLAGS = -f elf64
############################################################################################
TEST := test
TEST_SRC := main.c
TEST_OBJ := $(TEST_SRC:.c=.o)
TEST_LIB := $(NAME)
############################################################################################

all: $(NAME) 

$(TEST): $(NAME) $(TEST_SRC)
	$(CC) $(CFLAGS) $(TEST_SRC) $(TEST_LIB) $(INC) -o $(TEST)
	./$(TEST)

$(NAME): $(OBJPATH) $(OBJ)
	ar rc $(NAME) $(OBJ) 

$(OBJPATH)%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

$(OBJPATH):
	mkdir -p $(OBJPATH) $(OBJDIR)

clean:
	rm -rf $(OBJPATH)

fclean: clean
	rm -rf $(NAME) $(TEST) 

re: fclean all

.PHONY: test re fclean clean all
