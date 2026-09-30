
import UIKit
class ViewControllerConfirmacion: UIViewController {
    //instanciar la clase ClienteModel
    var pCliente: ClienteModel = ClienteModel()
    //definir los controles
    @IBOutlet weak var tfApellido: UILabel!
    @IBOutlet weak var tfNombre: UILabel!
    @IBOutlet weak var tfDni: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //definir los controles
        self.tfApellido.text = pCliente.Apellido
        self.tfNombre.text = pCliente.Nombre
        self.tfDni.text = pCliente.Dni
    }
    @IBAction func btnVolver(_ sender: Any) {
        // Esto cierra la pantalla actual y revela la Pantalla 1 automáticamente
        self.dismiss(animated: true, completion: nil)
    }
}
