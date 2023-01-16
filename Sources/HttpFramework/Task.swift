import Foundation

public class HTTPTask {
    public var id: UUID { request.id }
    public var request: HTTPRequest
    //private let completion: (HTTPResult) -> Void
    private var cancellationHandlers = Array<() -> Void>()
    private var completionHandlers = Array<(HTTPResult) async -> Void>()
    
    public init(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        self.request = request
        self.addCompletionHandler(completion)
    }
    
    public func cancel() {
        let handlers = cancellationHandlers
        cancellationHandlers = []
        // invoke in LIFO
        handlers.reversed().forEach { $0() }
    }
    
    public func addCancellationHandler(_ handler: @escaping () -> Void) {
        cancellationHandlers.append(handler)
    }
    
    public func complete(with result: HTTPResult) {
        let handlers = completionHandlers
        completionHandlers = []
        // invoke LIFO
		  Task{
				handlers.reversed().forEach { await $0(result) }  
		  }
        
    }
    
    public func addCompletionHandler(_ handler: @escaping (HTTPResult) async -> Void) {
        self.completionHandlers.append(handler)
    }
    public func fail(_ code: HTTPError.Code){
        let error = HTTPError(code: code, request: self.request)
        
        cancel()
        print("ERROR \(code) \(request)")
    }
}