import Foundation

protocol AmountCollectionViewProtocol: NSObject {
    func applyQuickAmountUpdate(index: Int)
    func setNewAmount(_ amount: String)
}
