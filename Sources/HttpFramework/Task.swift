import Foundation

public class HTTPTask {
    public var id: UUID { request.id }
    public var request: HTTPRequest
    private let completion: (HTTPResult) -> Void
    
    public init(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        self.request = request
        self.completion = completion
    }
    
    public func cancel() {
        // TODO
    }
    
    public func complete(with result: HTTPResult) {
        completion(result)
    }
    
    public func fail(_ code: HTTPError.Code){
        let error = HTTPError(code: code, request: self.request)
        completion(.failure(error))
    }
}
