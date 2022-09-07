//
//  Order.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 07.09.2022.
//

import Foundation
import FirebaseFirestore //импортируем сюда фаер бейс для того, чтобы связать дату

struct Order {
    
    var id: String = UUID().uuidString
    var userID: String
    var positions = [Position]()
    var date: Date
    var status: String
    
    var cost: Int {
        var sum = 0
        for position in positions {
            sum += position.cost
        }
        return sum
    }
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["userID"] = userID
        repres["date"] = Timestamp(date: date) //это внутренний формат времени у Firebase
        repres["status"] = status
        return repres
    }
}
