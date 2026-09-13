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
