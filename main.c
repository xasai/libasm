#include <stdio.h>
#include <string.h>
#include "libasm.h"

#define OK "[\e[0;32mOK\e[0m]\n"
#define KO "[\e[0;31mKO\e[0m]\n"
#define CHECK(x) (x ? OK : KO) 

void	strlen_t()
{
	printf("===================\e[0;35m[STRLEN]\e[0m==========================\n");

	char *strs[] = {"str1", "str2i ", "str33333333333", "str44444444444", "a",
	"", "asdfasdfasdfadsfa"
		, "veeeeiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiing", 0};

	for (size_t i = 0; strs[i]; i++)
	{
		char *s = strs[i];
		size_t std = strlen(s);
		size_t ft = ft_strlen(s);
		printf("\tstr[%ld]=\"%20s\"%20s\tstd %ld, %ld yours\n\n",
					   i , 	  s,CHECK(std == ft), std, ft);
	}
}

void	strcpy_t()
{
	printf("===================\e[0;35m[STRCPY]\e[0m==========================\n");

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
	printf("===================\e[0;35m[STRCMP]\e[0m==========================\n");

	char *strs[] = {"str1", "str2i ", "str33333333333", "str44444444444", "a",
	"", "asdfasdfasdfadsfa"
		, "veeeeiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiing", 0};

	for	(size_t i = 0; strs[i]; i++)
	{
		for(size_t j = i+1;strs[j]; j++)
		{
			char	*s1 = strs[i];
			char	*s2 = strs[j];

			int		std = strcmp(s1, s2);
			int		ft = ft_strcmp(s1, s2);

			printf("\ts1=\"%20.20s\" s2=\"%20.20s\" %s\tstd %i, %i yours\n\n",
					   	s1,	  s2,CHECK(std==ft), std, ft);
		}
	}
}

int		main()
{
	//strlen_t();
	strcpy_t();
	//strcmp_t();
}
