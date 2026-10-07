// Desarrollado por: Sebastian Salas
import UIKit

// 1. Clase Producto: Representa los electrodomésticos base de la tienda
class Producto {
    let nombre: String
    let precio: Double
    var stock: Int
    
    init(nombre: String, precio: Double, stock: Int) {
        self.nombre = nombre
        self.precio = precio
        self.stock = stock
    }
}

// 2. Clase ItemCarrito: Representa una línea dentro del carrito (un producto y su cantidad)
class ItemCarrito {
    let producto: Producto
    var cantidad: Int
    
    init(producto: Producto, cantidad: Int) {
        self.producto = producto
        self.cantidad = cantidad
    }
    
    // Ejemplo resuelto por el laboratorio: calcula el subtotal de esta línea
    func subtotal() -> Double {
        return producto.precio * Double(cantidad)
    }
}

// 3. Clase ClienteModel: Reutilizada del Ejercicio 2 anterior (Campos obligatorios)
class ClienteModel {
    var apellidos: String
    var nombres: String
    var dni: String
    
    init(apellidos: String, nombres: String, dni: String) {
        self.apellidos = apellidos
        self.nombres = nombres
        self.dni = dni
    }
}

// 4. Clase CarritoModel: Maneja la lógica global de la compra (Aquí resolvemos los TODO)
class CarritoModel {
    var items: [ItemCarrito] = []
    
    // TODO A1: Agregar producto al carrito validando el stock global
    func agregar(producto: Producto, cantidad: Int) -> Bool {
        // Buscar si el producto ya existe en el carrito
        let itemExistente = items.first(where: { $0.producto.nombre == producto.nombre })
        let cantidadActualEnCarrito = itemExistente?.cantidad ?? 0
        
        // Regla 8: Validar que la cantidad acumulada no supere el stock disponible
        if (cantidadActualEnCarrito + cantidad) > producto.stock {
            return false // No se agrega nada, stock insuficiente
        }
        
        if let item = itemExistente {
            // Si ya está, sumamos la cantidad a la línea existente
            item.cantidad += cantidad
        } else {
            // Si es nuevo, creamos un ItemCarrito y lo añadimos al array
            let nuevoItem = ItemCarrito(producto: producto, cantidad: cantidad)
            items.append(nuevoItem)
        }
        return true
    }
    
    // TODO A2: Suma de los subtotales de cada línea de producto
    func subtotal() -> Double {
        return items.reduce(0.0) { $0 + $1.subtotal() }
    }
    
    // TODO A3: Determinar el porcentaje de descuento por tramos (Regla 6)
    func porcentajeDescuento() -> Double {
        let montoSubtotal = subtotal()
        if montoSubtotal >= 5000 {
            return 0.15  // 15%
        } else if montoSubtotal >= 2000 {
            return 0.10  // 10%
        } else if montoSubtotal >= 500 {
            return 0.05  // 5%
        } else {
            return 0.0   // 0%
        }
    }
    
    // Funciones complementarias para cálculos monetarios
    func montoDescuento() -> Double {
        return subtotal() * porcentajeDescuento()
    }
    
    func igv() -> Double {
        // Regla 6: El IGV (18%) se calcula sobre el monto YA descontado
        let montoConDescuento = subtotal() - montoDescuento()
        return montoConDescuento * 0.18
    }
    
    func total() -> Double {
        let montoConDescuento = subtotal() - montoDescuento()
        return montoConDescuento + igv()
    }
    
    // Regla 7: Obtener la categoría del cliente según el subtotal
    func categoriaCliente() -> String {
        let montoSubtotal = Int(subtotal())
        switch montoSubtotal {
        case ..<500:
            return "Regular"
        case 500...1999:
            return "Frecuente"
        case 2000...4999:
            return "VIP"
        default:
            return "Premium" // 5000 o más
        }
    }
    
    // TODO A4: Suma de las unidades/cantidades totales en el carrito
    func cantidadTotal() -> Int {
        return items.reduce(0) { $0 + $1.cantidad }
    }
    
    // TODO A5: Vaciar por completo las líneas del carrito al finalizar la compra
    func vaciar() {
        items.removeAll()
    }
}

