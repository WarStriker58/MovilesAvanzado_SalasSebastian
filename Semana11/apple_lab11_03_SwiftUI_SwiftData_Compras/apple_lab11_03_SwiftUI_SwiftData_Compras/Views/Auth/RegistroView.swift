import SwiftUI
import SwiftData

// B2 · Crear cuenta
struct RegistroView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @State private var nombre = ""
    @State private var usuario = ""
    @State private var clave = ""
    @State private var confirmar = ""
    @State private var rol = Rol.comprador
    @State private var mensajeError: String?

    // El usuario se guarda en minúsculas y sin espacios
    private var usuarioNormalizado: String {
        usuario.trimmingCharacters(in: .whitespaces).lowercased()
    }

    // ¿Ya existe? FetchDescriptor + #Predicate + fetchCount
    private var usuarioExiste: Bool {
        let texto = usuarioNormalizado          // Se guarda en un let antes del #Predicate
        guard !texto.isEmpty else { return false }
        let descriptor = FetchDescriptor<Usuario>(predicate: #Predicate { $0.usuario == texto })
        return ((try? modelContext.fetchCount(descriptor)) ?? 0) > 0
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                // ② Nombre completo
                CampoTexto(titulo: "Nombre completo", texto: $nombre, capitalizar: true)

                // ③ Usuario único, con aviso si ya existe
                VStack(alignment: .leading, spacing: 4) {
                    CampoTexto(titulo: "Usuario", texto: $usuario)
                    if !usuarioNormalizado.isEmpty {
                        Label(usuarioExiste ? "Ese usuario ya existe" : "Disponible",
                              systemImage: usuarioExiste ? "xmark.circle.fill" : "checkmark.circle.fill")
                            .font(.caption)
                            .foregroundStyle(usuarioExiste ? Tema.rojo : Tema.azul)
                            .padding(.leading, 4)
                    }
                }

                // ④ Clave (mínimo 6) y su confirmación
                CampoTexto(titulo: "Clave (mínimo 6 caracteres)", texto: $clave, seguro: true)
                CampoTexto(titulo: "Confirmar clave", texto: $confirmar, seguro: true)

                // ⑤ Rol
                VStack(alignment: .leading, spacing: 6) {
                    Text("TU ROL")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.secondary)
                    Picker("Rol", selection: $rol) {
                        Text(Rol.comprador).tag(Rol.comprador)
                        Text(Rol.supervisor).tag(Rol.supervisor)
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.top, 4)

                if let mensajeError {
                    Label(mensajeError, systemImage: "exclamationmark.triangle.fill")
                        .font(.footnote)
                        .foregroundStyle(Tema.rojo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                // ⑥ Registrarme (entra directo a la app)
                Button("Registrarme", action: registrar)
                    .buttonStyle(BotonPrincipal())
                    .disabled(nombre.isEmpty || usuario.isEmpty || clave.isEmpty || confirmar.isEmpty)
                    .padding(.top, 8)

                Text("Al registrarte entrarás directamente a la app con las pestañas de tu rol.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(24)
        }
        .background(Tema.fondo)
        .navigationTitle("Crear cuenta")          // ① Título y volver al login
        .navigationBarTitleDisplayMode(.inline)
    }

    private func registrar() {
        if usuarioExiste {
            mensajeError = "El usuario ya existe. Elige otro."
            return
        }
        if clave.count < 6 {
            mensajeError = "La clave debe tener mínimo 6 caracteres."
            return
        }
        if clave != confirmar {
            mensajeError = "Las claves no coinciden."
            return
        }

        let nuevo = Usuario(
            nombre: nombre.trimmingCharacters(in: .whitespaces),
            usuario: usuarioNormalizado,
            clave: clave,
            rol: rol
        )
        modelContext.insert(nuevo)
        do {
            try modelContext.save()
            sesion.iniciar(nuevo)                // Entra directo a la app
        } catch {
            mensajeError = "No se pudo guardar: \(error.localizedDescription)"
        }
    }
}
