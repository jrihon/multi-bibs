#!/bin/bash


# https://www.github.com/typst/hayagriva

convert () {
cd "$1"
hayagriva "$1".bib > "$1".yml
cd ..
}


# Call function to bib files
convert 01_chapter && python3 parsetyp.py 01_chapter/
convert 02_chapter && python3 parsetyp.py 02_chapter/
convert 03_chapter && python3 parsetyp.py 03_chapter/
