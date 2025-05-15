import UIKit

class RegistrationController: UIViewController, FlowController {
    
    private var registrationView: RegistrationView {
        self.view as! RegistrationView
    }
    
    private let viewModel: RegistrationViewModel
    
    var completionHandler: ((User?) -> Void)?
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = RegistrationView(textFieldFactory: TextFieldFactory(), buttonFactory: ButtonFactory())
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
