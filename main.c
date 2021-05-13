#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include "libasm.h"

#define OK "[\e[0;32mOK\e[0m]\n"
#define KO "[\e[0;31mKO\e[0m]\n"
#define CHECK(x) (x ? OK : KO) 

void	print_errno()
{
	char *str = strerror(errno);
	write(1, str, strlen(str));
	write(1, "\n", 1);
}

void	strlen_t()
{
	printf("\t===================\e[0;35m[STRLEN]\e[0m==========================\n");

	char *strs[] = {"str1", "str2i ", "str33333333333", "str44444444444", "a",
	"", "asdfasdfasdfadsfa"
		, "veeeeiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiing", 0};

	for (size_t i = 0; strs[i]; i++)
	{
		char *s = strs[i];
		size_t std = strlen(s);
		size_t ft = ft_strlen(s);
		printf("\tstr[%ld]=\"%20.20s\"%20.20s\tstd %ld, %ld yours\n\n",
					   i , 	  s,CHECK(std == ft), std, ft);
	}
}

void	strcpy_t()
{
	printf("\t===================\e[0;35m[STRCPY]\e[0m==========================\n");

	char *strs[] = {"str1", "str2i ", "str33333333333", "str44444444444", "a",
	"", "asdfasdfasdfadsfa"
		, "veeeeiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiing", 0};
	
	char buf1[200];
	char buf2[200];

	for	(size_t i = 0; strs[i]; i++)
	{
		char *s = strs[i];
		char *std = strcpy(buf1, s);
		char *ft = ft_strcpy(buf2, s);
		int	cmp = strcmp(std, ft);	
		printf("\tstr[%ld]=\"%20.20s\"%20s\tstd \"%.20s\", \"%.20s\" yours\n\n",
					   i , 	  s,CHECK(cmp == 0), std, ft);
	}
}

void	strcmp_t()
{
	printf("\t===================\e[0;35m[STRCMP]\e[0m==========================\n");

	char *strs[] = {"str1", "str2i ", "str33333333333", "str44444444444", "a",
	"", "asdfasdfasdfadsfa"
		, "veeeeiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiing", 0};

	for	(size_t i = 0; strs[i]; i++)
	{
		for(size_t j = i;strs[j]; j++)
		{
			char	*s1 = strs[i];
			char	*s2 = strs[j];

			int		std = strcmp(s1, s2);
			std = std == 0 ? 0 : (std > 0 ? 1 : -1);
			int		ft = ft_strcmp(s1, s2);
			ft = ft == 0 ? 0 : (ft > 0 ? 1 : -1);

			printf("\ts1=\"%20.20s\" s2=\"%20.20s\" %s\tstd %i, %i yours\n\n",
					   	s1,	  s2,CHECK(std==ft), std, ft);
		}
	}
}

void	write_t()
{
	char str[] = "\n\t===================\e[0;35m[WRITE]\e[0m==========================\n";
	char *strs[] = {"str1", "str2i ", "str33333333333", "str44444444444", "a",
	"", "asdfasdfasdfadsfa"
		, "veeeeiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiing", 0};
	size_t check_len = strlen(CHECK(0));
	int ft, std;

	write(1, str, strlen(str));

	for (int i = 0; strs[i]; i++)
	{
		char *s = strs[i];
		size_t len = strlen(s);	

		write(1, "std:\"", 5);
		std = write(1, s, len);
		write(1, "\" ", 2);

		write(1, "\nft :\"", 6);
		ft = ft_write(1, s, len);
		write(1, "\" ", 2);
		write(1, CHECK(ft==std), check_len);
	}

	/* Check errno on error cases */
	int fail_fd = 32;
	std =write(fail_fd, "", 1); print_errno(); errno = 0;
	ft = ft_write(fail_fd, "", 1); print_errno(); errno = 0;
	write(1, CHECK(std==ft), check_len);

	std = write(1, NULL, 1); print_errno(); errno = 0;
	ft = ft_write(1, NULL, 1); print_errno(); errno = 0;
	write(1, CHECK(std==ft), check_len);

	std = write(1, "", -1); print_errno(); errno = 0;
	ft = ft_write(1, "", -1); print_errno(); errno = 0;
	write(1, CHECK(std==ft), check_len);
}
void	read_t()
{

	char *buf = calloc(sizeof(*buf), 1000);
	int fd = open("test.txt", O_RDWR);
	int std;
	int ft;
	int check_len = strlen(CHECK(1));
	/* Check on real file */
	std = read(fd, buf, 1000);
	lseek(fd, 0, SEEK_SET);
	write(1, buf, std);
	write(1, "\n", 1);
	ft = ft_read(fd, buf, 1000);
	lseek(fd, 0, SEEK_SET);
	write(1, buf, ft);
	write(1, CHECK(ft==std), check_len);	
	
	/* Check errno on error cases */	
	int fail_fd = 123;
	std = read(fail_fd, buf, 123); print_errno(); errno = 0;
	lseek(fd, 0, SEEK_SET);
	ft = ft_read(fail_fd, buf, 123); print_errno(); errno = 0;
	lseek(fd, 0, SEEK_SET);
	
	char *fail_addr = NULL;
	std = read(fd, fail_addr, 123); print_errno(); errno = 0;
	lseek(fd, 0, SEEK_SET);
	ft = ft_read(fd, fail_addr, 123); print_errno(); errno = 0;
	lseek(fd, 0, SEEK_SET);

	int	neg_size = -1;
	std = read(fd, buf,	neg_size); print_errno(); errno = 0;
	lseek(fd, 0, SEEK_SET);
	ft = ft_read(fd, buf, neg_size); print_errno(); errno = 0;
	lseek(fd, 0, SEEK_SET);
	close(fd);
	
	/* Write only permission */
	fd = open("test.txt", O_WRONLY);
	std = read(fd, buf, 100); print_errno(); errno = 0;
	lseek(fd, 0, SEEK_SET);
	ft = ft_read(fd, buf, 100); print_errno(); errno = 0;
	lseek(fd, 0, SEEK_SET);
	close(fd);	
}

int		main()
{
	//write_t();
	read_t();
	//strlen_t();
	//strcpy_t();
	//strcmp_t();
}
