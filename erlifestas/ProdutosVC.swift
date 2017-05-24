//
//  ProdutosVC.swift
//  erlifestas
//
//  Created by Edson Hakamada on 18/04/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import UIKit
import Firebase

class ProdutosVC: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    let defaultString = "nulo"
    
    @IBOutlet weak var fieldProduto: UITextField!
    @IBOutlet weak var fieldQuant: UITextField!
    
    //Produtos
    var produtos: [Produto] = [] //produtos buscados no banco
    var listaPedido: [Produto]! //produtos vindo do pedido
    var clienteSelecionado : Cliente!
    var data : String!
    var produtoSelected : Produto?
    var handle : UInt?
    var ref : FIRDatabaseReference?
    let picker = UIPickerView()
    var pedId: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = FIRDatabase.database().reference()
        buscar()
        
        picker.delegate = self
        picker.dataSource = self
        // Do any additional setup after loading the view.
        
        fieldProduto.inputView = picker
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSalver(_ sender: Any) {
        let nome = fieldProduto.text
        let quant = fieldQuant.text
        
        if nome != "" && quant != ""{
            if(produtoSelected?.nome != nil || produtoSelected?.nome != ""){
                produtoSelected?.quantidade = quant
                let val = "\(produtoSelected?.id! ?? defaultString)" + "," + "\(produtoSelected?.quantidade! ?? defaultString)"
                ref?.child("ProdutosPorPedido").child(pedId).updateChildValues(["\(listaPedido.count)" : val])
                performSegue(withIdentifier: "ProdutoSg", sender: nil)
            }
        }
    }
    
    func buscar(){
        produtos.removeAll()
        handle = ref?.child("Produtos").observe(.childAdded, with: {(snapshot) in
            if let dic = snapshot.value as? [String : AnyObject]{
                let p = Produto()
                p.setValuesForKeys(dic)
                p.quantidade = "0"
                self.produtos.append(p)
                self.produtos = self.produtos.sorted{$0.nome! < $1.nome!}
            }
        })
    }
    //config pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return produtos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return produtos[row].nome! + " R$" + (produtos[row].valor?.replacingOccurrences(of: ".", with: ","))!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fieldProduto.text = produtos[row].nome
        produtoSelected = produtos[row]
        self.view.endEditing(false)
    }
    //passando dados
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProdutoSg" {
            if let dest = segue.destination as? PedidoVC{
                dest.produtoSelecionado = produtoSelected
                dest.produtos = listaPedido
                dest.id = pedId
            }
        }
    }

}
