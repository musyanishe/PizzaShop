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
    
    @State private var isAlertShown = false
    @State private var alertMessage = ""
    
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
                        
                        AuthService.shared.signIn(email: self.mail, password: self.password) { result in
                            switch result {
                            case .success(_):
                                isTabViewShown.toggle()
                            case . failure(let error):
                                alertMessage = "Ошибка авторизации: \(error.localizedDescription)"
                                isAlertShown.toggle()
                            }
                        }
                        
                        
                    } else {
                        print("Регистрация")
                        
                        guard password == confirmPassword else {
                            alertMessage = "Пароли не совпадают"
                            isAlertShown.toggle()
                            return
                        }
                        
                        AuthService.shared.signUP(email: self.mail, password: self.password) { result in
                            switch result {
                                
                            case .success(let user):
                                alertMessage = "Вы зарегистрировались с email: \(user.email!)"
                                self.isAlertShown.toggle()
                                self.mail = ""
                                self.password = ""
                                self.confirmPassword = ""
                                self.isAuth.toggle()
                            case .failure(let error):
                                self.alertMessage = "Ошибка регистрации \(error.localizedDescription)"
                                self.isAlertShown.toggle()
                            }
                        }
                        
                        
                       
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
            .alert(alertMessage, isPresented: $isAlertShown) {
                Button {} label: {
                    Text("OK")
                }

            }
            
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
            
            if AuthService.shared.currentUser?.uid == "SGiqaFRBNIYZejGeof8vRLso5CF3" {
                AdminOrdersView()
            } else {
                let mainTabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)
                MainTabBarView(viewModel: mainTabBarViewModel)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .previewInterfaceOrientation(.portrait)
    }
}
