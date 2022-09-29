//
//  PositionCell.swift
//  PizzaShop
//
//  Created by Евгения Шевцова on 23.08.2022.
//

import SwiftUI

struct PositionCell: View {
    
    let position: Position
    
    var body: some View {
        
        HStack {
            Text(position.product.title)
                .fontWeight(.bold)
            Spacer()
            Text("\(position.count) шт.")
            Text("\(position.cost) ₽")
                .frame(width: 85, alignment: .trailing)
        }.padding(.horizontal)
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(
            position: Position(id: UUID().uuidString,
                               product: Product(
                                id: UUID().uuidString,
                                title: "Burger - Pizza",
                                imageURL: "pizzaPH",
                                price: 350,
                                description: "Nice with beer",
                               isRecommend: true),
                               count: 3))
    }
}
