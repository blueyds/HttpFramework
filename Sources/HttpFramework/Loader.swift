import Foundation

open class HTTPLoader {
    
    public var nextLoader: HTTPLoader? {
        willSet {
            guard nextLoader == nil else { fatalError("The nextLoader may only be set once") }
        }
    } 
    
    public init() { }
    
    open func load(task: HTTPTask) {
        print("\(nextLoader)")
        if let next = nextLoader {
            next.load(task: task)
        } else {
            // a convenience method to construct an HTTPError 
            // and then call .complete with the error in an HTTPResult
            task.fail(.cannotConnect)
        }
    } 
    open func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        let task = HTTPTask(request: request, completion: completion)
        load(task: task)
    }
}

precedencegroup LoaderChainingPrecedence {
    higherThan: NilCoalescingPrecedence
    associativity: right
}

infix operator --> : LoaderChainingPrecedence

@discardableResult
public func --> (lhs: HTTPLoader, rhs: HTTPLoader) -> HTTPLoader {
    lhs.nextLoader = rhs
    return lhs
}
