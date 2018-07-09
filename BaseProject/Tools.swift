//
//  Tools.swift
//  BaseProject
//
//  Created by Huy Nguyen on 4/6/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import UIKit
import DeviceGuru

public class Tools {
    public class func getWindow() -> UIWindow {
        var window = UIApplication.shared.keyWindow
        if window == nil {
            window = UIApplication.shared.windows[0]
        }
        return window!
    }

    public class func getDeviceModelAndVersion() -> String {
        let systemVersion = UIDevice.current.systemVersion
        let deviceGuru = DeviceGuru()
        let deviceName = deviceGuru.hardware()
        let deviceCode = deviceGuru.hardwareString()
        return "\(deviceName) - \(deviceCode) - \(systemVersion)"
    }

    public class func getAppTargetAndVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String

        let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String

        return "\(appName) - Version: \(version) - Build: \(build)"
    }
}
