import Foundation

//Docente : Juan León S.
// ===== EJERCICIO 1: CONDICIONALES =====

// --- Ejemplo (ya resuelto): ---
let nota = 15.0
if nota >= 13.0 {
    print("Aprobado con \(nota)")
} else {
    print("Desaprobado con \(nota)")
}

// --- TODO 1: Validar si una persona es mayor de edad ---
let edad = 17
if edad >= 18 {
    print("Es mayor de edad")
} else {
    print("Es menor de edad")
}

// --- TODO 2: Clasificar una nota con else if ---
let miNota = 16.0
// Categorías: Excelente (18-20), Bueno (15-17), Aprobado (13-14), Desaprobado (0-12)
if miNota >= 18 {
    print("Excelente")
} else if miNota >= 15 {
    print("Bueno")
} else if miNota >= 13 {
    print("Aprobado")
} else {
    print("Desaprobado")
}

// --- TODO 3: Verificar si un número es positivo, negativo o cero ---
let numero = -5
if numero > 0 {
    print("El número es positivo")
} else if numero < 0 {
    print("El número es negativo")
} else {
    print("El número es cero")
}

// ===== FIX: Encuentra y corrige los 3 errores =====

// --- Bloque 1: Temperatura ---
let temperatura = 35
if temperatura > 30 {
    print("Hace calor")
} else if temperatura > 20 { // Se agregó la llave '{'
    print("Clima agradable")
} else {
    print("Hace frío")
}

// --- Bloque 2: Saldo y Compra ---
let saldo = 100.0
let compra = 150.0
if saldo > compra {
    print("Compra realizada")
} else {
    // Se cambió 'saldo - compra' por 'compra - saldo' para evitar números negativos
    print("Saldo insuficiente: te faltan \(compra - saldo)")
}

// --- Bloque 3: Formato de Hora ---
let hora = 25
if hora >= 0 && hora < 12 {
    print("Buenos días")
} else if hora >= 12 && hora < 18 {
    print("Buenas tardes")
} else if hora >= 18 && hora < 24 { // Se cambió '<= 23' por '< 24' para cubrir todo el rango del día correctamente
    print("Buenas noches")
} else {
    print("Hora inválida")
}

// PREDICT: ¿Qué imprime cada bloque?

let x = 10
if x > 5 && x < 20 {
    print("Dentro del rango")
} else {
    print("Fuera del rango")
}
// PREDICT 1: Imprime "Dentro del rango"

let y = 15
if y > 20 {
    print("Mayor que 20")
} else if y > 10 {
    print("Mayor que 10")
} else if y > 5 {
    print("Mayor que 5")
}
// PREDICT 2: Imprime "Mayor que 10"
// ¿Por qué no imprime "Mayor que 5" también?
// Porque en una estructura 'else if', el programa se detiene y sale en la primera condición que resulte verdadera.

let esLunes = true
let llueve = false
if esLunes && llueve {
    print("Lunes lluvioso")
} else if esLunes || llueve {
    print("Es lunes O llueve")
} else {
    print("Ni lunes ni llueve")
}
// PREDICT 3: Imprime "Es lunes O llueve"

// ===== EJERCICIO 2: SWITCH =====

// --- Ejemplo (ya resuelto): ---
let diaSemana = 3
switch diaSemana {
case 1: print("Lunes")
case 2: print("Martes")
case 3: print("Miércoles")
case 4: print("Jueves")
case 5: print("Viernes")
case 6: print("Sábado")
case 7: print("Domingo")
default: print("Día inválido")
}

// --- TODO 4: Clasificar nota numérica a letra ---
let number = 16
switch number {
case 18...20: print("Excelente")
case 15...17: print("Bueno")
case 13...14: print("Aprobado")
case 11...12: print("Desaprobado - Recuperación")
case 0...10: print("Desaprobado")
default: print("Nota inválida")
}

// --- TODO 5: Calculadora simple con switch ---
let num1 = 20.0
let num2 = 5.0
let operacion = "/"
switch operacion {
case "+": print("Resultado: \(num1 + num2)")
case "-": print("Resultado: \(num1 - num2)")
case "*": print("Resultado: \(num1 * num2)")
case "/":
    // TODO: verificar que num2 no sea 0 antes de dividir
    if num2 != 0.0 {
        print("Resultado: \(num1 / num2)")
    } else {
        print("Error: No se puede dividir entre cero")
    }
default: print("Operación no válida")
}

// --- TODO 6: Categoría de producto por precio ---
let precio = 350.0
// Categorías: Económico (0-99), Medio (100-499), Premium (500-999), Lujo (1000+)
switch precio {
case 0.0...99.99:
    print("Económico")
case 100.0...499.99:
    print("Medio")
case 500.0...999.99:
    print("Premium")
case let x where x >= 1000.0:
    print("Lujo")
default:
    print("Precio inválido (negativo)")
}

// PREDICT: ¿Qué imprime?

let mes = 2
switch mes {
case 1, 3, 5, 7, 8, 10, 12: print("31 días")
case 4, 6, 9, 11: print("30 días")
case 2: print("28 o 29 días")
default: print("Mes inválido")
}
// PREDICT 4: Imprime "28 o 29 días"

let letra: Character = "a"
switch letra {
case "a", "e", "i", "o", "u": print("Vocal")
default: print("Consonante")
}
// PREDICT 5: Imprime "Vocal"

// ===== EJERCICIO 3: FOR-IN =====

// --- Ejemplo (ya resuelto): ---
// Imprime los números del 1 al 5:
for i in 1...5 {
    print("Número: \(i)")
}

// --- TODO 7: Tabla de multiplicar del 7 ---
for i in 1...12 {
    print("7 x \(i) = \(7 * i)")
}

// --- TODO 8: Sumatoria del 1 al 100 ---
var suma = 0
for i in 1...100 {
    suma = suma + i
}
print("La suma del 1 al 100 es: \(suma)")

// --- TODO 9: Calcular el factorial de 8 ---
var factorial = 1
for i in 1...8 {
    factorial = factorial * i
}
print("8! = \(factorial)")

// --- TODO 10: Patrón de asteriscos ---
for i in 1...5 {
    var fila = ""
    for _ in 1...i {
        fila += "*"
    }
    print(fila)
}

// ===== FIX: Encuentra los 2 errores =====

// --- Bloque 1: Números pares ---
// Se quiere imprimir los números pares del 2 al 20:
for i in 1...20 {
    // FIX 4 CORREGIDO: Se cambió '== 1' (impares) por '== 0' (pares)
    // Imprime pares
    if i % 2 == 0 {
        print(i)
    }
}

// --- Bloque 2: Cuenta regresiva ---
// Se quiere contar del 10 al 1 (cuenta regresiva):
// FIX 5 CORREGIDO: Usamos stride para ir desde 10 hasta 1, bajando de -1 en -1
// Cuenta hacia atras
for i in stride(from: 10, through: 1, by: -1) {
    print(i)
}

// PREDICT: ¿Cuántas veces se ejecuta y qué imprime al final?

var total = 0
for i in 1...5 {
    total += i
}
print(total)
// PREDICT 6: ¿Valor? 15 | ¿Cuántas iteraciones? 5

var texto = ""
for _ in 1...3 {
    texto += "Hola "
}
print(texto)
// PREDICT 7: Imprime "Hola Hola Hola "

// ¿Para qué sirve _ en vez de i?
// Sirve para optimizar el rendimiento del código. Le avisa a Swift que no necesitas almacenar el valor del índice actual, ya que el bucle solo se usa para repetir una acción una cantidad específica de veces.

// ===== EJERCICIO 4: WHILE =====

// --- Ejemplo (ya resuelto): ---
var contador = 5
while contador > 0 {
    print("Cuenta regresiva: \(contador)")
    contador -= 1 // Resta 1 en cada vuelta
}
print("¡Despegue!")

// --- TODO 11: Ahorro mensual ---
// Un alumno ahorra S/. 150 cada mes.
// ¿Cuántos meses necesita para juntar S/. 2000?
var ahorro = 0.0
var meses = 0
let meta = 2000.0
let ahorroMensual = 150.0

while ahorro < meta {
    ahorro += ahorroMensual
    meses += 1
}
print("Necesita \(meses) meses para juntar S/. \(meta)")
// Necesita 14 meses para juntar S/. 2000.0

// --- TODO 12: División sucesiva ---
// Divide un número entre 2 repetidamente hasta que sea menor a 1
var n = 1000.0
var divisiones = 0

while n >= 1.0 {
    n = n / 2
    divisiones += 1
    print("División \(divisiones): \(n)")
}
print("Se dividió \(divisiones) veces")
// Se dividió 10 veces (el número final queda en 0.9765625)

// --- TODO 13: Validar datos con repeat-while ---
// Simula pedir una nota hasta que sea válida (entre 0 y 20)
// Usamos valores fijos porque no podemos pedir input en Playground

let intento1 = 25 // Inválido: > 20
let intento2 = -3 // Inválido: < 0
let intento3 = 15 // Válido

var intentoActual = intento1
var esValido = false
var numIntento = 1

repeat {
    // TODO: Verifica si intentoActual está entre 0 y 20
    if intentoActual >= 0 && intentoActual <= 20 {
        esValido = true
        print("Nota \(intentoActual) válida en intento \(numIntento)")
    } else {
        print("Nota \(intentoActual) inválida, intento \(numIntento)")
        // Simula el siguiente intento:
        if numIntento == 1 { intentoActual = intento2 }
        if numIntento == 2 { intentoActual = intento3 }
        numIntento += 1
    }
} while !esValido

// PREDICT: ¿Cuántas veces se ejecuta cada bucle?

var a = 100
while a > 1 {
    a = a / 3
}
print(a)
// PREDICT 8: ¿Valor final? 1 | ¿Cuántas vueltas? 4

var b = 0
repeat {
    b += 1
} while b < 0
print(b)
// PREDICT 9: ¿Valor? 1

// ¿Por qué repeat-while ejecuta al menos una vez?
// Porque evalúa la condición al final del ciclo. Esto garantiza que las instrucciones dentro del bloque se ejecuten obligatoriamente una primera vez antes de que se compruebe si se cumple el criterio de repetición.

// ===== EJERCICIO 5: CARRITO DE COMPRAS =====
// --- Datos de productos (ya definidos): ---
let prod1 = "Laptop"
let precio1 = 3500.0
let cant1 = 1
let prod2 = "Mouse"
let precio2 = 45.50
let cant2 = 2
let prod3 = "Teclado"
let precio3 = 120.00
let cant3 = 1
let prod4 = "Monitor"
let precio4 = 890.00
let cant4 = 1
let prod5 = "USB Cable"
let precio5 = 15.00
let cant5 = 3

// --- TODO 14: Calcula el subtotal de cada producto ---
let sub1 = precio1 * Double(cant1)
let sub2 = precio2 * Double(cant2)
let sub3 = precio3 * Double(cant3)
let sub4 = precio4 * Double(cant4)
let sub5 = precio5 * Double(cant5)

// --- TODO 15: Calcula el subtotal general ---
let subtotalGeneral = sub1 + sub2 + sub3 + sub4 + sub5

// --- TODO 16: Aplica descuento según monto de compra ---
// Reglas:
// Compra >= 5000 → 15% de descuento
// Compra >= 2000 → 10% de descuento
// Compra >= 500 → 5% de descuento
// Compra < 500 → sin descuento
var porcentajeDescuento = 0.0
if subtotalGeneral >= 5000 {
    porcentajeDescuento = 0.15
} else if subtotalGeneral >= 2000 {
    porcentajeDescuento = 0.10
} else if subtotalGeneral >= 500 {
    porcentajeDescuento = 0.05
} else {
    porcentajeDescuento = 0.0
}
let descuento = subtotalGeneral * porcentajeDescuento
let subtotalConDescuento = subtotalGeneral - descuento

// --- TODO 17: Categoría de cliente según monto ---
// Usa switch con rangos para determinar la categoría:
// 0 - 499: "Regular"
// 500 - 1999: "Frecuente"
// 2000 - 4999: "VIP"
// 5000+: "Premium"
let montoParaCategoria = Int(subtotalGeneral)
var categoriaCliente = ""
switch montoParaCategoria {
case 0..<500:
    categoriaCliente = "Regular"
case 500..<2000:
    categoriaCliente = "Frecuente"
case 2000..<5000:
    categoriaCliente = "VIP"
default:
    categoriaCliente = "Premium"
}

// --- TODO 18: Calcula IGV y total ---
let igv = subtotalConDescuento * 0.18
let totalFinal = subtotalConDescuento + igv

// --- TODO 19: Imprime el ticket de compra ---
// Usa un bucle for para imprimir la línea separadora
// y print con interpolación para los datos
var separador = ""
for _ in 1...40 {
    separador += "="
}
print(separador)
print("          TICKET DE COMPRA")
print(" Cliente: \(categoriaCliente)")
print(separador)
print("\(prod1) x\(cant1) S/. \(sub1)")
print("\(prod2) x\(cant2) S/. \(sub2)")
print("\(prod3) x\(cant3) S/. \(sub3)")
print("\(prod4) x\(cant4) S/. \(sub4)")
print("\(prod5) x\(cant5) S/. \(sub5)")
print(separador)
print("Subtotal: S/. \(subtotalGeneral)")
print("Descuento (\(porcentajeDescuento * 100)%): -S/. \(descuento)")
print("Subtotal c/desc: S/. \(subtotalConDescuento)")
print("IGV (18%): S/. \(igv)")
print(separador)
print("TOTAL: S/. \(totalFinal)")
print(separador)
print("¡Gracias por su compra!")
