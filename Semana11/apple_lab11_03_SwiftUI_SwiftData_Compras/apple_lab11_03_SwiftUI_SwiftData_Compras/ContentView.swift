import SwiftUI
import SwiftData

// Pantalla raíz: si hay sesión muestra las pestañas del rol, si no el Login.
struct ContentView: View {
    @Environment(Sesion.self) private var sesion

    var body: some View {
        Group {
            if let usuario = sesion.usuario {
                PrincipalView(usuario: usuario)
            } else {
                LoginView()
            }
        }
        .animation(.default, value: sesion.usuario == nil)
    }
}

// TabView cuyas pestañas dependen del rol
struct PrincipalView: View {
    let usuario: Usuario

    var body: some View {
        if usuario.esSupervisor {
            TabView {
                ResumenView()
                    .tabItem { Label("Resumen", systemImage: "chart.bar.fill") }
                AprobarView()
                    .tabItem { Label("Aprobar", systemImage: "checkmark.seal.fill") }
                PorPagarView()
                    .tabItem { Label("Por pagar", systemImage: "creditcard.fill") }
                ProductosView()
                    .tabItem { Label("Productos", systemImage: "shippingbox.fill") }
                ProveedoresView()
                    .tabItem { Label("Proveedores", systemImage: "building.2.fill") }
            }
        } else {
            TabView {
                ProductosView()
                    .tabItem { Label("Productos", systemImage: "shippingbox.fill") }
                ProveedoresView()
                    .tabItem { Label("Proveedores", systemImage: "building.2.fill") }
                NuevaCompraView()
                    .tabItem { Label("Compra", systemImage: "cart.fill.badge.plus") }
                MisComprasView()
                    .tabItem { Label("Mis compras", systemImage: "list.bullet.rectangle.fill") }
            }
        }
    }
}
