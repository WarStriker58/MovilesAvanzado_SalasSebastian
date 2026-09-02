# Prompts utilizados — Laboratorio 02

## Herramienta de IA utilizada
ChatGPT

## Ejercicio 6 — Carrito mejorado
### Prompt (estructura CTRFE):
* **CONTEXTO:** Archivo Playground de Swift en Xcode (rama de desarrollo).
* **TAREA:** Mejorar un carrito de compras agregando: descuento por cantidad (5% extra si cant >= 3), cupón "DESCUENTO20" (20% adicional en cascada), envío gratis si el total supera S/. 3000 (sino S/. 25.00), puntos de fidelidad (1 por cada S/. 100) y validación de precios negativos o cantidades en cero.
* **RESTRICCIONES:** Cada línea debe incluir un comentario específico explicando su función en el negocio. No usar comentarios genéricos. Toda la lógica debe ir dentro del bloque de validación.
* **FORMATO:** Código Swift listo para ejecutar en Playgrounds.
* **EJEMPLO:** `let sub1 = (precio1 * Double(cant1)) * (cant1 >= 3 ? 0.95 : 1.0) // Calcula subtotal aplicando descuento por cantidad`

### ¿Funcionó a la primera?
No. Los comentarios extensos en la validación inicial rompieron la sintaxis de Swift al dividirse en varias líneas físicas en Xcode. Se corrigieron los saltos de línea y un factor de descuento erróneo.

### ¿La IA usó algo que no conocías?
Sí, operadores ternarios inline `(condición ? verdadero : falso)` para reducir código. Investigué que simplifican la asignación de valores sin usar bloques `if-else` largos.

---

## Ejercicio 7 — Juego de adivinanza
### Prompt (estructura CTRFE):
* **CONTEXTO:** Proyecto Playground en Xcode.
* **TAREA:** Generar un mini juego de adivinanza de números.
* **RESTRICCIONES:** Número secreto fijo (42), simular 5 intentos con variables (`intento1 = 20`, etc.), usar obligatoriamente un bucle `while`, mostrar mensajes de "Muy alto", "Muy bajo" o "¡Correcto!", contar los intentos y mostrar un mensaje de derrota si falla todos. Cada línea debe estar comentada explicando la comparación matemática.
* **FORMATO:** Código Swift continuo, sin bloques `do {}`.
* **EJEMPLO:** `if intentoActual == numeroSecreto { // Compara si el intento es igual al número secreto`

### ¿Funcionó a la primera?
Sí. El bucle `while` y la bandera booleana funcionaron correctamente, deteniendo el ciclo al encontrar el número.

### ¿La IA usó algo que no conocías?
Sí, empaquetar variables independientes en un arreglo dinámico para recorrerlas con `while` usando índices. Investigué la lectura indexada en colecciones de Swift.
