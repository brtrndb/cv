# Makefile for ModernCV.
# Bertrand B.

# Variables.
NAME	= BertrandBoyer
TEX	= $(NAME).tex
TEX_SECTIONS	= $(wildcard ./tex/*.tex)
EPS	= $(wildcard ./img/*/*.eps)
EPS_CONVERTED	= $(EPS:.eps=-eps-converted-to.pdf)
PDF	= $(TEX:.tex=.pdf)

# Compile with lualatex.
all:	$(PDF)

$(PDF):	$(TEX) $(TEX_SECTIONS) $(EPS)
	@echo "Compiling $(TEX) into $(PDF).";
	@lualatex $(TEX);

clean:
	@echo -n "Deleting temporary files.";
	@rm -rf $(NAME).aux $(NAME).log $(NAME).out $(NAME).bbl $(NAME).blg $(NAME).fls $(NAME).fdb_latexmk $(NAME).upa $(NAME).upb $(NAME).synctex.gz $(EPS_CONVERTED) *~;
	@echo " Done.";

fclean:	clean
	@echo -n "Deleting $(PDF).";
	@rm -rf $(PDF);
	@echo " Done.";

re:	fclean all

.PHONY:	all clean fclean re
