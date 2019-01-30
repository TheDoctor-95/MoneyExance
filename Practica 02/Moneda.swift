//
//  Moneda.swift
//  Practica 02
//
//  Created by Pau Duran on 24/10/2018.
//  Copyright © 2018 Pau Duran. All rights reserved.
//

import Foundation

class Moneda: Codable{
    
    var name:String
    var title:String
    //Valor respeto Euro
    var valor:Double
    var icon:String
    
    
    init(name: String, title:String, valor:Double, icon:String) {
        self.name = name
        self.title = title
        self.valor = valor
        self.icon = icon
    }
    
}
