import UIKit

extension UIColor {
    
    static var colorStore: [String: UIColor] = [:]
    
    class func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        let key = "\(red)\(green)\(blue)\(alpha)"
        
        if let storedColor = UIColor.colorStore[key] {
            return storedColor
        }
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        UIColor.colorStore[key] = color
        return color
    }
}


public func flyWeightExample() {
    let green1 = UIColor.green
    let green2 = UIColor.green
    // both points to the same memory address
    if green1 == green2 {
        print("green1 is EQUAL to green2")
    }
    
    let blue1 = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
    let blue2 = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
    
    // there are different objects in memory
    if blue1 === blue2 {
        print("blue1 is EQUAL to blue2")
    } else {
        print("blue1 is NOT EQUAL to blue2")
    }
    
    let red1 = UIColor.rgba(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    let red2 = UIColor.rgba(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    
    if red1 === red2 {
        print("red1 is EQUAL to red2")
    }
    
}
