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

IMG_ALL="$IMG_EDUCATION $IMG_EXPERIENCE"
MISSION_ALL="$MISSION_VISIAN $MISSION_SII $MISSION_THALES $MISSION_NOVACOM"
SECTION_ALL="$SECTION_EDUCATION $SECTION_EXPERIENCE $SECTION_SKILLS $SECTION_PROJECT $SECTION_HOBBIES"
OPTIONS_ALL="$IMG_ALL $MISSION_ALL $SECTION_ALL"

# Script command line options.
CMD_LANGUAGE=french
CMD_IMAGES=no
CMD_MISSIONS=no
CMD_NAME="$CVPDF"
CMD_FULL=no
CMD_RESET=no

# Functions.

# CV configuration functions.
set_attribute(){
    sed -i 's/'"$1"'}{\(yes\|no\)/'"$1"'}{'"$2"'/g' $CVTEX;
}

set_language(){
    sed -i 's/'"$CV_LANGUAGE"'}{\(french\|english\)/'"$CV_LANGUAGE"'}{'"$1"'/g' $CVTEX;
}

set_images(){
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
    set_language "french";
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
    set_images "yes";
    make_cv "$CVPDF-Pics.pdf";
    echo " Done.";
}

cv_no_picture(){
    echo -n " > Create moderncv without pictures.";
    set_images "no";
    make_cv "$CVPDF-NoPics.pdf";
    echo " Done.";
}

cv_full(){
    echo -n " > Create moderncv with full informations.";
    set_images "yes";
    set_missions "yes";
    make_cv "$CVPDF-Full.pdf";
    echo " Done.";
}

# Script.
echo "Starting script.";

while [ "$#" -gt "0" ];
do
    case "$1" in
	-n | --name)
	    CMD_NAME="$2";
	    shift 2;
	    ;;
	-l | --language)
	    CMD_LANGUAGE="$2";
	    shift 2;
	    ;;
	-i | --images)
	    CMD_IMAGES=yes;
	    shift 1;
	    ;;
	-m | --missions)
	    CMD_MISSIONS=yes;
	    shift 1;
	    ;;
	-f | --full)
	    CMD_FULL=yes;
	    shift 1;
	    ;;
	-r | --reset)
	    CMD_RESET=yes;
	    ;;
	-* | --*)
	    echo "Wrong option $1."
	    exit 1;
	    ;;
    esac
done

echo -n " > Setting language: $CMD_LANGUAGE."
set_language "$CMD_LANGUAGE";
echo " Done."

if [[ "$CMD_FULL" = "yes" ]];
then
    cv_full;
    echo "Finished.";
    exit 0;
fi

if [[ "$CMD_IMAGES" = "yes" ]];
then
    echo -n " > Setting images.";
    set_images "yes";
    echo " Done.";
fi

if [[ "$CMD_MISSIONS" = "yes" ]];
then
    echo -n " > Setting experiences missions.";
    set_missions "yes";
    echo " Done.";
fi

echo -n " > Generating $CMD_NAME...";
make_cv "$CMD_NAME.pdf";
echo " Done.";

if [[ "$CMD_RESET" = "yes" ]];
then
    echo -n " > Reset $CVTEX to default.";
    reset_options;
    echo " Done."
fi

echo "Finished.";
