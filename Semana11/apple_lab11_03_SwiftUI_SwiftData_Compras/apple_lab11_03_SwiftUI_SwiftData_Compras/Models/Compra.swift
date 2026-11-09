import Foundation
import SwiftData

// Valores posibles del estado de una compra
enum EstadoCompra {
    static let pendiente = "Pendiente"
    static let aprobada = "Aprobada"
    static let rechazada = "Rechazada"
}

@Model
final class Compra {
    var fecha: Date
    var cantidad: Int
    var costoUnitario: Double
    var igv: Double
    var total: Double
    var alCredito: Bool
    var vence: Date
    var estado: String          // Pendiente, Aprobada o Rechazada
    var pagada: Bool
    var motivoRechazo: String?

    // Lado "uno" de las tres relaciones (el inverso está en Usuario, Proveedor y Producto)
    var comprador: Usuario?
    var proveedor: Proveedor?
    var producto: Producto?

    init(fecha: Date, cantidad: Int, costoUnitario: Double, igv: Double, total: Double,
         alCredito: Bool, vence: Date, estado: String, pagada: Bool) {
        self.fecha = fecha
        self.cantidad = cantidad
        self.costoUnitario = costoUnitario
        self.igv = igv
        self.total = total
        self.alCredito = alCredito
        self.vence = vence
        self.estado = estado
        self.pagada = pagada
        self.motivoRechazo = nil
    }

    // Calculados (no se guardan)
    var subtotal: Double { Double(cantidad) * costoUnitario }

    // Aprobada, a crédito y sin pagar
    var estaPorPagar: Bool {
        estado == EstadoCompra.aprobada && alCredito && !pagada
    }

    // Por pagar y con la fecha de vencimiento ya pasada
    var estaVencida: Bool {
        estaPorPagar && vence < Date.now
    }
}
