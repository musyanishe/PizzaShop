//
//  MainTabBarView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 20.08.2022.
//

import SwiftUI

struct MainTabBarView: View {
    
    var viewModel: MainTabBarViewModel
    
    
    var body: some View {
        
        TabView {
            
            NavigationView{
                CatalogView()
            }
            .tabItem {
                Image(systemName: "menucard")
                Text("Catalog")
            }
            
            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        
    }
}

//struct MainTabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabBarView(viewModel: MainTabBarViewModel(user: User()))
//    }
//}
