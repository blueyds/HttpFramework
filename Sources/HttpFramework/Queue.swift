import Foundation

public actor Queue<T> {
    private var buffer: [T]
    
    public init<S: Sequence>(_ elements: S) where S.Element == T {
        buffer = Array(elements)
    }
	 
	 public init(){
		 buffer = [T]()
	 }
    
    public var count: Int {
        buffer.count
    }
    
    public var isEmpty: Bool{
        buffer.isEmpty
    }
    
    public var isFull: Bool {
        !isEmpty
    }
    
    public func enqueue(_ element: T) {
        buffer.append(element)
    }
    
    public func dequeue() -> T? {
        if !isEmpty {
            return buffer.removeFirst()
        }
        return nil
    }
    
    public func peek() -> T?{
        buffer.first
    }
}
