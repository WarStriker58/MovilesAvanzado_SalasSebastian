// Desarrollado por: Sebastian Salas
import UIKit

class CatalogoViewController: UIViewController {

    // Regla 1: Los datos fijos solicitados en el laboratorio
    let productos: [Producto] = [
        Producto(nombre: "Refrigeradora", precio: 2000, stock: 5),
        Producto(nombre: "Licuadora", precio: 250, stock: 10),
        Producto(nombre: "Laptop", precio: 3500, stock: 3),
        Producto(nombre: "Cocina", precio: 1200, stock: 4)
    ]
    
    // Regla 2: El carrito se inicializa aquí UNA sola vez
    let carrito = CarritoModel()
    
    // Enlace con tu botón azul "Ver carrito (0)"
    @IBOutlet weak var verCarritoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // TODO B2: Se ejecuta cada vez que regresas al Catálogo para actualizar el contador
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let totalItems = carrito.cantidadTotal()
        verCarritoButton.setTitle("Ver carrito (\(totalItems))", for: .normal)
    }

    // Acción conectada a los 4 botones de productos usando sus Tags (0, 1, 2, 3)
    @IBAction func productoTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "verDetalle", sender: sender)
    }
    
    // Gestión del viaje de datos entre pantallas
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verDetalle" {
            let boton = sender as! UIButton
            let destino = segue.destination as! DetalleViewController
            
            // Elige el producto del array según el Tag asignado en el Storyboard
            destino.producto = productos[boton.tag]
            destino.carrito = carrito // Pasa la referencia única del carrito
            
        } else if segue.identifier == "verCarrito" {
            // TODO B1: Caso "verCarrito" -> Pasa el carrito a la tercera pantalla
            let destino = segue.destination as! CarritoViewController
            destino.carrito = carrito
        }
    }
}

