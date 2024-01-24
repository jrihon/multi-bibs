#import "../../lib/multi-bib.typ": *

#import "bib_01_chapter.typ": dict_01_chapter // import dictionary from the generated file

#let biblio = (
  bibchapter : dict_01_chapter,
  bibyml : "../sections/01_chapter/first.yml"
)

//#include "01_chapter.typ"
#include "introduction.typ"
#include "methods.typ"
#include "results.typ"
#include "discussion.typ"
