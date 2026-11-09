import Foundation
import SwiftData

// Valores posibles del rol (se guardan como texto en la base de datos)
enum Rol {
    static let comprador = "Comprador"
    static let supervisor = "Supervisor"
}

@Model
final class Usuario {
    var nombre: String
    var usuario: String     // Se guarda en minúsculas: así es único sin distinguir mayúsculas
    var clave: String       // Práctica: se guarda como texto (en una app real sería un hash)
    var rol: String         // "Comprador" o "Supervisor"

    // Un usuario registra muchas compras.
    // .deny: no se puede borrar un usuario que tenga compras.
    @Relationship(deleteRule: .deny, inverse: \Compra.comprador)
    var compras: [Compra] = []

    init(nombre: String, usuario: String, clave: String, rol: String) {
        self.nombre = nombre
        self.usuario = usuario
        self.clave = clave
        self.rol = rol
    }

    // Calculados (no se guardan)
    var esSupervisor: Bool { rol == Rol.supervisor }
    var iniciales: String { Formato.iniciales(nombre) }
}
