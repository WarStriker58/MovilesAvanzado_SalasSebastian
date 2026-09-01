import Foundation

// ===== EJERCICIO 6: CARRITO DE COMPRAS MEJORADO =====

// --- Datos de productos y cantidades iniciales ---
let prod1 = "Laptop";    let precio1 = 3500.0; let cant1 = 1
let prod2 = "Mouse";     let precio2 = 45.50;  let cant2 = 2
let prod3 = "Teclado";   let precio3 = 120.00; let cant3 = 1
let prod4 = "Monitor";   let precio4 = 890.00; let cant4 = 1
let prod5 = "USB Cable"; let precio5 = 15.00;  let cant5 = 3

let cuponIngresado = "DESCUENTO20"

// --- REQUISITO 16: Validación de Datos de Entrada ---
// Validamos que no existan inconsistencias comerciales antes de procesar la orden
if precio1 < 0 || precio2 < 0 || precio3 < 0 || precio4 < 0 || precio5 < 0 || 
   cant1 <= 0 || cant2 <= 0 || cant3 <= 0 || cant4 <= 0 || cant5 <= 0 {
    
    print("ERROR CRÍTICO: Se detectaron precios negativos o cantidades en cero.")
    
} else {
    // --- REQUISITO 12: Descuento por cantidad (5% extra si lleva >= 3 unidades) ---
    // Multiplicamos por 0.95 (aplicando el 5% de descuento) solo si se cumple la condición por producto
    let sub1 = (precio1 * Double(cant1)) * (cant1 >= 3 ? 0.85 : 1.0) // Error corregido: 5% extra es 0.95
    let sub2 = (precio2 * Double(cant2)) * (cant2 >= 3 ? 0.95 : 1.0)
    let sub3 = (precio3 * Double(cant3)) * (cant3 >= 3 ? 0.95 : 1.0)
    let sub4 = (precio4 * Double(cant4)) * (cant4 >= 3 ? 0.95 : 1.0)
    let sub5 = (precio5 * Double(cant5)) * (cant5 >= 3 ? 0.95 : 1.0)

    let subtotalGeneral = sub1 + sub2 + sub3 + sub4 + sub5

    // --- Descuento por tramos según monto total de compra ---
    var porcentajeDescuento = 0.0
    if subtotalGeneral >= 5000 {
        porcentajeDescuento = 0.15
    } else if subtotalGeneral >= 2000 {
        porcentajeDescuento = 0.10
    } else if subtotalGeneral >= 500 {
        porcentajeDescuento = 0.05
    }
    
    let descuentoBaseMoneda = subtotalGeneral * porcentajeDescuento
    let subtotalConDescuentoBase = subtotalGeneral - descuentoBaseMoneda

    // --- REQUISITO 13: Cupón de descuento "DESCUENTO20" (20% adicional) ---
    // Se aplica en cascada sobre el subtotal que ya tiene el primer descuento aplicado
    var porcentajeCupon = 0.0
    if cuponIngresado == "DESCUENTO20" {
        porcentajeCupon = 0.20
    }
    let descuentoCuponMoneda = subtotalConDescuentoBase * porcentajeCupon
    let subtotalConTodosDescuentos = subtotalConDescuentoBase - descuentoCuponMoneda

    // --- Categoría de Cliente mediante Rangos ---
    let montoParaCategoria = Int(subtotalGeneral)
    var categoriaCliente = ""
    switch montoParaCategoria {
    case 0..<500:     categoriaCliente = "Regular"
    case 500..<2000:  categoriaCliente = "Frecuente"
    case 2000..<4000: categoriaCliente = "VIP"
    default:          categoriaCliente = "Premium"
    }

    // --- Impuestos e IGV ---
    let igv = subtotalConTodosDescuentos * 0.18
    let totalProductosEImpuesto = subtotalConTodosDescuentos + igv

    // --- REQUISITO 14: Envío gratis si supera S/. 3000 ---
    // Evaluamos contra el total acumulado de la orden con impuestos incluidos
    var costoEnvio = 25.0
    if totalProductosEImpuesto > 3000.0 {
        costoEnvio = 0.0
    }

    let totalFinal = totalProductosEImpuesto + costoEnvio

    // --- REQUISITO 15: Puntos de fidelidad (1 punto por cada S/. 100 de compra) ---
    // Truncamos a entero para otorgar puntos solo por bloques completos de 100 soles
    let puntosGanados = Int(subtotalGeneral / 100.0)

    // --- REQUISITO 19: Ticket de compra mejorado ---
    var separador = ""
    for _ in 1...40 { separador += "=" }
    
    print(separador)
    print("          TICKET DE COMPRA MEJORADO")
    print(" Cliente: \(categoriaCliente)")
    print(separador)
    print("\(prod1) x\(cant1) S/. \(sub1)")
    print("\(prod2) x\(cant2) S/. \(sub2)")
    print("\(prod3) x\(cant3) S/. \(sub3)")
    print("\(prod4) x\(cant4) S/. \(sub4)")
    print("\(prod5) x\(cant5) S/. \(sub5)")
    print(separador)
    print("Subtotal Inicial: S/. \(subtotalGeneral)")
    print("Desc. Volumen (\(porcentajeDescuento * 100)%): -S/. \(descuentoBaseMoneda)")
    print("Desc. Cupón (\(porcentajeCupon * 100)%): -S/. \(descuentoCuponMoneda)")
    print("Subtotal Neto: S/. \(subtotalConTodosDescuentos)")
    print("IGV (18%): S/. \(igv)")
    print("Costo de Envío: S/. \(costoEnvio)")
    print(separador)
    print("TOTAL A PAGAR: S/. \(totalFinal)")
    print(separador)
    print("Puntos Ganados en esta compra: \(puntosGanados) pts")
    print("¡Gracias por su compra!")
}
