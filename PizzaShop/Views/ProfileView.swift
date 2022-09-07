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
    
    @StateObject var viewmodel: ProfileViewModel
    
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
                    TextField("Имя", text: $viewmodel.profile.name)
                        .font(.body.bold())
                    HStack {
                        Text("+7")
                        TextField("Телефон", value: $viewmodel.profile.phone, format: .number)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Адрес доставки")
                    .bold()
                TextField("Ваш адрес", text: $viewmodel.profile.address)
            }.padding()
            
            //Таблица с заказами
            List {
                if viewmodel.orders.count == 0 {
                    Text("Ваши заказы будут тут")
                } else {
                    ForEach(viewmodel.orders, id: \.id) { order in
                        OrderCell(order: order)
                    }
                }
                
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
                        Text("Да")
                    }
                }.fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                    AuthView()
                }
        }
            
            //метод, который будет каждый раз срабатывать при нажатии на кнопку return
            .onSubmit {
                viewmodel.setProfile()
            }
            
            .onAppear {
                viewmodel.getProfile()
                viewmodel.getOrders()
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewmodel: ProfileViewModel(profile: PropertiesUser(id: "", name: "Vasya Pirogkof", phone: 3876532875, address: "tratata")))
    }
}
