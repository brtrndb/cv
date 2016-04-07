# Makefile for ModernCV.
# Bertrand B.

CVNAME	= BertrandBoyer
CVSRC	= $(CVNAME).tex
SRC	= Education.tex Experiences.tex Hobbies.tex Languages.tex Projects.tex Skills.tex
CVPDF	= $(CVSRC:.tex=.pdf)

# Compile with lualatex.
all:	cv

cv:	$(CVPDF)

$(CVPDF):	$(CVSRC) $(SRC)
	@echo "Compilation $(CVSRC) into $(CVPDF).";
	@lualatex $(CVSRC);

clean:
	@echo -n "Deleting temporary files.";
	@rm -rf $(CVNAME).aux $(CVNAME).log $(CVNAME).out *~;
	@echo " Done.";

fclean:	clean
	@echo -n "Deleting $(CVPDF).";
	@rm -rf $(CVPDF);
	@echo " Done.";

re:	fclean all
