import Foundation

protocol MobileAlertState {
    func alert()
}

class AlertContext {
    
    private(set) var currentState: MobileAlertState
    init() {
        self.currentState = SilentState()
    }
    
    func changeState(to newState: MobileAlertState) {
        self.currentState = newState
    }
    
    func alert() {
        self.currentState.alert()
    }
    
}

class SilentState: MobileAlertState {
    
    func alert() {
        print("Silent mode...")
    }
}

class VibrationState: MobileAlertState {
    func alert() {
        print("Vibration mode...")
    }
}

public func stateExample() {
    let context = AlertContext()
    context.alert()
    context.alert()
    context.changeState(to: VibrationState())
    context.alert()
    context.alert()
}
