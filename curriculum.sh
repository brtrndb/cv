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
SECTION_EXPERIENCES=displaySectionExperiences
SECTION_SKILLS=displaySectionSkills
SECTION_PROJECTS=displaySectionProjects
SECTION_HOBBIES=displaySectionHobbies

IMG_ALL="$IMG_EDUCATION $IMG_EXPERIENCE"
MISSION_ALL="$MISSION_VISIAN $MISSION_SII $MISSION_THALES $MISSION_NOVACOM"
SECTION_ALL="$SECTION_EDUCATION $SECTION_EXPERIENCES $SECTION_SKILLS $SECTION_PROJECTS $SECTION_HOBBIES"
OPTIONS_ALL="$IMG_ALL $MISSION_ALL $SECTION_ALL"

# Script command line options.
CMD_LANGUAGE="french"
CMD_IMAGES="no"
CMD_MISSIONS="no"
CMD_PROJECTS="no"
CMD_NAME="$CVPDF"
CMD_FULL="no"
CMD_RESET="no"

# Functions.
set_language(){
    sed -i 's/'"$CV_LANGUAGE"'}{\(french\|english\)/'"$CV_LANGUAGE"'}{'"$1"'/g' $CVTEX;
}

set_attribute(){
        sed -i '0,/'"$1"'}{\(yes\|no\)/s//'"$1"'}{'"$2"'/g' $CVTEX;
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
	set_attribute $opt "yes";
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
	    CMD_IMAGES="yes";
	    shift 1;
	    ;;
	-m | --missions)
	    CMD_MISSIONS="yes";
	    shift 1;
	    ;;
	-p | --projects)
	    CMD_PROJECTS="yes";
	    shift 1;
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

echo -n " > Setting images: $CMD_IMAGES.";
set_images $CMD_IMAGES;
echo " Done.";

echo -n " > Setting experiences missions: $CMD_MISSIONS.";
set_missions $CMD_MISSIONS;
echo " Done.";

echo -n " > Setting projects section: $CMD_PROJECTS.";
set_attribute $SECTION_PROJECTS $CMD_PROJECTS;
echo " Done.";

echo -n " > Generating $CMD_NAME...";
make_cv "$CMD_NAME";
echo " Done.";

reset_options;

echo "Finished.";
