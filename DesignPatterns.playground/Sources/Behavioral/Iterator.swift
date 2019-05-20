import Foundation

public struct Queue<T> {
    
    private var queue = [T]()
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public var head: T? {
        return queue.first
    }
    
    public mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    @discardableResult public mutating func dequeue() -> T? {
        return queue.removeLast()
    }
    
}
// Extends queue in order to conform with Sequence protocol

extension Queue: Sequence {
    public func makeIterator() -> ArraySlice<T>.Iterator {
        let nonEmptyValues = queue[0..<queue.count]
        return nonEmptyValues.makeIterator()
    }
}

public func iteratorExample() {
    var queue = Queue<Int>()
    queue.enqueue(1)
    queue.enqueue(2)
    queue.dequeue()
    queue.enqueue(3)
    
    for i in queue {
        print("Enqueued item \(i)")
    }
}
