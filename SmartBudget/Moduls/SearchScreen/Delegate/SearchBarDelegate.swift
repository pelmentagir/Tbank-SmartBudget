import UIKit

final class SearchBarDelegate: NSObject, UISearchBarDelegate {

    // MARK: Properties
    weak var viewModel: BudgetPlanningViewModelProtocol?

    // MARK: Delegate Methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if viewModel?.category != nil {
            searchBar.setShowsCancelButton(true, animated: true)
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
