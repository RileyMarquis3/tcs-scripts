#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
WHITE='\033[0;37m'
RESET='\033[0m'

SearchString="savona"
SearchString2="anovas"

FILE="README"
FILE2="README2"
# grep -iw savona README
### grep -iw $SearchString $FILE

DisplayResults() {
if [ "$?" == "0" ]; then
        echo -e "${GREEN}String exists in README file${RESET}"
else
        echo -e "${RED}String does NOT exist in README file${RESET}"
fi
}

grep -iw $SearchString $FILE
	DisplayResults

grep -iw $SearchString2 $FILE2
	DisplayResults

