#ifndef LIBASM_H
# define LIBASM_H
# include <sys/types.h>
# include <errno.h>
# include <unistd.h>
# include <fcntl.h>
# include <stdio.h>
# include <string.h>
# include <stdlib.h>


size_t		ft_strlen(char *str);
char		*ft_strcpy(char *dest, const char *src);
int			ft_strcmp(const char *s1, const char *s2);
ssize_t		ft_write(int fd, const void *buf, size_t count);
ssize_t		ft_read(int fd, void *buf, size_t count);
char		*ft_strdup(const char *s);

/* BONUS PART */

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

/*
** allocate t_list node on heap 
** assign data field = arg
** assign next field = NULL
** return = addres to created node 
*/
t_list		*list_init(void *data);

void		ft_list_push_front(t_list **head, void *data);
void		ft_list_sort(t_list **head, int (*cmp)());
void		ft_list_remove_if(t_list **head, void *data,
				int (*cmp)(), void (*data_erase)(void *));
int			ft_list_size(t_list *head);

#endif
