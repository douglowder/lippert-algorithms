import Testing
@testable import LippertAlgorithms

@Test func linkedList1() async throws {
  var list: LinkedList1<Int> = .empty
  #expect(list.isEmpty)
  list = list.push(1)
  list = list.push(2)
  list = list.push(3)
  #expect(!list.isEmpty)
  #expect(list.description == "321")
  list = list.reverse()
  #expect(list.description == "123")
  #expect(LinkedList1<Int>.empty.reverse().isEmpty)
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
  #expect(Array(stack) == [3, 2, 1])
  stack = try stack.pop()
  #expect(stack.description == "21")
  stack = try stack.pop()
  #expect(stack.description == "1")
  stack = try stack.pop()
  #expect(throws: StackError("Cannot pop from an empty stack"), performing: {
    try stack.pop()
  })

  var stack2: Stack<Int> = .empty
  stack2 = stack2.push(1)
  stack2 = stack2.push(2)
  var iterator = stack2.makeIterator()
  #expect(iterator.next() == 2)
  #expect(iterator.next() == 1)
  #expect(iterator.next() == nil)
}

@Test func queue() async throws {
  var queue: Queue<Int> = Queue.empty
  queue = queue.enqueue(1)
  queue = queue.enqueue(2)
  #expect(queue.description == "12")
  #expect(try queue.peek() == 1)
  queue = try queue.dequeue()
  #expect(try queue.peek() == 2)
  queue = queue.enqueue(3)
  #expect(try queue.peek() == 2)
  #expect(queue.description == "23")
  #expect(Array(queue) == [2, 3])
  queue = try queue.dequeue()
  queue = try queue.dequeue()
  #expect(throws: QueueError.self, performing: {
    try queue.dequeue()
  })
  #expect(throws: QueueError.self, performing: {
    try queue.peek()
  })
}
