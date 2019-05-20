import Foundation

/// Memento is used to save and restore state of objects

public struct Game: Codable {
    public struct State: Codable {
        public var attemptsRemaining: Int = 3
        public var level: Int = 1
        public var score: Int = 0
    }
    
    public var state = State()
}

public class GameSystem {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let storeKey = "stored_game"
    
    @discardableResult public func save(_ game: Game) -> Bool {
        guard let encodedGame = try? self.encoder.encode(game) else {
            return false
        }
        UserDefaults.standard.set(encodedGame, forKey: storeKey)
        return true
    }
    
    public func restore() -> Game? {
        guard let storedData = UserDefaults.standard.data(forKey: storeKey),
            let game = try? self.decoder.decode(Game.self, from: storedData) else {
            return nil
        }
        return game
    }
}

public func mementoExample() {
    let gameSate = Game.State(attemptsRemaining: 10, level: 2, score: 100)
    let game = Game(state: gameSate)
    let gameSystem = GameSystem()
    gameSystem.save(game)
    if let restoredGame = gameSystem.restore() {
        print(String(describing: restoredGame))
    }
}
