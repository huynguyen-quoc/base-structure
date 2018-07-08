//
//  Base.swift
//  BaseProject
//
//  Created by Huy Nguyen on 4/6/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

public class Base {
    public class func start() {
        let window = Tools.getWindow()
        
        let initializationVC:LoginViewController? = LoginViewController.instantiate(fromAppStoryboard: AppStoryBoard.Login)
        initializationVC?.alert = DialogHelper()
        window.rootViewController = initializationVC
        window.makeKeyAndVisible()
    }
}
