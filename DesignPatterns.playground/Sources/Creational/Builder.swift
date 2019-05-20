import Foundation

public enum Meat: String {
    case chicken, beef, tofu
}

public struct Hamburger {
    public let meat: Meat
    public let sauce: Sauces
    public let toppings: Toppings
}

public struct Sauces: OptionSet {
    public static let mayonaisse = Sauces(rawValue: 1 << 0)
    public static let mustard = Sauces(rawValue: 1 << 1)
    public static let ketchup = Sauces(rawValue: 1 << 2)
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct Toppings: OptionSet {
    public static let cheese = Toppings(rawValue: 1 << 0)
    public static let pickles = Toppings(rawValue: 1 << 1)
    public static let tomatoes = Toppings(rawValue: 1 << 2)
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public class HamburgerBuilder {
    
    private var sauces: Sauces = []
    private var meat: Meat = .beef
    private var toppings: Toppings = []
    
    public func selectMeat(_ meat: Meat) {
        self.meat = meat
    }
    
    public func addSauce(_ sauce: Sauces) {
        sauces.insert(sauce)
    }
    
    public func removeSauce(_ sauce: Sauces) {
        sauces.remove(sauce)
    }
    
    public func addTopping(_ topping: Toppings) {
        toppings.insert(topping)
    }
    
    public func removeTopping(_ topping: Toppings) {
        toppings.remove(topping)
    }
    
    public func build() -> Hamburger {
        return Hamburger(meat: meat, sauce: sauces, toppings: toppings)
    }
    
}

public func builderExample() {
    let builder = HamburgerBuilder()
    builder.selectMeat(.chicken)
    builder.addSauce(.ketchup)
    builder.addSauce(.mayonaisse)
    builder.addTopping(.cheese)
    let hamburger = builder.build()
    print(String(describing: hamburger))
}
