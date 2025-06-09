import UIKit

private extension String {
    static let stepText = "Шаг 2 из 2"
    static let titleText = "Распределите доход по категориям"
}

private extension CGFloat {
    static let microSpacing: CGFloat = 2

    static let categoryCollectionHeight: CGFloat = 300
    static let categoryItemWidth: CGFloat = 110
    static let categoryItemHeight: CGFloat = 150
}

final class CategoryDistributionView: UIView {

    // MARK: Properties
    private var buttonFactory: ButtonFactory

    // MARK: UI Elements
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    private(set) lazy var stepLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .defaultFontSize)
        label.text = .stepText
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .highFontSize)
        label.text = .titleText
        label.numberOfLines = 2
        return label
    }()

    private(set) lazy var tagsCollectionView: TagsCollecionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = .microSpacing
        layout.scrollDirection = .vertical

        let collectionView = TagsCollecionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    private(set) lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: .categoryItemWidth, height: .categoryItemHeight)
        layout.minimumInteritemSpacing = .extraSmallPadding
        layout.minimumLineSpacing = .extraSmallPadding

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    private lazy var continueButton: IButton = buttonFactory.createButton(type: .standard, title: .continueButtonText)

    // MARK: Initialization
    init(buttonFactory: ButtonFactory) {
        self.buttonFactory = buttonFactory
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        addSubviews()
        setupLayout()
        updateView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    private func updateView() {
        tagsCollectionView.updateView = {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(stepLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(tagsCollectionView)
        contentView.addSubview(categoryCollectionView)

        addSubview(continueButton)
    }

    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(continueButton.snp.top).offset(-CGFloat.largePadding)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }

        stepLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(CGFloat.largePadding)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stepLabel.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }

        tagsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.largePadding)
            make.leading.trailing.equalToSuperview().inset(CGFloat.mediumPadding)
            make.bottom.equalTo(categoryCollectionView.snp.top).offset(-CGFloat.largePadding)
        }

        categoryCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.smallPadding)
            make.bottom.equalToSuperview().offset(-CGFloat.largePadding)
            make.height.equalTo(CGFloat.categoryCollectionHeight)
        }

        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(CGFloat.authScaledBottomInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }
    }
}
