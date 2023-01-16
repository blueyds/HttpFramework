import Foundation

actor Stack<T> {
    private var buffer: [T]
    
    init<S: Sequence>(_ elements: S) where S.Element == T {
        buffer = Array(elements)
    }
    
    var count: Int {
        buffer.count
    }
    
    var isEmpty: Bool{
        buffer.isEmpty
    }
    
    func push(_ element: T) {
        buffer.append(element)
    }
    
    func pop() -> T? {
        if !isEmpty {
            return buffer.removeLast()
        }
        return nil
    }
    
    func peek() -> T?{
        buffer.last
    }
}
