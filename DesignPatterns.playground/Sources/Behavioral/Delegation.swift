import Foundation

public protocol DelegateProtocol {
    func didDoSomething()
}

public class WhoDelegates {
    public var delegate: DelegateProtocol?
    
    public init(withDelegate delegate: DelegateProtocol) {
        self.delegate = delegate
    }
    
    func onSomethingHappen() {
        self.delegate?.didDoSomething()
    }
}

public class DelegateObject: DelegateProtocol {
    
    public func didDoSomething() {
        debugPrint(#function)
    }
}

public func delegationExample() {
    let delegateObject = DelegateObject()
    let whoDelegates = WhoDelegates(withDelegate: delegateObject)
    whoDelegates.onSomethingHappen()
}
