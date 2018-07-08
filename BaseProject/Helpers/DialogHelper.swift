//
// Created by Nguyen Quoc Huy on 7/7/18.
// Copyright (c) 2018 Nguyen Quoc Huy. All rights reserved.
//

import Foundation
import UIKit
import PMAlertController

public enum DialogStyle: Int {
    case success
    case info
    case error
}

public enum DialogActionStyle: Int {
    case cancel
    case `default`
}

protocol DialogAlertProtocol {
    func present(_ viewControllerToPresent: UIViewController, title: String?, message: String?, icon: UIImage?,
                 dismissAction: DialogAction)
    func present(_ viewControllerToPresent: UIViewController, title: String?, message: String?, style: DialogStyle,
                 dismissAction: DialogAction)
}

protocol DialogConfirmProtocol {
    func present(_ viewControllerToPresent: UIViewController, title: String?, message: String?, icon: UIImage?,
                 dismissAction: DialogAction, okAction: DialogAction)
}

public struct DialogAction {
    var title: String?
    var action: (() -> Void)?
}

public class DialogHelper: DialogAlertProtocol, DialogConfirmProtocol {
    func present(_ viewControllerToPresent: UIViewController, title: String?, message: String?, style: DialogStyle, dismissAction: DialogAction) {
        var icon: UIImage? = nil;
        switch style {
            case .error:
                icon = UIImage(named: "broken_heart")
                break
            default:
                break
        }
        let vc = self.initAlert(title: title, message: message, icon: icon, style: .alert)
        self.addCancelButton(forViewController: vc, action: dismissAction)
        viewControllerToPresent.present(vc, animated: true)
    }
    
    func present(_ viewControllerToPresent: UIViewController, title: String?, message: String?, icon: UIImage?,
                 dismissAction: DialogAction) {
        let vc = self.initAlert(title: title, message: message, icon: icon, style: .alert)
        self.addCancelButton(forViewController: vc, action: dismissAction)
       
        viewControllerToPresent.present(vc, animated: true)
    }

    func present(_ viewControllerToPresent: UIViewController, title: String?, message: String?, icon: UIImage?,
                      dismissAction: DialogAction, okAction: DialogAction) {
        
    }
    
    private func addCancelButton(forViewController vc: PMAlertController, action : DialogAction){
        let cancelHandler = PMAlertAction(title: action.title, style: .cancel, action: { () -> Void in
            action.action?()
        })
        cancelHandler.titleLabel?.font = Style.valueFor(component: .alert, element: .button, state: .normal, value: .font)  as! UIFont
        let actionColor = Style.valueFor(component: .alert, element: .button, state: .normal, value: .color) as! UIColor
        cancelHandler.setTitleColor(actionColor, for: .normal)
        let actionBackColor = Style.valueFor(component: .alert, element: .button, state: .normal, value: .backColor) as! UIColor
        cancelHandler.backgroundColor = actionBackColor
        vc.addAction(cancelHandler)
    }
    
    private func initAlert(title: String?, message: String?, icon: UIImage?, style: PMAlertControllerStyle) -> PMAlertController {
        let alertTitle = title == nil ? "" : title!
        let alertMessage = message == nil ? "" : message!
        let vc = PMAlertController(title: alertTitle, description: alertMessage, image: icon, style: style)
        let viewBackColor = Style.valueFor(component: .alert, element: .view, state: .normal, value: .backColor) as! UIColor
        vc.alertView.backgroundColor = viewBackColor
        vc.alertView.layer.cornerRadius = 10
        vc.alertView.layer.masksToBounds = true
        let viewImageBackColor = Style.valueFor(component: .alert, element: .image, state: .normal, value: .backColor) as! UIColor
        vc.alertImage.contentMode = .center
        vc.alertImage.backgroundColor = viewImageBackColor
        vc.alertTitle.textColor = Style.valueFor(component: .alert, element: .title, state: .normal, value: .color) as! UIColor
        vc.alertTitle.font = Style.valueFor(component: .alert, element: .title, state: .normal, value: .font) as! UIFont
        vc.alertDescription.textColor = Style.valueFor(component: .alert, element: .message, state: .normal, value: .color) as! UIColor
        vc.alertDescription.font = Style.valueFor(component: .alert, element: .message, state: .normal, value: .font) as! UIFont
        vc.alertMaskBackground.backgroundColor = Style.valueFor(component: .alert, element: .overlay, state: .normal, value: .backColor) as? UIColor
        if icon != nil {
            vc.headerViewHeightConstraint.constant = 60
        }
        vc.headerViewTopSpaceConstraint.constant = 15
        vc.alertContentStackViewLeadingConstraint.constant = 25
        vc.alertContentStackViewTrailingConstraint.constant = 25
        vc.alertContentStackViewTopConstraint.constant = 15
        vc.gravityDismissAnimation = false
        let constraints = vc.alertDescription.constraints
        for contraint in constraints {
            if contraint.firstAttribute == .height {
                contraint.constant = 74
                break
            }
        }
        return vc;
    }
}
