//
//  ClienteVC.swift
//  erlifestas
//
//  Created by Edson Hakamada on 18/04/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import UIKit
import Firebase

class ClienteVC: UIViewController , UITextFieldDelegate{
    
    
    //Outlet's
    @IBOutlet weak var fieldNome: UITextField!
    @IBOutlet weak var fieldRua: UITextField!
    @IBOutlet weak var fieldBairro: UITextField!
    @IBOutlet weak var fieldCidade: UITextField!
    @IBOutlet weak var fieldComplemento: UITextField!
    @IBOutlet weak var fieldAniversario: UITextField!
    @IBOutlet weak var fieldTelefone: UITextField!
    private var fields : [UITextField] = []
    //Referencia firebase
    var ref : FIRDatabaseReference?
    var handle: UInt?
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //armazenando todos textfields em fields
        fields = [fieldNome, fieldRua, fieldBairro, fieldCidade, fieldComplemento, fieldAniversario, fieldTelefone]
        ref = FIRDatabase.database().reference()
        //setando delegate
        for field : UITextField in fields{
            field.delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func actionSalvar(_ sender: Any) {
        let nome = fieldNome.text
        let rua = fieldRua.text
        let bairro = fieldBairro.text
        let cidade = fieldCidade.text
        let comp = fieldComplemento.text
        let aniver = fieldAniversario.text
        let telefone = fieldTelefone.text
        if nome != "" && telefone != ""{
            let c = Cliente()
            let end = Endereco()
            c.id = ref?.childByAutoId().key
            c.nome = nome
            c.telefone = telefone
            if aniver == ""{
                c.aniversario = "false"
            }else {
                c.aniversario = aniver
            }
            if rua != "" && bairro != "" && cidade != "" {
                end.rua = rua
                end.bairro = bairro
                end.cidade = cidade
                if comp != ""{
                    end.complemento = comp
                }
            }else{
                end.rua = "false"
                end.bairro = "false"
                end.cidade = "false"
                end.complemento = "false"
            }
            salvarCliente(cliente: c)
            end.id = c.id
            salvarEndereco(endereco: end)
        }else {
            MyAlerts.alertMessage(usermessage : "Falha ao cadastrar usuário.", view :self)
            return
        }
    }
    
    func salvarCliente(cliente : Cliente){
        let dic = ["id":cliente.id,"nome":cliente.nome,"aniversario": cliente.aniversario,"telefone":cliente.telefone]
        ref?.child("Clientes").child((cliente.id)!).setValue(dic)
    }
    
    func salvarEndereco(endereco : Endereco){
        let dic = ["id":endereco.id, "rua":endereco.rua,"bairro":endereco.bairro,"cidade": endereco.cidade,"complemento":endereco.complemento]
        ref?.child("Endereco").child(endereco.id!).setValue(dic)
    }
    //config textsfields e datePicker
    func datePickerChanged(sender: UIDatePicker){
        fieldAniversario.text = dateFormat().string(from: sender.date)
    }
    //retirar
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fieldAniversario{
            datePicker.datePickerMode = .dateAndTime
            
            //toolbar
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            //bar button
            let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneAction))
            toolbar.setItems([done], animated: false)
            
            textField.inputAccessoryView = toolbar;
            
            textField.inputView = datePicker
            
            datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
            
            NSLog("fieldAniversario")
        }
    }
    //ate aqui
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fieldAniversario{
            fieldAniversario.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func doneAction() {
        fieldAniversario.text = dateFormat().string(from: datePicker.date)
        self.view.endEditing(true)
    }
    func dateFormat() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YY"
        return formatter
    }
}
