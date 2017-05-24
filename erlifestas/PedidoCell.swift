//
//  PedidoCell.swift
//  erlifestas
//
//  Created by Edson Hakamada on 09/05/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import UIKit

class PedidoCell: UITableViewCell {
    
    @IBOutlet weak var txtNome: UILabel!
    @IBOutlet weak var txtData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
