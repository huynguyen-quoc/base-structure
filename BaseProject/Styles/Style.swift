import Foundation

protocol StyleProtocol {
    func style(_ state: StyleType.state)
}

struct StyleType: Hashable {
    
    var hashValue: Int {
        return self.component.hashValue ^ self.state.hashValue ^ self.element.hashValue ^ self.value.hashValue
    }
    
    static func ==(lhs: StyleType, rhs: StyleType) -> Bool {
        return lhs.component == rhs.component && lhs.state == rhs.state && lhs.element == rhs.element && lhs.value == rhs.value
    }
    
    
    enum state : String {
        case enabled = "enabled"
        case disabled = "disabled"
        case normal = "normal"
        case focus = "focus"
        case error = "error"
    }
    
    enum component: String {
        case application = "application"
        case alert = "alert"
    }
    
    enum element: String {
        case title = "title"
        case view = "view"
        case overlay = "overlay"
        case message = "message"
        case image =  "image"
        case button = "button"
    }
    
    enum value: String {
        case backColor = "backColor"
        case color = "color"
        case font = "font"
    }
    
    let component:component
    let element:element
    let state:state
    let value:value
    
    
}
class Style {
    
    static var styleValues: [StyleType:Any] = [:]
    
    class func initStyle(style: [String:String]) {
        self.mapStyle(style: style)
    }
    
    private class func mapStyle(style: [String:String]) {
        for(key, val) in style {
            let components = key.components(separatedBy: ".")
            if components.count == 4 {
                let component = StyleType.component(rawValue: components[0])
                let element = StyleType.element(rawValue: components[1])
                let state = StyleType.state(rawValue: components[2])
                let value = StyleType.value(rawValue: components[3])
             
                let styleType = StyleType(component: component!, element: element!, state: state!, value: value!)
                guard let styleValue = StyleConstant.applicationStyleValue[val] else {
                      Style.styleValues[styleType] = val
                      continue
                }
                Style.styleValues[styleType] = styleValue!
              
            }
        }
    }
    
    class func valueFor(component: StyleType.component, element: StyleType.element, state:StyleType.state, value:StyleType.value) -> Any? {
        if let value = Style.styleValues[StyleType(component: component, element: element, state:state, value:value)] {
            return value;
        }
        
        return nil
    }
    
}
