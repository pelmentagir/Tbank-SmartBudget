import UIKit

private extension CGFloat {
    static let rowHeight: CGFloat = 60
}

private extension String {
    static let subtitleText = "Траты"
}

final class OperationView: UIView {

    // MARK: UI Elements
    private(set) lazy var filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = CGFloat.smallPadding
        layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat.largePadding, bottom: 0, right: CGFloat.largePadding)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .extraHighFontSize, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .italicFontSize, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = .subtitleText
        return label
    }()

    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.trackTintColor = .systemGray5
        progress.progressTintColor = .systemBlue
        progress.layer.cornerRadius = CGFloat.extraSmallPadding
        progress.clipsToBounds = true
        return progress
    }()

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.rowHeight = .rowHeight
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .systemBackground
        tableView.register(OperationTableViewCell.self, forCellReuseIdentifier: OperationTableViewCell.reuseIdentifier)
        return tableView
    }()

    private(set) lazy var timeRangeButton: UIButton = MonthPickerButton()

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(totalAmount: Double) {
        amountLabel.text = "\(totalAmount.formattedWithoutDecimalIfWhole()) ₽"
    }

    func updateProgress(_ progress: Float) {
        print(progress)
        progressView.progress = progress
    }

    // MARK: Private Methods
    private func addSubviews() {
        addSubview(timeRangeButton)
        addSubview(filterCollectionView)
        addSubview(amountLabel)
        addSubview(subtitleLabel)
        addSubview(progressView)
        addSubview(tableView)
    }

    private func setupLayout() {

        timeRangeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().inset(CGFloat.largePadding)
            make.height.equalTo(CGFloat.bigPadding)
        }

        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(timeRangeButton.snp.bottom).offset(CGFloat.bigPadding)
            make.leading.equalToSuperview().offset(CGFloat.bigPadding)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(CGFloat.extraSmallPadding)
            make.leading.equalTo(amountLabel)
        }

        progressView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(CGFloat.extraMediumPadding)
            make.leading.equalTo(amountLabel)
            make.trailing.equalToSuperview().inset(CGFloat.extraMediumPadding)
            make.height.equalTo(CGFloat.smallPadding)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
