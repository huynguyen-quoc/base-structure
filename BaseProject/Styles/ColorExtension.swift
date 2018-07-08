import UIKit

enum Color {
    case border
    case navigationBar
    case background
    case custom(hex:String, alpha:Double)
    
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}
extension Color {

    var value: UIColor {
        var color = UIColor.clear
        switch self {
        case .border:
            color = UIColor(hex: "#000000")
            break
        case .navigationBar:
            color = UIColor(hex: "#000000")
            break
        case .custom(let hexValue, let opacity):
            color = UIColor(hex: hexValue).withAlphaComponent(CGFloat(opacity))
            break
        case .background:
            color = UIColor(hex: "#000000")
            break
        }
        return color
    }
}
