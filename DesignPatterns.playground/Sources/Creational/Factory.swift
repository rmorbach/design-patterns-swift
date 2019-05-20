import Foundation

public class ProductFactory {
    
    public class func createProduct(withName name: String, price: Double) -> Product {
        return Product(identifier: UUID(), name: name, price: price)
    }
    
}

public struct Product {
    let identifier: UUID
    let name: String
    let price: Double
}

public func factoryExample() {
    let product = ProductFactory.createProduct(withName: "Shampoo", price: 20.0)
    debugPrint(product)
    
}
