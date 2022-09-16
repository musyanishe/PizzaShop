//
//  Product.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 21.08.2022.
//

import Foundation


struct Product {
    
    var id: String
    var title: String
    var imageURL: String = ""
    var price: Int
    var description: String
    
//    var ordersCount: Int
//    var isRecommend: Bool
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["title"] = title
        repres["price"] = price
        repres["description"] = description
        return repres
    }
}

