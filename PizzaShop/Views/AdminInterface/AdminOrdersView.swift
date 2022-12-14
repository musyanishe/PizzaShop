//
//  AdminOrdersView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 08.09.2022.
//

import SwiftUI

struct AdminOrdersView: View {
    
    @StateObject var viewModel = AdminOrdersViewModel()
    @State private var isOrderViewShow = false
    @State private var isShowAuthView = false
    @State private var isShowAddProductView = false
    @State private var isAlertPresented = false
    @State private var isShowAddDrinkView = false
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    AuthService.shared.signOut()
                    isShowAuthView.toggle()
                } label: {
                    Text("Выйти")
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Button {
                    isAlertPresented.toggle()
                } label: {
                    Text("Добавить товар")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .confirmationDialog("Какой продукт добавить?", isPresented: $isAlertPresented) {
                    
                    Button {
                        isShowAddProductView.toggle()
                    } label: {
                        Text("Добавить пиццу")
                    }
                    
                    Button {
                        isShowAddDrinkView.toggle()
                    } label: {
                        Text("Добавить напиток")
                    }
                    
                }

                
                Spacer()
                
                Button {
                    viewModel.getOrders()
                } label: {
                    Text("Обновить")
                }

            }.padding()

            List {
                ForEach(viewModel.orders, id: \.id) { order in
                    OrderCell(order: order)
                        .onTapGesture {
                            viewModel.currentOrder = order
                            isOrderViewShow.toggle()
                        }
                }
            }.listStyle(.plain)
                .onAppear {
                    viewModel.getOrders()
                }
                .sheet(isPresented: $isOrderViewShow) {
                    let orderViewModel = OrderViewModel(order: viewModel.currentOrder)
                    OrderView(viewModel: orderViewModel)
                }
        }
        .fullScreenCover(isPresented: $isShowAuthView) {
            AuthView()
        }
        .sheet(isPresented: $isShowAddProductView) {
            AddProductView()
        }
        .sheet(isPresented: $isShowAddDrinkView) {
            AddDrinkView()
        }
    }
}

struct AdminOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        AdminOrdersView()
    }
}
