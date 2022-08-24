//
//  Position.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 23.08.2022.
//

import Foundation

struct Position: Identifiable {
    
    var id: String
    var product: Product
    var count: Int
    
    var cost: Int {
        return product.price * self.count
    }
}
