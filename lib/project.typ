#let project(
  title: "",
  subtitle: "",
  author: "",
  presentation: none,
  doc,
) = {

  // set document(
    
  // )

  set list(
    indent: 1em,
  )

  set text(
    font: "New Computer Modern",
    lang: "es",
  )

  move(dy: 30%, align(end)[
    #set text(
      size: 14pt,
    )
    #heading(level: 1, outlined: false)[#title]
    #heading(level: 2, outlined: false)[#subtitle]
    #heading(level: 3, outlined: false)[#author]
  ])

  

  pagebreak()

  set page(
    numbering: "i",
  )

  heading(level: 1)[Presentación]

  presentation

  pagebreak()

  outline(indent: 2em)

  set page(
    numbering: "1",
  )
  counter(page).update(1)

  doc
}