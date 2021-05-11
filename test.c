#include <stdio.h>
#include <string.h>
#include "libasm.h"

void	strlen_test()
{
	char *str = "four";
	char *one = "1";
	char *two = "2 ";
	char *three = "3  ";
	char *xz = "asdfkljasjdkfljaskfjklasdjfkljasdkfjkasjfdlkasjdkfjaskjfdlk;asjl;kfjasd;kldfjsa;kfjl;kasjflk;jasd;kfjl;kdasjf;kdjas;kfjas;kdjfl;kasdjkfjasdk;fjl;kasdjdfjaldksjfl;kasdj;kjasdk;fjasdkjflkasj;klfjdas;jfl;kdasjflkajskflj";
	printf("%lu == %lu\n",strlen(one), ft_strlen(one));
	printf("%lu == %lu\n",strlen(two), ft_strlen(two));
	printf("%lu == %lu\n",strlen(three),  ft_strlen(three));
	printf("%lu == %lu\n",strlen(str),  ft_strlen(str));
	printf("%lu == %lu\n",strlen(xz), ft_strlen(xz));
	printf("%lu", ft_strlen(NULL));
}

int		main()
{
	strlen_test();
}
