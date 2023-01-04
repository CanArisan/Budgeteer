//
//  HomeView.swift
//  Budgeteer
//
//  Created by Can Arışan on 04.01.23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack {
            Text("Shoppings")
                .font(.title)
            ScrollView {
                ForEach(model.shoppings) { shopping in
                    ShoppingCell(shoppingId: shopping.id)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Model.mock)
    }
}
