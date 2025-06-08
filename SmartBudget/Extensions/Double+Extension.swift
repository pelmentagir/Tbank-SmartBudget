import Foundation

extension Double {
    func formattedWithoutDecimalIfWhole() -> String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self)
        }
        return String(format: "%.2f", self)
    }
}
