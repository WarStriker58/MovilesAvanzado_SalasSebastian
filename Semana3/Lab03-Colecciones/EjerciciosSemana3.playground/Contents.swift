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

// ===== TODO 10: Inventario de productos =====
// Pide N productos con nombre, precio y stock
// Calcula valor total y muestra stock bajo
var precios: [String: Double] = [:]
var stocks: [String: Int] = [:]

print("¿Cuántos productos?")
let n = Int(readLine() ?? "") ?? 0

// Evita que el programa falle si el usuario ingresa 0 o un número negativo
if n > 0 {
    for i in 1...n {
        print("\nProducto \(i) - Nombre:")
        let nombre = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("Precio:")
        let precio = Double(readLine() ?? "") ?? 0.0
        
        print("Stock:")
        let stock = Int(readLine() ?? "") ?? 0
        
        precios[nombre] = precio
        stocks[nombre] = stock
    }
}

// ===== TODO: Calcular valor total (precio × stock) =====
var valorTotalInventario = 0.0
for (nombre, precio) in precios {
    // Buscamos el stock correspondiente usando la clave del producto
    let stockProducto = stocks[nombre] ?? 0
    valorTotalInventario += precio * Double(stockProducto)
}

print("\n================ REPORTE ================")
print("Valor total del inventario: $\(String(format: "%.2f", valorTotalInventario))")

// ===== TODO: Mostrar productos con stock < 5 =====
print("\n--- Alerta de Stock Bajo (Menos de 5 unidades) ---")
var hayStockBajo = false

for (nombre, stock) in stocks {
    if stock < 5 {
        print("\(nombre): \(stock) unidades restantes.")
        hayStockBajo = true
    }
}

if !hayStockBajo {
    print("Todos los productos tienen buen nivel de stock.")
}
print("=========================================")



// ===== CARRITO DE COMPRAS 2.0 =====
var nombres: [String] = []
var precios: [Double] = []
var cantidades: [Int] = []

// TODO 11: Pedir productos
print("¿Cuántos productos va a comprar?")
let totalProductos = Int(readLine() ?? "") ?? 0
for i in 1...totalProductos {
    print("\nProducto \(i) - Nombre:")
    nombres.append(readLine() ?? "")
    print("Precio unitario:")
    precios.append(Double(readLine() ?? "") ?? 0)
    print("Cantidad:")
    cantidades.append(Int(readLine() ?? "") ?? 0)
}

// TODO 12: Calcular subtotales
var subtotales: [Double] = []
for i in 0..<nombres.count {
    let sub = precios[i] * Double(cantidades[i])
    subtotales.append(sub)
}

// TODO 13: Total del carrito
var totalCarrito = 0.0
for sub in subtotales {
    totalCarrito += sub
}

// TODO 14: Nombre del cliente
print("\nNombre del cliente:")
let cliente = readLine() ?? ""

// TODO 15: Descuento
var descPct = 0.0
if totalCarrito >= 5000 { descPct = 0.15 }
else if totalCarrito >= 2000 { descPct = 0.10 }
else if totalCarrito >= 500 { descPct = 0.05 }

let descuento = totalCarrito * descPct
let totalConDesc = totalCarrito - descuento

// TODO 16: IGV y total
let igv = totalConDesc * 0.18
let totalFinal = totalConDesc + igv

// TODO 17: Categoría
var categoria = ""
switch Int(totalCarrito) {
case 0..<500: categoria = "Regular"
case 500..<2000: categoria = "Frecuente"
case 2000..<5000: categoria = "VIP"
default: categoria = "Premium"
}

// TODO 18: Ticket
let sep = String(repeating: "=", count: 45)

// Ajustamos los prints para eliminar los espacios en blanco iniciales
print(sep)
print("TICKET DE COMPRA 2.0")
print("Cliente: \(cliente) (\(categoria))")
print(sep)

for i in 0..<nombres.count {
    // Formateamos los subtotales a un decimal si terminan en .0
    let subStr = subtotales[i] == Double(Int(subtotales[i])) ? String(format: "%.1f", subtotales[i]) : String(subtotales[i])
    print("\(nombres[i]) x\(cantidades[i]) S/. \(subStr)")
}

print(sep)

// Formateamos el subtotal general a un decimal si corresponde
let totalCarritoStr = totalCarrito == Double(Int(totalCarrito)) ? String(format: "%.1f", totalCarrito) : String(totalCarrito)
print("Subtotal: S/. \(totalCarritoStr)")

if descPct > 0 {
    let descPctStr = String(format: "%.1f", descPct * 100)
    let descStr = String(format: "%.1f", descuento)
    print("Descuento (\(descPctStr)%): -S/. \(descStr)")
}

// Forzamos el IGV y el TOTAL final a dos decimales exactos
print("IGV (18%): S/. \(String(format: "%.2f", igv))")
print(sep)
print("TOTAL: S/. \(String(format: "%.2f", totalFinal))")
print(sep)
