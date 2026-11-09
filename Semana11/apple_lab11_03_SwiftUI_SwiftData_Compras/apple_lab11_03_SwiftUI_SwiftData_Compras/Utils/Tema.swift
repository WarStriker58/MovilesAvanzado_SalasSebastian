import SwiftUI

// Paleta azul de la app
enum Tema {
    static let azul = Color(red: 0.15, green: 0.39, blue: 0.92)
    static let azulOscuro = Color(red: 0.07, green: 0.24, blue: 0.60)
    static let celeste = Color(red: 0.80, green: 0.89, blue: 1.00)
    static let naranja = Color.orange
    static let rojo = Color.red

    static let fondo = Color(.systemGroupedBackground)
    static let tarjeta = Color(.secondarySystemGroupedBackground)

    // Color de la insignia según el estado de la compra
    static func color(estado: String) -> Color {
        switch estado {
        case EstadoCompra.aprobada: return azul
        case EstadoCompra.rechazada: return rojo
        default: return naranja
        }
    }
}
