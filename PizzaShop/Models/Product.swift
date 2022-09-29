//
//  Product.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 21.08.2022.
//

import Foundation
import FirebaseFirestore

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
//        repres["isRecommend"] = isRecommend
        return repres
    }
    
    init(id: String = UUID().uuidString, title: String, imageURL: String = "", price: Int, description: String, isRecommend: Bool) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.price = price
        self.description = description
//        self.isRecommend = isRecommend
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        guard let description = data["description"] as? String else { return nil }
//        guard let isRecommend = data["isRecommend"] as? Bool else { return nil }
        
        self.id = id
        self.title = title
        self.price = price
        self.description = description
//        self.isRecommend = isRecommend
    }
    
}

