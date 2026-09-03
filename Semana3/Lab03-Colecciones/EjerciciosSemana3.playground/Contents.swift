// Desarrollado por: [Sebastian Salas]
import Foundation
// ===== TODO 1: Registro de 5 alumnos =====
var alumnos: [String] = []
for i in 1...5 {
    print("Nombre del alumno \(i):")
    // Limpiamos espacios innecesarios
    let nombre = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    alumnos.append(nombre.isEmpty ? "Alumno \(i)" : nombre)
}
print("\nAlumnos registrados: \(alumnos)\n")
// ===== TODO 2: Buscar un alumno =====
print("Ingrese el nombre del alumno a buscar:")
let buscar = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
if alumnos.contains(buscar) {
    print("-> \(buscar) está en la lista.\n")
} else {
    print("-> \(buscar) NO está en la lista.\n")
}
// ===== TODO 3: Notas con clasificación (Asociadas al alumno) =====
var notasClase: [Double] = []
// Usamos el total de alumnos en lugar de un número fijo
for alumno in alumnos {
    print("Nota para \(alumno):")
    let n = Double(readLine() ?? "") ?? 0.0
    notasClase.append(n)
}
var aprobados = 0
var desaprobados = 0
for nota in notasClase {
    if nota >= 13.0 { // Nota mínima aprobatoria (común en Perú)
        aprobados += 1
    } else {
        desaprobados += 1
    }
}
// Suma elegante usando reduce
let sumaNotas = notasClase.reduce(0, +)
let promedio = notasClase.isEmpty ? 0.0 : (sumaNotas / Double(notasClase.count))
print("\n--- RESULTADOS FINALES ---")
print("Promedio de la clase: \(String(format: "%.2f", promedio))")
print("Alumnos Aprobados: \(aprobados)")
print("Alumnos Desaprobados: \(desaprobados)")
// ===== FIX: 3 errores CORREGIDOS =====
// FIX 1: Cambiado el 7 entero por un String "Uva" (o "7")
var frutas = ["Manzana", "Plátano", "Naranja"]
frutas.append("Uva")
// FIX 2: Cambiado 'let' por 'var' para que el array sea modificable
var colores = ["Rojo", "Azul", "Verde"]
colores.append("Amarillo")
// FIX 3: Cambiado el índice 5 por el 4 para acceder al último número (50)
let numeros = [10, 20, 30, 40, 50]
print(numeros[4])
var lista = [1, 2, 3, 4, 5]
lista.remove(at: 0)
lista.append(6)
print(lista)         // Resultado: [2, 3, 4, 5, 6]
print(lista.count)   // Resultado: 5
var nombres = ["Ana", "Carlos", "Beto"]
print(nombres.sorted()) // Resultado: ["Ana", "Beto", "Carlos"]
print(nombres)          // Resultado: ["Ana", "Carlos", "Beto"]

// ===== TODO 4: Catálogo de productos =====
var productos: [String: Double] = [:]
for i in 1...4 {
    print("Producto \(i) - Nombre:")
    let nombre = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    
    // Si el nombre está vacío, le asignamos uno por defecto para evitar errores
    let nombreValido = nombre.isEmpty ? "Producto \(i)" : nombre
    
    print("Precio:")
    let precio = Double(readLine() ?? "") ?? 0.0
    
    productos[nombreValido] = precio
}
// ===== TODO 5: Mostrar catálogo =====
print("\n===== CATÁLOGO =====")
// Nota: Saldrán en orden aleatorio, es el comportamiento normal de un diccionario
for (nombre, precio) in productos {
    print("• \(nombre): S/. \(String(format: "%.2f", precio))")
}
// ===== TODO 6: Valor total =====
// Optimizamos usando .values y .reduce para sumar todo directamente
let valorTotal = productos.values.reduce(0, +)
print("\nValor total del catálogo: S/. \(String(format: "%.2f", valorTotal))\n")
// ===== TODO 7: Buscar producto =====
print("Ingrese el producto a buscar:")
let buscarProd = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
if let precioEncontrado = productos[buscarProd] {
    print("-> \(buscarProd) cuesta S/. \(String(format: "%.2f", precioEncontrado))")
} else {
    print("-> El producto '\(buscarProd)' no fue encontrado.")
}
// Diccionario inicial con nombres y edades
var edades: [String: Int] = ["Ana": 20, "Luis": 22, "María": 19]
// Lista vacía para guardar a los que cumplan la condición
var mayores: [String] = []
// Recorremos el diccionario revisando cada nombre y edad
for (nombre, edad) in edades {
    if edad >= 21 {
        mayores.append(nombre) // Si tiene 21 o más, guardamos su nombre
    }
}
// Imprime el resultado en pantalla: Mayores de 21: ["Luis"]
print("Mayores de 21: \(mayores)")
