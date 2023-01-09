import Foundation

public protocol HTTPBody { 
    var isEmpty: Bool { get }
    var additionalHeaders: [String: String] { get } 
    func encode() throws -> Data 
}

extension HTTPBody {
    public var isEmpty: Bool { return false }
    public var additionalHeaders: [String: String] { return [:] }
}

public struct EmptyBody: HTTPBody {
    public let isEmpty = true
    
    public init() { }
    public func encode() throws -> Data { Data() }
}

