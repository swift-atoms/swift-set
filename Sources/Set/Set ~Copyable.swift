public import Buffer
public import Index
public import Set_Primitive
public import Store

extension __Set where S: ~Copyable, S: Store.`Protocol` & Buffer.`Protocol` {

    @inlinable
    public var count: Index.Index<S.Element>.Count { store.count }

    @inlinable
    public var isEmpty: Bool { store.isEmpty }

    @inlinable
    public var capacity: Index.Index<S.Element>.Count { store.capacity }
}

extension __Set where S: Copyable, S: Store.`Protocol` {

    @inlinable
    public borrowing func clone() -> Self {
        var result = copy self
        result.store.unshare()
        return result
    }
}
