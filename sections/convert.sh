#!/bin/bash




convert () {
hayagriva "$1".bib > "$1".yml
}


convert first
convert second
