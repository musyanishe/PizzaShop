//
//  DataBaseService.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 05.09.2022.
//

import Foundation
import FirebaseFirestore

//класс-сервис для работы с базой данных в FireBase, тут импортируем фреймворк FirebaseFirestore(он пока крайний который поддерживается)
class DataBaseService {
    
    static let shared = DataBaseService()
    
    private let dataBase = Firestore.firestore() //по этой ссылке мы входим в нашу базу данных, если посмтреть на сайт Firebase, то эта база лежит во вкладке FireStore Database и получаем доступ ко всей папке с коллекциями, в моем случае это pizzashop-10778
    
    private var usersRef: CollectionReference {
        return dataBase.collection("users")
    } //это референс(или ссылка) уже на саму коллекцию пользователей^ мы могли бы эту коллекцию создать и на самом сайте, сейчас делаем кодом
    
    private init() {}
    
    func setUser(user: PropertiesUser, completion: @escaping(Result<PropertiesUser, Error>) -> Void) {
 
        /*
         Это первый способ как сохранять свойства юзера по id, но такой метод неудобен в использовании, так как раздувает наш сервис DataBaseService, поэтому свойства юзера можно репрезентовать прямо в модели, а здесь напишем следующий способом (см ниже)
        usersRef.document(user.id).setData([
            "id": user.id,
            "name": user.name,
            "phone": user.phone,
            "address": user.address
        ])
         */
        
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
}
