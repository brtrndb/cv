# Makefile for ModernCV.
# Bertrand B.

# Variables.
CV_NAME	= BertrandBoyer
CV_SRC	= $(CV_NAME).tex
CV_PDF	= $(CV_SRC:.tex=.pdf)

DIR_SRC	= ./tex/
SUB_SRC	= $(DIR_SRC)/Personal.tex \
	  $(DIR_SRC)/Education.tex \
	  $(DIR_SRC)/Experiences.tex \
	  $(DIR_SRC)/Hobbies.tex \
	  $(DIR_SRC)/Languages.tex \
	  $(DIR_SRC)/Projects.tex \
	  $(DIR_SRC)/Skills.tex

DIR_IMG	= ./img/
IMG	= $(DIR_IMG)/novacom.eps \
	  $(DIR_IMG)/thales.eps \
	  $(DIR_IMG)/sii.eps \
	  $(DIR_IMG)/visian.eps \
	  $(DIR_IMG)/epitech.eps \
	  $(DIR_IMG)/griffith.eps \
	  $(DIR_IMG)/eisti.eps

# Compile with lualatex.
all:	cv

cv:	$(CV_PDF)

$(CV_PDF):	$(CV_SRC) $(SUB_SRC) $(IMG)
	@echo "Compilation $(CV_SRC) into $(CV_PDF).";
	@lualatex $(CV_SRC);

clean:
	@echo -n "Deleting temporary files.";
	@rm -rf $(CV_NAME).aux $(CV_NAME).log $(CV_NAME).out *~;
	@rm -rf $(DIR_IMG)/*-eps-converted-to.pdf;
	@echo " Done.";

fclean:	clean
	@echo -n "Deleting $(CV_PDF).";
	@rm -rf $(CV_PDF);
	@echo " Done.";

re:	fclean all
