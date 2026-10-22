import Foundation

public struct QueueError: Error, CustomStringConvertible, Equatable {
  public let description: String
  public init(_ description: String) { self.description = description }
}

public class Queue<T> {

  private let enqueues: Stack<T>
  private let dequeues: Stack<T>

  private init(_ enqueues: Stack<T>, _ dequeues: Stack<T>) {
    self.enqueues = enqueues
    self.dequeues = dequeues
  }

  public static func empty() -> Queue<T> {
    return Queue(.empty, .empty)
  }
  
  public var isEmpty: Bool {
    get {
      return self.dequeues.isEmpty && self.enqueues.isEmpty
    }
  }

  public func enqueue(_ item: T) -> Queue<T> {
    return self.isEmpty ?
      Queue(self.enqueues, self.dequeues.push(item)) :
      Queue(self.enqueues.push(item), self.dequeues)
  }

  public func peek() throws -> T {
    if self.isEmpty {
      throw QueueError("Cannot peek into an empty queue")
    }
    return try self.dequeues.peek()
  }

  public func dequeue() throws -> Queue<T> {
    if self.isEmpty {
      throw QueueError("Cannot dequeue from an empty queue")
    }

    var dequeues: Stack<T> = try self.dequeues.pop()
    if !dequeues.isEmpty {
      return Queue(self.enqueues, dequeues)
    }
    if self.enqueues.isEmpty {
      return Queue.empty()
    }
    for item in self.enqueues {
      dequeues = dequeues.push(item)
    }
    return Queue(.empty, dequeues)
  }
}

extension Queue: Sequence {
  public func makeIterator() -> some IteratorProtocol<T> {
    return QueueIterator(self)
  }
}

internal class QueueIterator<T>: Sequence, IteratorProtocol {
  func next() -> T? {
    if self.queue.isEmpty {
      return nil
    }
    do {
      let value = try self.queue.peek()
      self.queue = try self.queue.dequeue()
      return value
    } catch {
      return nil
    }
  }
  
  typealias Element = T

  private var queue: Queue<T>

  required init(_ queue: Queue<T>) {
    self.queue = queue
  }
}

extension Queue: CustomStringConvertible {
  public var description: String {
    return self.map{ String(describing: $0) }.joined()
  }
}
