//
//  Model.swift
//  Budgeteer
//
//  Created by Can Arışan on 04.01.23.
//

import Foundation

// MARK: - Model
/// Contains all persistent data and handles storing and loading.
public class Model {
    
    // MARK: Stored Instance Properties
    @Published public private(set) var shoppings: [Shopping] {
        didSet {
            shoppings.saveToFile()
        }
    }
    @Published public private(set) var shoppingItems: [ShoppingItem] {
        didSet {
            shoppingItems.saveToFile()
        }
    }
    @Published public private(set) var products: [Product] {
        didSet {
            products.saveToFile()
        }
    }
    
    // MARK: Initializer
    public init(shoppings: [Shopping]? = nil, shoppingItems: [ShoppingItem]? = nil, products: [Product]? = nil) {
        self.shoppings = shoppings ?? Shopping.loadFromFile()
        self.shoppingItems = shoppingItems ?? ShoppingItem.loadFromFile()
        self.products = products ?? Product.loadFromFile()
    }
    
    // MARK: Instance Methods
    
    public func shopping(_ id: Shopping.ID?) -> Shopping? {
        shoppings.first(where: { $0.id == id })
    }
    
    public func shoppingItem(_ id: ShoppingItem.ID?) -> ShoppingItem? {
        shoppingItems.first(where: { $0.id == id })
    }
    
    public func product(_ id: Product.ID?) -> Product? {
        products.first(where: { $0.id == id })
    }
    
    public func save(_ shopping: Shopping) {
        delete(shopping: shopping.id)
        shoppings.append(shopping)
        shoppings.sort()
    }
    
    public func save(_ shoppingItem: ShoppingItem) {
        delete(shoppingItem: shoppingItem.id)
        shoppingItems.append(shoppingItem)
        shoppingItems.sort()
    }
    
    public func save(_ product: Product) {
        delete(product: product.id)
        products.append(product)
        products.sort()
    }
    
    public func delete(shopping id: Shopping.ID) {
        shoppings.removeAll(where: { $0.id == id })
    }
    
    public func delete(shoppingItem id: ShoppingItem.ID) {
        shoppingItems.removeAll(where: { $0.id == id })
    }
    
    public func delete(product id: Product.ID) {
        products.removeAll(where: { $0.id == id })
    }
    
    public func nextShoppingId() -> Int {
        return 1 + (shoppings.last?.id ?? 0)
    }
    
    public func nextShoppingItemId() -> Int {
        return 1 + (shoppingItems.last?.id ?? 0)
    }
    
    public func nextProductId() -> Int {
        return 1 + (products.last?.id ?? 0)
    }
}

// MARK: Extension: Model: ObservableObject
extension Model: ObservableObject { }

// MARK: Extension: Model
#if DEBUG
extension Model {
    
    // MARK: Stored Type Properties
    /**
     Mock data to enable working with the preview.
     */
    public static var mock: Model {
        
        let product1 = Product(id: 1,
                               receiptName: "Exquis. Frisch.",
                               category: .processedFood,
                               description: "Exquisa Frischkäse",
                               brand: "Exquisa")
        
        let product2 = Product(id: 1,
                               receiptName: "Avokado",
                               category: .fruit,
                               description: "Avokado")
        
        let item1 = ShoppingItem(id: 1,
                                 productId: 1,
                                 cost: 1.89)
        
        let item2 = ShoppingItem(id: 1,
                                 productId: 1,
                                 cost: 1.69)
        
        let shopping = Shopping(id: 1,
                                date: Date(),
                                market: .edeka,
                                totalCost: 2.58,
                                itemIds: [1, 2],
                                catalog: [1:product1, 2:product2])
        
        let products = [product1, product2]
        let shoppingItems = [item1, item2]
        let shoppings = [shopping]
        
        // Create a model with data
        let mock = Model(shoppings:shoppings, shoppingItems:shoppingItems, products: products)
        
        return mock
    }
}
#endif
