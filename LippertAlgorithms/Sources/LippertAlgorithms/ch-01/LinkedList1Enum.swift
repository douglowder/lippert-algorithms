public indirect enum LinkedList1Enum<T> {
  case empty
  case node(T, LinkedList1Enum<T>)

  public var isEmpty: Bool {
    if case .empty = self {
      return true
    }
    return false
  }

  public func push(_ value: T) -> LinkedList1Enum<T> {
    return .node(value, self)
  }

  public func reverse() -> LinkedList1Enum<T> {
    var result = LinkedList1Enum<T>.empty
    var list = self
    while case let .node(value, tail) = list {
      result = result.push(value)
      list = tail
    }
    return result
  }
}

extension LinkedList1Enum: CustomStringConvertible {
  public var description: String {
    var s = ""
    var list = self
    while case let .node(value, tail) = list {
      s += String(describing: value)
      list = tail
    }
    return s
  }
}
