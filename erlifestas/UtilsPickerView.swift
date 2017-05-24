//
//  UtilsPickerView.swift
//  erlifestas
//
//  Created by Edson Hakamada on 03/05/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import UIKit
import Firebase



class UtilsPickerView : UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //firebase referencias
    private var ref : FIRDatabaseReference?
    private var handle : UInt?
    
    //atr de auxilio
    var textField : UITextField!
    var clientes : [Cliente] = []
    var clienteSelecionado : Cliente!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.fireConfig()
        delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.fireConfig()
        delegate = self
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clientes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clientes[row].nome
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = clientes[row].nome
        clienteSelecionado = clientes[row]
        endEditing(false)
    }
    func fireConfig(){
        ref = FIRDatabase.database().reference()
        buscarClientes()
    }
    //buscando dados no firebase
    func buscarClientes(){
        handle = ref?.child("Clientes").observe(.childAdded, with: {(snapshot) in
            if let dic = snapshot.value as? [String : AnyObject]{
                let c = Cliente()
                c.setValuesForKeys(dic)
                self.buscarEndereco(cliente: c)
                self.clientes.append(c)
                self.clientes = self.clientes.sorted{$0.nome! < $1.nome!}
            }
        })
    }
    func buscarEndereco(cliente : Cliente){
        handle = ref?.child("Clientes").child(cliente.id!).child("endereco").observe(.childAdded, with: {(snapshot) in
            if let dic = snapshot.value as? [String : AnyObject]{
                let end = Endereco()
                end.setValuesForKeys(dic)
            }
        })
    }
}
