import Foundation

public class MySingleton {
    public static let shared = MySingleton()
    public var someProperty: Int = 0
    private init() { }
}

public func singletonExample() {
    let singleton = MySingleton.shared
    singleton.someProperty = 1
    print("Singleton property is \(singleton.someProperty)")
    MySingleton.shared.someProperty = 2
    print("Now singleton property is \(singleton.someProperty)")
}
