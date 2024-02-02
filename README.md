# Multi-bibs
A typst library to make multiple bibliographies in a single document possible!

DISCLAIMER : Very early development, but functional!
## Plugin
```typst
//! rootdirectory/chapters/01_chapter/mod.typ
#import "../../lib/multi-bibs.typ": *
#import "bib_01_chapter.typ": biblio

#include "introduction.typ"

// At the end of the chapter, call the bibliography
#mbibliography(biblio)
```
```typst 
//! rootdirectory/chapters/01_chapter/introduction.typ
#import "../../lib/multi-bibs.typ": *
#import "bib_01_chapter.typ": biblio

= Introduction
This is the start of the manuscript.
I am writing a sentence here and here follows a citation #mcitation(("foo2023bar"), biblio).
The second sentence includes another citation #mcitation(("qoo1973qux"), biblio).
```
## Docs 

```typst
//! Function signatures :
// manual citation function
#mcitation(references: array<string>, biblio: dict)

// manual bibliography function
#mbibliography(biblio: dict)
```
## Usage
1. Make a new `CHAPTER_X/` directory.
2. Add `mod.typ` and `bibliography_X.yml` to `CHAPTER_X/`.
3. Run the `parsetyp.py` script on `CHAPTER_X/` to instance an empty bibliography. This generates a `bib_CHAPTER_X.typ` file.
4. Work on the manuscript, use the `#mcitation()` function to cite your references.
    - Run the `parsetyp.py` script on `CHAPTER_X/` to fill out bibliography when adding new references.
5. Add the `#mbibliography(biblio)` function at the very end of the chapter, preferably in `mod.typ`.



```bash
# Usage of parsetyp.py
$ cd rootdirectory/chapters/
$ python3 parsetyp.py CHAPTER_X/
```




## Restrictions!
There are several rigids parts of the manuscript : 
- `CHAPTER_X` directory names are unique!
- `bibliography_X.yml` file names are unique!
Or else, unique links to the correct bibliography can become ambiguous.
</br>

The file structure needs to be respected. Relative imports in typst are still not finetuned and this can make for unrecognised imports of the following structure is not followed : 
```
rootdirectory/ 
    - chapters/
        - CHAPTER_X/
            mod.typ, bibliography_X.yml
        - CHAPTER_Y/
            mod.typ, bibliography_Y.yml
    - lib/
        multi-bibs.typ
```


### Filestructure example
```
rootdirectory/ 
    - chapters/
        parsetyp.py             # parses mod.typ for data !
        convert.sh              # convert foo.bib to foo.yml; hayagriva dependency !
        - 00_title/  
        - 01_chapter/
            mod.typ             # mandatory file per chapter!
            bib_01_chapter.typ  # generated by parsetyp.py
            introduction.typ 
            methods.typ 
            results.typ 
            discussion.typ 
            01_chapter.yml      # bibliography.yml !
        - 02_chapter/  
            ...
        - 03_chapter/
            ...
    - lib/
        multi-bibs.typ          # source of the lib !
    - output/
        main_test.pdf
    - src/
        fonts/
```



## TODO
- Implement a better system for parsing, hopefully `typst` native
- Implement citations where consecutive numbering goes `1-4`, not `1,2,3,4`
- Figure out how to make variables more global to avoid pesky import calls in every file?
- Pathing in the generated `biblio.bibyml` is somewhat hardcoded and hopefully I can change this later
- Allow less strict requirements for the structuring of the filesystem in the project
