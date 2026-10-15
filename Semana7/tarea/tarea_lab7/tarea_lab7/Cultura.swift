import UIKit

class Cultura: NSObject {
    var nombre: String = ""
    var region: String = ""
    var descripcion: String = ""
    var foto: UIImage!
    
    init(nombre: String, region: String, descripcion: String, foto: UIImage!) {
        self.nombre = nombre
        self.region = region
        self.descripcion = descripcion
        self.foto = foto
    }
}
