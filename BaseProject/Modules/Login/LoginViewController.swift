//
//  LoginViewController.swift
//  BaseProject
//
//  Created by Nguyen Quoc Huy on 7/7/18.
//  Copyright © 2018 Nguyen Quoc Huy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var alert: DialogAlertProtocol?;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var action = DialogAction();
        action.title = "Got it";
        action.action = {
            print("Tet")
        }
        alert?.present(self, title: "Oops!",
                       message: "Your password must contains letters and numbers.",
                       style: .error, dismissAction: action)
    }


}
