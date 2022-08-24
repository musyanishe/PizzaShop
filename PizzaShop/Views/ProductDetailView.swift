//
//  ProductDetailView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 21.08.2022.
//

import SwiftUI

struct ProductDetailView: View {
    
    var viewModel: ProductDetailViewModel
    @State private var size = "Small"
    @State private var count = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                
                Image("pizzaPH")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 260)
                
                
                HStack {
                    Text("\(viewModel.product.title)!")
                        .font(.title2.bold())
                        Spacer()
                    Text("\(viewModel.getPrice(size: self.size)) ₽")
                        .font(.title2)
                }.padding(.horizontal)
                
                Text("\(viewModel.product.description)")
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                
                HStack {
                    Stepper("Количество", value: $count, in: 1...10)
                
                    Text("\(count)")
                        .padding(.leading, 32)
                }.padding(.horizontal)
                
                Picker("Pizza size", selection: $size) {
                    ForEach(viewModel.sizes, id: \.self) { item in
                        Text(item)
                    }
                }.pickerStyle(.segmented)
                    .padding()
                
            }
            
            Button {
                var position = Position(id: UUID().uuidString,
                                        product: viewModel.product,
                                        count: self.count)
                position.product.price = viewModel.getPrice(size: size)
                
                CartViewModel.shared.addPosition(position)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add to cart!")
                    .padding()
                    .padding(.horizontal, 60)
                    .foregroundColor(.black)
                    .font(.title3.bold())
                    .background(LinearGradient(colors: [Color("orange"), Color("vineRed")], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(30)
            }
            
            
            Spacer()
        }
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
