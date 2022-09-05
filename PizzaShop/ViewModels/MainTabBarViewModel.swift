//
//  MainTabViewModel.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 05.09.2022.
//

import Foundation
import FirebaseAuth

class MainTabBarViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
}
