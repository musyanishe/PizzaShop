//
//  Position.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 23.08.2022.
//

import Foundation
import FirebaseFirestore

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
    
    init(id: String, product: Product, count: Int) {
        self.id = id
        self.product = product
        self.count = count
    }
    
    //QueryDocumentSnapshot - это снимок из базы данных какого-то заказа/документа, является опциональным так как документа может не оказаться в базе
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil}
        guard let price = data["price"] as? Int else { return nil}
        let product: Product = Product(id: "",
                                       title: title,
                                       imageURL: "",
                                       price: price,
                                       description: "")
        guard let count = data["count"] as? Int else { return nil}
        
        self.id = id
        self.product = product
        self.count = count
    }
    
}
