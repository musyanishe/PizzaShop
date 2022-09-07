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
    //Позиция у нас состоит из продуктов, только в базу данных нам надо, чтобы отправлялся не сам продукт а его определенные свойства, поэтому здесь делаем репрезентацию, а далее создаем еще один файл с сущностью "Заказ" (Order)
    var representation: [String: Any] {
        
        var repres = [String: Any]()
        
        repres["id"] = id
        repres["count"] = count
        repres["title"] = product.title
        repres["price"] = product.price
        repres["cost"] = cost
        
        return repres
    }
}
