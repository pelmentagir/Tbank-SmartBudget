import UIKit
import DGCharts

private extension CGFloat {
    static let chartSize: CGFloat = 300
    static let sectionSpacing: CGFloat = 16
    static let cellHeight: CGFloat = 130
}

final class MainView: UIView {

    // MARK: - UI Elements
    private(set) lazy var pieChartView: PieChartView = {
        let chartView = PieChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.usePercentValuesEnabled = true
        chartView.drawHoleEnabled = true
        chartView.holeRadiusPercent = 0.6
        chartView.transparentCircleRadiusPercent = 0.65
        chartView.chartDescription.enabled = false
        chartView.drawEntryLabelsEnabled = false
        chartView.centerTextRadiusPercent = 0.95
        chartView.legend.enabled = false
        return chartView
    }()

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 130
        tableView.register(CategoryBudgetTableViewCell.self, forCellReuseIdentifier: CategoryBudgetTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods
    func configure(with items: [CategorySpendingDTO]) {
        let total = items.map(\.percent).reduce(0, +)
        let amountText = String(format: "%.0f ₽", total)
        pieChartView.centerAttributedText = createCenterText(amount: amountText)

        let entries = items.map { PieChartDataEntry(value: Double($0.percent), label: $0.categoryName) }
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.sliceSpace = 2
        dataSet.selectionShift = 10
        dataSet.colors = generateColors(count: items.count)

        let data = PieChartData(dataSet: dataSet)
        data.setDrawValues(false)

        pieChartView.data = data
        pieChartView.highlightValues(nil)
    }

    // MARK: - Private Methods

    private func addSubviews() {
        addSubview(pieChartView)
        addSubview(tableView)
    }

    private func setupLayout() {
        pieChartView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGFloat.chartSize)
        }
        
        tableView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.top.equalTo(pieChartView.snp.bottom).offset(40)
            make.height.equalTo(300)
        }
    }

    private func createCenterText(amount: String) -> NSAttributedString {
        let fullText = "\(amount)\nРасходы"
        let attributedText = NSMutableAttributedString(string: fullText)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let nsText = fullText as NSString
        let numberRange = nsText.range(of: amount)
        let labelRange = nsText.range(of: "Расходы")

        attributedText.addAttributes([
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: UIColor.label,
            .paragraphStyle: paragraphStyle
        ], range: numberRange)

        attributedText.addAttributes([
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.secondaryLabel,
            .paragraphStyle: paragraphStyle
        ], range: labelRange)

        return attributedText
    }

    private func generateColors(count: Int) -> [UIColor] {
        let baseColors: [UIColor] = [
            .systemRed, .systemBlue, .systemGreen,
            .systemOrange, .systemPurple, .systemYellow,
            .systemPink, .systemTeal, .systemIndigo,
            .systemBrown, .systemCyan, .systemMint
        ]

        return (0..<count).map {
            let color = baseColors[$0 % baseColors.count]
            return color.withAlphaComponent(0.4)
        }
    }
}
