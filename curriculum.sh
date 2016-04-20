#!/bin/bash
# Generate different versions of moderncv CV.

# Files and folders options.
MODERNCV=BertrandBoyer
CVTEX=$MODERNCV.tex
CVPDF=$MODERNCV.pdf
CVFOLDER=""
NULL=/dev/null

# CV Options.
CV_LANGUAGE=cvLanguageVersion

IMAGE_PROFILE=displayImagesProfile
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

SPACE_CVHEADER=cvHeaderSpace
SPACE_SECTION=cvSectionSpace
SPACE_CVENTRY=cvEntrySpace
SPACE_MISSION_END=cvMissionSpaceEnd
SPACE_CVCOLUM=cvColumnSpace
SPACE_CVCOLUM_END=cvColumnSpaceEnd

IMAGE_ALL="$IMAGE_EDUCATION $IMAGE_EXPERIENCE"
MISSION_ALL="$MISSION_VISIAN $MISSION_SII $MISSION_THALES $MISSION_NOVACOM"
SECTION_ALL="$SECTION_EDUCATION $SECTION_EXPERIENCES $SECTION_SKILLS $SECTION_PROJECTS $SECTION_HOBBIES"
OPTIONS_ALL="$IMAGE_ALL $MISSION_ALL $SECTION_ALL"

# Script command line options.
CMD_NAME="$CVPDF"
CMD_LANGUAGE="french"
CMD_PROFILE="no"
CMD_IMAGES="no"
CMD_MISSIONS="no"
CMD_PROJECTS="no"
CMD_SPACE_HEADER="-0"
CMD_SPACE_SECTION="-0"
CMD_SPACE_ENTRY="-0"
CMD_SPACE_MISSION_END="-0"
CMD_SPACE_COLUMN="-0.4"
CMD_SPACE_COLUMN_END="-0"

# Default values.
DEF_LANGUAGE="french"
DEF_PROFILE="no"
DEF_IMAGES="no"
DEF_MISSIONS="no"
DEF_PROJECTS="no"
DEF_SPACE_HEADER="-0"
DEF_SPACE_SECTION="-0"
DEF_SPACE_MISSION_END="+0"
DEF_SPACE_ENTRY="+0"
DEF_SPACE_COLUMN="-0.4"
DEF_SPACE_COLUMN_END="-0"

# Functions.
set_language(){
    sed -i 's/'"$CV_LANGUAGE"'}{\(french\|english\)/'"$CV_LANGUAGE"'}{'"$1"'/g' $CVTEX;
}

set_attribute(){
    sed -i '0,/'"$1"'}{\(yes\|no\)/s//'"$1"'}{'"$2"'/g' $CVTEX;
}

set_space(){
    sed -i 's/'"$1"'}{[+-]*[0-9]*\.*[0-9]*cm}/'"$1"'}{'"$2"'cm}/g' $CVTEX;
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
    set_language "$DEF_LANGUAGE";
    set_attribute $IMAGE_PROFILE "$DEF_PROFILE";
    set_images "$DEF_IMAGES";
    set_missions "$DEF_MISSIONS";
    set_attribute $SECTION_PROJECTS "$DEF_PROJECTS";
    set_space $SPACE_CVHEADER "$DEF_SPACE_HEADER";
    set_space $SPACE_SECTION "$DEF_SPACE_SECTION";
    set_space $SPACE_MISSION_END "$DEF_SPACE_MISSION_END";
    set_space $SPACE_CVENTRY "$DEF_SPACE_ENTRY";
    set_space $SPACE_CVCOLUM "$DEF_SPACE_COLUMN";
    set_space $SPACE_CVCOLUM_END "$DEF_SPACE_COLUMN_END";
}

make_cv(){
    make > $NULL 2>&1;
    mv $CVPDF "$1" > $NULL 2>&1;
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
	-b | --bertrand)
	    CMD_PROFILE="yes"
	    CMD_SPACE_HEADER=$(echo $CMD_SPACE_HEADER - 0.5 | bc);
	    shift 1;
	    ;;
	-i | --images)
	    CMD_IMAGES="yes";
	    CMD_SPACE_HEADER=$(echo $CMD_SPACE_HEADER - 0.3 | bc);
	    CMD_SPACE_SECTION=$(echo $CMD_SPACE_SECTION - 0.2 | bc);
	    shift 1;
	    ;;
	-m | --missions)
	    CMD_MISSIONS="yes";
	    CMD_SPACE_ENTRY=$(echo $CMD_SPACE_ENTRY + 0.1 | bc);
	    CMD_SPACE_MISSION_END=$(echo $CMD_SPACE_MISSION_END + 0.1 | bc);
	    shift 1;
	    ;;
	-p | --projects)
	    CMD_PROJECTS="yes";
	    shift 1;
	    ;;
	-* | --*)
	    echo "Wrong option: $1."
	    exit 1;
	    ;;
    esac
done

echo -n " > Language: $CMD_LANGUAGE."
set_language "$CMD_LANGUAGE";
echo " Done."

echo -n " > Profile image: $CMD_PROFILE.";
set_attribute $IMAGE_PROFILE "$CMD_PROFILE";
echo " Done.";

echo -n " > Images: $CMD_IMAGES.";
set_images "$CMD_IMAGES";
echo " Done.";

echo -n " > Header space: $CMD_SPACE_HEADER.";
set_space $SPACE_CVHEADER "$CMD_SPACE_HEADER";
echo " Done.";

echo -n " > Entry spaces: $CMD_SPACE_ENTRY.";
set_space $SPACE_CVENTRY "$CMD_SPACE_ENTRY";
echo " Done.";

echo -n " > Section spaces: $CMD_SPACE_SECTION.";
set_space $SPACE_SECTION "$CMD_SPACE_SECTION";
echo " Done.";

echo -n " > Column spaces: $CMD_SPACE_COLUMN.";
set_space $SPACE_CVCOLUM "$CMD_SPACE_COLUMN";
echo " Done.";

echo -n " > Column end spaces: $CMD_SPACE_COLUMN_END.";
set_space $SPACE_CVCOLUM_END "$CMD_SPACE_COLUMN_END";
echo " Done.";

echo -n " > Experiences missions: $CMD_MISSIONS.";
set_missions $CMD_MISSIONS;
echo " Done.";

echo -n " > Projects section: $CMD_PROJECTS.";
set_attribute $SECTION_PROJECTS "$CMD_PROJECTS";
echo " Done.";

echo -n " > Generating $CMD_NAME...";
make_cv "$CMD_NAME";
echo " Done.";

echo -n " > Reset values.";
reset_options;
echo " Done.";

echo "Finished.";
