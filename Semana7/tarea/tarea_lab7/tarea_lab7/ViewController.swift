import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Arreglo con datos de prueba de Culturas Peruanas
    var listaCulturas: [Cultura] = [
        Cultura(nombre: "Chavín", region: "Áncash", descripcion: "Cultura preínca conocida por el majestuoso Lanzón Monolítico, el Templo de Chavín de Huántar y sus icónicas Cabezas Clavas talladas en piedra.", foto: UIImage(named: "avatar1")),
        Cultura(nombre: "Paracas", region: "Ica", descripcion: "Famosa en el mundo entero por su textilería fina y multicolor, sus complejos fardos funerarios y la práctica médica de trepanaciones craneanas.", foto: UIImage(named: "avatar2")),
        Cultura(nombre: "Moche", region: "La Libertad", descripcion: "Destacados por su altísima calidad alfarera en los huacos retratos, su orfebrería avanzada y el descubrimiento de la tumba real del Señor de Sipán.", foto: UIImage(named: "avatar3")),
        Cultura(nombre: "Nazca", region: "Ica", descripcion: "Reconocidos mundialmente por sus gigantescas líneas y geoglifos trazados en el desierto, que representan figuras de animales y plantas.", foto: UIImage(named: "avatar4"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Métodos de UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCulturas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Casteamos a tu celda personalizada
        let cell = tableView.dequeueReusableCell(withIdentifier: "culturaCell", for: indexPath) as! CulturaTableViewCell
        
        let cultura = listaCulturas[indexPath.row]
        cell.nombreCultura.text = cultura.nombre
        cell.imagenCultura.image = cultura.foto
        
        return cell
    }
    
    // MARK: - Métodos de UITableViewDelegate (Navegación al pulsar)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Ejecutamos el Segue que creaste en el Storyboard pasando la fila seleccionada
        performSegue(withIdentifier: "irADetalle", sender: indexPath.row)
    }
    
    // Preparar el traspaso de información antes de cambiar de pantalla
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irADetalle",
           let detalleVC = segue.destination as? DetalleViewController,
           let index = sender as? Int {
            // Le inyectamos el objeto Cultura correspondiente a la segunda pantalla
            detalleVC.culturaSeleccionada = listaCulturas[index]
        }
    }
}

