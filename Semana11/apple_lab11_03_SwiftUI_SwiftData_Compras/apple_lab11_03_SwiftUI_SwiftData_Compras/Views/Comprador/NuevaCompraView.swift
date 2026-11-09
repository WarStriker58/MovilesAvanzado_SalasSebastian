import SwiftUI
import SwiftData

// B5 · Nueva compra (solo comprador)
struct NuevaCompraView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(Sesion.self) private var sesion

    @Query(sort: \Proveedor.nombre) private var proveedores: [Proveedor]
    @Query(sort: \Producto.nombre) private var productos: [Producto]

    @State private var proveedor: Proveedor?
    @State private var producto: Producto?
    @State private var cantidad = 1
    @State private var costoUnitario = 0.0
    @State private var fecha = Date.now
    @State private var alCredito = false
    @State private var mensaje: String?

    // Cálculos en vivo
    private var calculo: (subtotal: Double, igv: Double, total: Double) {
        Reglas.calcular(cantidad: cantidad, costo: costoUnitario)
    }
    private var requiereAprobacion: Bool {
        Reglas.requiereAprobacion(total: calculo.total)
    }
    private var esValido: Bool {
        proveedor != nil && producto != nil && cantidad > 0 && costoUnitario > 0
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Datos de la compra") {
                    // ② Proveedor
                    Picker("Proveedor", selection: $proveedor) {
                        Text("Elegir").tag(Proveedor?.none)
                        ForEach(proveedores) { item in
                            Text(item.nombre).tag(Optional(item))
                        }
                    }
                    // ③ Producto
                    Picker("Producto", selection: $producto) {
                        Text("Elegir").tag(Producto?.none)
                        ForEach(productos) { item in
                            Text(item.nombre).tag(Optional(item))
                        }
                    }
                    // ④ Cantidad
                    HStack {
                        Text("Cantidad")
                        Spacer()
                        TextField("0", value: $cantidad, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 90)
                    }
                    // Costo unitario: lo escribe el comprador (empieza con el costo promedio)
                    HStack {
                        Text("Costo unitario (S/)")
                        Spacer()
                        TextField("0.00", value: $costoUnitario, format: .number.precision(.fractionLength(2)))
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 110)
                    }
                    // Fecha de registro (permite probar compras vencidas)
                    DatePicker("Fecha", selection: $fecha, displayedComponents: .date)
                }

                // ⑤ Contado o Crédito 30 días
                Section("Forma de pago") {
                    Picker("Pago", selection: $alCredito) {
                        Text("Contado").tag(false)
                        Text("Crédito 30 días").tag(true)
                    }
                    .pickerStyle(.segmented)
                    if alCredito {
                        LabeledContent("Vence", value: Formato.fecha(Reglas.vencimiento(desde: fecha)))
                    }
                }

                Section("Resumen") {
                    LabeledContent("Subtotal", value: Formato.soles(calculo.subtotal))
                    LabeledContent("IGV 18 %", value: Formato.soles(calculo.igv))
                    LabeledContent {
                        Text(Formato.soles(calculo.total)).bold()
                    } label: {
                        Text("Total").bold()
                    }
                }

                // ⑥ Aviso cuando el total llega a S/ 5,000
                if requiereAprobacion {
                    Section {
                        Label("Supera S/ 5,000: quedará pendiente de aprobación del supervisor. No cambia stock ni costo promedio todavía.",
                              systemImage: "exclamationmark.triangle.fill")
                            .font(.footnote)
                            .foregroundStyle(Tema.naranja)
                    }
                }

                // ⑦ Enviar a aprobación / Registrar compra
                Section {
                    Button(requiereAprobacion ? "Enviar a aprobación" : "Registrar compra", action: registrar)
                        .buttonStyle(BotonPrincipal())
                        .disabled(!esValido)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Nueva compra")
            .toolbar {
                // ① Avatar de la sesión
                ToolbarItem(placement: .topBarTrailing) {
                    AvatarMenu()
                }
            }
            // Al elegir producto, el costo unitario empieza con su costo promedio
            .onChange(of: producto) { _, nuevo in
                costoUnitario = nuevo?.costoPromedio ?? 0
            }
            .alert("Compra registrada", isPresented: hayMensaje) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(mensaje ?? "")
            }
        }
    }

    private var hayMensaje: Binding<Bool> {
        Binding(get: { mensaje != nil }, set: { if !$0 { mensaje = nil } })
    }

    private func registrar() {
        guard let usuario = sesion.usuario, let proveedor, let producto else { return }

        let valores = calculo
        let estado = requiereAprobacion ? EstadoCompra.pendiente : EstadoCompra.aprobada

        // CREATE: primero insertamos, luego enlazamos las relaciones
        let compra = Compra(
            fecha: fecha,
            cantidad: cantidad,
            costoUnitario: costoUnitario,
            igv: valores.igv,
            total: valores.total,
            alCredito: alCredito,
            vence: alCredito ? Reglas.vencimiento(desde: fecha) : fecha,
            estado: estado,
            pagada: !alCredito              // Contado: queda pagada
        )
        modelContext.insert(compra)
        compra.comprador = usuario          // Quién la registró
        compra.proveedor = proveedor
        compra.producto = producto

        // Aprobada al instante: se aplican stock y costo promedio
        if estado == EstadoCompra.aprobada {
            Reglas.aplicarEfectos(de: compra)
        }

        do {
            try modelContext.save()
        } catch {
            print("Error al guardar la compra: \(error)")
        }

        if estado == EstadoCompra.aprobada {
            mensaje = "Aprobada por \(Formato.soles(valores.total)). Stock de \(producto.nombre): \(producto.stock) · costo promedio \(Formato.soles(producto.costoPromedio))."
        } else {
            mensaje = "Total \(Formato.soles(valores.total)). Quedó pendiente de aprobación del supervisor."
        }

        limpiar()
    }

    private func limpiar() {
        proveedor = nil
        producto = nil
        cantidad = 1
        costoUnitario = 0
        alCredito = false
        fecha = .now
    }
}
