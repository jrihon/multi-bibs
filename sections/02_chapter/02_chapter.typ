#import "../../lib/multi-bib.typ": *

#import "bib_02_chapter.typ": dict_02_chapter

#let biblio = (
  bibchapter : dict_02_chapter,
  bibyml : "../sections/02_chapter/second.yml"
)

#pagebreak()

= Chapter 2
#lorem(150)

== Introduction
#lorem(50). Afterwards the thing haasnoot1992conformation did cool thing, together with stuff #mcite(("rings1980conformational"), biblio).

== Methods
#lorem(50)
We did the method of Sega #emph[et al.] #mcite(("Sega2011Sixring"), biblio)

== Results
#lorem(50)
We did the method of Cremer #emph[et al.] #mcite(("cremer1975general"), biblio)

== Conclusion
#lorem(20)

#mbibliography(biblio)
