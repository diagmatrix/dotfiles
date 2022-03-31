# VARIABLES
# colors
RED=`tput setaf 2`
BOLD=`tput bold`
NC=`tput sgr0`
# files
OUTPUT=$2
FILES=${@:3}
# aux
OPTION=$1

# PROCESS
if [ "$OPTION" = '--help' ]; then
    echo -e "${BOLD}Usage:${NC} pdfmerge [OPTION] [OUTPUT] [FILE]..."
    echo -e "${BOLD}Options:${NC}"
    echo -e "\t -o: Merge the pdfs into OUTPUT"
    echo -e "\t --help: Shows this help message"
elif [ "$OPTION" = '-o' ]; then
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$OUTPUT $FILES
    echo -e "${BOLD}PDFs files merged into${NC} ${RED}${OUTPUT}${NC}"
    echo -n "Do you wish to remove the files? [Y/N] "
	read answer
    if [ "$answer" != "${answer#[Yy]}" ];then 
        for var in "${FILES[@]}"; do
            printf '%s\n' "${BOLD}Removing: ${NC}$var"
            rm $var
        done
    fi
else
    echo -e "Missing operand..."
    echo -e "Try 'pdfmerge --help' for more information."
fi