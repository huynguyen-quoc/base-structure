import Foundation
import UIKit

enum AppStoryBoard: String {

    case Main
    case Login
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type,
                                             function: String = #function, line: Int = #line, file: String = #file) -> T? {
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
        let scene = instance.instantiateViewController(withIdentifier: storyBoardID) as? T
        return scene
    }
    
}

extension UIViewController {

    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiate(fromAppStoryboard appStoryboard: AppStoryBoard) -> Self? {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
