
import UIKit

struct StyleConstant {
    
    static let applicationStyleValue:[String:Any?] = [
        "baseColor" : "3B49EE",
        "sizeFontAlertBig" : 24.0,
        "sizeFontAlert" : 18.0,
        "backColorAlertView" : UIColor(hex: "#E9E9E9"),
        "backColorAlertImage" : UIColor(hex: "#E9E9E9"),
        "backColorAlertAction" : UIColor.white,
        "backMaskColorAlert" : UIColor(hex: "#000000").withAlphaComponent(0.35),
        "textColorAlertTitle" : UIColor(hex: "#333333"),
        "textColorAlertMessage" : UIColor(hex: "#333333"),
        "textColorAlertAction" :  UIColor(hex: "#333333"),
        "fontAlertTitle" : UIFont(name: "SourceSansPro-Semibold", size: 24.0),
        "fontAlertMessage" : UIFont(name: "SourceSansPro-Regular", size: 18.0),
        "fontAlertAction" : UIFont(name: "SourceSansPro-Regular", size: 18.0)
    ]
    
    
    static let applicationStyleType: [String:String] = [
        "alert.overlay.normal.backColor" : "backMaskColorAlert",
        "alert.title.normal.color" : "textColorAlertTitle",
        "alert.message.normal.color" : "textColorAlertMessage",
        "alert.button.normal.font" : "fontAlertAction",
        "alert.message.normal.font" : "fontAlertMessage",
        "alert.title.normal.font" : "fontAlertTitle",
        "alert.button.normal.color" : "textColorAlertAction",
        "alert.button.normal.backColor" : "backColorAlertAction",
        "alert.view.normal.backColor" : "backColorAlertView",
        "alert.image.normal.backColor" : "backColorAlertImage"
    ]
}
