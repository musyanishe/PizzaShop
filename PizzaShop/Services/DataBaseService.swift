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
    } //это референс(или ссылка) уже на саму коллекцию пользователей, мы могли бы эту коллекцию создать и на самом сайте, сейчас делаем кодом
    
    private init() {}
    
    func setProfile(user: PropertiesUser, completion: @escaping(Result<PropertiesUser, Error>) -> Void) {
 
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
    
    //docSnapShot - это раздел на firestore database со свойствами юзера по id
    func getProfile(completion: @escaping (Result<PropertiesUser, Error>) -> Void) {
        usersRef.document(AuthService.shared.currentUser!.uid).getDocument { docSnapShot, error in
            guard let snap = docSnapShot else { return }
            guard let data = snap.data() else { return }
            
            guard let userName = data["name"] as? String else { return }
            guard let id = data["id"] as? String else { return }
            guard let phone = data["phone"] as? Int else { return }
            guard let address = data["address"] as? String else { return }
            
            let user = PropertiesUser(id: id, name: userName, phone: phone, address: address)
            
            completion(.success(user))
        }
    }
}
