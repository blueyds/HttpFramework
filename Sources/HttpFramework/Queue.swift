import Foundation

actor Queue<T> {
    private var buffer: [T]
    
    init<S: Sequence>(_ elements: S) where S.Element == T {
        buffer = Array(elements)
    }
    
    nonisolated var count: Int {
        buffer.count
    }
    
    nonisolated var isEmpty: Bool{
        buffer.isEmpty
    }
    
    nonisolated var isFull: Bool {
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
    
    nonisolated func peek() -> T?{
        buffer.first
    }
}
