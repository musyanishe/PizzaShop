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
    private var currentUser: User? {
        return auth.currentUser
    }
    
    func singUP(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void) {
            
            auth.createUser(withEmail: email, password: password) { result, error in
                
                if let result = result {
                    completion(.success(result.user))
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }
    
}
