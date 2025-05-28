import UIKit

final class TagsCollecionView: UICollectionView {

    // MARK: Properties
    var updateView: (() -> Void)?

    override var contentSize: CGSize {
        didSet {
            if oldValue != contentSize {
                self.invalidateIntrinsicContentSize()
                updateView?()
            }
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
}
