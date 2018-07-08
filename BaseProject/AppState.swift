import Foundation

enum ProcessingState : Int {
    case idle =  1
    case loading =  2
}

class AppState {
    public static var processingStatus:ProcessingState = .idle
    public static var pageSize:Int = 30
}
