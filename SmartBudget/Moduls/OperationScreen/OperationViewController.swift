import UIKit

final class OperationViewController: UIViewController, FlowController {
    private var operationView: OperationView {
        self.view as! OperationView
    }

    private var viewModel: OperationViewModel
    var completionHandler: ((String) -> Void)?

    init(viewModel: OperationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = OperationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
