// Datos de las líneas
let lineas: [String: [String]] = [
    
    "Linea 1": [
        "Villa El Salvador",
        "Parque Industrial",
        "Pumacahua",
        "Villa Maria",
        "Maria Auxiliadora",
        "San Juan",
        "Atocongo",
        "Jorge Chavez",
        "Ayacucho",
        "Cabitos",
        "Angamos",
        "San Borja Sur",
        "La Cultura",
        "Arriola",
        "Gamarra",
        "Miguel Grau",
        "El Angel",
        "Presbitero Maestro",
        "Caja de Agua",
        "Piramide del Sol",
        "Los Jardines",
        "Los Postes",
        "San Carlos",
        "San Martin",
        "Santa Rosa",
        "Bayovar"
    ],
    
    "Linea 2": [
        "Puerto del Callao",
        "Buenos Aires",
        "Juan Pablo II",
        "Insurgentes",
        "Carmen de la Legua",
        "Oscar R. Benavides",
        "San Marcos",
        "Elio",
        "La Alborada",
        "Tingo Maria",
        "Parque Murillo",
        "Plaza Bolognesi",
        "Estacion Central",
        "Plaza Manco Capac",
        "Cangallo",
        "28 de Julio",
        "Nicolas Ayllon",
        "Circunvalacion",
        "San Juan de Dios",
        "Evitamiento",
        "Ovalo Santa Anita",
        "Colectora Industrial",
        "Hermilio Valdizan",
        "Mercado Santa Anita",
        "Vista Alegre",
        "Prolongacion Javier Prado",
        "Municipalidad de Ate"
    ],
    
    "Linea 3": [],
    "Linea 4": [],
    "Linea 5": [],
    "Linea 6": []
]

// FUNCIONES
func mostrarLineas() {
    print("\n========================================")
    print("          LINEAS DISPONIBLES")
    print("========================================")
    
    for linea in lineas.keys {
        print("- \(linea)")
    }
}

func consultarLinea() {
    print("\nIngrese el nombre de la linea:")
    
    if let nombreLinea = readLine() {
        
        if let estaciones = lineas[nombreLinea] {
            
            print("\n========================================")
            print("          \(nombreLinea)")
            print("========================================")
            
            if estaciones.isEmpty {
                print("No hay estaciones registradas.")
            } else {
                for (indice, estacion) in estaciones.enumerated() {
                    print("\(indice + 1). \(estacion)")
                }
            }
            
        } else {
            print("\nLa linea no existe.")
        }
    }
}

func consultarEstacion() {
    print("\nIngrese el nombre de la estacion:")
    
    if let nombreEstacion = readLine() {
        
        var encontrada = false
        
        for (linea, estaciones) in lineas {
            
            if estaciones.contains(nombreEstacion) {
                print("\nLa estacion \(nombreEstacion) pertenece a \(linea).")
                encontrada = true
            }
        }
        
        if !encontrada {
            print("\nLa estacion no fue encontrada.")
        }
    }
}

func buscarEstacion() {
    print("\nIngrese el texto de la estacion que desea buscar:")
    
    if let texto = readLine() {
        
        print("\n========================================")
        print("          RESULTADOS DE BUSQUEDA")
        print("========================================")
        
        var encontrada = false
        
        for (_, estaciones) in lineas {
            
            for estacion in estaciones {
                
                if estacion.lowercased().contains(texto.lowercased()) {
                    print("- \(estacion)")
                    encontrada = true
                }
            }
        }
        
        if !encontrada {
            print("No se encontraron estaciones.")
        }
    }
}

func mostrarConexiones() {
    print("\n========================================")
    print("       ESTACIONES DE CONEXION")
    print("========================================")
    
    print("Funcion en desarrollo.")
}

func contarEstaciones() {
    print("\nIngrese el nombre de la linea:")
    
    if let nombreLinea = readLine() {
        
        if let estaciones = lineas[nombreLinea] {
            print("\n\(nombreLinea) tiene \(estaciones.count) estaciones.")
        } else {
            print("\nLa linea no existe.")
        }
    }
}

// MENU PRINCIPAL
var continuar = true

while continuar {
    
    print("\n")
    print("========================================")
    print("       METRO DE LIMA Y CALLAO")
    print("========================================")
    print("1. Consultar linea")
    print("2. Consultar estacion")
    print("3. Buscar estacion")
    print("4. Mostrar estaciones de conexion")
    print("5. Contar estaciones de una linea")
    print("6. Mostrar todas las lineas")
    print("7. Salir")
    print("========================================")
    print("Seleccione una opcion:")
    
    if let opcion = readLine() {
        
        switch opcion {
            
        case "1":
            consultarLinea()
            
        case "2":
            consultarEstacion()
            
        case "3":
            buscarEstacion()
            
        case "4":
            mostrarConexiones()
            
        case "5":
            contarEstaciones()
            
        case "6":
            mostrarLineas()
            
        case "7":
            continuar = false
            print("\nGracias por utilizar el sistema.")
            
        default:
            print("\nOpcion no valida.")
        }
    }
}
