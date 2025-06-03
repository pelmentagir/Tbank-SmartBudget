import UIKit
import DGCharts

private extension CGFloat {
    static let chartSize: CGFloat = 300
    static let rowHeight: CGFloat = 140
    static let selectionShift: CGFloat = 10
    static let sliceSpace: CGFloat = 2
    static let centerTextRadiusPercent: CGFloat = 0.95
    static let transparentCircleRadiusPercent: CGFloat = 0.65
    static let holeRadiusPercent: CGFloat = 0.6
    static let xxlFont: CGFloat = 32
    static let titleStackViewSpacing: CGFloat = 6
}

private extension String {
    static let expensesText = "Расходы"
}

final class MainView: UIView {

    // MARK: UI Elements
    private(set) lazy var scrollView = UIScrollView()
    private let contentView = UIView()

    private lazy var bankIconView: UIImageView = {
        let icon = UIImageView(image: .icBank)
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        return icon
    }()

    private lazy var spentIncomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .xxlFont, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private(set) lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bankIconView, spentIncomeLabel])
        stackView.spacing = .titleStackViewSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()

    private(set) lazy var pieChartView: PieChartView = {
        let chartView = PieChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.usePercentValuesEnabled = true
        chartView.drawHoleEnabled = true
        chartView.transparentCircleRadiusPercent = .transparentCircleRadiusPercent
        chartView.chartDescription.enabled = false
        chartView.drawEntryLabelsEnabled = false
        chartView.centerTextRadiusPercent = .centerTextRadiusPercent
        chartView.legend.enabled = false
        chartView.rotationEnabled = false
        return chartView
    }()

    private(set) lazy var tableView: UITableView = {
        let tableView = IntrinsicTableView()
        tableView.rowHeight = .rowHeight
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CategoryBudgetTableViewCell.self, forCellReuseIdentifier: CategoryBudgetTableViewCell.reuseIdentifier)
        return tableView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView, pieChartView, tableView])
        stackView.axis = .vertical
        stackView.spacing = .extraLargePadding
        stackView.alignment = .center
        return stackView
    }()

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func setSpentIncome(spent: Int) {
        spentIncomeLabel.text = "\(spent) ₽"
    }

    func setLeftIncome(left: Int) {
        pieChartView.centerAttributedText = createCenterText(amount: "\(left) ₽")
    }

    func configurePie(with items: [CategorySpending]) {
        let entries = items.map { PieChartDataEntry(value: Double($0.percent), label: $0.categoryName) }
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.sliceSpace = .sliceSpace
        dataSet.selectionShift = .selectionShift
        dataSet.colors = UIColor.getColorForPieChart(categories: items)

        let data = PieChartData(dataSet: dataSet)
        data.setDrawValues(false)

        pieChartView.data = data
        pieChartView.highlightValues(nil)
    }

    // MARK: Private Methods
    private func setupSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
    }

    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }

        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        pieChartView.snp.makeConstraints { make in
            make.size.equalTo(CGFloat.chartSize)
        }

        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.largePadding)
        }
    }

    private func createCenterText(amount: String) -> NSAttributedString {
        let fullText = "\(amount)\n\(String.expensesText)"
        let attributedText = NSMutableAttributedString(string: fullText)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let nsText = fullText as NSString
        let numberRange = nsText.range(of: amount)
        let labelRange = nsText.range(of: .expensesText)

        attributedText.addAttributes([
            .font: UIFont.systemFont(ofSize: .italicFontSize, weight: .bold),
            .foregroundColor: UIColor.label,
            .paragraphStyle: paragraphStyle
        ], range: numberRange)

        attributedText.addAttributes([
            .font: UIFont.systemFont(ofSize: .defaultFontSize, weight: .regular),
            .foregroundColor: UIColor.secondaryLabel,
            .paragraphStyle: paragraphStyle
        ], range: labelRange)

        return attributedText
    }
}
