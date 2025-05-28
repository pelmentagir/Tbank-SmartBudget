import UIKit

final class SearchTableViewDelegate: NSObject, UITableViewDelegate {

    // MARK: Properties
    weak var viewModel: SearchViewModelProtocol?

    // MARK: Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.findCategoryAtIndex(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
