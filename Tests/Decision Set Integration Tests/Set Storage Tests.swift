import Buffer
import Index
import Set
import Store
import Testing

@Suite
struct `Set Storage Tests` {

    @Test
    func supportedStoreMetrics() {
        var store = MetricStore()
        store.initialize(at: .zero, to: 42)
        let set = __Set(store: consume store)

        let first: __Set<MetricStore>.Index = .zero
        let count = set.count
        let isEmpty = set.isEmpty
        let capacity = set.capacity

        #expect(first == .zero)
        #expect(count == Index<Int>.Count(1))
        #expect(!isEmpty)
        #expect(capacity == Index<Int>.Count(4))
    }

    @Test
    func cloneUnsharesTheCopiedStore() {
        let set = __Set(store: CopyStore())
        let clone = set.clone()

        #expect(set.take().unshareCount == 0)
        #expect(clone.take().unshareCount == 1)
    }
}

private struct CopyStore: Store::Store.`Protocol` {

    var value = 7
    var unshareCount = 0
}

extension CopyStore {

    var capacity: Index<Int>.Count { Index<Int>.Count(1) }

    subscript(slot: Index<Int>) -> Int {
        get { value }
        set { value = newValue }
    }

    mutating func initialize(at slot: Index<Int>, to element: consuming Int) {
        value = element
    }

    mutating func move(at slot: Index<Int>) -> Int { value }

    mutating func swapAt(_ i: Index<Int>, _ j: Index<Int>) {}

    mutating func unshare() {
        unshareCount += 1
    }
}

private struct MetricStore: Store::Store.`Protocol`, Buffer.`Protocol` {
    var value = 0
    var count: Index<Int>.Count = .zero
}

extension MetricStore {
    var capacity: Index<Int>.Count { 4 }
    subscript(slot: Index<Int>) -> Int {
        get { value }
        set { value = newValue }
    }
    mutating func initialize(at slot: Index<Int>, to element: consuming Int) {
        value = element
        count = .one
    }
    mutating func move(at slot: Index<Int>) -> Int {
        count = .zero
        return value
    }
    mutating func swapAt(_ i: Index<Int>, _ j: Index<Int>) {}
    mutating func unshare() {}
}
