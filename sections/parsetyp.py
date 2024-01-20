from sys import argv
from os.path import isfile


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
    brackfound = False

    for i, char in enumerate(typ): 
        if char == "#":
            # match on the word mcite; length 5
            if typ[i:(i+6)] == "#mcite":
                citefound = True
                continue

        # find the R-brackets
        if char == "(" and citefound :
            brackfound = True
            continue

        if citefound and brackfound :
            if char != ")" :
                content += char

            else :
                citefound = False
                brackfound = False


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
    bibdict.write(")")



            
