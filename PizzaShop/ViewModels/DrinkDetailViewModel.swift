//
//  DrinkDetailViewModel.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 29.09.2022.
//

import UIKit

class DrinkDetailViewModel: ObservableObject {
    
    @Published var drink: Product
    @Published var count = 0
    @Published var drinkImage = UIImage(named: "GreenTea")!
    
    init(drink: Product) {
        self.drink = drink
    }
    
    func getImage() {
        StorageService.shared.downloadDrinkImage(id: drink.id) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.drinkImage = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
