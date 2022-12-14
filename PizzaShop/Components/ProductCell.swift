//
//  ProductCell.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 21.08.2022.
//

import SwiftUI

struct ProductCell: View {
    
    @State private var uiImage = UIImage(named: "pizzaPH")
    var product: Product
    
    var body: some View {
        VStack {
            Image(uiImage: uiImage!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: screen.width * 0.45)
                .clipped()
                .cornerRadius(20)
            
            HStack {
                Text(product.title)
                    .font(.custom("AvenirNext - regular", size: 12))
                Spacer()
                Text("\(product.price) ₽")
                    .font(.custom("AvenirNext - bold", size: 12))
            }
            .padding(.horizontal)
            .padding(.bottom, 6)
        }
        .frame(width: screen.width * 0.45, height: screen.width * 0.55)
        .background(.white)
        .cornerRadius(16)
        .shadow(radius: 10)
        .onAppear {
            StorageService.shared.downloadProductImage(id: product.id) { result in
                switch result {
                case .success(let data):
                    if let data = UIImage(data: data) {
                        self.uiImage = data
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product(
            id: "1",
            title: "Burger - pizza",
            imageURL: "Not found",
            price: 500,
            description: "Nice with beer",
            isRecommend: false
        ))
    }
}
