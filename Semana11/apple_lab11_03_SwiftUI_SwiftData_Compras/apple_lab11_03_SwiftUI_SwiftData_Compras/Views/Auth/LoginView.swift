import SwiftUI
import SwiftData

// B1 · Login
struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @State private var usuario = ""
    @State private var clave = ""
    @State private var hayError = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // ① Logo y nombre
                    LogoApp()
                        .padding(.top, 48)
                    VStack(spacing: 4) {
                        Text("Compras Tecsup")
                            .font(.title.bold())
                        Text("Inicia sesión para continuar")
                            .foregroundStyle(.secondary)
                    }

                    // ② Usuario · ③ Clave oculta
                    VStack(spacing: 12) {
                        CampoTexto(titulo: "Usuario", texto: $usuario)
                        CampoTexto(titulo: "Clave", texto: $clave, seguro: true)
                    }
                    .padding(.top, 12)

                    // ④ Mensaje de error genérico (no dice cuál falló)
                    if hayError {
                        Label("Usuario o clave incorrectos", systemImage: "exclamationmark.triangle.fill")
                            .font(.footnote)
                            .foregroundStyle(Tema.rojo)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    // ⑤ Ingresar
                    Button("Ingresar", action: ingresar)
                        .buttonStyle(BotonPrincipal())
                        .disabled(usuario.isEmpty || clave.isEmpty)

                    // ⑥ Ir a Crear cuenta
                    HStack(spacing: 4) {
                        Text("¿Primera vez?")
                            .foregroundStyle(.secondary)
                        NavigationLink("Crear cuenta") {
                            RegistroView()
                        }
                        .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(24)
            }
            .background(Tema.fondo)
        }
    }

    private func ingresar() {
        // Guardamos el texto en constantes antes de usarlo en #Predicate
        let textoUsuario = usuario.trimmingCharacters(in: .whitespaces).lowercased()
        let textoClave = clave

        let descriptor = FetchDescriptor<Usuario>(
            predicate: #Predicate { $0.usuario == textoUsuario && $0.clave == textoClave }
        )

        if let encontrado = try? modelContext.fetch(descriptor).first {
            hayError = false
            sesion.iniciar(encontrado)          // ContentView cambia solo a las pestañas
        } else {
            hayError = true
        }
    }
}
