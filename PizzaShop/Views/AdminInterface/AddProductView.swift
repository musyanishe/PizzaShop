//
//  AddProductView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 13.09.2022.
//

import SwiftUI

struct AddProductView: View {
    
    @State private var showImagePicker = false
    @State private var image = UIImage(named: "pizzaPH")!
    @State private var title: String = ""
    @State private var price: Int = 0
    @State private var description: String = ""
    
    var body: some View {
        
        VStack {
            
            Text("Добавить товар")
                .font(.title2.bold())
            
            Image(uiImage: image)
                .resizable()
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 320)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(30)
                .padding(.horizontal)
                .onTapGesture {
                    showImagePicker.toggle()
                }
            TextField("Название продукта", text: $title)
                .padding()
            TextField("Цена продукта", value: $price, format: .number)
                .keyboardType(.numberPad)
                .padding()
            TextField("Описание продукта", text: $description)
                .padding()
            
            Button {
                print("Сохранить")
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
    }
    
    
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
