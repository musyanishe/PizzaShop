//
//  OrderView.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 08.09.2022.
//

import SwiftUI

struct OrderView: View {
    
    @StateObject var viewModel: OrderViewModel
   
    var statuses: [String] {
        var sts = [String]()
        
        for status in OrderStatus.allCases {
            sts.append(status.rawValue)
        }
        return sts
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("\(viewModel.user.name)")
                .font(.title3)
                .bold()
            Text("+7 \(viewModel.user.phone)")
            Text("\(viewModel.user.address)")
            
            Picker(selection: $viewModel.order.status) {
                ForEach(statuses, id: \.self) { status in
                    Text(status)
                }
            } label: {
                Text("Cтатус заказа")
            }
            .pickerStyle(.segmented)
            .onChange(of: viewModel.order.status) { newStatus in
                DataBaseService.shared.setOrder(order: viewModel.order) { result in
                    switch result {
                    case .success(let order):
                        print(order.status)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }

            
            List {
                ForEach(viewModel.order.positions, id: \.id) { position in
                    PositionCell(position: position)
                }
                Text("ИТОГО: \(viewModel.order.cost) ₽")
                    .bold()
            }
            
        }.padding()
            .onAppear {
                viewModel.getUserData()
            }
    }
    
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(viewModel: OrderViewModel(order: Order(userID: "",
                                                         date: Date(),
                                                         status: "New")))
    }
}
