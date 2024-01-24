#!/bin/bash


# https://www.github.com/typst/hayagriva

convert () {
hayagriva "$1".bib > "$1".yml
}


# Call function to bib files
convert 01_chapter/first
convert 02_chapter/second
