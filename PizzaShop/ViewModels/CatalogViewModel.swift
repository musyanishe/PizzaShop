//
//  CatalogViewModel.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 21.08.2022.
//

import Foundation

class CatalogViewModel: ObservableObject {
    
    static let shared = CatalogViewModel()
    
//    var popularProducts = [
//    Product(
//        id: "1",
//        title: "Burger - pizza",
//        imageURL: "Not found",
//        price: 500,
//        description: "Nice with beer"
//     ),
//    Product(
//        id: "2",
//        title: "Peperoni",
//        imageURL: "Not found",
//        price: 350,
//        description: "Nice with beer"
//     ),
//    Product(
//        id: "3",
//        title: "Margarita",
//        imageURL: "Not found",
//        price: 450,
//        description: "Nice with beer"
//     ),
//    Product(
//        id: "4",
//        title: "Gavayan",
//        imageURL: "Not found",
//        price: 400,
//        description: "Nice with beer"
//     ),
//    Product(
//        id: "5",
//        title: "4Cheese",
//        imageURL: "Not found",
//        price: 650,
//        description: "Nice with beer"
//     )
//    ]
    
    @Published var pizzas = [Product]()
    @Published var drinks = [Product]()
    
    private init() {}
    
    func getPizzas() {
        DataBaseService.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.pizzas = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getDrinks() {
        DataBaseService.shared.getDrinks { result in
            switch result {
            case .success(let drinks):
                self.drinks = drinks
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
