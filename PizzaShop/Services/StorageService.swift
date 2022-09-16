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
    
    private init() {}
    
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
    
}
