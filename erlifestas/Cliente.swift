//
//  File.swift
//  erlifestas
//
//  Created by Edson Hakamada on 18/04/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import Foundation

class Cliente: NSObject {
    var id : String?
    var nome : String?
    var aniversario : String?
    var telefone : String?
    
    override init(){ }
    
    init(id : String,nome : String, aniversario : String,telefone : String) {
        self.id = id
        self.nome = nome
        self.aniversario = aniversario
        self.telefone = telefone
    }
}
