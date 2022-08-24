//
//  CartView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 20.08.2022.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var viewModel: CartViewModel //делаем ViewModel наблюдаемой, то есть сможем получать сразу оповещение об изменении во вью модели
    
    var body: some View {
        
        VStack {
            List(viewModel.positions) { position in
                PositionCell(position: position)
                    .swipeActions {
                        Button {
                            viewModel.positions.removeAll { pos in
                                pos.id == position.id
                            }
                        } label: {
                            Text("Delete")
                        }.tint(.red)

                    }
            }
            .listStyle(.plain)
            .navigationTitle("Cart")
            
            HStack {
                Text("ИТОГО:")
                    .fontWeight(.bold)
                Spacer()
                Text("\(viewModel.cost) ₽")
                    .fontWeight(.bold)
            }.padding()
         
            
            HStack(spacing: 24) {
                Button {
                    print("Отменить")
                } label: {
                    Text("Отменить")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(24)
                }
                
                Button {
                    print("Заказать")
                } label: {
                    Text("Заказать")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(24)
                }

            }.padding()
            
            
            
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel.shared)
    }
}
