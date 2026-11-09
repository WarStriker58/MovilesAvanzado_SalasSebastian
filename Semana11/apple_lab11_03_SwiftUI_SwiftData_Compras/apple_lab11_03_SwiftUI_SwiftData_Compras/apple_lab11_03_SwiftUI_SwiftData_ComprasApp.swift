import SwiftUI
import SwiftData

@main
struct ComprasApp: App {

    // Sesión compartida: recuerda al usuario conectado mientras la app está abierta
    @State private var sesion = Sesion()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(sesion)    // Cualquier vista puede leer la sesión
                .tint(Tema.azul)
        }
        // Contenedor persistente (SQLite) para toda la app
        .modelContainer(ModelContainerProvider.shared.container)
    }
}
