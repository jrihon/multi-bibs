#import "../template/template.typ": *

#import "bib_01_chapter.typ": dict_01_chapter

#let biblio = (
  bibchapter : dict_01_chapter,
  bibyml : "../sections/first.yml"
)

= Chapter 1
#lorem(150)

== Introduction
#lorem(50)
We follow the nomenclature of IUPAC #mcite(("iupac1983nucleicacids"), biblio)
//We follow the nomenclature of IUPAC #cite(<iupac1983nucleicacids>)
== Methods
#lorem(50)
This software package is the absolute best #mcite(("neese2020orca"), biblio) !
== Results
#lorem(50)

In terms of formalisms, the Cremer-Pople formalism is top notch #mcite(("cremer1975general"), biblio).
but still, this thing is also fine #mcite(("iupac1983nucleicacids"), biblio).
== Conclusion
#lorem(20)

#mbibliography(biblio)
