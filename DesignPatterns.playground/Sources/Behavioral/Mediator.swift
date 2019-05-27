import Foundation

protocol MediatorProtocol {
    func send(message: String, sender: ColleagueProtocol)
}

protocol ColleagueProtocol: AnyObject {
    var identifier: String { get }
    func send(message: String)
    func receive(message: String, from colleague: ColleagueProtocol)
}


class Mediator<ColleagueType: ColleagueProtocol>: MediatorProtocol {

    var colleagues = [ColleagueType]()
    
    func register(colleague: ColleagueType) {
        if !colleagues.contains(where: { ($0 as AnyObject) === (colleague as AnyObject) }) {
            colleagues.append(colleague)
        }
    }
    
    func remove(colleague: ColleagueType) {
        guard let index = colleagues.firstIndex(where: { ($0 as AnyObject) === (colleague as AnyObject) }) else {
            return
        }
        colleagues.remove(at: index)
    }
    
    func send(message: String, sender: ColleagueProtocol) {
        
        colleagues.forEach {
            guard $0.identifier != sender.identifier else { return }
            $0.receive(message: message, from: sender)
        }
        
    }
    
}

class Colleague: ColleagueProtocol {
    
    let mediator: MediatorProtocol
    let identifier: String = UUID().uuidString
    
    init(withMediator mediator: MediatorProtocol) {
        self.mediator = mediator
    }
    
    func receive(message: String, from colleague: ColleagueProtocol) {
        print("Received \(message) from \(colleague)")
    }
    
    func send(message: String) {
        mediator.send(message: message, sender: self)
    }
    
}

public func mediatorExample() {
    let mediator = Mediator<Colleague>()
    
    let developer = Colleague(withMediator: mediator)
    let qa = Colleague(withMediator: mediator)
    
    mediator.register(colleague: developer)
    mediator.register(colleague: qa)
    
    developer.send(message: "I've just finished the task")
    qa.send(message: "Ok, I'will test it very soon")
}
