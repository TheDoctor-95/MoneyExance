//
//  ViewController.swift
//  Practica 02
//
//  Created by Pau Duran on 24/10/2018.
//  Copyright © 2018 Pau Duran. All rights reserved.
//

import UIKit

var monedas = [Moneda]()

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    
    var pos :Int = 0
    
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var f: UIImageView!
    @IBOutlet weak var equivalencia: UILabel!
    @IBOutlet weak var moneda: UILabel!
    
    @IBOutlet weak var tansfResult: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var cantidad: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var from :Int = 0
    var to   :Int = 0
    
    @IBOutlet weak var imgOpt: UIImageView!
    @IBOutlet weak var btnOpt: UIButton!
    @IBOutlet weak var viewInterac: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewInterac.isUserInteractionEnabled = true
        
        let swiftRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        
        swiftRight.direction = UISwipeGestureRecognizer.Direction.right
        
        viewInterac.addGestureRecognizer(swiftRight)
        
        let swiftLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        
        swiftLeft.direction = UISwipeGestureRecognizer.Direction.left
        
        viewInterac.addGestureRecognizer(swiftLeft)
        
        
        let monedasUD = UserDefaults.standard.data(forKey: "monedas")
        
        if(monedasUD != nil){
            monedas = try! JSONDecoder().decode([Moneda].self, from: monedasUD!)
        }
        
        
        if(monedas.count == 0){
            
            let names = ["usa", "japan", "india", "euro"]
            let titles = ["Dolar", "Yen Japones", "Rupia Hindú", "Euro"]
            let valores = [0.871124,0.00768679,0.0120192,1]
            let iconos = ["$", "¥", "₹", "€"]
            
            for i in 0...(names.count - 1) {
                let m = Moneda(name: names[i] ,title: titles[i],valor: valores[i],icon:iconos[i])
                monedas.append(m)
            }
            
            let monedasData = try! JSONEncoder().encode(monedas)
            
            UserDefaults.standard.set(monedasData, forKey: "monedas")
            
            
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        loadMoneda()
        
        imgOpt.isHidden = true
        btnOpt.isHidden = true
        
    }
    
    func transform(){
        let cStr = cantidad.text
        if(cStr != nil){
            if(cStr != "999"){
                if(Double(cStr!)==nil){
                    errorLabel.text = "Introduce un numero"
                }else{
                    errorLabel.text = ""
                    
                    let c = Double(cStr!)!
                    
                    let f = monedas[from]
                    
                    let t = monedas[to]
                    
                    
                    let result = c * f.valor/t.valor
                    
                    let resultStr = String(format: "%.2f", result)
                    
                    tansfResult.text = "\(resultStr) \(t.icon)"
                }
                
                
                
                
            }else{
                imgOpt.isHidden = false
                btnOpt.isHidden = false
            }
            
        }
    }
    
    @IBAction func cantidadChanged(_ sender: Any) {
        
        transform()
        
    }
    
    
    
    @IBAction func tansformar(_ sender: Any) {
        
        transform()
        
    }
    
    
    func loadMoneda(){
        let m :Moneda = monedas[pos]
        moneda.text = m.title
        bg.image = UIImage(named: m.name+"-bg")
        f.image = UIImage(named: m.name+"-f")
        let resultStr = String(format: "%.5f", m.valor)
        
        equivalencia.text = "1.00 \(m.icon) = \(resultStr) €"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return monedas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return monedas[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow
        row: Int, inComponent component: Int){
        
        if(component == 0){
            from = row
        }else{
            to = row
        }
        
        transform()
        
        print(monedas[row].title)
    }
    
    func prevFunc(){
        if(pos==0){
            pos = monedas.count-1
        }else{
            pos -= 1
        }
        loadMoneda()
    }
    
    @IBAction func prev(_ sender: Any) {
       prevFunc()
        
    }
    func nextFunc(){
        if(pos==monedas.count-1){
            pos = 0
        }else{
            pos += 1
        }
        loadMoneda()
    }
    
    @IBAction func next(_ sender: Any) {
        nextFunc()
    }
    
    @objc func swipeGesture(sender:UIGestureRecognizer){
        
        if let swipeGesture = sender as? UISwipeGestureRecognizer {
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                prevFunc()
            case UISwipeGestureRecognizer.Direction.left:
                nextFunc()
                
            default:
                prevFunc()
            }
            
        }
        
    }
    
    
}

