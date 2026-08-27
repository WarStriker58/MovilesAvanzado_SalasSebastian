import Foundation

//variables, calculos y plan de pagos con su validacion
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

//calculos finales para el plan de pagos
if esPlanValido {
    
    let interesTotal = montoCompra * porcentajeInteres
    let montoFinal = montoCompra + interesTotal
    let cuotaMensual = montoFinal / Double(mesesPlan)
    
    print("En que mes hara un pago adelantado? (0 para ninguno, 1 al \(mesesPlan)): ")
    let mesAdelantado = Int(readLine() ?? "0") ?? 0
    
    var montoAdicional = 0.0
    if mesAdelantado >= 1 && mesAdelantado <= mesesPlan {
        print("Monto adicional a pagar ese mes (S/): ")
        montoAdicional = Double(readLine() ?? "0") ?? 0.0
    }
}
