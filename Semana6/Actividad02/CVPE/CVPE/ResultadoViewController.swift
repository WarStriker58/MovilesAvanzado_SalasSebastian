import UIKit

class ResultadoViewController: UIViewController {
    
    // Conexiones para mostrar las salidas
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblIgv: UILabel!
    @IBOutlet weak var lblBase: UILabel!
    @IBOutlet weak var lblIntereses: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblCuotaMensual: UILabel!
    
    // Objeto contenedor que se inyecta desde la pantalla anterior
    var datosVenta: VentaModel?

    override func viewDidLoad() {
        super.viewDidLoad()
            
    // Mostrar los datos formateados si el modelo contiene información
    if let venta = datosVenta {
        lblSubtotal.text = String(format: "S/. %.2f", venta.subtotal)
        lblIgv.text = String(format: "S/. %.2f", venta.igv)
        lblBase.text = String(format: "S/. %.2f", venta.base)
        lblIntereses.text = String(format: "S/. %.2f", venta.intereses)
        lblTotal.text = String(format: "S/. %.2f", venta.total)
        lblCuotaMensual.text = String(format: "S/. %.2f", venta.cuota)
        }
    }
}
