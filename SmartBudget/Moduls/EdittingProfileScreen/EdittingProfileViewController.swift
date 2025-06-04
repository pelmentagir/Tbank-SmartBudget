import UIKit
import Combine

final class EdittingProfileViewController: UIViewController, FlowController {

    private var edittingProfileView: EdittingProfileView {
        self.view as! EdittingProfileView
    }

    // MARK: Properties
    private let viewModel: EdittingProfileViewModelProtocol
    private var keyboardObserver: KeyboardObserver?
    private var cancellables = Set<AnyCancellable>()
    private var tableViewDataSource: EdittingProfileTableViewDataSource?
    var completionHandler: ((User) -> Void)?
    var presentImagePicker: (() -> Void)?

    // MARK: UI Actions
    private lazy var addPhotoButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        presentImagePicker?()
    }

    private lazy var saveButtonTapped = UIAction { [weak self] _ in
        guard let self else { return }
        let name = getTextFieldText(for: 0)
        let lastName = getTextFieldText(for: 1)
        let salaryDay = getTextFieldText(for: 2)
        let salaryAmount = getTextFieldText(for: 3)
        viewModel.updateValidationStatus(name: name, lastName: lastName, salaryDay: salaryDay, salaryAmount: salaryAmount)
    }

    // MARK: Initialization
    init(viewModel: EdittingProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func loadView() {
        self.view = EdittingProfileView(buttonFactory: ButtonFactory(), textFieldFactory: TextFieldFactory())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        setupActions()
        setupKeyboardObserver()
    }

    // MARK: Public Methods
    func handleAvatarImage(image: UIImage) {
        edittingProfileView.setupAvatar(image: image)
    }

    // MARK: Private Methods
    private func setupTableView() {
        tableViewDataSource = EdittingProfileTableViewDataSource(viewModel: viewModel)
        edittingProfileView.tableView.dataSource = tableViewDataSource
    }

    private func setupBindings() {
        viewModel.isValidPublisher
            .removeDuplicates()
            .sink { [weak self] valid in
                if valid {
                    guard let self else { return }
                    let name = getTextFieldText(for: 0)
                    let lastName = getTextFieldText(for: 1)
                    let salaryDay = Int(getTextFieldText(for: 2)) ?? 1
                    let salaryAmount = Int(getTextFieldText(for: 3)) ?? 0
                    self.viewModel.updateUser(name: name, lastName: lastName, salaryDay: salaryDay, salaryAmount: salaryAmount)
                    self.completionHandler?(self.viewModel.user)
                }
            }.store(in: &cancellables)

        viewModel.shouldShowCluePublisher
            .removeDuplicates()
            .sink { [weak self] show in
                self?.edittingProfileView.showClue(!show)
            }.store(in: &cancellables)
    }

    private func setupActions() {
        edittingProfileView.choosePhotoButton.addAction(addPhotoButtonTapped, for: .touchUpInside)
        edittingProfileView.saveButton.addAction(saveButtonTapped, for: .touchUpInside)
    }

    private func setupKeyboardObserver() {
        keyboardObserver = KeyboardObserver(onShow: { [weak self] keyboardFrame in
            guard let self else { return }
            self.edittingProfileView.updateLayout(keyboardRect: keyboardFrame)
        }, onHide: { [weak self] in
            guard let self else { return }
            self.edittingProfileView.updateLayout()
        })
    }

    private func getTextFieldText(for row: Int) -> String {
        guard let cell = edittingProfileView.tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? ProfileEditCell else {
            return ""
        }
        return cell.textField.text ?? ""
    }
}
