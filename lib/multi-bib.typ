

/* Utility functions */
// Works for Linux/MacOS only
#let basename_yml(pathtofile) = {

  if pathtofile.ends-with(".yml") == false {
    panic("The called file : (" + pathtofile + ") does end in the .yml format")
  }

  let basename = ""
  if pathtofile.contains("/") {
    basename = pathtofile.split("/").at(-1).split(".").at(0) // take yml file (foo.yml) and cut off extension
  } else {
    basename = pathtofile.split(".").at(0)
  }
  basename
}
//
/* Bilbiography functions */

// name_pub : key of the citation
// yml_dict : the dict, parsed by python
// style    : citation style
#let mcite(arr_of_pubs, bilbio) = {

  let basename = basename_yml(bilbio.bibyml)
  let bibchapter = bilbio.bibchapter

  // if the array contains one value, Typst coerces it to extract to only value and give it to you
  if type(arr_of_pubs) == "string" {

    let name_pub = arr_of_pubs // array got coerced into a single string
    let val = bibchapter.at(name_pub, default: 404) // find name of citation in the bibyml
   
    if val == 404 {
      panic("The key: " + name_pub + " was not found in the queried yml.")
    }

    // the link is make by concatenating the :
    // "key of the publication in yml" + "the name of the bibliography.yml file"
    link(
      label(name_pub + basename), // string coerced into label
      text(weight: "bold",
        fill: rgb("#FF4252"),     // red, just for highlights, can be deleted later
        super(str(val)))          // the citation-indexing superscripted
    ) 

  // if the type is an array
  } else if type(arr_of_pubs) == "array" {

    let counter = 0
    for name_pub in arr_of_pubs {

      let val = bibchapter.at(name_pub, default: 404)
     
      if val == 404 {
        panic("The key: " + name_pub + " was not found in the queried yml.")
      }

      let citation = ""
      if counter == 0 {

        // the link is make by concatenating the :
        // "key of the publication in yml" + "the name of the bibliography.yml file"
        link(
          label(name_pub + basename), // string coerced into label
          text(weight: "bold",
            fill: rgb("#FF4252"),     // red, just for highlights, can be deleted later
            super(str(val)))          // the citation-indexing superscripted
        )
      } else {  // if there are multiple citations
        link(
          label(name_pub + basename), 
          text(weight: "bold",
            fill: rgb("#FF4252"),
            super(",") + super(str(val))  // add comma in between citations
          ) 
        )
      }
      counter += 1
    }
  } else {
    panic("Invalid parameters passed to mcite() : " + str(type(arr_of_pubs)))
  }
}

#let mbibliography(biblio) = {

  pagebreak() // page break to start bibliography

  let bibchapter = biblio.bibchapter
  let bibyml = yaml(biblio.bibyml)

  let fontsize = 10pt
  [#text("Bibliography", weight: "bold", size: 16pt) \ ]

  let basename = basename_yml(biblio.bibyml)

  let counter = 0

  for name_pub in bibchapter.keys() {
    counter += 1

    // unique labels indicate the name of the `author key` and the name of the `yaml bibliography`
    [#text(str(counter) + ". ", size: fontsize) #label(name_pub + basename)] // labels have to remain in lobal scope to their appended text
    h(1em) // extra space before citation
    

    let author = bibyml.at(name_pub)
    for (key, value) in author {
      if key == "title" [#text(value + ", ", style: "italic", size: fontsize)] 
      if key == "date" [#text(str(value), weight: "bold", size: fontsize)  \ ] // "\" is a newline character in typst
    }
  }

}
