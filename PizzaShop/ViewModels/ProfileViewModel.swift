//
//  ProfileViewModel.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 06.09.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var profile: PropertiesUser
    @Published var orders: [Order] = [Order]()
    
    init(profile: PropertiesUser) {
        self.profile = profile
    }
    
    func getOrders() {
        DataBaseService.shared.getOredrs(by: AuthService.shared.currentUser?.accessibilityHint) { result in
            switch result {
            case .success(let orders):
                self.orders = orders
                print("Всего заказов: \(orders.count)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setProfile() {
        DataBaseService.shared.setProfile(user: self.profile) { result in
            switch result {
                
            case .success(let user):
                print(user.name)
            case .failure(let error):
                print("Ошибка отправки данных \(error.localizedDescription)")
            }
        }
    }
    
    func getProfile() {
        DataBaseService.shared.getProfile { result in
            switch result {
                
            case .success(let user):
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
