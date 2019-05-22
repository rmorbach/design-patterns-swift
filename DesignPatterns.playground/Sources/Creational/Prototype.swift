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
    
    var level: Int
    init(withLevel level: Int) {
        self.level = level
    }
    
    required convenience public init(withPrototype prototype: GameStatus) {
        self.init(withLevel: prototype.level)
    }
}

public func prototypeExample() {
    let game1 = GameStatus(withLevel: 10)
    let game2 = game1.copy()
    game2.level = 20
    print("Game1 level: \(game1.level); Game2 level: \(game2.level)")
}
