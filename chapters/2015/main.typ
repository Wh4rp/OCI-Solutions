#import "../../lib/problem.typ": *

== Regional

#problem(
  letter: "A",
  title: [¿Cuánto pan es _una marraqueta_?], statement:
  [
    En la casa de Alejandra tendrán un asado familiar y su padre la ha enviado a comprar marraquetas para hacer choripanes. Alejandra no sabe exactamente cuánto pan es _una marraqueta_ pues siempre ha comprado hallullas, así que antes de partir pregunta a su padre cuanto pan es _una marraqueta_. Su padre le responde que según recuerda, en las panaderías se encuentran como 4 rollos de pan pegados y que cada uno de estos rollos es _una marraqueta_. Alejandra queda extrañada, pues si los cuatro rollos vienen pegados deberían en su conjunto ser llamados _una marraqueta_. Para no discutir Alejandra simplemente acepta la definición de marraqueta de su padre y se dirige a la panadería para cumplir con la orden.

    Por si no fuera ya el colmo al llegar a la panadería Alejandra queda aún más confundida, pues ve a un cliente comprar 2 marraquetas y salir con el conjunto de 4 rollos pegados. Al parecer en la panadería siguen la definición de la Asociación de Consumo de Marraquetas (ACM) y consideran que _una marraqueta_ son dos rollos de pan pegados. En la panadería solo pueden vender una cantidad entera de marraquetas y Alejandra debe pedirlas según la definición de la ACM. Dada la cantidad de marraquetas que quiere el padre según su definición, ¿podrías ayudar a Alejandra a saber cuántas marraquetas pedirle al panadero? Notar que como solo se puede comprar una cantidad entera de marraquetas no siempre es posible llevar la cantidad exacta de marraquetas según la definición del padre. Si este es el caso Alejandra puede llevar más marraquetas, pero siempre debe comprar la menor cantidad posible.
  ],
  input:
  [
    La entrada consiste en una línea con un único entero $N$ que representa la cantidad de marraquetas que Alejandra debe comprar según la definición de su padre.
  ],
  output:
  [
    Debes imprimir una línea con un único entero correspondiente a la menor cantidad de marraquetas según la definición de la ACM que Alejandra debe comprar para llevar a su padre la cantidad de marraquetas que solicitó según su definición.
  ],
  subtasks:
  (
    (
      score: 30,
      description: [
        Se probarán varios casos donde $0<N≤100$ y siempre es posible comprar la cantidad exacta de marraquetas.
      ]
    ),
    (
      score: 70,
      description: [
        Se probarán varios casos donde $0<N≤100$ y sin restricciones adicionales.
      ]
    )
  ),
  examples:
  (
    (
      input: [78],
      output: [39]
    ),
    (
      input: [7],
      output: [4]
    ),
  ),
  solution: [
    Primero que todo hagamos la conversión entre las dos definciones de _una marraqueta_. Según la definición del padre, _una marraqueta_ son 4 rollos de pan pegados, mientras que según la definición de la ACM, _una marraqueta_ son 2 rollos de pan pegados. Por lo tanto, para pasar de la definición del padre a la definición de la ACM debemos dividir por 2.

    Se puede seguir el siguiente razonamiento:

    $ 1 "marraqueta para el papá" -> 1 "rollo" -> 1 / 2 dot (2 "rollos") -> 1 / 2 "marraqueta para la ACM" $

    Es claro que si se nos pide una cantidad par de marraquetas entonces basta con pedir la mitad en la panadería; e.g. el papá pide 8 marraquetas (8 rollos) entonces Alejandra pide 4 marraquetas según la ACM ($2 dot 4 "rollos" = 8 "rollos"$).

    Si se pide una cantidad impar entonces hay que pedir la función para que así no falte; e.g. el papá pide 7 marraquetas (7 rollos) entonces Alejandra pide 4 marraquetas según la ACM ($2 dot 4 "rollos" = 8 "rollos" > 7 "rollos"$).

    Así el código nos queda:

    ```cpp
    #include <iostream>
    using namespace std;

    int main() {
      int n;
      cin >> n;
      if (n % 2 == 0) {
        cout << n / 2 << endl;
      } else {
        cout << (n + 1) / 2 << endl;
      }
    }
    ```

    También se puede hacer el truco de sumar 1 a $N$ antes de dividirlo por 2, pues así nos aseguramos de que la división siempre redondee hacia arriba. Esto es porque si $N$ es par entonces $N + 1$ es impar y el resultado de la división no cambia.

    ```cpp
    #include <iostream>
    using namespace std;

    int main() {
      int n;
      cin >> n;
      cout << (n + 1) / 2 << endl;
    }
    ```
  ]
)

== Final nacional

#problem(
  letter: "A",
  title: [Partido de ping-pong], statement:
  [
    Jota Pe y Nelman son fanáticos del ping-pong. Cada vez que se juntan aprovechan de jugar un partido. Sus partidos no son profesionales y siguen las siguientes reglas que ellos mismos han inventado:

    - El partido se juega a N puntos y el primero que llega a los N puntos gana.
    - La cantidad de puntos, es decir, el valor de N, puede ser distinto en cada partido.
    - En cada partido uno de los dos comienza sacando.
    - Cada jugador conserva su saque hasta perder un punto. 

    Lo que no saben Jota Pe y Nelman es que sus partidos son muy predecibles. Resulta que cada vez que a Jota Pe le toca sacar tiene una racha de A puntos, es decir, gana A puntos seguidos y luego pierde el saque. Lo mismo pasa con Nelman, cada vez que a él le toca sacar tiene una racha de B puntos y luego pierde su saque. El largo de las rachas, es decir, el valor de A y B, depende del día en que jueguen. Notar que cuando un jugador pierde el saque el oponente gana un punto.

    Jota Pe y Nelman quedarían muy sorprendidos si alguien fuera capaz de adivinar quién de los dos va a ganar un partido antes de que lo jueguen. ¿Qué tal si haces un programa para sorprenderlos?
  ],
  input:
  [
    La entrada está compuesta de dos líneas.

    La primera línea contiene dos enteros N y P. N corresponde a la cantidad de puntos a los que se jugará el partido. P es un entero que indica quién comenzará sacando (Jota Pe = 1 y Nelman = 2). La siguiente línea contiene dos enteros A y B, que representan respectivamente el largo de las rachas de Jota Pe y de Nelman.
  ],
  output:
  [
    Tu programa debe imprimir un 1 si Jota Pe es quien ganará el partido y un 2 si Nelman es quien ganará el partido.
  ],
  subtasks:
  (
    (
      score: 10,
      description: [
        Se probarán varios casos donde $1≤N≤100$, $P=1$, y $A = B = 0$.
      ]
    ),
    (
      score: 10,
      description: [
        Se probarán varios casos donde $1≤N≤100$, $P=1$, y $A = B = 1$.
      ]
    ),
    (
      score: 20,
      description: [
        Se probarán varios casos donde $1≤N≤100$, $A=B$, y $0 ≤ A, B ≤ N$.
      ]
    ),
    (
      score: 60,
      description: [
        Se probarán varios casos donde $1≤N≤100$, y $1 ≤ A, B ≤ N$.
      ]
    )
  ),
  examples:
  (
    (
      input: [11 1\ 0 0],
      output: [2]
    ),
    (
      input: [11 1\ 1 1],
      output: [1]
    ),
    (
      input: [7 2\ 2 2],
      output: [2]
    ),
    (
      input: [6 1\ 2 3],
      output: [2]
    ),
  ),
  solution: [
    Como $N$ es un valor chico (a lo más 100) entonces podemos simular el juego hasta que alguno de los dos obtenga los $N$ puntos.

    Una manera fácil de simularlo es teniendo variables que guarden los puntos de cada jugador y hagamos un bucle donde asignemos un punto según cuantos turnos quedan de racha al jugador que saca. Si ya no quedan turnos de racha entonces asignamos un punto al otro y cambiamos quien saca.

    ```cpp
    #include <iostream>
    using namespace std;

    int main() {
      int n, p, a, b;
      cin >> n >> p >> a >> b;
      int jota = 0, nelman = 0;
      int contador_racha;
      // Asignamos el contador de racha según quien comienza sacando
      if (p == 1) {
        contador_racha = a;
      } else {
        contador_racha = b;
      }
      while (jota < n && nelman < n) {  // Mientras ninguno haya ganado
        if(contador_racha != 0){        // Si quedan turnos de racha
          if (p == 1) {
            jota++;
          } else {
            nelman++;
          }
          contador_racha--;
        }
        else{                            // Si no quedan turnos de racha
          if(p == 1){                    // cambiamos quien saca y
            p = 2;                       // reasignamos el contador de racha
            nelman++;
            contador_racha = b;
          }
          else{
            p = 1;
            jota++;
            contador_racha = a;
          }
        }
      }

      // Imprimimos el ganador
      if (jota == n) {
        cout << 1 << endl;
      } else {
        cout << 2 << endl;
      }
    }
    ```
  ]
)