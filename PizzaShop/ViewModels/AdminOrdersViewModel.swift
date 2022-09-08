//
//  AdminOrdersViewModel.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 08.09.2022.
//

import Foundation

class AdminOrdersViewModel: ObservableObject {
    
    @Published var orders = [Order]()
    var currentOrder = Order(userID: "", date: Date(), status: "Новый")
    
    func getOrders() {
        DataBaseService.shared.getOrders(by: nil) { result in
            switch result {
                
            case .success(let orders):
                self.orders = orders
                for (index, order) in self.orders.enumerated() {
                    DataBaseService.shared.getPositions(by: order.id) { result in
                        switch result {
                        case .success(let positions):
                            self.orders[index].positions = positions
                            print(self.orders[index].cost)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
