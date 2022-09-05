//
//  AuthService.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 24.08.2022.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    //cвойство, которое хранит в себе ссылку на авторизацию, то есть на окно Authentication на сайте FireBase
    private let auth = Auth.auth()
    //текующий юзер, опциональный, так как он может быть как зарегистрированным так и нет
    //класс User, это тот который нам дает FirebaseAuth
    var currentUser: User? {
        return auth.currentUser
    }
    //здесь реализуем регистрацию, методы auth.createUser и auth.signIn это методы встроенные в Firebase
    func signUP(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void) {
            
            auth.createUser(withEmail: email, password: password) { result, error in
                
                if let result = result {
                    let propertiesUser = PropertiesUser(
                        id: result.user.uid, //берем настоящий пользовательский id
                        name: "",
                        phone: 0,
                        address: ""
                    )
                    
                    DataBaseService.shared.setUser(user: propertiesUser) { resultDB in
                        switch resultDB {
                        case .success(_):
                            completion(.success(result.user))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }
    
    //здесь реализуем авторизацию
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void) {
            
            auth.signIn(withEmail: email, password: password) { result, error in
                if let result = result {
                    completion(.success(result.user))
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }
    
}
