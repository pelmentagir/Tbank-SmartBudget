import UIKit
import Combine

final class MainViewController: UIViewController, FlowController {

    private var mainView: MainView {
        self.view as! MainView
    }

    private var viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()
    var completionHandler: ((String) -> Void)?

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.$chartItems
            .sink { [weak self] items in
                self?.mainView.configure(with: items)
            }.store(in: &cancellables)
    }
}
