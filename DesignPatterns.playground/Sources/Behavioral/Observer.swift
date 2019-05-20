import Foundation

@objcMembers public class KVOUser: NSObject {
    dynamic public var name: String
    public init(withName name: String) {
        self.name = name
    }
}


public func observerExample() {
    let user = KVOUser(withName: "Rodrigo")
    _ = user.observe(\.name, options: [.initial, .new]) { (user, change) in
        print("New name \(change.newValue!)")
    }
    user.name = "Rodrigo Morbach"
}
