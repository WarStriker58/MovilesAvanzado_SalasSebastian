import UIKit

class NuevaVentaViewController: UIViewController {
    // Conexiones de entrada
    @IBOutlet weak var tfElectrodomestico: UITextField!
    @IBOutlet weak var tfPrecioUnitario: UITextField!
    @IBOutlet weak var tfCantidad: UITextField!
    @IBOutlet weak var tfMeses: UITextField!
    @IBOutlet weak var tfInteresMensual: UITextField!
    
    // Variable temporal para guardar los resultados calculados
    var modeloCalculado: VentaModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Acción asociada al boton Calcular
    @IBAction func btnCalcular(_ sender: Any) {
        // Extraer valores de forma segura y convertirlos a Double/Int
        let precioUnitario = Double(tfPrecioUnitario.text ?? "") ?? 0.0
        let cantidad = Double(tfCantidad.text ?? "") ?? 0.0
        let meses = Double(tfMeses.text ?? "") ?? 1.0 // Evitar división por cero
        let tasaInteresMensual = Double(tfInteresMensual.text ?? "") ?? 0.0
                
        // --- IMPLEMENTACIÓN DE FÓRMULAS EXACTAS ---
        let subtotalCalculado = precioUnitario * cantidad
        let igvCalculado = subtotalCalculado * 0.18
        let baseCalculado = subtotalCalculado + igvCalculado
        let interesesCalculados = baseCalculado * (tasaInteresMensual / 100.0) * meses
        let totalCalculado = baseCalculado + interesesCalculados
        let cuotaCalculada = totalCalculado / meses
                
        // Empaquetar todo dentro del modelo de datos
        self.modeloCalculado = VentaModel(
            subtotal: subtotalCalculado,
            igv: igvCalculado,
            base: baseCalculado,
            intereses: interesesCalculados,
            total: totalCalculado,
            cuota: cuotaCalculada
        )
    }
    
    // Preparar el traspaso de información antes de que cargue la vista destino
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultado" {
            if let pantallaDestino = segue.destination as? ResultadoViewController {
                // Pasar la referencia del modelo calculado directamente
                pantallaDestino.datosVenta = self.modeloCalculado
                }
            }
        }
}
