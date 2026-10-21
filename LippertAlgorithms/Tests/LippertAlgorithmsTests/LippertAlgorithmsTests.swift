import Testing
@testable import LippertAlgorithms

@Test func linkedList1() async throws {
    // Swift Testing Documentation
    // https://developer.apple.com/documentation/testing
  var list: LinkedList1<Int> = LinkedList1.empty()
  list = list.push(1)
  list = list.push(2)
  list = list.push(3)
  #expect(list.description == "Optional(3)Optional(2)Optional(1)")
  list = list.reverse()
  #expect(list.description == "Optional(1)Optional(2)Optional(3)")

}

@Test func linkedList1Enum() async throws {
  var list: LinkedList1Enum<Int> = .empty
  #expect(list.isEmpty)
  list = list.push(1)
  list = list.push(2)
  list = list.push(3)
  #expect(!list.isEmpty)
  #expect(list.description == "321")
  list = list.reverse()
  #expect(list.description == "123")
  #expect(LinkedList1Enum<Int>.empty.reverse().isEmpty)
}

@Test func stack() async throws {
  var stack: Stack<Int> = .empty
  #expect(throws: StackError("Cannot peek into an empty stack"), performing: {
    try stack.peek()
  })
  #expect(throws: StackError("Cannot pop from an empty stack"), performing: {
    try stack.pop()
  })
  stack = stack.push(1)
  stack = stack.push(2)
  stack = stack.push(3)
  #expect(!stack.isEmpty)
  #expect(stack.description == "321")
  stack = try stack.pop()
  #expect(stack.description == "21")
  stack = try stack.pop()
  #expect(stack.description == "1")
  stack = try stack.pop()
  #expect(throws: StackError("Cannot pop from an empty stack"), performing: {
    try stack.pop()
  })





}
