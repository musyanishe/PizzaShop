//
//  OrderStatus.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 07.09.2022.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    case new = "Новый"
    case cooking = "Готовится"
    case delivery = "Передано в доставку"
    case completed = "Выполнен"
    case cancelled = "Отменен"
}
