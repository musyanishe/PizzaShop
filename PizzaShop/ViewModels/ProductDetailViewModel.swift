//
//  ProductDetailViewModel.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 22.08.2022.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    
    @Published var product: Product 
    
    init(product: Product) {
        self.product = product
    }
}
 
