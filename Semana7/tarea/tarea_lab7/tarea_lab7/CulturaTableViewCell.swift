//
//  CulturaTableViewCell.swift
//  tarea_lab7
//
//  Created by Tecsup on 14/10/26.
//

import UIKit

class CulturaTableViewCell: UITableViewCell {

    @IBOutlet weak var imagenCultura: UIImageView!
    @IBOutlet weak var nombreCultura: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
