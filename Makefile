# Makefile for ModernCV.
# Bertrand B.

CVNAME	= BBoyerCV
CVSRC	= $(CVNAME).tex
SRC	= CV-Education.tex CV-Experiences.tex CV-Hobbies.tex CV-Languages.tex CV-Projects.tex CV-Skills.tex
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
