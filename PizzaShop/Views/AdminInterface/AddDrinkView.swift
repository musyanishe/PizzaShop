//
//  AddDrinkView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 26.09.2022.
//

import SwiftUI

struct AddDrinkView: View {
    
    @State private var showImagePicker = false
    @State private var image = UIImage(named: "GreenTea")!
    @State private var title: String = ""
    @State private var price: Int? = nil
    @State private var description: String = ""
    @State private var isRecommend: Bool = true
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            
            Text("Добавить напиток")
                .font(.title2.bold())
            
            Image(uiImage: image)
                .resizable()
                .frame(minWidth: 150, idealWidth: 200, maxWidth: 220, minHeight: 220, idealHeight: 250, maxHeight: 270)
                .cornerRadius(20)
                .padding(.horizontal)
                .onTapGesture {
                    showImagePicker.toggle()
                }
            TextField("Название", text: $title)
                .padding()
            TextField("Цена", value: $price, format: .number)
                .keyboardType(.numberPad)
                .padding()
            TextField("Описание", text: $description)
                .padding()
            
            Button {
                guard let price = price else {
                    print("Невозможно извлечь цену из TextField")
                    return
                }
                let drink = Product(id: UUID().uuidString, title: title, price: price, description: description, isRecommend: isRecommend)
                guard let imageData = image.jpegData(compressionQuality: 0.15) else {
                    print("Может тут косяк?)")
                    return }
                DataBaseService.shared.setDrink(drink: drink, image: imageData) { result in
                    switch result {
                    case .success(let product):
                        print(product.title)
                        dismiss()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Сохранить")
                    .padding()
                    .padding(.horizontal, 30)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            
            Spacer()
            
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
        .padding(.vertical)
    }
    
}

struct AddDrinkView_Previews: PreviewProvider {
    static var previews: some View {
        AddDrinkView()
    }
}
