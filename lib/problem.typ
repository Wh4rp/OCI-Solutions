#let problem(
  letter: "",
  title: "",
  statement: "",
  input: "",
  output: "",
  subtasks: (),
  examples: (),
  solution: none,
) = {
  heading(level: 3, [Problema #letter - #title])
  statement
  heading(level: 4, "Entrada", outlined: false)
  input
  heading(level: 4, "Salida", outlined: false)
  output
  if subtasks != () {
    heading(level: 4, "Subtareas y puntajes", outlined: false)
    for (index, subtask) in subtasks.enumerate(start: 1) {
      heading(level: 5, outlined: false)[
        Subtarea #index (#subtask.score puntos)
      ]
      subtask.description
    }
  }
  if examples != () {
    heading(level: 4, "Ejemplos de entrada y salida", outlined: false)
    for example in examples {
      move(dx: 2.5%, dy: 0pt, block(
        inset: 8pt,
        stroke: 0.5pt + black,
        width: 95%,
      )[
        #grid(
          columns: (50%, 50%),
          [
            #heading(level: 5, "Entrada de ejemplo", outlined: false)
            #example.input
          ],
          [
            #heading(level: 5, "Salida de ejemplo", outlined: false)
            #example.output
          ]
        )
      ]
      )
    }
  }
  heading(level: 4, "Solución")
  solution
  pagebreak()
}