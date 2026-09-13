import Foundation

// estructura base e ingreso de datos
print("Ingrese el nombre del estudiante:")
let estudiante = readLine() ?? ""

print("Ingrese el DNI del estudiante:")
let dni = readLine() ?? ""

print("¿Es alumno de Tecsup? (Seleccione una opción numérica):")
print("1. Sí")
print("2. No")
let opcionTecsup = readLine() ?? ""

var textoAlumnoTecsup = ""
var esAlumnoTecsup = false

if opcionTecsup == "1" {
    textoAlumnoTecsup = "Sí ✅"
    esAlumnoTecsup = true
} else {
    textoAlumnoTecsup = "No"
    esAlumnoTecsup = false
}

// bucle interactivo para registrar multiples cursos
print("\n¿Cuántos cursos distintos va a registrar?")
let cantidadCursosDiferentesString = readLine() ?? ""
let cantidadCursosDiferentes = Int(cantidadCursosDiferentesString) ?? 0

var subtotal = 0.0
var totalCursosComprados = 0
var listaDeCursosImpresion = "" 

var contador = 1

while contador <= cantidadCursosDiferentes {
    print("\n--- CURSO \(contador) ---")
    
    print("Nombre del curso:")
    let nombreCurso = readLine() ?? ""
    
    print("Cantidad de vacantes para este curso:")
    let cantString = readLine() ?? ""
    let cant = Int(cantString) ?? 0
    
    print("Precio por unidad de este curso:")
    let precioString = readLine() ?? ""
    let precio = Double(precioString) ?? 0.0
    
    let totalPorCurso = Double(cant) * precio
    
    subtotal = subtotal + totalPorCurso
    totalCursosComprados = totalCursosComprados + cant
    
    if cant > 0 {
        listaDeCursosImpresion = listaDeCursosImpresion + nombreCurso + " x\(cant) - S/ \(totalPorCurso)\n"
    }
    
    contador = contador + 1
}
