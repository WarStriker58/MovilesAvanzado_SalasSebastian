import Foundation

// Formatos de texto que se usan en todas las pantallas
enum Formato {

    // 1416 -> "S/ 1,416.00"
    static func soles(_ valor: Double) -> String {
        let texto = valor.formatted(
            .number
                .precision(.fractionLength(2))
                .locale(Locale(identifier: "en_US"))
        )
        return "S/ \(texto)"
    }

    // Fecha -> "09/11/2026"
    static func fecha(_ fecha: Date) -> String {
        let formateador = DateFormatter()
        formateador.dateFormat = "dd/MM/yyyy"
        return formateador.string(from: fecha)
    }

    // "Lucía Paredes" -> "LP"
    static func iniciales(_ nombre: String) -> String {
        let letras = nombre
            .split(separator: " ")
            .prefix(2)
            .compactMap { $0.first }
            .map { String($0) }
            .joined()
        return letras.isEmpty ? "?" : letras.uppercased()
    }
}
