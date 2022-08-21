//
//  ProductDetailView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 21.08.2022.
//

import SwiftUI

struct ProductDetailView: View {
    
    var viewModel: ProductDetailViewModel
    
    var body: some View {
        Text("\(viewModel.product.title)")
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDetailViewModel(product: Product(
            id: "1",
            title: "Burger - pizza",
            imageURL: "Not found",
            price: 500,
            description: "Nice with beer"
        )))
    }
}
