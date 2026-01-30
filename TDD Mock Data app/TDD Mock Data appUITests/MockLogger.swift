import Foundation

public final class MockLogger: LoggerProtocol {
    public private(set) var messages: [String] = []
    
    public init() {}
    
    public func log(_ message: String) {
        messages.append(message)
    }
}
