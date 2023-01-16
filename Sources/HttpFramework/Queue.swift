import Foundation

actor Queue<T> {
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
    
    var isFull: Bool {
        !isEmpty
    }
    
    func enqueue(_ element: T) {
        buffer.append(element)
    }
    
    func dequeue() -> T? {
        if !isEmpty {
            return buffer.removeFirst()
        }
        return nil
    }
    
    func peek() -> T?{
        buffer.first
    }
}
