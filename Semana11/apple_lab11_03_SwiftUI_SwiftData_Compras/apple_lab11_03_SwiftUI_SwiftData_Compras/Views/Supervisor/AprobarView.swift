import SwiftUI
import SwiftData

// B7 · Aprobar (solo supervisor)
struct AprobarView: View {
    @Environment(\.modelContext) private var modelContext

    // Solo las compras pendientes, más antiguas primero
    @Query(filter: #Predicate<Compra> { $0.estado == "Pendiente" }, sort: \Compra.fecha)
    private var pendientes: [Compra]

    @State private var compraARechazar: Compra?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if pendientes.isEmpty {
                        ContentUnavailableView("Nada por aprobar",
                                               systemImage: "checkmark.seal",
                                               description: Text("Las compras desde S/ 5,000 aparecerán aquí."))
                            .padding(.top, 60)
                    }
                    // ② Tarjeta de cada compra pendiente
                    ForEach(pendientes) { compra in
                        TarjetaAprobacion(
                            compra: compra,
                            aprobar: { aprobar(compra) },
                            rechazar: { compraARechazar = compra }
                        )
                    }
                    if !pendientes.isEmpty {
                        Text("Al rechazar se pide un motivo, que el comprador verá en \"Mis compras\".")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
            .background(Tema.fondo)
            .navigationTitle("Aprobar")
            .toolbar {
                // ① Avatar de la sesión
                ToolbarItem(placement: .topBarTrailing) {
                    AvatarMenu()
                }
            }
            .sheet(item: $compraARechazar) { compra in
                RechazoView(compra: compra)
            }
        }
    }

    // Aprobar: cambia el estado y AHORA sí aplica stock y costo promedio
    private func aprobar(_ compra: Compra) {
        withAnimation {
            compra.estado = EstadoCompra.aprobada
            Reglas.aplicarEfectos(de: compra)
            try? modelContext.save()
        }
    }
}

// Tarjeta de una compra pendiente
struct TarjetaAprobacion: View {
    let compra: Compra
    let aprobar: () -> Void
    let rechazar: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(compra.proveedor?.nombre ?? "—") · \(compra.producto?.nombre ?? "—")")
                        .font(.headline)
                    // Quién la solicitó (relación compra ▸ comprador)
                    Text("Solicitó: \(compra.comprador?.nombre ?? "—") · \(Formato.fecha(compra.fecha))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Insignia(texto: EstadoCompra.pendiente, color: Tema.naranja)
            }

            Divider()

            Text("\(compra.cantidad) u. × \(Formato.soles(compra.costoUnitario)) = \(Formato.soles(compra.subtotal))")
                .font(.subheadline)
            Text("IGV 18 % \(Formato.soles(compra.igv)) · Total \(Formato.soles(compra.total))")
                .font(.subheadline.weight(.semibold))
            Text(compra.alCredito ? "Crédito 30 días · vence \(Formato.fecha(compra.vence))" : "Contado")
                .font(.caption)
                .foregroundStyle(.secondary)

            // ③ Vista previa del efecto: stock y costo promedio antes y después
            if let producto = compra.producto {
                let nuevoCosto = Reglas.nuevoCostoPromedio(
                    stock: producto.stock,
                    costoPromedio: producto.costoPromedio,
                    cantidad: compra.cantidad,
                    costoUnitario: compra.costoUnitario
                )
                VStack(alignment: .leading, spacing: 4) {
                    Text("Si apruebas:")
                        .fontWeight(.semibold)
                    Text("Stock \(producto.stock) → \(producto.stock + compra.cantidad)")
                    Text("Costo promedio \(Formato.soles(producto.costoPromedio)) → \(Formato.soles(nuevoCosto))")
                }
                .font(.caption)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Tema.azul.opacity(0.08), in: RoundedRectangle(cornerRadius: 10))
            }

            // ④ Rechazar (pide motivo) o Aprobar
            HStack(spacing: 12) {
                Button(role: .destructive, action: rechazar) {
                    Text("Rechazar").frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)

                Button(action: aprobar) {
                    Text("Aprobar").frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .controlSize(.large)
        }
        .padding()
        .background(Tema.tarjeta, in: RoundedRectangle(cornerRadius: 16))
    }
}

// Hoja para rechazar con motivo obligatorio
struct RechazoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let compra: Compra
    @State private var motivo = ""

    private var motivoLimpio: String {
        motivo.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Compra") {
                    LabeledContent("Proveedor", value: compra.proveedor?.nombre ?? "—")
                    LabeledContent("Solicitó", value: compra.comprador?.nombre ?? "—")
                    LabeledContent("Total", value: Formato.soles(compra.total))
                }
                Section {
                    TextField("Escribe el motivo", text: $motivo, axis: .vertical)
                        .lineLimit(3...6)
                } header: {
                    Text("Motivo del rechazo (obligatorio)")
                } footer: {
                    Text("Rechazar no cambia stock, costo promedio ni cuentas por pagar.")
                }
            }
            .navigationTitle("Rechazar compra")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Rechazar", role: .destructive, action: rechazar)
                        .disabled(motivoLimpio.isEmpty)     // Sin motivo no se puede
                }
            }
        }
        .presentationDetents([.medium, .large])
    }

    private func rechazar() {
        compra.estado = EstadoCompra.rechazada
        compra.motivoRechazo = motivoLimpio
        try? modelContext.save()
        dismiss()
    }
}
