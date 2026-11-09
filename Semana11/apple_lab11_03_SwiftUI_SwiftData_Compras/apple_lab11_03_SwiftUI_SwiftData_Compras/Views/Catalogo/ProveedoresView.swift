import SwiftUI
import SwiftData

// B4 · Proveedores (comprador: consultar y buscar · supervisor: crear, editar y borrar)
struct ProveedoresView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]

    @State private var busqueda = ""
    @State private var mostrarNuevo = false
    @State private var proveedorAEditar: Proveedor?
    @State private var mensajeError: String?

    private var esSupervisor: Bool { sesion.usuario?.esSupervisor ?? false }

    private var filtrados: [Proveedor] {
        if busqueda.isEmpty { return proveedores }
        return proveedores.filter {
            $0.nombre.localizedCaseInsensitiveContains(busqueda) || $0.ruc.contains(busqueda)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    if filtrados.isEmpty {
                        Text(proveedores.isEmpty ? "Aún no hay proveedores." : "Sin resultados.")
                            .foregroundStyle(.secondary)
                    }
                    // ② Fila con insignia y total comprado
                    ForEach(filtrados) { proveedor in
                        FilaProveedor(proveedor: proveedor)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if esSupervisor { proveedorAEditar = proveedor }
                            }
                            .deleteDisabled(!esSupervisor)
                    }
                    .onDelete(perform: borrar)
                } footer: {
                    // ③ Nota de la relación
                    Text("\"por pagar\" y \"comprado\" se calculan con las compras del proveedor (relación proveedor ▸ compras).")
                }
            }
            .searchable(text: $busqueda, prompt: "Buscar por nombre o RUC")
            .navigationTitle("Proveedores")
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
                ProveedorFormView()
            }
            .sheet(item: $proveedorAEditar) { proveedor in
                ProveedorFormView(proveedor: proveedor)
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
            let proveedor = filtrados[index]
            if proveedor.compras.isEmpty {
                modelContext.delete(proveedor)
            } else {
                mensajeError = "\(proveedor.nombre) tiene \(proveedor.compras.count) compra(s) registradas."
            }
        }
        try? modelContext.save()
    }
}

// Fila de un proveedor
struct FilaProveedor: View {
    let proveedor: Proveedor

    var body: some View {
        HStack(spacing: 12) {
            IconoIniciales(texto: proveedor.nombre, color: Tema.azulOscuro)
            VStack(alignment: .leading, spacing: 2) {
                Text(proveedor.nombre)
                    .font(.subheadline.weight(.semibold))
                Text("RUC \(proveedor.ruc)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(Formato.soles(proveedor.totalComprado))
                    .font(.subheadline.weight(.semibold))
                if proveedor.cantidadPorPagar > 0 {
                    Insignia(texto: "\(proveedor.cantidadPorPagar) por pagar", color: Tema.naranja)
                } else {
                    Insignia(texto: "Al día", color: Tema.azul)
                }
            }
        }
        .padding(.vertical, 2)
    }
}
