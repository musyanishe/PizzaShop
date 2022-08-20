//
//  PizzaShopApp.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 20.08.2022.
//

import SwiftUI

let screen = UIScreen.main.bounds

@main
struct PizzaShopApp: App {
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
