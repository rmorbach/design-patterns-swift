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

class Dime: Coin {
    var diameter: Double {
        return 0.75
    }
    var weight: Double {
        return 2.268
    }
    
    var centValue: Int {
        return 10
    }
}


protocol CoinHandlerProtocol {
    var next: CoinHandlerProtocol? { get }
    func handleCoinValidation(_ coin: Coin) -> Coin?
}

class CoinHandler: CoinHandlerProtocol {
    var next: CoinHandlerProtocol?
    
    var coinType: Coin.Type
    
    init(withCoinType coinType: Coin.Type) {
        self.coinType = coinType
    }
    
    func handleCoinValidation(_ coin: Coin) -> Coin? {
        guard let validatedCoint = self.createCoin(from: coin) else {
            return next?.handleCoinValidation(coin)
        }
        return validatedCoint
    }
    
    private func createCoin(from coin: Coin) -> Coin? {
        // TODO - perform coin validation
        return nil
    }
}

enum CoinValidationError: Error {
    case invalidCoin(coin: Coin)
}

class VendingMachine {
    let coinHandler: CoinHandler
    var coins = [Coin]()
    
    init(withHandler handler: CoinHandler) {
        self.coinHandler = handler
    }
    
    func insertCoin(_ coin: Coin) throws {
        guard let validatedCoin = coinHandler.handleCoinValidation(coin) else {
            throw CoinValidationError.invalidCoin(coin: coin)
        }
        coins.append(validatedCoin)
    }
}

public func chainOfResponsabilityExample() {
    // First handler
    let pennyHandler = CoinHandler(withCoinType: Penny.self)
    let dimeHandler = CoinHandler(withCoinType: Dime.self)
    
    pennyHandler.next = dimeHandler
    
    let vendingMachine = VendingMachine(withHandler: pennyHandler)
    do {
        let penny = Penny()
        try vendingMachine.insertCoin(penny)
        print(penny.description)
    } catch {
        print(error)
    }
}
