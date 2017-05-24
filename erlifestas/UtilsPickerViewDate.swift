//
//  UtilsDate.swift
//  erlifestas
//
//  Created by Edson Hakamada on 03/05/17.
//  Copyright © 2017 Erik Hakamada. All rights reserved.
//

import UIKit

class UtilsPickerViewDate : UIViewController {
    
    private var textField: UITextField!
    private let datePicker = UIDatePicker()
    
    
    func createDatePicker(textField: UITextField){
        //formato do datePicker
        self.textField = textField
        datePicker.datePickerMode = .date
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneAction))
        toolbar.setItems([done], animated: false)
        
        textField.inputAccessoryView = toolbar;
        
        textField.inputView = datePicker
    }
    
    func doneAction() {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/YYYY"
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .none
        
        textField.text = dateFormat.string(from: datePicker.date)
        self.view.endEditing(true)
    }

}
