//
//  HomeVC.swift
//  erlifestas
//
//  Created by Edson Hakamada on 09/05/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController , UITableViewDataSource , UITableViewDelegate{
    @IBOutlet weak var myTebleView: UITableView!

    //firebase referencia
    private lazy var ref : FIRDatabaseReference = FIRDatabase.database().reference().child("Pedidos")
    private var handle : FIRDatabaseHandle?
    
    
    var pedido : Pedido!
    private var pedidos : [Pedido] = []
    var c = Cliente()
    var listaProduto = [Produto]()
    let defaultString = "nulo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buscarPedido()
        NSLog("\(pedidos.count)")
        for p : Pedido in pedidos{
            NSLog("Pedido p : " + ((p.id)! + "\t" + (p.dataEntrega)!))
        }
        self.navigationController?.isNavigationBarHidden = false
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Buscas
    func buscarPedido(){
        pedidos.removeAll()
        handle = ref.observe(.childAdded, with: {(snap) in
            if let data = snap.value as! [String : AnyObject]! {
                let p = Pedido()
                p.setValuesForKeys(data)
                self.pedidos.append(p)
                NSLog("\(p.id ?? self.defaultString)")
                NSLog("\(self.pedidos.count)")
            }
        })
    }
    func buscarCliente(pedido : Pedido){
        handle = ref.child(pedido.id!).child("cliente").observe(.childAdded, with: {(snapshot) in
            if let dic = snapshot.value as? [String : AnyObject]{
                self.c.setValuesForKeys(dic)
                NSLog(self.c.nome!)
            }
        })
    }
    func buscarProdutos(pedido : Pedido){
        handle = ref.child(pedido.id!).child("produtos").observe(.childAdded, with: {(snapshot) in
            if let dic = snapshot.value as? [String : AnyObject]{
                let produtin = Produto()
                produtin.setValuesForKeys(dic)
                self.listaProduto.append(produtin)
                
            }
        })
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedidos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: - Construir as celulas
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PedidoCell
        cell.txtNome.text = pedidos[indexPath.row].id
        cell.txtData.text = pedidos[indexPath.row].dataEntrega
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
