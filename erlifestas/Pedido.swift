//
//  Pedido.swift
//  erlifestas
//
//  Created by Edson Hakamada on 18/04/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import Foundation
import Firebase

class Pedido: NSObject {
    var id : String?
    var cliente : String? //id do cliente
    var dataEntrega : String?
    var dataPedido : String?
    var produtos : Dictionary<String, String>? //<id dos produtos : quantidade>
    var total : String?
    
    init(id : String, cliente : String, dataEntrega : String, produtos : Dictionary<String, String>, total : String) {
        self.id = id
        self.cliente = cliente
        self.dataEntrega = dataEntrega
        self.produtos = produtos
        self.total = total
    }
    
    init?(snapshot: FIRDataSnapshot) {
        guard let dict = snapshot.value as? [String: AnyObject] else { return nil }
        guard let id = dict["id"] else { return nil }
        guard let cliente  = dict["cliente"]  else { return nil }
        guard let dataEntrega = dict["dataEntrega"] else { return nil }
        guard let produtos = dict["produtos"] else { return nil }
        guard let total = dict["body"] else { return nil }
        
        self.id = id as? String
        self.cliente = cliente as? String
        self.dataEntrega = dataEntrega as? String
        self.produtos = produtos as? Dictionary<String, String>
        self.total = total as? String
    }
    convenience override init() {
        self.init(id: "", cliente: "", dataEntrega: "", produtos: ["id":""], total: "")
    }
    
}
