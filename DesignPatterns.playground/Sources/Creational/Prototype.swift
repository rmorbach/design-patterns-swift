import Foundation

public protocol Copying: AnyObject {
    // Copy initializer
    init(withPrototype prototype: Self)
}

extension Copying {
    public func copy() -> Self {
        return type(of: self).init(withPrototype: self)
    }
}


public class GameStatus: Copying {
    
    let level: Int
    init(withLevel level: Int) {
        self.level = level
    }
    
    required convenience public init(withPrototype prototype: GameStatus) {
        self.init(withLevel: prototype.level)
    }
    
}

