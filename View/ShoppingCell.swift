//
//  ShoppingCell.swift
//  Budgeteer
//
//  Created by Can Arışan on 04.01.23.
//

import SwiftUI

struct ShoppingCell: View {
    @EnvironmentObject var model: Model
    
    var shoppingId: Shopping.ID
    
    var shopping: Shopping {
        model.shopping(shoppingId)!
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            HStack {
                Text("Shopping \(shoppingId)")
                    .font(.title)
                Spacer()
                Text("\(shopping.dateDescription)")
                    .font(.headline)
            }
            Spacer()
                .frame(height: 5)
            HStack {
                Image("Edeka")
                    .resizable()
                    .frame(
                        width: 60,
                        height: 60,
                        alignment: .center
                    )
                Spacer()
                    .frame(width: 70)
                VStack {
                    Text("Market: \(shopping.market.rawValue)")
                    Text(String(format: "Total Cost: %g%@", shopping.totalCost, shopping.currency.rawValue))
                }
            }
        }
        .padding()
        .foregroundColor(.black)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("ShoppingCell"))
        )
        .padding(.horizontal, 10)
    }
}

struct ShoppingCell_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCell(shoppingId:1).environmentObject(Model.mock)
    }
}
