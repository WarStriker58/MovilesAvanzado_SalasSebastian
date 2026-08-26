import Foundation

//ingreso de datos y el calculo de monto compra
print("Nombre del producto: ")
let producto = readLine() ?? ""

print("Precio unitario: ")
let precio = Double(readLine() ?? "0") ?? 0.0

print("Cantidad: ")
let cantidad = Int(readLine() ?? "0") ?? 0

let montoCompra = precio * Double(cantidad)
print("Monto total de compra: S/ \(montoCompra)")
print("---------------------------------------")
