import Foundation

public class LinkedList1<T>: CustomStringConvertible {
  public var description: String {
    get {
      var s = ""
      var list: LinkedList1<T> = self
      while !list.isEmpty() {
        let valueString = String(describing: list.value)
        s = s + valueString
        list = list.tail!
      }
      return s
    }
  }

  var value: T?
  var tail: LinkedList1<T>?

  internal init() {
    self.value = nil
    self.tail = nil
  }

  public required init(_ value: T?, _ tail: LinkedList1<T>) {
    self.value = value
    self.tail = tail
  }

  public static func empty() -> LinkedList1<T> {
    return LinkedList1<T>()
  }

  public func isEmpty() -> Bool {
    return value == nil && tail == nil
  }

  public func push(_ value: T) -> LinkedList1<T> {
    return LinkedList1<T>(value, self)
  }

  public func reverse() -> LinkedList1<T> {
    var result = LinkedList1.empty()
    var list: LinkedList1<T> = self
    while !list.isEmpty() {
      if let identifier = list.value {
          result = result.push(identifier)
      }
      list = list.tail!
    }
    return result
  }

}
