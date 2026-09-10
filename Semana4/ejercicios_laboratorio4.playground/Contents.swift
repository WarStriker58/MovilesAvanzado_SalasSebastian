// ===== CASO 2 — PARTE B: BIBLIOTECA (CON IA) =====
// Docente: Juan León
// TODO 20: código fiel a la Parte A, comentado exhaustivamente línea por línea 

import Foundation // Importa el entorno base necesario para ejecutar el código y manejar los flujos de impresión 

enum EstadoLibro { // Define un tipo de datos enumerado para restringir de forma segura los estados posibles de un libro
case disponible // Opción del enum que representa de manera explícita que el libro está libre para préstamos
case prestado // Opción del enum que indica que el libro se encuentra bajo custodia de un lector externo
} // Usar un enum evita errores humanos de escritura en comparación con usar cadenas de texto comunes ("disponible") 

struct Libro { // Estructura que define el modelo de datos de un libro como un tipo de valor puro en Swift
let titulo: String // Constante inmutable: el título no puede ser modificado una vez creado el libro para proteger el dato
let autor: String // Constante inmutable: el autor queda fijo de por vida en la estructura garantizando consistencia
var estado: EstadoLibro = .disponible // Propiedad mutable que almacena el estado y se inicializa por defecto en disponible
} // Los structs se copian por valor en Swift, lo que significa que heredarán un comportamiento inmutable por defecto 

class Biblioteca { // Declara una clase para gestionar el inventario; al ser tipo de referencia, el estado persiste y se comparte
var libros: [Libro] = [] // Arreglo mutable de estructuras 'Libro' que actúa como la base de datos central de la biblioteca 

func agregar(libro: Libro) { // Método para añadir elementos; recibe una copia inmutable del struct debido al paso por valor
libros.append(libro) // Agrega el elemento al final del array, alterando la propiedad interna de la instancia de la clase
} // Al estar dentro de una clase, no requiere la palabra clave 'mutating' para alterar sus propiedades internas

@discardableResult // Le indica al compilador de Swift que ignore la advertencia si el código que llama no guarda el Bool devuelto
func prestar(titulo: String) -> Bool { // Método para procesar un préstamo; busca por título y devuelve éxito (true) o fallo (false)
for i in 0..<libros.count { // Bucle clásico por índice que recorre de forma secuencial cada posición válida del arreglo
if libros[i].titulo == titulo { // Compara la propiedad del struct almacenado en el índice 'i' con el parámetro buscado
if libros[i].estado == .disponible { // Verifica directamente en el array si el libro actual se encuentra libre para préstamo
libros[i].estado = .prestado // Modifica el struct DENTRO del array (una copia local en una variable no alteraría el inventario)
print("Préstamo aprobado: (titulo)") // Imprime en consola la confirmación exacta del éxito de la transacción
return true // Interrumpe el bucle inmediatamente y sale de la función devolviendo verdadero al flujo principal
} else { // Bloque de control que se activa si el título coincide pero no cumple la condición de disponibilidad
print("Error: (titulo) ya está prestado") // Informa en la salida estándar que el libro está ocupado actualmente
return false // Detiene la ejecución retornando falso para reportar el fallo del proceso de préstamo
} // Cierre de la validación del estado interno del libro
} // Cierre de la comprobación de igualdad de títulos
} // Cierre del bucle for que examina la colección entera de libros
print("Error: no existe (titulo)") // Línea a la que solo se llega si el bucle terminó por completo sin encontrar coincidencias
return false // Retorna falso para avisar formalmente que el libro solicitado no pertenece al catálogo
} // Cierre del método prestar

@discardableResult // Suprime avisos del compilador permitiendo invocar la función de forma directa en la sección de simulación
func devolver(titulo: String) -> Bool { // Método para retornar libros; implementa la lógica secuencial inversa al préstamo
for i in 0..<libros.count { // Recorre el arreglo mediante índices numéricos enteros comenzando desde la posición cero
if libros[i].titulo == titulo { // Evalúa si el título del elemento en el índice actual coincide con el argumento enviado
if libros[i].estado == .prestado { // Chequea directamente en el contenedor si el libro está marcado como prestado
libros[i].estado = .disponible // Sobrescribe el valor del enum en el índice exacto del array para habilitarlo de nuevo
print("Devolución registrada: (titulo)") // Envía a la consola la notificación de reingreso exitoso al sistema
return true // Finaliza la función de inmediato retornando un indicador de éxito al invocador
} else { // Bloque alternativo si el libro está en el catálogo pero presenta un estado contradictorio
print("Error: (titulo) ya está disponible") // Notifica el error de lógica en la consola al intentar devolver algo no prestado
return false // Cancela la operación devolviendo falso para asegurar la integridad de los datos
} // Cierre del condicional del estado del libro encontrado
} // Cierre de la comparación del título del libro
} // Cierre del ciclo de inspección secuencial del array
print("Error: no existe (titulo)") // Sentencia ejecutada si el ciclo for se agota sin hallar el título especificado
return false // Devuelve falso indicando que la devolución fracasó porque el libro no existe en los registros
} // Cierre del método devolver

func inventario() { // Método de reporte encargado de recorrer el catálogo y formatear el estado actual de cada libro
print("===== INVENTARIO =====") // Imprime una línea estética de cabecera para organizar visualmente el reporte en consola
for libro in libros { // Itera sobre la colección; en cada ciclo 'libro' es una copia temporal e inmutable del struct actual
switch libro.estado { // Evalúa de forma exhaustiva el enum del libro para decidir qué bifurcación de impresión ejecutar
case .disponible: // Caso del switch que atrapa el flujo si la propiedad enum equivale al estado disponible
print("(libro.titulo) ((libro.autor)) - disponible") // Imprime los datos formateados del libro confirmando su presencia
case .prestado: // Caso del switch que captura el flujo si la propiedad enum corresponde al estado prestado
print("(libro.titulo) ((libro.autor)) - prestado") // Imprime los datos del libro advirtiendo su ausencia temporal
} // Cierre del bloque de control switch (en Swift es obligatorio que cubra todos los casos posibles del enum)
} // Cierre del bucle for in que lee los elementos uno a uno
} // Cierre del método inventario

} // Cierre definitivo de la estructura de la clase Biblioteca 

// Simulación pura y directa sin asignaciones basura (_ =)
let miBiblioteca = Biblioteca() // Crea el objeto centralizado guardándolo en una constante que protege la referencia en memoria 

miBiblioteca.agregar(libro: Libro(titulo: "Cien años de soledad", autor: "Gabriel García Márquez")) // Inserta el primer libro inicializando el catálogo
miBiblioteca.agregar(libro: Libro(titulo: "La ciudad y los perros", autor: "Mario Vargas Llosa")) // Inserta el segundo libro expandiendo el arreglo de datos
miBiblioteca.agregar(libro: Libro(titulo: "El Quijote", autor: "Miguel de Cervantes")) // Añade el tercer registro poblando los datos iniciales de prueba 

miBiblioteca.prestar(titulo: "La ciudad y los perros") // Altera el estado del libro de forma exitosa imprimiendo la confirmación
miBiblioteca.prestar(titulo: "La ciudad y los perros") // Intenta repetir la acción forzando la impresión del error controlado de ya prestado
miBiblioteca.devolver(titulo: "La ciudad y los perros") // Restablece el estado del libro a disponible sin alterar el resto de elementos
miBiblioteca.prestar(titulo: "El Quijote") // Transfiere el estado del tercer libro a prestado modificando la memoria del array
miBiblioteca.prestar(titulo: "El Principito") // Busca un libro que no existe disparando la última alerta de error de la simulación 

miBiblioteca.inventario() // Invoca el reporte final consolidado para verificar visualmente que las mutaciones coincidan con el Caso A
