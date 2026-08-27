import Foundation

print("Nombre del producto: ")
let producto = readLine() ?? ""

print("Precio unitario: ")
let precio = Double(readLine() ?? "0") ?? 0.0

print("Cantidad: ")
let cantidad = Int(readLine() ?? "0") ?? 0

let montoCompra = precio * Double(cantidad)
print("Monto total de compra: S/ \(montoCompra)")
print("---------------------------------------")

print("Elija el Plan de Pagos (6, 12, 24): ")
let mesesPlan = Int(readLine() ?? "0") ?? 0

var porcentajeInteres = 0.0
var esPlanValido = false

if mesesPlan == 6 {
    porcentajeInteres = 0.20
    esPlanValido = true
} else if mesesPlan == 12 {
    porcentajeInteres = 0.40
    esPlanValido = true
} else if mesesPlan == 24 {
    porcentajeInteres = 0.60
    esPlanValido = true
} else {
    print("Plan no valido. No se puede proceder.")
}
