import SwiftUI
import SwiftData

// B3 · Productos (comprador: consultar y buscar · supervisor: crear, editar y borrar)
struct ProductosView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @Query(sort: \Producto.nombre) private var productos: [Producto]

    @State private var busqueda = ""
    @State private var mostrarNuevo = false
    @State private var productoAEditar: Producto?
    @State private var mensajeError: String?

    private var esSupervisor: Bool { sesion.usuario?.esSupervisor ?? false }

    // ② Búsqueda por nombre o categoría
    private var filtrados: [Producto] {
        if busqueda.isEmpty { return productos }
        return productos.filter {
            $0.nombre.localizedCaseInsensitiveContains(busqueda) ||
            $0.categoria.localizedCaseInsensitiveContains(busqueda)
        }
    }

    // ④ Valor del inventario = Σ stock × costo promedio
    private var valorInventario: Double {
        productos.reduce(0) { $0 + $1.valorInventario }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    if filtrados.isEmpty {
                        Text(productos.isEmpty ? "Aún no hay productos." : "Sin resultados.")
                            .foregroundStyle(.secondary)
                    }
                    // ③ Fila con costo promedio y stock en color
                    ForEach(filtrados) { producto in
                        FilaProducto(producto: producto)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if esSupervisor { productoAEditar = producto }
                            }
                            .deleteDisabled(!esSupervisor)      // ⑤ Solo el supervisor borra
                    }
                    .onDelete(perform: borrar)
                } footer: {
                    if esSupervisor {
                        Text("Toca un producto para editarlo. Desliza para borrar: bloqueado si tiene compras.")
                    }
                }

                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Valor del inventario (stock × costo promedio)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(Formato.soles(valorInventario))
                            .font(.title2.bold())
                            .foregroundStyle(Tema.azulOscuro)
                    }
                }
            }
            .searchable(text: $busqueda, prompt: "Buscar producto o categoría")
            .navigationTitle("Productos")
            .toolbar {
                // ① Botón + (solo supervisor)
                if esSupervisor {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            mostrarNuevo = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    AvatarMenu()
                }
            }
            .sheet(isPresented: $mostrarNuevo) {
                ProductoFormView()
            }
            .sheet(item: $productoAEditar) { producto in
                ProductoFormView(producto: producto)
            }
            .alert("No se puede eliminar", isPresented: hayError) {
                Button("Entendido", role: .cancel) {}
            } message: {
                Text(mensajeError ?? "")
            }
        }
    }

    private var hayError: Binding<Bool> {
        Binding(get: { mensajeError != nil }, set: { if !$0 { mensajeError = nil } })
    }

    // Regla .deny: no se borra si tiene compras
    private func borrar(_ offsets: IndexSet) {
        for index in offsets {
            let producto = filtrados[index]
            if producto.compras.isEmpty {
                modelContext.delete(producto)
            } else {
                mensajeError = "\(producto.nombre) tiene \(producto.compras.count) compra(s) registradas."
            }
        }
        try? modelContext.save()
    }
}

// Fila de un producto
struct FilaProducto: View {
    let producto: Producto

    var body: some View {
        HStack(spacing: 12) {
            IconoIniciales(texto: producto.nombre)
            VStack(alignment: .leading, spacing: 2) {
                Text(producto.nombre)
                    .font(.subheadline.weight(.semibold))
                Text(producto.categoria)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(Formato.soles(producto.costoPromedio))
                    .font(.subheadline.weight(.semibold))
                Text("costo prom.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            ChipStock(stock: producto.stock)
        }
        .padding(.vertical, 2)
    }
}
