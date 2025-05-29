import UIKit

// MARK: - Default

extension CGFloat {
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static let baseWidth: CGFloat = 390
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let lowFontSize: CGFloat = 12
    static let normalFontSize: CGFloat = 14
    static let defaultFontSize: CGFloat = 16
    static let italicFontSize: CGFloat = 18
    static let regularFontSize: CGFloat = 20
    static let mediumFontSize: CGFloat = 24
    static let highFontSize: CGFloat = 28
    static let cornerRadius: CGFloat = 16
    static let alphaBackgorundViewCategory: CGFloat = 0.12

    static let extraSmallPadding: CGFloat = 4
    static let smallPadding: CGFloat = 8
    static let mediumPadding: CGFloat = 12
    static let largePadding: CGFloat = 16
    static let extraLargePadding: CGFloat = 40
}

// MARK: - Auth

extension CGFloat {
    static let authBaseHeight: CGFloat = 50
    static let authBaseLogoSize: CGFloat = 110
    static let authBaseBottomInset: CGFloat = 30
    static let authBaseHorizontalInset: CGFloat = 30
    static let authBaseStackBottomOffset: CGFloat = 100

    static var authScaledHeight: CGFloat { authBaseHeight * (screenWidth / baseWidth) }

    static var authScaledLogoSize: CGFloat { authBaseLogoSize * (screenWidth / baseWidth) }

    static var authScaledBottomInset: CGFloat { authBaseBottomInset * (screenWidth / baseWidth) }

    static var authScaledHorizontalInset: CGFloat { authBaseHorizontalInset * (screenWidth / baseWidth) }

    static var authScaledStackBottomOffset: CGFloat { authBaseStackBottomOffset * (screenWidth / baseWidth) }
}

// MARK: - Profile

extension CGFloat {
    static let profileAvatarSize: CGFloat = 160
    static let profileAvatarTopOffset: CGFloat = 50
    static let profileAddButtonOffset: CGFloat = 120
    static let profileCornerRadius: CGFloat = 80
    static let profileAddButtonImageSize: CGFloat = 30
    static let profileKeyboardVisibleTopOffset: CGFloat = 20
    static let profileKeyboardHiddenTopOffset: CGFloat = 50
    static let profileStackViewCenterOffset: CGFloat = 100
    static let profileClueBottomOffset: CGFloat = 50

    static var profileScaledAvatarSize: CGFloat { profileAvatarSize * (screenWidth / baseWidth) }
    static var profileScaledAvatarTopOffset: CGFloat { profileAvatarTopOffset * (screenWidth / baseWidth) }
    static var profileScaledAddButtonOffset: CGFloat { profileAddButtonOffset * (screenWidth / baseWidth) }
    static var profileScaledCornerRadius: CGFloat { profileCornerRadius * (screenWidth / baseWidth) }
}
