import UIKit

class ProfitViewController: UIViewController {

    private var profitView: ProfitView {
        self.view as! ProfitView
    }

    private var viewModel: ProfitViewModel
    private var amountCollectionViewDataSource: AmountCollectionViewDataSource?
    private var amountCollectionViewDelegate: AmountCollectionViewDelegate?

    init(viewModel: ProfitViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = ProfitView(textFieldFactory: TextFieldFactory(), buttonFactory: ButtonFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }

    private func configureCollectionView() {
        amountCollectionViewDelegate = AmountCollectionViewDelegate()
        amountCollectionViewDataSource = AmountCollectionViewDataSource(viewModel: viewModel)

        profitView.amountCollectionView.dataSource = amountCollectionViewDataSource
        profitView.amountCollectionView.delegate = amountCollectionViewDelegate
    }
}
