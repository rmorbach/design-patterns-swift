
import Foundation

enum RequestState {
    case waiting, serving, ordering
}

struct Request {
    let details: String
    var state: RequestState
    
    init(details: String, state: RequestState = .waiting) {
        self.details = details
        self.state = state
    }
}

protocol Command {
    func execute()
}

class WaiterCommand: Command {
    var request: Request
    
    init(withRequest request: Request) {
        self.request = request
    }
    func execute() {
        // Ignore
    }
}

class OrderCommand: WaiterCommand {
    
    override func execute() {
        let time = arc4random_uniform(5)
        let interval = Double(time)
        Thread.sleep(forTimeInterval: interval)
        print("Request of \(self.request.details) is being ordered")
        self.request.state = .ordering
    }
}

class ServCommand: WaiterCommand {
    override func execute() {
        let time = arc4random_uniform(5)
        let interval = Double(time)
        Thread.sleep(forTimeInterval: interval)
        print("Serving \(self.request.details)")
        self.request.state = .serving
    }
}

class Waiter {

    
    let executeQueue = DispatchQueue(label: "com.waiter.executeQueue")
    
    var commands: [Command] = []
    
    init(withCommand startCommand: Command) {
        self.commands.append(startCommand)
    }
    
    func addCommand(_ command: Command) {
        commands.append(command)
    }
    
    func execute() {
       
        executeQueue.async {
            
            guard self.commands.isEmpty == false else {
                print("Waiting for commands")
                return
            }
            
            let firstCommand = self.commands.removeFirst()
            firstCommand.execute()
        }
    }

}

public func commandExample() {
    
    let cheeseBurguerRequest = Request(details: "X burger")
    let orderCheeseBurger = OrderCommand(withRequest: cheeseBurguerRequest)
    let servCheeseBurger = ServCommand(withRequest: cheeseBurguerRequest)
    
    let waiter = Waiter(withCommand: orderCheeseBurger)
    waiter.addCommand(servCheeseBurger)
    
    waiter.execute()
    waiter.execute()
    waiter.execute()
    
}
