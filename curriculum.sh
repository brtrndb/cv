#!/bin/bash
# Generate different versions of moderncv CV.

# Files and folders options.
MODERNCV=BertrandBoyer
CVTEX=$MODERNCV.tex
CVPDF=$MODERNCV.pdf
CVFOLDER=./cv
NULL=/dev/null

# CV Options.
CV_LANGUAGE=cvLanguageVersion

IMG_EDUCATION=displayImagesEducation
IMG_EXPERIENCE=displayImagesExperiences

MISSION_VISIAN=displayMissionsVisian
MISSION_SII=displayMissionsSII
MISSION_THALES=displayMissionsThales
MISSION_NOVACOM=displayMissionsNovacom

SECTION_EDUCATION=displaySectionEducation
SECTION_EXPERIENCE=displaySectionExperiences
SECTION_SKILLS=displaySectionSkills
SECTION_PROJECT=displaySectionProjects
SECTION_HOBBIES=displaySectionHobbies

IMG_ALL="$IMG_EDUCATION $IMG_EDUCATION"
MISSION_ALL="$MISSION_VISIAN $MISSION_SII $MISSION_THALES $MISSION_NOVACOM"
SECTION_ALL="$SECTION_EDUCATION $SECTION_EXPERIENCE $SECTION_SKILLS $SECTION_PROJECT $SECTION_HOBBIES"
OPTIONS_ALL="$IMG_ALL $MISSION_ALL $SECTION_ALL"

# Functions.
set_attribute(){
    sed -i 's/'"$1"'}{\(yes\|no\)/'"$1"'}{'"$2"'/g' $CVTEX;
}

set_language(){
    set_attribute $CV_LANGUAGE $1;
}

set_pictures(){
    for img in $IMG_ALL;
    do
	set_attribute $img $1;
    done
}

set_missions(){
    for mission in $MISSION_ALL;
    do
	set_attribute $mission $1;
    done
}

reset_options(){
    set_language french;
    for opt in $OPTIONS_ALL;
    do
	set_attribute $opt "yes"
    done
}

cv_dir(){
    if [ ! -d "$CVFOLDER" ];
    then
	mkdir $CVFOLDER;
    fi
}

make_cv(){
    make > $NULL 2>&1;
    cv_dir;
    mv $CVPDF "$CVFOLDER/$1";
}

# CV generating functions.
cv_pictures(){
    echo -n " > Create moderncv with pictures.";
    set_pictures "yes";
    make_cv "$CVPDF-Pics.pdf";
    echo " Done.";
}

cv_no_picture(){
    echo -n " > Create moderncv without pictures.";
    set_pictures "no";
    make_cv "$CVPDF-NoPics.pdf";
    echo " Done.";
}

cv_full(){
    echo -n " > Create moderncv with full informations.";
    set_pictures "yes";
    set_missions "yes";
    make_cv "$CVPDF-Full.pdf";
    echo " Done.";
}

cv_reset(){
    echo -n " > Reset $CVTEX to default.";
    reset_options;
    echo " Done."
}

# Script.

echo "Starting script.";
set_language french;
cv_full;
cv_reset;
echo "Finished.";
