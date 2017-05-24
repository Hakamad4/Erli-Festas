//
//  Endereco.swift
//  erlifestas
//
//  Created by Edson Hakamada on 18/04/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import Foundation

class Endereco: NSObject {
    var id : String?
    var rua : String?
    var bairro : String?
    var cidade : String?
    var complemento : String?
    
    override init() {
    }
    
    init(id : String, rua: String, bairro: String, cidade: String, complemento :String) {
        self.rua = rua
        self.bairro = bairro
        self.cidade = cidade
        self.complemento = complemento
    }
}
