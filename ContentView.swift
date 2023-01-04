//
//  ContentView.swift
//  Budgeteer
//
//  Created by Can Arışan on 04.01.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        HomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Model.mock)
    }
}
