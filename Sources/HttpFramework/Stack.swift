import Foundation

public actor Stack<T> {
    private var buffer: [T]
    
    public init<S: Sequence>(_ elements: S) where S.Element == T {
        buffer = Array(elements)
    }
    
    public var count: Int {
        buffer.count
    }
    
    public var isEmpty: Bool{
        buffer.isEmpty
    }
    
    public func push(_ element: T) {
        buffer.append(element)
    }
    
    public func pop() -> T? {
        if !isEmpty {
            return buffer.removeLast()
        }
        return nil
    }
    
    public func peek() -> T?{
        buffer.last
    }
}
