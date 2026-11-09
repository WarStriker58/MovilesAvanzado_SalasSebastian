import Foundation
import SwiftData

@MainActor
final class ModelContainerProvider {

    // Singleton: un único contenedor para toda la app
    static let shared = ModelContainerProvider()

    let container: ModelContainer

    private init() {
        // Las cuatro clases que se guardan
        let schema = Schema([Usuario.self, Proveedor.self, Producto.self, Compra.self])

        do {
            // Carpeta Application Support (se crea si no existe)
            let carpeta = URL.applicationSupportDirectory
            try FileManager.default.createDirectory(at: carpeta, withIntermediateDirectories: true)

            let config = ModelConfiguration(
                "ComprasData",
                schema: schema,
                url: carpeta.appending(path: "ComprasData.sqlite")
            )

            print("Base de datos SQLite en: \(config.url.path)")

            container = try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Error al inicializar ModelContainer: \(error)")
        }
    }
}
