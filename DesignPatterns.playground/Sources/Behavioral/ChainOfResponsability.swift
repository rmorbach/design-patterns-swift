import Foundation

protocol Coin {
    var diameter: Double { get }
    var weight: Double { get }
    var centValue: Int { get }
    var description: String { get }
}

extension Coin {
    var description: String {
        return String(format: "{diameter: %0.3f, dollarValue: $%0.2f, weight: %0.3f}", diameter, centValue, weight)
    }
}

class Penny: Coin {
    var diameter: Double {
        return 0.75
    }
    
    var weight: Double {
        return 2.5
    }
    
    var centValue: Int {
        return 1
    }
}

public func chainOfResponsabilityExample() {
    let penny = Penny()
    print(penny.description)
}
