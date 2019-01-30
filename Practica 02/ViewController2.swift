//
//  ViewController2.swift
//  Practica 02
//
//  Created by Pau Duran on 06/11/2018.
//  Copyright © 2018 Pau Duran. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var fieldValue: UITextField!
    
    @IBOutlet weak var pikerView: UIPickerView!
    
    @IBOutlet weak var errorLabel: UILabel!
    var row = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pikerView.delegate = self
        pikerView.dataSource = self
        
        fieldValue.text = String(monedas[row].valor)
        
        
        
        
    }
    
    @IBAction func btnSaveClik(_ sender: Any) {
        let cStr = fieldValue.text
        if(cStr != nil && Double(cStr!) != nil){
        
            monedas[row].valor = Double(cStr!)!
            errorLabel.text = ""
            
            let monedasData = try! JSONEncoder().encode(monedas)
            
            UserDefaults.standard.set(monedasData, forKey: "monedas")
            
            
        }else{
            errorLabel.text = "Introduce un numero"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return monedas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return monedas[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow
        row: Int, inComponent component: Int){
        
        fieldValue.text = String(monedas[row].valor)
        self.row = row
        
    }
}
