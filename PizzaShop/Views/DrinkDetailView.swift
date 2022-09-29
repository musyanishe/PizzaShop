//
//  DrinkDetailView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 29.09.2022.
//

import SwiftUI

struct DrinkDetailView: View {
    
    let viewModel: DrinkDetailViewModel
    @State private var count = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            
            Image(uiImage: viewModel.drinkImage)
                .resizable()
                .frame(maxWidth: 180, maxHeight: 260)
                .cornerRadius(20)
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                
                HStack {
                    Text(viewModel.drink.title)
                        .font(.title2.bold())
                    Spacer()
                    Text("\(viewModel.drink.price) р")
                        .font(.title2)
                }.padding(.horizontal)
                
                Text(viewModel.drink.description)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                
                HStack {
                    Stepper("Количество", value: $count, in: 1...10)
                    
                    Text("\(count)")
                        .padding(.horizontal)
                }.padding(.horizontal)
            }
            
            Button {
                let position = Position(
                    id: UUID().uuidString,
                    product: viewModel.drink,
                    count: count)
                
                CartViewModel.shared.addPosition(position)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add to cart")
                    .padding()
                    .padding(.horizontal, 60)
                    .foregroundColor(.black)
                    .font(.title3.bold())
                    .background(LinearGradient(colors: [Color("orange"), Color("vineRed")], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(30)
            }
            .padding()
            .onAppear {
                viewModel.getImage()
            }
            Spacer()
        }
    }

}

struct DrinkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetailView(viewModel: DrinkDetailViewModel(drink: Product(
            id: "2",
            title: "Green Tea",
            imageURL: "Not Found",
            price: 125,
            description: "Fresh tea",
            isRecommend: true
        )))
    }
}
