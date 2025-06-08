import UIKit

final class OperationTableViewDelegate: NSObject, UITableViewDelegate {
    weak var viewModel: OperationViewModel?

    init(viewModel: OperationViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dayInfo = viewModel?.getDayInfo(for: section) else { return nil }

        let headerView = OperationHeaderTableView()
        headerView.configure(day: dayInfo)

        return headerView
    }
}
