# Makefile for ModernCV.
# Bertrand B.

CVNAME	= BertrandBoyer
CVSRC	= $(CVNAME).tex
SRC_DIR	= ./tex/
SRC	= $(SRC_DIR)/Education.tex $(SRC_DIR)/Experiences.tex $(SRC_DIR)/Hobbies.tex $(SRC_DIR)/Languages.tex $(SRC_DIR)/Projects.tex $(SRC_DIR)/Skills.tex
IMG_DIR	= ./img/
IMG	= $(IMG_DIR)/novacom.eps $(IMG_DIR)/thales.eps $(IMG_DIR)/sii.eps $(IMG_DIR)/visian.eps $(IMG_DIR)/epitech.eps $(IMG_DIR)/griffith.eps $(IMG_DIR)/eisti.eps
CVPDF	= $(CVSRC:.tex=.pdf)

# Compile with lualatex.
all:	cv

cv:	$(CVPDF)

$(CVPDF):	$(CVSRC) $(SRC) $(IMG)
	@echo "Compilation $(CVSRC) into $(CVPDF).";
	@lualatex $(CVSRC);

clean:
	@echo -n "Deleting temporary files.";
	@rm -rf $(CVNAME).aux $(CVNAME).log $(CVNAME).out *~;
	@rm -rf $(IMG_DIR)/*-eps-converted-to.pdf;
	@echo " Done.";

fclean:	clean
	@echo -n "Deleting $(CVPDF).";
	@rm -rf $(CVPDF);
	@echo " Done.";

re:	fclean all
