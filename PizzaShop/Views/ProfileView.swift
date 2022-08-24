//
//  ProfileView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 20.08.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var isAvatarAlertPresented = false
    @State private var isQuitAlertPresented = false
    @State private var isAuthViewPresented = false
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 16) {
                Image("user")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .background(Color("lightGray"))
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvatarAlertPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять аву?", isPresented: $isAvatarAlertPresented) {
                        Button {
                            print("Library")
                        } label: {
                            Text("From Library")
                        }
                        
                        Button {
                            print("Camera")
                        } label: {
                            Text("Camera")
                        }
                        

                    }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Мирослав Иванов")
                        .bold()
                    Text("+7(911)189-22-12")
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Адрес доставки:")
                    .bold()
                Text("Россия, Московская область, г. Несуществующий городок, ул. Юных мечт, д. 23, кв.35")
            }
            
            //Таблица с заказами
            List {
                Text("Ваши заказы будут тут")
            }.listStyle(.plain)
            
            Button {
                isQuitAlertPresented.toggle()
            } label: {
                Text("Выйти")
                    .padding()
                    .padding(.horizontal)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }.padding()
                .confirmationDialog("Действительно хотите выйти?", isPresented: $isQuitAlertPresented) {
                    Button {
                        isAuthViewPresented.toggle()
                    } label: {
                        Text("Yes")
                    }

                }.fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                    AuthView()
                }

            
        }
        
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
