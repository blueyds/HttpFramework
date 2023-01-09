import Foundation

public struct BasicCredentials: Hashable, Codable {
    public let username: String
    public let password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}


extension BasicCredentials: HTTPRequestOption {
    public static let defaultOptionValue: BasicCredentials? = nil
}

extension HTTPRequest {
    public var basicCredentials: BasicCredentials? {
        get { self[option: BasicCredentials.self] }
        set { self[option: BasicCredentials.self] = newValue }
    }
}
