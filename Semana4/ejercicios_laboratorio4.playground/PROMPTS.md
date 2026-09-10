# Prompts utilizados — Laboratorio 04

## Herramienta de IA utilizada
ChatGPT

## Caso 2B — Biblioteca

### Prompt 1:
Mejora este código de Swift correspondiente al Caso 2 - Parte A: Biblioteca. Conserva estrictamente las mismas firmas de funciones, structs y enums. Además, agrega un comentario explicativo profundo e inteligente en CADA línea detallando qué hace a nivel técnico y qué pasa con la memoria de Swift, asegurando que la salida sea idéntica a la de la Parte A. El código es: [Aquí se pegó el código original de la Parte A]

### Respuesta de la IA:
La IA inicialmente propuso una versión optimizada utilizando funciones avanzadas como `.firstIndex(where:)`, closures condensados (`$0`) y desempaquetado de opcionales con `if let`. Después de pedirle una corrección, generó el código respetando la estructura tradicional exacta del Caso A (bucles por índice y switch básico) pero incluyendo explicaciones detalladas línea por línea sobre el comportamiento de tipos de valor (`struct` y `enum`) y tipos de referencia (`class`).

### ¿Funcionó a la primera?
No. Inicialmente me devolvió sintaxis avanzada que no correspondía al nivel actual del curso. Tuvimos que hacer un ajuste.

### ¿Usó algo que no hemos visto en clase?
Sí. Utilizó `.firstIndex(where:)` y closures con `$0`. Le pedí explícitamente que lo reescribiera manteniendo mi bucle por índice tradicional `for i in 0..<libros.count` y el `switch` que yo había diseñado originalmente.

## Mi versión (Parte A) vs. la versión de la IA (Parte B)

### ¿Qué hizo distinto la IA respecto a mi solución?
La lógica algorítmica y la estructura del código terminaron siendo idénticas a mi solución. La gran diferencia radica en la documentación: la IA expandió el propósito de cada línea explicando por qué mutar un struct requiere acceder directamente a su posición en el array y cómo se comporta el paso por valor en Swift.

### ¿Hay alguna línea de la IA que no entiendo del todo? ¿Cuál?
Ninguna. Al obligar a la IA a regresar a la estructura de la Parte A, todas las líneas de código me resultan familiares y entiendo perfectamente su funcionamiento (bucles, condicionales y switches).

### ¿Qué me pareció mejor de MI versión?
Que es directa, utiliza las herramientas de control de flujo que ya domino perfectamente a estas alturas del ciclo y no añade complejidad innecesaria para resolver el problema propuesto.

### ¿Qué me pareció mejor de la versión de la IA?
La calidad técnica de los comentarios. Me ayudó a comprender mejor la teoría detrás del código, como el hecho de por qué no necesitamos usar la palabra clave `mutating` en las funciones de la clase, o cómo el compilador asegura de forma obligatoria que el `switch` de un enum sea exhaustivo.
