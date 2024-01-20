#import "./template/template.typ": * // import all functions from the template

// https://github.com/typst/packages/tree/main/packages/preview/fontawesome/0.1.0
// Import from the typst package repository: https://typst.app/docs/packages/
#import "@preview/fontawesome:0.1.0": * // for the special unicode symbols

#show: layout

#include {"./sections/titlepage.typ"} 
#include {"./sections/01_chapter.typ"} 
#include {"./sections/02_chapter.typ"} 

//#autoImport("01_chapter")
//#autoImport("02_chapter")

