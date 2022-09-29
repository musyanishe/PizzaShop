//
//  ProductDetailViewModel.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 22.08.2022.
//

import Foundation
import UIKit

class ProductDetailViewModel: ObservableObject {
    
    @Published var product: Product
    @Published var sizes = ["Small", "Medium", "Large"]
    @Published var count = 0
    @Published var image = UIImage(named: "pizzaPH")!
    
    init(product: Product) {
        self.product = product
    }
    
    func getPrice(size: String) -> Int {
        switch size {
        case "Small": return product.price
        case "Medium": return Int(Double(product.price) * 1.25)
        case "Large": return Int(Double(product.price) * 1.5)
        default: return 0
        }
    }
    
    func getImage() {
        StorageService.shared.downloadProductImage(id: product.id) { result in
            switch result {
                
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
 
