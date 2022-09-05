//
//  PropertiesUser.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 05.09.2022.
//

import Foundation

struct PropertiesUser: Identifiable {
    
    var id: String
    var name: String
    var phone: Int
    var address: String
 
    var representation: [String: Any] {
        
        var repres = [String: Any]()
        
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["address"] = self.address
        
        return repres
    }
    
}
