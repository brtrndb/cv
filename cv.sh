#!/bin/sh
# Bertrand B.

# Script parameters.
PARAM_OUTPUT_NAME="BertrandBoyer.pdf";
PARAM_WITH_IMAGES="sections";
PARAM_SECTION_PERSONAL=true;
PARAM_SECTION_EDUCATION=true;
PARAM_SECTION_EXPERIENCES=true;
PARAM_SECTION_SKILLS=true;
PARAM_SECTION_LANGUAGES=true;
PARAM_SECTION_HOBBIES=true;
PARAM_NO_RESET=true;

# Makefile constants.
MAKE_NAME="BertrandBoyer";
MAKE_NAME_TEX=$MAKE_NAME.tex;
MAKE_NAME_PDF=$MAKE_NAME.pdf;

NULL="/dev/null";

usage() {
    echo "Usage: ./$(basename $0)";
    echo "-o, --output:  Output file name.";
    echo "-i, --images:  Set images. Options: all, profile, education, experiences, sections.";
    echo "--personal:    Use/Don't use the Personal Informations section. Default: $PARAM_SECTION_PERSONAL.";
    echo "--education:   Use/Don't use the Education section. Default: $PARAM_SECTION_EDUCATION.";
    echo "--experiences: Use/Don't use the Experiences section. Default: $PARAM_SECTION_EXPERIENCES.";
    echo "--skills:      Use/Don't use the Skills section. Default: $PARAM_SECTION_SKILLS.";
    echo "--languages:   Use/Don't use the Language section. Default: $PARAM_SECTION_LANGUAGES.";
    echo "--hobbies:     Use/Don't use the Hobbies section. Default: $PARAM_SECTION_HOBBIES.";
    echo "--no-reset:    Use/Don't reset '$MAKE_NAME_TEX' to its previous state after generating PDF.";
    echo "-h, --help:    Display usage.";
}

configure_param_output() {
    PARAM_OUTPUT_NAME=$2;
    EXTENSION=${PARAM_OUTPUT_NAME##*.};
    if [ "$EXTENSION" = "$PARAM_OUTPUT_NAME" ]; then
	PARAM_OUTPUT_NAME=$PARAM_OUTPUT_NAME.pdf
    fi
}

configure_param_images() {
    if [ "$2" = "all" ] \
	   || [ "$2" = "profile" ] \
	   || [ "$2" = "education" ] \
	   || [ "$2" = "experiences" ] \
	   || [ "$2" = "sections" ] \
	   || [ "$2" = "none" ]; then
	PARAM_WITH_IMAGES=$2;
    else
	echo "Unknown option $2 for $1. Ignored.";
    fi
}

configure_param_sections() {
    if [ "$2" != "yes" ] && [ "$2" != "y" ] \
	   && [ "$2" != "true" ] && [ "$2" != "t" ] \
	   && [ "$2" != "no" ] && [ "$2" != "n" ] \
	   && [ "$2" != "false" ] && [ "$2" != "f" ]; then
	echo "Unknown option $2 for $1. Ignored.";
	return 0;
    fi

    case "$1" in
	--personal)
	    PARAM_SECTION_PERSONAL=$2;
	    ;;
	--education)
	    PARAM_SECTION_EDUCATION=$2;
	    ;;
	--experiences)
	    PARAM_SECTION_EXPERIENCES=$2;
	    ;;
	--skills)
	    PARAM_SECTION_SKILLS=$2;
	    ;;
	--languages)
	    PARAM_SECTION_LANGUAGES=$2;
	    ;;
	--hobbies)
	    PARAM_SECTION_HOBBIES=$2;
	    ;;
	* | -* | --*)
	    echo "Unknown option: $1. Ignored.";
	    ;;
    esac
}

configure() {
    while [ "$#" -gt "0" ];
    do
	case "$1" in
	    -o | --output)
		configure_param_output $1 $2;
		shift 2;
		;;
	    -i | --images)
		configure_param_images $1 $2;
		shift 2;
		;;
	    --personal | --education | --experiences | --skills | --languages | --hobbies)
		configure_param_sections $1 $2;
		shift 2;
		;;
	    --no-reset)
		PARAM_NO_RESET=false;
		shift 1;
		;;
	    -h | --help)
		usage;
		exit 0;
		;;
	    * | -* | --*)
		echo "Unknown option: $1. Ignored.";
		shift 1;
		;;
	esac
    done
}

set_attribute() {
    KEY=$1;
    VALUE=$2;
    echo -n "Setting up '$KEY' to '$VALUE'...";
    sed -i '0,/'"$KEY"'}{\(yes\|no\)/s//'"$KEY"'}{'"$VALUE"'/g' $MAKE_NAME_TEX;
    echo " Done.";
}

set_images() {
    OPTION_IMAGE_PROFILE="displayImageProfile";
    OPTION_IMAGE_EDUCATION="displayImageEducation";
    OPTION_IMAGE_EXPERIENCES="displayImageExperiences";
    OPTION_IMAGE_SECTION="$OPTION_IMAGE_EDUCATION $OPTION_IMAGE_EXPERIENCES";
    OPTION_IMAGE_ALL="$OPTION_IMAGE_PROFILE $OPTION_IMAGE_SECTION";

    KEYS_YES=$OPTION_IMAGE_SECTION;
    KEYS_NO=$OPTION_IMAGE_PROFILE;

    if [ "$PARAM_WITH_IMAGES" = "all" ]; then
	KEYS_YES=$OPTION_IMAGE_ALL;
	KEYS_NO="";
    elif [ "$PARAM_WITH_IMAGES" = "profile" ]; then
	KEYS_YES=$OPTION_IMAGE_PROFILE;
	KEYS_NO=$OPTION_IMAGE_SECTION;
    elif [ "$PARAM_WITH_IMAGES" = "education" ]; then
	KEYS_YES=$OPTION_IMAGE_EDUCATION;
	KEYS_NO="$OPTION_IMAGE_PROFILE $OPTION_IMAGE_EXPERIENCES";
    elif [ "$PARAM_WITH_IMAGES" = "experiences" ]; then
	KEYS_YES=$OPTION_IMAGE_EXPERIENCES;
	KEYS_NO="$OPTION_IMAGE_PROFILE $OPTION_IMAGE_EDUCATION";
    elif [ "$PARAM_WITH_IMAGES" = "sections" ]; then
	KEYS_YES=$OPTION_IMAGE_SECTION;
	KEYS_NO=$OPTION_IMAGE_PROFILE;
    elif [ "$PARAM_WITH_IMAGES" = "none" ]; then
	KEYS_YES="";
	KEYS_NO=$OPTION_IMAGE_ALL;
    fi

    for OPTION_IMAGE in $KEYS_YES; do
	set_attribute $OPTION_IMAGE "yes";
    done
    for OPTION_IMAGE in $KEYS_NO; do
	set_attribute $OPTION_IMAGE "no";
    done
}

set_sections() {
    OPTION_SECTION_PERSONAL="displayPersonalInfos";
    OPTION_SECTION_EDUCATION="displaySectionEducation";
    OPTION_SECTION_EXPERIENCES="displaySectionExperiences";
    OPTION_SECTION_SKILLS="displaySectionSkills";
    OPTION_SECTION_LANGUAGES="displaySectionLanguages";
    OPTION_SECTION_HOBBIES="displaySectionHobbies";

    if [ "$PARAM_SECTION_PERSONAL" = "true" ]; then
	set_attribute $OPTION_SECTION_PERSONAL "yes"
    fi
    if [ "$PARAM_SECTION_EDUCATION" = "true" ]; then
	set_attribute $OPTION_SECTION_EDUCATION "yes"
    fi
    if [ "$PARAM_SECTION_EXPERIENCES" = "true" ]; then
	set_attribute $OPTION_SECTION_EXPERIENCES "yes"
    fi
    if [ "$PARAM_SECTION_SKILLS" = "true" ]; then
	set_attribute $OPTION_SECTION_SKILLS "yes"
    fi
    if [ "$PARAM_SECTION_LANGUAGES" = "true" ]; then
	set_attribute $OPTION_SECTION_LANGUAGES "yes"
    fi
    if [ "$PARAM_SECTION_HOBBIES" = "true" ]; then
	set_attribute $OPTION_SECTION_HOBBIES "yes"
    fi
}

set_all() {
    set_images;
}

reset_all() {
    if [ "$PARAM_NO_RESET" = "true" ]; then
	git checkout $MAKE_NAME_TEX;
    fi
}

do_make() {
    echo -n "Generating $PARAM_OUTPUT_NAME...";
    make > $NULL 2>&1;
    mv $MAKE_NAME_PDF $PARAM_OUTPUT_NAME > $NULL 2>&1;
    echo " Done.";
}

run() {
    configure $*;
    set_all;
    do_make;
    reset_all;
}

run $*;
