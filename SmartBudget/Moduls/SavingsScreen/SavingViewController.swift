import UIKit

final class SavingViewController: UIViewController, FlowController {
    private var savingView: SavingView {
        self.view as! SavingView
    }
    
    private var viewModel: SavingViewModel
    var completionHandler: ((String) -> Void)?
    
    init(viewModel: SavingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = SavingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
