import SwiftUI
import SwiftData

enum FiltroPago: String, CaseIterable {
    case pendientes = "Pendientes"
    case vencidas = "Vencidas"
    case pagadas = "Pagadas"
}

// B8 · Por pagar (solo supervisor)
struct PorPagarView: View {

    // Todas las compras aprobadas a crédito y sin pagar (para el total por pagar)
    @Query(filter: #Predicate<Compra> { c in
        c.alCredito && c.estado == "Aprobada" && c.pagada == false
    })
    private var porPagar: [Compra]

    @State private var filtro = FiltroPago.pendientes
    @State private var busqueda = ""

    // ⑤ Total por pagar
    private var totalPorPagar: Double {
        porPagar.reduce(0) { $0 + $1.total }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // ① Segmented Pendientes / Vencidas / Pagadas
                Picker("Filtro", selection: $filtro) {
                    ForEach(FiltroPago.allCases, id: \.self) { opcion in
                        Text(opcion.rawValue).tag(opcion)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical, 8)

                // La lista cambia su #Predicate según el filtro elegido
                ListaPorPagar(filtro: filtro, busqueda: busqueda, totalPorPagar: totalPorPagar)
            }
            .background(Tema.fondo)
            .searchable(text: $busqueda, prompt: "Buscar por proveedor")
            .navigationTitle("Por pagar")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AvatarMenu()
                }
            }
        }
    }
}

// Lista filtrada con #Predicate (Nivel +)
struct ListaPorPagar: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @Query private var compras: [Compra]

    let busqueda: String
    let totalPorPagar: Double

    init(filtro: FiltroPago, busqueda: String, totalPorPagar: Double) {
        self.busqueda = busqueda
        self.totalPorPagar = totalPorPagar

        // Valores guardados en constantes antes de usarlos en #Predicate
        let ahora = Date.now
        let aprobada = EstadoCompra.aprobada

        let predicado: Predicate<Compra>
        switch filtro {
        case .pendientes:
            predicado = #Predicate<Compra> { c in
                c.alCredito && c.estado == aprobada && c.pagada == false
            }
        case .vencidas:
            predicado = #Predicate<Compra> { c in
                c.alCredito && c.estado == aprobada && c.pagada == false && c.vence < ahora
            }
        case .pagadas:
            predicado = #Predicate<Compra> { c in
                c.alCredito && c.estado == aprobada && c.pagada == true
            }
        }
        _compras = Query(filter: predicado, sort: \Compra.vence)
    }

    private var esSupervisor: Bool { sesion.usuario?.esSupervisor ?? false }

    // Búsqueda por proveedor
    private var visibles: [Compra] {
        if busqueda.isEmpty { return compras }
        return compras.filter {
            ($0.proveedor?.nombre ?? "").localizedCaseInsensitiveContains(busqueda)
        }
    }

    var body: some View {
        List {
            Section {
                if visibles.isEmpty {
                    Text("No hay compras en este filtro.")
                        .foregroundStyle(.secondary)
                }
                // ② Compra a crédito · ③ Etiqueta VENCIDA
                ForEach(visibles) { compra in
                    FilaPorPagar(compra: compra)
                        // ④ Deslizar Pagar (solo supervisor)
                        .swipeActions(edge: .trailing) {
                            if esSupervisor && !compra.pagada {
                                Button {
                                    pagar(compra)
                                } label: {
                                    Label("Pagar", systemImage: "checkmark.circle.fill")
                                }
                                .tint(Tema.azul)
                            }
                        }
                }
            }

            // ⑤ Total por pagar
            Section {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total por pagar")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(Formato.soles(totalPorPagar))
                        .font(.title2.bold())
                        .foregroundStyle(Tema.azulOscuro)
                }
            } footer: {
                Text("Solo cuentan compras aprobadas a crédito y no pagadas. Desliza una fila a la izquierda para pagar.")
            }
        }
    }

    // Pagar: marca la compra como pagada y sale de Pendientes
    private func pagar(_ compra: Compra) {
        withAnimation {
            compra.pagada = true
            try? modelContext.save()
        }
    }
}

// Fila de una compra a crédito
struct FilaPorPagar: View {
    let compra: Compra

    var body: some View {
        HStack(spacing: 12) {
            IconoIniciales(texto: compra.proveedor?.nombre ?? "?", color: Tema.azulOscuro)
            VStack(alignment: .leading, spacing: 2) {
                Text(compra.proveedor?.nombre ?? "Sin proveedor")
                    .font(.subheadline.weight(.semibold))
                Text("\(compra.producto?.nombre ?? "—") × \(compra.cantidad) · vence \(Formato.fecha(compra.vence))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(Formato.soles(compra.total))
                    .font(.subheadline.weight(.semibold))
                if compra.pagada {
                    Insignia(texto: "Pagada", color: Tema.azul)
                } else if compra.estaVencida {
                    Insignia(texto: "VENCIDA", color: Tema.rojo)
                }
            }
        }
        .padding(.vertical, 2)
    }
}
