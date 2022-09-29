//
//  CatalogView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 20.08.2022.
//

import SwiftUI

struct CatalogView: View {
    
    @StateObject var viewModel: CatalogViewModel
    
    let layoutForPopular = [GridItem(.adaptive(minimum: screen.width / 2.2))]
    let layoutForPizza = [GridItem(.adaptive(minimum: screen.width / 2.4))]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
//            Section("Популярное") {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    LazyHGrid(rows: layoutForPopular, spacing: 16) {
//                        ForEach(CatalogViewModel.shared.popular, id: \.id) { item in
//                            NavigationLink {
//                                
//                                let viewModel = ProductDetailViewModel(product: item)
//                                
//                                ProductDetailView(viewModel: viewModel)
//                            } label: {
//                                ProductCell(product: item)
//                                    .foregroundColor(.black)
//                            }
//                        }
//                    }
//                    .padding()
//                }
//            }
            
            Section("Пицца") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layoutForPizza, spacing: 18 ) {
                        ForEach(CatalogViewModel.shared.pizzas, id: \.id) { item in
                            NavigationLink {
                                
                                let viewModel = ProductDetailViewModel(product: item)
                                
                                ProductDetailView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding()
                }
            }
            
            Section("Напитки") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layoutForPizza, spacing: 18 ) {
                        ForEach(CatalogViewModel.shared.drinks, id: \.id) { item in
                            NavigationLink {

                                let viewModel = DrinkDetailViewModel(drink: item)

                                DrinkDetailView(viewModel: viewModel)
                            } label: {
                                DrinkCell(drink: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding()
                }
            }
            
        }.navigationBarTitle(Text("Каталог"))
            .onAppear {
                viewModel.getPizzas()
                viewModel.getDrinks()
            }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView(viewModel: CatalogViewModel.shared)
    }
}
