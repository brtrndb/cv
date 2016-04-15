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

IMAGE_EDUCATION=displayImagesEducation
IMAGE_EXPERIENCE=displayImagesExperiences

SECTION_EDUCATION=displaySectionEducation
SECTION_EXPERIENCES=displaySectionExperiences
SECTION_SKILLS=displaySectionSkills
SECTION_PROJECTS=displaySectionProjects
SECTION_HOBBIES=displaySectionHobbies

MISSION_VISIAN=displayMissionsVisian
MISSION_SII=displayMissionsSII
MISSION_THALES=displayMissionsThales
MISSION_NOVACOM=displayMissionsNovacom

SPACE_CVENTRY=cvEntrySpace
SPACE_CVCOLUM=cvColumnSpace
SPACE_CVCOLUM_END=cvColumnSpaceEnd

IMAGE_ALL="$IMAGE_EDUCATION $IMAGE_EXPERIENCE"
MISSION_ALL="$MISSION_VISIAN $MISSION_SII $MISSION_THALES $MISSION_NOVACOM"
SECTION_ALL="$SECTION_EDUCATION $SECTION_EXPERIENCES $SECTION_SKILLS $SECTION_PROJECTS $SECTION_HOBBIES"
OPTIONS_ALL="$IMAGE_ALL $MISSION_ALL $SECTION_ALL"

# Script command line options.
CMD_LANGUAGE="french"
CMD_IMAGES="no"
CMD_MISSIONS="no"
CMD_PROJECTS="no"
CMD_NAME="$CVPDF"
CMD_FULL="no"
CMD_RESET="no"
CMD_SPACE_SECTION="+0"
CMD_SPACE_ENTRY="+0"
CMD_SPACE_COLUMN="-0.4"
CMD_SPACE_COLUMN_END="-0.5"

# Functions.
set_language(){
    sed -i 's/'"$CV_LANGUAGE"'}{\(french\|english\)/'"$CV_LANGUAGE"'}{'"$1"'/g' $CVTEX;
}

set_attribute(){
    sed -i '0,/'"$1"'}{\(yes\|no\)/s//'"$1"'}{'"$2"'/g' $CVTEX;
}

set_space(){
    sed -i 's/'"$1"'}{[+-][0-9]*\.*[0-9]*cm}/'"$1"'}{'"$2"'cm}/g' $CVTEX;
}

set_images(){
    for img in $IMAGE_ALL;
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
    set_space $SPACE_CVENTRY "+0";
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
	    CMD_SPACE_ENTRY="+0.2";
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

echo -n " > Setting entries spaces: $CMD_SPACE_ENTRY.";
set_space $SPACE_CVENTRY $CMD_SPACE_ENTRY;
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
