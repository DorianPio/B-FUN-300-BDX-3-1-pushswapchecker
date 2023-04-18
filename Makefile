##
## EPITECH PROJECT, 2021
## makefile
## File description:
## Makefile
##

SRC		=	pushswapchecker.hs

NAME	=	pushswap_checker
RM_F	=	rm -f

all:		$(NAME)

$(NAME):
			ghc -c -O $(SRC)
			ghc -o $(NAME) *.o

clean:
			$(RM_F) *.o
			$(RM_F) *.hi

fclean:        clean
			$(RM_F) $(NAME)

re:			fclean all

.PHONY:		all $(NAME) clean fclean re