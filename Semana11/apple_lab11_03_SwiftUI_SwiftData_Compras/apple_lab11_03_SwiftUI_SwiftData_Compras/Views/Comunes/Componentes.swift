import SwiftUI

// MARK: - Logo de la app (Login)
struct LogoApp: View {
    var tamano: CGFloat = 84

    var body: some View {
        RoundedRectangle(cornerRadius: tamano * 0.24)
            .fill(LinearGradient(colors: [Tema.azul, Tema.azulOscuro],
                                 startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: tamano, height: tamano)
            .overlay {
                Image(systemName: "shippingbox.fill")
                    .font(.system(size: tamano * 0.45))
                    .foregroundStyle(.white)
            }
            .shadow(color: Tema.azul.opacity(0.3), radius: 10, y: 6)
    }
}

// MARK: - Campo de texto con título (Login y Registro)
struct CampoTexto: View {
    let titulo: String
    @Binding var texto: String
    var seguro = false
    var capitalizar = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(titulo.uppercased())
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.secondary)
            Group {
                if seguro {
                    SecureField(titulo, text: $texto)       // Clave oculta
                } else {
                    TextField(titulo, text: $texto)
                }
            }
            .textInputAutocapitalization(capitalizar ? .words : .never)
            .autocorrectionDisabled()
        }
        .padding(12)
        .background(Tema.tarjeta, in: RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Botón principal azul
struct BotonPrincipal: ButtonStyle {
    @Environment(\.isEnabled) private var habilitado

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(habilitado ? Tema.azul : Color.gray.opacity(0.45),
                        in: RoundedRectangle(cornerRadius: 14))
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

// MARK: - Avatar de la sesión con menú "Cerrar sesión"
struct AvatarMenu: View {
    @Environment(Sesion.self) private var sesion

    var body: some View {
        Menu {
            if let usuario = sesion.usuario {
                Section("\(usuario.nombre) · \(usuario.rol)") {
                    Button(role: .destructive) {
                        sesion.cerrar()
                    } label: {
                        Label("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
        } label: {
            Text(sesion.usuario?.iniciales ?? "?")
                .font(.caption.bold())
                .foregroundStyle(.white)
                .frame(width: 32, height: 32)
                .background(Tema.azul, in: Circle())
        }
    }
}

// MARK: - Insignia (Pendiente, Aprobada, VENCIDA, Al día...)
struct Insignia: View {
    let texto: String
    let color: Color

    var body: some View {
        Text(texto)
            .font(.caption2.bold())
            .foregroundStyle(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color.opacity(0.15), in: Capsule())
    }
}

// MARK: - Cuadro con iniciales (productos y proveedores)
struct IconoIniciales: View {
    let texto: String
    var color: Color = Tema.azul

    var body: some View {
        Text(Formato.iniciales(texto))
            .font(.caption.bold())
            .foregroundStyle(.white)
            .frame(width: 38, height: 38)
            .background(color.gradient, in: RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Stock en tonos azules: >10 oscuro, 6 a 10 medio, 5 o menos claro
struct ChipStock: View {
    let stock: Int

    private var fondo: Color {
        if stock > 10 { return Tema.azulOscuro }
        if stock >= 6 { return Tema.azul }
        return Tema.celeste
    }

    var body: some View {
        Text("\(stock) u.")
            .font(.caption.bold())
            .foregroundStyle(stock <= 5 ? Tema.azulOscuro : .white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(fondo, in: Capsule())
    }
}

// MARK: - Ícono según el estado de la compra
struct IconoEstado: View {
    let estado: String

    private var simbolo: String {
        switch estado {
        case EstadoCompra.aprobada: return "checkmark"
        case EstadoCompra.rechazada: return "xmark"
        default: return "hourglass"
        }
    }

    var body: some View {
        Image(systemName: simbolo)
            .font(.subheadline.bold())
            .foregroundStyle(.white)
            .frame(width: 38, height: 38)
            .background(Tema.color(estado: estado).gradient, in: RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Tarjeta de indicador (Resumen)
struct TarjetaIndicador: View {
    let titulo: String
    let valor: String
    var detalle: String? = nil
    let icono: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label(titulo, systemImage: icono)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(valor)
                .font(.title3.bold())
                .foregroundStyle(Tema.azulOscuro)
                .minimumScaleFactor(0.7)
                .lineLimit(1)
            if let detalle {
                Text(detalle)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Tema.naranja)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Tema.tarjeta, in: RoundedRectangle(cornerRadius: 16))
    }
}
