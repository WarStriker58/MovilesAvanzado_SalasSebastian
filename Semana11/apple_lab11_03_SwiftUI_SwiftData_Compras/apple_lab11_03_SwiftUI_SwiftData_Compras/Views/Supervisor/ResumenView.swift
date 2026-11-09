import SwiftUI
import SwiftData
import Charts

// Dato para el gráfico de barras
struct TotalProveedor: Identifiable {
    let nombre: String
    let total: Double
    var id: String { nombre }
}

// B9 · Resumen del supervisor
struct ResumenView: View {
    @Environment(Sesion.self) private var sesion

    @Query private var productos: [Producto]
    @Query private var proveedores: [Proveedor]
    @Query private var compras: [Compra]

    private var aprobadas: [Compra] {
        compras.filter { $0.estado == EstadoCompra.aprobada }
    }
    private var pendientes: [Compra] {
        compras.filter { $0.estado == EstadoCompra.pendiente }
    }

    // ② Valor del inventario
    private var inventario: Double {
        productos.reduce(0) { $0 + $1.valorInventario }
    }
    // ③ Crédito fiscal = IGV de las compras aprobadas
    private var creditoFiscal: Double {
        aprobadas.reduce(0) { $0 + $1.igv }
    }
    // Por pagar = aprobadas a crédito sin pagar
    private var porPagar: Double {
        aprobadas.filter { $0.estaPorPagar }.reduce(0) { $0 + $1.total }
    }
    // ④ Compras por aprobar (importe)
    private var importePorAprobar: Double {
        pendientes.reduce(0) { $0 + $1.total }
    }
    // ⑤ Total comprado por proveedor
    private var datos: [TotalProveedor] {
        proveedores
            .map { TotalProveedor(nombre: $0.nombre, total: $0.totalComprado) }
            .filter { $0.total > 0 }
            .sorted { $0.total > $1.total }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Hola, \(sesion.usuario?.nombre ?? "") · \(sesion.usuario?.rol ?? "")")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 12),
                                        GridItem(.flexible(), spacing: 12)], spacing: 12) {
                        TarjetaIndicador(titulo: "Inventario", valor: Formato.soles(inventario),
                                         icono: "shippingbox.fill")
                        TarjetaIndicador(titulo: "Crédito fiscal", valor: Formato.soles(creditoFiscal),
                                         icono: "percent")
                        TarjetaIndicador(titulo: "Por pagar", valor: Formato.soles(porPagar),
                                         icono: "creditcard.fill")
                        TarjetaIndicador(titulo: "Por aprobar", valor: "\(pendientes.count)",
                                         detalle: Formato.soles(importePorAprobar),
                                         icono: "hourglass")
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Total comprado por proveedor")
                            .font(.headline)
                        if datos.isEmpty {
                            Text("Aún no hay compras aprobadas.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        } else {
                            Chart(datos) { item in
                                BarMark(
                                    x: .value("Total", item.total),
                                    y: .value("Proveedor", item.nombre)
                                )
                                .foregroundStyle(Tema.azul.gradient)
                                .cornerRadius(6)
                                .annotation(position: .trailing) {
                                    Text(Formato.soles(item.total))
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .chartXAxis(.hidden)
                            .chartXScale(domain: 0...((datos.first?.total ?? 1) * 1.45))
                            .frame(height: CGFloat(datos.count) * 48 + 16)
                        }
                    }
                    .padding()
                    .background(Tema.tarjeta, in: RoundedRectangle(cornerRadius: 16))
                }
                .padding()
            }
            .background(Tema.fondo)
            .navigationTitle("Resumen")
            .toolbar {
                // ① Avatar de la sesión
                ToolbarItem(placement: .topBarTrailing) {
                    AvatarMenu()
                }
            }
        }
    }
}
