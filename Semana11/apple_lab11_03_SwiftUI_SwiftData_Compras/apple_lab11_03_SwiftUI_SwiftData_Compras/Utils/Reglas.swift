import Foundation

// Reglas de negocio del caso Compras (en un solo lugar para explicarlas fácil)
enum Reglas {

    static let tasaIGV = 0.18
    static let limiteAprobacion = 5_000.0
    static let diasCredito = 30

    // IGV 18 % sobre el subtotal. Total = subtotal + IGV
    static func calcular(cantidad: Int, costo: Double) -> (subtotal: Double, igv: Double, total: Double) {
        let subtotal = Double(cantidad) * costo
        let igv = redondear(subtotal * tasaIGV)
        return (subtotal, igv, subtotal + igv)
    }

    // Menor a S/ 5,000 -> Aprobada al instante. Desde S/ 5,000 -> Pendiente
    static func requiereAprobacion(total: Double) -> Bool {
        total >= limiteAprobacion
    }

    // Crédito: vence 30 días después de la fecha de registro
    static func vencimiento(desde fecha: Date) -> Date {
        Calendar.current.date(byAdding: .day, value: diasCredito, to: fecha) ?? fecha
    }

    // Costo promedio ponderado:
    // (stock actual × costo promedio + cantidad × costo unitario) / (stock actual + cantidad)
    static func nuevoCostoPromedio(stock: Int, costoPromedio: Double,
                                   cantidad: Int, costoUnitario: Double) -> Double {
        let unidades = stock + cantidad
        guard unidades > 0 else { return costoUnitario }
        return (Double(stock) * costoPromedio + Double(cantidad) * costoUnitario) / Double(unidades)
    }

    // Efectos de una compra aprobada: nuevo costo promedio y suma al stock
    static func aplicarEfectos(de compra: Compra) {
        guard let producto = compra.producto else { return }
        producto.costoPromedio = nuevoCostoPromedio(
            stock: producto.stock,
            costoPromedio: producto.costoPromedio,
            cantidad: compra.cantidad,
            costoUnitario: compra.costoUnitario
        )
        producto.stock += compra.cantidad
    }

    static func redondear(_ valor: Double) -> Double {
        (valor * 100).rounded() / 100
    }
}
