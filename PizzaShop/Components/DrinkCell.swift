//
//  DrinkCell.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 29.09.2022.
//

import SwiftUI

struct DrinkCell: View {
    
    @State private var uiImage = UIImage(named: "GreenTea")!
    var drink: Product
    
    var body: some View {
        VStack {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: screen.width * 0.35)
                .clipped()
                .cornerRadius(20)
            
            HStack {
                Text(drink.title)
                    .font(.custom("AvenirNext - regular", size: 12))
                Spacer()
                Text("\(drink.price) ₽")
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
            StorageService.shared.downloadDrinkImage(id: drink.id) { result in
                switch result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        self.uiImage = image
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    
    }
}

struct DrinkCell_Previews: PreviewProvider {
    static var previews: some View {
        DrinkCell(drink: Product(
            id: "1",
            title: "Green tea",
            imageURL: "Not found",
            price: 132,
            description: "Fresh drink",
            isRecommend: false
        ))
    }
}
