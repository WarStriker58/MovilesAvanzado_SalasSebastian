import SwiftUI
import SwiftData

enum FiltroMisCompras: String, CaseIterable {
    case todas = "Todas"
    case pendientes = "Pendientes"
    case rechazadas = "Rechazadas"
}

// B6 · Mis compras (el comprador solo ve las suyas)
struct MisComprasView: View {
    @Environment(Sesion.self) private var sesion

    @Query(sort: \Compra.fecha, order: .reverse) private var compras: [Compra]

    @State private var filtro = FiltroMisCompras.todas
    @State private var busqueda = ""

    // ④ Solo las compras del usuario de la sesión (relación compra ▸ comprador)
    private var misCompras: [Compra] {
        guard let usuario = sesion.usuario else { return [] }
        return compras.filter { $0.comprador?.persistentModelID == usuario.persistentModelID }
    }

    private var visibles: [Compra] {
        misCompras.filter { cumpleFiltro($0) && coincideBusqueda($0) }
    }

    private func cumpleFiltro(_ compra: Compra) -> Bool {
        switch filtro {
        case .todas: return true
        case .pendientes: return compra.estado == EstadoCompra.pendiente
        case .rechazadas: return compra.estado == EstadoCompra.rechazada
        }
    }

    private func coincideBusqueda(_ compra: Compra) -> Bool {
        busqueda.isEmpty || (compra.proveedor?.nombre ?? "").localizedCaseInsensitiveContains(busqueda)
    }

    var body: some View {
        NavigationStack {
            List {
                // ① Segmented Todas / Pendientes / Rechazadas
                Section {
                    Picker("Filtro", selection: $filtro) {
                        ForEach(FiltroMisCompras.allCases, id: \.self) { opcion in
                            Text(opcion.rawValue).tag(opcion)
                        }
                    }
                    .pickerStyle(.segmented)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }

                Section {
                    if visibles.isEmpty {
                        Text("No hay compras en este filtro.")
                            .foregroundStyle(.secondary)
                    }
                    // ② Pendiente · ③ Rechazada con su motivo
                    ForEach(visibles) { compra in
                        FilaCompra(compra: compra)
                    }
                } footer: {
                    Text("Solo ves tus compras. Aprobar y pagar lo hace el supervisor.")
                }
            }
            .searchable(text: $busqueda, prompt: "Buscar por proveedor")
            .navigationTitle("Mis compras")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AvatarMenu()
                }
            }
        }
    }
}

// Fila de una compra (usada en Mis compras)
struct FilaCompra: View {
    let compra: Compra

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            IconoEstado(estado: compra.estado)
            VStack(alignment: .leading, spacing: 3) {
                Text(compra.proveedor?.nombre ?? "Sin proveedor")
                    .font(.subheadline.weight(.semibold))
                Text("\(compra.producto?.nombre ?? "—") × \(compra.cantidad) · \(Formato.fecha(compra.fecha))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(compra.alCredito ? "Crédito · vence \(Formato.fecha(compra.vence))" : "Contado")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                if compra.estado == EstadoCompra.rechazada, let motivo = compra.motivoRechazo {
                    Text("Motivo: \(motivo)")
                        .font(.caption)
                        .foregroundStyle(Tema.rojo)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(Formato.soles(compra.total))
                    .font(.subheadline.weight(.semibold))
                Insignia(texto: compra.estado, color: Tema.color(estado: compra.estado))
                if compra.estaVencida {
                    Insignia(texto: "VENCIDA", color: Tema.rojo)
                }
            }
        }
        .padding(.vertical, 2)
    }
}
