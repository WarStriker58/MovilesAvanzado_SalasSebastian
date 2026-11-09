import Foundation
import Observation

// Guarda al usuario conectado mientras la app está abierta.
// Se coloca con .environment(...) en la App y cualquier vista la lee con
// @Environment(Sesion.self). Si usuario es nil se muestra el Login.
@Observable
final class Sesion {
    var usuario: Usuario?

    func iniciar(_ usuario: Usuario) {
        self.usuario = usuario
    }

    func cerrar() {
        usuario = nil   // La vista raíz vuelve sola al Login
    }
}
