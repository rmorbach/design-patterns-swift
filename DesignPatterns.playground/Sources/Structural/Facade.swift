import Foundation

protocol Runnable {
    func start() -> Bool
    func stop()
}

class FullInjector: Runnable {
    
    func start() -> Bool {
        print("FullInjector started")
        return true
    }
    
    func stop() {
        print("FullInjector stopped")
    }
    
}
class CoolingSystem: Runnable {
    func start() -> Bool {
        print("CoolingSystem started")
        return true
    }
    func stop() {
        print("CoolingSystem stopped")
    }
}

class Engine: Runnable {

    let fullInjector = FullInjector()
    let coolingSystem = CoolingSystem()
    
    func start() -> Bool {
        guard fullInjector.start() == true else {
            return false
        }
        guard coolingSystem.start() == true else {
            return false
        }
        print("Engine started")
        return true
    }
    
    func stop() {
        fullInjector.stop()
        coolingSystem.stop()
        print("Engine stopped")
    }
}

class EngineFacade: Runnable {
    let engine = Engine()
    func start() -> Bool {
        print("EngineFacade started")
        return engine.start()
    }
    func stop() {
        engine.stop()
        print("EngineFacade stopped")
    }
}

class EletricSystem: Runnable {
    func start() -> Bool {
        print("EletrictSystem started")
        return true
    }
    
    func stop() {
        print("EletrictSystem stopped")
    }
}

class Car: Runnable {
    
    let engineFacade = EngineFacade()
    let eletricSystem = EletricSystem()
    
    func start() -> Bool {
        print("Starting car")
        return engineFacade.start() && eletricSystem.start()
    }
    
    func stop() {
        engineFacade.stop()
        eletricSystem.stop()
        print("Stopping car")
    }
}


public func facadeExample() {
    
    let car = Car()
    car.start()
    car.stop()
    
}
