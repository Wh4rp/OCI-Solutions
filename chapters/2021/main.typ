#import "@preview/cetz:0.1.2"
#import "../../lib/problem.typ": *

== Final

#problem(
  letter: "B",
  title: [El mejor camino], statement:
  [
    Aburrida en su casa, Maiki acaba de inventar un nuevo juego. El juego se juega en una matriz de $M$ filas y $N$ columnas. Las filas de la matriz se enumeran de arriba a abajo entre $1$ y $M$. Las columnas se enumeran de izquierda a derecha entre $1$ y $N$. Identificamos con un par  $(i, j)$ a la casilla en la fila i y columna j.

    Partiendo de la casilla  $(1, 1)$, en cada turno uno puede moverse desde la casilla actual a la casilla inmediatamente abajo o inmediatamente a la derecha. Cada vez que uno se mueve a una nueva casilla se asigna un puntaje. El puntaje es distinto para cada casilla y depende de si uno se mueve a la casilla viniendo desde la izquierda o desde arriba. El objetivo del juego es llegar a la casilla  $(M, N)$ sumando la mayor cantidad de puntaje.

    La siguiente figura muestra un ejemplo para $M = 2$ y $N = 3$ Las flechas representan los puntajes asociados a cada casilla. Notar que las casillas del borde superior tienen un puntaje asociado a llegar desde arriba. Estos puntajes son irrelevantes pues uno nunca puede moverse a estas casillas desde arriba. Similarmente, las casillas del borde izquierdo tienen un puntaje asociado a llegar desde la izquierda a pesar de ser irrelevante.

    #align(center)[
      #image(width: 60%, "mejor_camino.png")
    ]

    Las flechas marcadas de color *rojo* representan un posible camino. Partiendo desde la casilla  $(1, 1)$ primero se mueve hacia la casilla  $(2, 1)$ obteniendo $8$ puntos. Posteriormente se mueve dos veces a la derecha obteniendo respectivamente en cada movimiento $9$ y $4$ puntos. El puntaje total es entonces $8 + 9 + 4 = 21$. Notar que cualquier otro camino obtiene un menor puntaje y por lo tanto 21 es el puntaje máximo que es posible obtener.

    Dada una matriz con los puntajes asociados a cada casilla, tu tarea es encontrar el puntaje máximo que es posible obtener en el juego.
  ],
  input:
  [
    La primera línea de la entrada contiene dos enteros $M$ y $N$ $(1 ≤ N ≤ 500$ y $1 ≤ M ≤ 500)$ correspondientes respectivamente a la cantidad de filas y columnas en la matriz.

    A continuación siguen $M$ líneas cada una conteniendo $N$ enteros mayores o iguales que cero y menores que $10^6$. El $j$-ésimo entero de la línea $i$-ésima corresponde al puntaje asociado a moverse desde arriba a la casilla $(i, j)$.
  ],
  output:
  [
    La salida consiste en un entero  -  el puntaje máximo que es posible obtener en el juego.
  ],
  subtasks:
  (
    (
      score: 10,
      description: [
        Se probarán varios casos en que $M = 1$ (ver primer caso de ejemplo). 
      ]
    ),
    (
      score: 10,
      description: [
        Se probarán varios casos en que el puntaje asociado a moverse desde arriba es igual al puntaje de moverse desde la izquierda y además este es igual para todas las celdas (ver segundo caso de ejemplo).
      ]
    ),
    (
      score: 30,
      description: [
        Se probarán varios casos en que para cada celda el puntaje de moverse desde arriba es igual al puntaje de moverse desde la izquierda. Este valor puede ser distinto para celdas distintas (ver tercer caso de ejemplo). 
      ]
    ),
    (
      score: 50,
      description: [
        Se probarán varios casos sin restricciones adicionales (ver cuarto caso de ejemplo).
      ]
    )

  ),
  examples:
  (
    (
      input: [
        1 6\
        0 0 0 0 0 0\
        0 2 3 1 4 1
      ],
      output: [11]
    ),
    (
      input: [
        3 5\
        2 2 2 2 2\
        2 2 2 2 2\
        2 2 2 2 2\
        2 2 2 2 2\
        2 2 2 2 2\
        2 2 2 2 2
      ],
      output: [12]
    ),
    (
      input: [
        4 2\
        1 2\
        4 2\
        3 4\
        1 3\
        1 2\
        4 2\
        3 4\
        1 3
      ],
      output: [14]
    ),
    (
      input: [
        2 3\
        2 1 5\
        8 1 4\
        1 3 3\
        3 9 4
      ],
      output: [21]
    ),
  ),
  solution: [
    Pensemos este problema de forma recursiva. Si estamos en una casilla $(i, j)$ entonces se tuvo que haber llegado o por la izquierda o por arriba. Suponiendo que se tienen ya las sumas máximas para llegar a $(i-1, j)$ y $(i, j-1)$ entonces la suma máxima hasta la casilla $(i, j)$ está dada por la siguiente identidad:

    $ "max_sum"(i, j) = max("max_sum"(i - 1, j) + "arriba"(i, j), "max_sum"(i, j - 1) + "izquierda"(i, j)) $

    #figure(
      caption: [Posibles casillas de procedencia para llegar a $(i, j)$],
      align(center)[
        #cetz.canvas({
          import cetz.draw: *
          grid((0,0), (8,6), step: 2, help-lines: true)
          // (i, j)
          content((5, 3), [$(i, j)$], name: "position to go")
          content((3, 3), [$(i, j-1)$], name: "position from left")
          content((5, 5), [$(i-1, j)$], name: "position from top")
          // Arrow 1 from left to "position"
          place-marks(bezier-through(
            (3.2,3.2), (3.8,3.8), (4.8,3.3)),
            (mark: ">", size: .2, pos: 1),
            fill: black
          )
          // Arrow 2 from top to "position"
          place-marks(bezier-through(
            (5,4.7), (5.5,4), (5.2,3.3)),
            (mark: ">", size: .2, pos: 1),
            fill: black
          )
        })
      ]
    )


    Donde $"arriba"(i, j)$ es el puntaje que se suma llegando desde arriba, y lo análogo para $"izquierda"(i, j)$.

    Esta fórmula es válida siempre y cuando $0 < i <= M$ y $0 < j <= N$.
    
    Veamos que $"max_sum"(0, 0) = 0$ ya que es por donde se parte y no se ha sumado nada aún.
    
    Cuando $i = 0$ y $j != 0$, nos estaríamos fijando en la primera columna. Donde la única forma de llegar a $(i, j)$ es ir hacia bajos desde $(0, 0)$. Por lo que está dado por:

    $ "max_sum"(i, j) = "max_sum"(i - 1, j) + "arriba"(i, j) $

    #figure(
      caption: [Primera fila donde $i = 0$],
      align(center)[
        #cetz.canvas({
          import cetz.draw: *
          let (n, m) = (4, 4)
          fill(red)
          stroke(none)
          rect((0, n), (n, m - 1))
          stroke(black)
          grid((0,0), (n, m), help-lines: true)
        })
      ]
    )

    Por otro lado cuando $i != 0$ y $j = 0$, nos estaríamos fijando en la primera fila. Donde la única forma de llegar a $(i, j)$ es ir hacia la derecha desde $(0, 0)$. Por lo que está dado por:

    $ "max_sum"(i, j) = "max_sum"(i, j - 1) + "izquierda"(i, j) $

    #figure(
      caption: [Primera columna donde $j = 0$],
      align(center)[
        #cetz.canvas({
          import cetz.draw: *
          let (n, m) = (4, 4)
          fill(red)
          stroke(none)
          rect((0, 0), (1,n))
          stroke(black)
          grid((0,0), (n, m), help-lines: true)
        })
      ]
    )

    Así en el código podemos hacer un array de dos dimensiones donde guardaremos las sumas máximas hasta cada casilla. Y luego recorrer la matriz de izquierda a derecha y de arriba hacia abajo, calculando las sumas máximas para cada casilla. Finalmente la suma máxima hasta la casilla $(M - 1, N - 1)$ es la solución al problema.

    ```cpp
    #include <bits/stdc++.h>
    using namespace std;

    #define rep(i, n) for(int i = 0; i < n; i++)

    int main() {
      int n, m;
      cin >> n >> m;

      int arriba[n][m], izquierda[n][m];

      rep(i, n) rep(j, m) cin >> arriba[i][j];
      rep(i, n) rep(j, m) cin >> izquierda[i][j];
      
      int max_sum[n][m];

      rep(i, n){
        rep(j, m){ 
          if(i == 0 && j == 0)
            max_sum[0][0] = 0;
          else if(i == 0)
            max_sum[i][j] = max_sum[i][j - 1] + izquierda[i][j];
          else if(j == 0)
            max_sum[i][j] = max_sum[i-1][j] + arriba[i][j];
          else
            max_sum[i][j] = max(max_sum[i][j - 1] + izquierda[i][j], max_sum[i-1][j] + arriba[i][j]);
        }
      }

      cout << max_sum[n-1][m-1] << '\n';

      return 0;
    }
    ```
  ]
)