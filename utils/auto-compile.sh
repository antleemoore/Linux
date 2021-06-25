#!/bin/bash

clear

extension="${1##*.}"
RED='\033[0;31m'
NC='\033[0m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
case $extension in 
    cpp)
        echo "Starting Auto C++ Runner"
        echo $1 | entr -psc 'echo Compiling C++ File; echo; echo Output:;g++ -o '${1%.cpp}' '$1' && ./'${1%.cpp}
        ;;
    c)
        echo "Starting Auto C Runner"
        echo $1 | entr -psc 'echo Compiling C File; echo; echo Output:;gcc -o '${1%.c}' '$1' && ./'${1%.c}
        ;;
    js)
        echo "Starting Auto JavaScript Runner"
        echo $1 | entr -psc 'echo Compiling JavaScript File; echo; echo Output:;node '$1
        ;;
    py)
        echo "Starting Auto Python Runner"
        echo $1 | entr -psc 'echo Compiling Python File; echo; echo Output:;python '$1
        ;;
    java)
        echo "Starting Auto Java Runner"
        echo $1 | entr -psc 'echo Compiling Java File; echo; echo Output:;javac '$1' && java '${1%.java}
        ;;
    html) # WIP
            echo "Starting Auto HTML Runner"
            echo $1 | entr -pscr 'echo Rendering HTML File; echo;firefox --new-window '$1
        # else
            echo -e "${RED}Error${NC} (${LIGHTBLUE}HTML Run${NC}): ${YELLOW}Firefox Needs to Already Be Running${NC}"
        # fi
        ;;
    tex) # WIP
        echo "Starting Auto LaTeX Runner"
        echo "Starting Initial Compile"
        pdflatex $1 > /dev/null
        qpdfview ${1%.tex}'.pdf' &
        echo $1 | entr -psc 'echo Compiling LaTeX File; echo; echo Output:;pdflatex '$1
        killall qpdfview
        ;;
    sh)
        echo "Starting Auto Shell Script Checker"
        echo $1 | entr -psc 'echo Checking Shell Script; echo; echo Output:; shellcheck '$1
        ;;
    *)
        echo "Unsupported File Type"
        ;;
esac
