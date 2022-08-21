//
//  ContentView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 20.08.2022.
//

import SwiftUI

struct AuthView: View {
    @State private var mail = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var isAuth = true
    @State private var isTabViewShown = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(isAuth ? "Авторизация" : "Регистрация")
                .padding()
                .padding(.horizontal, 30)
                .font(.title2.bold())
                .background(Color("whiteAlpha"))
                .cornerRadius(30)
            
            VStack {
                TextField("Введите E-mail", text: $mail)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                SecureField("Введите пароль", text: $password)
                    .padding()
                    .background(Color("whiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                if !isAuth {
                    SecureField("Повторите пароль", text: $confirmPassword)
                        .padding()
                        .background(Color("whiteAlpha"))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                }
                
                Button {
                    
                    if isAuth {
                        print("Авторизация пользователя через Firebase")
                        isTabViewShown.toggle()
                    } else {
                        print("Регистрация")
                        self.mail = ""
                        self.password = ""
                        self.confirmPassword = ""
                        self.isAuth.toggle()
                    }
                    
                } label: {
                    Text(isAuth ? "Войти" : "Создать аккаунт")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color("orange"), Color("vineRed")], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                }

                Button {
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Еще не с нами?" : "Уже есть аккаунт!")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(Color("vineRed"))
                }
                
            }
            .padding()
            .padding(.top, 10)
            .background(Color("whiteAlpha"))
            .cornerRadius(25)
            .padding(isAuth ? 30 : 12)
            
        }
        .frame(maxWidth: .infinity,  maxHeight: .infinity)
        .background(
            Image("pizzaBg")
            .resizable()
            .ignoresSafeArea()
            .aspectRatio(contentMode: .fill)
            .blur(radius: isAuth ? 0 : 6)
        )
        .animation(Animation.easeInOut(duration: 0.3), value: isAuth)
        .fullScreenCover(isPresented: $isTabViewShown) {
            MainTabBarView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .previewInterfaceOrientation(.portrait)
    }
}