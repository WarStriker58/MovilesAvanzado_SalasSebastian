import UIKit

class DetalleViewController: UIViewController {

    // Conecta estos Outlets arrastrándolos desde tu pantalla de Detalle en el Storyboard
    @IBOutlet weak var imagenDetalle: UIImageView!
    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var labelRegion: UILabel!
    //@IBOutlet weak var labelDescripcion: UILabel! // Puede ser UILabel o UITextView
    @IBOutlet weak var labelDescripcion: UITextView!
    
    // Propiedad intermedia que almacena los datos inyectados desde el ViewController anterior
    var culturaSeleccionada: Cultura?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Si se recibió el objeto de manera exitosa, actualizamos la interfaz gráfica
        if let cultura = culturaSeleccionada {
            title = cultura.nombre // Pone el nombre en la barra de navegación superior
            labelNombre.text = "Cultura: \(cultura.nombre)"
            labelRegion.text = "Región: \(cultura.region)"
            labelDescripcion.text = cultura.descripcion
            imagenDetalle.image = cultura.foto
        }
    }
}
