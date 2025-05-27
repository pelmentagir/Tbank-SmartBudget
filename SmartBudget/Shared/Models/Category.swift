import UIKit

struct Category: Hashable {
    let icon: UIImage
    let name: String
    let discription: String
    let backgroundColor: UIColor
    var percentage: Int = 0
    var amount: Int = 0
}
