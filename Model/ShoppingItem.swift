//
//  ShoppingItem.swift
//  Budgeteer
//
//  Created by Can Arışan on 04.01.23.
//

import Foundation

public class ShoppingItem: Codable, Identifiable {
    
    public let id: Int
    public let productId: Int
    public var cost: Double
    
    init(id: Int, productId: Int, cost: Double) {
        self.id = id
        self.cost = cost
        self.productId = productId
    }
    
}

extension ShoppingItem: LocalFileStorable {
    static var fileName = "ShoppingItems"
}

extension ShoppingItem: Equatable {
    public static func == (lhs: ShoppingItem, rhs: ShoppingItem) -> Bool {
        return lhs.id == rhs.id
    }
}

extension ShoppingItem: Comparable {
    public static func < (lhs: ShoppingItem, rhs: ShoppingItem) -> Bool {
        return lhs.id < rhs.id
    }
}

extension ShoppingItem: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
