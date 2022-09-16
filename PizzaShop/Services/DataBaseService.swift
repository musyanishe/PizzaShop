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
    
    private var usersRef: CollectionReference { return dataBase.collection("users") } //это референс(или ссылка) уже на саму коллекцию пользователей, мы могли бы эту коллекцию создать и на самом сайте, сейчас делаем кодом
    
    private var ordersRef: CollectionReference { return dataBase.collection("orders") }
    
    private var productsRef: CollectionReference { return dataBase.collection("products") }
    
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
    func getProfile(by userID: String? = nil, completion: @escaping (Result<PropertiesUser, Error>) -> Void) {
        
        usersRef.document(userID != nil ? userID! : AuthService.shared.currentUser!.uid).getDocument { docSnapShot, error in
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
    //здесь стринг делаем опциональным, так как этим же методом будет пользователь администратор, то есть если мы передаем nil то у нас достаются из базы все заказы, а если не nil то тогда мы ищем конретного юзера в базе
    func getOrders(by userID: String?, completion: @escaping (Result<[Order], Error>) -> Void) {
        self.ordersRef.getDocuments { qSnap, error in
            
            if let qSnap = qSnap {
                var orders = [Order]()
                for doc in qSnap.documents {
                    if let userID = userID {
                        if let order = Order(doc: doc), order.userID == userID {
                            orders.append(order)
                        }
                    } else { //ветка для админа
                        if let order = Order(doc: doc) {
                            orders.append(order)
                        }
                    }
                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func setOrder(order: Order, completion: @escaping (Result<Order, Error>) -> Void) {
        ordersRef.document(order.id).setData(order.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.setPositions(to: order.id, positions: order.positions) { result in
                    switch result {
                    case .success(let positions):
                        completion(.success(order))
                        print(positions.count)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func setPositions(to orderID: String, positions: [Position], completion: @escaping (Result<[Position], Error>) -> Void) {
        let positionsRef = ordersRef.document(orderID).collection("positions")
        
        for position in positions {
            positionsRef.document(position.id).setData(position.representation)
        }
        completion(.success(positions))
    }
    //отправляем в запросе id заказа, переходим в этот заказ, достаем из него позиции и передаем в комплишн массив позиций
    func getPositions(by orderID: String, completion: @escaping (Result<[Position], Error>) -> Void) {
        
        let positionsRef = ordersRef.document(orderID).collection("positions")
        positionsRef.getDocuments { qSnap, error in
            if let qSnap = qSnap {
                var positions = [Position]()
                
                for doc in qSnap.documents {
                   if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    //метод сохранения продукта с Storage
    func setProduct(product: Product, image: Data, completion: @escaping (Result<Product, Error>) -> Void) {
        StorageService.shared.upload(id: product.id, image: image) { result in
            switch result {
            case .success(let sizeInfo):
                print(sizeInfo)
                
                self.productsRef.document(product.id).setData(product.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(product))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
