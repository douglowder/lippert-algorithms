import Foundation

public struct StackError: Error, CustomStringConvertible, Equatable {
  public let description: String
  public init(_ description: String) { self.description = description }
}

public indirect enum Stack<T> {
  case empty
  case node(T, Stack<T>)

  public var isEmpty: Bool {
    if case .empty = self {
      return true
    }
    return false
  }

  public func push(_ value: T) -> Stack<T> {
    return .node(value, self)
  }

  public func pop() throws -> Stack<T> {
    switch self {
    case let .node(_, tail):
      return tail
    default:
      throw StackError("Cannot pop from an empty stack")
    }
  }

  public func peek() throws -> T {
    switch self {
    case let .node(value, _):
      return value
    default:
      throw StackError("Cannot peek into an empty stack")
    }
  }
}

extension Stack: CustomStringConvertible {
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
