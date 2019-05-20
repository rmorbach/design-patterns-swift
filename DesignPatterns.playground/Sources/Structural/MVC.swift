import Foundation
import UIKit

// Model
public struct Address: Codable {
    public let street: String
    public let number: Int
    public let state: String
    public let zipCode: String
    
    public init(street: String, number: Int, state: String, zipCode: String) {
        self.street = street
        self.number = number
        self.state = state
        self.zipCode = zipCode
    }
}

// View
public class AddressView: UIView {
    
    @IBOutlet weak var streetLabel: UILabel?
    @IBOutlet weak var numberLabel: UILabel?
    @IBOutlet weak var stateLabel: UILabel?
    @IBOutlet weak var zipCodeLabel: UILabel?
}

// Controller
public class AddressDetailsViewController: UIViewController {
    
    public var address: Address? {
        didSet {
            configureView()
        }
    }
    public var addressView: AddressView?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 600))
        self.view = view
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureView() {
        self.addressView = AddressView(frame: CGRect(x: 0, y: 0, width: 300, height: 600))
        self.addressView?.streetLabel?.text = address?.street
        self.addressView?.stateLabel?.text = address?.state
        self.addressView?.numberLabel?.text = "\(String(describing: address?.number))"
        self.addressView?.zipCodeLabel?.text = address?.zipCode
        if let addressView = self.addressView {
            view.addSubview(addressView)
        }
    }
}

public func mvcExample() -> AddressDetailsViewController {
    
    let address = Address(street: "Street 1", number: 10, state: "Washington", zipCode: "111000")
    let addressVc = AddressDetailsViewController(nibName: nil, bundle: nil)
    addressVc.address = address
    
    return addressVc
    
}
