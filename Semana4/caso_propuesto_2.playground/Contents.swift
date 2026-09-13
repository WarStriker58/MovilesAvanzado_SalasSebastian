import Foundation

// base cliente
class Cliente {
    var codigo: String
    var direccion: String
    var fechaDeRegistro: String
    var numeroCuenta: String
    var montoMinimoApertura: Double
    
    init(codigo: String, direccion: String, fechaDeRegistro: String, numeroCuenta: String, montoMinimoApertura: Double) {
        self.codigo = codigo
        self.direccion = direccion
        self.fechaDeRegistro = fechaDeRegistro
        self.numeroCuenta = numeroCuenta
        self.montoMinimoApertura = montoMinimoApertura
    }
    
    func mostrarDatos() {
        print("📄 Código: \(codigo)")
        print("📍 Dirección: \(direccion)")
        print("📅 Fecha de registro: \(fechaDeRegistro)")
        print("🏦 Nº Cuenta: \(numeroCuenta)")
        print("💰 Monto mínimo de apertura: S/ \(montoMinimoApertura)")
    }
}

// agregar cliente natural
class ClienteNatural: Cliente {
    var nombreCompleto: String
    var dni: String
    
    init(codigo: String, direccion: String, fechaDeRegistro: String, numeroCuenta: String, montoMinimoApertura: Double, nombreCompleto: String, dni: String) {
        self.nombreCompleto = nombreCompleto
        self.dni = dni
        super.init(codigo: codigo, direccion: direccion, fechaDeRegistro: fechaDeRegistro, numeroCuenta: numeroCuenta, montoMinimoApertura: montoMinimoApertura)
    }
    
    override func mostrarDatos() {
        print("👤 Cliente Natural:")
        print("Nombre: \(nombreCompleto)")
        print("DNI: \(dni)")
        super.mostrarDatos()
    }
}

// agregar cliente juridico
class ClienteJuridico: Cliente {
    var razonSocial: String
    var ruc: String
    var representanteLegal: String
    
    init(codigo: String, direccion: String, fechaDeRegistro: String, numeroCuenta: String, montoMinimoApertura: Double, razonSocial: String, ruc: String, representanteLegal: String) {
        self.razonSocial = razonSocial
        self.ruc = ruc
        self.representanteLegal = representanteLegal
        super.init(codigo: codigo, direccion: direccion, fechaDeRegistro: fechaDeRegistro, numeroCuenta: numeroCuenta, montoMinimoApertura: montoMinimoApertura)
    }
    
    override func mostrarDatos() {
        print("🏢 Cliente Jurídico:")
        print("Razón Social: \(razonSocial)")
        print("RUC: \(ruc)")
        print("Representante Legal: \(representanteLegal)")
        super.mostrarDatos()
    }
}

// registro y validacion de clientes
var listaClientes: [Cliente] = []
var continuar = true

print("=== SISTEMA DE REGISTRO DE CLIENTES ===")

while continuar {
    
    var opcion = ""
    while opcion != "1" && opcion != "2" {
        print("\n¿Qué tipo de cliente desea registrar?")
        print("1. Cliente Natural")
        print("2. Cliente Jurídico")
        print("Seleccione una opción (1 o 2): ", terminator: "")
        opcion = readLine() ?? ""
        if opcion != "1" && opcion != "2" {
            print("❌ Opción inválida. Ingrese 1 o 2.")
        }
    }
    
    var codigo = ""
    while codigo == "" {
        print("Ingrese Código: ", terminator: "")
        codigo = readLine() ?? ""
        if codigo == "" { print("⚠️ El código no puede estar vacío.") }
    }
    
    var direccion = ""
    while direccion == "" {
        print("Ingrese Dirección: ", terminator: "")
        direccion = readLine() ?? ""
        if direccion == "" { print("⚠️ La dirección no puede estar vacía.") }
    }
    
    var fecha = ""
    while fecha == "" {
        print("Ingrese Fecha de registro (AAAA-MM-DD): ", terminator: "")
        fecha = readLine() ?? ""
        if fecha == "" { print("⚠️ La fecha no puede estar vacía.") }
    }
    
    var cuenta = ""
    while cuenta == "" {
        print("Ingrese Nº Cuenta: ", terminator: "")
        cuenta = readLine() ?? ""
        if cuenta == "" { print("⚠️ El número de cuenta no puede estar vacío.") }
    }
    
    var monto = 0.0
    var montoValido = false
    while montoValido == false {
        print("Ingrese Monto mínimo de apertura: ", terminator: "")
        let montoTexto = readLine() ?? ""
        if let montoConvertido = Double(montoTexto), montoConvertido > 0 {
            monto = montoConvertido
            montoValido = true
        } else {
            print("❌ Monto inválido. Ingrese un número mayor a 0.")
        }
    }
    
    if opcion == "1" {
        var nombre = ""
        while nombre == "" {
            print("Ingrese Nombre Completo: ", terminator: "")
            nombre = readLine() ?? ""
            if nombre == "" { print("⚠️ El nombre no puede estar vacío.") }
        }
        
        var dni = ""
        while dni == "" {
            print("Ingrese DNI: ", terminator: "")
            dni = readLine() ?? ""
            if dni == "" { print("⚠️ El DNI no puede estar vacío.") }
        }
        
        let nuevoNatural = ClienteNatural(codigo: codigo, direccion: direccion, fechaDeRegistro: fecha, numeroCuenta: cuenta, montoMinimoApertura: monto, nombreCompleto: nombre, dni: dni)
        listaClientes.append(nuevoNatural)
        
    } else {
        var razonSocial = ""
        while razonSocial == "" {
            print("Ingrese Razón Social: ", terminator: "")
            razonSocial = readLine() ?? ""
            if razonSocial == "" { print("⚠️ La razón social no puede estar vacía.") }
        }
        
        var ruc = ""
        while ruc == "" {
            print("Ingrese RUC: ", terminator: "")
            ruc = readLine() ?? ""
            if ruc == "" { print("⚠️ El RUC no puede estar vacío.") }
        }
        
        var representante = ""
        while representante == "" {
            print("Ingrese Representante Legal: ", terminator: "")
            representante = readLine() ?? ""
            if representante == "" { print("⚠️ El representante legal no puede estar vacío.") }
        }
        
        let nuevoJuridico = ClienteJuridico(codigo: codigo, direccion: direccion, fechaDeRegistro: fecha, numeroCuenta: cuenta, montoMinimoApertura: monto, razonSocial: razonSocial, ruc: ruc, representanteLegal: representante)
        listaClientes.append(nuevoJuridico)
    }
    
    print("\n¿Desea registrar otro cliente? (s/n): ", terminator: "")
    let respuesta = readLine() ?? ""
    if respuesta != "s" && respuesta != "S" {
        continuar = false
    }
}

// reporte final
print("\n=======================================")
print("          REPORTE DE CLIENTES          ")
print("=======================================")

var i = 0
while i < listaClientes.count {
    let clienteActual = listaClientes[i]
    clienteActual.mostrarDatos()
    
    if i < listaClientes.count - 1 {
        print("---------------------------------------")
    }
    
    i = i + 1
}

print("=======================================")
