//
//  PizzaShopApp.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 20.08.2022.
//

import Firebase
import FirebaseAuth
import SwiftUI

let screen = UIScreen.main.bounds

@main
struct PizzaShopApp: App {
    
    //связываем класс AppDelegate со свифтуй
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
    
    //в этом месте мы вшиваем Firebase в наш проект
    class AppDelegate: NSObject, UIApplicationDelegate {
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            
            FirebaseApp.configure()
            print("App Delegate launched")
            
            return true
        }
    }
    
}
