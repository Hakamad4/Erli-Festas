//
//  CadProdutoVC.swift
//  erlifestas
//
//  Created by Edson Hakamada on 18/04/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import UIKit
import Firebase


class CadProdutoVC: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var fieldNome: UITextField!
    @IBOutlet weak var fieldValor: UITextField!
    @IBOutlet weak var fieldUnid: UITextField!
    
    //tipos de unidade
    var unidade = ["Kg","g","L","ml","cento","cada"]
    //PickerView
    let picker = UIPickerView()
    
    //FireBase
    var ref : FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        
        self.ref = FIRDatabase.database().reference()
        
        //construindo o pickerView no textField
        fieldUnid.inputView = picker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let nome = fieldNome.text
        let valor = fieldValor.text
        let tipoUni = fieldUnid.text
        
        if nome != "" && valor != "" && tipoUni != ""{
            //instanciando e setando produto
            let p = Produto()
            p.id = ref?.childByAutoId().key
            p.nome = nome
            p.valor = valor
            p.medida = tipoUni
            
            //criando dictionario
            let dic =
                ["id" : p.id , "nome": p.nome ,"valor" : p.valor, "medida": p.medida]
            
            ref?.child("Produtos").child((p.id)!).setValue(dic)
            
            fieldNome.text = ""
            fieldValor.text = ""
            fieldUnid.text = ""
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unidade.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unidade[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fieldUnid.text = unidade[row]
        self.view.endEditing(false)
    }
    
    
    


}
