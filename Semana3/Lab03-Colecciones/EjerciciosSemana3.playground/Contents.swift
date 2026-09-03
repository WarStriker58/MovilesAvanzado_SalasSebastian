// Desarrollado por: SEBASTIAN SALAS
import Foundation // Importa la librería base para entrada/salida y funciones matemáticas

// ===== EJERCICIO 6: GESTIÓN DE NOTAS =====
var registroAlumnos: [String: [Double]] = [:] // Crea el diccionario para almacenar el nombre como clave y sus 3 notas como arreglo

print("¿Cuántos alumnos desea registrar?") // Imprime en consola la pregunta inicial para el usuario
let totalAlumnos = Int(readLine() ?? "") ?? 0 // Lee la entrada de la consola, la convierte a entero o asigna 0 por defecto

if totalAlumnos > 0 { // Valida que el número de alumnos ingresado sea mayor a cero para iniciar el ciclo
    for i in 1...totalAlumnos { // Inicia un bucle que se repetirá la cantidad de veces equivalente al total de alumnos
        print("\nAlumno \(i) - Nombre:") // Solicita en la terminal el nombre del alumno actual usando interpolación
        let nombre = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines) // Lee el nombre y elimina espacios vacíos accidentales
        
        var notasAlumno: [Double] = [] // Inicializa un arreglo temporal vacío para guardar las 3 notas del alumno actual
        for j in 1...3 { // Abre un sub-bucle interno que se ejecutará exactamente 3 veces (una por cada nota requerida)
            print("Ingrese Nota \(j):") // Solicita en pantalla el ingreso de la nota correspondiente de manera correlativa
            let nota = Double(readLine() ?? "") ?? 0.0 // Captura la entrada de la terminal y la transforma a tipo decimal
            notasAlumno.append(nota) // Agrega la nota decimal validada al final de la lista temporal de notas
        } // Cierra el ciclo interno de captura de notas de este alumno en particular
        
        registroAlumnos[nombre] = notasAlumno // Guarda en el diccionario global el nombre del alumno asociado a su arreglo de notas
    } // Finaliza el bucle principal de registro de datos de alumnos
} // Cierra la estructura condicional de validación inicial de cantidad de alumnos

// ===== PROCESAMIENTO Y ESTADÍSTICAS =====
var sumaPromediosGenerales = 0.0 // Declara una variable acumuladora para sumar todos los promedios y obtener la media global
var notaMasAlta = 0.0 // Inicializa la variable de control para identificar la nota máxima histórica con el valor más bajo posible
var notaMasBaja = 20.0 // Inicializa la variable de control para identificar la nota mínima histórica con el valor máximo estándar
var cantidadAprobados = 0 // Establece un contador entero para registrar cuántos alumnos consiguen una nota aprobatoria

struct ReporteAlumno { // Define una estructura personalizada para empaquetar de forma ordenada los datos procesados del alumno
    let nombre: String // Propiedad que almacenará el nombre completo del alumno evaluado
    let promedio: Double // Propiedad que almacenará el promedio final calculado del alumno
    let clasificacion: String // Propiedad que guardará la categoría cualitativa obtenida según su desempeño
} // Cierra la definición de la estructura auxiliar

var listaReporte: [ReporteAlumno] = [] // Crea un arreglo vacío que contendrá los reportes estructurados de cada uno de los alumnos

for (nombre, notas) in registroAlumnos { // Recorre el diccionario obteniendo en cada iteración el nombre y su arreglo de notas
    let sumaNotas = notas.reduce(0.0, +) // Suma de forma compacta todos los elementos numéricos contenidos en el arreglo de notas
    let promedio = sumaNotas / Double(notas.count) // Calcula el promedio dividiendo la suma total entre la cantidad de notas registradas
    sumaPromediosGenerales += promedio // Acumula el promedio de este alumno en la variable global para el cálculo estadístico posterior
    
    for nota in notas { // Inicia un recorrido individual por cada una de las tres notas registradas del alumno
        if nota > notaMasAlta { notaMasAlta = nota } // Si la nota actual es mayor que el registro histórico, actualiza el valor máximo
        if nota < notaMasBaja { notaMasBaja = nota } // Si la nota actual es menor que el registro histórico, actualiza el valor mínimo de forma correcta
    } // Finaliza el análisis individual de notas para máximos y mínimos
    
    var clasificacion = "" // Declara una variable de texto local para almacenar la categoría cualitativa del alumno
    switch promedio { // Evalúa el valor del promedio obtenido para asignarle una escala de rendimiento
    case 17.0...20.0: // Define el rango de notas excepcionales que van desde el diecisiete hasta el veinte
        clasificacion = "Excelente" // Asigna la categoría de Excelente al alumno que se encuentre en este rango
    case 14.0..<17.0: // Define el rango de notas buenas que van desde catorce hasta menos de diecisiete
        clasificacion = "Bueno" // Asigna la categoría de Bueno al estudiante clasificado en este intervalo
    case 11.0..<14.0: // Define el rango aprobatorio básico que va desde el once hasta menos del catorce
        clasificacion = "Aprobado" // Asigna la etiqueta cualitativa de Aprobado al estudiante en este segmento
    default: // Captura por descarte cualquier promedio que se encuentre por debajo del valor once
        clasificacion = "Desaprobado" // Asigna la condición de Desaprobado al alumno que no alcanzó la nota mínima
    } // Concluye la estructura de control switch para la categorización del rendimiento escolar
    
    if promedio >= 11.0 { // Evalúa si el promedio final del alumno cumple con la condición de aprobación institucional
        cantidadAprobados += 1 // Incrementa en una unidad el contador general de alumnos aprobados del aula
    } // Cierra la condición de verificación de aprobación del alumno
    
    let nuevoReporte = ReporteAlumno(nombre: nombre, promedio: promedio, clasificacion: clasificacion) // Instancia el reporte empaquetado
    listaReporte.append(nuevoReporte) // Agrega el objeto de reporte recién construido al arreglo general de reportes
} // Finaliza el bucle general de procesamiento de datos del diccionario

// ===== ORDENAMIENTO POR PROMEDIO =====
let listaOrdenada = listaReporte.sorted(by: { $0.promedio > $1.promedio }) // Ordena el arreglo de mayor a menor según el promedio

// ===== IMPRESIÓN DE RESULTADOS =====
print("\n=============================================") // Imprime una línea estética divisoria para la presentación del reporte
print("           REPORTE DE ALUMNOS                ") // Muestra el encabezado principal del bloque de resultados en la consola
print("=============================================") // Imprime otra barra de separación para delimitar los datos de la cabecera

for alumno in listaOrdenada { // Inicia el recorrido ordenado de los alumnos para mostrar sus datos individuales en pantalla
    let promStr = String(format: "%.2f", alumno.promedio) // Convierte el promedio decimal a un texto formateado con dos decimales exactos
    print("- \(alumno.nombre) | Promedio: \(promStr) | Categoría: \(alumno.clasificacion)") // Imprime la fila con la información resumida
} // Termina el ciclo de impresión de los resultados de los estudiantes evaluados

print("=============================================") // Imprime una línea divisoria antes del bloque de estadísticas generales
print("               ESTADÍSTICAS                  ") // Muestra el título correspondiente a la sección de analítica global del aula
print("=============================================") // Coloca un separador para dar orden visual al bloque estadístico final

if !registroAlumnos.isEmpty { // Verifica que existan datos registrados para prevenir divisiones matemáticas entre cero
    let promedioGeneralAula = sumaPromediosGenerales / Double(registroAlumnos.count) // Calcula la media aritmética del salón entero
    let porcentajeAprobados = (Double(cantidadAprobados) / Double(registroAlumnos.count)) * 100.0 // Determina el porcentaje de aprobación
    
    print("Promedio General del Aula: \(String(format: "%.2f", promedioGeneralAula))") // Muestra el promedio total de la clase formateado
    print("Nota más Alta registrada: \(String(format: "%.2f", notaMasAlta))") // Muestra en consola la calificación más alta del periodo
    print("Nota más Baja registrada: \(String(format: "%.2f", notaMasBaja))") // Muestra en la pantalla la calificación mínima recolectada
    print("Porcentaje de Aprobados  : \(String(format: "%.1f", porcentajeAprobados))%") // Expresa el porcentaje de éxito con un solo decimal
} else { // Determina la ruta alternativa en caso de que el usuario no haya ingresado ningún dato inicial
    print("No se registraron datos para calcular estadísticas.") // Advierte en la terminal la ausencia de registros de alumnos
} // Cierra la llave de validación de seguridad de cálculo estadístico
print("=============================================") // Imprime la línea de cierre final que concluye el ticket del ejercicio



// ===== EJERCICIO 7: INVENTARIO CON MENÚ =====
// Diccionarios globales para almacenar los datos
var inventarioPrecios: [String: Double] = [:]
var inventarioStocks: [String: Int] = [:]

// Registro inicial de productos
print("¿Cuántos productos desea registrar?")
let totalProductos = Int(readLine() ?? "") ?? 0

if totalProductos > 0 {
    for i in 1...totalProductos {
        print("\nProducto \(i) - Nombre:")
        let nombre = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("Precio unitario:")
        let precio = Double(readLine() ?? "") ?? 0.0
        
        print("Stock inicial:")
        let stock = Int(readLine() ?? "") ?? 0
        
        // Guardar datos usando el nombre como clave
        inventarioPrecios[nombre] = precio
        inventarioStocks[nombre] = stock
    }
}

// Bucle interactivo del menú principal
var ejecutarMenu = true
while ejecutarMenu {
    print("\n=============================================")
    print("             MENÚ DE INVENTARIO              ")
    print("=============================================")
    print("1) Ver inventario completo")
    print("2) Buscar producto por nombre")
    print("3) Alerta de Stock Bajo (< 5 unidades)")
    print("4) Calcular Valor Total del Inventario")
    print("5) Salir del programa")
    print("=============================================")
    print("Seleccione una opción (1-5):")
    
    let opcionStr = readLine() ?? ""
    print("") // Salto de línea estético
    
    switch opcionStr {
    case "1":
        // Opción 1: Reporte formateado en columnas estables
        print("============== INVENTARIO ACTUAL ==============")
        if inventarioPrecios.isEmpty {
            print("El inventario se encuentra vacío.")
        } else {
            // Formateo de columnas: 20 caracteres para nombre, 12 para precio
            print(String(format: "%-20@ | %-12@ | %-8@", "Producto", "Precio", "Stock"))
            print("-----------------------------------------------")
            for (nombre, precio) in inventarioPrecios {
                let stock = inventarioStocks[nombre] ?? 0
                let precioStr = String(format: "S/. %.2f", precio)
                print(String(format: "%-20@ | %-12@ | %-8d", nombre, precioStr, stock))
            }
        }
        print("===============================================")
        
    case "2":
        // Opción 2: Buscar producto por clave exacta
        print("Ingrese el nombre del producto a buscar:")
        let buscarNombre = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let precio = inventarioPrecios[buscarNombre] {
            let stock = inventarioStocks[buscarNombre] ?? 0
            print("\n🔍 ¡Producto encontrado!")
            print("- Nombre: \(buscarNombre)")
            print("- Precio: S/. \(String(format: "%.2f", precio))")
            print("- Stock : \(stock) unidades")
        } else {
            print("❌ El producto '\(buscarNombre)' no está registrado.")
        }
        
    case "3":
        // Opción 3: Filtrar productos con existencias críticas
        print("=========== ALERTA DE STOCK BAJO ===========")
        var contadorBajo = 0
        for (nombre, stock) in inventarioStocks {
            if stock < 5 {
                let precio = inventarioPrecios[nombre] ?? 0.0
                print("⚠️ \(nombre) -> Quedan \(stock) u. (S/. \(String(format: "%.2f", precio)))")
                contadorBajo += 1
            }
        }
        if contadorBajo == 0 {
            print("✅ Todo en orden. No hay productos con stock menor a 5.")
        }
        print("============================================")
        
    case "4":
        // Opción 4: Sumatoria financiera (Precio * Stock)
        print("========= VALOR TOTAL DE ACTIVOS =========")
        var valorTotalAlmacen = 0.0
        for (nombre, precio) in inventarioPrecios {
            let stock = inventarioStocks[nombre] ?? 0
            valorTotalAlmacen += precio * Double(stock)
        }
        print("Valor monetario total: S/. \(String(format: "%.2f", valorTotalAlmacen))")
        print("==========================================")
        
    case "5":
        // Opción 5: Romper la condición del bucle while
        print("Saliendo del sistema de gestión... ¡Hasta luego!")
        ejecutarMenu = false
        
    default:
        // Manejo de opciones erróneas de teclado
        print("❌ Opción inválida. Digite un número válido del 1 al 5.")
    }
}
