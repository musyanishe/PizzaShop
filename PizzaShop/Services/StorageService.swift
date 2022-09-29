//
//  StorageService.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 15.09.2022.
//

import Foundation
import FirebaseStorage

class StorageService {
    
    static let shared = StorageService()
    
    private let storage = Storage.storage().reference() // Storage - это хранилище из firebase, указываем путь до хранилища
    private var productsRef: StorageReference { storage.child("products") }
    private var drinksRef: StorageReference { storage.child("drinks") }
    
    private init() {}
    //products
    func upload(id: String, image: Data, completion: @escaping (Result<String, Error>) -> Void) {
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        productsRef.child(id).putData(image, metadata: metaData) { metaData, error in
            guard let metaData = metaData else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success("Размер полученного изображения: \(metaData.size)"))
        }
    }
    
    func downloadProductImage(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        productsRef.child(id).getData(maxSize: 2*1024*1024) { data, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(data))
        }
    }
    
    //drinks
    func uploadDrink(id: String, image: Data, completion: @escaping (Result<String, Error>) -> Void) {
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        drinksRef.child(id).putData(image, metadata: metaData) { metaData, error in
            guard let metaData = metaData else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success("Размер полученного изображения: \(metaData.size)"))
        }
    }
    
    func downloadDrinkImage(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        drinksRef.child(id).getData(maxSize: 2*1024*1024) { data, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(data))
        }
    }
    
}
