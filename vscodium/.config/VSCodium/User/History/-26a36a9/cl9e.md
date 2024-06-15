# Rust

## ¿Qué es Rust?

**_A language empowering everyone to build reliable and efficient software_**

Rust es un lenguaje de programación _compilado_, de bajo nivel, de _de propósito general"_ y _multiparadigma_ desarrollado por la Rust Foundation.

Rust es un lenguaje de _código abierto_ que se apoya fuertemente en la opinión de la comuinidad para incorporación de mejoras y la corrección del códgio.

Rust nació con el objetivo de ser un buen lenguaje para la creación de aplicaciones tanto del lado del servidor como del lado del cliente. Por este motivo, se ha tratado de hacer énfasis en características como la _seguridad_, _el control de la memoria_ y _concurrencia_.

## ¿Por qué Rust?

### Eficiencia

- No cuenta con garbage-collector, la operatoria de la gestión de la memoría recae en el desarrollador.
- Se tiene abstracciones con cero coste. Se tienen abstracciones con cero coste. A diferencia de otros lenguajes como Java, que cada vez que se crea una clase, no solo la clase que creamos en esta en memoria, sino que todos los metadatos que acompañan a la misma estarán en memoria. Rust por otro lado, cada vez que se declara un struct (tipo de clase), solo los datos del struct son cargados en memoría. No se agrega ningún metadato.

### Fiabilidad

- Cuenta con un sistemas de tipos estáticos y profundos.
- Cuenta con un meaejo de memoria seguro.
- Minimiza las condiciones de carrera.

### Productividad

- Cuenta con una documentación muy completa.
- Cuenta con un compilador accesible con mensajes de error útiles.
- Los mensajes de error son claros, sencillos de entender y sobre todo, útiles. En ocaciones el compilador te sugiere código más correcto de implementar.

## Historia

Rust, desde sus inicios, ha experimentado un desarrollo dinámico y una evolución significativa. Fue concebido por Graydon Hoare, un ingeniero de Mozilla, con el objetivo de superar las limitaciones de los lenguajes de programación existentes y abordar problemas de seguridad y rendimiento.

- **2006: Inicios del desarrollo**

  - El proyecto Rust se inició en 2006 como un experimento interno en Mozilla para abordar las deficiencias de otros lenguajes utilizados en el desarrollo del navegador Firefox.

- **2010: Anuncio público**

  - En 2010, Rust se anunció públicamente, generando interés y participación de la comunidad de desarrolladores.

- **2015: Lanzamiento de Rust 1.0**

  - El 15 de mayo de 2015, Rust alcanzó su versión 1.0, marcando un hito significativo en su desarrollo. Esta versión estable estableció la base para el uso práctico del lenguaje en diversos proyectos.

- **Desarrollo abierto y colaborativo**

  - Desde entonces, Rust ha adoptado un enfoque de desarrollo abierto y colaborativo, con la Rust Foundation asumiendo un papel crucial en la gestión y dirección del proyecto.

- **2020: Creación de la Rust Foundation**
  - En 2020, se anunció la creación de la Rust Foundation como una entidad independiente para respaldar y fomentar el crecimiento de Rust como un lenguaje de programación moderno y confiable.

La historia de Rust refleja su evolución desde un proyecto experimental hasta un lenguaje maduro y confiable que se utiliza en una variedad de aplicaciones críticas y proyectos de código abierto.

Esta breve historia proporciona un contexto sobre cómo Rust ha evolucionado a lo largo de los años y ha ganado aceptación en la comunidad de desarrollo de software.

## Rust te incentiva a programar correctamente

La afirmación de que Rust te convierte en un mejor programador no es una exageración; está respaldada por principios fundamentales que el lenguaje introduce, especialmente a través de su sistema de propiedad. Veamos algunas de las razones clave:

### No cuenta con garbage-collector

La ausencia de un recolector de basura en Rust significa que debes ser consciente y deliberado en la gestión de la memoria. A diferencia de muchos lenguajes modernos que automatizan la liberación de memoria, en Rust, eres el responsable de asignar y liberar memoria. Esto puede parecer inicialmente desafiante, pero te obliga a adoptar prácticas de programación más seguras y eficientes.

Rust aborda varios problemas relacionados con el manejo de la memoria en lenguajes de programación, y su enfoque innovador ha contribuido a resolver o mitigar los siguientes problemas:

1. **Fugas de Memoria (Memory Leaks):** Las fugas de memoria ocurren cuando un programa asigna memoria pero no la libera después de su uso. Rust, a través de su sistema de propiedad y reglas de ownership, garantiza que cada porción de memoria tenga un propietario claro y que se libere automáticamente cuando ese propietario sale del ámbito.

```rust
fn main() {
    let data = String::from("Hola, Rust!");
    // ... código que usa 'data'
} // 'data' se libera automáticamente aquí, evitando fugas de memoria
```

2. **Referencias Nulas (Null References):** En muchos lenguajes, las referencias nulas pueden provocar errores difíciles de rastrear. Rust elimina la posibilidad de referencias nulas al exigir que las referencias siempre apunten a datos válidos.

```rust
fn main() {
    let reference: &String = &String::from("¡Hola, Rust!");
    // No hay posibilidad de referencia nula aquí
}
```

3. **Accesos No Autorizados a la Memoria (Memory Unsafe Access):** Rust evita que los programas realicen accesos no autorizados a la memoria, lo que podría provocar comportamientos inesperados o vulnerabilidades de seguridad. Al garantizar que las referencias sigan reglas estrictas, Rust previene este tipo de errores.

```rust
fn main() {
    let data = vec![1, 2, 3];
    let element = &data[10]; // Esto provocará un error de tiempo de compilación, evitando acceso no autorizado.
}
```

4. **Condiciones de Carrera (Race Conditions):** Las condiciones de carrera ocurren cuando múltiples hilos acceden y modifican datos compartidos simultáneamente, lo que puede llevar a resultados inesperados. Rust aborda este problema al exigir que las referencias mutables a datos solo existan en un solo lugar a la vez, eliminando así las condiciones de carrera en tiempo de compilación.

```rust
use std::sync::{Mutex, Arc};
use std::thread;

fn main() {
    let counter = Arc::new(Mutex::new(0));

    let mut handles = vec![];

    for _ in 0..10 {
        let counter = Arc::clone(&counter);
        let handle = thread::spawn(move || {
            let mut num = counter.lock().unwrap();
            *num += 1;
        });
        handles.push(handle);
    }

    for handle in handles {
        handle.join().unwrap();
    }

    println!("Resultado final: {}", *counter.lock().unwrap());
}
```

Estos ejemplos ilustran cómo Rust aborda problemas comunes relacionados con el manejo de la memoria, asegurando un código más seguro y reduciendo la probabilidad de errores difíciles de diagnosticar en tiempo de ejecución.

### Las 3 reglas de Rust (Relgas de Ownership)

1. Cada valor tiene un dueño.
2. Puede haber sólo un dueño a la vez.
3. Cuando el dueño sale del scope, el valor se destruye.

```rust
fn main() {
    let name = "John".to_owned();

    println!("Hello {}!", name);

    println!("Hello {}!", to_upper_case(name));

    println!("Hello {}!", name);
}

fn to_upper_case(s: String) -> String {
    s.to_uppercase()
}
```

**Salida por consola**

```bash
error[E0382]: borrow of moved value: `name`
  --> src/main.rs:22:27
   |
16 |     let name = "John".to_owned();
   |         ---- move occurs because `name` has type `String`, which does not implem
ent the `Copy` trait
...
20 |     println!("Hello {}!", to_upper_case(name));
   |                                         ---- value moved here
21 |
22 |     println!("Hello {}!", name);
   |                           ^^^^ value borrowed here after move
   |
note: consider changing this parameter type in function `to_upper_case` to borrow ins
tead if owning the value isn't necessary
  --> src/main.rs:25:21
   |
25 | fn to_upper_case(s: String) -> String {
   |    -------------    ^^^^^^ this parameter takes ownership of the value
   |    |
   |    in this function
   = note: this error originates in the macro `$crate::format_args_nl` which comes fr
om the expansion of the macro `println` (in Nightly builds, run with -Z macro-backtra
ce for more info)
help: consider cloning the value if the performance cost is acceptable
   |
20 |     println!("Hello {}!", to_upper_case(name.clone()));
   |                                             ++++++++

For more information about this error, try `rustc --explain E0382`.
error: could not compile `example` (bin "example") due to previous error
```

Para entender a que se debe el error, hay que recordar las reglas de Ownership. Cuando en la linea 22, se pasa el valor de `name` a la función, se esta modificando quien es el dueño de esa variable y, al momento de que la función finaliza su ejecuión, esta sale del scope provocando que cuando se quiera volver a hacer uso de la variable, se este haciendo referencia un valor inexistente en el bloque de la memoria.

Algo a destacar, es como el compilador da una sugerencia de alternativas se tiene para solucionar este error, sin embargo, esto tiene una solución más sencilla que es pasar un puntero que haga referencia a esa posición de la memoria en lugar de pasar una referencia la variable.

Esto aunque pueda ser tedioso, nos da una visión más clara y un manejo de memoria más seguro de la memoria.

## Desventajas

A pesar de sus numerosas fortalezas, Rust también presenta algunos desafíos y limitaciones que es importante tener en cuenta:

### Curva de aprendizaje elevada

Rust es conocido por tener una curva de aprendizaje más empinada en comparación con otros lenguajes de programación. La necesidad de comprender conceptos avanzados como el sistema de propiedad y el manejo de memoria puede resultar intimidante para los principiantes. Sin embargo, es importante señalar que esta barrera inicial a menudo se traduce en una comprensión más profunda de los fundamentos de la programación.

### elativamente joven en comparación con otros lenguajes

Aunque Rust ha ganado rápidamente popularidad, es un lenguaje relativamente joven en comparación con gigantes de la industria como C++ o Java. Esto significa que puede carecer de algunas bibliotecas y marcos de trabajo maduras que se encuentran en lenguajes más establecidos. A medida que la comunidad de Rust continúa creciendo, es probable que esta limitación disminuya con el tiempo.

### Posible falta de bibliotecas para casos específicos

En algunos casos, puede encontrarse con que algunas bibliotecas especializadas aún no han sido desarrolladas para Rust. Esto podría deberse a la novedad del lenguaje o a la falta de demanda para ciertos casos de uso. Aunque la situación está mejorando constantemente con la expansión del ecosistema de Rust, es algo a considerar en proyectos específicos.

### Compilador a veces lento

El compilador de Rust es conocido por su exhaustividad y rigor en la verificación de código, lo cual es beneficioso para garantizar la seguridad y la corrección. Sin embargo, esta minuciosidad puede traducirse en tiempos de compilación más largos, especialmente en proyectos grandes. Aunque existen estrategias para mitigar esto, como el uso de compilaciones incrementales, es algo a tener en cuenta en entornos de desarrollo que requieren una respuesta rápida.

A pesar de estas desventajas, muchas de ellas pueden abordarse con el tiempo y a medida que la comunidad de Rust evoluciona, ofreciendo soluciones y herramientas adicionales. Es crucial sopesar estas limitaciones frente a las ventajas inherentes que Rust proporciona en términos de seguridad y rendimiento.

## ¿Qué se puede hacer con Rust?

Como se ha mencianado anteriormente, Rust es un lenguaje de programación _proposito general_, esto queire decir que permite el desarrollo de aplicaciones de diferentes ambitos.

### Servidores Web BackEnd

Rust permite la creación de servidores web gracias a frameworks como `actix-web` y `Rocket`.

### Videojuegos

Los videojuegos son uno de los softwares que necesitan más performance y alto rendimiento. Rust, al ser un lenguaje de tan bajo nivel se vuelve una alternativa ideal para este tipo de desarrollos. Además, a día de hoy, existen diferentes _game engines_ que permiten el desarrollo en Rust como:

- [Amethyst](https://amethyst.rs/)
- [Bevy](https://bevyengine.org/)
- [Dioxus](https://dioxuslabs.com/)

### WEB 3

Rust está siendo uno de los lenguajes favoritos para el interactuar con las diferentes blockchains. La seguridad, fiabilidad y performance son una de las características que han impulsado al lenguaje a ser uno de los más utilizados para estos propósitos.

### otros

- Web FontEnd, gracias a que compila directamente a Web Assembly
- Software embebidos
- Automatizaciones de infra (CI/CD)

## El compilador de Rust

El compilador de Rust es una de las joyas fundamentales del ecosistema de Rust. Aporta beneficios significativos tanto para desarrolladores novatos como experimentados, y su diseño se alinea estrechamente con los principios clave del lenguaje.

### Verificación de Memoria y Prevención de Errores

Uno de los aspectos más notables del compilador de Rust es su énfasis en la seguridad de memoria y la prevención de errores. A través del sistema de propiedad, el compilador verifica y hace cumplir reglas estrictas sobre cómo se asigna y libera memoria. Esto ayuda a evitar problemas comunes como fugas de memoria, referencias nulas y condiciones de carrera. Las verificaciones de tiempo de compilación, en lugar de tiempo de ejecución, brindan una capa adicional de seguridad, permitiendo a los desarrolladores atrapar errores antes de que lleguen a la producción.

```rust
fn main() {
    let mut v = vec![1, 2, 3];

    let first = &v[0];
    // immutable borrow occurs here rustc (E0502)

    v.push(4);
    // cannot borrow `v` as mutable because it is also borrowed as immutable rustc (E0502)

    println!("The first element is: {}", first);
    // immutable borrow later used here rustc (E0502)
}
```

En este ejemplo, el compilador detecta que se está tomando una referencia a un elemento de un vector mutable antes de que se realice una operación que podría invalidar esa referencia.

### Mensajes de Error Claros y Accesibles

El compilador de Rust es conocido por proporcionar mensajes de error claros y útiles. Cuando surge un problema durante la compilación, el compilador no solo informa sobre el error, sino que también ofrece sugerencias y pistas para corregirlo. Estos mensajes de error bien redactados ayudan a los desarrolladores a comprender rápidamente la naturaleza del problema y a tomar las medidas correctivas necesarias.

```rust
fn main() {
    let x: u32 = "Hola, mundo".parse().expect("No es un número válido!");
}
```

En este caso, el compilador detecta el intento de convertir una cadena en un entero sin manejar adecuadamente el resultado, y proporciona un mensaje de error descriptivo

```bash
warning: unused variable: `x`
  --> src/main.rs:57:9
   |
2  |     let x: u8 = "Hola, Rustacean".parse().expect("No es un número válido!");
   |         ^ help: if this is intentional, prefix it with an underscore: `_x`
```

### Análisis Estático Avanzado

Rust incorpora un análisis estático avanzado que permite al compilador realizar inferencias y optimizaciones complejas durante la compilación. Esto contribuye a la eficiencia del código generado y garantiza un rendimiento óptimo. Además, la capacidad del compilador para detectar patrones y optimizar el código facilita la escritura de programas eficientes sin necesidad de intervención manual extensa.

```rust
fn main() {
    let x = 5;
    let y = x + 1;
    println!("El valor de y es: {}", y);
}
```

Rust realiza análisis estático para inferir tipos y optimizar el código durante la compilación.

### Gestión de Dependencias: Cargo

El compilador de Rust trabaja en conjunto con Cargo, el sistema de gestión de paquetes y construcción de proyectos de Rust. Cargo simplifica la gestión de dependencias, la construcción y las tareas comunes del proyecto. Permite a los desarrolladores enfocarse en la lógica de su aplicación mientras se encarga de manejar la infraestructura y las dependencias de manera eficiente.

### Compilación a Diferentes Plataformas

Rust ofrece la capacidad de compilar programas para diversas plataformas de forma sencilla. Esto se traduce en una portabilidad mejorada, permitiendo a los desarrolladores crear aplicaciones que pueden ejecutarse en diferentes sistemas operativos y arquitecturas con facilidad.

### Compilación Incremental

El compilador de Rust incorpora un sistema de compilación incremental que agiliza el proceso de desarrollo. Solo se recompilan las partes modificadas del código, reduciendo significativamente los tiempos de compilación, especialmente en proyectos grandes. Esto permite a los desarrolladores realizar cambios y ver resultados rápidamente, mejorando la eficiencia en el ciclo de desarrollo.

### Fomento de Buenas Prácticas de Programación

Al exigir la adherencia a las reglas del sistema de propiedad y al proporcionar mensajes de error detallados, el compilador de Rust fomenta buenas prácticas de programación. Los desarrolladores se benefician al escribir código más robusto y seguro, contribuyendo a un software de alta calidad desde el principio.

```rust
fn main() {
    let mut data = String::from("¡Hola, Rust!");
    let referencia = &data;
    println!("{}", referencia);
}
```

```bash
warning: variable does not need to be mutable
  --> src/main.rs:61:9
   |
2  |     let mut data = String::from("¡Hola, Rust!");
   |         ----^^^^
   |         |
   |         help: remove this `mut`
   |
```

En resumen, el compilador de Rust no solo traduce el código fuente a ejecutable, sino que también actúa como un aliado valioso para los desarrolladores, brindando seguridad, claridad y eficiencia a lo largo de todo el ciclo de desarrollo de software.

## Un pequeño ejemplo

En general, cuando se quiera general una nueva aplicación con Rust, se utilizará Cargo para poder crearlo. Para lo cúal se provee una instrucción `cargo new` que permite realizar dicha operatoria.

```bash
$ cargo new app-example
```

Con la anterior instrucción se generará un proyecto con la siguiente estructura:

```bash
app-example
├── Cargo.lock
├── Cargo.toml
├── src
│   └── main.rs
└── .gitignore
```

Para poder ejecuarlo, se cuenta con la instrucción `cargo run`:

```bash
$ cargo run
```

A lo cúal se veria el siguiente resultado:

```bash
$ cargo run
   Compiling hello-rust v0.1.0 (/Users/ag_dubs/rust/hello-rust)
    Finished dev [unoptimized + debuginfo] target(s) in 1.34s
     Running `target/debug/hello-rust`
Hello, world!
```

### Ejemplo de una pequeña aplicación:

```rust
use ferris_says::say; // from the previous step
use std::io::{stdout, BufWriter};

fn main() {
    let stdout = stdout();
    let message = String::from("Hello fellow Rustaceans!");
    let width = message.chars().count();

    let mut writer = BufWriter::new(stdout.lock());
    say(&message, width, &mut writer).unwrap();
}
```

salida:

```bash
 __________________________
< Hello fellow Rustaceans! >
 --------------------------
        \
         \
            _~^~^~_
        \) /  o o  \ (/
          '_   -   _'
          / '-----' \
```

### Herramientas del ecosistema Rust

- [Cargo](https://doc.rust-lang.org/cargo/)
- [Rustup](https://rustup.rs/)
- [Rust Analyzer](https://rust-analyzer.github.io/)
- [rust-doc](https://doc.rust-lang.org/)
- [RustFmt](https://github.com/rust-lang-nursery/rustfmt)
- [Clippy](https://github.com/rust-lang/rust-clippy)

## Conclusión

En resumen, el ecosistema de Rust se beneficia enormemente del excepcional rendimiento y las características avanzadas de su compilador. Este componente central va más allá de la simple traducción de código fuente a ejecutable, actuando como un aliado inteligente para los desarrolladores. Algunos puntos clave resaltan su importancia:

- Seguridad y Prevención de Errores: El sistema de propiedad y las verificaciones de memoria en tiempo de compilación garantizan una mayor seguridad y prevención de errores, permitiendo a los desarrolladores escribir código robusto desde el principio.

- Mensajes de Error Claros: Los mensajes de error detallados y claros proporcionados por el compilador facilitan la identificación y corrección de problemas, acelerando el proceso de desarrollo y aprendizaje.

- Análisis Estático y Optimizaciones: El análisis estático avanzado y las optimizaciones inteligentes realizadas por el compilador contribuyen a la eficiencia del código generado, mejorando el rendimiento de las aplicaciones Rust.

- Gestión de Dependencias Eficiente: Cargo, el sistema de gestión de paquetes, simplifica la gestión de dependencias, asegurando que los desarrolladores puedan centrarse en la lógica de su aplicación sin preocuparse por detalles logísticos.

- Compilación para Diferentes Plataformas: La capacidad de compilar para diversas plataformas permite la portabilidad de las aplicaciones, brindando flexibilidad a los desarrolladores para desplegar sus soluciones en una variedad de entornos.

- Compilación Incremental: La compilación incremental agiliza el proceso de desarrollo, permitiendo a los desarrolladores ver rápidamente los resultados de sus cambios sin tener que recompilar todo el proyecto.

- Fomento de Buenas Prácticas: Al exigir el cumplimiento de las reglas del sistema de propiedad, el compilador de Rust fomenta buenas prácticas de programación, contribuyendo a la creación de software más seguro y confiable.

En conjunto, el compilador de Rust no solo facilita el desarrollo de software de alta calidad, sino que también educa y guía a los desarrolladores hacia mejores prácticas, fortaleciendo la base de un lenguaje que ha ganado reconocimiento por su eficiencia, seguridad y rendimiento. Con su continua evolución respaldada por la activa comunidad de Rust, este compilador sigue siendo un pilar esencial en la experiencia de desarrollo con Rust.
