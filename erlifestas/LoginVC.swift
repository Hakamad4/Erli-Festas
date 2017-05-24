//
//  ViewController.swift
//  erlifestas
//
//  Created by Edson Hakamada on 18/04/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import UIKit
import FirebaseAuth
import SpriteKit

class LoginVC: UIViewController ,UITextFieldDelegate{
    
    //MARK: Outlet's
    @IBOutlet weak var fieldEmail: UITextField!
    @IBOutlet weak var fieldPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fieldEmail.tag = 0
        fieldEmail.delegate = self
        
        fieldPass.tag = 1
        fieldPass.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Ação do botão entrar
    @IBAction func loginAction(_ sender: Any) {
        let email = fieldEmail.text?.lowercased()
        let pass = fieldPass.text?.lowercased()
        
        if email != "" || pass != ""{
            FIRAuth.auth()?.signIn(withEmail: email!, password: pass!, completion: {
            user, error in
                if error != nil{
                    print("Falha")
                    MyAlerts.alertMessage(usermessage: "Este email não tem permissão para logar-se, ou sua esta incorreta! Porfavor tente de novo.", view: self)
                    return
                }else{
                    print("Sucesso")
                }
            })
        }
        
    }

}

