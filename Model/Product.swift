//
//  ShoppingItem.swift
//  Budgeteer
//
//  Created by Can Arışan on 04.01.23.
//

import Foundation

public class Product: Codable, Identifiable {
    
    public let id: Int
    public let receiptName: String
    public var description: String
    public var brand: String?
    public var category: Category
    
    public enum Category: String, Codable, CaseIterable {
        case processedFood = "Processed Food"
        case ingredient = "Ingredient"
        case fruit = "Fruit"
        case snacks = "Snacks & Drinks"
        case hygiene = "Hygiene & Cleaning"
        case misc = "Miscellaneous"
        case other = "Other"
    }
    
    init(id: Int, receiptName: String, category: Category, description: String? = nil, brand: String? = nil) {
        self.id = id
        self.receiptName = receiptName
        self.category = category
        self.description = description ?? ""
        self.brand = brand ?? ""
    }
    
}

extension Product: LocalFileStorable {
    static var fileName = "Products"
    
    /**
     Load the mappings of Product id to description from a file
     - returns: A dict of deserialised objects
     */
    static func loadDictFromFile() -> [Int:Product] {
        do {
            let fileWrapper = try FileWrapper(url: Self.localStorageURL, options: .immediate)
            guard let data = fileWrapper.regularFileContents else {
                throw NSError()
            }
            
            let list = try JSONDecoder().decode([Self].self, from: data)
            return Dictionary(uniqueKeysWithValues: list.map{($0.id, $0)})
        } catch _ {
            print("Could not load \(Self.self)s, the Model uses an empty collection")
            return [:]
        }
    }
}

extension Product: Equatable {
    public static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Product: Comparable {
    public static func < (lhs: Product, rhs: Product) -> Bool {
        return lhs.id < rhs.id
    }
}

extension Product: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
