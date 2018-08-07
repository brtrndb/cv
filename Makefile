# Makefile for ModernCV.
# Bertrand B.

# Variables.
CV_NAME	= BertrandBoyer
CV_SRC	= $(CV_NAME).tex
CV_PDF	= $(CV_SRC:.tex=.pdf)

DIR_SRC	= ./tex/
DIR_IMG	= ./img/
SUB_SRC	= $(wildcard $(DIR_SRC)/*.tex)
IMG	= $(wildcard $(DIR_IMG)/*.eps)

# Compile with lualatex.
all:	$(CV_PDF)

$(CV_PDF):	$(CV_SRC) $(SUB_SRC) $(IMG)
	@echo "Compiling $(CV_SRC) into $(CV_PDF).";
	@lualatex $(CV_SRC);

clean:
	@echo -n "Deleting temporary files.";
	@rm -rf $(CV_NAME).aux $(CV_NAME).log $(CV_NAME).out $(CV_NAME).bbl $(CV_NAME).blg $(CV_NAME).fls $(CV_NAME).fdb_latexmk $(CV_NAME).synctex.gz *~ $(DIR_IMG)/*-eps-converted-to.pdf;
	@echo " Done.";

fclean:	clean
	@echo -n "Deleting $(CV_PDF).";
	@rm -rf $(CV_PDF);
	@echo " Done.";

re:	fclean all

.PHONY:	all clean fclean re
