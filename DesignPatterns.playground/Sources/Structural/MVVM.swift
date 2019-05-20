import Foundation
import UIKit

// Model
public struct Pet {
    public let name: String
    public let birthday: Date
    public var image: UIImage?
}

// View
public class PetView: UIView {
    @IBOutlet weak var labelName: UILabel?
    @IBOutlet weak var labelBirthday: UILabel?
    @IBOutlet weak var imageView: UIImageView?
}

// ViewModel
public class PetViewModel {
    private let pet: Pet
    public init(withPet pet: Pet) {
        self.pet = pet
    }
    
    public var name: String {
        return pet.name
    }
    
    public var birthday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: pet.birthday)
    }
    
    public var image: UIImage? {
        return pet.image
    }
}

public class PetViewController: UIViewController {
    
    public var viewModel: PetViewModel? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        let petView = PetView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        // Setup view
        petView.imageView?.image = viewModel?.image
        petView.labelBirthday?.text = viewModel?.birthday
        petView.labelName?.text = viewModel?.name
    }
}

public func mvvmExample() {
    let budy = Pet(name: "Budy", birthday: Date(), image: nil)
    let petViewModel = PetViewModel(withPet: budy)
    let petViewController = PetViewController(nibName: nil, bundle: nil)
    petViewController.viewModel = petViewModel
}
