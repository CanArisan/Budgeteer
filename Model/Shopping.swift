//
//  Shopping.swift
//  Budgeteer
//
//  Created by Can Arışan on 04.01.23.
//

import Foundation

public class Shopping: Codable, Identifiable {
    
    public let id: Int
    public let date: Date
    public var market: Market
    public var itemIds: [Int]
    public var totalCost: Double
    public var currency: Currency
    
    public enum Market: String, Codable, CaseIterable {
        case edeka = "Edeka"
        case other = "Other"
    }
    
    public enum Currency: String, Codable, CaseIterable {
        case usd = "$"
        case tl = "₺"
        case eur = "€"
    }
    
    public var catalog: [Int:Product] {
        didSet {
            Array(catalog.values).saveToFile()
        }
    }
    
    public var dateDescription: String {
        let day = Calendar.current.component(.day, from: date)
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        return String(format: "%02d.%02d.%04d", day, month, year)
    }
    
    init(id: Int, date: Date, market: Market, totalCost: Double, itemIds: [Int]? = nil, catalog: [Int:Product]? = nil, currency: Currency = .eur) {
        self.id = id
        self.date = date
        self.market = market
        self.itemIds = itemIds ?? []
        self.totalCost = totalCost
        self.catalog = catalog ?? Product.loadDictFromFile()
        self.currency = currency
    }
    
}

extension Shopping: LocalFileStorable {
    static var fileName = "Shoppings"
}

extension Shopping: Equatable {
    public static func == (lhs: Shopping, rhs: Shopping) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Shopping: Comparable {
    public static func < (lhs: Shopping, rhs: Shopping) -> Bool {
        return lhs.id < rhs.id
    }
}

extension Shopping: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
