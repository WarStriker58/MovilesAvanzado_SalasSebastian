# Prompts — Lab 03
## Docente: Juan Leon — Tecsup
## Herramienta: ChatGPT

## Ejercicio 6 — Gestión de notas
### Prompt (CTRFE):

* **CONTEXTO:** Estudiante de desarrollo iOS en Tecsup (Semana 3). Estoy aprendiendo el uso de colecciones básicas en Swift como diccionarios, arreglos, ciclos e impresión formateada en consola.
* **TAREA:** Crear un programa en Swift que gestione las notas de N alumnos. Debe solicitar el nombre y 3 calificaciones por alumno, guardarlos en un diccionario `[String: [Double]]`, calcular el promedio individual, clasificarlos mediante un `switch` (Excelente, Bueno, Aprobado, Desaprobado), mostrar estadísticas generales (promedio del aula, nota más alta, nota más baja, % de aprobados) y listar a los alumnos ordenados por promedio.
* **RESTRICCIONES:** Solo utilizar conceptos cubiertos de la semana 1 a la 3. **NO utilizar estructuras (`struct`) ni clases (`class`)**. Usar diccionarios, tuplas o arreglos paralelos para el ordenamiento.
* **FORMATO:** Código fuente de Swift documentado de forma segura y clara.
* **EJEMPLO DE SALIDA:** Un reporte limpio en consola, con separadores estéticos (`===`) y números formateados a dos decimales.

---

## Ejercicio 7 — Inventario con menú
### Prompt (CTRFE):

* **CONTEXTO:** Estudiante de desarrollo móvil iOS en Tecsup.
* **TAREA:** Implementar un sistema de gestión de inventario en Swift que reciba N productos (nombre, precio, stock) y exponga un menú interactivo continuo usando un ciclo `while`. Las opciones del menú deben ser: 1) Ver inventario completo, 2) Buscar por nombre, 3) Alerta de Stock bajo (< 5 unidades), 4) Calcular Valor total del inventario y 5) Salir del programa.
* **RESTRICCIONES:** No utilizar conceptos avanzados ni persistencia de datos externa. Evitar comentarios excesivamente largos en la misma línea del código para prevenir errores de parsing del compilador.
* **FORMATO:** Tablas y reportes alineados limpiamente en consola usando cadenas de formato (`String(format:)`).
