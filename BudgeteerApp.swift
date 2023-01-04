//
//  BudgeteerApp.swift
//  Budgeteer
//
//  Created by Can Arışan on 04.01.23.
//

import SwiftUI

@main
struct BudgeteerApp: App {
    let model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
