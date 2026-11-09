import SwiftUI
import SwiftData

// Crear o editar un producto (solo supervisor)
struct ProductoFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let producto: Producto?     // nil = nuevo

    @State private var nombre: String
    @State private var categoria: String
    @State private var stock: Int
    @State private var costoPromedio: Double

    init(producto: Producto? = nil) {
        self.producto = producto
        _nombre = State(initialValue: producto?.nombre ?? "")
        _categoria = State(initialValue: producto?.categoria ?? "")
        _stock = State(initialValue: producto?.stock ?? 0)
        _costoPromedio = State(initialValue: producto?.costoPromedio ?? 0)
    }

    private var esValido: Bool {
        !nombre.trimmingCharacters(in: .whitespaces).isEmpty &&
        !categoria.trimmingCharacters(in: .whitespaces).isEmpty &&
        stock >= 0 && costoPromedio >= 0
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Datos del producto") {
                    TextField("Nombre", text: $nombre)
                    TextField("Categoría", text: $categoria)
                }
                Section("Inventario") {
                    HStack {
                        Text("Stock")
                        Spacer()
                        TextField("0", value: $stock, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Costo promedio (S/)")
                        Spacer()
                        TextField("0.00", value: $costoPromedio, format: .number.precision(.fractionLength(2)))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle(producto == nil ? "Nuevo producto" : "Editar producto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar", action: guardar)
                        .disabled(!esValido)
                }
            }
        }
    }

    private func guardar() {
        let nombreLimpio = nombre.trimmingCharacters(in: .whitespaces)
        let categoriaLimpia = categoria.trimmingCharacters(in: .whitespaces)

        if let producto {
            // UPDATE: basta cambiar las propiedades
            producto.nombre = nombreLimpio
            producto.categoria = categoriaLimpia
            producto.stock = stock
            producto.costoPromedio = costoPromedio
        } else {
            // CREATE
            let nuevo = Producto(nombre: nombreLimpio, categoria: categoriaLimpia,
                                 stock: stock, costoPromedio: costoPromedio)
            modelContext.insert(nuevo)
        }
        try? modelContext.save()
        dismiss()
    }
}
