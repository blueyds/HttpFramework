import Foundation

public class ModifyRequest: HTTPLoader {
    
    private let modifier: (HTTPRequest) -> HTTPRequest
    
    public init(modifier: @escaping (HTTPRequest) -> HTTPRequest) {
        self.modifier = modifier
        super.init()
    }
    
    override public func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        let modifiedRequest = modifier(request)
        super.load(request: modifiedRequest, completion: completion)
    }
}

