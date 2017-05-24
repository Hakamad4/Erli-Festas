//
//  PedidoVC.swift
//  erlifestas
//
//  Created by Edson Hakamada on 03/05/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import UIKit
import Firebase

class PedidoVC: UIViewController, UITextFieldDelegate , UITableViewDataSource , UITableViewDelegate{
    
    var defaultString : String = "Nulo"
    
    @IBOutlet weak var fieldCliente: UITextField!
    @IBOutlet weak var fieldDataEntrega: UITextField!
    @IBOutlet weak var tableProdutos: UITableView!
    
    //Firebase Referencia
    private var ref : FIRDatabaseReference?
    private var handle : UInt?
    var id : String?
    //instanciando a lista de itens selecionados e o cliente
    var produtos : [Produto] = []
    var produtoSelecionado : Produto!
    var clienteSelecionado : Cliente!
    
    
    //instanciando pickers
    let datePicker = UIDatePicker()
    let clientePicker = UtilsPickerView()
    var pedido : Pedido!
    var total : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //refencia ao banco
        ref = FIRDatabase.database().reference()
        if id == nil || id == ""{
            id = ref?.childByAutoId().key
            ref?.child("Pedidos").child(id!).setValue(["id" :id])
        }
        clientePicker.textField = fieldCliente
        fieldDataEntrega.delegate = self
        fieldCliente.delegate = self
        //navigation
        self.navigationController?.isNavigationBarHidden = false
        
        
        if produtoSelecionado != nil {
            total = total + (Double(produtoSelecionado.valor!)! * Double(produtoSelecionado.quantidade!)!)
            add()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let nome = fieldCliente.text
        let dtEntrega = fieldDataEntrega.text

        
        
        if nome != "" && dtEntrega != ""{
            clienteSelecionado = clientePicker.clienteSelecionado
            
            if clienteSelecionado.nome != nil || clienteSelecionado.nome != "" {
                save()
            }else {
                NSLog("Cliente Sel : vazio")
                MyAlerts.alertMessage(usermessage : "Cliente não selecionado.", view :self)
                return
            }
        }else {
            MyAlerts.alertMessage(usermessage : "Falha ao cadastrar Pedido.", view :self)
            return
        }
    }
    
    //config textsfields e datePicker
    func datePickerChanged(sender: UIDatePicker){
        fieldDataEntrega.text = dateFormat().string(from: sender.date)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fieldDataEntrega {
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
            NSLog("Teste 2")
        }else if textField == fieldCliente {
            fieldCliente.inputView = clientePicker
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func doneAction() {
        let data = dateFormat().string(from: datePicker.date)
        fieldDataEntrega.text = data
        self.view.endEditing(true)
    }
    func dateFormat() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YY HH:mm"
        return formatter
    }
    
    //config tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.txtNome.text = produtos[indexPath.row].nome
        let val : Double = Double(produtos[indexPath.row].valor!)! * Double(produtos[indexPath.row].quantidade!)!
        cell.txtQuant.text = "R$" + "\(val)"
        return cell
    }
    
    func save(){
        NSLog("Cliente Sel : " + clienteSelecionado.nome!)
        //setando o pedido
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YY"
        let dtPedido = formatter.string(from: Date())
        //criando dicionario do Pedido pra subir no banco
        let dicPedido : [String : AnyObject] = ["id" : id as AnyObject ,"dataEntrega" : fieldDataEntrega.text as AnyObject,"dataPedido" : dtPedido as AnyObject,"total": "\(total)" as AnyObject,
            "cliente" : "\(clienteSelecionado.id ?? defaultString)" as AnyObject]
        ref?.child("Pedidos").child(id!).updateChildValues(dicPedido)
    }
    
    func add(){
        produtos.append(produtoSelecionado)
        NSLog("Produto Selecionado : " + produtoSelecionado.nome!)
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == "selectProd" {
            if let dest = segue.destination as? ProdutosVC{
                if clientePicker.clienteSelecionado != nil{
                    dest.clienteSelecionado = clientePicker.clienteSelecionado
                }
                dest.pedId = id
                dest.listaPedido = produtos
            }
        }
     }
 
    
}
