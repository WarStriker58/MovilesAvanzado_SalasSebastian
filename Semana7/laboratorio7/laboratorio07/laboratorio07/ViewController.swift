//
//  ViewController.swift
//  laboratorio07
//
//  Created by Tecsup on 14/10/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //  lista de Profesores con fotos
    var listaProfesores = [
        Profesor(nombre: "Jaime Gomez", cargo: "Coordinador de Software", foto: UIImage(named: "avatar1")),
        Profesor(nombre: "Jaime Farfan", cargo: "Docente de Software TC", foto: UIImage(named: "avatar2")),
        Profesor(nombre: "Juan León", cargo: "Docente de Software TC", foto: UIImage(named: "avatar4")),
        Profesor(nombre: "Silvia Montoya", cargo: "Docente de Software TC", foto: UIImage(named: "avatar3")),
        Profesor(nombre: "Theobaldo Diaz", cargo: "Docente de Software TC", foto: UIImage(named: "avatar5")),
        Profesor(nombre: "Elliot Garamendi", cargo: "Docente de Software TC", foto: UIImage(named: "avatar4")),
        Profesor(nombre: "Edwin Huerto", cargo: "Docente de Redes TC", foto: UIImage(named: "avatar2"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaProfesores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Crear un objeto para que se muestre en la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda")!
        
        // Asignar los datos del profesor a las etiquetas de la celda
        cell.textLabel?.text = listaProfesores[indexPath.row].nombre
        cell.detailTextLabel?.text = String(listaProfesores[indexPath.row].cargo)
        
        // Asignar la imagen guardada en el modelo
        cell.imageView?.image = listaProfesores[indexPath.row].foto!
        
        return cell
    }
}
