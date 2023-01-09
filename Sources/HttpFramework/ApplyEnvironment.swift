import Foundation
public class ApplyEnvironment: HTTPLoader {
    
    private let environment: ServerEnvironment
    
    public init(environment: ServerEnvironment) {
        self.environment = environment
        super.init()
    }
    override public func load(task: HTTPTask) {
        let copy = modifyRequest(request: task.request)
        task.request = copy
        super.load(task: task)
    }
    private func modifyRequest(request: HTTPRequest) -> HTTPRequest{
        var copy = request
        
        // use the environment specified by the request, if it's present
        // if it doesn't have one, use the one passed to the initializer
        let requestEnvironment = request.serverEnvironment ?? environment
        if copy.host == nil{
            copy.host = requestEnvironment.host
        }
        if copy.path.hasPrefix("/") == false {
            copy.path = requestEnvironment.pathPrefix + copy.path
        }
        // TODO: apply the query items from the requestEnvironment
        requestEnvironment.query.forEach(){ queryItem in
            copy.addQueryItem(item: queryItem)
        }
        for (header, value) in requestEnvironment.headers {
            copy.headers.updateValue(value, forKey: header)
        }
        return copy
    }

    override public func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        var copy = modifyRequest(request: request)
        //print("\(copy.url?.absoluteString)")
        super.load(request: copy, completion: completion)
    }
}

