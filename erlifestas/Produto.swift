//
//  Produto.swift
//  erlifestas
//
//  Created by Edson Hakamada on 18/04/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import Foundation

class Produto: NSObject {
    var id: String?
    var nome : String?
    var valor : String?
    var medida : String?
    var quantidade : String?
    
    override init() {
        super.init()
    }
    init(id: String?, nome : String?, valor : String?, medida : String?, quantidade : String?) {
        super.init()
        self.id = id
        self.nome = nome
        self.valor = valor
        self.medida = medida
        self.quantidade = quantidade
    }
    
}
