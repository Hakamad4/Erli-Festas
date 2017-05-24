//
//  CustomCell.swift
//  erlifestas
//
//  Created by Edson Hakamada on 04/05/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var txtNome: UILabel!
    @IBOutlet weak var txtQuant: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
