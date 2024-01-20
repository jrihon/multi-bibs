// awesomeCV-Typst 2023-07-05 mintyfrankie
// Github Repo: https://github.com/mintyfrankie/brilliant-CV
// Typst version: 0.6.0

/* Packages */
#import "../metadata.typ": *
#import "@preview/fontawesome:0.1.0": * // all the fa-FUNCTION calls

/* Styles */

#let awesomeColors = (
  skyblue: rgb("#0395DE"),
  red: rgb("#DC3522"),
  nephritis: rgb("#27AE60"),
  concrete: rgb("#95A5A6"),
  darknight: rgb("#131A28"),
  babyblue: rgb("#669DF2"),
  coral: rgb("#FF4252"),
  nightblue: rgb("#2C63B8"),
  darkrose: rgb("#851545"),
  greenish: rgb("#35CC56"),
  kahki: rgb("#CCB832"),
  brown: rgb("#CC8139"),
  blood: rgb("#CC485D"),
  anthracite: rgb("#767F94"),
)

#let regularColors = (
  lightaccent: rgb("#A9B5D490"), // anthracite ish rgb accent and alpha: 90%
  alpha: rgb("#A9B5D410"), // anthracite ish rgb accent and alpha: 90%
  lightgray: rgb("#343a40"),
  darkgray: rgb("#212529"),
  linkblue: rgb("#48A1D9")
)

#let accentColor = awesomeColors.at(awesomeColor)

/* Layout */
// returns text, page and align setting to the '#show' macro in metadata.typ
#let layout(doc) = {
  set text(
    font: ("Source Sans Pro"),
    weight: "regular",
    size: 12pt,
  )
  set align(left)
  set page(
    paper: "a4",
    margin: (
      left: 1.4cm,
      right: 1.4cm,
      top: .8cm,
      bottom: .4cm,
    ),
  )
  doc
}

/* Bilbiography functions */

// name_pub : key of the citation
// yml_dict : the dict, parsed by python
// style    : citation style
#let mcite(name_pub, ordered_dict) = {
  let val = ordered_dict.at(name_pub, default: 404)
 
  if val == 404 {
    panic("The key: " + name_pub + " was not found in the queried yml.")
  }

  link(
    label(name_pub), // string coerced into label
    text(weight: "bold", fill: rgb("#FF4252"), super(str(val)) ) // the indexing superscript
  )
  
//  val // return the index of the order of appearance of the citation
}

#let mbiblio(name_yml, ordered_dict) = {

  pagebreak()
  [#text("Bibliography", weight: "bold", size: 16pt) \ ]

  let ymlbib = yaml(name_yml)
  let counter = 0

  for author in ordered_dict.keys() {
    counter += 1
    [#text(str(counter) + ". ") #label(author)]
       
    h(1em)

    // label the bibliography to the superscript index value in the text
    

    let auth = ymlbib.at(author)
    for (key, value) in auth {
      if key == "title" [#text(value + ", ", style: "italic")] 
      if key == "date" [#text(str(value), weight: "bold")  \ ] 


    }
  }

}

/* Utility Functions */
//
//#let hBar() = [
//  #h(5pt) | #h(5pt)
//]

//#let autoImport(file) = {
//    include {"../sections/" + file + ".typ"} // string concatenation
//}
//
#let beforeSectionSkip = 1pt
#let beforeEntrySkip = 1pt
#let beforeEntryDescriptionSkip = 1pt


#let sectionTitleStyle(str, color:black, size:16pt) = {text(
  size: size, 
  weight: "bold", 
  fill: color,
  str
)}

#let entryA1Style(str) = {text(
  size: 10pt,
  weight: "bold",
  str
)}


#let entryA2Style(str) = {align(right, text(
  weight: "medium",
  fill: accentColor,
  style: "oblique",
  str
))}

#let entryB1Style(str) = {text(
  size: 8pt,
  fill: accentColor,
  weight: "medium",
  smallcaps(str)
)}

#let entryB2Style(str) = {align(right, text(
  size: 8pt,
  weight: "medium",
  fill: gray,
  style: "oblique",
  str
))}

#let entryDescriptionStyle(str) = {text(
  fill: regularColors.lightgray,
  {
    v(beforeEntryDescriptionSkip)
    str
  }
)}

#let entryKeywords(str) = {
  text(
    fill: regularColors.lightgray,
    style: "italic",
    v(-4pt) + h(8pt) + "Keywords : " + str
  )
}


// Brilliant CV style string colouring
#let cvSection(title) = {
  let highlightText = title.slice(0,3)
  let normalText = title.slice(3)

  v(beforeSectionSkip)
  sectionTitleStyle(highlightText, color: accentColor)
  sectionTitleStyle(normalText, color: black)
  h(2pt)
  box(width: 1fr, line(stroke: 0.9pt, length: 100%))
}

// make a box environment to write text int
#let boxEnvironment(header, align_header, body) = {

  let highlightText = header.slice(0,3)
  let normalText = header.slice(3)
  if header.at(2) == " " { // account for space in at the third letter. Can substitute for any index
    highlightText = header.slice(0,4)
    normalText = header.slice(4)
  }

  v(beforeSectionSkip)
  let h = sectionTitleStyle(highlightText, color: accentColor) + sectionTitleStyle(normalText, color: regularColors.lightaccent)
  align( // header of the box
    align_header,
    text(size: 16pt, h)
  )

  v(-5mm)
  align(
//    align_header,
    rect(
      width: 100%,
      fill: regularColors.alpha,
      radius: 10%,
      stroke : (
        top : regularColors.lightaccent,
        bottom : regularColors.lightaccent,
        right : regularColors.lightaccent,
        left : regularColors.lightaccent,
        rest : rgb("#FFFFFF")
      ),
      par(justify: true, body) // justify the body of content to take up the full width
    )
  )
}

#let manual_cite(dict, match_name, is_first : false) = {

    for (k, v) in dict {

      if k == "authors" {
        let auth_list = v.split(",")
        let auth_len = auth_list.len()
        let c = 1

        for auth in auth_list {
          if auth == match_name and c == 1 { // if first author is my name
            text(auth, weight: "bold")
          } else if c == 1 {  // if it is someone else's name as first author
            text(auth)
          } else if auth == match_name {  // if my name is somewhere in the list
            ", " + text(auth, weight: "bold")
            if is_first { // if I am also joint first-author
              super("◆") // diamond to signify joint first
            }
          } else if c == auth_len {  // if we have arrived to the last one in the list, prefix with ampersand
            " & " + text(auth)
          } else {
             ", " + text(auth)  // if all else, just regular print the name
          }
          c += 1
        }

      } else if k == "title" {
          "\"" + text(v) + "\". "
      } else if k == "date" {
          " (" + text(v) + ") "
      } else if k == "journal" {
          text(v, style: "italic") + ". "
      } else if k == "doi" {
        link("https://doi.org/" + v)[#text(v, fill: regularColors.linkblue)] 
      } else if k == "url" {
        link(v)[#text("Download poster", fill: regularColors.linkblue)] 
        linebreak() // last thing to print from the citation
      } else if k == "volume" {
        text(v) + " "
      } else if k == "number" {
          "(" + text(v) + "), "
      } else if k == "page_range" {
          "pp. " + text(v) + ". "
      }

    }
  v(1pt)
  box(width: 1fr, line(stroke: (thickness: 0.9pt, paint: regularColors.lightaccent), length: 100%)) // just a line across the page
  v(1pt)
}
