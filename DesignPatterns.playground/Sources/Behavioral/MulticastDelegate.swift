import Foundation

public class MulticastDelegate<ProtocolType> {
    
    private class Wrapper {
        weak var delegate: AnyObject?
        init(_ delegate: AnyObject) {
            self.delegate = delegate
        }
    }
    
    private var wrappers: [Wrapper]
    
    private var delegates: [ProtocolType] {
        return wrappers.compactMap { $0.delegate} as! [ProtocolType]
    }
    
    public init(withDelegates delegates: [ProtocolType] = []) {
        wrappers = delegates.map { Wrapper($0 as AnyObject) }
    }
    
    public func addDelegate(_ delegate: ProtocolType) {
        wrappers.append(Wrapper(delegate as AnyObject))
    }
    
    public func removeDelegate(_ delegate: ProtocolType) {
        guard let index = wrappers.firstIndex( where: { $0.delegate === (delegate as AnyObject) } ) else {
            return
        }
        wrappers.remove(at: index)
    }
    
    public func invokeDelegates(withClosure closure: (ProtocolType) -> Void) {
        delegates.forEach { closure($0) }
    }
}

public protocol Alarm: class {
    func notify(withMessage message: String)
}

class CellPhone: Alarm {
    
    func notify(withMessage message: String) {
        print("CellPhone is notifying \(message)")
    }
    
}

class TV: Alarm {
    func notify(withMessage message: String) {
        print("TV is notifying \(message)")
    }
}

class CentralAlarmSystem {
    
    private let multicastDelegate = MulticastDelegate<Alarm>()
    
    func addReceiver(_ receiver: Alarm) {
        multicastDelegate.addDelegate(receiver)
    }
    
    func remoteReceiver(_ receiver: Alarm) {
        multicastDelegate.removeDelegate(receiver)
    }
    
    func invoke(_ closure: (Alarm) -> Void) {
        multicastDelegate.invokeDelegates(withClosure: closure)
    }
}

public func multicastDelegateExample() {
    let system = CentralAlarmSystem()
    let cellPhone = CellPhone()
    let tv = TV()
    
    system.addReceiver(cellPhone)
    system.addReceiver(tv)
    
    system.invoke { alarm in
        alarm.notify(withMessage: "Meal is ready!")
    }
}


