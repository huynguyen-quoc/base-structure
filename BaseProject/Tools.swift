//
//  Tools.swift
//  BaseProject
//
//  Created by Huy Nguyen on 4/6/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import UIKit

public class Tools {
    public class func getWindow() -> UIWindow {
        var window = UIApplication.shared.keyWindow
        if window == nil {
            window = UIApplication.shared.windows[0]
        }
        return window!
    }
    
    public class func deviceID() -> String? {
        #if arch(i386) || arch(x86_64)
            return "10A5322A-EB39-4137-B713-123456-123"
        #else
            return UIDevice.current.identifierForVendor?.uuidString
        #endif
    }
    
    public class func appVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
}
