from sys import argv
from os.path import isfile
from re import match


# >>> python3 parsetyp.py 02_chapter.typ
# >>> ["parsetyp.py", "02_chapter.typ"]

try :
    filename = argv[1]
except : 
    exit("No file.typ was prompted. Exitting ... ")

if not isfile(filename) or not filename.endswith(".typ") : 
    exit("Incorrect filetype or file does not exist. Exitting ... ")



with open(filename, "r") as typfile : 

    typ = typfile.read()
    total_content = list()
    content = ""
    citefound = False
    commented = False
    brackfound = 0

    for i, char in enumerate(typ): 

        # Ignore commented rules
        if char == "/": 
            if typ[i:i+2] == "//": 
                commented = True
                continue 
        if commented : 
#            print(typ[i:i+2])
            if match(r'\n', typ[i:i+2]) :
                commented = False
                continue
            else : 
                continue

        if char == "#":
            # match on the word mcite; length 5
            if typ[i:(i+6)] == "#mcite":
                citefound = True
                continue

        # find the R-brackets
        if char == "(" and citefound :
            brackfound += 1
            continue

        if citefound and brackfound == 2 :
            if char != ")" :
                content += char

            else :
                citefound = False
                brackfound = 0


                # if done, push to list and close out
                if content not in total_content :
                    total_content.append(content)
                content = ""


bib = "bib_" + filename
with open(bib, "w") as bibdict :
    dictname = "dict_" + filename.split(".")[0]
    bibdict.write(f"#let {dictname} = (\n")

    for idx, citation in enumerate(total_content):
        bibdict.write(f"    {citation}: {idx+1}, \n")
    bibdict.write(")\n")
