import Foundation

// ===== CASO 1.5: HERENCIA Y POLIMORFISMO — LA CADENA DE SUCURSALES =====
// Docente: Juan León

enum CategoriaElectro {
    case lineaBlanca, tecnologia, pequenos
}

struct Electrodomestico {
    let nombre: String
    let marca: String
    let precioLista: Double
    let categoria: CategoriaElectro
}

// --- Ejemplo (ya resuelto): la base define el FLUJO; las hijas cambiarán las REGLAS ---
class Sucursal {
    let nombre: String
    let ciudad: String
    
    init(nombre: String, ciudad: String) {
        self.nombre = nombre
        self.ciudad = ciudad
    }
    
    func descuento() -> Double {
        return 0.05
    }
    
    func costoEnvio(monto: Double) -> Double {
        return 30.0
    }
    
    // REGLA 2: este método NO se sobrescribe en las subclases
    final func cotizar(item: Electrodomestico) { // Se agregó 'final' para asegurar que no se sobrescriba
        let precioConDescuento = item.precioLista * (1 - descuento())
        let envio = costoEnvio(monto: precioConDescuento)
        let total = precioConDescuento + envio
        print("\(nombre): \(item.nombre) -> S/ \(precioConDescuento) + envío S/ \(envio) = S/ \(total)")
    }
}

// --- TODO 14: SucursalLima ---
class SucursalLima: Sucursal {
    override func descuento() -> Double {
        return 0.10
    }
    
    override func costoEnvio(monto: Double) -> Double {
        if monto >= 1500.0 {
            return 0.0
        } else {
            return 30.0
        }
    }
}

// --- TODO 15: SucursalProvincia ---
class SucursalProvincia: Sucursal {
    // NO se sobrescribe descuento(), hereda el 5% de la clase base automáticamente.
    
    override func costoEnvio(monto: Double) -> Double {
        let envioCalculado = monto * 0.08
        if envioCalculado < 50.0 {
            return 50.0
        } else {
            return envioCalculado
        }
    }
}

// --- TODO 16: SucursalOutlet ---
class SucursalOutlet: Sucursal {
    override func descuento() -> Double {
        return 0.25
    }
    
    override func costoEnvio(monto: Double) -> Double {
        return 0.0
    }
}

// --- TODO 18: La prueba del polimorfismo (REGLA 6) ---
// Agregamos SucursalOnline antes de armar el array para demostrar el polimorfismo.
class SucursalOnline: Sucursal {
    override func costoEnvio(monto: Double) -> Double {
        return 15.0
    }
}

// --- TODO 17: El recorrido polimórfico (REGLA 4) ---
let refrigeradora = Electrodomestico(nombre: "Refrigeradora", marca: "Frost", precioLista: 2000.0, categoria: .lineaBlanca)
let licuadora = Electrodomestico(nombre: "Licuadora", marca: "Mix", precioLista: 250.0, categoria: .pequenos)

// Array polimórfico que incluye la nueva sucursal sin alterar la lógica de ejecución
let sucursales: [Sucursal] = [
    SucursalLima(nombre: "Lima Centro", ciudad: "Lima"),
    SucursalProvincia(nombre: "Provincia Cusco", ciudad: "Cusco"),
    SucursalOutlet(nombre: "Outlet Ate", ciudad: "Lima"),
    SucursalOnline(nombre: "Tienda Web", ciudad: "Digital") // Agregada aquí
]

print("===== Refrigeradora (S/ 2000.0) =====")
for sucursal in sucursales {
    sucursal.cotizar(item: refrigeradora)
}

print("\n===== Licuadora (S/ 250.0) =====")
for sucursal in sucursales {
    sucursal.cotizar(item: licuadora)
}

// RESPUESTA AL TODO 18:
// Se necesitaron exactamente 7 líneas nuevas de código para implementar 'SucursalOnline'
// e integrarla al array (5 líneas de la clase + 1 línea en el array + 1 línea de comentario explicativo).
// Gracias al polimorfismo, NO se modificó ninguna línea de los bucles 'for-in' ni del método 'cotizar'.

// ===== FIX: Este código tiene 2 errores =====
// Docente: Juan León

class SucursalMall: Sucursal {
    // SOLUCIÓN FIX 7: Se agrega 'override' porque el método ya existe en la clase padre.
    override func descuento() -> Double {
        return 0.12
    }
}

class SucursalExpress: Sucursal {
    let radioKm: Int
    
    init(nombre: String, ciudad: String, radioKm: Int) {
        self.radioKm = radioKm
        // SOLUCIÓN FIX 8: Se llama al inicializador del padre después de configurar las variables propias.
        super.init(nombre: nombre, ciudad: ciudad)
    }
}

// ===== PREDICT: ¿Qué imprime? =====
// Docente: Juan León

let misteriosa: Sucursal = SucursalLima(nombre: "Lima Centro", ciudad: "Lima")

print(misteriosa.descuento())
// Imprime: 0.1

let monto = 2000.0 * (1 - misteriosa.descuento()) // monto = 2000 * 0.9 = 1800.0

print(misteriosa.costoEnvio(monto: monto))
// Imprime: 0.0

// ===== CASO 2 — PARTE A: BIBLIOTECA (SIN IA) =====
// Docente: Juan León
// TODO 19: escribe aquí el enum, el struct, la clase y la simulación

import Foundation

enum EstadoLibro {
    case disponible
    case prestado
}

struct Libro {
    let titulo: String
    let autor: String
    var estado: EstadoLibro = .disponible
}

class Biblioteca {
    var libros: [Libro] = []
    
    func agregar(libro: Libro) {
        libros.append(libro)
    }
    
    @discardableResult
    func prestar(titulo: String) -> Bool {
        for i in 0..<libros.count {
            if libros[i].titulo == titulo {
                if libros[i].estado == .disponible {
                    libros[i].estado = .prestado
                    print("Préstamo aprobado: \(titulo)")
                    return true
                } else {
                    print("Error: \(titulo) ya está prestado")
                    return false
                }
            }
        }
        print("Error: no existe \(titulo)")
        return false
    }
    
    @discardableResult
    func devolver(titulo: String) -> Bool {
        for i in 0..<libros.count {
            if libros[i].titulo == titulo {
                if libros[i].estado == .prestado {
                    libros[i].estado = .disponible
                    print("Devolución registrada: \(titulo)")
                    return true
                } else {
                    print("Error: \(titulo) ya está disponible")
                    return false
                }
            }
        }
        print("Error: no existe \(titulo)")
        return false
    }
}
